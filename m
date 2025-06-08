Return-Path: <linux-kselftest+bounces-34438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBC8AD12AB
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jun 2025 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D247C7A1738
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jun 2025 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5107211A05;
	Sun,  8 Jun 2025 14:38:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146EE13AC1;
	Sun,  8 Jun 2025 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749393538; cv=none; b=PLKirUj3q+bhO3MleOSpWhVu0xoh1C6HEdMYPfz3OK+9FcwJOiQw2yPwcWV1wxfU3j6ZqvvMmQ6kPYPNSVJPk1qqbEYgH6Cyq31XpV7bMH4T3UF5WsT3j5I91l+nqGvbOyJkxT2z6wqwcye+NzOS2tAqmUfXZ4QZ/HBJPY2GSLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749393538; c=relaxed/simple;
	bh=GjCBinQ9WgSLDZp6lILM9aqYmuXijKRPIVCVTB+1wEc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tLCZGK6ZJqPHC5Gr/W6QoX44CncN4m06N0kIDLBzDOl4jqqdo50jmvuMEufcyKHkYtKxUkpqBAsZNaIQdg7Q+BKBtKrEOP2amQP4ZUd05oNixgV6Zdt2qOa2WpMCYIqRISkb/aOrvg+b5KL8A5VD7afbmu22F4Ga6ZsxWu4AxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: wangfushuai <wangfushuai@baidu.com>
To: <andrii@kernel.org>, <eddyz87@gmail.com>, <mykolal@fb.com>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <shuah@kernel.org>,
	<mhal@rbox.co>, <jakub@cloudflare.com>, <thinker.li@gmail.com>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, wangfushuai <wangfushuai@baidu.com>
Subject: [PATCH] selftests/bpf: fix signedness bug in redir_partial()
Date: Sun, 8 Jun 2025 22:36:23 +0800
Message-ID: <20250608143623.25242-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

When xsend() returns -1 (error), the check 'n < sizeof(buf)' incorrectly
treats it as success due to unsigned promotion. Explicitly check for -1
first.

Fixes: a4b7193d8efd ("selftests/bpf: Add sockmap test for redirecting partial skb data")
Signed-off-by: wangfushuai <wangfushuai@baidu.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 1d98eee7a2c3..f1bdccc7e4e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -924,6 +924,8 @@ static void redir_partial(int family, int sotype, int sock_map, int parser_map)
 		goto close;
 
 	n = xsend(c1, buf, sizeof(buf), 0);
+	if (n == -1)
+		goto close;
 	if (n < sizeof(buf))
 		FAIL("incomplete write");
 
-- 
2.36.1


