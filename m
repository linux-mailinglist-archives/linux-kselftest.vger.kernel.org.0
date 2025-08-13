Return-Path: <linux-kselftest+bounces-38860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD11CB24D86
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F3A562F1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651125B312;
	Wed, 13 Aug 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h2vzrFgK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200C259CBF;
	Wed, 13 Aug 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099030; cv=none; b=kKdUJNGocAqy3vSQDo4mewQfZEBt/kYqFdU44Rb1cvzvfIqOEM9/GcVHk9dXfNoPX61/oNDegVsLCmBU/83UkHcd4if/wB6p0ejY6vA2WmyPzhm8KoteaYoFGgmA6Z0wxlhynzTd29dXqw/SbSuZ1qd8+GqAUyRnxd5426Tj2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099030; c=relaxed/simple;
	bh=Lq/MnBJO7IgZrEMAWluUyyddXBO6L7dMH0/XYrmHcf0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LzTzexqXeB5SZnYWqzFAfHzo/CnlcDI5L194m/zKhwkfDEt5EmTMHoStH3v9H2UH7J9bdl4c5BMg2PcAeFDeYBTwwF+M5YWUon7AEDa8Opm8Z63NcMMpe+JtL1konSiA4iQbbx5u9shA1dPqUqJfwK4lzFjgS4NddGiaIioM2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h2vzrFgK; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755099025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YbKIrg1u+aegCZtj1WAHU6eFnKOD0XbkWiMGluO5IUw=;
	b=h2vzrFgKPvgV0rds3aqAio70G3hP1AIFLxbOsX7gfavp3K0Ps4wuo0ukHltPOsxlMtr0ma
	vN6df2RLBi9JFUKnzUSOGWsoo2ri4zIDbS5A/7t3wmn/SqStunZAXuZXnzCRCFb6D8pi0W
	FqrddFnWclpXKZZ0Hc7Rj2ApLjZMFjk=
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
	mykolal@fb.com,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	mrpre@163.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf: Allow fall back to interpreter for programs with stack size <= 512
Date: Wed, 13 Aug 2025 23:29:56 +0800
Message-ID: <20250813152958.3107403-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This change restores interpreter fallback capability for BPF programs with
stack size <= 512 bytes when jit fails.
Add selftest for socket filter to test it.

changes:
v2:
- Addressed comments from Alexei
- Add selftest

v1:
 https://lore.kernel.org/all/20250805115513.4018532-1-kafai.wan@linux.dev/

---
KaFai Wan (2):
  bpf: Allow fall back to interpreter for programs with stack size <=
    512
  selftests/bpf: Add socket filter attach test

 kernel/bpf/core.c                             |  16 ++-
 .../selftests/bpf/prog_tests/socket_filter.c  | 124 ++++++++++++++++++
 .../selftests/bpf/progs/socket_filter.c       |  16 +++
 3 files changed, 149 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_filter.c
 create mode 100644 tools/testing/selftests/bpf/progs/socket_filter.c

-- 
2.43.0


