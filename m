Return-Path: <linux-kselftest+bounces-16885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C91966F60
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 07:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39211F2358E
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 05:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAA6BFCA;
	Sat, 31 Aug 2024 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="fG+vSqJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19094339A1;
	Sat, 31 Aug 2024 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725081660; cv=none; b=iInENjojwf8zuIyi6OarfpvMyhrvleIOmryHvOSDU6IDgW2KQGdt0lpQyv+gb/ziWrvKX1j1eZATiNYfG7zlJt4lzyaeZF7RdhAXt7KcEeU79ez9zIAd+BFf4IgOPKtSoDVrKbsY279z6p4UOc4/wXrLeUvfnE+17b7wDkhVc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725081660; c=relaxed/simple;
	bh=kdh5MZ5G8BVHDgqG9m+qNc/EQP6z/M14E6kJxvIu4j4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=k2KH7jPNZ2e9sYR/dybFQiWWoS2JJIXJ3FWOfHBdvkdNBhfV0IrFnTLcBfwGOsWtVzHADnxjEGO4sGsXugc4tOwQKtldXVSgpE/OgQ4H96f1lF2ZOCAcld7qaS66uzpzT8cVlQOm/b3TBcV9k4HXeQvU2kPNsdkA6Q1l5UpgddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=fG+vSqJy; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1725081649;
	bh=dPCF7zEC8o4YbyuKZZOy/BoxK53N327mCoWJOObDk/E=;
	h=From:To:Cc:Subject:Date;
	b=fG+vSqJyYn2NNfgU79RBzde0rne3NjGCa1TgDTLQ1BEmwga5AjOwckeR4N+TvPWSe
	 zFJ103J5IE4Att9HZ6wTPiJxSsyB811zE0fok6MC+6MczElveC6kCFCPQOsJPlX/ld
	 TYt3EdKMCc+TKALRTWUMUIaOJlu5gx1ph4CuoPBg=
Received: from rtoax.. ([120.245.115.147])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 3A00768F; Sat, 31 Aug 2024 13:14:32 +0800
X-QQ-mid: xmsmtpt1725081272tm5fidhfo
Message-ID: <tencent_0AEA8FB622DE1A740841643D5F36ABF8BD0A@qq.com>
X-QQ-XMAILINFO: Mo29KZ8DTxVy9fyeeq697G/FCZgvHQFzayZ6l9T5hdgFj6qXrl4TL06efq3wIl
	 BuZm5PYiXdWk5HkvqKVBN3eHIbt6D8rJh/TXV6vivKByzgNAvQ0Td7I3V+5dI9MAGr06WLUs1DmQ
	 e1OTf0Jdtzr0cgnGkcQly89KzH58MlpE5nAUXLfdB6JNzSkFIxewdE95BNXXRYo+9PnC2PKQyslw
	 tGLvlLUNL0SihmptRNMxBu+ZKqAqQd5jd/8V2WGEVHfeX8ecaXgcrdxGkarp50Gafqpv/+KiHPvN
	 rUVaU61r/CelCZJREzgXfAS5N9D2eKn06MZitffmAbDv6AoNwwp0wa9JuEqfbR2Pt7IQJFd9w8hI
	 0U/BZcTtjf3Blmw2W6zRo+AFsan/LJPk9rWq5lJ+3iSpWAa3eV2xNEvgyn4Vy3F0jCS5IcyMPKUI
	 bkVW8FAaFLiJIiCvSGZtCNRhDJoLHfF+c+DgxNyblhfEN3xFKiAglmUngOPu1m6jj6m0ipX9bS38
	 +TN3K/yAyXZTi8EmnNa9QJSM8k/LL1fWnyJcIFB55qXnG4wcfeaVejf+/WidTGOdKnZjGZWHPQJa
	 EAyOjLM0shNjbHNhK+5TPvCER/0q020asTXPCjIr7ib3I8cR8BQjgDy0j1kMalJrdaWxD9nQk9cf
	 1wgKWXs4C0vPc8B/3RGtNK1khY0y2YDevEMU3sd4vpuQY2ryatfmUXA1lSEkqJ4fGptOXNGeRTqW
	 4bvQxVheAXls3W6Edfx5Ko7BdLYfBXJiaXlsSSvCfiI4XB7WAHtywUGIH7hf2FuhtvVZx9q2UzNL
	 D3OqN2r1wisned3PMkWlqo04gAbxclfHl/5HzG4vE8Elt5ccrY17TJcCkSARvn3t8j1woz+DVNDp
	 GnmZZWv40ZvOUMvhIth64Uct7lYGrJ9MDYAn/cGcS65McCLzcqP753ud056tTuhZrb2RcZD/uNMA
	 2zsMosbveqKLK4xT5rGNTGVbuU11Uusashe9Y6kFO8mJlQaeJRnxeo8Mday1nyFU7e1GWRtWbXuR
	 ZY3ZLoxQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Rong Tao <rtoax@foxmail.com>
To: shuah@kernel.org
Cc: rongtao@cestc.cn,
	Rong Tao <rtoax@foxmail.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] selftests: splice: Add usage() to splice_read.c
Date: Sat, 31 Aug 2024 13:14:28 +0800
X-OQ-MSGID: <20240831051431.29326-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Give the programmer more help information to inform the program on how to
use it.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/splice/splice_read.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/splice/splice_read.c b/tools/testing/selftests/splice/splice_read.c
index 46dae6a25cfb..73a8bc146f97 100644
--- a/tools/testing/selftests/splice/splice_read.c
+++ b/tools/testing/selftests/splice/splice_read.c
@@ -9,6 +9,12 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
+void usage(const char *prog)
+{
+	fprintf(stderr, "Usage: %s INPUT [BYTES]\n", prog);
+	fprintf(stderr, "       %s /etc/os-release | cat\n", prog);
+}
+
 int main(int argc, char *argv[])
 {
 	int fd;
@@ -16,7 +22,7 @@ int main(int argc, char *argv[])
 	ssize_t spliced;
 
 	if (argc < 2) {
-		fprintf(stderr, "Usage: %s INPUT [BYTES]\n", argv[0]);
+		usage(argv[0]);
 		return EXIT_FAILURE;
 	}
 
@@ -49,6 +55,7 @@ int main(int argc, char *argv[])
 		      size, SPLICE_F_MOVE);
 	if (spliced < 0) {
 		perror("splice");
+		usage(argv[0]);
 		return EXIT_FAILURE;
 	}
 
-- 
2.46.0


