Return-Path: <linux-kselftest+bounces-22326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EAE9D348A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D2228687F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9269719DF40;
	Wed, 20 Nov 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nwh8Hwj6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129F19ABD8;
	Wed, 20 Nov 2024 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088620; cv=none; b=e09tEn4XWhIN1aDgM/u6/96JFi/6am8fN5yqdj78um4Oev03paxNcJgpdW1TIrubiUdMh9Ii50FL+hgFNNHdkJ9FjZYqqGo4BT+H2ZcYThlFf46Z1lQbb5ONZCoQPnIWN5zcfKUoMhTVQPDwpMM4PO4bTVPzI9kjdb7xqOC0EWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088620; c=relaxed/simple;
	bh=SLaqNi8sV6LOqwUiHrki5fAoOb/y9rKuG4iAfsmwqzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdZa2xOnTOsy2/hmKRiKyc4Hu6kiSbAPuwsJ8XNmM3jOr/wi7P4QnuwVVOEA2E9vmBObtu0EW3o+jz0q1D4FIEOwJOPqNv4k0oDSHtsCfIH2cwBn0CajFXeLwRvIDDrnoww3BKoghV2IURvnYfuKhibPz/okTg4zqw/c5bIFEc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nwh8Hwj6; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D659B240008;
	Wed, 20 Nov 2024 07:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMTGnFyD36MsNEVM2J6r94qGNXIMhpQegdtY9Puer+M=;
	b=nwh8Hwj69hyac4hQj0bt5SCtnXgja2wC8OvEB4FEbPR1lD2nopwsw357OKluLcPWaOdjSx
	qk42hQSQfRq+iN/n35WOH9YTRaZXmpVH6fCnsr0Zg4vjN85HXo2QZt8AcIuPkWTvGK6AA/
	WVOE6qgjJ7aC3Ai/3FIAQXBr/VGH2MEWr1CzTo//Gi9Y8LkuOuw4l6TLlv/xSyI8qnNa/q
	a94WMAwnpCBPZ3TfKkBOF2xjQC3jE+jORdGwy8shfaCC2KEXeAEfsUZhI+wscRt6oqDyYl
	rE/WtlC2e5BZAr2SejtERi771ekSnGbcum2XmI1m9s6n1Uo1csgGH1K2TEqL+w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 Nov 2024 08:43:18 +0100
Subject: [PATCH bpf-next v3 08/14] selftests/bpf: Enable generic tc actions
 in selftests config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-flow_dissector-v3-8-45b46494f937@bootlin.com>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
In-Reply-To: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
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
Changes in v3:
- none
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


