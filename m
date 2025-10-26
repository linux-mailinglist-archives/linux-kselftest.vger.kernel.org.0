Return-Path: <linux-kselftest+bounces-44071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35F9C0ADE5
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 17:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39DB3B4757
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6B254B18;
	Sun, 26 Oct 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gtF5Mof7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8AF242D97
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496733; cv=none; b=lg2omVbpCcwOBYmTixwd5UIeb5DOLWRUzX/J1+lHuoe5Bkacggd9y2EmT8qlosewjYLASfZOUkkvuL0yIuk6mxC7UOJS/2UvbI/inyZlwy7H7FYokGO/ZLdUb6SHAvf2wx7JvEquzqBz/HQp5fRqAM0xLj4cxBUNj8PpLyIPc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496733; c=relaxed/simple;
	bh=Sj7EQgk8COjO3En+I+4AkavknHt8j+R1rN2b1IapuN4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KAtxFWDkTyK5MP1pnhKI+OwdORtJLexwvA+Y3gEGC0JeamXhaFB+VZHSROkJzZthQufAssjeC8/nVRkTGm9mlioEgKXjfCxympuDXmsZgvTG2KlENSwDPqdNWCBiYrThh9jxIkJitZrVxNKDliaU+QtP14VWUtzvHHxysavDMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gtF5Mof7; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761496719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fEkR8ho0e0lDa+wJBLIyXVGdc4q/yccEqcF5GhbP2yU=;
	b=gtF5Mof7PMvxtGDGArhqFttn4RhPsRee+89QxyKDY0n2f/xvLGMeKVUxnA3MAfkfgGrGC3
	jd3cSqKm1EEcMOaIMRWYh79YTNKtc7su7WA6UF+yI8Lbr/V6g9SFh3e5qUbzLuceucGCHq
	7X5XSU1DDP88E/k6ROO/e2Y+QGRzUAU=
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
	memxor@gmail.com,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	kafai.wan@linux.dev,
	luis.gerhorst@fau.de,
	shung-hsi.yu@suse.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: Fix tnum_overlap to check for zero mask first
Date: Mon, 27 Oct 2025 00:38:04 +0800
Message-ID: <20251026163806.3300636-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid verifier bug warning when tnum_overlap()
is called with zero mask.

---
KaFai Wan (2):
  bpf: Fix tnum_overlap to check for zero mask first
  selftests/bpf: Range analysis test case for JEQ

 kernel/bpf/tnum.c                             |  2 ++
 .../selftests/bpf/progs/verifier_bounds.c     | 23 +++++++++++++++++++
 2 files changed, 25 insertions(+)

-- 
2.43.0


