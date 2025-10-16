Return-Path: <linux-kselftest+bounces-43299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB9BE201E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD17A4FC967
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD983090E6;
	Thu, 16 Oct 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zOKYxokE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F74308F01;
	Thu, 16 Oct 2025 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600767; cv=none; b=W/YFs7PHMLA/UwZMWCDJhB7eay34oPHwyXFOlsSdYET274WsrPUMp46T77ivjXaL+OS0eyQyi9Q0YGMPOS4QWw0wASdx0w7Cx7WgyaVe2wP0ysNIlSUfTgFgcJV8nAnP2g0DHGUnMGJA+1ZplMH9WWsWSDs4BecDHCGGokiQtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600767; c=relaxed/simple;
	bh=cDq9NFxMdJ1KoM2cm0BBx/55+lB4JI39tEo11K8xsCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fr9y9+IwHTZElPK2yM9uTRvaUNs1UZDLB0GXbvOsyf1ETHaz6iNgBejYMD+pr2P9Q9UiIIpQTR5El1K9USDuDX+hdPUcGbsEL2JsWOonisNl6lGo9YC4JKMOVj12nH+6znmdU7BQyH49wpa1wCByFquH2RqXKEgXW6lxEgUL9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zOKYxokE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 78DC31A1410;
	Thu, 16 Oct 2025 07:46:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E5E66062C;
	Thu, 16 Oct 2025 07:46:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BA76102F22F9;
	Thu, 16 Oct 2025 09:45:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760600762; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V902gLTJ1tGfAR8hmV6KKVBGzcuYROlev8W1RLscgLg=;
	b=zOKYxokEKMEH0d/eRmZPfhH6t8BhI1impj7gJZXw8svq0ridEjhmIv1H2LA8APeaO55AQv
	OKdQqTHW4w/9zb83Tj2QC+FhH/ryYrs3/E7wM67SLgiRIZVvJEayckSCdAwYTEzvtuWnk5
	W1k5y/w7kUlSuOcBHQF/CrWj/fjhaM1ID6qQsaaqYqgsipoL7rIv2aVBjwks1MjTY+nmUZ
	mHvpNrPva/4jJEoUm6Eh2U59phynVYHyxUzh8l9J83C41uKpJaWWe3LW75mN1Y0PUU29mt
	jWQJE7fGmiaAXTGYSWQbr9MrFtN8iZyQKRmvuvMklj5Vf5bQTULp9bWX87xwTQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 16 Oct 2025 09:45:35 +0200
Subject: [PATCH bpf-next v5 06/15] selftests/bpf: test_xsk: Wrap test
 clean-up in functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-xsk-v5-6-662c95eb8005@bootlin.com>
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

The clean-up done at the end of a test in __testapp_validate_traffic()
isn't wrapped in a function. It isn't convenient if we want to use it
somewhere else in the code.

Wrap the clean-up in two new functions : the first deletes the sockets,
the second releases the umem.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 36 ++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index d7cb2821469c62abd0d532821e836336a2177eb5..84b724731e26d0c7e67131ec1bd562e223d3d09d 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1679,6 +1679,27 @@ static void xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_
 		xsk_reattach_xdp(ifobj_tx, test->xdp_prog_tx, test->xskmap_tx, test->mode);
 }
 
+static void clean_sockets(struct test_spec *test, struct ifobject *ifobj)
+{
+	u32 i;
+
+	if (!ifobj || !test)
+		return;
+
+	for (i = 0; i < test->nb_sockets; i++)
+		xsk_socket__delete(ifobj->xsk_arr[i].xsk);
+}
+
+static void clean_umem(struct test_spec *test, struct ifobject *ifobj1, struct ifobject *ifobj2)
+{
+	if (!ifobj1)
+		return;
+
+	testapp_clean_xsk_umem(ifobj1);
+	if (ifobj2 && !ifobj2->shared_umem)
+		testapp_clean_xsk_umem(ifobj2);
+}
+
 static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *ifobj1,
 				      struct ifobject *ifobj2)
 {
@@ -1734,18 +1755,9 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 		pthread_join(t0, NULL);
 
 	if (test->total_steps == test->current_step || test->fail) {
-		u32 i;
-
-		if (ifobj2)
-			for (i = 0; i < test->nb_sockets; i++)
-				xsk_socket__delete(ifobj2->xsk_arr[i].xsk);
-
-		for (i = 0; i < test->nb_sockets; i++)
-			xsk_socket__delete(ifobj1->xsk_arr[i].xsk);
-
-		testapp_clean_xsk_umem(ifobj1);
-		if (ifobj2 && !ifobj2->shared_umem)
-			testapp_clean_xsk_umem(ifobj2);
+		clean_sockets(test, ifobj1);
+		clean_sockets(test, ifobj2);
+		clean_umem(test, ifobj1, ifobj2);
 	}
 
 	if (test->fail)

-- 
2.51.0


