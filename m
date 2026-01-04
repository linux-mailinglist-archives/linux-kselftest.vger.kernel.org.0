Return-Path: <linux-kselftest+bounces-48132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1E0CF1215
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 17:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4377B3006590
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C4727FD56;
	Sun,  4 Jan 2026 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QbbrUXYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33D273D66
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543905; cv=none; b=Hi8dbpxgFHsBCOvkwtBTpp7oK2gVL1hmfRkbCA20pAEIe1X/hQeh0/tdPVdhdgX0lJZd5gNLttaVjOaz+q6OOUDqmnApuLVHgqiSYmYKNNrNw+7KdD9BxA97qL9+a9W34gU5cM+r2/XALaQtqVYrpR/f0r32j+Jj10CV8Luslos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543905; c=relaxed/simple;
	bh=91jkGKfDJwn1XnLEZU/KmWmRlnEhLxr/3bEtwdraeCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovejrClPHFA/p5RW/NYFbPY03+VL/fmCUKdgx/3S/iN6P/2oJEW63DE7gtotFclW8vT1NwnO2Aw882tt9dRLAgdjGQHj1Xz2RRU4L7q1qhBjFFWIwJtc/AxMO74Ch0TFwQRCYF//F4bI1A0rC9ycGhoarTCchQiikUUWEbcYFaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QbbrUXYB; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767543890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghm38KeLA+Zt1e5ioDPfhSJ87XBSGozi7s0hux0wgYY=;
	b=QbbrUXYB28c0COIhrJjJZA77B0Un8m8cBW4PtN4KlNMyzUrXnQUAVB3WZZyVyKs4Up7jPr
	fWcuqatbn6fXyz3iDqRwcQBDxZMs9zfX4EVq1p9DbtlEqoj5sDVLB6I2kuwOPAgVLUGdB2
	HuVp46jcI2ku0zPyBJQFSYDqekMUm/A=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	shuah@kernel.org,
	aleksander.lobakin@intel.com,
	toke@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH bpf-next 0/2] bpf, test_run: Fix user-memory-access vulnerability for LIVE_FRAMES
Date: Mon,  5 Jan 2026 00:23:48 +0800
Message-ID: <20260104162350.347403-1-kafai.wan@linux.dev>
In-Reply-To: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid user-memory-access vulnerability
for LIVE_FRAMES at specific xdp_md context.

---
KaFai Wan (2):
  bpf, test_run: Fix user-memory-access vulnerability for LIVE_FRAMES
  selftests/bpf: Add test for xdp_md context with LIVE_FRAMES in
    BPF_PROG_TEST_RUN

 net/bpf/test_run.c                            | 23 +++++++++----------
 .../bpf/prog_tests/xdp_context_test_run.c     | 19 +++++++++++++++
 .../bpf/prog_tests/xdp_do_redirect.c          |  6 ++---
 .../bpf/progs/test_xdp_context_test_run.c     |  6 +++++
 4 files changed, 39 insertions(+), 15 deletions(-)

-- 
2.43.0


