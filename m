Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54615AC232
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Sep 2022 06:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiIDECM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Sep 2022 00:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiIDECM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Sep 2022 00:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D833336C;
        Sat,  3 Sep 2022 21:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A19560E92;
        Sun,  4 Sep 2022 04:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A46C433C1;
        Sun,  4 Sep 2022 04:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662264129;
        bh=TIoOTSREpvkvhl9eSkOM8oVjPAEJAUA02SCQCR6SdbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YiT58vTpgqD6qCXUZgUsF4ckAtznccfJnq1mmLjCK8UVp7YTLcnAjqERh7613K/UH
         fv0rTRe9/U5bt9Hi10/Ja7QWcHlksFoVRN16wTShPNbFf5agDCBz8iifOxRbnLT3Rt
         ptfxfWjACqee5aMhG7bOiV7wXcl1Han+qTOru0ui6TNVpQ7nS4twPAwOxNj3ZFZO2n
         vJq/dcTi285CSgnS62oIn7f/ZzjiPPz4CThAYjq575CT7c+QW83ozQqc3UWIzLuNLM
         879KJ0hSzYG3pwAqZKmWfPuweq2OOZWBTQ3WL8DDYx9BT3ssYfQn0uLYbjhh44T5Vq
         Agque2y1l+VnQ==
Date:   Sun, 4 Sep 2022 07:02:05 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <YxQjPbFSHOThq4c5@kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-5-jarkko@kernel.org>
 <d2b76530-82a2-6ac1-32ea-696e653d767d@intel.com>
 <YxEwwzXOsCliznQJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxEwwzXOsCliznQJ@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 02, 2022 at 01:22:59AM +0300, Jarkko Sakkinen wrote:
> > Is this test passing on your system? This version is missing the change to
> > mrenclave_ecreate() that causes SGX_IOC_ENCLAVE_INIT to fail when I try it out.
> 
> I *did* get a pass in my test machine. Hmm... I'll check if
> the kernel tree was out-of-sync, which could be the reason.
> 
> I do not compile kernel on that machine but have the kernel
> tree for running selftests. So there is a possiblity for
> a human error. Thanks for pointing this out.

Apparently, v1 and v2 break the encl->src_size calculation:
the dynamic heap size is not added.

So, in order to revert sigstruct change:

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 47b2786d6a77..0e4e12e1e3eb 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -172,7 +172,7 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
 }

 bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
-              unsigned long edmm_size)
+              unsigned long dynamic_heap_size)
 {
        const char device_path[] = "/dev/sgx_enclave";
        struct encl_segment *seg;
@@ -299,9 +299,9 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
        if (seg->src == MAP_FAILED)
                goto err;

-       encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
+       encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size + dynamic_heap_size;

-       for (encl->encl_size = 4096; encl->encl_size < encl->src_size + edmm_size;)
+       for (encl->encl_size = 4096; encl->encl_size < encl->src_size;)
                encl->encl_size <<= 1;

        return true;

BR, Jarkko
