Return-Path: <linux-kselftest+bounces-40767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A8BB43835
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC227C7581
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D82FE578;
	Thu,  4 Sep 2025 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zl4qeXTI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289092FDC44;
	Thu,  4 Sep 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980689; cv=none; b=hGY1Jh67pNYg3ivrAKG9ynB66RCZS3UCdYcBNoDu+8EBnQJSbSTR6WiSyiFxDMNQu6BcV9VbApD4M1CdMOf4Yoid5U2VbKJUFOdl9LlDxFWGefPzLKa6aMI0Rh4SxKEPg0Gm2MOMB1A+JM8lLFbkQwfpHsJfJUUEB0PE5rtrxow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980689; c=relaxed/simple;
	bh=IEPHuqnbRSKAeGCFI2Kg+8RLi1TPHm2Vo+JJUOCvWMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTU1kzTo5Ov9wxyIYdlyl9v/Ca3gId3BkY7GbZX9csmyTQT9ro3w9Qz5nQhC8agmXRygtw259KbLAg9E6/H/msxikiFiV0zzLOsJ21OF93CVs0SI7f5usr7SGawFwcsk3K14/C5YTUzq6NraClCdYlY/FoOWNq3t1EX6/wFrNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zl4qeXTI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7C80B4E40C0A;
	Thu,  4 Sep 2025 10:11:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54459606BB;
	Thu,  4 Sep 2025 10:11:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72EC51C22DE29;
	Thu,  4 Sep 2025 12:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756980683; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=j7rcPwwGDfvSooU7OQI5sxso3YC/QBKzLUx9piCbBMY=;
	b=Zl4qeXTIVH0xK+BUmfmyBWgs0Uq5kqhEbrBFLXzQSm1LC1Rw1YrMJidbrmo0I0T7hEfW1d
	FjkRtDrm+sWgVbhEQN4TBMMYFU8LoEHOKtkuPXThw0ESW8ldqQJBSCGyb5SK+y/sjsYLE+
	+GKlMjLs2RbGY4QN7OjZ3hOWRrkHHeBEllEvejubccX50FB5g2NN/LW+IVovEGXhkpJKmE
	I2UZDJhUUmsH96IYj8ZVX9RsK7MR7fkn5iQ4CFW2TS/HcCmtLjnC+0VUvi395r4FEmdPLS
	F3ollufy9mdgksJ43tbMIrNvMcZVNGvHHfzh1Qp4uqLV60Uewx9lIa9xstTX9w==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 04 Sep 2025 12:10:19 +0200
Subject: [PATCH bpf-next v3 04/14] selftests/bpf: test_xsk: Wrap test
 clean-up in functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-xsk-v3-4-ce382e331485@bootlin.com>
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
In-Reply-To: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
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

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 36 ++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index e4059c7d0a289449a6b73669fa87f7440b7f55c0..f70a05d570681e36d3e592a6845637402d1bb58f 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1689,6 +1689,27 @@ static void xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_
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
@@ -1744,18 +1765,9 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
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
 
 	return !!test->fail;

-- 
2.50.1


