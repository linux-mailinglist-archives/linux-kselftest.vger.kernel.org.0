Return-Path: <linux-kselftest+bounces-49250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E3D39314
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 07:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D59F730049E3
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 06:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BDF265CD9;
	Sun, 18 Jan 2026 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRnOMNHl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04821E3DF2
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768719340; cv=none; b=pcW/j+C1WTLl1mB4DoqlMIjehWeYjnzgRfzJ5zCYMWiHO2GMEqqM9kX5TH3tXUa1wCLsRKm0mBADov34e3QQuUQdGq4ZVU3IFq+mNvMYbAkQXU49yDMmeEmvc1a84I8y8w4j0V8zyQId264DF62UWdl3szyE5RDqviXN32DZbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768719340; c=relaxed/simple;
	bh=u/GjgTAvMfnOixIrqpZgUxRPxejTvZ25uycB9M0lvlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZBdnlNJ7X6wLFpevzbK+Txg2oPicJY7csAgJsLsUeGMIGIHdrw/sAZxfbZAQubo+lpzHIa5zLXDdYUttMRncSoLVIlRXvFNUeAI1YPp5yD1RkKqgOOxrnp3s84IdXQJQNsUjTCtvjg4AH4/Ka2Ztv4kJ6xSGLFzPczyk0i31du4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRnOMNHl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so24912765ad.3
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Jan 2026 22:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768719338; x=1769324138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=syz4hhKfkVl8CBRKwpksblWsc7ovAlARMhsU/2akUZk=;
        b=VRnOMNHlXADqspHg1auuyItR2vWrMm/PSRw3Tb6h4NtNNwo6c6rsh3mXgkQ8U6zVVX
         GRUN0hlOfJW/2FhkI78VMD6HjIh9CwPyCg38PYXlwHRJhH2W5yz3tcJsCrjD0Fmp2T/G
         qBQDm4r3argcjFUEPtIv4K05sCXyld6tGtFen6bO1r23S3zGD35/55OAoJYWNyrWnCTe
         aGNaTAkbOlmevLzB9TJMQ2nF0Df8j5SSXWBVYfpc0QEZk+slUvGT3Nft3MX0gHjg9XUq
         Zq/3nEhmpxg1+wuNiwRGPoDFaxJtfGY907Ue1SLJszzvmalQCd7vhItus6CNxQe6tcTW
         I1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768719338; x=1769324138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syz4hhKfkVl8CBRKwpksblWsc7ovAlARMhsU/2akUZk=;
        b=MMdtVYgHacwsWwlr18eobnxUZ16z7o3bfUhWLLpB6p4Ttz3S4I61KPub53WzPAYdef
         IcjBc+bDhSdwum/4c9tFeb6IiYOEgYbVonY4tuXY4W98OdvCNVSgAtMznTKIugjh/ns+
         73DfuEL7PWMp5j+KW/t4o1Nw/JmY4yu6MYInejcf8nyYID+8zQnY04W56C0KbSyA/PIk
         +8eIbcIw/YcGf+T3Un8U/l/yDl7Fy75xAWL4teK+gcuQINnZ6UtLdTP8Sq3faNOF+IjB
         7Gjc6M4EXhU+hryydpKRwmLsUJX4brmrakPzQ+fSb+DT7pdiFLiHOcP8kb3TFMNpq5rD
         WHQA==
X-Forwarded-Encrypted: i=1; AJvYcCUTjLT94Mq5QHpvnA/qN/WAFn6rEVJoyeCkViO/n4KnInooQImyiYNPI2OPGd8n/WaBFrHfqOBcJmSjp4mqerE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhXK/gKfcZhzbiE5LHyEQLMSjIyUzR2w34BdxKS/D1BC59mzft
	SANpBsREsKw5LeHZRxtQXmzGPlpunYUirfEeucrydQfJJpdfdU59Nrla
X-Gm-Gg: AY/fxX4gMkiZ8JGaQkwdGqyD3lP+WTD0pHCkPUoZPFRe03biNuGOLgci+FQPU5YeEM3
	qAN7Shmt+xqtH7qK0cJpxV/ySjxG7pXfhJBpNjO1g6rKpWMbLneJp4iktJgAi9SXPXlo6Dh5KBD
	umGPthZeVqNsAqnntaMFfJQBBdR8dSbbWL5Av10jxJ8MJ9j8uC0UwMGBptkwNSeQk3VigvTuOf+
	0cLP2R9Sle57ziB6XEnDGCVFUQg4gGhElZ2OmTSJQyhTcClfN/U7IfHgBmg8yDTlvZiOZKdabcM
	AASJ3mL765i0KoWyRULUeBX31OShBp2ccZGMMeUazAO/lyjfDiakLSGJlofV3TLoasb4zeWQ4gx
	Uta7Xb+7XX1eY2zL/5TM6HZX751uF/TuH8iAopD6mqGdnKyAWjI+1z0cM4h4+g2m/v7+iYa1wg9
	WZAiI8V4yiJjz/HFkr2wS62bA=
X-Received: by 2002:a17:903:1104:b0:29e:9c82:a920 with SMTP id d9443c01a7336-2a7188589bcmr73881425ad.6.1768719338281;
        Sat, 17 Jan 2026 22:55:38 -0800 (PST)
Received: from localhost.localdomain ([222.110.133.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ab97csm62215735ad.11.2026.01.17.22.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:55:38 -0800 (PST)
From: LeeYongjun <jun85566@gmail.com>
To: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	LeeYongjun <jun85566@gmail.com>
Subject: [PATCH] selftests: alsa: Remove unused variable in utimer-test
Date: Sun, 18 Jan 2026 15:55:10 +0900
Message-Id: <20260118065510.29644-1-jun85566@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'i' in wrong_timers_test() is declared but never used.
This was detected by Cppcheck static analysis.

tools/testing/selftests/alsa/utimer-test.c:144:9: style: Unused variable: i [unusedVariable]

Remove it to clean up the code and silence the warning.

Signed-off-by: LeeYongjun <jun85566@gmail.com>
---
 tools/testing/selftests/alsa/utimer-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/utimer-test.c b/tools/testing/selftests/alsa/utimer-test.c
index c45cb226bd8f..d221972cd8fb 100644
--- a/tools/testing/selftests/alsa/utimer-test.c
+++ b/tools/testing/selftests/alsa/utimer-test.c
@@ -141,7 +141,6 @@ TEST_F(timer_f, utimer) {
 TEST(wrong_timers_test) {
 	int timer_dev_fd;
 	int utimer_fd;
-	size_t i;
 	struct snd_timer_uinfo wrong_timer = {
 		.resolution = 0,
 		.id = UTIMER_DEFAULT_ID,
-- 
2.34.1


