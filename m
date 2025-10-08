Return-Path: <linux-kselftest+bounces-42887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83343BC5A23
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6719419E37DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B706F2F60CD;
	Wed,  8 Oct 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YC9y+8g0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7534BA49;
	Wed,  8 Oct 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937505; cv=none; b=MDeZEKh8fOUmFXU57uQo+QUzCTO57DreQC4SCoIvgtpEv7fxQwlkx418pWB7kiCP6DCgkwEXEzJbq9fT91NmnZ8OKOu7/V+jOBzXcXmxfsyNShM+aaVNHssrNk+GBuEoubxK9Vu/f83ryseZkJh6/MgnL8ND04Tx5RBxYgRGOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937505; c=relaxed/simple;
	bh=uexBAi8abIyVlYVl6i70dggsyJY7YYcNKjpyad5zP5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALhmUxuuSWkZaF12NhYn7YBjqTpIMgzipVB3ptF5Ur/Ei8T3pWzGF0yF7AfMfd2X5fMelBu3ABvoqGOuArmk0wVbwdVJ6mi/k4SZQlRYu1GR3SoKgrdJWTT4g88l4uvVo2Q+Q/nXovaagjpT+EF3mINgVTqBf/b7c9S5DplDbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YC9y+8g0; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759937503; x=1791473503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HHo5PWe4LtvHDjkJQgFRKiGpts4xHP/caZrRDmAGqn0=;
  b=YC9y+8g0FGJcIj2lFLfMbOv8wkKCoVtyjmdCzVJ4pJr3kLQWfc7WDHk9
   GrO8QhQDH702tsck8MGOav3HfQR4gJ4SXm2ukkhLUPUwQJdHtYv0ntrWN
   lcUUO4OXjE4HyM780lOqs9L8g4UPiD667Za3A7cffdmFAUrAz1h2vLzST
   tTEBCbIV/PQeOxnWki9pdXLScCFiTEBfMby+QDR9tnzy9YadortPC4Vtp
   I5KLsgf/EkGKkRZqcLwNmVBzuofGhV7si2ptaXOa5y05Q8DBybVA5S5Tt
   vTJj5zgZ6KktuwnfnzCbVxDs6BNuhtXZapgSRZu1OnLkmsYJXVWFrK7ho
   A==;
X-CSE-ConnectionGUID: qOunANGnQdCOJtYflWxMdA==
X-CSE-MsgGUID: o8RG+11STU2/PSRYpbgbGw==
X-IronPort-AV: E=Sophos;i="6.19,213,1754956800"; 
   d="scan'208";a="4531225"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 15:31:41 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:52437]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.112:2525] with esmtp (Farcaster)
 id 1e7fe95c-108c-4ec7-ac08-fab91a63a8ba; Wed, 8 Oct 2025 15:31:41 +0000 (UTC)
X-Farcaster-Flow-ID: 1e7fe95c-108c-4ec7-ac08-fab91a63a8ba
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 8 Oct 2025 15:31:37 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Wed, 8 Oct 2025
 15:31:24 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <jdike@addtoit.com>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <qiuxu.zhuo@intel.com>, <james.morse@arm.com>,
	<rric@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robdclark@gmail.com>, <sean@poorly.run>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <linus.walleij@linaro.org>,
	<dmitry.torokhov@gmail.com>, <maz@kernel.org>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <agk@redhat.com>, <snitzer@redhat.com>,
	<dm-devel@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<mcoquelin.stm32@gmail.com>, <krzysztof.kozlowski@canonical.com>,
	<malattia@linux.it>, <hdegoede@redhat.com>, <mgross@linux.intel.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<sakari.ailus@linux.intel.com>, <clm@fb.com>, <josef@toxicpanda.com>,
	<dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <dushistov@mail.ru>,
	<luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <pmladek@suse.com>,
	<senozhatsky@chromium.org>, <andriy.shevchenko@linux.intel.com>,
	<linux@rasmusvillemoes.dk>, <minchan@kernel.org>, <ngupta@vflare.org>,
	<akpm@linux-foundation.org>, <yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>,
	<pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>,
	<jmaloy@redhat.com>, <ying.xue@windriver.com>, <shuah@kernel.org>,
	<willy@infradead.org>, <farbere@amazon.com>, <sashal@kernel.org>,
	<quic_akhilpo@quicinc.com>, <ruanjinjie@huawei.com>,
	<David.Laight@ACULAB.COM>, <herve.codina@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-um@lists.infradead.org>, <linux-edac@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
	<linux-hwmon@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<linux-sunxi@lists.linux.dev>, <linux-media@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-sparse@vger.kernel.org>,
	<linux-mm@kvack.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <tipc-discussion@lists.sourceforge.net>,
	<linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, David Laight
	<David.Laight@aculab.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v3 06/19 5.15.y] minmax: add a few more MIN_T/MAX_T users
