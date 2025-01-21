Return-Path: <linux-kselftest+bounces-24864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA57A17E5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DD816A835
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375EC1F4705;
	Tue, 21 Jan 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D6s27Pqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131A1F3D34;
	Tue, 21 Jan 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464496; cv=none; b=B+iSs7UqDZh/DUCV4zGKQ2/916jApufsHyWHVg16Rzwp1t0VVdfncstT3O75KXltH1mTFLxGr9iIC0nPbtoKsOlPPdEB919IaJPPh7vAeA2cNwkeASef7Birk2t8mFznEedccUIeazxVgWlxZDL6R6ImqlSWKf5KDAq5oPdlUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464496; c=relaxed/simple;
	bh=Tg8M5cDmTjCtJDNBj9IXmsB9LswH3wfAHbSlZTOJ3sE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7rk5/j90xMMJjh6N8/qvME/gCGhgN9mF2SWDKMLUgZj+wX2Z5VoH1txfdgRxqZVfpRo9MHfp1BJ34JK28YUOOujhPhWw2494IHvolHcGRGGgjg82srQ1aonXWsKpBcfgogUPvt+FGgIpSWqHXpf/y6UKij4WX7mg2a0YimT69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D6s27Pqn; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9DA01BF20C;
	Tue, 21 Jan 2025 13:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737464491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuPUMiL4noPLXhbJcS0szRr9m4xTROwgDoOzcYvBj3w=;
	b=D6s27PqnhpNg8XgjBuwUN+ppe+6ZLWaJPgE9EXkn5NKHWaT4Th8BfAmZrqOyp+mmmfli2j
	2sdilMWzEbnPtDuqa1TsIgJZk9qbcCIR3/l6Xa8z/RYV1FdUdmhb4SdhrKJzz/it3Irhm2
	ByLrIzZrF1/Sshb8GKZOeTb9Z6qKIXmwL2VeEsAA/gNb4nn0D9IzVTWQC+OKZyUdi6oQVf
	ntSUbthLuoJ1d7ZfAv9mHifB13IanMUrabKLnAk1r5skwXqVnSPfid/io02zpTmqINBosV
	dru7mlB9Pe6bbOWeXlZ7lhkwlQGXy6bNBBILHyfLplrDSOMGLFR5MZX6RJtxqw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 21 Jan 2025 14:01:27 +0100
Subject: [PATCH bpf-next v2 05/10] selftests/bpf: test_xdp_veth: Add XDP
 flags to prog_configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-redirect-multi-v2-5-fc9cacabc6b2@bootlin.com>
References: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
In-Reply-To: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

XDP flags are hardcoded to 0 at attachment.

Add flags attributes to the struct prog_configuration to allow flag
modifications for each test case.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index b2b4f6958940f7bce66953568d18fb10e12130e5..0aa1583b741b15f573bbb979b2047a0109070544 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -77,6 +77,8 @@ static struct veth_configuration net_config[VETH_PAIRS_COUNT] = {
 struct prog_configuration {
 	char local_name[PROG_NAME_MAX_LEN]; /* BPF prog to attach to local_veth */
 	char remote_name[PROG_NAME_MAX_LEN]; /* BPF prog to attach to remote_veth */
+	u32 local_flags; /* XDP flags to use on local_veth */
+	u32 remote_flags; /* XDP flags to use on remote_veth */
 };
 
 static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
@@ -106,7 +108,8 @@ static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
 	if (!ASSERT_NEQ(interface, 0, "non zero interface index"))
 		return -1;
 
-	ret = bpf_xdp_attach(interface, bpf_program__fd(local_prog), 0, NULL);
+	ret = bpf_xdp_attach(interface, bpf_program__fd(local_prog),
+			     prog[index].local_flags, NULL);
 	if (!ASSERT_OK(ret, "attach xdp program to local veth"))
 		return -1;
 
@@ -120,7 +123,8 @@ static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
 		return -1;
 	}
 
-	ret = bpf_xdp_attach(interface, bpf_program__fd(remote_prog), 0, NULL);
+	ret = bpf_xdp_attach(interface, bpf_program__fd(remote_prog),
+			     prog[index].remote_flags, NULL);
 	if (!ASSERT_OK(ret, "attach xdp program to remote veth")) {
 		close_netns(nstoken);
 		return -1;
@@ -187,14 +191,20 @@ void test_xdp_veth_redirect(void)
 		{
 			.local_name = "xdp_redirect_map_0",
 			.remote_name = "xdp_dummy_prog",
+			.local_flags = 0,
+			.remote_flags = 0,
 		},
 		{
 			.local_name = "xdp_redirect_map_1",
 			.remote_name = "xdp_tx",
+			.local_flags = 0,
+			.remote_flags = 0,
 		},
 		{
 			.local_name = "xdp_redirect_map_2",
 			.remote_name = "xdp_dummy_prog",
+			.local_flags = 0,
+			.remote_flags = 0,
 		}
 	};
 	struct bpf_object *bpf_objs[VETH_REDIRECT_SKEL_NB];

-- 
2.47.1


