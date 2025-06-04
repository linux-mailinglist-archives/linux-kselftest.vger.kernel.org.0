Return-Path: <linux-kselftest+bounces-34283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3780FACD79C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 07:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E40188763F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 05:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016F262800;
	Wed,  4 Jun 2025 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="j8EUBg02"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64EF230BD2;
	Wed,  4 Jun 2025 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749016730; cv=none; b=HQ0n50PycJELNO7i8pWpxh3Ibb3Fp1RhbJv4Y7Cp0hrawx3PI2DcnyKRhtbtLv//ebOiy0KiDa+aJNnNEzZLxs9GxPOp30My8e2ZcpwqUBfaTuonJOQ+fkp1ZjVk47w3IEJtSJ/ZnORZgTj8EGVBmdxhoNF0C91oFE/k9LEaWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749016730; c=relaxed/simple;
	bh=T+0ACzjcRPUCr/NNL+Xz2/jt8sPhrX+Xfym653JfVTY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=in2ZVN4dOjp9IgnxEj/Y9QSZlQIXlKxJy8jsjA4186NIwRZbBBgv3BrTKDBf4zjkOCHk3gz8USWcN5aMBF2+VtN7jbSr7YMaaKuWCONGVebuLQRnx9sr9fgOG30hzqQfL/otdzPu7+59SSiZjvh0jR70xpWa5kmNekLantLAvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=j8EUBg02; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1749016414;
	bh=dxK57rrh1jvoo1g24molYIQ1YbfbH2OZpE0y+PyiV/c=;
	h=From:To:Cc:Subject:Date;
	b=j8EUBg02aEnilOpHZCWkZ0BRObtR1z8LLex8B0Nmvp5bywuBr0tqIFXqpgqtUN+Ek
	 DWPPmbKeK4FnK0LlnspTPyYrY9B0PEtfBFOqyuVCiSacdCNh6hpkMGmiTvADD9h8hR
	 R5EBvV1PNxaxflrmWghZzuC5hKu64CLZQWydpB9o=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
	id D5E8A2A8; Wed, 04 Jun 2025 13:53:30 +0800
X-QQ-mid: xmsmtpt1749016410tl4fl36g6
Message-ID: <tencent_A6502A28AF21A3CA88B106F3421159869708@qq.com>
X-QQ-XMAILINFO: NQzH8pzEc5hGPs3uj3kHrPeahZXak4dASrsyrlzi8+3SJ7ZOTDpWGr79QAvJA0
	 fhuR2sbv+Msr+YEK+VIb74pqi2uxdzWNu1OdHXfeB+gQ03Su/LZcBfmkwasrzX9FYuUnQXit9C+8
	 0IGhc4QLAqbKjZD2amrQ9T+2pXDPAHE6zE9GoK//b4lUK7qCg59+iZvbfFjqbiBHo2ENmXdEPY9o
	 zCcyfK05WmOKNR16Gm10Z71NYlowvtf8olaxSsExCHxDWghK7mKS53Z0w1Zlidk+iXMa/C4XQCiy
	 3PtbVLIPiynLUyTUW/WJrl/7CuVbUIpWgTYSdKL2pqwNrw/tDpSXOQ1hw8QsaEC9qQxeM4siDjic
	 xO5BKctg33BahoFO/o11+aebzWKaRomZaU9YeqRZILrG8rtEGKIjvpnFbIUvnHFq5qKCaV/1g9CE
	 b+Tvda3WblLyGp5R4B1ybfjTRi7bzLIhcObdUeogv0Ovz6nBlKdAlkhDlk/7TzI+JgLq0urLwHZn
	 Bd9mfje5NdZvG0aBDfd3HsARwebUUxi79N7F1hd+64PcRbaGV3qtIpaCdA6jwIHWOSb/VvXsf3Xq
	 2IIeq/+33mu/I7IkCFknTgMP3obpfF8b6sR+EIZJfYDoRArzXNZcHoZUv/2RgZ4mWUUvtu4yLLBQ
	 AML7h0BY4RTkSoFxrTSd5U0M4q0xWbywZiDdrTcKkLGDH4a8DZ0kJlCf2dljGbY0+QrBDnGbLd7U
	 YrdmJeSInyQ/AiQwoj5qfElxvyst5HOcko0dhXHeacRUWEDDbeEXzm5w5+s7gzq8AkXqMZqt1nKK
	 gawqU30CpqXDpEHnLpgGZ+tmOIklp4yY8TCXhdfQ9i1gjILJFTDL4EQZoLUrF26XXA8SGgzGoY9G
	 5SIOqn0KAkov8Plr9prRgfZzXXi4meZrkw/iUdPHs+vY5gdNQTZiakfZPdradkPBZ75gVmMfQ+fG
	 mzxismGJH8a23K/56wMcUloUA3OxUmqFqRJc0tai9nrTW5oqwHvx/QQNkfGv28p3VR+OPlF3U=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com
Cc: rongtao@cestc.cn,
	rtoax@foxmail.com,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Amery Hung <ameryhung@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Oleg Nesterov <oleg@redhat.com>,
	bpf@vger.kernel.org (open list:BPF [SELFTESTS] (Test Runners & Infrastructure)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] selftests/bpf: Fix compile error of bin_attribute::read/write()
Date: Wed,  4 Jun 2025 13:53:22 +0800
X-OQ-MSGID: <20250604055324.222850-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Since commit 97d06802d10a ("sysfs: constify bin_attribute argument of
bin_attribute::read/write()"), make bin_attribute parameter of
bin_attribute::read/write() const.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e6c248e3ae54..e9e918cdf31f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -385,7 +385,7 @@ int bpf_testmod_fentry_ok;
 
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
-		      struct bin_attribute *bin_attr,
+		      const struct bin_attribute *bin_attr,
 		      char *buf, loff_t off, size_t len)
 {
 	struct bpf_testmod_test_read_ctx ctx = {
@@ -465,7 +465,7 @@ ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRNO);
 
 noinline ssize_t
 bpf_testmod_test_write(struct file *file, struct kobject *kobj,
-		      struct bin_attribute *bin_attr,
+		      const struct bin_attribute *bin_attr,
 		      char *buf, loff_t off, size_t len)
 {
 	struct bpf_testmod_test_write_ctx ctx = {
@@ -567,7 +567,7 @@ static void testmod_unregister_uprobe(void)
 
 static ssize_t
 bpf_testmod_uprobe_write(struct file *file, struct kobject *kobj,
-			 struct bin_attribute *bin_attr,
+			 const struct bin_attribute *bin_attr,
 			 char *buf, loff_t off, size_t len)
 {
 	unsigned long offset = 0;
-- 
2.49.0


