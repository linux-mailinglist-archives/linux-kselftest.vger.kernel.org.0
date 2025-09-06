Return-Path: <linux-kselftest+bounces-40897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD77B47753
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 23:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C348216DBB9
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 21:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5D299923;
	Sat,  6 Sep 2025 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1DZxSTp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC82957CD;
	Sat,  6 Sep 2025 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757193237; cv=none; b=DekMiq8L9MQ4b6sgwPXN/QlDCNIqHcZ/Q8nxteSQsYQSdXo8I8GB1DMYUO+gBScIiL+Sn3SjLLL+B2NM/ZFSOHiuH6ZAExXiYhOFpRl90vNPt3ny6KoYNu8OPOVXs2p+mu6xiNSSApSOFmPWNy37AAA5Kspy9T45lvCLdvxoKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757193237; c=relaxed/simple;
	bh=3IunjHgQNa9G1WtkXomBrlJVAd/AFFo29Ilr8xz0q58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHjldI/q/u2+Ardb2tJgac/nTliCq7NRJL1iI2tnLh7Y+dm7R/R/vdPUU2YElcTMoRRAn5loej8NPIbpHqWzydsJ8RrLYL5ku4b+ktTzjTUeevgqEBUV4enPw+ved0zRW6PSDVr8hQNRFJZBOdlB+bssIBHdnlsSVQMT/yFLqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1DZxSTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08E6C4CEF8;
	Sat,  6 Sep 2025 21:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757193237;
	bh=3IunjHgQNa9G1WtkXomBrlJVAd/AFFo29Ilr8xz0q58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1DZxSTplxxBHD7xy0ELPY/bLpPuCtE+Y1xUIKgddrv2kYxdiWPVEzaH8Wap+euoQ
	 GkIdmlVU+4WHbcPDV7jfqqllt3VVsTDH/9xLWBhoUNhBPd78zSvsAFzzD3YO4JfCYk
	 TXs5gdavhEFDCEBknej5ja/W3mt4LZ9cmGDr2GPR5DbH0JIrD+I1LLcPPgCZ+4i0PP
	 HizbME+o8PFlRvOFT7/lrTqKyM9xB1p7cVTIKsOWe36MvIHFM08Ct9zOq+us+kdeeX
	 QLgcsamdjBOJupu2YPjw7s1NNzTFdS65f+ksmvMu+G6XlhEVUEKLg3SQwliVsOh0P+
	 SbNj9hauqiSVQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests: net: move netlink-dumps back to progs
Date: Sat,  6 Sep 2025 14:13:51 -0700
Message-ID: <20250906211351.3192412-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250906211351.3192412-1-kuba@kernel.org>
References: <20250906211351.3192412-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9bb88c659673 ("selftests: net: test extacks in netlink dumps")
moved netlink-dumps from TEST_GEN_PROGS to YNL_GEN_FILES.
But _FILES are not for tests, rather for utilities / helpers.
Create YNL_GEN_PROGS and include netlink-dumps there.
This makes netlink-dumps part of executed tests, again.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/Makefile | 4 +++-
 tools/testing/selftests/net/ynl.mk   | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 9926a14fd279..8c860782f9cd 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -121,8 +121,10 @@ TEST_PROGS += ipv6_force_forwarding.sh
 TEST_PROGS += route_hint.sh
 
 # YNL files, must be before "include ..lib.mk"
-YNL_GEN_FILES := busy_poller netlink-dumps
+YNL_GEN_FILES := busy_poller
+YNL_GEN_PROGS := netlink-dumps
 TEST_GEN_FILES += $(YNL_GEN_FILES)
+TEST_GEN_PROGS += $(YNL_GEN_PROGS)
 
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh setup_loopback.sh setup_veth.sh
diff --git a/tools/testing/selftests/net/ynl.mk b/tools/testing/selftests/net/ynl.mk
index e907c2751956..793a2fc33d9f 100644
--- a/tools/testing/selftests/net/ynl.mk
+++ b/tools/testing/selftests/net/ynl.mk
@@ -5,10 +5,11 @@
 # Inputs:
 #
 # YNL_GENS:      families we need in the selftests
-# YNL_PROGS:     TEST_PROGS which need YNL (TODO, none exist, yet)
+# YNL_GEN_PROGS: TEST_GEN_PROGS which need YNL
 # YNL_GEN_FILES: TEST_GEN_FILES which need YNL
 
-YNL_OUTPUTS := $(patsubst %,$(OUTPUT)/%,$(YNL_GEN_FILES))
+YNL_OUTPUTS :=	$(patsubst %,$(OUTPUT)/%,$(YNL_GEN_FILES)) \
+		$(patsubst %,$(OUTPUT)/%,$(YNL_GEN_PROGS))
 YNL_SPECS := \
 	$(patsubst %,$(top_srcdir)/Documentation/netlink/specs/%.yaml,$(YNL_GENS))
 
-- 
2.51.0


