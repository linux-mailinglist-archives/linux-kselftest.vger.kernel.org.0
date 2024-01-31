Return-Path: <linux-kselftest+bounces-3898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00593844AB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC582910A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312BF3A1A8;
	Wed, 31 Jan 2024 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SLBTpbOa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CFC39AFD;
	Wed, 31 Jan 2024 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738690; cv=none; b=Z20sPkT940nCrIrSRLxtDZM/oJbtYIZHkrPTvNnZ4vGJFvCt+Uf+ES2X/lcgXGKmBVDasf45tr7wUZp4C/RxoYwzY4r7M1SEZXy0l2YPs5OZ1S03ZQ6243Q5FBfFzV9Ev1lpBu8VIpEXjbS4+VyLjQTZePO0UvhsjOBY8yg3UDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738690; c=relaxed/simple;
	bh=UlyYLaTBCOQnHnPC0g51OMnV2sy7LcHXFVG1g/sGiv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TX4dH5X6DpTPFt+ZIrdyBrkBqbrtusaAG7rwcKevK10jnMqeXgaNFPD/wR0ZDrTxXLSJqXQubbqnjJowPsFKXtGWGhtBSbeJYokhWZUiHQL5Vuwo+VcaGxvWXSx4IfRj/NjUcbGOUz5dWNGcCmdrazR05NtcoOkIjM0xU2OSu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SLBTpbOa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706738686;
	bh=UlyYLaTBCOQnHnPC0g51OMnV2sy7LcHXFVG1g/sGiv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SLBTpbOahFRgDA2g4UORL3cKOUb7KPhbu87Goi3Mk93GIealgJaJy5G0Q0997PkZw
	 Z+wtxdSPccPCdBfr9lp2WO3zYeNhR3m9I16lsbkAsyPxNUaIkgA6HDU0ryoBYCf3Dg
	 HLLud3FIU/VSAG4+I92ZmcTLMN9ddTrzQYHyVRlJNOMzzYR2x0N8g5+o21evSnSVlD
	 jL72fnOVoQKWsZnsoZ3vHtkxlvV06umziQXZY7Yxv+6jByUy5oonjhhe3K5Z2VMX7e
	 LHNvml6cC8XLZxbX1o3gKXQGuo3zSHJxxzEvnHum3Ey0vp5sTaEVjKe00iGC2nM7C5
	 j0UU2NiBUUxNA==
Received: from [192.168.1.211] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D0576378206F;
	Wed, 31 Jan 2024 22:04:45 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 31 Jan 2024 17:02:41 -0500
Subject: [PATCH 2/4] selftests: ktap_helpers: Add helper to pass/fail test
 based on exit code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-ktap-sh-helpers-extend-v1-2-98ffb468712c@collabora.com>
References: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
In-Reply-To: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
To: Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Similar to the C counterpart, add a helper function that runs a command
and passes or fails the test based on the result.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/kselftest/ktap_helpers.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index ecc1413c22cd..29107924f5c2 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -76,6 +76,17 @@ ktap_test_fail() {
 	KTAP_CNT_FAIL=$((KTAP_CNT_FAIL+1))
 }
 
+ktap_test_result() {
+	description="$1"
+	shift
+
+	if $@; then
+		ktap_test_pass "$description"
+	else
+		ktap_test_fail "$description"
+	fi
+}
+
 ktap_print_totals() {
 	echo "# Totals: pass:$KTAP_CNT_PASS fail:$KTAP_CNT_FAIL xfail:0 xpass:0 skip:$KTAP_CNT_SKIP error:0"
 }

-- 
2.43.0


