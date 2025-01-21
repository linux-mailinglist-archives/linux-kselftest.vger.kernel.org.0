Return-Path: <linux-kselftest+bounces-24848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92946A17B57
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 11:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF93162382
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DB31F0E2D;
	Tue, 21 Jan 2025 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jnESZgfi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792951BCA19;
	Tue, 21 Jan 2025 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454944; cv=none; b=e6Oflf9LNTOJAibWK1vlqmC3ffURffBsuI1J0nyvdPbjHE9Uunu9s0aNJ7DjZcxzj8QaJDtpEG3Wo8JQv7rEut8NzR5dlJHapg7JV1lXzKxcz1sDoDuCRb3fJrOXFM/llxmJH3mwl9nayu/QvQ8fPTb1w253k4jkBZItQi/sMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454944; c=relaxed/simple;
	bh=0Nr7e/NtqvjGyug6WlmvTn7BiwzmE1kcYBSG07uZQZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kj4A/xQS3Yi2Ut2QujcLTwysYnhmGuO9bIMhW2IlPI/k7f9e7S2lnBGCmV2uLngoiuJ+4bDTjfl08V+fJNrg1lrheV4KPLKzkQXQXWxV9WV2j16zrX8pMlfKqy1IrRPPJPgL3fUHL/4vZ7nWaABHits1d6pRshy1uOAi821h8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jnESZgfi; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8DA0240005;
	Tue, 21 Jan 2025 10:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737454940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1xSk4qxT/8ra8CyA+fYL/qAEHJzTXBv629tkpHZtFo=;
	b=jnESZgfiCTnTuRgEjMl9X1/IjdL/PxtuQ1k+rMjnHcCrtAMXrfPvzM9dElHd2JRnQ0c6kz
	kf7Gq4HNumlgDMvtPm28Au30f7gKGJQv22nLDZd0fsZwpuWVnmapmD+3A6rOIilAKsIo5m
	98HNkHPdPExy4tuymOI47CnECUHZujmslUmRIdnhwroHH20aPhbtqS+fz9jFfW8KrElrhY
	J1a8noN3wJde6xYuwb5RMzPivV0xlqtfiQWszNMAXdwIMYq5SorTGdf0Ykkb6ISnB6z5F5
	v8mL9cj6NAFGfo4Z0jCU4hCmh108aPJGQ6wm+ZDJ/ExFVwJj4qHipvmQTYfKVQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 21 Jan 2025 11:22:16 +0100
Subject: [PATCH bpf-next 02/10] selftests/bpf: Remove unused argument
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-redirect-multi-v1-2-b215e35ff505@bootlin.com>
References: <20250121-redirect-multi-v1-0-b215e35ff505@bootlin.com>
In-Reply-To: <20250121-redirect-multi-v1-0-b215e35ff505@bootlin.com>
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


