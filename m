Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6744278DAD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbjH3ShR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244049AbjH3MYZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 08:24:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E8CC5;
        Wed, 30 Aug 2023 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693398262; x=1724934262;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/DxvYklHe20nQbJbPnAFJlahY5gcOY8BRtA5KbVsT14=;
  b=YzqDbZbgkEm8RG4ar9WNc+5G7K1wxSGSBdQFCV23VbLiuje36zXmRkmH
   Bhw04G03iIp/kMeia9UOtQ4Xxs/5NIhjUjLMAP6NbibqmmrMoLp7l6hmi
   5Xj7knpe+NOrSBkfpJMWTGlGy/KJElDDfHqrDhDgP5iJZb2uBGKa3w6GR
   JRHmvqgkaQ1AaU+jBgQB3zlxfus9I3nGPcYlPP5GYCEifn/Sq160+KMq4
   uxEqWrL3lgxDPCzwm4JvlIcTf+J2My74yD1h8UX1aKwRb8VwEGWlE2v8B
   abwbH1CzcZS30ksLtmaWhioSO1caFppHlyz+kkXkvOTWle6qCePSYGoqc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374537192"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="374537192"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 05:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="853710746"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="853710746"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.251.213.104])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 05:22:59 -0700
Date:   Wed, 30 Aug 2023 15:22:57 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] selftests/kvm: Replace attribute with macro
In-Reply-To: <82ed62dd7070203701b4ca326e62862404dd5f72.1693216959.git.maciej.wieczor-retman@intel.com>
Message-ID: <fc618e8c-f8b-c339-9aa6-1d2c2865b42e@linux.intel.com>
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com> <82ed62dd7070203701b4ca326e62862404dd5f72.1693216959.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 28 Aug 2023, Wieczor-Retman, Maciej wrote:

> The __printf() macro is used in many tools in the linux kernel to
> validate the format specifiers in functions that use printf. Some
> selftests use it without putting it in a macro definition and some tests
> import the kselftests.h header.

"Some" and yet this only converts one? Please be more precise in the 
wording.

> Use __printf() attribute instead of the full attribute since the macro
> is inside kselftests.h and the header is already imported.

IMO, this would be enough:

Use __printf() from kselftests.h instead of the full attribute.

Was there a reason why you didn't convert mm/pkey-helpers.h one?

-- 
 i.


> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/kvm/include/test_util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index a6e9f215ce70..710a8a78e8ce 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -33,7 +33,7 @@ static inline int _no_printf(const char *format, ...) { return 0; }
>  #define pr_info(...) _no_printf(__VA_ARGS__)
>  #endif
>  
> -void print_skip(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
> +void __printf(1, 2) print_skip(const char *fmt, ...);
>  #define __TEST_REQUIRE(f, fmt, ...)				\
>  do {								\
>  	if (!(f))						\
> 
