Return-Path: <linux-kselftest+bounces-47266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EF6CAD381
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 14:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39103026AE7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB33148B5;
	Mon,  8 Dec 2025 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UDmeoemP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5872618DB37;
	Mon,  8 Dec 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199719; cv=none; b=MbT01NZJ6f2y3+DeAiWiXYx9ePZP7r7GXYV4bEhl/JfhEzwOWO3CtG5QBUoE/hNzESylVVZEvO4jKwtZKfUiQXnn4FwTtfBlDXTbSZbAXCoKuyi1lCUvNYFupYLsFNkEqCC++IO/njt6i7y8v6Ia1NiouFXqX1gHzxShecdd5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199719; c=relaxed/simple;
	bh=cE3RFdQDlR8xQX7mvAp4ctPTCLn01POosDTBFFGQ4lk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JP1RaCn3iNm4FyrylqZptLvbFPJcSdOe0DV6srAXRDkxjaVNgqqwE+jlxsd51MfXe/AvUhqZNGGIW3Leek8bb8rhPZ51YBUBz8atKRu2YJXmW5eT8DP4rIYOLfO03mz7ARdKmtxyVOVHFwmNOXdsKuorpbjXsrCdO/kypLtbdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UDmeoemP; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765199717; x=1796735717;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NH+P540j674jKep8OGKNKOl9cpTm86nan/sWIUcpW6I=;
  b=UDmeoemP4s2//bbPXXuhcDq2S4Kq2z3d2CeMyJIn6FAF1UyatCSToAKU
   FrIDJdgaWUZoxkYe279OdtjUylu8ihavb8KIyY4ZUMK63/tJU3Lfb2UOL
   8Y49amSVk8KGfwIX3AnZdMUmYfo0LjBV+1pY2coWUnifR0x4akN78NyC/
   xJWoUpKQ3YrzdfOLyoJ/OVfGjzMMdoEv1PC2AWt/AIcbP5QpcyTGnjUYv
   A6xSPkU/OLlORfkRJeAJsdljLC+zs2YOapb5QjoUtXpE+MlGwJcUTiAvG
   HhzLE601CKALq3Ucj1RgQ98HIdv0I3CaReCmBAlqg+duDVd2OQ/wQD/Lm
   g==;
X-CSE-ConnectionGUID: zPFZ2qicR3+K+Vw/d6vwaA==
X-CSE-MsgGUID: RLvkZHz4S6OV8vEyXDF7DA==
X-IronPort-AV: E=Sophos;i="6.20,258,1758585600"; 
   d="scan'208";a="8460938"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 13:15:14 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:11740]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.136:2525] with esmtp (Farcaster)
 id 2789a50d-4ee9-4aa3-9f83-432ffd98fa8a; Mon, 8 Dec 2025 13:15:14 +0000 (UTC)
X-Farcaster-Flow-ID: 2789a50d-4ee9-4aa3-9f83-432ffd98fa8a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 8 Dec 2025 13:15:14 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 8 Dec 2025 13:15:10 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, <kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH bpf-next v2 0/2] bpf: cpumap: improve error propagation in cpu_map_update_elem()
Date: Mon, 8 Dec 2025 22:14:30 +0900
Message-ID: <20251208131449.73036-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series improves error propagation in cpumap and adds selftests that
cover the failure cases.

Currently, failures returned from __cpu_map_entry_alloc() are ignored
and always converted to -ENOMEM by cpu_map_update_elem(). This series
ensures the correct error propagation and adds selftests.

Changes:
  v2:
    - send to bpf-next, not to bpf
    - drop Fixes: tag
  v1: https://lore.kernel.org/bpf/20251128160504.57844-1-enjuk@amazon.com/

Kohei Enju (2):
  bpf: cpumap: propagate underlying error in cpu_map_update_elem()
  selftests/bpf: add tests for attaching invalid fd

 kernel/bpf/cpumap.c                           | 21 ++++++++++++-------
 .../bpf/prog_tests/xdp_cpumap_attach.c        | 19 +++++++++++++++--
 2 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.51.0


