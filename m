Return-Path: <linux-kselftest+bounces-17920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3997786F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 07:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB82833B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 05:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762CC186E5A;
	Fri, 13 Sep 2024 05:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cbBQJOSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8021D52B;
	Fri, 13 Sep 2024 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206217; cv=none; b=ieOwNpXfZGCVR8wdrXCFHmgGdBpnOM8w8fYfKBf2xpevQ93X7ys5jcsxzHj6mEtt95uX9Tg9bLcqeM1Yl6iemL4MUUkiBJ9T9Wf+TMbWcZ4N4h7FS8aJXFqQLIkBPDqkuxGZ/gAPzAq43JN5HFoQmMT7xYMTxMjmsXHzz32XnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206217; c=relaxed/simple;
	bh=6igXgBzJbL/bxr+9RONfH/CyyIxiTqnZKHLRBoihv2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B41W1HqSbR77l5+jqwizlq8mlsZop5pqCNbW4N0pRdAHs4GkKyQOiOuRCRw8XDTCT+qAPg5mb6LJIUB40ZkoYsJMhHsiDrpoT0aJ6asAG2K5L09+gx6G4WJd2v99RnNCNrJJwY4/OIPFTGLCzt/xMg1jCBUW38FHvcH8SOdsYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cbBQJOSQ; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726206204; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=C4W/4ycTRzizrdX3vEha8KtLmRwzwt5L/4YB4OcI418=;
	b=cbBQJOSQ5mnGnBmR5bHq3CK0uUYZmTr1UQjMMBeJ68/EGHYZ9yyOeJtFjFK6cBr3963CnKlRMvBlA1kIqV4ZnIM2GZSRQF0FvzvWFI5YKZ/NSafFC6JBQlYAg5vWs687H78dTG/gOxCq0ZmOheVK+u+Hgt7fvY30kXo5p968X6s=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WEtnxii_1726206196)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 13:43:24 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: seanjc@google.com
Cc: pbonzini@redhat.com,
	shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] KVM: selftests: Use ARRAY_SIZE for array length
Date: Fri, 13 Sep 2024 13:43:15 +0800
Message-Id: <20240913054315.130832-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of macro ARRAY_SIZE to calculate array size minimizes
the redundant code and improves code reusability.

./tools/testing/selftests/kvm/x86_64/debug_regs.c:169:32-33: WARNING: Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10847
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/kvm/x86_64/debug_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index 76cc2df9238a..2d814c1d1dc4 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -166,7 +166,7 @@ int main(void)
 	/* Test single step */
 	target_rip = CAST_TO_RIP(ss_start);
 	target_dr6 = 0xffff4ff0ULL;
-	for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
+	for (i = 0; i < ARRAY_SIZE(ss_size); i++) {
 		target_rip += ss_size[i];
 		memset(&debug, 0, sizeof(debug));
 		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP |
-- 
2.32.0.3.g01195cf9f


