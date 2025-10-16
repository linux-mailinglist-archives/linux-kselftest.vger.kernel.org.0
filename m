Return-Path: <linux-kselftest+bounces-43294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54442BE1FAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE58E18816E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A592FF652;
	Thu, 16 Oct 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tmkPbh6Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548B2FF16B;
	Thu, 16 Oct 2025 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600755; cv=none; b=Ov3exDbBc1bKH+vujpR0o2iIEcdhBWBKn1SgQ6JmNZO0cQ3Bo1IjL79r+KjHZQF4X9MivDoJ9OJD6hsfDHwnzy2irWqtXk8hjFnPqANekt4lgURp6yU5yKxRB+JykwU09E3RUaggDIeNR+U9/00MuaJx0xkE4h1+XiwszuM9PPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600755; c=relaxed/simple;
	bh=GRf5pO09B51DGf/8JXpqDGryXFdVf0zOZoy017qnk0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uA/+hg+t3zRFjbaONBHZCKqs7YmfXZ9zi2W4HhQpbabxu4t5Izhd5b8aV991DkQLwOsMV5oQ/aUbmDBFOxGIYApOzojhPw2lWQe8Owgqo2hMdoQkQuC9FoNLWw9dZdL0Bb24Xr9QS4Z9F8K3iAiMFmXHpdjK7C3cFK8IwsKGNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tmkPbh6Q; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3434A1A1414;
	Thu, 16 Oct 2025 07:45:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0903E6062C;
	Thu, 16 Oct 2025 07:45:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A227102F22ED;
	Thu, 16 Oct 2025 09:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760600750; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NTnD8CdkarTrhlGO770hkduquLn2c0s6l4SlOEHonts=;
	b=tmkPbh6QA2VZHSNygnmsQ5EMXXjkeCfRNH8b/l2ySw9uVh8DKVNBdpV1gOOmrdAtdNKZiQ
	AY3JB/8q1R5XEKFr+KYQlEWGCOj8divHoXJkz5h+pStLotGm+PuQJ/zW6uPpRzBIrmVHrl
	DzHHkFbLKEDwuIWxXgQsvrzWBAqGRQ1+2QBRNwS5bpaou6Ta/B+4vHaRthxpf4nR8uqSkW
	4ul/WowwGycXeneTMd24dR5drWzI9yvNSQJHhhk+7wnmbRW6UxyygHjWl3Q41VZS5b7DXI
	w52FqTYzv9hVXVdkA4G6YaZHtoBjZr7hvZNoYX0aD0iIdMxMtrUv68VipuhZsw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 16 Oct 2025 09:45:31 +0200
Subject: [PATCH bpf-next v5 02/15] selftests/bpf: test_xsk: Initialize
 bitmap before use
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-xsk-v5-2-662c95eb8005@bootlin.com>
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

bitmap is used before being initialized.

Initialize it to zero before using it.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 02250f29f9946d1ca701e30a900617056d91587b..679491b6b9dd80ccb2b92729141fb8715b874c6d 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1069,6 +1069,8 @@ static int receive_pkts(struct test_spec *test)
 	u32 sock_num = 0;
 	int res, ret;
 
+	bitmap_zero(bitmap, test->nb_sockets);
+
 	ret = gettimeofday(&tv_now, NULL);
 	if (ret)
 		exit_with_error(errno);
@@ -1259,6 +1261,8 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 	DECLARE_BITMAP(bitmap, test->nb_sockets);
 	u32 i, ret;
 
+	bitmap_zero(bitmap, test->nb_sockets);
+
 	while (!(all_packets_sent(test, bitmap))) {
 		for (i = 0; i < test->nb_sockets; i++) {
 			struct pkt_stream *pkt_stream;

-- 
2.51.0


