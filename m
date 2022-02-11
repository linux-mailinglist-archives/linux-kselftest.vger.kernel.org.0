Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92B4B232B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 11:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbiBKKeJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 05:34:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiBKKeI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6689AEA6
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 02:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B72AB828BA
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 10:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AED7C340E9;
        Fri, 11 Feb 2022 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644575645;
        bh=wXXuyKBQt46IGOEHezmN82dITuXgKrK5o/eWPXu2fvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvqgYTsPaCzQdgevk0P6T6vM6jW6nDW8c4Md4WJQARQLFYVVvGHCfSM3lOGaDZL2m
         zJhOtTpJWum2yeaLgVDIhHKciV0E8HE7GgjUI6g5vkGsm6QT9O9f/XEL7rO2oSGM32
         Wb6+NgshhTdM2q/d9LDUChl7laPTCNStwtZ3wR1t2LjtwY1DazH7nJrxUByhI0cb3y
         FKLeEyg8UjIp8pey9AYNC27YThq42ecrLJ7sUiW+Tkhq9yH2P2DJoVuv12tS9TvPhu
         8pzH6EhPyfHX8BH3dveaWXMJRiUYrkVK+offjxfTHFacoVRlLJBDdm8CInbKRnItbc
         yB/EPxDXx8DvA==
Date:   Fri, 11 Feb 2022 12:33:56 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftest/vm: Use correct PAGE_SHIFT value for
 ppc64
Message-ID: <YgY7lDToiQ0pM6U6@kernel.org>
References: <20220211063330.99648-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211063330.99648-1-aneesh.kumar@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 11, 2022 at 12:03:28PM +0530, Aneesh Kumar K.V wrote:
> Keep it simple by using a #define and limiting hugepage size to 2M.
> This keeps the test simpler instead of dynamically finding the page size
> and huge page size.
> 
> Without this tests are broken w.r.t reading /proc/self/pagemap
> 
> 	if (pread(pagemap_fd, ent, sizeof(ent),
> 			(uintptr_t)ptr >> (PAGE_SHIFT - 3)) != sizeof(ent))
> 		err(2, "read pagemap");
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/ksm_tests.c        | 9 ++++++++-
>  tools/testing/selftests/vm/transhuge-stress.c | 9 ++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
> index 1436e1a9a3d3..cae72872152b 100644
> --- a/tools/testing/selftests/vm/ksm_tests.c
> +++ b/tools/testing/selftests/vm/ksm_tests.c
> @@ -22,7 +22,14 @@
>  #define KSM_MERGE_ACROSS_NODES_DEFAULT true
>  #define MB (1ul << 20)
>  
> -#define PAGE_SHIFT 12
> +#ifdef __powerpc64__
> +#define PAGE_SHIFT	16
> +#else
> +#define PAGE_SHIFT	12
> +#endif

Page size can be other than 4096 for other configurations as well. And even
on ppc64 it's not necessarily 64k.

Ideally page size in selftests/vm should be sysconf(_SC_PAGESIZE)

> +/*
> + * On ppc64 this will only work with radix 2M hugepage size
> + */
>  #define HPAGE_SHIFT 21
>  
>  #define PAGE_SIZE (1 << PAGE_SHIFT)
> diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
> index 5e4c036f6ad3..b1f8d98355c5 100644
> --- a/tools/testing/selftests/vm/transhuge-stress.c
> +++ b/tools/testing/selftests/vm/transhuge-stress.c
> @@ -16,7 +16,14 @@
>  #include <string.h>
>  #include <sys/mman.h>
>  
> -#define PAGE_SHIFT 12
> +#ifdef __powerpc64__
> +#define PAGE_SHIFT	16
> +#else
> +#define PAGE_SHIFT	12
> +#endif
> +/*
> + * On ppc64 this will only work with radix 2M hugepage size
> + */
>  #define HPAGE_SHIFT 21
>  
>  #define PAGE_SIZE (1 << PAGE_SHIFT)
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
