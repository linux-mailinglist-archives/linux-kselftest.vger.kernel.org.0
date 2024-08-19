Return-Path: <linux-kselftest+bounces-15629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B26E95670E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 11:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245C91F22D6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 09:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C804115ECC0;
	Mon, 19 Aug 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="O2ReNIug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC615C14A;
	Mon, 19 Aug 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059884; cv=pass; b=KKXqrf7AjKER6Y4SXDsR1Qbn2PuuVGyzNNIS55J2jN0kSRFLulH8qw+QKUYkE0e0S1uF5+CshCjxdoNPLzhKwx9ccgmun3qaY73Pwd8bJPqzwI1sx8wloueb68sBh3Hw4JIVgufX0tRyxdQzGz44FN1gbT67O7ftYQlLOBhEOwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059884; c=relaxed/simple;
	bh=SrrhtEIIFUe7algni/la03aIO19Z9C8mC8ADl3cruuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ByCbXf1ZzzwpYBjRvP7LEletqlhrt3xNYyegiyM56xCN/GeqdTb3pifRE5jStJb0xqJTSLhPUwDQFjvxb6C5OSNqbaa/OuhlDZSHAtrPmWzdfhVibMQPX8ky1dKT7B3Jur1NNg8wcORdSAX2Z1K85XWovn0AjrZV+5yGvNAsB2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=O2ReNIug; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: usama.anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724059869; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JimiMCkBda7mvCzC9psxsMxwORgR1EQrd5G48XhsmD3i2HgCdreMJOfMEnV4tARRaPdcGSVygBBKcP4rEol1KmPskqH4mzJX/3k0duyNyVhOPDRc52ysmY3YmPVFOYeBX67qIPXX0+kVpY3rQkvH9YmH8BazbvdZB3wY6Urnv2Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724059869; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WseWT0AzOXOI2uqPhUX7ZJugBuRLM2tFOo1I3zX6X3I=; 
	b=SC37Q8p3r3wsa5PTsZUY+P4htA9Ms3ve1AmxCpy5uExBjwnkkxmavzAdONaAfuD7Th034wjNNhuOAVvEeiYaaMfVo1N6cV562y+MYwqnd2PBVsUZGYGs2AMi2BbmFjI6/yh0LCYH7LsH0bjvqWfF6k7LOajPU5BhGzdqp0JCUrg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724059869;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=WseWT0AzOXOI2uqPhUX7ZJugBuRLM2tFOo1I3zX6X3I=;
	b=O2ReNIugktKLpMLqSXEod/wXFG0vun7lrjEK/07UzBoaDAzsUNjTmDZCOSUTpFoG
	r9S2Rxv7qxWqyxSyX1ljhz5JKpr1QAl4kDZvuL8RbxesH1sx7xHw5ZzSOyNvDlBgeaM
	ySca7+/9TrijkSxXCqGgloxzysX/l2bjRQLNdf6A=
Received: by mx.zohomail.com with SMTPS id 1724059867772582.7950323534847;
	Mon, 19 Aug 2024 02:31:07 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: kvm: fix mkdir error when building for unsupported arch
Date: Mon, 19 Aug 2024 14:30:28 +0500
Message-Id: <20240819093030.2864163-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The tests are built on per architecture basis. When unsupported
architecture is specified, it has no tests and TEST_GEN_PROGS is empty.
The lib.mk has support for not building anything for such case. But KVM
makefile doesn't handle such case correctly. It doesn't check if
TEST_GEN_PROGS is empty or not and try to create directory by mkdir.
Hence mkdir generates the error.

mkdir: missing operand
Try 'mkdir --help' for more information.

This can be easily fixed by checking if TEST_GEN_PROGS isn't empty
before calling mkdir.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Instead of ignoring error, check TEST_GEN_PROGS's validity first
---
 tools/testing/selftests/kvm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 48d32c5aa3eb7..9f8ed82ff1d65 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -317,7 +317,9 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
 $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
 
+ifneq ($(strip $(TEST_GEN_PROGS)),)
 $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
+endif
 $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
-- 
2.39.2


