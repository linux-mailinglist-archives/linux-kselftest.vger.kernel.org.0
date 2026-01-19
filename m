Return-Path: <linux-kselftest+bounces-49367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98443D3AC41
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95E9630E8565
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EEA3803D4;
	Mon, 19 Jan 2026 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KoPGdF5E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D33803DD
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832628; cv=none; b=GkyoYgrBc5RLbWA3vuw6tKcOfLBqwf/wMXo4HmvtYnvbKjIce0+1qZEHcos0A3GsIgCTlipPBIv502ReKHcczkiNd6wPxeu6EBhPiFCWVZKYt8IJAp2UbXkCKpyP5+wMO3WPjjNqgKOM+yoI9B9m0unWSgUPhd7HMlhs2zXzSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832628; c=relaxed/simple;
	bh=zVGZh7eFDDPz8YwCWOxi/FDxpsyLCNTp4r0ypycyE+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dV4EBbUA1Fx3M9VxH2Qyia0yWPZ9ageJIkxZC23ibWvg0DdNaZDsYBwEU8RLradtMm4iGm6Dgl2LOuOBtWiDnNzswM8XQyc+/X91QF1B/g37nTGcFSMGJ5S9TJKDC0EYd+a2rIuDUrYJx0P08R4zgISDvy6HBzeOImyiQzV3rWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KoPGdF5E; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768832623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3T80oN8F5GALi0Utz+Tw6OTmbiEVk1RUB4ZQwlgHphc=;
	b=KoPGdF5EZZ7HlwpXKoAv0qVESjP/Sbh4uL6L/VcRMqyJ0mgCXmUnFjCynxsilJEMJK17it
	pF5xBNu4tGBGv27+tBe8LKcApkPQT7ZHGghcn8PhJDpqpFUgJXFsQSLZJcMeEQI53fXbS9
	ldaR2YmCGNdWdFgk3bjX7wnCITiW2OY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/3] bpf: Avoid deadlock using trylock when popping LRU free nodes
Date: Mon, 19 Jan 2026 22:21:17 +0800
Message-ID: <20260119142120.28170-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Switch the free-node pop paths to raw_spin_trylock*() so callers don't block
on contended LRU locks. This is a narrower change than Menglong's approach [1],
which aimed to eliminate the deadlock entirely.

The trylock-based approach avoids deadlocks in long-lived critical
sections, while still allowing locking in short-lived ones. Although it
does not completely eliminate the possibility of deadlock, it
significantly reduces the likelihood in practice.

LRU-related deadlocks have been observed multiple times, including:

 - [syzbot] [bpf?] possible deadlock in bpf_lru_push_free (2) [2]
 - Re: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and local storage maps [3]
 - Raw log of CI failure [4]

BTW, this series also factors out the bpf_lru_node_set_hash() helper, along with
a comment describing the required ordering and locking constraints.

Links:
[1] https://lore.kernel.org/bpf/20251030030010.95352-1-dongml2@chinatelecom.cn/
[2] https://lore.kernel.org/bpf/69155df5.a70a0220.3124cb.0018.GAE@google.com/
[3] https://lore.kernel.org/bpf/CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com/
[4] https://github.com/kernel-patches/bpf/actions/runs/20943173932/job/60181505085

Leon Hwang (3):
  bpf: Factor out bpf_lru_node_set_hash() helper
  bpf: Avoid deadlock using trylock when popping LRU free nodes
  selftests/bpf: Allow -ENOMEM on LRU map updates

 kernel/bpf/bpf_lru_list.c                     | 35 ++++++++++++++-----
 .../bpf/map_tests/map_percpu_stats.c          |  3 +-
 2 files changed, 28 insertions(+), 10 deletions(-)

--
2.52.0


