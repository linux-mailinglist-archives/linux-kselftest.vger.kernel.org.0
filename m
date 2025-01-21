Return-Path: <linux-kselftest+bounces-24861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF40A17E4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2331C3A836D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108161F37B5;
	Tue, 21 Jan 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XUkyMXmi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD391E3DD0;
	Tue, 21 Jan 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464493; cv=none; b=SRBbqPFpUOQjz5JjtoWS6x8N2lp/EhuvkH+Az+zhiLmZPp1i0kfB7DVMsIiLaKBYYkMlBFrpIToKMTPv8e8o8uDpzDjyNojEPdluBCITXx4QdGu2wiv6iTEv+HTo4fYfx22n+7ae2RuhfcrF0WLlClxN0e7fyn3bXW/bqXKDpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464493; c=relaxed/simple;
	bh=0Nr7e/NtqvjGyug6WlmvTn7BiwzmE1kcYBSG07uZQZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTECVzg48s6w1Mr2sqLwPTw/8sDw9H3ODq6uUL79b310mlgpFN/RvPYgbEKyZoHJ9TT3qDxCwRi2C6BGRUmO/8r3nk+2jdkRkpfVtLtl1tGJey3CHOXLd803Pg4+jhIOyXBJHzrdvJ2+lXDfrzxEMJtclLw6558I0luElqYZ48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XUkyMXmi; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A12C31BF208;
	Tue, 21 Jan 2025 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737464488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1xSk4qxT/8ra8CyA+fYL/qAEHJzTXBv629tkpHZtFo=;
	b=XUkyMXmiZCNLZthmo6MW2Fp+7ddUxb5ukHNi2D6D5bVLt9glHarSIdm8VCUYOeponB3J2a
	292kZbJJ5AV/veDLU7Sj6RmQbh9BZjR9pyH7e01MOqIYcl8j/4hc5eYvHrBNzraai7c9Nj
	V6yiGtEkcIrOvEqJBU67qdm6mlciw2xqjJ2yIPQp8CI/TyW6u+sBH5nxsKk9fwMrkJ9I9v
	FqpJsuqcvIhEsNqavzpfLFmjXDdEnenL7Zq4kb3UmSMl4UeTyDsEzhzoHWmJPRkVtSZput
	yoHo4xnabqE+p1c8KVJ1Nj9t4WOmeEx0WwjAtEFzvezL4xIQK07kWWjT/CnRog==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 21 Jan 2025 14:01:24 +0100
Subject: [PATCH bpf-next v2 02/10] selftests/bpf: Remove unused argument
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-redirect-multi-v2-2-fc9cacabc6b2@bootlin.com>
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

check_ping() doesn't use the struct skeletons it has as input.

Remove the unused input.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 8dc28274a6e8fc75b05781d827a04f01e03a6ebb..8507863e61bbea99c906c60ed4535e23d530588c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -165,7 +165,7 @@ static void cleanup_network(void)
 		SYS_NOFAIL("ip netns del %s", config[i].namespace);
 }
 
-static int check_ping(struct skeletons *skeletons)
+static int check_ping(void)
 {
 	/* Test: if all interfaces are properly configured, we must be able to ping
 	 * veth33 from veth11
@@ -214,7 +214,7 @@ void test_xdp_veth_redirect(void)
 			goto destroy_xdp_redirect_map;
 	}
 
-	ASSERT_OK(check_ping(&skeletons), "ping");
+	ASSERT_OK(check_ping(), "ping");
 
 destroy_xdp_redirect_map:
 	xdp_redirect_map__destroy(skeletons.xdp_redirect_maps);

-- 
2.47.1


