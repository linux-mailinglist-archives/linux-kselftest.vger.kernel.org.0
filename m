Return-Path: <linux-kselftest+bounces-43770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A332BFD590
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3247D358689
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB742853F7;
	Wed, 22 Oct 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DglCSK7/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE9269B1C
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151585; cv=none; b=eQwkqn5mUTHoaCS/tMWnHy3p1tKYjUK2UDeNuExPK2WoHMaUeWmKtxLCdzRYacRaeTiGefSYiSB86uo5irGaJ4Zv9F1N2ZAKc4T3AbJZ/9dDtnawAl3nRaW4gUcQ1nn4MSMVTUuGoKyCbWbXmiaE3iZ3UL5PZI42+yf+Pa/liwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151585; c=relaxed/simple;
	bh=kHipxjPKdfKyZjusmW/Xen/+cggiUczv4HaoaLIzec4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZfhd3/GeP1wl/Nst6E7nQ1ywNXok4wSaji0P8Cvmw2GAkeRJd/B6/OTNUFaaLduyKto+VU0UiFYWuGekYgO5GBlWGuATpQAiwp+L0wphiE6zMIFcsqVznZdrw/5lXzaILGEESDX4qVY0i1IP4CbIe9x2Oael3D+U58vu4A3S2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DglCSK7/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761151571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YR3WnEjvrHHzguVdZ+7J/zHY0xABiTWzZ7eMT7M8+Do=;
	b=DglCSK7/VAhxn7bUjD72797plehx2OIH1weyvIRcgUYCfvrG/Xa2C5H1ADDd+geZrS3grI
	sAxp1WAOBdxuaxSPhxH5JlVTsuopnm/x0zh2fwb4Q9d3uzgOm2YeoJ0iI3r2YfCPXvOyXE
	Fg8WURLOUskyp2geh7U9T36eIACet50=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	m.shachnai@gmail.com,
	luis.gerhorst@fau.de,
	colin.i.king@gmail.com,
	harishankar.vishwanathan@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH bpf-next 0/2] bpf: Skip bounds adjustment for conditional jumps on same register
Date: Thu, 23 Oct 2025 00:44:55 +0800
Message-ID: <20251022164457.1203756-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid verifier bug warning when conditional
 jumps on same register when the register holds a scalar with range.

---
KaFai Wan (2):
  bpf: Skip bounds adjustment for conditional jumps on same register
  selftests/bpf: Add test for conditional jumps on same register

 kernel/bpf/verifier.c                           |  4 ++++
 .../selftests/bpf/progs/verifier_bounds.c       | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.43.0


