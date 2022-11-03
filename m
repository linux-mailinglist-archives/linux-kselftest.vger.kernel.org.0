Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C55618001
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiKCOv5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiKCOvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:51:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3C918B30;
        Thu,  3 Nov 2022 07:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10DE5B828B4;
        Thu,  3 Nov 2022 14:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC02C43143;
        Thu,  3 Nov 2022 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487103;
        bh=1ynZM90FVuDLUm6Ak2G09DB3URFnKUrvlsBGn1ucYXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JyRr6wkpdyrB+4wxOYn8KaoaZBO7VBziswzVB1HZ1YrOkxCzbS5gSVYEDEKL0/NM/
         tv+O6T4EKN1qyE+TuPm/P3bSTS75P5h5qczWaX//RCbAZqGfFXwhpl2ci3+fVYscM9
         MjUcHB8WrhDFP6HvOvgMvUy4LMlX8TDzd+duVGS2fWp0jrY2wlF01O9Bye7eerkqFp
         WKff862tjqqjsnsVuZlb+8G27tDnTM3V5XjA8V5a+oYeFsYnHvz4wgXN4O4N7sMryA
         GeQgiIPWXkz4q29z8ZFVGRZxAvIPooFutsGc4Kww5k+VrVbAuMJvIhXTUBVeTPSO1d
         DEnKH2009KERQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1oqbZE-0076bD-0V;
        Thu, 03 Nov 2022 14:51:40 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Daniel Latypov" <dlatypov@google.com>,
        "Isabella Basso" <isabbasso@riseup.net>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH RFC v2 8/8] drm/i915: check if current->mm is not NULL
Date:   Thu,  3 Nov 2022 14:51:38 +0000
Message-Id: <dda905a04a85cad003338732d712ff98c18c68cf.1667486144.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667486144.git.mchehab@kernel.org>
References: <cover.1667486144.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The mmap tests require mm in order to work. Failing to do that
will cause a crash:

[  316.820722] BUG: kernel NULL pointer dereference, address: 00000000000000e8
[  316.822517] #PF: supervisor write access in kernel mode
[  316.823430] #PF: error_code(0x0002) - not-present page
[  316.824390] PGD 0 P4D 0
[  316.825357] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  316.826350] CPU: 0 PID: 1517 Comm: kunit_try_catch Tainted: G     U           N 6.1.0-rc2-drm-266703e6f163+ #14
[  316.827503] Hardware name: Intel Corporation Tiger Lake Client Platform/TigerLake Y LPDDR4x T4 Crb, BIOS TGLSFWI1.R00.3243.A01.2006102133 06/10/2020
[  316.828633] RIP: 0010:down_write_killable+0x50/0x110
[  316.829756] Code: 24 10 45 31 c9 31 c9 41 b8 01 00 00 00 31 d2 31 f6 48 89 ef e8 e1 74 4a ff bf 01 00 00 00 e8 87 d6 46 ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 13 0f 94 c0 5a 84 c0 74 62 8b 05 49 12 e4 00 85 c0 74
[  316.830896] RSP: 0018:ffffc90001eabc58 EFLAGS: 00010246
[  316.832008] RAX: 0000000000000000 RBX: 00000000000000e8 RCX: 0000000000000000
[  316.833141] RDX: 0000000000000001 RSI: ffffffff81c94fc9 RDI: ffffffff81c94fc9
[  316.834195] RBP: 0000000000000158 R08: 0000000000000001 R09: 0000000000000000
[  316.835231] R10: 0000000000000000 R11: ffff8883a13350b8 R12: 0000000000000002
[  316.836259] R13: 0000000000000001 R14: 0000000000100000 R15: 00000000000000e8
[  316.837237] FS:  0000000000000000(0000) GS:ffff8883a3800000(0000) knlGS:0000000000000000
[  316.838214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  316.839190] CR2: 00000000000000e8 CR3: 0000000002812003 CR4: 0000000000770ef0
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

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RFC v2 0/8] at: https://lore.kernel.org/all/cover.1667486144.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index add5ae56cd89..2c5f93e946b5 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -1845,6 +1845,11 @@ int i915_gem_mman_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_mmap_gpu),
 	};
 
+	if (!current->mm) {
+		pr_err("Test called without an user context!\n");
+		return -EINVAL;
+	}
+
 	return i915_live_subtests(tests, i915);
 }
 EXPORT_SYMBOL_NS_GPL(i915_gem_mman_live_selftests, I915_SELFTEST);
-- 
2.38.1

