Return-Path: <linux-kselftest+bounces-30940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4A0A8B578
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 11:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BD84440F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD238230BED;
	Wed, 16 Apr 2025 09:34:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4839140E5F
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796051; cv=none; b=qb2zIeloHFzQU6qxtD4Bfpx5W+0v45i3WZfmVxXLswoVs65L3+57VB0fi7w3oS5H/j1NweIKAVNbfFphhTPuTS+hukjqFrAL34lGi0qtSixtTOGTsBIcPshCtGdVzTneFDDN83Dct3n9jo/0J0nb1BwN5jftWPYy3mmP3re6NHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796051; c=relaxed/simple;
	bh=1cQ9Bo7hlVWZLcKOGksiuzi03AWoJ23xdgj4ZMbGROM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUWrCliXRZpB+Gms6ieAnrei6M9hGge6K7Kj58R11gKO4jITqV8lHhA+E3biwyi1cKbZSl169VVIP2RP40/aa++O7jE9NLkQ3J3ICMUKAQEwgLOWBVrW6Z6CbXaN9TjHWaZZkrKgvODxr1KGOIxYDfB+kMImIKQ9UF8jz+4LzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13589C4CEE9;
	Wed, 16 Apr 2025 09:34:07 +0000 (UTC)
Date: Wed, 16 Apr 2025 10:34:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2] drm/tests: Drop drm_kunit_helper_acquire_ctx_alloc()
Message-ID: <Z_95jWM2YMTGy3pi@arm.com>
References: <20250220132537.2834168-1-mripard@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220132537.2834168-1-mripard@kernel.org>

Hi Maxime,

On Thu, Feb 20, 2025 at 02:25:37PM +0100, Maxime Ripard wrote:
> lockdep complains when a lock is released in a separate thread the
> lock is taken in, and it turns out that kunit does run its actions in a
> separate thread than the test ran in.
> 
> This means that drm_kunit_helper_acquire_ctx_alloc() just cannot work as
> it's supposed to, so let's just get rid of it.
> 
> Suggested-by: Simona Vetter <simona.vetter@ffwll.ch>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

My scripts for running all possible kunit tests (under arm64 qemu)
started failing with 6.15-rc1. I bisected it to commit 30188df0c387
("drm/tests: Drop drm_kunit_helper_acquire_ctx_alloc()"). No idea
whether it fails on other architectures but it's fairly easy to
reproduce on arm64. Starting from defconfig, enable CONFIG_KUNIT=m and
CONFIG_DRM_VC4_KUNIT_TEST=m, build the kernel with gcc. Once a prompt is
reached, "modprobe vc4" and the most noticeable thing is the kernel
panic with stack protector enabled (by default on arm64):

  Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: drm_vc4_test_pv_muxing+0x2a4/0x2a4 [vc4]
  CPU: 14 UID: 0 PID: 311 Comm: kunit_try_catch Tainted: G        W        N  6.15.0-rc2 #1 PREEMPT
  Tainted: [W]=WARN, [N]=TEST
  Hardware name: QEMU KVM Virtual Machine, BIOS 2024.08-4 10/25/2024
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x60/0x80
   dump_stack+0x18/0x24
   panic+0x168/0x360
   __ktime_get_real_seconds+0x0/0x20
   vc4_test_pv_muxing_gen_params+0x0/0x94 [vc4]
   kunit_try_run_case+0x6c/0x160 [kunit]
   kunit_generic_run_threadfn_adapter+0x28/0x4c [kunit]
   kthread+0x12c/0x204
   ret_from_fork+0x10/0x20
  SMP: stopping secondary CPUs
  Kernel Offset: 0x431a85f00000 from 0xffff800080000000
  PHYS_OFFSET: 0xfff0e8f3c0000000
  CPU features: 0x0002,00000268,01002640,82004203
  Memory Limit: none
  ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: drm_vc4_test_pv_muxing+0x2a4/0x2a4 [vc4] ]---

Scrolling through the log, I also get a lot of warnings before the
panic:

  WARNING: CPU: 14 PID: 311 at drivers/gpu/drm/drm_modeset_lock.c:296 drm_modeset_lock+0xbc/0xfc [drm]
  Modules linked in: vc4 snd_soc_hdmi_codec drm_kunit_helpers drm_exec cec drm_display_helper drm_client_lib drm_dma_helper kunit drm_kms_helper drm backlight dm_mod ip_tables x_tables ipv6
  CPU: 14 UID: 0 PID: 311 Comm: kunit_try_catch Tainted: G        W        N  6.15.0-rc2 #1 PREEMPT
  Tainted: [W]=WARN, [N]=TEST
  Hardware name: QEMU KVM Virtual Machine, BIOS 2024.08-4 10/25/2024
  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : drm_modeset_lock+0xbc/0xfc [drm]
  lr : drm_atomic_get_private_obj_state+0x78/0x180 [drm]
  sp : ffff800080b0bbd0
  x29: ffff800080b0bbd0 x28: 0000000000000004 x27: ffff170d4829a480
  x26: ffff170d42968000 x25: ffff170d4829a480 x24: ffff170d40eaf540
  x23: 0000000000000038 x22: ffff170d42964400 x21: ffff170d4829a480
  x20: ffff170d42968958 x19: ffff800080b0bd58 x18: 00000000ffffffff
  x17: 0000000000000000 x16: ffffc31b065888a0 x15: 0000000000000000
  x14: 0000000000000040 x13: 01e0000002800280 x12: 0000000000000000
  x11: 0000000000000000 x10: 000001e001e001e0 x9 : 0000000000000020
  x8 : ffff170d40b70148 x7 : 0000000000000021 x6 : 0000000000000fdf
  x5 : 0000000000000fdf x4 : 0000000000000004 x3 : ffff170d429688f0
  x2 : ffff170d40eaf540 x1 : 0000000000000000 x0 : ffff800080b0be10
  Call trace:
   drm_modeset_lock+0xbc/0xfc [drm] (P)
   drm_atomic_get_private_obj_state+0x78/0x180 [drm]
   vc4_atomic_check+0x47c/0x754 [vc4]
   drm_atomic_check_only+0x4d4/0x914 [drm]
   drm_vc4_test_pv_muxing+0xe0/0x2a4 [vc4]
   kunit_try_run_case+0x6c/0x160 [kunit]
   kunit_generic_run_threadfn_adapter+0x28/0x4c [kunit]
   kthread+0x12c/0x204
   ret_from_fork+0x10/0x20

Reverting the above commit makes these go away. I did not have time to
look deeper, I thought I'd report it here first.

The panic is with gcc 14.2.0 from Debian unstable. I tried with gcc
12.2.0 in Debian stable and I don't get the stack protector panic, only
the lock warnings.

With clang 14 and 19, I get NULL pointer dereferences with this call
trace (decoded):

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
  [...]
  drm_modeset_lock (include/linux/list.h:153 include/linux/list.h:169 drivers/gpu/drm/drm_modeset_lock.c:318 drivers/gpu/drm/drm_modeset_lock.c:396) drm (P)
  drm_atomic_get_connector_state (drm.mod.c:?) drm
  vc4_mock_atomic_add_output (drivers/gpu/drm/vc4/tests/vc4_mock_output.c:?) vc4
  drm_vc4_test_pv_muxing (drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c:688) vc4
  kunit_try_run_case (lib/kunit/test.c:400) kunit
  kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:31) kunit
  kthread (kernel/kthread.c:466)
  ret_from_fork (arch/arm64/kernel/entry.S:863)

I can run more tests if you'd like, decode the stack traces.

Thanks.

-- 
Catalin

