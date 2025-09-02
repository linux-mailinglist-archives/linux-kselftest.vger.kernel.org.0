Return-Path: <linux-kselftest+bounces-40599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FBFB4018D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB8F1B257B9
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E92FE585;
	Tue,  2 Sep 2025 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d+sALJ8S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4C2D661C;
	Tue,  2 Sep 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817653; cv=none; b=mPMIO9YNUI9V5uGDLO/455wmA8xs7y5J2/ApJpCl59VEV2kmJf+ypfW9tQl3N6RfhJA+/U8USSjZQAlfGujLdz2G5ju+14PBdqn+KTUQRzRBO2xmF61HASEjnl3YOnIfp0mbL526DS70vW+pZCdcKRxZYk4hcM8FWr1AfgQRgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817653; c=relaxed/simple;
	bh=vJT5ZLX9e7deVZgnby32qRjIjwNqRba/sD5a493Ncm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIcgFTS8pbGkSw4zXzmQC5KAQ4SAnrL3FIwudChpBxIgBG0g6ROaisAlrF4hI6i92fUR3FK1lQy5Ll1JxWTikGKuxZ3pSXSPAIkACB09BQiZI9jO9WRxU8l/ma+FatKzi5GAxZsHqZu7Mkymnqo+f5elHou5QgxOWj0/mcQaW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d+sALJ8S; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 93E004E40BF7;
	Tue,  2 Sep 2025 12:54:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6B93E60695;
	Tue,  2 Sep 2025 12:54:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80CB11C228A5D;
	Tue,  2 Sep 2025 14:54:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756817649; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dYFkh04cJOkItcPhHP/10HIM2TJ3nn0Kgbf3aeQNBs4=;
	b=d+sALJ8SvNddste1IB1+gIrro4vCzMyJF0lOPP2oxWeIzA2HNZM2McxxiFnT7p16RXUbN/
	qQZLfkANbYdnZhoMCALB6dFnKI9MGYIr7RQYvTpSUR38BArtOnyFexZ36nHsEtDyDnNbFo
	QBsPZpZ/XGgv64TaTwQvSogkLckqAF4NkxVnC9WzFxayHCzLyLkQyc50BMZMFubfW14y3v
	ziTLyRaZ8kDKhtitMOfrH9eLAfwNskRX73ry0NWf/tEK0ifhqun/TiEKItBbqlwdWo4R37
	elkdOImHwwSZyGyQZFCNnKAMDlcnHsJCW8qHzLtwh7yJRvOvn+OzRh66HFb47A==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 02 Sep 2025 14:49:58 +0200
Subject: [PATCH bpf-next v2 08/14] selftests/bpf: test_xsk: Don't exit
 immediately when gettimeofday fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-xsk-v2-8-17c6345d5215@bootlin.com>
References: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
In-Reply-To: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
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
index 745ba0080ae0447bcfa07faf21559fbb9b42e76a..edc4236bdd319d396196bb672c6b15617d37b380 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1106,7 +1106,7 @@ static int receive_pkts(struct test_spec *test)
 
 	ret = gettimeofday(&tv_now, NULL);
 	if (ret)
-		exit_with_error(errno);
+		return TEST_FAILURE;
 
 	timeradd(&tv_now, &tv_timeout, &tv_end);
 
@@ -1122,7 +1122,7 @@ static int receive_pkts(struct test_spec *test)
 
 		ret = gettimeofday(&tv_now, NULL);
 		if (ret)
-			exit_with_error(errno);
+			return TEST_FAILURE;
 
 		if (timercmp(&tv_now, &tv_end, >)) {
 			ksft_print_msg("ERROR: [%s] Receive loop timed out\n", __func__);
@@ -1265,13 +1265,13 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 
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
2.50.1


