Return-Path: <linux-kselftest+bounces-40598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F197B4018B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5041A862BB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86E62F744C;
	Tue,  2 Sep 2025 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oOYLpmF9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95B82DE1E5;
	Tue,  2 Sep 2025 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817650; cv=none; b=T9sxsOU9qEj1lr0eufxdueaX4nqtptjs+AF8dHG0Y1qm/qhpgBzraXdXTg/u9ZQAuzd534fzSaAjLVmHjZTkmj5FvJdAy0zwF9ny/rX0c47rgHBiRcHG8XF/sZVpvWIpEs+sATK5gSnGYBhMFlN926SjRKGy0gUv2X7W40hrc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817650; c=relaxed/simple;
	bh=FzNamSPrsMmJP1e5lqpIGGBeUHLiZ/mMkJFzYdhLBxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTZ+JPelghSHWkAS0vFfA3SBgpsroQhdx4IFMDGJqlhGnQPA09LwaL8vAO8Cu4CuO869S7Hr5hH0H4Ua34QC51erkPGILs6xdOnbty3lZ5S5IOOUs/uLfUfGxB1AsFihaDJRewKajiD+oLv3dcrrfihFW51ib5ereZD7DI3Ko7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oOYLpmF9; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8A771C8EC73;
	Tue,  2 Sep 2025 12:53:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E1DF60695;
	Tue,  2 Sep 2025 12:54:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A8E31C228A25;
	Tue,  2 Sep 2025 14:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756817646; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=D64yGA2J7uh8HX9n1ZRbBA9QteUIGWuWGvNMv7Vf2E8=;
	b=oOYLpmF9GNegmoDXkkewm+t7KonlJFJKrvRRfuJaO6OdhtNA7TzkQREjZDM6nDX7zM4K7Z
	Hsv6DQ1RZ6g3KRXdB401zLTi19FCWCO16FeMqfkIt09mHcnzi3s8pSZ2lzPYyy7fYriR3m
	eEDMJEPxD6gyrlik43SUkJ8YtzaLFtW0+LL4zMXUZgSbayiZiwAiP+nL6ruVSZkK8XkOtB
	USZaB3c06KeASOc8rL9UVlbl3JEnqdDx9Qjq7tMsSRLOv6tnmz5GmBjSBFKQRCnvRojegV
	N6ZwrOC2ug4oCjjhu8+R4qwJn1DQmAEJcy2HRRK+t3dexl5K748s8fzIGB/3yw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 02 Sep 2025 14:49:57 +0200
Subject: [PATCH bpf-next v2 07/14] selftests/bpf: test_xsk: Don't exit
 immediately when xsk_attach fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-xsk-v2-7-17c6345d5215@bootlin.com>
References: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
In-Reply-To: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
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

xsk_reattach_xdp calls exit_with_error() on failures. This exits the
program immediately. It prevents the following tests from being run and
isn't compliant with the CI.

Add a return value to the functions handling XDP attachments to handle
errors more smoothly.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 5019172a5c5eeb32be4e5026b8a7f9e56997c10d..745ba0080ae0447bcfa07faf21559fbb9b42e76a 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1653,7 +1653,7 @@ static bool xdp_prog_changed_tx(struct test_spec *test)
 	return ifobj->xdp_prog != test->xdp_prog_tx || ifobj->mode != test->mode;
 }
 
-static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_prog,
+static int xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_prog,
 			     struct bpf_map *xskmap, enum test_mode mode)
 {
 	int err;
@@ -1662,31 +1662,40 @@ static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_pro
 	err = xsk_attach_xdp_program(xdp_prog, ifobj->ifindex, mode_to_xdp_flags(mode));
 	if (err) {
 		ksft_print_msg("Error attaching XDP program\n");
-		exit_with_error(-err);
+		return err;
 	}
 
 	if (ifobj->mode != mode && (mode == TEST_MODE_DRV || mode == TEST_MODE_ZC))
 		if (!xsk_is_in_mode(ifobj->ifindex, XDP_FLAGS_DRV_MODE)) {
 			ksft_print_msg("ERROR: XDP prog not in DRV mode\n");
-			exit_with_error(EINVAL);
+			return -EINVAL;
 		}
 
 	ifobj->xdp_prog = xdp_prog;
 	ifobj->xskmap = xskmap;
 	ifobj->mode = mode;
+
+	return 0;
 }
 
-static void xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_rx,
+static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_rx,
 				 struct ifobject *ifobj_tx)
 {
-	if (xdp_prog_changed_rx(test))
-		xsk_reattach_xdp(ifobj_rx, test->xdp_prog_rx, test->xskmap_rx, test->mode);
+	int err = 0;
+
+	if (xdp_prog_changed_rx(test)) {
+		err = xsk_reattach_xdp(ifobj_rx, test->xdp_prog_rx, test->xskmap_rx, test->mode);
+		if (err)
+			return err;
+	}
 
 	if (!ifobj_tx || ifobj_tx->shared_umem)
-		return;
+		return 0;
 
 	if (xdp_prog_changed_tx(test))
-		xsk_reattach_xdp(ifobj_tx, test->xdp_prog_tx, test->xskmap_tx, test->mode);
+		err = xsk_reattach_xdp(ifobj_tx, test->xdp_prog_tx, test->xskmap_tx, test->mode);
+
+	return err;
 }
 
 static void clean_sockets(struct test_spec *test, struct ifobject *ifobj)
@@ -1796,7 +1805,8 @@ static int testapp_validate_traffic(struct test_spec *test)
 		}
 	}
 
-	xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx);
+	if (xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx))
+		return TEST_FAILURE;
 	return __testapp_validate_traffic(test, ifobj_rx, ifobj_tx);
 }
 

-- 
2.50.1


