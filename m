Return-Path: <linux-kselftest+bounces-9587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D78BE03E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 12:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCB51C232B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 10:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6DB156C78;
	Tue,  7 May 2024 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LobBtDgD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8D1509A6;
	Tue,  7 May 2024 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079231; cv=none; b=BN9OsIrvxaWFQlt5shvaDTd73Qox6sT/LgZkmZT82mIqGj/ppTjIADlR36rT7cg0hGXqZlC8HWG8utSX97Qxa+SdGdpSgMvwt+FGkHoioG/XBn/gHQaNfGkOajHk7J7h6NCxAW278fQNvOpwRKUYFlBvjYjW3RLOiQnMdux1aJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079231; c=relaxed/simple;
	bh=jSQSA9ObspLWriDSbY7LXBjGeEeVNlgc2rqqlfC5LXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJl9WwmlhUdb0i9dDGXAfvoMNkt/UpFAkIfraT+IIM1axtzqu1s+IA8L1FUaTDO18w3YO8gnw/z81TUd/qi41Mw3XwrQHR2FMwM9LMb2/pJzMMgdjbw/Mq/Ka51UiHZqVT4HjMhyZM7oJQ8biv3m/GxtywnRfa09lqNWWJ8/QGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LobBtDgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B638C4AF66;
	Tue,  7 May 2024 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715079231;
	bh=jSQSA9ObspLWriDSbY7LXBjGeEeVNlgc2rqqlfC5LXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LobBtDgDRS54ocaslIxQbAv+VeYjboKklIHMunyTIrincm9+v7wH435pZEWgRs0Wl
	 2aq2NE483s/Kuqj0WtFj+U8s0etMSOUqEVFfNvO2wLG8Xi4bXQcpAwVIOg70lAidvq
	 npOvLfGb/CVmTWmM10gmJj9wVkVH8SyGf0RUvY0KX3dX1F533Xk53NjAuqa7lNbjgr
	 sQQIxiXTFXrP+gqDIESebSpQXacB7Pzy534Lkqe0+RUGXOQmKljCxIYzafQQRfgDx7
	 Nxhw09AXz17pQ/dVHPKyweSYX/VjBiwbehepyGU2MC6MWRLmAhTFqZo61bpfksEo0w
	 tsRV7PYWMzFoQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 May 2024 12:53:32 +0200
Subject: [PATCH bpf-next 2/4] selftests/bpf: Add RUN_MPTCP_TEST macro
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-2-e2bcbdf49857@kernel.org>
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
In-Reply-To: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mhApJwAHgeitNpAaQBRyxjO18rRunoBqRBu7knt84w4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmOgguX+CwaeAGlpJyISVH1t/JF4AqZulYA5ymv
 Fyb2Vd5VvWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjoILgAKCRD2t4JPQmmg
 c4b+EADGbAtlxozE2Q30WzhbII+rfSFL0kbpgbwvR9eTSPvFy+cAFy2K3c/8xpHIkU4UHy5hB8v
 IYVECxBKSlhefM8JcrC3C/oClRAyQBMNTqiZCKVBmWn7GrJib3c7gowTjpL/A9I0L5ziqEx8Yji
 jZLm/T8cqCtekuwfEG4xVUmCcFmTzEOtrk07s1n7Dze05BAlF+ulpSlaRMzS/jWBeURdAkwkUrg
 M4jX0gDMF7duHWP/R7Fut6X5GTyhOZlP0OEIV+532yrQyt1IcR/0MpwDfAzK2mMJjCJTlUhV5NB
 2RXMtMxaUMFW3TbXF8TTi23FcMgAiHnpDae82ouXyZXIoHTW7TBD4zIpk2ZRVctePKdSfwQqLAw
 IZcBuMZfBE0kK5U8H/XHgSyWXbVK59x0e0zadorZ6dvxCYZl4IJV+gRzXNg03ENiVor9Is3Evkj
 PTNH27cGsmU1UmI5UNmFJ7q43mS60swX4YRE4vQOP3sWoMG0vq8Fgz41oex9dkZQVUdnsul/zG1
 1ZKPz2GhHWHhc14V7nqjRkx6Nun6bPDaJO7LzhGa530NftYMEMub8QQBRu6vV7jF0NgCZTWEoi9
 qU3kdInCSU6nePpofvQW3yavuF1rRTL1TMqdtKA2ahkpvlK0cNGnV7sYPjdkhaUUGG1lCfH2cHQ
 t2uMsXvVJAUkE3g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Each MPTCP subtest tests test__start_subtest(suffix), then invokes
test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST to
simpolify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index baf976a7a1dd..9d1b255bb654 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -347,10 +347,14 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
+#define RUN_MPTCP_TEST(suffix)					\
+do {								\
+	if (test__start_subtest(#suffix))			\
+		test_##suffix();				\
+} while (0)
+
 void test_mptcp(void)
 {
-	if (test__start_subtest("base"))
-		test_base();
-	if (test__start_subtest("mptcpify"))
-		test_mptcpify();
+	RUN_MPTCP_TEST(base);
+	RUN_MPTCP_TEST(mptcpify);
 }

-- 
2.43.0


