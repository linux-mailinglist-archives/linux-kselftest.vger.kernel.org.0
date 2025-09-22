Return-Path: <linux-kselftest+bounces-42055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B38B90134
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 12:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740EC7B1303
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D548301003;
	Mon, 22 Sep 2025 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="W3NhVsS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.75.33.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A32FFDD7;
	Mon, 22 Sep 2025 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.75.33.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537321; cv=none; b=FQUlmpiVGzom2ikzhaU1QxDxSnvRX1iy+H87BvMopabD/WZ3YHvRfEhNwlaWTIfu6UXJoCFAxMr5qASnG2vDO+UABbkN5UrliEi3eF8UQwIVdVsCVOF/XDYWJeD4x3q4yIle5+nMb8djqD+TNBApBvI/A78sDKkSYwZF7fXk0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537321; c=relaxed/simple;
	bh=hcoduC9SuwdSny6Q7RdFdZcmeAvlu0OBCGvWRfPVdKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVIyunyKWh9V5x2uKEZBZpB5oDQVVuzEROhcHzUTOqpeixykF76vFZH5Q6YXJD5C9onda1Ck3chlCrziGSp0Md5EgUeJms+APcSKKr8kqamGMzDdLrOdVjCpUphoc5IaYcSr+8t+KBIwMKjGuacLVA1hT49/rvVjX6vws/LxbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=W3NhVsS4; arc=none smtp.client-ip=3.75.33.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758537318; x=1790073318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tTfrH7Se5iJWwpFSYeUhPMKUM+uiwvsIpMu8S6rA7S8=;
  b=W3NhVsS47MSnnqAn9qu0EInfIi3LHW5ptudjP5Q3k2RoGZucQGEr7d1C
   9LaLr068nopf+cZ07IfhmqAljoe6r6Xx5m9uUk9iSBwG2gvfiHaUUAYra
   u76xlbtKISIPhHnTJTmcwI9rCkq9N86RJLKIk9Wc5DtfJLPHq3oZwbe+H
   91v7mG9kZdrtZ3/5oBvg2BUdjD1b+bhlJ6Iv3g2hOanaj+zQx7PVZgTs5
   C4V0/wq531GYw1MOAmQg3weOLZa+AbciGALWhwED+QSXTwwwH6V10HkH5
   KYzGjF8JoskPomyKPR1YWEFk3XC5qVpcJmsk0llIKSwZnsvE9I7ozFmE0
   Q==;
X-CSE-ConnectionGUID: whGf3uX4QI+nszMTRs0+7g==
X-CSE-MsgGUID: 6Gvlx0A3SUKp/eeipI9VrA==
X-IronPort-AV: E=Sophos;i="6.18,284,1751241600"; 
   d="scan'208";a="2479048"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 10:35:14 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:17697]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.64:2525] with esmtp (Farcaster)
 id b00c1c88-5f9a-48ae-8030-ef5b69eb574d; Mon, 22 Sep 2025 10:35:14 +0000 (UTC)
X-Farcaster-Flow-ID: b00c1c88-5f9a-48ae-8030-ef5b69eb574d
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 10:35:13 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 22 Sep 2025
 10:34:47 +0000
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
CC: Linus Torvalds <torvalds@linux-foundation.org>, David Laight
	<David.Laight@aculab.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH 04/15 6.6.y] minmax: make generic MIN() and MAX() macros available everywhere
Date: Mon, 22 Sep 2025 10:32:30 +0000
Message-ID: <20250922103241.16213-5-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922103241.16213-1-farbere@amazon.com>
References: <20250922103241.16213-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 1a251f52cfdc417c84411a056bc142cbd77baef4 ]

This just standardizes the use of MIN() and MAX() macros, with the very
traditional semantics.  The goal is to use these for C constant
expressions and for top-level / static initializers, and so be able to
simplify the min()/max() macros.

