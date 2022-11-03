Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7855F618284
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 16:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiKCPXM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiKCPXL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 11:23:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0825F5FA2
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667488989; x=1699024989;
  h=date:from:to:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=C/9GQiG5IHJ6NJDspcBsPm/DgfJzjiEU0skgLUS9ULc=;
  b=CwtWWox2RiCUSTHbVyHkRFA2mIrsZohZAlmhw0NIJT2iTN2OWyz16ubz
   CojtpLEK3HJM6OEel6qxGL4aui3nlLPKDrA9pFwzlfW1LLUmtmmjFuBW8
   kk6UqwAQvURrVU7TVzgikfzoa7+WnCY9xMqgB2t/UslumXVzpoPTPGdxh
   QFf2owYtlxs0a+dyy5fLqvjcZ7eMIkriv0gTJAGYTVpbuT+WL1a/zue8m
   umUfn/R9YcfiQv6Ldz7cvov2cZy9C59UJn8b+q/uW1Mvasw6sPLgnbUp3
   PlEIsRJ6aT3K561zzrAhV/tImHcgo7Fi/EiYBPWhTFo4+EsT9W/8Z+BHT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="336411219"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="336411219"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 08:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="666007697"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="666007697"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 03 Nov 2022 08:23:09 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.30.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 12B42580BA0;
        Thu,  3 Nov 2022 08:23:05 -0700 (PDT)
Date:   Thu, 3 Nov 2022 16:23:02 +0100
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: KUnit issues - Was: [igt-dev] [PATCH RFC v2 8/8] drm/i915: check if
 current->mm is not NULL
Message-ID: <20221103162302.4ba62d72@maurocar-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

I'm facing a couple of issues when testing KUnit with the i915 driver.

The DRM subsystem and the i915 driver has, for a long time, his own
way to do unit tests, which seems to be added before KUnit.

I'm now checking if it is worth start using KUnit at i915. So, I wrote
a RFC with some patches adding support for the tests we have to be
reported using Kernel TAP and KUnit.

There are basically 3 groups of tests there:

- mock tests - check i915 hardware-independent logic;
- live tests - run some hardware-specific tests;
- perf tests - check perf support - also hardware-dependent.

As they depend on i915 driver, they run only on x86, with PCI
stack enabled, but the mock tests run nicely via qemu.

The live and perf tests require a real hardware. As we run them
together with our CI, which, among other things, test module
unload/reload and test loading i915 driver with different
modprobe parameters, the KUnit tests should be able to run as
a module.

While testing KUnit, I noticed a couple of issues:

1. kunit.py parser is currently broken when used with modules

the parser expects "TAP version xx" output, but this won't
happen when loading the kunit test driver.

Are there any plans or patches fixing this issue?

2. current->mm is not initialized

Some tests do mmap(). They need the mm user context to be initialized,
but this is not happening right now.

Are there a way to properly initialize it for KUnit?

3. there's no test filters for modules

In order to be able to do proper CI automation, it is needed to
be able to control what tests will run or not. That's specially
interesting at development time where some tests may not apply
or not run properly on new hardware.

Are there any plans to add support for it at kunit_test_suites()
when the driver is built as module? Ideally, the best would be to
export a per-module filter_glob parameter on such cases.

4. there are actually 3 levels of tests on i915:
	- Level 1: mock, live, perf
	- Level 2: test group (mmap, fences, ...)
	- Level 3: unit tests

Currently, KUnit seems to have just two levels (test suite and tests).
Are there a way to add test groups there?

Regards,
Mauro

Forwarded message:

