Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D097F5AC24A
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Sep 2022 06:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiIDEVR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Sep 2022 00:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiIDEVQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Sep 2022 00:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4473F1F603;
        Sat,  3 Sep 2022 21:21:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D448060EBF;
        Sun,  4 Sep 2022 04:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA62C433D6;
        Sun,  4 Sep 2022 04:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662265274;
        bh=HTaLkyOjeRqU6VsCndu9y+G0HXRggqTWGIUw/ybXXiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxGJ2cteHFQQU2LqmX2NpaI/6R7xnmfcsx/3Eu0WPftaDbPga46zvXsc12SBVYA81
         lv08BC3pvPTj+qtjvZ5epX+o5nbRxd2+3XMWDP+1VCy9o6nU2YctavaHm39honQsQJ
         nQ3QSnn/iD8Qu1/plkJMQoS4dpOMC3k4W2tcZkqGkzOVoU+dgt9Y/suyebfFn1oh/i
         L5SiXE+3MuRAKin/VKVpWa4JfEwFn1swTSXH/mth7Vu/vvX/MieBG3i65bmGIE07sy
         pJoaJkJU0bRALRKlxXySzIYWV4Wor0CvMfnV2Z30JpfxXzeInpDJ+1Xx31UdblFOLz
         +VGAPe0uPt+gw==
Date:   Sun, 4 Sep 2022 07:21:09 +0300
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
Message-ID: <YxQntXMQfEZ/kZQT@kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-5-jarkko@kernel.org>
 <d2b76530-82a2-6ac1-32ea-696e653d767d@intel.com>
 <YxEwwzXOsCliznQJ@kernel.org>
 <YxQjPbFSHOThq4c5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxQjPbFSHOThq4c5@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 04, 2022 at 07:02:08AM +0300, Jarkko Sakkinen wrote:
> On Fri, Sep 02, 2022 at 01:22:59AM +0300, Jarkko Sakkinen wrote:
> > > Is this test passing on your system? This version is missing the change to
> > > mrenclave_ecreate() that causes SGX_IOC_ENCLAVE_INIT to fail when I try it out.
> > 
> > I *did* get a pass in my test machine. Hmm... I'll check if
> > the kernel tree was out-of-sync, which could be the reason.
> > 
> > I do not compile kernel on that machine but have the kernel
> > tree for running selftests. So there is a possiblity for
> > a human error. Thanks for pointing this out.
> 
> Apparently, v1 and v2 break the encl->src_size calculation:
> the dynamic heap size is not added.
> 
> So, in order to revert sigstruct change:
> 
> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> index 47b2786d6a77..0e4e12e1e3eb 100644
> --- a/tools/testing/selftests/sgx/load.c
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -172,7 +172,7 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
>  }
> 
>  bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
> -              unsigned long edmm_size)
> +              unsigned long dynamic_heap_size)
>  {
>         const char device_path[] = "/dev/sgx_enclave";
>         struct encl_segment *seg;
> @@ -299,9 +299,9 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
>         if (seg->src == MAP_FAILED)
>                 goto err;
> 
> -       encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
> +       encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size + dynamic_heap_size;
> 
> -       for (encl->encl_size = 4096; encl->encl_size < encl->src_size + edmm_size;)
> +       for (encl->encl_size = 4096; encl->encl_size < encl->src_size;)
>                 encl->encl_size <<= 1;

Actually, it is correct after all how Vijay changed it. We should use
the final pre-calculated enclave address range in sigstruct.c. It's the
re-calculation of that in sigstruct is a reminiscent of it being a
separate command-line utility, instead of calculating the sigstruct
on-fly. I.e. there has been sane reasons why it has been like that.

BR, Jarkko
