Return-Path: <linux-kselftest+bounces-42203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF801B9A604
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C9B1B274A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41989313281;
	Wed, 24 Sep 2025 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jOZzbbPh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6E3126A1
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725432; cv=none; b=oeTp3LMtyvboXQnqCmcvVn7rIn+7w/fe1JGvHCqmozrza9FsBi1cuIA0vXOmXIxBZkty2TuQsNtSOyEf/uzQgUUWrZICAZCTNlVYzQgm68w3ruDvguHsxnWFeCl1xfpbQS/+OKukHaRD0ccA/NPpSdknjXlzDrMw4S9g/WdfwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725432; c=relaxed/simple;
	bh=v4Hzeqdb7Z4hEux4t+JJgDM2laAqTJTu0/gQKSRMpIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMovjJ3Dz8XeEsIWXSA5fbXvxbI+atZK0xD6WIWKVHpny9+rgl1RLhAxFLIB4WrUoYaeIiWYcoLWpM2rO+r9z3z3NiugWaMdCqhXZU7hwEgJAhiJpw+BLXj6eIJu/7eOfgW1OQRD4iA/t2prfUa9rXu0MF1NW1CQ0Mgb9fUIP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jOZzbbPh; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E8D5D1A0F81;
	Wed, 24 Sep 2025 14:50:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE9DD60634;
	Wed, 24 Sep 2025 14:50:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31E5D102F1973;
	Wed, 24 Sep 2025 16:50:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758725427; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TK9L/dZGJ+Bzm/DsHznC4dwU9CdtNX9rrae1jJI01ds=;
	b=jOZzbbPhRLBxIB3iLegxUKAU6qJ02CoWyEszBFekwkike7c6Fb1yuONGw+w0l64OreZmh7
	ZQ2LFXlIskjwRaYui9An4O/ximJGy2xymlkKpwZl7+nfuf21C3CIQJGH7vLy0L3msLpDug
	fupHvVFxVFr0pWda8uGM7/K/hnljDNFb6WITWbViybxpjasx9ByIdXkGQUhr6ZT3v8ITbk
	Fm1odY2EQLw1Pcwq/C7tLm187FyOwBdKJ0B7hSZgoRtYZCKFioHsH+U+A7P7Nu8EHorGKE
	7+KAh8oMTmC3womKVIUgaJQ5fZMaoBjDEvXS0e5XU//RtarDAp63McSdeuVSqQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 24 Sep 2025 16:49:45 +0200
Subject: [PATCH bpf-next v4 10/15] selftests/bpf: test_xsk: Don't exit
 immediately when gettimeofday fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-xsk-v4-10-20e57537b876@bootlin.com>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
In-Reply-To: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
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


