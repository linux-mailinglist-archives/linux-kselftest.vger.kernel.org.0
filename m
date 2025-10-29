Return-Path: <linux-kselftest+bounces-44290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B216EC1B1DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487421B21F5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649B034FF60;
	Wed, 29 Oct 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mkw+i2le"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81A34F47B;
	Wed, 29 Oct 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745990; cv=none; b=noZ+QnnkkwcnWbN3pEtdfWzK9WXy2IJ3GkpTeZ1R5vNJ1AE/cZ5QhHEYVvtkl8ncksm0Za2imE72xFZQb/qLwvNPOLDgL05I3Vlg5oeejn3hCwk5MmJVhufkNH+AnbLr9KN8dFPk1U24LgmV7G7RlevxzQbdytDf8zAJxXK+Rwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745990; c=relaxed/simple;
	bh=hDnlp3LMVT5loeyAzRD7285zejpH1G4epoBItAK9wjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h4fs2g4KS4ak7yAxcKsgTpUQC3xDK22+yDM7qN3X5k0Em0iXX9m2Khi+7A9vWETYkfLhgB0ne488fhzJ7Q0qHvZkS4PXHtNIlYw/2dUVnOuFtv3jWb6TZoynWwLuWTyANqqn3JCmKNfNa7unlxM+TQ7gCM5G00jeu7Dm19AN4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mkw+i2le; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BCCE31A1749;
	Wed, 29 Oct 2025 13:53:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90B62606E8;
	Wed, 29 Oct 2025 13:53:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 877D1117F80F1;
	Wed, 29 Oct 2025 14:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761745983; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/3LXUnTxSB4ddUvvxQJiiPX2Yasi5zJ4vq9VaVwuag8=;
	b=Mkw+i2leTvDRCiM+jVMSVzMM3cktZ3dmNa+DLhVIRB5OfwopaGNAaYRcYTbQrMtLY54FIo
	fsRPRMKX3BXV9PltUpPudRdOtmWapqLkFX288Xc6wR+zkFCQ/PZ20y5XPpLsKmi5DBGsmd
	Ec9LyWvpoM9jCwfYlIseGlimJIJ+59WgiC3acc7bwdOTrJ1gS+fisCQ1GNTnEBkLiVRGYd
	cOwbkagt39BXXjRFNIB0ZFNbHIg1htmS6n+IoTj761IBWhsRpqnKLkN2SW96+2pxEycQCe
	iaE6G/lZSuRNoFv/uowlsUA35cVjAD4N7P3vGrsd6vvbjMWxyZgz/AJ7Mior3g==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 29 Oct 2025 14:52:31 +0100
Subject: [PATCH bpf-next v6 10/15] selftests/bpf: test_xsk: Don't exit
 immediately when gettimeofday fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-xsk-v6-10-5a63a64dff98@bootlin.com>
References: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
In-Reply-To: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

exit_with_error() is called when gettimeofday() fails. This exits the
program immediately. It prevents the following tests from being run and
isn't compliant with the CI.

Return TEST_FAILURE instead of calling exit_on_error().

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 0adb6c0b948f6216b24d0562bcda26097dbb9dbc..2c955e1099439c377cd28f5a9be2a17e65d49f78 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1096,7 +1096,7 @@ static int receive_pkts(struct test_spec *test)
 
 	ret = gettimeofday(&tv_now, NULL);
 	if (ret)
-		exit_with_error(errno);
+		return TEST_FAILURE;
 
 	timeradd(&tv_now, &tv_timeout, &tv_end);
 
@@ -1112,7 +1112,7 @@ static int receive_pkts(struct test_spec *test)
 
 		ret = gettimeofday(&tv_now, NULL);
 		if (ret)
-			exit_with_error(errno);
+			return TEST_FAILURE;
 
 		if (timercmp(&tv_now, &tv_end, >)) {
 			ksft_print_msg("ERROR: [%s] Receive loop timed out\n", __func__);
@@ -1255,13 +1255,13 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 
 	ret = gettimeofday(&tv_now, NULL);
 	if (ret)
-		exit_with_error(errno);
+		return TEST_FAILURE;
 	timeradd(&tv_now, &tv_timeout, &tv_end);
 
 	while (xsk->outstanding_tx) {
 		ret = gettimeofday(&tv_now, NULL);
 		if (ret)
-			exit_with_error(errno);
+			return TEST_FAILURE;
 		if (timercmp(&tv_now, &tv_end, >)) {
 			ksft_print_msg("ERROR: [%s] Transmission loop timed out\n", __func__);
 			return TEST_FAILURE;

-- 
2.51.0


