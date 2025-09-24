Return-Path: <linux-kselftest+bounces-42205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D94B9A616
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5211B26C05
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DD5313E1C;
	Wed, 24 Sep 2025 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VQJPzBgv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB530B53B;
	Wed, 24 Sep 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725437; cv=none; b=p6OqsOHuPq08PfN2bHi/BrthxFvjLhEDlo7qHxd104xEV9eJYnyQlsVZ5Jl1NZcJuhM/Lm78WwFngPQSIBAwzjI5d/zyYM6Lhggu4q4qi2ygZ3LIDuNvAEXlhGdMa94ZapL4VNIh6CIKAAtlSne4au3OxJrrS8pJqkx1Y5Hvzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725437; c=relaxed/simple;
	bh=13mlIcN22MoVBJKPQYpDZafSJMWRWUcz6N9AWEC0wKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9cT+avrbCeVErSX9Ppx1oGXyMu1vmmOsGbAPAnLhobSF+/Op52pku3AkaMRLQIG7G6NeGf7MgPhwYrRuh0mbHPyrVZbSK+z7J5EQudUm3AqZ9AeC9pcETG5KodjT/Jbd0fq94bmgXwYgKZ2FSdOX0MF2qOf/k2FJ3jU4KV+9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VQJPzBgv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 03ABD4E40D4B;
	Wed, 24 Sep 2025 14:50:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD51F60634;
	Wed, 24 Sep 2025 14:50:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E0E4102F1975;
	Wed, 24 Sep 2025 16:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758725432; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PtAOV6pl4nR4Ob8glEmR2K44VxFkck1hyOMiXeH+b3c=;
	b=VQJPzBgvQGaP9GkqafObH4o7S1iYAr/AngpKrnDjjsoo0BIG6rGmM8Wps8LxYBleKC6k6P
	U7DxWoPxR/feEp97HdF4IB7Mtgr5XyhsiMZtEHcdpUJx3Pq/WD2zo9jHGZkdrAMNbdRVXk
	tHBa4dSiE1DhhJaa9BygaFtmtfrVj6ff6N1ficIBz2w8BJ+aCRUqCS9+RviBgfQmjTyHr1
	/z5DiNAOfgpPOM5N+ReJtK6ozGooei40MtbfNONZcqj8AUIE/lAgxrmOQb9F7z8aeeLBFY
	N0g5RONxv9TJLT+3yy97bxwd0fUrKk85G4Yp15s+Cn/kjXgGOBpuyFxIRPlEGw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 24 Sep 2025 16:49:47 +0200
Subject: [PATCH bpf-next v4 12/15] selftests/bpf: test_xsk: Don't exit
 immediately if validate_traffic fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-xsk-v4-12-20e57537b876@bootlin.com>
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

__testapp_validate_traffic() calls exit_with_error() on failures. This
exits the program immediately. It prevents the following tests from
running and isn't compliant with the CI.

Return TEST_FAILURE instead of calling exit_with_error().
Release the resource of the 1st thread if a failure happens between its
creation and the creation of the second thread.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 2c392d5b9f30145cf7b0ea8a49990f1673bef6c9..18a6ce648461de1975aa25997a22c77cecb97a76 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1772,12 +1772,12 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 	err = test_spec_set_mtu(test, test->mtu);
 	if (err) {
 		ksft_print_msg("Error, could not set mtu.\n");
-		exit_with_error(err);
+		return TEST_FAILURE;
 	}
 
 	if (ifobj2) {
 		if (pthread_barrier_init(&barr, NULL, 2))
-			exit_with_error(errno);
+			return TEST_FAILURE;
 		pkt_stream_reset(ifobj2->xsk->pkt_stream);
 	}
 
@@ -1791,8 +1791,11 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 
 	if (ifobj2) {
 		pthread_barrier_wait(&barr);
-		if (pthread_barrier_destroy(&barr))
-			exit_with_error(errno);
+		if (pthread_barrier_destroy(&barr)) {
+			clean_sockets(test, ifobj1);
+			clean_umem(test, ifobj1, NULL);
+			return TEST_FAILURE;
+		}
 
 		/*Spawn TX thread */
 		pthread_create(&t1, NULL, ifobj2->func_ptr, test);

-- 
2.51.0


