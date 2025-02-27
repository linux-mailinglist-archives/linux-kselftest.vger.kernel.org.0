Return-Path: <linux-kselftest+bounces-27773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA67CA48152
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E3F7A88AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CE238D21;
	Thu, 27 Feb 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fvJIXCW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B92343AB;
	Thu, 27 Feb 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666453; cv=none; b=HBnJIxuYtHFm/UzC1FxwtRZNBNJm/M0XiWFNF+nCAuZf+svoX7hVmQF/RhQ0QeOIFDRs+Ln6iCM65vk19gJOKKEXFt6Y5pXyqt5VTuLl/ahQJxrASYfg8OPvI1tuua7KCtbW9HZ2CKr+r+eTlchOBuQhYjVKKcPBE32Ln1iESVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666453; c=relaxed/simple;
	bh=n4EvS2tujlITFMmhI1w8JTOm/HL+ES1yhv6hk/Wk0Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeXK9r/TYNpqqVAjMQLkOM+gc0+D+HgahVekLh9gX0WrOREoxlxwSkf//uedqTsGJsxVYb6VodVLDxO1cZw88yNE68igIbEvIJB65HPM4qay/yj0hZL+A+QkG1B1lO2fnbXOzFbWg/EK6rbovE87DUnD3Bj2Tff9MoKEJG/Csmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fvJIXCW5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740666450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aagjyEaL1HJrTcuwbXuuxWhha8H/1pOmC7GbTqPHhw=;
	b=fvJIXCW5O3SFzdRVlqNHIXFvxueNSmtKxq4Uu1qC8YagvVdnuIQ/TqRUcKyaVIhnw1ldCB
	q3k9GzOa44xYHh3wle8san33RyvGO/v+gs47VgID+CVz7WJC/hVEY4eeI1+Xx/FfGjXmhy
	yEl9Gsqn2NJeBdP6GN0ekdQSgFTn0ro=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Fixes for test_maps test
Date: Thu, 27 Feb 2025 22:26:46 +0800
Message-ID: <20250227142646.59711-4-jiayuan.chen@linux.dev>
In-Reply-To: <20250227142646.59711-1-jiayuan.chen@linux.dev>
References: <20250227142646.59711-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

BPF CI has failed 3 times in the last 24 hours. Add retry for ENOMEM.
It's similar to the optimization plan:
commit 2f553b032cad ("selftsets/bpf: Retry map update for non-preallocated per-cpu map")

Failed CI:
https://github.com/kernel-patches/bpf/actions/runs/13549227497/job/37868926343
https://github.com/kernel-patches/bpf/actions/runs/13548089029/job/37865812030
https://github.com/kernel-patches/bpf/actions/runs/13553536268/job/37883329296

selftests/bpf: Fixes for test_maps test
Fork 100 tasks to 'test_update_delete'
Fork 100 tasks to 'test_update_delete'
Fork 100 tasks to 'test_update_delete'
Fork 100 tasks to 'test_update_delete'
......
test_task_storage_map_stress_lookup:PASS
test_maps: OK, 0 SKIPPED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/bpf/test_maps.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 8b40e9496af1..986ce32b113a 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1396,9 +1396,10 @@ static void test_map_stress(void)
 #define MAX_DELAY_US 50000
 #define MIN_DELAY_RANGE_US 5000
 
-static bool retry_for_again_or_busy(int err)
+static bool can_retry(int err)
 {
-	return (err == EAGAIN || err == EBUSY);
+	return (err == EAGAIN || err == EBUSY ||
+		(err == ENOMEM && map_opts.map_flags == BPF_F_NO_PREALLOC));
 }
 
 int map_update_retriable(int map_fd, const void *key, const void *value, int flags, int attempts,
@@ -1451,12 +1452,12 @@ static void test_update_delete(unsigned int fn, void *data)
 
 		if (do_update) {
 			err = map_update_retriable(fd, &key, &value, BPF_NOEXIST, MAP_RETRIES,
-						   retry_for_again_or_busy);
+						   can_retry);
 			if (err)
 				printf("error %d %d\n", err, errno);
 			assert(err == 0);
 			err = map_update_retriable(fd, &key, &value, BPF_EXIST, MAP_RETRIES,
-						   retry_for_again_or_busy);
+						   can_retry);
 			if (err)
 				printf("error %d %d\n", err, errno);
 			assert(err == 0);
-- 
2.47.1


