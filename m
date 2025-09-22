Return-Path: <linux-kselftest+bounces-42051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA996B90072
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 12:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3382A19D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4252FF17D;
	Mon, 22 Sep 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HZ8j1fpf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8A296BA2;
	Mon, 22 Sep 2025 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537200; cv=none; b=WcNmYeeiBf2QH4klzwLPh/Z0Zf6W3RvVI43XGYhGdlqRCf3pzPa94FeF65//3B/2kzKBbx9IKX68w9i1nEV5gpZJC4DqOz4TwcGWJ9z3bcqzl03Q8a9t2hQ+vkE3+3Ro8jMGy2+VsATrLPH4CuY66Ez6/6XvK8sQXt1qYoQ4Yq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537200; c=relaxed/simple;
	bh=PixZFZmWcKwq1euE7Zl54sLIl2MpNNci4XMpny8p56I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dbll3C/6sB+F8s9awBYBVHf1wumV620DbPw0qNjZ6QAqgrFYkVD3wWUGdGtEkkCMRUtzy4JJDHEeSFX4KJfSRpzpV55ZxA9Z8WJKKEcYX+fiScuruph2mOkqylAE3zvf2oPatYgoOCiNbw2SHyCkVlW08Hsm/A4jJxr1F3RG/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HZ8j1fpf; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758537198; x=1790073198;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zVSnvTXkXiuh+OW/uVNUL4x1ADt15TY9E6leiyfAL50=;
  b=HZ8j1fpfp/NtePMdMaW0FcYOCEYlQQp0vb3mDknGOZpJnZIPkI5bE+TV
   fRzVPNGgZ2WU2PgI9wUgC136V/fTJTxHh4EOuRhKg3CJzo7t7FV1nIPZO
   F6hVzIw41izSt/kSYjXqBxBzX5wRRf9MIzOzM+j/QWSbwWS12XeiT4CYe
   Og0hpgkknNDbR6ZsmvhBz5/uovypzqA/wwGS6y3+JjW/7M/twEREgeuip
   +f3oN6Y/kPEBCPVCLDTSBHdosI1RdpKd9QnWw+x2o+CFSJargqxrCTsKv
   2JRLXxSOGxEr2xvROnRI14veGIhsUpdHbL00gDjgdi4xS1qFLW3BVazNS
   g==;
X-CSE-ConnectionGUID: SA7Bpc9VQgG1HmOijFiFuw==
X-CSE-MsgGUID: 7eapTz9/SuG/x2ufntC2mg==
X-IronPort-AV: E=Sophos;i="6.18,284,1751241600"; 
   d="scan'208";a="2478632"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 10:33:14 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:4640]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.10.226:2525] with esmtp (Farcaster)
 id c0c65c16-13cf-4fa2-a5a8-1f23642ff95a; Mon, 22 Sep 2025 10:33:14 +0000 (UTC)
X-Farcaster-Flow-ID: c0c65c16-13cf-4fa2-a5a8-1f23642ff95a
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 10:33:13 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 22 Sep 2025
 10:32:49 +0000
From: Eliav Farber <farbere@amazon.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <qiuxu.zhuo@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>, <harry.wentland@amd.com>,
	<sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>,
	<alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<evan.quan@amd.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <jdelvare@suse.com>,
	<linux@roeck-us.net>, <linus.walleij@linaro.org>,
	<dmitry.torokhov@gmail.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <agk@redhat.com>, <snitzer@kernel.org>,
	<dm-devel@lists.linux.dev>, <mailhol.vincent@wanadoo.fr>,
	<wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<mcoquelin.stm32@gmail.com>, <krzysztof.kozlowski@linaro.org>,
	<malattia@linux.it>, <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<markgross@kernel.org>, <artur.paszkiewicz@intel.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <sakari.ailus@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <clm@fb.com>, <josef@toxicpanda.com>,
	<dsterba@suse.com>, <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <pmladek@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
	<senozhatsky@chromium.org>, <minchan@kernel.org>,
	<akpm@linux-foundation.org>, <dsahern@kernel.org>, <shuah@kernel.org>,
	<keescook@chromium.org>, <wad@chromium.org>, <farbere@amazon.com>,
	<David.Laight@ACULAB.COM>, <arnd@kernel.org>, <linux-um@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-hwmon@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-media@vger.kernel.org>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>,
	<linux-sparse@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	<bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 00/15 v6.6.y] Backport minmax.h updates from v6.17-rc7
