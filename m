Return-Path: <linux-kselftest+bounces-37843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDE8B0E09A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 17:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B971C8205F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ABC278E77;
	Tue, 22 Jul 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OgNsbpjc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FA278754
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198529; cv=none; b=SM+zelv4ibgKAlIfxRPsGRcB5vQusBcEqXssfDZjkteuK9RonYGWsNIzPLco2vw5KM381f0frXP1MVXyfmNo/W2xHvaLm6/rJwNu2S4k9ip8XaxTstmkmj0lC/DKHrPyZtvlCifIuFOJtwgvlJyuH73PGUT6G2HwzhYnpjXQ8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198529; c=relaxed/simple;
	bh=TXC0jzWUxyeA40ayoyWkerpcYh7WExKkbc+qnS5ks0Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=r4PMxMA1bSnNnDOan31RsVLoNbC8tMWg7RHT3itBxzCI3n8T5q5GmsuVnvpUBP+AEZsePGcJleX3DkAeJ2rUhB8yQeAvTkqrvr9W7myh055Vo4GkunhBi1VuuaOcr0kFVNZNRWOB/i/wUQ49J5kpMYHuGjTrAM/kclxwSPud9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OgNsbpjc; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753198515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xh4LPphC6fvNyzC3xKXkuWTCa65+atiUsQY/kPj004Y=;
	b=OgNsbpjc+rLtNneZOANMOjCUzxjrdi/elcIuf9obgzsfjJkqkOQtbgZRZCKqLo4uSOiCsx
	PrV9mGaNxcAqcpoZ3DLFzsHlBLrjqLX49ScN70TQ8S3Vm+jrdAybNF/1WqKK0AdIdQA6i+
	qWtAqNFg0tarlHFpJUNq+5TUJ9CpYSM=
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
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v3 0/4] bpf: Show precise rejected function when attaching to __noreturn and deny list functions
Date: Tue, 22 Jul 2025 23:34:30 +0800
Message-ID: <20250722153434.20571-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Show precise rejected function when attaching fexit/fmod_ret to __noreturn 
functions.
Add log for attaching tracing programs to functions in deny list.
Add selftest for attaching tracing programs to functions in deny list.
Migrate fexit_noreturns case into tracing_failure test suite.

changes:
v3:
- add tracing_deny case into existing files (Alexei)
- migrate fexit_noreturns into tracing_failure 
- change SOB

v2:
- change verifier log message (Alexei)
- add missing Suggested-by
  https://lore.kernel.org/bpf/20250714120408.1627128-1-mannkafai@gmail.com/

v1:
 https://lore.kernel.org/all/20250710162717.3808020-1-mannkafai@gmail.com/

---
KaFai Wan (4):
  bpf: Show precise rejected function when attaching fexit/fmod_ret to
    __noreturn functions
  bpf: Add log for attaching tracing programs to functions in deny list
  selftests/bpf: Add selftest for attaching tracing programs to
    functions in deny list
  selftests/bpf: Migrate fexit_noreturns case into tracing_failure test
    suite

 kernel/bpf/verifier.c                         |  5 +-
 .../bpf/prog_tests/fexit_noreturns.c          |  9 ----
 .../bpf/prog_tests/tracing_failure.c          | 52 +++++++++++++++++++
 .../selftests/bpf/progs/fexit_noreturns.c     | 15 ------
 .../selftests/bpf/progs/tracing_failure.c     | 12 +++++
 5 files changed, 68 insertions(+), 25 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 delete mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

-- 
2.43.0