Date: Thu,  3 Nov 2022 14:51:38 +0000
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To:=20
Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>, linux-kselfte=
st@vger.kernel.org, Micha=C5=82 Winiarski <michal.winiarski@intel.com>, dri=
-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Daniel Latyp=
ov <dlatypov@google.com>, linux-kernel@vger.kernel.org, igt-dev@lists.freed=
esktop.org, Matthew Auld <matthew.auld@intel.com>, Daniel Vetter <daniel@ff=
wll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, skhan@linuxfoundation.org, =
Isabella Basso <isabbasso@riseup.net>, David Airlie <airlied@gmail.com>, Ch=
ristian K=C3=B6nig <christian.koenig@amd.com>
Subject: [igt-dev] [PATCH RFC v2 8/8] drm/i915: check if current->mm is not=
 NULL


The mmap tests require mm in order to work. Failing to do that
will cause a crash:

[  316.820722] BUG: kernel NULL pointer dereference, address: 0000000000000=
0e8
[  316.822517] #PF: supervisor write access in kernel mode
[  316.823430] #PF: error_code(0x0002) - not-present page
[  316.824390] PGD 0 P4D 0
[  316.825357] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  316.826350] CPU: 0 PID: 1517 Comm: kunit_try_catch Tainted: G     U     =
      N 6.1.0-rc2-drm-266703e6f163+ #14
[  316.827503] Hardware name: Intel Corporation Tiger Lake Client Platform/=
TigerLake Y LPDDR4x T4 Crb, BIOS TGLSFWI1.R00.3243.A01.2006102133 06/10/2020
[  316.828633] RIP: 0010:down_write_killable+0x50/0x110
[  316.829756] Code: 24 10 45 31 c9 31 c9 41 b8 01 00 00 00 31 d2 31 f6 48 =
89 ef e8 e1 74 4a ff bf 01 00 00 00 e8 87 d6 46 ff 31 c0 ba 01 00 00 00 <f0=
> 48 0f b1 13 0f 94 c0 5a 84 c0 74 62 8b 05 49 12 e4 00 85 c0 74
[  316.830896] RSP: 0018:ffffc90001eabc58 EFLAGS: 00010246
[  316.832008] RAX: 0000000000000000 RBX: 00000000000000e8 RCX: 00000000000=
00000
[  316.833141] RDX: 0000000000000001 RSI: ffffffff81c94fc9 RDI: ffffffff81c=
94fc9
[  316.834195] RBP: 0000000000000158 R08: 0000000000000001 R09: 00000000000=
00000
[  316.835231] R10: 0000000000000000 R11: ffff8883a13350b8 R12: 00000000000=
00002
[  316.836259] R13: 0000000000000001 R14: 0000000000100000 R15: 00000000000=
000e8
[  316.837237] FS:  0000000000000000(0000) GS:ffff8883a3800000(0000) knlGS:=
0000000000000000
[  316.838214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  316.839190] CR2: 00000000000000e8 CR3: 0000000002812003 CR4: 00000000007=
70ef0
[  316.840147] PKRU: 55555554
[  316.841099] Call Trace:
[  316.842047]  <TASK>
[  316.842990]  ? vm_mmap_pgoff+0x78/0x150
[  316.843936]  vm_mmap_pgoff+0x78/0x150
[  316.844884]  igt_mmap_offset+0x178/0x1b9 [i915]
[  316.846119]  __igt_mmap+0xfe/0x680 [i915]

Unfortunately, when KUnit module runs, it doesn't create an
user context, causing mmap tests to fail.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C=
/C on the cover.
See [PATCH RFC v2 0/8] at: https://lore.kernel.org/all/cover.1667486144.git=
.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/g=
pu/drm/i915/gem/selftests/i915_gem_mman.c
index add5ae56cd89..2c5f93e946b5 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -1845,6 +1845,11 @@ int i915_gem_mman_live_selftests(struct drm_i915_pri=
vate *i915)
 		SUBTEST(igt_mmap_gpu),
 	};
=20
+	if (!current->mm) {
+		pr_err("Test called without an user context!\n");
+		return -EINVAL;
+	}
+
 	return i915_live_subtests(tests, i915);
 }
 EXPORT_SYMBOL_NS_GPL(i915_gem_mman_live_selftests, I915_SELFTEST);
--=20
2.38.1