Date: Mon, 22 Sep 2025 10:32:26 +0000
Message-ID: <20250922103241.16213-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

This series backports 15 patches to update minmax.h in the 6.6.y branch,
aligning it with v6.17-rc7.

The ultimate goal is to synchronize all longterm branches so that they
include the full set of minmax.h changes.

The key motivation is to bring in commit d03eba99f5bf ("minmax: allow
min()/max()/clamp() if the arguments have the same signedness"), which
is missing in older kernels.

In mainline, this change enables min()/max()/clamp() to accept mixed
argument types, provided both have the same signedness. Without it,
backported patches that use these forms may trigger compiler warnings,
which escalate to build failures when -Werror is enabled.

David Laight (7):
  minmax.h: add whitespace around operators and after commas
  minmax.h: update some comments
  minmax.h: reduce the #define expansion of min(), max() and clamp()
  minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
  minmax.h: move all the clamp() definitions after the min/max() ones
  minmax.h: simplify the variants of clamp()
  minmax.h: remove some #defines that are only expanded once

Linus Torvalds (8):
  minmax: avoid overly complicated constant expressions in VM code
  minmax: simplify and clarify min_t()/max_t() implementation
  minmax: add a few more MIN_T/MAX_T users
  minmax: make generic MIN() and MAX() macros available everywhere
  minmax: simplify min()/max()/clamp() implementation
  minmax: don't use max() in situations that want a C constant
    expression
  minmax: improve macro expansion and type checking
  minmax: fix up min3() and max3() too

 arch/um/drivers/mconsole_user.c               |   2 +
 arch/x86/mm/pgtable.c                         |   2 +-
 drivers/edac/sb_edac.c                        |   4 +-
 drivers/edac/skx_common.h                     |   1 -
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   2 +
 .../drm/amd/pm/powerplay/hwmgr/ppevvmath.h    |  14 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   2 +-
 drivers/gpu/drm/drm_color_mgmt.c              |   2 +-
 drivers/gpu/drm/radeon/evergreen_cs.c         |   2 +
 drivers/hwmon/adt7475.c                       |  24 +-
 drivers/input/touchscreen/cyttsp4_core.c      |   2 +-
 drivers/irqchip/irq-sun6i-r.c                 |   2 +-
 drivers/md/dm-integrity.c                     |   6 +-
 drivers/media/dvb-frontends/stv0367_priv.h    |   3 +
 .../net/can/usb/etas_es58x/es58x_devlink.c    |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 drivers/net/fjes/fjes_main.c                  |   4 +-
 drivers/nfc/pn544/i2c.c                       |   2 -
 drivers/platform/x86/sony-laptop.c            |   1 -
 drivers/scsi/isci/init.c                      |   6 +-
 .../pci/hive_isp_css_include/math_support.h   |   5 -
 fs/btrfs/tree-checker.c                       |   2 +-
 include/linux/compiler.h                      |   9 +
 include/linux/minmax.h                        | 228 +++++++++++-------
 include/linux/pageblock-flags.h               |   2 +-
 kernel/trace/preemptirq_delay_test.c          |   2 -
 lib/btree.c                                   |   1 -
 lib/decompress_unlzma.c                       |   2 +
 lib/vsprintf.c                                |   2 +-
 mm/zsmalloc.c                                 |   2 -
 net/ipv4/proc.c                               |   2 +-
 net/ipv6/proc.c                               |   2 +-
 tools/testing/selftests/mm/mremap_test.c      |   2 +
 tools/testing/selftests/seccomp/seccomp_bpf.c |   2 +
 34 files changed, 202 insertions(+), 146 deletions(-)

-- 
2.47.3


