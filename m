Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FEF4C1755
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiBWPnq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiBWPnq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:43:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD7F13F3D;
        Wed, 23 Feb 2022 07:43:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 273D0B82033;
        Wed, 23 Feb 2022 15:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90118C340E7;
        Wed, 23 Feb 2022 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645630995;
        bh=poLkfAL/ene1NybYu+EMK7WnfwCiDW55xL2XkxtVWyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFw7gj+7mez/kKLMf1VfbxbWXgj4ra9+215sRauxf4oPQnXotD6cZmJ/jnWLO3SBN
         5Dv9kMK/3/SdBHNz5DYbz7gnAlRyokhw6DLO0GsP9yTk6NuY77PGyYXv7BGbIb07m6
         2ZvxBUpGe72ZK/nIg7G18RwOjPxIlmNO6SCrM9vkozKHym/Y5EfDbGuzgyT4X5hkhn
         uz73Dn+cyjNLmd9vs/3wnE2G1T995lDtSpE2ljpLcsB1LnFrxJWzJ+QTXeLPCvz+Yc
         HGK5MkWQzPxbZdIK9aKjhOHAg9hK9u0/dGCt7Ki4jOLLY4ZRjDopu3Ts6YJUr5mJ8a
         beIPLQQVEfLAg==
Date:   Wed, 23 Feb 2022 16:43:50 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 1/4] selftests/sgx: Fix NULL-pointer-dereference upon
 early test failure
Message-ID: <YhZWNkNUvMYLWaee@iki.fi>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <89824888783fd8e770bfc64530c7549650a41851.1643754040.git.reinette.chatre@intel.com>
 <YhKePZv8tsgKYGfK@iki.fi>
 <8defd54d-1263-07b8-a117-c298903cbe27@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8defd54d-1263-07b8-a117-c298903cbe27@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 22, 2022 at 12:05:34PM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 2/20/2022 12:02 PM, Jarkko Sakkinen wrote:
> > On Tue, Feb 01, 2022 at 02:47:03PM -0800, Reinette Chatre wrote:
> >> == Background ==
> >>
> >> The SGX selftests track parts of the enclave binaries in an array:
> >> encl->segment_tbl[]. That array is dynamically allocated early
> >> (but not first) in the test's lifetime. The array is referenced
> >> at the end of the test in encl_delete().
> >>
> >> == Problem ==
> >>
> >> encl->segment_tbl[] can be NULL if the test fails before its
> >> allocation. That leads to a NULL-pointer-dereference in encl_delete().
> >> This is triggered during early failures of the selftest like if the
> >> enclave binary ("test_encl.elf") is deleted.
> >>
> >> == Solution ==
> >>
> >> Ensure encl->segment_tbl[] is valid before attempting to access
> >> its members. The offset with which it is accessed, encl->nr_segments,
> >> is initialized before encl->segment_tbl[] and thus considered valid
> >> to use after the encl->segment_tbl[] check succeeds.
> >>
> >> Fixes: 3200505d4de6 ("selftests/sgx: Create a heap for the test enclave")
> >> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> >> ---
> >> Changes since V1:
> >> - Rewrite commit message (Dave).
> >>
> >>  tools/testing/selftests/sgx/load.c | 9 +++++----
> >>  1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> >> index 9d4322c946e2..006b464c8fc9 100644
> >> --- a/tools/testing/selftests/sgx/load.c
> >> +++ b/tools/testing/selftests/sgx/load.c
> >> @@ -21,7 +21,7 @@
> >>  
> >>  void encl_delete(struct encl *encl)
> >>  {
> >> -	struct encl_segment *heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
> >> +	struct encl_segment *heap_seg;
> >>  
> >>  	if (encl->encl_base)
> >>  		munmap((void *)encl->encl_base, encl->encl_size);
> >> @@ -32,10 +32,11 @@ void encl_delete(struct encl *encl)
> >>  	if (encl->fd)
> >>  		close(encl->fd);
> >>  
> >> -	munmap(heap_seg->src, heap_seg->size);
> >> -
> >> -	if (encl->segment_tbl)
> >> +	if (encl->segment_tbl) {
> >> +		heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
> >> +		munmap(heap_seg->src, heap_seg->size);
> >>  		free(encl->segment_tbl);
> >> +	}
> >>  
> >>  	memset(encl, 0, sizeof(*encl));
> >>  }
> >> -- 
> >> 2.25.1
> >>
> > 
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> 
> Thank you very much for taking a look at these patches. 
> 
> V3[1] was submitted (8 February) and merged (11 February) onto x86/sgx
> before I received your reviewed-by tags for V1 (15 February) or
> V2 (20 February). The merged version thus does not contain your tags.
> 
> Reinette
> 
> [1] https://lore.kernel.org/linux-sgx/cover.1644355600.git.reinette.chatre@intel.com/

Not a big deal, but thanks for confirming :-)

BR, Jarkko
