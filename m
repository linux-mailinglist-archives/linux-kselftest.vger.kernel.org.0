Return-Path: <linux-kselftest+bounces-11630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD469902E28
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E611C21E80
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4535661;
	Tue, 11 Jun 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC10WO+K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37211AD21;
	Tue, 11 Jun 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071230; cv=none; b=sdUrqZ9Osfmor/cHgnaGapCQz+TOM9ELASqUXLTqU9rvuYqWtVmV8HanNYRL6gxBfMSK6x3iFtul2Zwrdy/wt4SOvujoJcGfy0eQE7kQphqRPrXCwKdeNZufcRLzhFblnwb2UbaLvL+z6gkMBtJnnk7xgauABczdpkW43q3sqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071230; c=relaxed/simple;
	bh=EOuXoUhyZErUAKP/jyrB94SzTJRRLAYfeiAWVUX3QGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ee3DiIthH1LVccMYlaY6icoj/367l4Fnp2vmd8dVFR3hlYOL59Dgh1ANA0aO7CYS16bUiN62zzOTaXXMpxPxn01sY4Pn0OFCVjc9261b2/LW+eD0DKKKKzg4p4iv395/jIFbPLZuDGRI511JZ9qQEnztazfqhLhpwxCjh/q5gH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC10WO+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F89C2BBFC;
	Tue, 11 Jun 2024 02:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718071229;
	bh=EOuXoUhyZErUAKP/jyrB94SzTJRRLAYfeiAWVUX3QGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BC10WO+KtQ0Q1WUUr768cLfJ/GzaRE5db7X5iBHx0yiTgbEa8fqAsb43N+0GFwJnp
	 Fcig0JMy6Aw1bfBjZZVeaMYGzQynGkee6fE6TXP2HVVoYuk/FHrhT5pZJNygGafEE2
	 olL2gO8sDWdxn8df6hfBIVHaGyVbaTTzet3XrsfOqO3nG0mwGTF7U+Pfb8eskRwcCj
	 uqVQeNux37dikGj87vNJQbjLUe06sDYXyaUn4jTaqagbbL/IA7XolsNYckJ1HQvTnT
	 UQd/NT0u5Dnzy0qbb8AW4s4CPqi3H69QPxktMZZ7VXnM1cpFc3LFMZQYCls27Q/IH8
	 ObiPNbsG2M7+A==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 4/5] selftests/bpf: Use start_server_str in mptcp
Date: Tue, 11 Jun 2024 09:59:37 +0800
Message-ID: <bd2f838063195bb7e199df9d01e7f266dbb1d360.1718070940.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718070939.git.tanggeliang@kylinos.cn>
References: <cover.1718070939.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since start_server_str() is added now, it can be used in mptcp.c in
start_mptcp_server() instead of using helpers make_sockaddr() and
start_server_addr() to simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4472aa404da0..00f63f3f19f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -104,13 +104,8 @@ static int start_mptcp_server(int family, const char *addr_str, __u16 port,
 		.timeout_ms	= timeout_ms,
 		.proto		= IPPROTO_MPTCP,
 	};
-	struct sockaddr_storage addr;
-	socklen_t addrlen;
 
-	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
-		return -1;
-
-	return start_server_addr(SOCK_STREAM, &addr, addrlen, &opts);
+	return start_server_str(family, SOCK_STREAM, addr_str, port, &opts);
 }
 
 static int verify_tsk(int map_fd, int client_fd)
-- 
2.43.0


