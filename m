Return-Path: <linux-kselftest+bounces-22057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA10E9C94CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C01F239F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 21:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109A1BBBC8;
	Thu, 14 Nov 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="COdKPCKk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA901B6CF6;
	Thu, 14 Nov 2024 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621086; cv=none; b=NfPtQj0Ku/TloDUkR/4ZfbRuZfovQr6z/HAhB3IgxjYjedgFxuGu13sda9URst/Wue4+x+cnsJF6qhNJyzfvxf/SP3XB6/GlvLAeYWmje3i2QP+DMh+tFTANJc9+NBs2+XhqGMUEx4mKz+0Qw8b7BUi0wkop1UAMDHSwg4gGb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621086; c=relaxed/simple;
	bh=Y1UwH2Q7NwOHxYZX5xOsmZjeaN2/LmNye/nJw1S0YzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ko2FnVO+4dEyD11QunLDqObMWhb7X30TNoczEwfWd8KGbKUm3rFVwCVoaYK89RFXnGVdopdAZ6abyRaPspW+yHqnmSj7cBEWRI7m871pMrTE332vym+rdstD1Ws2WezpXzJQm59R8VUjNd8jw2gl8ixFaCQ+kG+YLEfLl6dPEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=COdKPCKk; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44B6020005;
	Thu, 14 Nov 2024 21:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731621082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcZTGjdZBAYzErVaAy+X9+V14rB04cB08uoTvKLfLUY=;
	b=COdKPCKklkrYuQXZp2S0hOT+cg40Ng6+68z7P2ghtUkDd8c3vQt3FnIpmVRT3adu1n3oHt
	PXvE4VqCQiNqZaLORNKUiMdCyT4LlUja/tgPY0TJLkmVLYQgDJ1fe5jcdpo5RmtkaF1yp1
	/KJr0Gu9hPuK3PEdDvUHiCo/zDu67S9G6LfKqkHxjTO0oQUtLT/2up/TgmSN/9PyB1mHvL
	aHPMAHnUguvdIj6ICK1w2xOjjQvuisLDZ82n29mZhHaYrQstwC3/DX2BPPfHAkpqgWe8He
	hSV4/XPMuHB6tveKbdfZpzYfoTwMTfWTbgvYR7Lou2Z01wxB+5auxxuSfxQsFw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 14 Nov 2024 22:50:39 +0100
Subject: [PATCH bpf-next v2 08/13] selftests/bpf: Enable generic tc actions
 in selftests config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241114-flow_dissector-v2-8-ee4a3be3de65@bootlin.com>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
In-Reply-To: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Enable CONFIG_NET_ACT_GACT to allow adding simple actions with tc
filters. This is for example needed to migrate test_flow_dissector into
the automated testing performed in CI.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- fetch Acked-by tag
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 4ca84c8d9116a48b1ebf04488ebf7ebfcb633282..c378d5d07e029109061fcd433cec223280a525a4 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -58,6 +58,7 @@ CONFIG_MPLS=y
 CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
 CONFIG_MPTCP=y
+CONFIG_NET_ACT_GACT=y
 CONFIG_NET_ACT_SKBMOD=y
 CONFIG_NET_CLS=y
 CONFIG_NET_CLS_ACT=y

-- 
2.47.0


