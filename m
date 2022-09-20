Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B315BDFE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiITIVf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 04:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiITIUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 04:20:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3353DF1B;
        Tue, 20 Sep 2022 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663661946; x=1695197946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XsLK0rUD3KK3Xm/Wda0NghIGHbyZGZps+l+d5v4b5Bk=;
  b=VbTyiaYUOFOaZX/+oPG1owamNSdr2KXQRFoOiC/KjRrEzZd9ps90nEch
   wmg8r9hOJJaOZo3zPhN1UqZ0VDgmIhgmW/lzty70FU2PJde6h9cdmyrdD
   oyJz1TttXvpIaXbI9eNtCHsizYd8lpHOSCRhxjg1JmSsMv+i5y51mWn0q
   H/PMuJqDx38/da+16PGUVPdcyy88wx1DV2gYJePB5QQcMHhasQ9d7vGK2
   xxSPr8B+LhTruNkDWpU1QNhh98zoxkgh/DBMg1+kuQXuXlXuvsJyiRaaS
   0No6BOv+oyLzerBfMUBvl/R22SmHPTgNIjPXBQZRIXQCazUKRk1I/yFF+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279359210"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="279359210"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:19:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="744433857"
Received: from thrakatuluk.fi.intel.com (HELO platvala-desk.ger.corp.intel.com) ([10.237.72.90])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:19:02 -0700
Date:   Tue, 20 Sep 2022 11:18:25 +0300
From:   Petri Latvala <petri.latvala@intel.com>
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     igt-dev@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        daniel@ffwll.ch, kunit-dev@googlegroups.com,
        magalilemes00@gmail.com, maira.canal@usp.br, dlatypov@google.com,
        n@nfraprado.net, linux-kernel@vger.kernel.org,
        leandro.ribeiro@collabora.com, dri-devel@lists.freedesktop.org,
        davidgow@google.com, tales.aparecida@gmail.com,
        skhan@linuxfoundation.org, andrealmeid@riseup.net,
        brendanhiggins@google.com, twoerner@gmail.com
Subject: Re: [igt-dev] [PATCH i-g-t v2 4/4] tests: DRM selftests: switch to
 KUnit
Message-ID: <Yyl3UXvLd3Jyr9uP@platvala-desk.ger.corp.intel.com>
References: <20220829000920.38185-1-isabbasso@riseup.net>
 <20220829000920.38185-5-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829000920.38185-5-isabbasso@riseup.net>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 28, 2022 at 09:09:20PM -0300, Isabella Basso wrote:
> As the DRM selftests are now using KUnit [1], update IGT tests as well.
> 
> [1] - https://lore.kernel.org/all/20220708203052.236290-1-maira.canal@usp.br/
> 
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  tests/drm_buddy.c    |  7 ++++---
>  tests/drm_mm.c       |  7 ++++---
>  tests/kms_selftest.c | 12 +++++++++---
>  3 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/drm_buddy.c b/tests/drm_buddy.c
> index 06876e0c..74c06dce 100644
> --- a/tests/drm_buddy.c
> +++ b/tests/drm_buddy.c
> @@ -6,9 +6,10 @@
>  #include "igt.h"
>  #include "igt_kmod.h"
>  
> -IGT_TEST_DESCRIPTION("Basic sanity check of DRM's buddy allocator (struct drm_buddy)");
> +IGT_TEST_DESCRIPTION("Basic sanity check of DRM's buddy allocator (struct \
> +		      drm_buddy) using KUnit");
>  
> -igt_main
> +igt_simple_main
>  {
> -	igt_kselftests("test-drm_buddy", NULL, NULL, NULL);
> +	igt_kunit("drm_buddy_test", NULL);
>  }

With kselftests we had the ability to only run a specified set of
tests, and with or without selection, we had sub-results for each
through dynamic subtests. Does kunit have that possibility? I mean I
know kunit itself does but what about igt_kunit()?

Orthogonal to that question, drm_mm and test-drm_modeset are _now_
using kunit but in LTS kernels they're not, and we'd like to be able
to keep testing those. That means having both launchers here and just
letting the "incorrect" one produce a 'skip'.


-- 
Petri Latvala


> diff --git a/tests/drm_mm.c b/tests/drm_mm.c
> index 2052b115..75fc6682 100644
> --- a/tests/drm_mm.c
> +++ b/tests/drm_mm.c
> @@ -24,9 +24,10 @@
>  #include "igt.h"
>  #include "igt_kmod.h"
>  
> -IGT_TEST_DESCRIPTION("Basic sanity check of DRM's range manager (struct drm_mm)");
> +IGT_TEST_DESCRIPTION("Basic sanity check of DRM's range manager (struct drm_mm)\
> +		     using KUnit");
>  
> -igt_main
> +igt_simple_main
>  {
> -	igt_kselftests("test-drm_mm", NULL, NULL, NULL);
> +	igt_kunit("drm_mm_test", NULL);
>  }
> diff --git a/tests/kms_selftest.c b/tests/kms_selftest.c
> index abc4bfe9..bbf24c2b 100644
> --- a/tests/kms_selftest.c
> +++ b/tests/kms_selftest.c
> @@ -24,9 +24,15 @@
>  #include "igt.h"
>  #include "igt_kmod.h"
>  
> -IGT_TEST_DESCRIPTION("Basic sanity check of KMS selftests.");
> +IGT_TEST_DESCRIPTION("Basic sanity check of KMS selftests using KUnit");
>  
> -igt_main
> +igt_simple_main
>  {
> -	igt_kselftests("test-drm_modeset", NULL, NULL, NULL);
> +	igt_kunit("drm_cmdline_parser_test", NULL);
> +	igt_kunit("drm_damage_helper_test", NULL);
> +	igt_kunit("drm_dp_mst_helper_test", NULL);
> +	igt_kunit("drm_format_helper_test", NULL);
> +	igt_kunit("drm_format_test", NULL);
> +	igt_kunit("drm_framebuffer_test", NULL);
> +	igt_kunit("drm_plane_helper_test", NULL);
>  }
> -- 
> 2.37.2
> 
