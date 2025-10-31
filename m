Return-Path: <linux-kselftest+bounces-44494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D67C23A8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E50188B724
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 08:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0610328611;
	Fri, 31 Oct 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yYEcObXN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908431158A;
	Fri, 31 Oct 2025 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897897; cv=none; b=oMqcUnY8zBmD7MPoEnP1Gam9qKqX+pXOKVgnU7fYVpe98Nl39ZGzEteEPDuWurAfYQoc+cB8A8t0rnMKJjK2lV3bq48iXq6OwVKRHpjZ0SmX6ffgc0IKxr+2fZCdpl93BzSaJ/aYgsI8yjYbRSu5HkO4lyiufrNao+0Ol9l8x0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897897; c=relaxed/simple;
	bh=GRf5pO09B51DGf/8JXpqDGryXFdVf0zOZoy017qnk0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4wZKOrj1sOZ1nF8UJ7AcJNns4GCAAu9ta4mSta8GEFI1yRAO0k2MMTNPjrwNqiUwc3hU8VnQdnVx57771jPqmd3fW+VM3MACdKrJGZxEc8S4LVkjEGZvfdIcqWbwmszaxshCuEDY21peKndJjC1gsUGuVp8556iKSvEmFtWl84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yYEcObXN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 483CD1A17A9;
	Fri, 31 Oct 2025 08:04:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2167860704;
	Fri, 31 Oct 2025 08:04:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B366C1180FB54;
	Fri, 31 Oct 2025 09:04:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761897893; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NTnD8CdkarTrhlGO770hkduquLn2c0s6l4SlOEHonts=;
	b=yYEcObXNsAP4suIaOsjQVG1kBPpP9lDw8qjLcgmA9S9zFOwg1/eYj6oPFsqQiTCTn3JT9R
	Gw/aXwHVfCKNKAa2kkCkRhb1Hg6txtpo9A8oHSUeFI8YNPBovhOjk7kkd5etVd6Fu+njuV
	lcRlghq//sKZHtRfn7urpHT+eFMTu51ajs51pjsbKAzLJHB5u+5fl9f8NlatnYiIOIfG5v
	G7rcxIK9SlhZX0uGKqxCx3JgaeZjuUTTx0mMz79MhERKLnFHjzsl0aWgAbNQW1jksdOx+s
	wUC3ZCProminJcbzISstuUojG3timWFRbuoBz311BOchKcvd4dEOrZdfjqr9Ew==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Oct 2025 09:04:38 +0100
Subject: [PATCH bpf-next v7 02/15] selftests/bpf: test_xsk: Initialize
 bitmap before use
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-xsk-v7-2-39fe486593a3@bootlin.com>
References: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
In-Reply-To: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
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


