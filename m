Return-Path: <linux-kselftest+bounces-44525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1590C25E19
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7273A34EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E932E11AA;
	Fri, 31 Oct 2025 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XHdyN+cp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100052D4B40;
	Fri, 31 Oct 2025 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925449; cv=none; b=gr+eLOQ4UrMF1Og+pf9eaeHycFwzTuTU1xH5sFK7aJw4Qb/yHFjTcvw6KI2H0q9j06CQqrlnPr0ADrf7EnNTAYUNHr2Vu5G8S0hvwba7tg+FYrBa61y/QsnD/kHurjt2PNsFeE5mzcWDmWAmhtEsRCz1TF1e1itdmtpCVVGVSJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925449; c=relaxed/simple;
	bh=eal7PDItWPlWbiMcTsnIxrsXvwGEWuu6ZdgocoDg/KA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eiyPXxera17F4apZW/H+drBfy+An9f3dToJwLADBHv6nsTDDbb/r3kevQqqsTx7kF925LiNKiGWYADw1NuhkpDjFWhyeyfmVQM4KhtfFamx6/RiH0CB2DE0K9c+muftI4NbFApa0n0X9V4GBCzVPeNuyD9XCTllxkpkxhwB0aNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XHdyN+cp; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761925442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P6xjb+IZJVIDmv2kgaXp/7vkw59533Qmn8Z1AXli+YM=;
	b=XHdyN+cpcSsaX3IJvgxoC8s6RO7hIzjYMrdxRl/3Hmm52/XR4F3uPLT2DZAksV2aqvRTLz
	kM7roV2vziViM8n2DXPK6NQJ9/MXmUej3LwF2rnxaGY7KSqnAQQyMdRhQ2x7yD4jWlHcY7
	1fIEzh5CdSBu5EMMX3JdXNaRbI6GhGs=
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
	henriette.herzog@rub.de,
	kafai.wan@linux.dev,
	luis.gerhorst@fau.de,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpf: Skip bounds adjustment for conditional jumps on same scalar register
Date: Fri, 31 Oct 2025 23:41:05 +0800
Message-ID: <20251031154107.403054-1-kafai.wan@linux.dev>
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

v3:
  - Enhance is_scalar_branch_taken() to handle scalar case. (Eduard)
  - Update the selftest to cover all conditional jump opcodes. (Eduard)

v2:
  https://lore.kernel.org/bpf/20251025053017.2308823-1-kafai.wan@linux.dev/
 - Enhance is_branch_taken() and is_scalar_branch_taken() to handle
   branch direction computation for same register. (Eduard and Alexei)
 - Update the selftest.
 

v1:
  https://lore.kernel.org/bpf/20251022164457.1203756-1-kafai.wan@linux.dev/
---
KaFai Wan (2):
  bpf: Skip bounds adjustment for conditional jumps on same scalar
    register
  selftests/bpf: Add test for conditional jumps on same scalar register

 kernel/bpf/verifier.c                         |  33 ++++
 .../selftests/bpf/progs/verifier_bounds.c     | 154 ++++++++++++++++++
 2 files changed, 187 insertions(+)

-- 
2.43.0


