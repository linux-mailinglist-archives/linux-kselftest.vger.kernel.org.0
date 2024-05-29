Return-Path: <linux-kselftest+bounces-10821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F137F8D2E0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 09:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F311C23BC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0933167264;
	Wed, 29 May 2024 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NPedPWJc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02066167260;
	Wed, 29 May 2024 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967553; cv=none; b=V9l7DqRy00Ix02M1i/An6mTCXgbR0Pqd7xhBMle9lefN8WLnPrfKxyXhHENmyknfDg+EWZlBoDjAELd2ABoWcEVSWryjmDzaVNYd7l0NbjgDGpclbcAZ3PNQAKlVSm/DSucmrVLYpTgQZ+Z38t3ywiHpqZad0gNPKm+N6XmsRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967553; c=relaxed/simple;
	bh=Rddsd8MhlvXyzWsz0mlMxYZ4iXWCAYvdf+LHczGrxWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rWFmPCs/hU9erKFEKUr+Tc2D8lSCa5lw/ptD0cDnS1Lro5OMBB+dvPvpS81tILEqdh+htJ1rPZDIxpnPwmcpshGyLMrdtK2AhOv4+FDBOTmI/68Wd4Lymgsi83yjdd8h+uhdIO5YALrl1GbzvkhJvt/+MQbsG4TfOMuhBl3SX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NPedPWJc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716967549;
	bh=Rddsd8MhlvXyzWsz0mlMxYZ4iXWCAYvdf+LHczGrxWg=;
	h=From:To:Cc:Subject:Date:From;
	b=NPedPWJcv+8ONEP6Fo0xmQRUklb/ltD3jRtAZyR+krWk6iAXC1up9LaxJ6Ehx+lLz
	 ffmLzB/r9B1ILro0gPmxCwomb3sse3hTtqwp3iHxZgIH4s3Bf0LFi5Ht6hQFq39ana
	 S0SN9QX/jmiBZzzaMU2bZyHQp+itWvCf3nVkHA6KMbH4GEcXjpr4SKo0IrtnaxQXuB
	 VBbx2M73L6HcX72Y8B1s9pPCMabAMW1vGuiReemnBHGoKsCP22ubR4pMCZUbMCFcoG
	 eA/YtLZA8IKpMPgaqavNEY0vnMt51C94ZQ3DFbfucr2JRyIYrcoRsZPcv4vxC+Q0Rb
	 jUmMFJid/S09w==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C10EE3780627;
	Wed, 29 May 2024 07:25:36 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 0/4] kselftests: vdso: conform tests to TAP output
Date: Wed, 29 May 2024 12:24:50 +0500
Message-Id: <20240529072454.2522495-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform individual tests to TAP output. One patch conform one test. With
this series, all vDSO tests become TAP conformant.

Muhammad Usama Anjum (4):
  kselftests: vdso: vdso_test_clock_getres: conform test to TAP output
  kselftests: vdso: vdso_test_correctness: conform test to TAP output
  kselftests: vdso: vdso_test_getcpu: conform test to TAP output
  kselftests: vdso: vdso_test_gettimeofday: conform test to TAP output

 .../selftests/vDSO/vdso_test_clock_getres.c   |  68 ++++----
 .../selftests/vDSO/vdso_test_correctness.c    | 146 +++++++++---------
 .../testing/selftests/vDSO/vdso_test_getcpu.c |  16 +-
 .../selftests/vDSO/vdso_test_gettimeofday.c   |  23 +--
 4 files changed, 126 insertions(+), 127 deletions(-)

-- 
2.39.2


