Return-Path: <linux-kselftest+bounces-44505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10058C23B7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C7B424B96
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2EC33BBAA;
	Fri, 31 Oct 2025 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gsj4T3/a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E661933B6FD;
	Fri, 31 Oct 2025 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897925; cv=none; b=DzsLVQEC3Im/eSksn++1iQDm0YgaQAXQZXPE9i2B9RqieJg55H4s38VKl8eLv6LJi3Gz/mLhqnAz4jBvGAoEEn8FTyXcoS17tTZl+3GxNF8Qn8q9rar+8HqOWXCKwCviyUuiuQVy7AeGJwc4fXY9w79SpI/o9bOkbCIL/JZgxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897925; c=relaxed/simple;
	bh=tzEL/+eFohUsoGJMjgGf+3hkw6vtFhHimprapHHcNmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7QhJwNg5caa7F3PCZUR8q49JmDx09XOOo7PVU7idlbuQnIp37pp3DVtpB+7TyNkoZTHJ2eTfoQ33fPsktO8cN4546EOfol0oEChNBmU4UWf0lTXgSquqlTPkkNmvbA6cjsVcvLZm9O+slXFRtrttvAJEFtyEvSuRFZkWrf6K0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gsj4T3/a; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3D578C0E94C;
	Fri, 31 Oct 2025 08:05:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7D4760704;
	Fri, 31 Oct 2025 08:05:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4EDB1180FB68;
	Fri, 31 Oct 2025 09:05:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761897921; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QwpYT3cQId6kxLH+jgZ2Gj6zVCFYz82Z4Bfwux7jeYg=;
	b=gsj4T3/a4h8YgXAfUz6sN57qDAwNY8SPd9ng0nHMPSJlN03cRXxKdM4pFkmqgt4Vx5kqaY
	LeE58wDcGgX+p87+XojUDIvWHrMyG2iBJh+87A5FitdRaCb0HEuEQV88Q/Cy/gLn1Jpt4f
	OQHsF66BhNOxZRh5wGkCjY8inPg0Frs+bkC1EFuv3NtbYWlgKfUe1xjK+5jw3yLpixkmGc
	Pi9zaqI63L3JeOyyhBmcDPWeRQWtjaSi/9qJZtultYQA8t7pZDjtcCuUxGJlK+o0bTZY/t
	5nhj2yFQMKW0YPwREDXZOs7z3iZVXwtcAj8MRsMoN6U4O4lm6MbJOgKz+ptrww==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Oct 2025 09:04:48 +0100
Subject: [PATCH bpf-next v7 12/15] selftests/bpf: test_xsk: Don't exit
 immediately if validate_traffic fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-xsk-v7-12-39fe486593a3@bootlin.com>
References: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
In-Reply-To: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
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

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 19182c1d9730191276084acd35da7118780b273e..0b69438826e3bb617f488aa829d5f8eb98d2b0f5 100644
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
 
@@ -1791,8 +1791,12 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 
 	if (ifobj2) {
 		pthread_barrier_wait(&barr);
-		if (pthread_barrier_destroy(&barr))
-			exit_with_error(errno);
+		if (pthread_barrier_destroy(&barr)) {
+			pthread_kill(t0, SIGUSR1);
+			clean_sockets(test, ifobj1);
+			clean_umem(test, ifobj1, NULL);
+			return TEST_FAILURE;
+		}
 
 		/*Spawn TX thread */
 		pthread_create(&t1, NULL, ifobj2->func_ptr, test);

-- 
2.51.0


