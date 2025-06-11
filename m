Return-Path: <linux-kselftest+bounces-34684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAB5AD5205
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93424173FE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2C26A0B3;
	Wed, 11 Jun 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I71yfH3A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4FC2g7Z+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA64275871;
	Wed, 11 Jun 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638047; cv=none; b=ANob/PaGNqRDj/XSTkUIxJfYUslozYMQlfEw/Y+b11AHRuJHHQ9llSzdZn0rYxJtfzjo90DuWbuTE7O59AnjuA2S9vH5URReaoMFt9X3Ff2tfzWnYXD0N+waF1idn3QVpXgRmPGX+z3OyffhkLlew3YhIScldiSudp3uLVxkpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638047; c=relaxed/simple;
	bh=Jd9bN1x0QUY5vumCRf0DJ1rTzHAMY7u+Dc+/Xk5jW5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxPv2kgd9AHyeXHFgsLUHJ8M5EufH/rFje/V1JQkdMt2XYlAoGVkCo9wJENF4UfmsYX09ZC0EWrP44MII+ik90rs4WFMi+3WUkJ81+oolW1Wig5B7F1ZljmaNoCr5bwteZC7hdPOgAdXMIU2VExzL9n8aWKVrxy+RZX5TFpj3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I71yfH3A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4FC2g7Z+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749638043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6Qg6NrTIlROWiZjlcUgHvA4YqAO2DpE5nyR3C7rQFQ=;
	b=I71yfH3ANbOHXgnZ7WaWgYC81MTvC6Y4TUAA2WrTNdH9cqyGuEOlA+DK03syWO45yKuoLq
	VS4btwQ2BQQCzgUujg6qxvtjRqV5Men2bxot44e376HG6Fw4Sie174l7RjEb7a8l6YOEuD
	ygaOv1E8qXNOFYL6ehANIdXgMZkrH2ozL/1jPJLnPf1o8AvCyd2R53M+nx5YFKlWqX4aM8
	ENs5P8X2ioqY8dAocMyKsPD5mhKSyKQhkJ5s5McmrNyDN4o+RE6UrDzdQEuWSr/7OMAH4z
	ni+cQZyMQzVQWAIVcpHf47CjS+oAnUbFRaJ1NBv1BTaBzFxwz2oNmDVyBpD6JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749638043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6Qg6NrTIlROWiZjlcUgHvA4YqAO2DpE5nyR3C7rQFQ=;
	b=4FC2g7Z+fsxwc+rtFLA2ZRo81Ouhyvsrmb8oxCAww+mIDOqWeORVSAPnmBu2fQOdEQ5cua
	7yDdaOUByvzuHXAA==
Date: Wed, 11 Jun 2025 12:33:55 +0200
Subject: [PATCH v3 5/9] selftests: vDSO: vdso_config: Avoid
 -Wunused-variables
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-selftests-vdso-fixes-v3-5-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
In-Reply-To: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749638036; l=1265;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Jd9bN1x0QUY5vumCRf0DJ1rTzHAMY7u+Dc+/Xk5jW5Y=;
 b=dcs51nCEYORy2V/C5S1KGZ4opd6IQLCqDROIu/JKl9ov9W+hqeLN/wKIjMskk6Hs9OdzaGGvz
 S0Qze2tBoiOBIdvpEp4NjaPEIEqqFDYoaplR75G5dLISE33KsfRg9zx
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
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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