These macro names were used by various kernel code - they are very
traditional, after all - and all such users have been fixed up, with a
few different approaches:

 - trivial duplicated macro definitions have been removed

   Note that 'trivial' here means that it's obviously kernel code that
   already included all the major kernel headers, and thus gets the new
   generic MIN/MAX macros automatically.

 - non-trivial duplicated macro definitions are guarded with #ifndef

   This is the "yes, they define their own versions, but no, the include
   situation is not entirely obvious, and maybe they don't get the
   generic version automatically" case.

 - strange use case #1

   A couple of drivers decided that the way they want to describe their
   versioning is with

	#define MAJ 1
	#define MIN 2
	#define DRV_VERSION __stringify(MAJ) "." __stringify(MIN)

   which adds zero value and I just did my Alexander the Great
   impersonation, and rewrote that pointless Gordian knot as

	#define DRV_VERSION "1.2"

   instead.

 - strange use case #2

   A couple of drivers thought that it's a good idea to have a random
   'MIN' or 'MAX' define for a value or index into a table, rather than
   the traditional macro that takes arguments.

   These values were re-written as C enum's instead. The new
   function-line macros only expand when followed by an open
   parenthesis, and thus don't clash with enum use.

Happily, there weren't really all that many of these cases, and a lot of
users already had the pattern of using '#ifndef' guarding (or in one
case just using '#undef MIN') before defining their own private version
that does the same thing. I left such cases alone.

Cc: David Laight <David.Laight@aculab.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 arch/um/drivers/mconsole_user.c               |  2 ++
 drivers/edac/skx_common.h                     |  1 -
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |  2 ++
 .../drm/amd/pm/powerplay/hwmgr/ppevvmath.h    | 14 +++++++----
 drivers/gpu/drm/radeon/evergreen_cs.c         |  2 ++
 drivers/hwmon/adt7475.c                       | 24 +++++++++----------
 drivers/media/dvb-frontends/stv0367_priv.h    |  3 +++
 drivers/net/fjes/fjes_main.c                  |  4 +---
 drivers/nfc/pn544/i2c.c                       |  2 --
 drivers/platform/x86/sony-laptop.c            |  1 -
 drivers/scsi/isci/init.c                      |  6 +----
 .../pci/hive_isp_css_include/math_support.h   |  5 ----
 include/linux/minmax.h                        |  2 ++
 kernel/trace/preemptirq_delay_test.c          |  2 --
 lib/btree.c                                   |  1 -
 lib/decompress_unlzma.c                       |  2 ++
 mm/zsmalloc.c                                 |  2 --
 tools/testing/selftests/mm/mremap_test.c      |  2 ++
 tools/testing/selftests/seccomp/seccomp_bpf.c |  2 ++
 19 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/arch/um/drivers/mconsole_user.c b/arch/um/drivers/mconsole_user.c
index e24298a734be..a04cd13c6315 100644
--- a/arch/um/drivers/mconsole_user.c
+++ b/arch/um/drivers/mconsole_user.c
@@ -71,7 +71,9 @@ static struct mconsole_command *mconsole_parse(struct mc_request *req)
 	return NULL;
 }
 
+#ifndef MIN
 #define MIN(a,b) ((a)<(b) ? (a):(b))
+#endif
 
 #define STRINGX(x) #x
 #define STRING(x) STRINGX(x)
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 2ea4d1d1fbef..1fa31a6fdfcd 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -45,7 +45,6 @@
 #define I10NM_NUM_CHANNELS	MAX(I10NM_NUM_DDR_CHANNELS, I10NM_NUM_HBM_CHANNELS)
 #define I10NM_NUM_DIMMS		MAX(I10NM_NUM_DDR_DIMMS, I10NM_NUM_HBM_DIMMS)
 
-#define MAX(a, b)	((a) > (b) ? (a) : (b))
 #define NUM_IMC		MAX(SKX_NUM_IMC, I10NM_NUM_IMC)
 #define NUM_CHANNELS	MAX(SKX_NUM_CHANNELS, I10NM_NUM_CHANNELS)
 #define NUM_DIMMS	MAX(SKX_NUM_DIMMS, I10NM_NUM_DIMMS)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 1b2df97226a3..40286e8dd4e1 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -25,7 +25,9 @@
 
 #include "hdcp.h"
 
+#ifndef MIN
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
 #define HDCP_I2C_ADDR 0x3a	/* 0x74 >> 1*/
 #define KSV_READ_SIZE 0xf	/* 0x6803b - 0x6802c */
 #define HDCP_MAX_AUX_TRANSACTION_SIZE 16
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
index 6f54c410c2f9..409aeec6baa9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
@@ -22,12 +22,18 @@
  */
 #include <asm/div64.h>
 
