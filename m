Return-Path: <linux-kselftest+bounces-14843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A8E948EBA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E351EB277AE
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447DF1C4606;
	Tue,  6 Aug 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="Lk5nzlNO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F641C4609;
	Tue,  6 Aug 2024 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946279; cv=pass; b=DV3rvbM1aP/QgWRLXn9TnWZiviIyFmqcou4s5HE9w3J2siqvKq5YB99QzMBvzNpsx9WU5/9Vmk2YWwpzp/gXf6W6u9GI4edd/3sLkpbjNRbSUYYbDPH0r8rPxtclhzBK13Nnf3NX0djWqfJEh2M1SQB6v2nB6Qcwo4kpf9aBlmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946279; c=relaxed/simple;
	bh=p3fsxhmFTlHE8WKl7kT8o2EbqX+QKKZtAFdKzLhlWVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXTRckrFsFw8m4ipB8F4AbTxCHq7s5IfpPnN7Ta7QFL8LIbDBjd+teD6q0LdgKb5lTDMHfLe9WybEVzOAhAhPvB4kBf3EsuRItilAX1VVeCcMfZSSf/nARxOPnoTX8JMn50gvHqHU2TKtVNu2ooxemrguV0AQOdyPHCuIi2+mxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=Lk5nzlNO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: usama.anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722946268; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MVx1mu1i15YzdccykSN3UCyW/l7piyIFj1exHnwDI8NPoHACwioq8RQ7unH8O6VzB8s9PanaOyH+XccEv712uWt8RmG8/RVpvlvMr+5bxLMgWMlLLTV7CXMsLaqrzYfGaLnYVmD4dizD/TKXmnd403zIht7MTeYbKu8WU4/hKbY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722946268; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t2SIu7MxK2kRM/yUu/z/NSTqcIKafdAt/RiiaTDXUQA=; 
	b=IIS6frqrbgzTslQigK6wUdJZiuyf3H3U6/nqEIs6cnSsguaQdjpbacPvGHCejEBt3xdNQKmFXwk3TPauNWYQ4EmBWLDuz2s/dS/KbJtrQa+xYgXmaAr+uUXyhf6LA4t/CIvJVRWHBPHSCjOsCyyHnWDn6oZ8bU2cJyagDPxRCMQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722946268;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=t2SIu7MxK2kRM/yUu/z/NSTqcIKafdAt/RiiaTDXUQA=;
	b=Lk5nzlNOlNwQJQ3/lW+CN05m0kibXTWBNFGIhaJWW8GN9GD53R7R6ThOxKEDhvDf
	8qn7y1Vhc+KNpLdf6JtCvzLf2192XzJNqAHPfskFodMe0DEw8Eu1GlBOeWKdInS428m
	JMArVxUipcPbrEw876iSE6vFmtFvmtTpcBsGAdWc=
Received: by mx.zohomail.com with SMTPS id 1722946266733740.0620634044298;
	Tue, 6 Aug 2024 05:11:06 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kvm: fix mkdir error when building for non-supported arch
Date: Tue,  6 Aug 2024 17:10:29 +0500
Message-Id: <20240806121029.1199794-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The mkdir generates an error when kvm suite is build for non-supported
architecture such as arm. Fix it by ignoring the error from mkdir.

mkdir: missing operand
Try 'mkdir --help' for more information.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 48d32c5aa3eb7..8ff46a0a8d1cd 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -317,7 +317,7 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
 $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
 
-$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
+$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))) > /dev/null 2>&1)
 $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
-- 
2.39.2


