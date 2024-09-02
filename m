Return-Path: <linux-kselftest+bounces-16936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC43968352
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 11:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9709C1F2163A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 09:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912C01D27A9;
	Mon,  2 Sep 2024 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DHAHV/+v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32D1D4600;
	Mon,  2 Sep 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269591; cv=none; b=TDDTYPNC6m7OCBxIw7bBEf14CazCqn7lZSllUwIREQiABoVIQyM7QOIsRuprqjBAhCmU6L5tzZTk+fod0Y5hLMdOQDO1NbeYdQJGj15ZlgCVEok2BiH2iZwN7BU59r8YqLNK9P0+MkByxvTqLytbsyPN6FTS/ph9Sv6hrRqUmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269591; c=relaxed/simple;
	bh=/ywkmSDiz/LnLATR1K+5lE/O9riJKh5k4UrAo5BJKmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXCXrjacnOGTeHt7MipViitrhNyLGW7kZQ8h0T2eRYR9IOgXpJh6JAgi+yccoC3HJIXVSjnk0KWe/0hdV3NB/u/SCBM2g4j+q6sFokG5eiW13d0zxGv4sI5MQkXke/kC8YICS2JDfw1KA+UmchZlWBDuKR9U4UpkyTIhzGuDCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DHAHV/+v; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=8t/9R11y9WzMjl6WDUd5IoEaVlGq5A+d/FgzVIbj16A=;
	b=DHAHV/+v5z7FIO/q0BvYLE3HDSPoBDz6goSffGxhnHh3n3QAnx1Nd7AetsBCiE
	lYCsEr3zQt+WoEWDIoJ2PYg3wjaO24jOY6whGBKGzfxFx02iPsXQbn7hmAy0Oeoj
	u3/rKGo98P+Uu8XVmJrK9koZTKp5QWfmecM7VguCjwSo0=
Received: from localhost.localdomain (unknown [120.227.22.125])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wD3_x9AhtVmyBj+Kg--.58067S2;
	Mon, 02 Sep 2024 17:32:49 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix procmap_query()'s params mismatch and compilation warning
Date: Mon,  2 Sep 2024 17:32:48 +0800
Message-ID: <20240902093248.23473-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_x9AhtVmyBj+Kg--.58067S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr45uF1UWF13Ww4UWryrXrb_yoW8CF48pr
	4fJ39Fka47KF1UX3W7GF4kXrWFkw4kAryUAw4jqrnIvFn5J3WxJFsakFW5uFWrGr9Yyr1S
	yayrKF92ka1jvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jv38nUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNwZOvWXAnCO7gQAAsi

From: Yuan Chen <chenyuan@kylinos.cn>

When the PROCMAP_QUERY is not defined, a compilation error occurs due to the
mismatch of the procmap_query()'s params, procmap_query() only be called in
the file where the function is defined, modify the params so they can match.

We get a warning when build samples/bpf:
    trace_helpers.c:252:5: warning: no previous prototype for ‘procmap_query’ [-Wmissing-prototypes]
      252 | int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
          |     ^~~~~~~~~~~~~
As this function is only used in the file, mark it as 'static'.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/testing/selftests/bpf/trace_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 1bfd881c0e07..2d742fdac6b9 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -249,7 +249,7 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
 #ifdef PROCMAP_QUERY
 int env_verbosity __weak = 0;
 
-int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
+static int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
 {
 	char path_buf[PATH_MAX], build_id_buf[20];
 	struct procmap_query q;
@@ -293,7 +293,7 @@ int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, si
 	return 0;
 }
 #else
-int procmap_query(int fd, const void *addr, size_t *start, size_t *offset, int *flags)
+static int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.46.0


