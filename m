Return-Path: <linux-kselftest+bounces-14104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D349193A927
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E51CB23085
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B8D1494B3;
	Tue, 23 Jul 2024 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcNgF9j8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86FB1487E9;
	Tue, 23 Jul 2024 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773365; cv=none; b=bH1VgPfmihd9u0L8q/gQIROiUM9WJKKBvPWef0fIK63l6+mblJcRlz8sjhk6eM5POXr5WcLuCrEkLR8A8vxH8Ekhp8cycRT9AfbJyWI7rvdUt1dHizcfqAul6rsuPRZBSRI2mKwC2YJlldeWHooLivoBuTxt76RnKPvlJIuYqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773365; c=relaxed/simple;
	bh=12aAaZMootg+cvj+0ayt/8qu159GnEbnVlWc6KZT748=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu6J/Uu5w9Lxj5N2y2ZnvQtVo4jZwDIVeKTJTAOlF1QmOeBw8kMUITpMX1ByTTn5fAZJwb1OhiBq5e0mSUpRGIWXh3LCNugODnwzYmZN6jpAAMhAbQVrROAm9BKY0TGe0iPRDrldnQJ2ASVLjAtM1aJd7JkXWUOZ6b3ie5x012o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcNgF9j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC283C4AF0F;
	Tue, 23 Jul 2024 22:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773365;
	bh=12aAaZMootg+cvj+0ayt/8qu159GnEbnVlWc6KZT748=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcNgF9j8fYFu0O8jZo1teuViXEcwm5ET1nCR4ZdoTXhkpDmsEd2gWimUte/Ge/0pY
	 d2eMuUQPGqeRME6Mw0gs/MkIyE5dGVq3WijwFBrJR4g1Cc169OH+Bh6pH/PQm7tW5O
	 uFw05Qm8gX+M7b7hSsZcqLU/jmvfnSi4kXB83DxscXADZkNC27Gcx07liHm+DhVFk0
	 pf0PTouQzG2QjnktC6hFId6ZRCOovNTbgVNiLvMvM8XLeuV7vOTZGTQvsEZ1fN9OTJ
	 Ix1Z+VmviIDUvD0BUg9J7+4tjNYo3xF/X9x+Yz4JuMRkcTBN4PHsrpJrt4cv3dMNHu
	 4i7MjDv3Wq3Yg==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 02/15] selftests/bpf: AF_PACKET support for make_sockaddr
Date: Wed, 24 Jul 2024 06:22:08 +0800
Message-ID: <e1ac981f0f30a7d6ed7f57a08e37aeb3f5d2fff5.1721771340.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721771340.git.tanggeliang@kylinos.cn>
References: <cover.1721771340.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds AF_PACKET support for make_sockaddr(), uses sscanf()
to parse the given addr_str string into sll_ifindex, sll_halen and
sll_addr of sockaddr_ll. Other fields of struct sockaddr_ll are not
used in BPF selftests right now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index a3f0a49fb26f..2a142d713861 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -416,6 +416,21 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		if (len)
 			*len = offsetof(struct sockaddr_un, sun_path) + 1 + strlen(addr_str);
 		return 0;
+	} else if (family == AF_PACKET) {
+		struct sockaddr_ll *sll = (void *)addr;
+
+		memset(addr, 0, sizeof(*sll));
+		sll->sll_family = family;
+		sll->sll_protocol = htons(ETH_P_ALL);
+		if (addr_str &&
+		    sscanf(addr_str, "%d %c %s", &sll->sll_ifindex,
+			   &sll->sll_halen, sll->sll_addr) == -1) {
+			log_err("AF_PACKET sscanf(%s)", addr_str);
+			return -1;
+		}
+		if (len)
+			*len = sizeof(*sll);
+		return 0;
 	}
 	return -1;
 }
-- 
2.43.0


