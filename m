Return-Path: <linux-kselftest+bounces-28907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD07DA5F142
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF37D7A6BD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C14265610;
	Thu, 13 Mar 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YjttR443"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C201EE013;
	Thu, 13 Mar 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862896; cv=none; b=rUI/u0LFgrCMbiSGgkyVqjLp6Nr97MuNtvMWVaQHwsTVeBh+XqSWknOH4Yp1QWMSxFyNyQUY9I6q0uKAKstOrLcxq5HHOZroUwo6GAY4SvcX12vLN52OLPX7FmmSaF/rxOYQaLGBG//c6j99SVgKziF/iiU2X5QvNRDTEqIZfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862896; c=relaxed/simple;
	bh=jIrgB+Of8GjIDCFndWRj81685Oli/mbEm6qoFYFa2yY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRkr5mfRQ6s7EYnIbO3jXynRyRTleBXFEK9s9AMWLg9WyKd+FwwY/YggDtCRZyZOfI9pBySd3MAHQw4pFAO1Bk14KkqWEyJ2+eMmuKPWyv0+jGvOLcyLrLbaZXOwKk3DK4ujG5vssMyVRHkmI4WLpY1or5hU9Jl7CIc7uegqjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YjttR443; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDA6C43C67;
	Thu, 13 Mar 2025 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741862886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmVbak8eK+3pmfHwySA9orkO+49ATky8BJ/0nzXmFQg=;
	b=YjttR4436+6VI8Zi9jf0L/AYsu6A5MtafcwfFwiThEihasOzpr7+dn8Oq/xtsgBguiGEZb
	fEz6DTM7ts/VAp94pwUcLCfkTDUyVqcTzjVZ5CKXAWB7a4J4HGYmh4rpdERmindLqcm0+s
	O3y2cReKQqBRsM2esGD1SwzK31WP3n9rkO74qOBheWUXkjxrzW/fRv9hrz8t+Qn3DOh9Hi
	vnirruk7cN11aPwvG9UblAzMmHG2jEMXdcat3966q/P9fN8kOqsH3XBOH4P0pra9nQlePw
	+9i4/2EIOhv3S0f0HO5IrihSlvfWcPSfek6AxEexiCXnP94oOLgDunZI1CxsIA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 13 Mar 2025 11:47:59 +0100
Subject: [PATCH 01/13] selftests/bpf: test_xsk: Initialize bitmap before
 use
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-xsk-v1-1-7374729a93b9@bootlin.com>
References: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
In-Reply-To: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepvdgrtddumegtsgduleemkedvheefmeguuddttdemfhelvgdumeeftgejudemjeeitdgtmedutggsrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekvdehfeemugdutddtmehflegvudemfegtjedumeejiedttgemudgtsggrpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpt
 hhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehmrghgnhhushdrkhgrrhhlshhsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

bitmap is used before being initialized.

Initialize it to zero before using it.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 11f047b8af75262b4bd5490ccedda00db4a639d2..3585c5afe9842b59fbd50256e5bc83a58a0ee38f 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1265,6 +1265,8 @@ static int receive_pkts(struct test_spec *test)
 	u32 sock_num = 0;
 	int res, ret;
 
+	bitmap_zero(bitmap, test->nb_sockets);
+
 	ret = gettimeofday(&tv_now, NULL);
 	if (ret)
 		exit_with_error(errno);
@@ -1455,6 +1457,8 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 	DECLARE_BITMAP(bitmap, test->nb_sockets);
 	u32 i, ret;
 
+	bitmap_zero(bitmap, test->nb_sockets);
+
 	while (!(all_packets_sent(test, bitmap))) {
 		for (i = 0; i < test->nb_sockets; i++) {
 			struct pkt_stream *pkt_stream;

-- 
2.48.1


