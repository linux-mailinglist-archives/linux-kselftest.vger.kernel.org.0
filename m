Return-Path: <linux-kselftest+bounces-17016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28E9690EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 03:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF11CB21862
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 01:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8398E1CCEC8;
	Tue,  3 Sep 2024 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K4dpwi6Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41135894;
	Tue,  3 Sep 2024 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725326945; cv=none; b=tdguhkbFrblteKeGP7AyoQMU0UuU+j56UtdJGXV342i61dGhsO+lWTYo2S3ZhvKB737WQNSCyE26W0jxLWKUK0e6mifWccUmwqE5YwOztjmVzCtOFiUZCACGBEdcjfE8tHCgvcS1znNBnS/5Q6wCeJqvFHEXwIT3fd9QE4EgbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725326945; c=relaxed/simple;
	bh=ewLcDCB955THeX+myHKKDUBb9+AN7kD6zjieN/rwB9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g5D9arglp8VPmWdLzuEg/nqVIWppsHKVgw4akWMqO+invnxeZxqaFc5qdBQlZ/Tc2SopjGzaNgcQV0g9eUY3+KLWhD6L1GgFa1nBsdRutEjNTZoKm+tbhT1b6hnQ41f4nnXlcXkLFx8CuaU8DCd+02mzlr3yNePCreHHy39XskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K4dpwi6Q; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=7QEqUqVkOjsdylZ3LlxcjmjIRjs2Jr60I7ftoPbSY+4=;
	b=K4dpwi6QmQzrn4zhmUybTcGzqlzgtOpeBbLNnJIg0R13ym4NwDg4Yb4oZSQz5/
	aUaeWRFC+DnTn2TbpNyIt9YPrR1d0w1IP5eCpf9ZLjRNTjUXQ7ikMcGCSEGo+PRV
	bReT+mUaesn/sFNkzRsQhEsZ1eS/Zxh5mWQEANn/geV3c=
Received: from localhost.localdomain (unknown [120.227.22.125])
	by gzsmtp5 (Coremail) with SMTP id tCgvCgD3P0JHZtZmU6_PAg--.16445S2;
	Tue, 03 Sep 2024 09:28:40 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: andrii@kernel.org,
	olsajiri@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/1] selftests/bpf: Fix procmap_query()'s params mismatch and compilation warning
Date: Tue,  3 Sep 2024 09:28:39 +0800
Message-ID: <20240903012839.3178-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:tCgvCgD3P0JHZtZmU6_PAg--.16445S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr45uF1UWF13Ww4UWryrXrb_yoW8Zryxpw
	4fJ39rKa47KF1UX3W7CF4kXrWFkw4kAryUAw4jqrnIvFn5XF1xJF4SkFW5uFWrGr9Yyr1S
	yayrKF9aka1j9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAKsUUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiRAlPvWVOEkirJAAAsB

From: Yuan Chen <chenyuan@kylinos.cn>

When the PROCMAP_QUERY is not defined, a compilation error occurs due to the
mismatch of the procmap_query()'s params, procmap_query() only be called in
the file where the function is defined, modify the params so they can match.

We get a warning when build samples/bpf:
    trace_helpers.c:252:5: warning: no previous prototype for ‘procmap_query’ [-Wmissing-prototypes]
      252 | int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
          |     ^~~~~~~~~~~~~
As this function is only used in the file, mark it as 'static'.

Fixes: 4e9e07603ecd ("selftests/bpf: make use of PROCMAP_QUERY ioctl if available")
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


