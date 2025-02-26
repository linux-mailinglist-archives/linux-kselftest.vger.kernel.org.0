Return-Path: <linux-kselftest+bounces-27611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A189A460B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 14:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBFA18985A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 13:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE04E21D3E3;
	Wed, 26 Feb 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iIsvUNCu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B021D3DC
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576207; cv=none; b=u1f3Hok6eMsOVO0GmQaYJdtIycxBtzb22BZuO4mF3y0wOt98GbdIC8i/CggswiJ740sb1jJzGqPnjTicL2PCASGC/PHHJRnxLDJYnLpgTQ2XQ9Qy3I7Lgdxw3z/1rpX+7Tw5NIR8M071VnKz7vXNYu1ncN2+QtFHCrMjBi+cHLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576207; c=relaxed/simple;
	bh=jQ0mvOO2ZFMK8vaOnq+3OiJhcPOVu/rV64BQ6cnKjE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=br7k20FBYdlgmiHl50cZz7IOM4/sj7SO+f0GmUoi0D3Pphotb/oFWbYhCv51aHD/X41HL78QTYy7AN28+jL3AW0K4WAq+EtqUmlYxomhs0i4OrnRZekIWAYcv6k5H80IOBgxTpea6uBoR9f/l7Thjb92SKcMta5Xpgyb5Kbyqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iIsvUNCu; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740576203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCwtNd+g+fkSkGCZp+PS2GqWiSUDlgAUtiYKlrhsjEw=;
	b=iIsvUNCuEFDLIkKFagNZlQ8+lpviJYWHfbS0r85F6i1yJ8LUcsyoV3e1UAOX/M9CEkGtpj
	V6ZxgC/ScaLXFP81q6YEOP8gRuBW+7l1OwOOssJclu7+K4FyNqOzZZ/u06q+u0Mro90mCJ
	q4ZPuX0tZ7wiUHSnlfc/0AdR1ARDcBc=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: cong.wang@bytedance.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
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
	mhal@rbox.co,
	jiayuan.chen@linux.dev,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com
Subject: [PATCH bpf-next v1 2/3] selftests/bpf: Add socketpair to create_pair to support unix socket
Date: Wed, 26 Feb 2025 21:22:41 +0800
Message-ID: <20250226132242.52663-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250226132242.52663-1-jiayuan.chen@linux.dev>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Current wrapper function create_pair() is used to create a pair of
connected links and returns two fds, but it does not support unix sockets.

Here we introduce socketpair() into create_pair(), which supports creating
a pair of unix sockets, since the semantics of the two are the same.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/socket_helpers.h       | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index 1bdfb79ef009..a805143dd84f 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -313,11 +313,22 @@ static inline int recv_timeout(int fd, void *buf, size_t len, int flags,
 
 static inline int create_pair(int family, int sotype, int *p0, int *p1)
 {
-	__close_fd int s, c = -1, p = -1;
+	__close_fd int s = -1, c = -1, p = -1;
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
 	int err;
 
+	if (family == AF_UNIX) {
+		int fds[2];
+
+		err = socketpair(family, sotype, 0, fds);
+		if (!err) {
+			*p0 = fds[0];
+			*p1 = fds[1];
+		}
+		return err;
+	}
+
 	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return s;
-- 
2.47.1


