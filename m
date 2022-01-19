Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A48493E16
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jan 2022 17:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356116AbiASQME (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jan 2022 11:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356115AbiASQMD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jan 2022 11:12:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF7EC061574
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jan 2022 08:12:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so6420557wmb.5
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jan 2022 08:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IBNFO4yxXqNmzn3LqT1fqeVE0Vjj1TW/ZplMTx0IYeM=;
        b=MQr0BtryerQqcLEuI0DElKIG7cQxegSKc/WT1hPc451G5Yn8RbzK7WwDSXqpH7jRvP
         1/a0XuTWXJuGmQko7S+Kzs3k/SQjGUAfFdkyR+pmNCjcdPIK3tnS1lk5crJPWeaUn8I7
         rT3UnFiD3r5TfX7tqGKWkbHxiZ/qNc0Q4JP/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IBNFO4yxXqNmzn3LqT1fqeVE0Vjj1TW/ZplMTx0IYeM=;
        b=3iBHz6VvNOmLv8XCk+5bnZYex//Njvv9koCVXGvYsvMYTZHgwP00sLlJYalXIJFUlW
         gVEX93q/ewO4AohUUyLTtB0DDE86Io6XfrTvLgvf4ujF6e1mi+OGhz0wg64Vwu2i3/OY
         LjnC7RCpuCaso12X92k3KCKoobLdyLBn+1z5VxOIp7VZpHX9RVbKr28G3/mozDqE1O0V
         9nhxkw+8a3uI+ojv7AbY6AQfHPG6qiRcC6DuvSybhSJU9NCFtvZ2Cebxvvg89uIsVQvy
         WaZzo/S5gApvrumRWQvkPdvlTO1wa6rSrzKhwRZKiaGw357TVCUuG0YRSm/lAsSBdnhl
         VQKg==
X-Gm-Message-State: AOAM531I+S4Uxh2n09deD5dsB7Do81d6GpGSQIEzCF/C022FElg4yqaL
        QvuER7RmHtndeuc1ZgiHIBCYHg==
X-Google-Smtp-Source: ABdhPJwBHCGP+vHdPD/q/Mbp64vMrk1/UObTxORaUhfXLkLFSfvOhE0vVBDtxcDkKyUcSdeEdz13Fg==
X-Received: by 2002:a05:600c:1d06:: with SMTP id l6mr4300906wms.174.1642608721894;
        Wed, 19 Jan 2022 08:12:01 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j31sm27007wms.2.2022.01.19.08.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:12:01 -0800 (PST)
Date:   Wed, 19 Jan 2022 17:11:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petri Latvala <petri.latvala@intel.com>,
        Arkadiusz Hiler <arek@hiler.eu>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@riseup.net>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [RFC 00/10] drm: selftests: Convert to KUnit
Message-ID: <Yeg4Tx3VFlWVzohI@phenom.ffwll.local>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 18, 2022 at 12:22:49AM +0100, Michał Winiarski wrote:
> KUnit unifies the test structure and provides helper tools that simplify
> the development. Basic use case allows running tests as regular processes,
> leveraging User Mode Linux.
> For example, to execute all DRM unit tests:
> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm
> (the tool also allows using QEMU instead of UML by adding e.g. --arch=x86_64)
> 
> For developers - it means that it's easier to run unit tests on the development
> machine, tightening the feedback loop. When using UML, it also simplifies using
> gdb for debug (since the kernel is just a regular process).
> For CI systems - DRM tests can be moved from being executed on device under
> test (that's also running IGTs and so on) to being executed on buildsystem
> during build (just like checkpatch.pl).
> 
> All tests were renamed - IGT prefix is no longer used.
> 
> Compared to selftests executed by CI using IGT, there's one functional
> regression - KUnit test runner is not catching WARNs.
> To solve this, we could either go in the similar direction that UBSAN went in:
> 1195505 ("kunit: ubsan integration")
> Or we could expand the test runner to catch WARN signature in dmesg.

I think catching WARN signature in dmesg makes sense, assuming Kunit has a
standard WARN format. It would be nice to be consistent here.

I haven't looked at any details, but yes so much I want to see this done.
I'll cc a bunch of people I've talked with about this conversion,
hopefully I got them all. Maybe they can help with review and getting this
all landed!

Cheers, Daniel

> Pastebin to preview the output and execution times:
> https://gitlab.freedesktop.org/-/snippets/4139
> 
> -Michał
> 
> Michał Winiarski (10):
>   drm: test-drm_cmdline_parser: Convert to KUnit
>   drm: test-drm_plane_helper: Convert to KUnit
>   drm: test-drm_format: Convert to KUnit
>   drm: test-drm_framebuffer: Convert to KUnit
>   drm: test-drm_damage_helper: Convert to KUnit
>   drm: test-drm_dp_mst_helper: Convert to KUnit
>   drm: test-drm_rect: Convert to KUnit
>   drm: test-drm_mm: Convert to KUnit
>   drm: selftests: Convert to KUnit
>   drm: test: Simplify testing on UML with kunit.py
> 
>  drivers/gpu/drm/.kunitconfig                  |    3 +
>  drivers/gpu/drm/Kconfig                       |   22 +-
>  drivers/gpu/drm/Makefile                      |    2 +-
>  drivers/gpu/drm/i915/Kconfig.debug            |    1 -
>  drivers/gpu/drm/selftests/Makefile            |    7 -
>  .../gpu/drm/selftests/drm_cmdline_selftests.h |   68 -
>  drivers/gpu/drm/selftests/drm_mm_selftests.h  |   28 -
>  .../gpu/drm/selftests/drm_modeset_selftests.h |   40 -
>  drivers/gpu/drm/selftests/drm_selftest.c      |  109 -
>  drivers/gpu/drm/selftests/drm_selftest.h      |   41 -
>  .../drm/selftests/test-drm_cmdline_parser.c   | 1141 --------
>  .../drm/selftests/test-drm_damage_helper.c    |  667 -----
>  .../drm/selftests/test-drm_dp_mst_helper.c    |  273 --
>  drivers/gpu/drm/selftests/test-drm_format.c   |  280 --
>  drivers/gpu/drm/selftests/test-drm_mm.c       | 2487 -----------------
>  .../drm/selftests/test-drm_modeset_common.c   |   32 -
>  .../drm/selftests/test-drm_modeset_common.h   |   52 -
>  .../gpu/drm/selftests/test-drm_plane_helper.c |  223 --
>  drivers/gpu/drm/selftests/test-drm_rect.c     |  223 --
>  drivers/gpu/drm/test/Makefile                 |    7 +
>  .../gpu/drm/test/test-drm_cmdline_parser.c    | 1027 +++++++
>  drivers/gpu/drm/test/test-drm_damage_helper.c |  667 +++++
>  drivers/gpu/drm/test/test-drm_dp_mst_helper.c |  429 +++
>  drivers/gpu/drm/test/test-drm_format.c        |  356 +++
>  .../test-drm_framebuffer.c                    |  109 +-
>  drivers/gpu/drm/test/test-drm_mm.c            | 2426 ++++++++++++++++
>  drivers/gpu/drm/test/test-drm_plane_helper.c  |  312 +++
>  drivers/gpu/drm/test/test-drm_rect.c          |  249 ++
>  drivers/video/Kconfig                         |    4 +
>  29 files changed, 5558 insertions(+), 5727 deletions(-)
>  create mode 100644 drivers/gpu/drm/.kunitconfig
>  delete mode 100644 drivers/gpu/drm/selftests/Makefile
>  delete mode 100644 drivers/gpu/drm/selftests/drm_cmdline_selftests.h
>  delete mode 100644 drivers/gpu/drm/selftests/drm_mm_selftests.h
>  delete mode 100644 drivers/gpu/drm/selftests/drm_modeset_selftests.h
>  delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.c
>  delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.h
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_damage_helper.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_format.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_mm.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.h
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_plane_helper.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_rect.c
>  create mode 100644 drivers/gpu/drm/test/Makefile
>  create mode 100644 drivers/gpu/drm/test/test-drm_cmdline_parser.c
>  create mode 100644 drivers/gpu/drm/test/test-drm_damage_helper.c
>  create mode 100644 drivers/gpu/drm/test/test-drm_dp_mst_helper.c
>  create mode 100644 drivers/gpu/drm/test/test-drm_format.c
>  rename drivers/gpu/drm/{selftests => test}/test-drm_framebuffer.c (91%)
>  create mode 100644 drivers/gpu/drm/test/test-drm_mm.c
>  create mode 100644 drivers/gpu/drm/test/test-drm_plane_helper.c
>  create mode 100644 drivers/gpu/drm/test/test-drm_rect.c
> 
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