Date: Wed, 8 Oct 2025 15:29:31 +0000
Message-ID: <20251008152946.29285-7-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251008152946.29285-1-farbere@amazon.com>
References: <20251008152946.29285-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 4477b39c32fdc03363affef4b11d48391e6dc9ff ]

Commit 3a7e02c040b1 ("minmax: avoid overly complicated constant
expressions in VM code") added the simpler MIN_T/MAX_T macros in order
to avoid some excessive expansion from the rather complicated regular
min/max macros.

The complexity of those macros stems from two issues:

 (a) trying to use them in situations that require a C constant
     expression (in static initializers and for array sizes)

 (b) the type sanity checking

and MIN_T/MAX_T avoids both of these issues.

Now, in the whole (long) discussion about all this, it was pointed out
that the whole type sanity checking is entirely unnecessary for
min_t/max_t which get a fixed type that the comparison is done in.

But that still leaves min_t/max_t unnecessarily complicated due to
worries about the C constant expression case.

However, it turns out that there really aren't very many cases that use
min_t/max_t for this, and we can just force-convert those.

This does exactly that.

Which in turn will then allow for much simpler implementations of
min_t()/max_t().  All the usual "macros in all upper case will evaluate
the arguments multiple times" rules apply.

We should do all the same things for the regular min/max() vs MIN/MAX()
cases, but that has the added complexity of various drivers defining
their own local versions of MIN/MAX, so that needs another level of
fixes first.

Link: https://lore.kernel.org/all/b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com/
Cc: David Laight <David.Laight@aculab.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V2 -> V3:
Fix fs/erofs/zdata.h to use MIN_T instead of min_t to fix build on the
following patch:
In file included from ./include/linux/kernel.h:16,
                 from ./include/linux/list.h:9,
                 from ./include/linux/wait.h:7,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from fs/erofs/internal.h:10,
                 from fs/erofs/zdata.h:9,
                 from fs/erofs/zdata.c:6:
fs/erofs/zdata.c: In function ‘z_erofs_decompress_pcluster’:
fs/erofs/zdata.h:185:61: error: ISO C90 forbids variable length array ‘pages_onstack’ [-Werror=vla]
  185 |         min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
      |                                                             ^~~~
./include/linux/minmax.h:49:23: note: in definition of macro ‘__cmp_once_unique’
   49 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
      |                       ^
./include/linux/minmax.h:164:27: note: in expansion of macro ‘__cmp_once’
  164 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
      |                           ^~~~~~~~~~
fs/erofs/zdata.h:185:9: note: in expansion of macro ‘min_t’
  185 |         min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
      |         ^~~~~
fs/erofs/zdata.c:847:36: note: in expansion of macro ‘Z_EROFS_VMAP_ONSTACK_PAGES’
  847 |         struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

V1 -> V2:
Use `[ Upstream commit <HASH> ]` instead of `commit <HASH> upstream.`
like in all other patches.

 arch/x86/mm/pgtable.c                             | 2 +-
 drivers/edac/sb_edac.c                            | 4 ++--
 drivers/gpu/drm/drm_color_mgmt.c                  | 2 +-
 drivers/md/dm-integrity.c                         | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 fs/erofs/zdata.h                                  | 2 +-
 net/ipv4/proc.c                                   | 2 +-
 net/ipv6/proc.c                                   | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..e649161eb6fc 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -107,7 +107,7 @@ static inline void pgd_list_del(pgd_t *pgd)
 #define UNSHARED_PTRS_PER_PGD				\
 	(SHARED_KERNEL_PMD ? KERNEL_PGD_BOUNDARY : PTRS_PER_PGD)
 #define MAX_UNSHARED_PTRS_PER_PGD			\
-	max_t(size_t, KERNEL_PGD_BOUNDARY, PTRS_PER_PGD)
+	MAX_T(size_t, KERNEL_PGD_BOUNDARY, PTRS_PER_PGD)
 
 
 static void pgd_set_mm(pgd_t *pgd, struct mm_struct *mm)
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 1522d4aa2ca6..714020e7405a 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -109,8 +109,8 @@ static const u32 knl_interleave_list[] = {
 	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
 };
 #define MAX_INTERLEAVE							\
-	(max_t(unsigned int, ARRAY_SIZE(sbridge_interleave_list),	\
-	       max_t(unsigned int, ARRAY_SIZE(ibridge_interleave_list),	\
+	(MAX_T(unsigned int, ARRAY_SIZE(sbridge_interleave_list),	\
+	       MAX_T(unsigned int, ARRAY_SIZE(ibridge_interleave_list),	\
 		     ARRAY_SIZE(knl_interleave_list))))
 
 struct interleave_pkg {
diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index bb14f488c8f6..1ff572d8744e 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -528,7 +528,7 @@ int drm_plane_create_color_properties(struct drm_plane *plane,
 {
 	struct drm_device *dev = plane->dev;
 	struct drm_property *prop;
-	struct drm_prop_enum_list enum_list[max_t(int, DRM_COLOR_ENCODING_MAX,
+	struct drm_prop_enum_list enum_list[MAX_T(int, DRM_COLOR_ENCODING_MAX,
 						       DRM_COLOR_RANGE_MAX)];
 	int i, len;
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index e9d553eea9cd..8e2b00536c3e 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2536,7 +2536,7 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned write_start,
 				    unlikely(from_replay) &&
 #endif
 				    ic->internal_hash) {
-					char test_tag[max_t(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
+					char test_tag[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, sec + ((l - j) << ic->sb->log2_sectors_per_block),
 								  (char *)access_journal_data(ic, i, l), test_tag);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2478caeec763..21cc8cd9e023 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2805,7 +2805,7 @@ static void stmmac_dma_interrupt(struct stmmac_priv *priv)
 	u32 channels_to_check = tx_channel_count > rx_channel_count ?
 				tx_channel_count : rx_channel_count;
 	u32 chan;
-	int status[max_t(u32, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES)];
+	int status[MAX_T(u32, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES)];
 
 	/* Make sure we never check beyond our status buffer. */
 	if (WARN_ON_ONCE(channels_to_check > ARRAY_SIZE(status)))
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 3a008f1b9f78..43876fd8a2cb 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -182,7 +182,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 }
 
 #define Z_EROFS_VMAP_ONSTACK_PAGES	\
-	min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
+	MIN_T(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
 #define Z_EROFS_VMAP_GLOBAL_PAGES	2048
 
 #endif
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 4b9280a3b673..d849f61b7519 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -43,7 +43,7 @@
 #include <net/sock.h>
 #include <net/raw.h>
 
-#define TCPUDP_MIB_MAX max_t(u32, UDP_MIB_MAX, TCP_MIB_MAX)
+#define TCPUDP_MIB_MAX MAX_T(u32, UDP_MIB_MAX, TCP_MIB_MAX)
 
 /*
  *	Report socket allocation statistics [mea@utu.fi]
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index d6306aa46bb1..e07c43bd5cb0 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -27,7 +27,7 @@
 #include <net/ipv6.h>
 
 #define MAX4(a, b, c, d) \
-	max_t(u32, max_t(u32, a, b), max_t(u32, c, d))
+	MAX_T(u32, MAX_T(u32, a, b), MAX_T(u32, c, d))
 #define SNMP_MIB_MAX MAX4(UDP_MIB_MAX, TCP_MIB_MAX, \
 			IPSTATS_MIB_MAX, ICMP_MIB_MAX)
 
-- 
2.47.3


