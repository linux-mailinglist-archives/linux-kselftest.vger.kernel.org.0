Return-Path: <linux-kselftest+bounces-40601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020DDB40199
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E70188EF76
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85E3019C2;
	Tue,  2 Sep 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HvJ+J4ER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED663002D7;
	Tue,  2 Sep 2025 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817659; cv=none; b=q+b3wCCBiToEs82ZMGbQfH6undFkwC5m5SnJWfHuiSOywfQqpnt16HytmTMPL2KCE2UqvlkXlN0hEih69I86+O4SKzmwOzCW2pWWJEvqPKuye7C3ktXvlZceW+k6nCqMa42jQuF9Ee+ImylTIa3lsC3Di9K3blP1YSU5lPMqSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817659; c=relaxed/simple;
	bh=f+PUXB48FO3f34mXIwurXdJAEg2KAeDvIh3cgkdjW24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3YYwF3QMeTp1ELd3PZq9Td5PEU4f5+tw2ZSh9H41NGVrekHq/ZK5sDYViLWfY6fsYx9Grgel8xbcXAMtzeAumJFa5O4y/SgxvyIzir+uSFdgC+NyyckgAdS1IuEj81vCeyeq9iB1tWFCwMYe9UHK6vg8NjIDFa3bzZVPnqoxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HvJ+J4ER; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5C9A3C8EC66;
	Tue,  2 Sep 2025 12:54:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5153660695;
	Tue,  2 Sep 2025 12:54:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E08C1C22CD91;
	Tue,  2 Sep 2025 14:54:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756817655; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HYciB7DpQG/ZKZdVIJkDQBEkAOfPYSQPQ8fg/ov91R0=;
	b=HvJ+J4ERsnLYSLgVHTQcCc5RynNfI6hc8rm360HmqUNCG5k37Xmoa1uZr3JM0oy+Fe93Cq
	/SIEXJ2vxN34eb+1pncOh0h3oLKd3sNLR18ZZzdMbyfz//b+aVVW0fwlQPR+/BgcLvhKWM
	UrPp4etK8oRFrrUZbwLbt+DL8yP5k9O7SG/VxXGuV24LrAs/DqOczWbIuSsB2+nV3ovwGP
	F0iUyY6c0QwXPEsP26dhmj5FJOTFDHtkFh5VDIkm2loXTvOnU7MCdvVOnS6GDjbgUrzdgH
	YKQgMA1/2NIHUwu8jPy09FKsz/R1Js8j2pDhkG7Ycqf47Zj9deVNW4unC3+b9w==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 02 Sep 2025 14:50:00 +0200
Subject: [PATCH bpf-next v2 10/14] selftests/bpf: test_xsk: Don't exit
 immediately if validate_traffic fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-xsk-v2-10-17c6345d5215@bootlin.com>
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
index 516ebbf6248e4629acf69e9a16e2a46b19fdea81..b22b99f2e4acb528928654ec00995dc892487068 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1782,12 +1782,12 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
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
 
@@ -1801,8 +1801,11 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 
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
2.50.1


