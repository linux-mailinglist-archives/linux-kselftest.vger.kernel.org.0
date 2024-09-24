Return-Path: <linux-kselftest+bounces-18296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD3C984524
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 13:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832A8B22DC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C0613212B;
	Tue, 24 Sep 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iHFYVVVL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA912BF25;
	Tue, 24 Sep 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178616; cv=none; b=qIxCLBSZ7Iv1rrtOVovpPnPIyjLNTkl5PmR8vuC6kOLqBe2sopVjB5+VCe5+paLGS6RRbNE8QLkjvwWZ1sT3W/eQ0LzAnUAw5H7R8/uew/GSWlC28acwTiu6fm6EcT4IQAZSo9YfpX2YXT1NuV9Mzm8T3BxPvsBSuCWKvA0yV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178616; c=relaxed/simple;
	bh=B0vGTGuGETOSe4/CrulkHq90ReEW/9D1uyFMYsYhYFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJp6lSxU0+S4G8xoSeA66MvcGKceFej4XfAShLRvPlHmAwFc89MQN/z7Of//FrIWxwGQ500/xJTxTYWb3mZLW8kJM4C7KZL4roHmuLCXJXxodXu4y16JJh4gKGgv013z2q+anOSiE9LmsEybWDhI62vTodcL8El1Y0tGHv/Y4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=iHFYVVVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AE3C4CEC4;
	Tue, 24 Sep 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iHFYVVVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727178612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7o71oK5hozmjw/7c4MUUMAtZ3Jk8dSM5xTWF5ssidyw=;
	b=iHFYVVVLVpYaUgy/T0qXm50B5e/1eF9YN4TQxUJwustv/MzWTgl0tY8ugG3EBf9eXpZU7C
	Kyj5kW4MbLeAxXFEa0YhaER9goXFpaBGiWeUNnVGfUDCoMDnE9IzbBc0u/ZKvfa0b7G/1N
	KIkpiYK2vTjnQ/NF7AgKWHZUg/9qCEM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8c0faff3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 11:50:12 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: christophe.leroy@csgroup.eu,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] selftests: vDSO: align stack for O2-optimized memcpy
Date: Tue, 24 Sep 2024 13:47:23 +0200
Message-ID: <20240924115001.916112-1-Jason@zx2c4.com>
In-Reply-To: <202409241558.98e13f6f-oliver.sang@intel.com>
References: <202409241558.98e13f6f-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When switching on -O2, gcc generates SSE2 instructions that assume a
16-byte aligned stack, which the standalone test's start point wasn't
aligning. Fix this with the usual alignnent sequence.

Fixes: ecb8bd70d51 ("selftests: vDSO: build tests with O2 optimization")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409241558.98e13f6f-oliver.sang@intel.com
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/vdso_standalone_test_x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
index 27f6fdf11969..644915862af8 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -131,6 +131,8 @@ asm (
 	"_start:\n\t"
 #ifdef __x86_64__
 	"mov %rsp,%rdi\n\t"
+	"and $-16,%rsp\n\t"
+	"sub $8,%rsp\n\t"
 	"jmp c_main"
 #else
 	"push %esp\n\t"
-- 
2.46.0


