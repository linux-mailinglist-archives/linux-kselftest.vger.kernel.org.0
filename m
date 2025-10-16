Return-Path: <linux-kselftest+bounces-43305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A9881BE2012
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EA41350456
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318593168E3;
	Thu, 16 Oct 2025 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MDlseRkd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6A431618D;
	Thu, 16 Oct 2025 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600782; cv=none; b=rW7TKYA9cPvplzibeqGkLTujYmApXHjPjRj7drDoO0tC7v9BmNu5Fd0J4pZDpupvnqaqyWeoKloJrSs/lnfO5AVdhJv/RFA7K3h2Thq3DQNFJ90jURROwWpJ8zIVwjnC79eJs5IzOyx4bzRnP9NcY9rCQvtnoqoFDxomoe/tinM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600782; c=relaxed/simple;
	bh=i6tvyT3HeQHgZFGaqaMNEa+sxOzLO4PwlSxdaTbHzYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KugTPDujHKx147xFdhavmXoeBn4uRnGqguYcmU4nGN8l/PCgPKSymIXWA4+NClhfSA4bEmCP6+y3U2OQ4KKPe3HBiSywU2VVewDl4gx/LG/t4zNi56orl0qXDo/4fXZMaIXu/wFkxW7PVGU0gIbe4HZo5iFqqpeZPSNqg2lZLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MDlseRkd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 114E31A1403;
	Thu, 16 Oct 2025 07:46:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D10F46062C;
	Thu, 16 Oct 2025 07:46:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 207A8102F22F9;
	Thu, 16 Oct 2025 09:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760600777; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QiRKufBHvQpmJwKLnrkextSnGSsnCJs7BLMNg+4LYZU=;
	b=MDlseRkdeGO4jZZdHPSZSVEevxpJlX057OJRn5YqxOf2sQdj654zZyP9LgEuGCy+lw6rmG
	TUGiRkZGQNlFov8Q7st6+vpUH6gFg0KHRyz6+s0kOrJZQTJblrKyGjtRsNXGvthxPwG8I3
	PYPciGnB6FzughetZQvLseP+Y2yG+3QsjOO1vhAbyI5ze3+HKcaFMstXtA47d+4oGG73Me
	7Z5MxRg5nf4I3wqVR13U19/YImon6iExAVisabVU+6xZAooYfQTK1SK30IplfCldog8iI/
	aH9Xnm3+T1hndiC1+iOiUOVEpRrJ1DT3RRD/u8iCDH7lWXqxTAC8ijsJEb1UOg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 16 Oct 2025 09:45:41 +0200
Subject: [PATCH bpf-next v5 12/15] selftests/bpf: test_xsk: Don't exit
 immediately if validate_traffic fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-xsk-v5-12-662c95eb8005@bootlin.com>
References: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
In-Reply-To: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
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


