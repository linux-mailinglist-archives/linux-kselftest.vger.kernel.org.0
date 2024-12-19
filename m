Return-Path: <linux-kselftest+bounces-23594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E129F7E68
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB26188F1EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBCB226552;
	Thu, 19 Dec 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO4HcIth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78022616C;
	Thu, 19 Dec 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623423; cv=none; b=YOV8/y2nxU+HeFc6AFp4d/rdPOPPKII8P6drw0lltTxt+VJ+2F5D6/c+DTkvxELVimZU1cjEsFHxoUJmnL6PJ2W82vY7JXDB1oSLyJ8RgS4V6OpuoCZ4Hd/2QT74fA3bo0zrQ3kf8CMBRjrUNn7koF/il/Uq6Fd8ibLBqK7wIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623423; c=relaxed/simple;
	bh=W96t/RxyrkRGBDbdV5a6GjcXQ/s600KDjdOOQeqhKcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GIDJEt619SOdubAz4SGJgcmqA4cnSol3Ppl4Y/Kx+sRT+AQOvaGX0NChDlEsEqdxmsW0VKBOCNVdAp3LJa/YUVANdGiJi2PNu9/J17WeFCsgOJ58bjZzRdGiKRoH6i6gpfnjy0kerrRfFs1PYl4UWK0QKYD+P1r7QVbnWBy6fXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO4HcIth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27EFC4CEE0;
	Thu, 19 Dec 2024 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623423;
	bh=W96t/RxyrkRGBDbdV5a6GjcXQ/s600KDjdOOQeqhKcw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DO4HcIth/Q3IyqDkFpuUFwup3+MDVzFPS8Dhf2Pe/i60mejZu9Buah4WQ13amFKOi
	 VTAF48JSSKFguNEPVmeG+oPbqGKDLIFy06xijfHtB1uWTD8JFCDzWnH9LtNF0Nh06d
	 GEEz6stZuMrG98U65YLfcUxO6IU04o4JmSe++nXRJUjQ5qxeZPW00k83dasehp2MNv
	 3bIi0NiZnBadt/fkmnaRDk+MOSewgbTcdB512hRrbhjeYg7e5XYhWRYMpNLS7Xc8iK
	 Z9AGsABGAnMcQwiLSKtBoAVruHwIslk5vto6NtJ4DgtnZH58qieQYhP0ZtbhHb8vAw
	 9o76j8ZjDAWuA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Dec 2024 16:46:41 +0100
Subject: [PATCH bpf-next/net v2 2/7] bpf: Allow use of skc_to_mptcp_sock in
 cg_sockopt
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-2-ae244d3cdbbc@kernel.org>
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
In-Reply-To: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6JrVc2ULAFXcwJoeGrzMjRsZ5K+d/6l9XN9k4QmIJsg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZECusixmfR7aeSuAt+bA3fIj0UldEuyvFNW4y
 0SbiAMp5o6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2RArgAKCRD2t4JPQmmg
 czPLEADqcXMCkCE3I8HxzUrqLApKF5oodPBxy8gItnot6SJ0kJJZqdGQ7Dkdluzj06wBWP7xvYc
 9DdUtRTfCC+lQi8kBZ9UkrDS/mkVgBIRhZSI5gaSN19wTR7jeBYRyKYyt1FuKG6mo95tau+5l6j
 tJmRn8gTS+/1+h2oV7NDaZWGsgJ3na5Osn8abmoBRmtf6aCqWrPIGGToWQI3+jsyFOM8wyjXPY2
 DTbRqPsTIFiLV4wAJ3DcW7wY/21s6AhCHu4MHAbZIkraQZzqQ1X+4+Qfww6ePWtwwQVEFmwpinR
 pM/gqXW+R5JNY+LtRRUiAr4IImLdLEMhjPYf4hnmQTnhRpPbqdEIkE4K8oUA/+LcleFSzYmay5R
 fBicig2WA4qGi3Jfmvrt+LQEqU5PZhNaeXJJ9xiO4FG14kmwHw+OmYS7j3+BpM4sxmV6OtSIBWO
 w9UurakX9f/+f11dFvIkSvLIxjmJpqfP0ryTaq4tkeOrOmxpTDzrij310RwolWPKr6MXsA0EUBr
 bwYM5ntRH67eDsq1UP5qUPmmHusphpN4vewCV4fOa/7wTs1tRt3o6mkIi0OlbXMZ/Z8qa8YlGvf
 zGhSynqv0Zkhslpv9BuG0iIbODAfH2239nKFk+kZ9IjI9x4t1sJ26Kht+C3kv8eREfe6K4TqZZy
 c8A7oElNsNbZXXg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently, bpf_skc_to_mptcp_sock() helper is not allowed to be used
in cg_sockopt. This patch adds this permission.

Thanks to the previous patch allowing skc_to_mptcp_sock() to be used
with MPTCP sockets, this permission allows this helper to be use it in
CGroup BPF hooks, e.g. [gs]etsocktopt.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2: new patch.
---
 kernel/bpf/cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 46e5db65dbc8d8c6591b53dfc77bb689357f33ea..1ca22e4842cf6b6c6bdbc37bf415187e706b2b69 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2358,6 +2358,8 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #ifdef CONFIG_INET
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
+	case BPF_FUNC_skc_to_mptcp_sock:
+		return &bpf_skc_to_mptcp_sock_proto;
 #endif
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;

-- 
2.47.1


