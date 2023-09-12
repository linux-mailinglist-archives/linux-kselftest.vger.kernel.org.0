Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4251679C841
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 09:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjILHgX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjILHgV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 03:36:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32387E79
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 00:36:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31f7c87353eso549417f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1694504175; x=1695108975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+grCUostfIpNDbJCtZATyVfp717UCSAOFrm4GuSqa4=;
        b=Zi6OvxxqPSYGMupXReZWbsSk1pSc16kc4OftahhHWPL1n7PvMwoivfdyoVwEIgyHw+
         Y5K2UV1owEK8GmmcsrWP7TABUv1NIIBE4eFXXtmvrjFqusMyZVWNrvpWtAMxE+PbBK6Y
         53mrBKWMvKUSvxMA2mHqexUkRmWpqaVTpomoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504175; x=1695108975;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+grCUostfIpNDbJCtZATyVfp717UCSAOFrm4GuSqa4=;
        b=BqwynOknBhObe2UuRJreZdXJ5H8ozwW7kpq0jNIJD/z42eT3goNrgmJysBmgjCnvSO
         QfkNFikVUDqFG+8ClSzOtByzMgXI5+yO74IH3gLJOAddi2LRmo3cfQoS0tCySTUVRmEJ
         ilifuofKptzln4JuMvvOL/jQ8xdrQLKKATp37KW7b/i5034CZXpE2aiioU4CPGP6d9pk
         c7LOcV8Dx6oko+27ccfeVgyFAtoReMyMI51GuhHVXSax2v4LFsKjuxAUjch2Rmq05B1I
         uU3MdDSU9Nxdl+duivNRiUJ12ybIW5iD8oMzW8x+ytJxW+B5X4BpKXFEiKNpsld0U+XK
         K5pg==
X-Gm-Message-State: AOJu0YzOT2VuJOYepO3oSKGfqY9IddPSKud4/WbGe3rxOsQ0HQuuZLFX
        GyhyQqa0zvTxw4yo2s4RR3DxBA==
X-Google-Smtp-Source: AGHT+IGxydkfPGJ6b1sjOo2veJypAVFwoUoaaZ8mu7ON6QOiYcwhv+yqb2kpDK9bW/DrJ1e3VPPNXQ==
X-Received: by 2002:a05:6000:70a:b0:31f:84c9:d75f with SMTP id bs10-20020a056000070a00b0031f84c9d75fmr8444826wrb.4.1694504175484;
        Tue, 12 Sep 2023 00:36:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b00317ddccb0d1sm12118428wro.24.2023.09.12.00.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:36:14 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:36:12 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/tests: Flag slow tests as such
Message-ID: <ZQAU7Juw5WM1LAAM@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org>
 <20230911-kms-slow-tests-v1-2-d3800a69a1a1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-kms-slow-tests-v1-2-d3800a69a1a1@kernel.org>
X-Operating-System: Linux phenom 6.4.0-3-amd64 
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 11, 2023 at 11:51:06AM +0200, Maxime Ripard wrote:
> Kunit recently gained a speed attribute that allows to filter out slow
> tests. A slow test is defined in the documentation as a test taking more
> than a second to execute.
> 
> Let's flag the few tests that are doing so on my machine when running:
> 
> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests \
> 	--cross_compile aarch64-linux-gnu- --arch arm64
> 
> Suggested-by: David Gow <davidgow@google.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Ugh ... not a fan.

igt has a really bad habit of making disastrously combinatorial tests with
impossible runtimes, and then just filtering these out so it's still fast.

Maybe some stress tests for overall system make sense like this, but
absolutely not for unit tests. And I did spot check some of these, they're
just combinatorial explosions with large repetition counts and some fun
stuff like going through prime numbers because surely that's a good idea.

Imo delete them all, and if that causes a real gap in coverage, ask the
authors to write some actual good unit tests for these corner cases.

Cheers, Sima
> ---
>  drivers/gpu/drm/tests/drm_buddy_test.c |  2 +-
>  drivers/gpu/drm/tests/drm_mm_test.c    | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
> index 09ee6f6af896..6f79cde2df55 100644
> --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> @@ -742,7 +742,7 @@ static struct kunit_case drm_buddy_tests[] = {
>  	KUNIT_CASE(drm_test_buddy_alloc_range),
>  	KUNIT_CASE(drm_test_buddy_alloc_optimistic),
>  	KUNIT_CASE(drm_test_buddy_alloc_pessimistic),
> -	KUNIT_CASE(drm_test_buddy_alloc_smoke),
> +	KUNIT_CASE_SLOW(drm_test_buddy_alloc_smoke),
>  	KUNIT_CASE(drm_test_buddy_alloc_pathological),
>  	{}
>  };
> diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
> index 186b28dc7038..c1e662c2a76c 100644
> --- a/drivers/gpu/drm/tests/drm_mm_test.c
> +++ b/drivers/gpu/drm/tests/drm_mm_test.c
> @@ -2228,23 +2228,23 @@ module_param(max_prime, uint, 0400);
>  static struct kunit_case drm_mm_tests[] = {
>  	KUNIT_CASE(drm_test_mm_init),
>  	KUNIT_CASE(drm_test_mm_debug),
> -	KUNIT_CASE(drm_test_mm_reserve),
> -	KUNIT_CASE(drm_test_mm_insert),
> -	KUNIT_CASE(drm_test_mm_replace),
> -	KUNIT_CASE(drm_test_mm_insert_range),
> +	KUNIT_CASE_SLOW(drm_test_mm_reserve),
> +	KUNIT_CASE_SLOW(drm_test_mm_insert),
> +	KUNIT_CASE_SLOW(drm_test_mm_replace),
> +	KUNIT_CASE_SLOW(drm_test_mm_insert_range),
>  	KUNIT_CASE(drm_test_mm_frag),
>  	KUNIT_CASE(drm_test_mm_align),
>  	KUNIT_CASE(drm_test_mm_align32),
>  	KUNIT_CASE(drm_test_mm_align64),
> -	KUNIT_CASE(drm_test_mm_evict),
> +	KUNIT_CASE_SLOW(drm_test_mm_evict),
>  	KUNIT_CASE(drm_test_mm_evict_range),
>  	KUNIT_CASE(drm_test_mm_topdown),
>  	KUNIT_CASE(drm_test_mm_bottomup),
>  	KUNIT_CASE(drm_test_mm_lowest),
>  	KUNIT_CASE(drm_test_mm_highest),
>  	KUNIT_CASE(drm_test_mm_color),
> -	KUNIT_CASE(drm_test_mm_color_evict),
> -	KUNIT_CASE(drm_test_mm_color_evict_range),
> +	KUNIT_CASE_SLOW(drm_test_mm_color_evict),
> +	KUNIT_CASE_SLOW(drm_test_mm_color_evict_range),
>  	{}
>  };
>  
> 
> -- 
> 2.41.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
