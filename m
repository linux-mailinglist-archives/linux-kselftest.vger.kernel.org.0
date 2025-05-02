Return-Path: <linux-kselftest+bounces-32191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002A7AA7255
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA983BA3BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4C1255F57;
	Fri,  2 May 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V+KrgAOw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wXiVl8Yk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6BB255250;
	Fri,  2 May 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189629; cv=none; b=mpNVS5uhSHUO0kA1FVbrn84yLv0jmQR68BEE2u0059mAI1PhO/9tC47BBNjKtgH1DGE0KLPJgYY+jDNvM/LmtwxhJqaRKiTe9FjLfZtNPCQelAsEXVLCcp2SE+6STqV4xG4d4wV2oyef3fvXkZdbk0V0rdTvC8fBQhpY92qnV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189629; c=relaxed/simple;
	bh=br7krp9+8M4zKe0RpPB+/gmM+jV6iMTWKPSaZ5x3GfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1EqYlHXmLbfLxcwM4k2IuKVmpAyQ82YhMOteXnf3Hue9jFZffsQrxx+/sWvFIKWV18ZXAP+P8r4t1VbuR8SsIf7j3QlHwbdBfuDZSZg/NM+hTZ+4xRaQ+eMhwtHfnBiT4/jyevuCeWOmsjoKZCriDMHKG85Rb0RbkhFxrHavqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V+KrgAOw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wXiVl8Yk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746189625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsLvWnvAGPHW8cTdtBfQSCkuvBKWmDlkApA1kk8SamY=;
	b=V+KrgAOw5PuLH8GdVzlBYkYvcH/FDHekDCyb6MKdd2gEPhsd46iMSJosMp/i2yKOkbApb6
	iR+U/H9e2SBMX8diFCkvl5ppO3Sv3Ovv1L1Qeuxi+/kmrM8BgJua55ukXDvMUP6C2tEm5F
	40RjmUjeb+jNNLZZRkEYLYRHPyQny9WxxqsMqlxgj+JmavnGTvRxGDefs9XW/vWg/gZMY7
	HlpkcvmhOsgYlXuUuHB066OCfBZYSNC3oreK/+KD7FlSb42XSCghEQvMMp7yvHq/80yeD2
	dAYL9Y5yVX9mW5dwaH7YGCJCugPwHRJpoKtVDAJrxhxiOk4oAiA1lHbpvcDzYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746189625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsLvWnvAGPHW8cTdtBfQSCkuvBKWmDlkApA1kk8SamY=;
	b=wXiVl8YkuBpFTjbUra7q0bBu0jnw5OGh3rmSWgrp9MFi8Q+2IE5sxApZw2eJWNzJaodIEm
	hoxn5nq2Qk/S/GAQ==
Date: Fri, 02 May 2025 14:40:19 +0200
Subject: [PATCH 7/7] selftests: vDSO: vdso_config: Avoid -Wunused-variables
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-selftests-vdso-fixes-v1-7-fb5d640a4f78@linutronix.de>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746189620; l=1202;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=br7krp9+8M4zKe0RpPB+/gmM+jV6iMTWKPSaZ5x3GfU=;
 b=TLpzHI9LeTS/mEEkxMznV8DaDu2giwQ86jopSAfLqJ32Lzr5PASkH2kIfAb5++g5gbqUyLytS
 6pUtIXuAky8BC4tgzry1A86GVLijk+J8HHJ99Yx6GdaPB82pgwi9VZz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Not all users of this header make use of all its variables.
For example vdso_test_correctness.c does not use "versions":

In file included from vdso_test_correctness.c:22:
vdso_config.h:61:20: warning: ‘versions’ defined but not used [-Wunused-variable]
   61 | static const char *versions[7] = {
      |                    ^~~~~~~~

Avoid those warnings through attribute((unused)).

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_config.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 722260f9756198956f0dfccced907284b6851e76..5fdd0f36233742bc47ae79f23d2cfae5a0f56dee 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -58,6 +58,7 @@
 #define VDSO_NAMES		1
 #endif
 
+__attribute__((unused))
 static const char *versions[7] = {
 	"LINUX_2.6",
 	"LINUX_2.6.15",
@@ -68,6 +69,7 @@ static const char *versions[7] = {
 	"LINUX_5.10"
 };
 
+__attribute__((unused))
 static const char *names[2][7] = {
 	{
 		"__kernel_gettimeofday",

-- 
2.49.0


