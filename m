Return-Path: <linux-kselftest+bounces-13343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9324192AD79
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C478B1C213DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B193A1C9;
	Tue,  9 Jul 2024 01:00:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9783717F;
	Tue,  9 Jul 2024 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486817; cv=none; b=UWeltbkkgTQgkIXgY3SjB10wOGjASitUFcqDVbuqPLVJpfmkZwM9ZcTyIbExMG2oT6gZbMA/nmdumj69qvcIIBU31Rjhwo/N1I54RtNZPHWwrIXxALPF2n93JGaId0egLbVwRh/bHqVHBI4ArammWZdvublBW6QRo3b52d3dcw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486817; c=relaxed/simple;
	bh=DCgQZ0V97LeODbU+jANYGac8jCb2C4pq7bcU9vU4LGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NhiU4+284mIl4ginYofdHe30hO9lgCOTCEFNRJ2MI7MyH3UjUwlNwhEF5mtDj9xcpO7cxO6rq9DGdqle1G3dOV9NWMoP+eobSbArKzU+oA9SQpIVxgiI7Rx5jgBwXQSzVb0OSzxXjJ6pg43uiGbxfsYJHMK0ERIw0OV8waYgJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WJ2cD5gx9z1yvCh;
	Tue,  9 Jul 2024 08:56:12 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 980E4180028;
	Tue,  9 Jul 2024 09:00:06 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 9 Jul
 2024 09:00:05 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <mykolal@fb.com>, <shuah@kernel.org>,
	<liaochang1@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH 0/2] Optimize the return_instance management of uretprobe
Date: Tue, 9 Jul 2024 00:51:40 +0000
Message-ID: <20240709005142.4044530-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)

While exploring uretprobe syscall and trampoline for ARM64, we observed
a slight performance gain for Redis benchmark using uretprobe syscall.
This patchset aims to further improve the performance of uretprobe by
optimizing the management of struct return_instance data.

In details, uretprobe utilizes dynamically allocated memory for struct
return_instance data. These data track the call chain of instrumented
functions. This approach is not efficient, especially considering the
inherent locality of function invocation.

This patchset proposes a rework of the return_instances management. It
replaces dynamic memory allocation with a statically allocated array.
This approach leverages the stack-style usage of return_instance and
remove the need for kamlloc/kfree operations.

This patch has been tested on Kunpeng916 (Hi1616), 4 NUMA nodes, 64
cores @ 2.4GHz. Redis benchmarks show a throughput gain by 2% for Redis
GET and SET commands:

------------------------------------------------------------------
Test case       | No uretprobes | uretprobes     | uretprobes
                |               | (current)      | (optimized)
==================================================================
Redis SET (RPS) | 47025         | 40619 (-13.6%) | 41529 (-11.6%)
------------------------------------------------------------------
Redis GET (RPS) | 46715         | 41426 (-11.3%) | 42306 (-9.4%)
------------------------------------------------------------------

Liao Chang (2):
  uprobes: Optimize the return_instance related routines
  selftests/bpf: Add uretprobe test for return_instance management

 include/linux/uprobes.h                       |  10 +-
 kernel/events/uprobes.c                       | 162 +++++++++++-------
 .../bpf/prog_tests/uretprobe_depth.c          | 150 ++++++++++++++++
 .../selftests/bpf/progs/uretprobe_depth.c     |  19 ++
 4 files changed, 274 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uretprobe_depth.c
 create mode 100644 tools/testing/selftests/bpf/progs/uretprobe_depth.c

-- 
2.34.1


