Return-Path: <linux-kselftest+bounces-9586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597DB8BE03A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 12:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138012830E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 10:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC0C154C05;
	Tue,  7 May 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQwAI7pF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3A81514E7;
	Tue,  7 May 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079226; cv=none; b=bpdRsZmIc04ui9MAb7El6dpM4GL0KBDYG7eF8PL5JQwJ65UBIx3gAGxjll111FbWs9eh3Nh+kaZ9h1Z5k0mUmm7eGcIURTgixtZ9QzUbOl/nSHB36UO8aAJ5V7+gm/KMEomLvg+a0ZK9XreQbDrqVeXYsWAMaNjRzOwlZMTC2fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079226; c=relaxed/simple;
	bh=hPNoNz/g0I0oQPt/EFnqKp4bIa85B5bemCYHctr92U4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4OOLGVmJZXufsyknJuihbb6jWVBlWs6EXgECum/uJbB0lF+fg+J16u8Af1h4U5IUZyCw6FL3rA8bhA65EKTDzO+0zl8Bp7nhbE/fAi3XOBbgFGcbzc3i8pq1KeW+G9VDmTFE1a+P+h/5gvDQ5bC1olNrYNhuXI+NrXb3YCzV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQwAI7pF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD63DC4AF63;
	Tue,  7 May 2024 10:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715079225;
	bh=hPNoNz/g0I0oQPt/EFnqKp4bIa85B5bemCYHctr92U4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sQwAI7pFMlEkTyzClB0iQYDUxEIFMwCadJADJv0UuKF0stcPVmE5iBuWrr/zPQ0ae
	 MZ7KvqUUGh+lVYytmm4fcPpa33ZITC8J+OUQYEf0ZbbrBRKTMcmUV5gdA4D8JzMyge
	 1my0Lw3XCTXlp/4x6846+5eXf3h+9Pf4lHu9uNy3pnEfjEO9MzgWRqAmNqTy8wsa2R
	 pmn2ZBI/E3J+fg43+67CqOaG6FdzKBaogCv5uGV3V88AvJcXiyx4B/Xuxrdx3qFRmC
	 CI6pAtwfOJRX95Y9M5o6Q609MDUL1Hb5whrhO0AKdL4vA1gmFcNHaTXFdE6l8lfCop
	 mm1bEgBwLyg+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 May 2024 12:53:31 +0200
Subject: [PATCH bpf-next 1/4] selftests/bpf: Handle SIGINT when creating
 netns
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-1-e2bcbdf49857@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lyRBoz5Xmhw6UZgyarafKgSfWpCH32S9g/wdv08HRjU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmOggukIkwZj6TYCL8FxTM3oKEpmnsX+s2yWfBf
 zv+Q+kmt6CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjoILgAKCRD2t4JPQmmg
 c584EACgL5qCGLUyywbDhu1TIO6ySqs4kpRCfDV1gmNFeugITDERHvC0Y/t0MApQDciodwUanek
 eFYdwF2cKkHp3T1K5lC1e5vrh6dFOAObk9WuyDeXCuuEJgTF8qm8eLHOw9WpdT3RZw+2pVdP9fE
 B5A1qF7U+qjWWD031Kx4CPo/+v6QlUruVwiFJSA0yOHWA4l5HfXFhd8jF8uH93p/OyXwmzy+BnV
 8RuK+k/uFudn85WUF1x6+aygt0bDGZntYCDslsPw//HBw9Z/HpqnFpv2T0+9AF2HahVYfliNOGJ
 amboL9mxYBEKMDQ+dIb9ll/fglr0Ma2oyxvjDLBcmdEMNDIjsaRsgUSjUGxTOPavuvZ3sMg71VJ
 KBBlaPczPTVU89XKZxLE4XKCN27BmTEG1cwvFDSU/LS3bW4K03vDouwCMWxYVlB+L1q2O8ZGMBH
 cZfIE0ZdWXKx9OS6IVVsEiI3bRG4tckilcigatWcnuGf1nHmhBSnieGl1SPfD2GkORLC3y4bTxU
 zQtN6aNyLp35sQ+S0ngqwNYj8AJEpou7PUFVV7o4qERDo2peInoBFfwqVGjMjwDT0aWeEMoW1/K
 xuE1SwbX1WmAmrM1sXwTpC3/qpMzgFiis+XhmF9iKogYatOzDClThq8a+RW6uK4GbSqDz6ONVUx
 UYAiYLtzEO62bXg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

It's necessary to delete netns during the MPTCP bpf tests interrupt,
otherwise the next tests run will fail due to unable to create netns.

This patch adds a new SIGINT handle sig_int, and deletes NS_TEST in it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 274d2e033e39..baf976a7a1dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -64,11 +64,18 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static void sig_int(int sig)
+{
+	signal(sig, SIG_IGN);
+	SYS_NOFAIL("ip netns del %s", NS_TEST);
+}
+
 static struct nstoken *create_netns(void)
 {
 	SYS(fail, "ip netns add %s", NS_TEST);
 	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
 
+	signal(SIGINT, sig_int);
 	return open_netns(NS_TEST);
 fail:
 	return NULL;

-- 
2.43.0


