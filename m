Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E467B670BB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 23:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjAQWh1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 17:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjAQWhC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 17:37:02 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67724F861
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 14:12:44 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 200so18529268pfx.7
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 14:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9YW+lwhjFOD4p6LmIXUirNO23qllr5fTwF/5IqDM2Y=;
        b=QFG6GWHXqBMM7GsWXt3Hr4bJ1B2S7Xr4CFM24cED5KtkzBBs+b5GQ/86H/d4eHip+t
         d9veLwx80rIkaBJsl3kKDBpXOkE5LZkY3Ab0vBUtS0ClC96ieweI0OrM/lOJjk75aCSW
         +MITjt5k+UHflslBkemgH/xekPOCzoXOhsYMAzBLR/7oNX2or9JRoUyeG63I3MEVgcKr
         p1iYGHI1R2nONABIlLsCF9zbJsT0O6Lyuwnekv6OMN+0rf8eod4J49iOK/auaEBu1Dy3
         ebbHaHl3S/+6EtAVziSqJ39ASlZZrBZ4r05Mbvwxe1eOHeFdcea65lGPLDqz5rvNHT7U
         25yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9YW+lwhjFOD4p6LmIXUirNO23qllr5fTwF/5IqDM2Y=;
        b=4ujaMGkicVL+Gq0zJiiBN9n+VaTWt3HhUtWKz9lzlFTOBFeoAwuZmkCbiut94K87LW
         L2gMkXwJszYbNAz6gzNG7JZUZACB5zyd7SsODYpxCpY7tDnWU2TT7KkMdZJ8GnPEStdn
         +WsPVmuLDAmqUUjTSryNe34wuQy443cvJVigSOiv0gVQBKqILuCTJLCK3/cn74Va1sgl
         HA0+bboWC5B6dwS/Xr5L0OzY1OsF8hyOr3jTa8qv0l++qlePjNaV5N+mayXKBHLMb7Ub
         QtejixZU2kfpYtoGftA8v2Uzy5GhQrj01Svu81eC7ooe+EaLvV6niYxx1Db6t5ieyrOS
         Aa5Q==
X-Gm-Message-State: AFqh2krNj8Nngq1qxF0+g91madp+/DI20oqDEq4eN1DkiOHYEOIFH+MH
        YjDG0dZVSv785OH6CIV0rFUI5A==
X-Google-Smtp-Source: AMrXdXsxfo+xqmW7i1lvwa6CRHsBy8qgST2EYmwTSV2bp+gjyNC1TrUprRW0J90ZkExuFN7WkNsF/w==
X-Received: by 2002:a05:6a00:a87:b0:582:13b5:d735 with SMTP id b7-20020a056a000a8700b0058213b5d735mr2626944pfl.0.1673993563929;
        Tue, 17 Jan 2023 14:12:43 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i24-20020aa796f8000000b0058d99337381sm5119064pfq.172.2023.01.17.14.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:12:43 -0800 (PST)
Date:   Tue, 17 Jan 2023 22:12:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
Subject: Re: [V2 PATCH 5/6] KVM: selftests: Add get_free_huge_2m_pages
Message-ID: <Y8cdWKaZVXQFcO+i@google.com>
References: <20221205232341.4131240-1-vannapurve@google.com>
 <20221205232341.4131240-6-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205232341.4131240-6-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> Add an API to query free 2MB hugepages in the system.
> 
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  .../testing/selftests/kvm/include/test_util.h  |  1 +
>  tools/testing/selftests/kvm/lib/test_util.c    | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index aea80071f2b8..3d1cc215940a 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -122,6 +122,7 @@ struct vm_mem_backing_src_alias {
>  bool thp_configured(void);
>  size_t get_trans_hugepagesz(void);
>  size_t get_def_hugetlb_pagesz(void);
> +size_t get_free_huge_2mb_pages(void);
>  const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
>  size_t get_backing_src_pagesz(uint32_t i);
>  bool is_backing_src_hugetlb(uint32_t i);
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index d33b98bfe8a3..745573023b57 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -162,6 +162,24 @@ size_t get_trans_hugepagesz(void)
>  	return size;
>  }
>  
> +size_t get_free_huge_2mb_pages(void)

I strongly prefer to follow the precedence set by other tests, which at this
point means defaulting to non-huge pages.  I do think we need to make it easier
and/or automatic to test hugepages, but I would like to tackle that problem
separately.  E.g. a kernel built without hugepage support will fail the fopen()
below.

> +{
> +	size_t free_pages;
> +	FILE *f;
> +	int ret;
> +
> +	f = fopen("/sys/kernel/mm/hugepages/hugepages-2048kB/free_hugepages", "r");
> +	TEST_ASSERT(f != NULL, "Error in opening hugepages-2048kB/free_hugepages");
> +
> +	do {
> +		ret = fscanf(f, "%ld", &free_pages);
> +	} while (errno == EINTR);
> +	TEST_ASSERT(ret < 1, "Error reading hugepages-2048kB/free_hugepages");
> +	fclose(f);
> +
> +	return free_pages;
> +}
> +
>  size_t get_def_hugetlb_pagesz(void)
>  {
>  	char buf[64];
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 
