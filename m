Return-Path: <linux-kselftest+bounces-37950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CECB10E69
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 17:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C918C5683E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272B2EA49A;
	Thu, 24 Jul 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UzCI1Lzy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50C2EA15C
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370126; cv=none; b=NKOO5hzAtJVLYsyW0clCdVhI5MonZVzVu8D2rJcww3sQP37OYeYNhptxnlDwfyjUYXOV6BFdTX8bWuXloaD9C2O54EEJyvzTEKkQ90+ZJm9gAJYqWmd1m+KfI2Hme0HfJhxBnV54dXTKtI50RJB4orVg3AGQcQS0kIclvqPzpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370126; c=relaxed/simple;
	bh=HFs9e4GRx5Xr5NbjGGQjvwPKKVUUlE8Z0bI9D8f35k0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QA51hJ77yARg9BP0H5zzjNwJ4ivjyS+XT06lc8QFcjqGbUspSzX9ZrlsgJSdmHXpAoV9nO5l0QfEMvspRQlZS6LPaYPEjtFKKwT6MyrRPG8Uli+KJhuFIW4P1xQaUPbC7q0puAUMESqzgAMUXUUOC9Ax1aXS7uTnM7rmUMIZfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UzCI1Lzy; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753370110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=10zbmwKgUh+KE8grpL0UhT126MR+ngBmfxMox32GllA=;
	b=UzCI1Lzy1y0ac3ERbi51gMX1/Qz1dv/ppr7o0syCyS6F8Qtr6hWou+XYpaSOp1V5tgi9DE
	WDHKwaf8rtvrYZEwOhxUIbtsA6X0syicaNKhW7IUCRyVU2Y74RZ3llolbaHRyDUXZlHlJo
	fV835J8IFiR5UMJjLddoNda4/imc4pE=
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
Subject: [PATCH bpf-next v4 0/4] bpf: Show precise rejected function when attaching to __noreturn and deny list functions
Date: Thu, 24 Jul 2025 23:14:50 +0800
Message-ID: <20250724151454.499040-1-kafai.wan@linux.dev>
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
v4:
- change tracing_deny case attaching function (Yonghong Song)
- add Acked-by: Yafang Shao and Yonghong Song

v3:
- add tracing_deny case into existing files (Alexei)
- migrate fexit_noreturns into tracing_failure 
- change SOB
  https://lore.kernel.org/bpf/20250722153434.20571-1-kafai.wan@linux.dev/

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