-#define SHIFT_AMOUNT 16 /* We multiply all original integers with 2^SHIFT_AMOUNT to get the fInt representation */
+enum ppevvmath_constants {
+	/* We multiply all original integers with 2^SHIFT_AMOUNT to get the fInt representation */
+	SHIFT_AMOUNT	= 16,
 
-#define PRECISION 5 /* Change this value to change the number of decimal places in the final output - 5 is a good default */
+	/* Change this value to change the number of decimal places in the final output - 5 is a good default */
+	PRECISION	=  5,
 
-#define SHIFTED_2 (2 << SHIFT_AMOUNT)
-#define MAX (1 << (SHIFT_AMOUNT - 1)) - 1 /* 32767 - Might change in the future */
+	SHIFTED_2	= (2 << SHIFT_AMOUNT),
+
+	/* 32767 - Might change in the future */
+	MAX		= (1 << (SHIFT_AMOUNT - 1)) - 1,
+};
 
 /* -------------------------------------------------------------------------------
  * NEW TYPE - fINT
diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 820c2c3641d3..1311f10fad66 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -33,8 +33,10 @@
 #include "evergreen_reg_safe.h"
 #include "cayman_reg_safe.h"
 
+#ifndef MIN
 #define MAX(a,b)                   (((a)>(b))?(a):(b))
 #define MIN(a,b)                   (((a)<(b))?(a):(b))
+#endif
 
 #define REG_SAFE_BM_SIZE ARRAY_SIZE(evergreen_reg_safe_bm)
 
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 14b2547adae8..ce0ab4e4e41a 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -22,23 +22,23 @@
 #include <linux/util_macros.h>
 
 /* Indexes for the sysfs hooks */
-
-#define INPUT		0
-#define MIN		1
-#define MAX		2
-#define CONTROL		3
-#define OFFSET		3
-#define AUTOMIN		4
-#define THERM		5
-#define HYSTERSIS	6
-
+enum adt_sysfs_id {
+	INPUT		= 0,
+	MIN		= 1,
+	MAX		= 2,
+	CONTROL		= 3,
+	OFFSET		= 3,	// Dup
+	AUTOMIN		= 4,
+	THERM		= 5,
+	HYSTERSIS	= 6,
 /*
  * These are unique identifiers for the sysfs functions - unlike the
  * numbers above, these are not also indexes into an array
  */
+	ALARM		= 9,
+	FAULT		= 10,
+};
 
-#define ALARM		9
-#define FAULT		10
 
 /* 7475 Common Registers */
 
diff --git a/drivers/media/dvb-frontends/stv0367_priv.h b/drivers/media/dvb-frontends/stv0367_priv.h
index 617f605947b2..7f056d1cce82 100644
--- a/drivers/media/dvb-frontends/stv0367_priv.h
+++ b/drivers/media/dvb-frontends/stv0367_priv.h
@@ -25,8 +25,11 @@
 #endif
 
 /* MACRO definitions */
+#ifndef MIN
 #define MAX(X, Y) ((X) >= (Y) ? (X) : (Y))
 #define MIN(X, Y) ((X) <= (Y) ? (X) : (Y))
+#endif
+
 #define INRANGE(X, Y, Z) \
 	((((X) <= (Y)) && ((Y) <= (Z))) || \
 	(((Z) <= (Y)) && ((Y) <= (X))) ? 1 : 0)
diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 2513be6d4e11..cfcf0f7d9d90 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -14,9 +14,7 @@
 #include "fjes.h"
 #include "fjes_trace.h"
 
-#define MAJ 1
-#define MIN 2
-#define DRV_VERSION __stringify(MAJ) "." __stringify(MIN)
+#define DRV_VERSION "1.2"
 #define DRV_NAME	"fjes"
 char fjes_driver_name[] = DRV_NAME;
 char fjes_driver_version[] = DRV_VERSION;
diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index 3f6d74832bac..be566ca7bae9 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -126,8 +126,6 @@ struct pn544_i2c_fw_secure_blob {
 #define PN544_FW_CMD_RESULT_COMMAND_REJECTED 0xE0
 #define PN544_FW_CMD_RESULT_CHUNK_ERROR 0xE6
 
-#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
-
 #define PN544_FW_WRITE_BUFFER_MAX_LEN 0x9f7
 #define PN544_FW_I2C_MAX_PAYLOAD PN544_HCI_I2C_LLC_MAX_SIZE
 #define PN544_FW_I2C_WRITE_FRAME_HEADER_LEN 8
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 9569f11dec8c..bd7323cf9a97 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -757,7 +757,6 @@ static union acpi_object *__call_snc_method(acpi_handle handle, char *method,
 	return result;
 }
 
-#define MIN(a, b)	(a > b ? b : a)
 static int sony_nc_buffer_call(acpi_handle handle, char *name, u64 *value,
 		void *buffer, size_t buflen)
 {
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 6277162a028b..6eefa7e5f4cf 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -65,11 +65,7 @@
 #include "task.h"
 #include "probe_roms.h"
 
-#define MAJ 1
-#define MIN 2
-#define BUILD 0
-#define DRV_VERSION __stringify(MAJ) "." __stringify(MIN) "." \
-	__stringify(BUILD)
+#define DRV_VERSION "1.2.0"
 
 MODULE_VERSION(DRV_VERSION);
 
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
index a444ec14ff9d..1c17a87a8572 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
@@ -31,11 +31,6 @@
 /* A => B */
 #define IMPLIES(a, b)        (!(a) || (b))
 
-/* for preprocessor and array sizing use MIN and MAX
-   otherwise use min and max */
-#define MAX(a, b)            (((a) > (b)) ? (a) : (b))
-#define MIN(a, b)            (((a) < (b)) ? (a) : (b))
-
 #define ROUND_DIV(a, b)      (((b) != 0) ? ((a) + ((b) >> 1)) / (b) : 0)
 #define CEIL_DIV(a, b)       (((b) != 0) ? ((a) + (b) - 1) / (b) : 0)
 #define CEIL_MUL(a, b)       (CEIL_DIV(a, b) * (b))
diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 9c2848abc804..fc384714da45 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -277,6 +277,8 @@ static inline bool in_range32(u32 val, u32 start, u32 len)
  * Use these carefully: no type checking, and uses the arguments
  * multiple times. Use for obvious constants only.
  */
+#define MIN(a,b) __cmp(min,a,b)
+#define MAX(a,b) __cmp(max,a,b)
 #define MIN_T(type,a,b) __cmp(min,(type)(a),(type)(b))
 #define MAX_T(type,a,b) __cmp(max,(type)(a),(type)(b))
 
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 8af92dbe98f0..acb0c971a408 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -34,8 +34,6 @@ MODULE_PARM_DESC(cpu_affinity, "Cpu num test is running on");
 
 static struct completion done;
 
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-
 static void busy_wait(ulong time)
 {
 	u64 start, end;
diff --git a/lib/btree.c b/lib/btree.c
index 49420cae3a83..bb81d3393ac5 100644
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -43,7 +43,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
 #define NODESIZE MAX(L1_CACHE_BYTES, 128)
 
 struct btree_geo {
diff --git a/lib/decompress_unlzma.c b/lib/decompress_unlzma.c
index 20a858031f12..9d34d35908da 100644
--- a/lib/decompress_unlzma.c
+++ b/lib/decompress_unlzma.c
@@ -37,7 +37,9 @@
 
 #include <linux/decompress/mm.h>
 
+#ifndef MIN
 #define	MIN(a, b) (((a) < (b)) ? (a) : (b))
+#endif
 
 static long long INIT read_int(unsigned char *ptr, int size)
 {
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c82070167d8a..14327fc34aa7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -119,8 +119,6 @@
 #define ISOLATED_BITS	5
 #define MAGIC_VAL_BITS	8
 
-#define MAX(a, b) ((a) >= (b) ? (a) : (b))
-
 #define ZS_MAX_PAGES_PER_ZSPAGE	(_AC(CONFIG_ZSMALLOC_CHAIN_SIZE, UL))
 
 /* ZS_MIN_ALLOC_SIZE must be multiple of ZS_ALIGN */
diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5c3773de9f0f..944645f9d2b3 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -22,7 +22,9 @@
 #define VALIDATION_DEFAULT_THRESHOLD 4	/* 4MB */
 #define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
 
+#ifndef MIN
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
 
 struct config {
 	unsigned long long src_alignment;
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 15325ca35f1e..4390965c84c4 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -60,7 +60,9 @@
 #define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
 #endif
 
+#ifndef MIN
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
 
 #ifndef PR_SET_PTRACER
 # define PR_SET_PTRACER 0x59616d61
-- 
2.47.3


