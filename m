Return-Path: <linux-kselftest+bounces-42202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F73B9A60A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD713A9825
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED163128D3;
	Wed, 24 Sep 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PjJ2y6oG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69B31282C
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725430; cv=none; b=U/bLStFADxjcq6LaKJI2xhmi1id21bILTQ2xhEMX29Fkn06NXloUA5oXdNlqmiiVLL6Ie0Zhaz6M9t/lbunMhjJ9NH0Sa3GRrpbFTeB/A7uDTYKYVkp669SdNyP4xNAkfn/yssin+LhLfVyIYkHBOwQkNP3bnWfM+jDM8gkLg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725430; c=relaxed/simple;
	bh=tN+KK502mRn5IU2MfOua2IbsgatQICalJNBq1gn4xBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtGvOFpGUhs3dxAKxB7HDHQ8MFxFBBwQn5ONHDpZs9i8kf6LcVUevV9i7Eh8rFxwJtRm5kFI6mbLKXZ+DED0+4JFiz4aN13OQwgmZbez9M55z149Ge93znRUmtj5/WmOrF36o+T32Af5fLoBT3hS3EgoXwm8iZtuzK3ZUxVyFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PjJ2y6oG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 482931A0F82;
	Wed, 24 Sep 2025 14:50:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1E7A160634;
	Wed, 24 Sep 2025 14:50:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C92D8102F1972;
	Wed, 24 Sep 2025 16:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758725424; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WGWlPkl4pGG2y4n8r70mjy/ZV+JI6orK8Oq0psEM/Wg=;
	b=PjJ2y6oGs6Qy4QsMcuo7ez/7P7hirhWs0vo3ASxlceKQXUjvwEH7SIUwtkRXuV7kuxJxzv
	+8pQd/UndoztOAApaekuHPImdUIjvtEffqwdd0SVcH9titqy7gX45h21SefuRRPbaDva02
	fHTD0LLsgpMDjBTrUNFRpxAe/2lXIT5+OUHhg3OuTuSwMlyHNsn5HFhrDS54xC70aSIg3J
	XFVBo1ruDketINLFj6DpQ2OiFlf8kcxB7gLcWd1vDejUKfV1QB+1q0TdYlvNC/MPYOZbWB
	wIhmRuxI1MF3HWjIHi67PefIEH8iJey7cThLsQ4qiirsGVcT4IMR0X1tCcTRRg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 24 Sep 2025 16:49:44 +0200
Subject: [PATCH bpf-next v4 09/15] selftests/bpf: test_xsk: Don't exit
 immediately when xsk_attach fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-xsk-v4-9-20e57537b876@bootlin.com>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
In-Reply-To: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
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
index 7db1d974e31511e93b05bf70be991cee4cd444c6..0adb6c0b948f6216b24d0562bcda26097dbb9dbc 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1643,7 +1643,7 @@ static bool xdp_prog_changed_tx(struct test_spec *test)
 	return ifobj->xdp_prog != test->xdp_prog_tx || ifobj->mode != test->mode;
 }
 
-static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_prog,
+static int xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_prog,
 			     struct bpf_map *xskmap, enum test_mode mode)
 {
 	int err;
@@ -1652,31 +1652,40 @@ static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_pro
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
@@ -1789,7 +1798,8 @@ static int testapp_validate_traffic(struct test_spec *test)
 		}
 	}
 
-	xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx);
+	if (xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx))
+		return TEST_FAILURE;
 	return __testapp_validate_traffic(test, ifobj_rx, ifobj_tx);
 }
 

-- 
2.51.0


