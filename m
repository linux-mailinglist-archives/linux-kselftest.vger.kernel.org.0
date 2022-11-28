Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241863B3AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 21:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiK1UtD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 15:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiK1Usd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 15:48:33 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF892F661;
        Mon, 28 Nov 2022 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jz2hvAT/K6kCHF/STG2fHRhRhklQMEYtVkKxZL0G/yU=; b=ZNh1cCs+OiKgGuoJs5FtQ/uRs5
        hVRJoqFiqAPIHwkJvEstX0NjVH85b+in8BuqEhg5H6wrrm7NyilFdlV2xnWJXKYZtuuVxriI7wexm
        dDL11fSvBT8hhLmBgJLrmn8Pj6ZjMLNLKKywJK+l4SDW6SvGtcAZfdjarNnrN75zeYdqGexm7XNdA
        HS8AcxKqDpuHdUoujTpZ6zcVX1BGib3UgVFcRZJhwmDGQbx4gfa24oCd1QPt2ZaOBglpf55SZYuRh
        zpUV4hC/JMvYU+XczsOekT86Mrll6hv86e1RFBqMLRl9RS7S0DJoVRPBaddiihnOtTZVped+TX70j
        yp7h0p6g==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ozl2x-00AcwT-CJ; Mon, 28 Nov 2022 21:48:11 +0100
Message-ID: <9b321967-917c-0afd-0483-7c5d72479f0e@igalia.com>
Date:   Mon, 28 Nov 2022 17:48:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 00/17] drm: Introduce Kunit Tests to VC4
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
References: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/28/22 11:53, Maxime Ripard wrote:
> Hi,
> 
> This series introduce Kunit tests to the vc4 KMS driver, but unlike what we
> have been doing so far in KMS, it actually tests the atomic modesetting code.
> 
> In order to do so, I've had to improve a fair bit on the Kunit helpers already
> found in the tree in order to register a full blown and somewhat functional KMS
> driver.
> 
> It's of course relying on a mock so that we can test it anywhere. The mocking
> approach created a number of issues, the main one being that we need to create
> a decent mock in the first place, see patch 22. The basic idea is that I
> created some structures to provide a decent approximation of the actual
> hardware, and that would support both major architectures supported by vc4.
> 
> This is of course meant to evolve over time and support more tests, but I've
> focused on testing the HVS FIFO assignment code which is fairly tricky (and the
> tests have actually revealed one more bug with our current implementation). I
> used to have a userspace implementation of those tests, where I would copy and
> paste the kernel code and run the tests on a regular basis. It's was obviously
> fairly suboptimal, so it seemed like the perfect testbed for that series.
> 
> It can be run using:
> ./tools/testing/kunit/kunit.py run \
>         --kunitconfig=drivers/gpu/drm/vc4/tests/.kunitconfig \
>         --cross_compile aarch64-linux-gnu- --arch arm64
> 
> Let me know what you think,
> Maxime

Hi Maxime,

It is great to see some device mocking with KUnit! Other than the
comments that I pointed out in the series, I believe that a small entry
on the VC4 documentation would be nice to cover how to run the tests and
also what the tests are currently covering.

Best Regards,
- Maíra Canal

> 
> To: David Airlie <airlied@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Maíra Canal <mairacanal@riseup.net>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---
> Changes in v2:
> - Added some documentation for public functions
> - Removed the fake device probe/remove workqueue 
> - Made sure the tests could be compiled as modules
> - Moved the vc4 tests in the vc4 module
> - Applied some of the preliminary patches
> - Rebased on top of current drm-misc-next branch
> - Fixed checkpatch issues
> - Introduced BCM2835 (Pi0-3) tests for muxing
> - Introduced tests to cover past bugs we had
> - Link to v1: https://lore.kernel.org/r/20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech
> 
> ---
> Maxime Ripard (17):
>       drm/tests: helpers: Move the helper header to include/drm
>       drm/tests: helpers: Document drm_kunit_device_init()
>       drm/tests: helpers: Rename the device init helper
>       drm/tests: helpers: Remove the name parameter
>       drm/tests: helpers: Create the device in another function
>       drm/tests: helpers: Switch to a platform_device
>       drm/tests: helpers: Make sure the device is bound
>       drm/tests: helpers: Allow for a custom device struct to be allocated
>       drm/tests: helpers: Allow to pass a custom drm_driver
>       drm/tests: Add a test for DRM managed actions
>       drm/vc4: Move HVS state to main header
>       drm/vc4: crtc: Introduce a lower-level crtc init helper
>       drm/vc4: crtc: Make encoder lookup helper public
>       drm/vc4: hvs: Provide a function to initialize the HVS structure
>       drm/vc4: tests: Introduce a mocking infrastructure
>       drm/vc4: tests: Fail the current test if we access a register
>       drm/vc4: tests: Add unit test suite for the PV muxing
> 
>  drivers/gpu/drm/tests/Makefile                  |    1 +
>  drivers/gpu/drm/tests/drm_client_modeset_test.c |   19 +-
>  drivers/gpu/drm/tests/drm_kunit_helpers.c       |  106 ++-
>  drivers/gpu/drm/tests/drm_kunit_helpers.h       |   11 -
>  drivers/gpu/drm/tests/drm_managed_test.c        |   71 ++
>  drivers/gpu/drm/tests/drm_modes_test.c          |   19 +-
>  drivers/gpu/drm/tests/drm_probe_helper_test.c   |   20 +-
>  drivers/gpu/drm/vc4/Kconfig                     |   15 +
>  drivers/gpu/drm/vc4/Makefile                    |    7 +
>  drivers/gpu/drm/vc4/tests/.kunitconfig          |   14 +
>  drivers/gpu/drm/vc4/tests/vc4_mock.c            |  200 +++++
>  drivers/gpu/drm/vc4/tests/vc4_mock.h            |   63 ++
>  drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c       |   41 +
>  drivers/gpu/drm/vc4/tests/vc4_mock_output.c     |  138 +++
>  drivers/gpu/drm/vc4/tests/vc4_mock_plane.c      |   47 +
>  drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c  | 1039 +++++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_crtc.c                  |  102 ++-
>  drivers/gpu/drm/vc4/vc4_dpi.c                   |   13 +-
>  drivers/gpu/drm/vc4/vc4_drv.c                   |    4 +-
>  drivers/gpu/drm/vc4/vc4_drv.h                   |   91 +-
>  drivers/gpu/drm/vc4/vc4_dsi.c                   |    9 +-
>  drivers/gpu/drm/vc4/vc4_hdmi_regs.h             |    4 +
>  drivers/gpu/drm/vc4/vc4_hvs.c                   |   81 +-
>  drivers/gpu/drm/vc4/vc4_kms.c                   |   25 +-
>  drivers/gpu/drm/vc4/vc4_txp.c                   |   15 +-
>  drivers/gpu/drm/vc4/vc4_vec.c                   |   13 +-
>  include/drm/drm_kunit_helpers.h                 |   91 ++
>  27 files changed, 2087 insertions(+), 172 deletions(-)
> ---
> base-commit: 199557fab92548f8e9d5207e385097213abe0cab
> change-id: 20221123-rpi-kunit-tests-87a388492a73
> 
> Best regards,
