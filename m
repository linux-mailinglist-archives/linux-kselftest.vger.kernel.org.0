Return-Path: <linux-kselftest+bounces-20527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0669ADEA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 10:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674F32845D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD11C4A00;
	Thu, 24 Oct 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7FahoOD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFCA1C32EC;
	Thu, 24 Oct 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757495; cv=none; b=YZIc4oD3Jd9ID+4gIpr+boTCkdC9FSVbwtHTIQZVuFnyglZKCAeG2/KPvVu7C8DjZVMmMwXxroWT5mGHeN6CRsq9+RdYxr4spj88uz6t//uOf8GriFswn3KXW02Wes/Gb69V8TKJVT3aDfO918/FgkHBxluu5ppd5y/oMml/5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757495; c=relaxed/simple;
	bh=IZ/zXxz1cBMKrj44BZQYvjzRj7dB5flzbyL4CRWfrUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoOZj3xaTpbbUVJ60l1mtqTDlnyowIv/A4Q0UP3XiB5LzOrvKFwQDqaEijEAzml2e4750cLZ0WZIM6/8XHHLanwxxY+aszJe9GTWXPCiRPN2fQj2XiqXpBvcB7qnmp9/x3BinbXq7fQ7fLFEenckN/opQ/A4uGMSUEcjuoJOi/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7FahoOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABFAC4CECC;
	Thu, 24 Oct 2024 08:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729757493;
	bh=IZ/zXxz1cBMKrj44BZQYvjzRj7dB5flzbyL4CRWfrUA=;
	h=From:To:Cc:Subject:Date:From;
	b=P7FahoODf1Zkn7zuX6fwIAEJ1P7tpio2f5BSHqfPbKrSS7TMlfUHMXa2KaCrnRDCg
	 WJS3Eta6TOB7y/w2gox9YWvHfSoLj8vzqNDMhh6By/RROCcxoS5Q9qndIGqaN9WmtP
	 HGeXk8qyIi3utVLyMp8jhEynB5awL+EumMj+SaGgORG1vayp/s4tjLcbwEGTLWLIhF
	 ZVbWG2EeOV9SzGHR8rmBNYwEorRWj1cceuU3WFck/iloW/Y4HrdcELltpwdUw+0oTQ
	 Gt+2g5XFRLGQ9qBuVPUidcIvJoS0lO7m4M1f1wjndn6aNlu9LN6RVp/2Wx5DjnzPhc
	 KNtZWKYpGDbwg==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Use make/remove netns helpers in mptcp
Date: Thu, 24 Oct 2024 16:11:20 +0800
Message-ID: <99e57c7470ac338da18f02ef3af5936c8b21f5a7.1729757268.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

New netns selftest helpers make_netns() and remove_netns() has been added
in network_helpers.c, let's use them in mptcp selftests too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d2ca32fa3b21..8276398f7d6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -66,12 +66,18 @@ struct mptcp_storage {
 
 static struct nstoken *create_netns(void)
 {
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+	struct nstoken *nstoken;
 
-	return open_netns(NS_TEST);
-fail:
-	return NULL;
+	if (make_netns(NS_TEST) < 0)
+		return NULL;
+
+	nstoken = open_netns(NS_TEST);
+	if (!nstoken) {
+		log_err("open netns %s failed", NS_TEST);
+		remove_netns(NS_TEST);
+	}
+
+	return nstoken;
 }
 
 static void cleanup_netns(struct nstoken *nstoken)
@@ -79,7 +85,7 @@ static void cleanup_netns(struct nstoken *nstoken)
 	if (nstoken)
 		close_netns(nstoken);
 
-	SYS_NOFAIL("ip netns del %s", NS_TEST);
+	remove_netns(NS_TEST);
 }
 
 static int start_mptcp_server(int family, const char *addr_str, __u16 port,
-- 
2.45.2


