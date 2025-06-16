Return-Path: <linux-kselftest+bounces-35066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17DBADB01E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DAE188F2B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F84F1EF36B;
	Mon, 16 Jun 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy19Yfjv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33F2E425A
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076675; cv=none; b=EvE3jaidxUKX2julo55wRk8uHbysj4GSPOdWwG+8dEzVfbw8JPa0XHkYzEuan2wzMt990q4chNjDzWaFoSQ493Cw61JEx8ANbknipPbsiYRF11XdyxpcCz75s0Ar5ZEGbaReeMrBfledJESuQHuAz1Z0HmdqFez63NqeGBLhhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076675; c=relaxed/simple;
	bh=opIQOAD2ZClX/na4ZFIvwcZTKIw9Y3y8I4AF0J2lX88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K/da7BeBtYQb0eIMWvwBgljqu6jwYtoQtaN1oC1T/sxYed+1j+anm/sbksCGVv29hqIbOpiRiqlp67WB6RNbV06j7VL2xRFmclePqnDFTInW4FtywDWaZc4itAtzDo+CyYnk5MSxjR4X4+zIz7+qSzehbg30iqJxrvehGDVAAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy19Yfjv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so8462070a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 05:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750076672; x=1750681472; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nTsbWROq96tG2AbE5vFFnvADMcynnaQTC97yHym3Xus=;
        b=fy19YfjvsqsZ6f02RaNqGfHH9jLu5L5h9cbl1l+K2KcrjBEz+8d6vk5TQOJVLkn+Iq
         V0++paayJ6Tk658ou5zQ6Xh7C7UTy4gpDKxb5rhm7q9pMN0Y4LdK4OaCW3zUVD2T7DTA
         dWObh0sMNZejvx5KIyc1ZXx1CIDqA+/biGUPiuYsWgRjMdakYedMqrZbxWpOtaGeDb0Z
         T+FGoBcnld+uvo713rHaHRzXpdYJn8TZAlJfJjJMoteamJJ3Me2YMqCMbJ0DvN6cOS7e
         yxm5OFpCknYdTCp1drkbCxHY1LmdkavoA6YtXmHG4IWpGeMxdvSPVqYkGlPxusPbGzxk
         u3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750076672; x=1750681472;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTsbWROq96tG2AbE5vFFnvADMcynnaQTC97yHym3Xus=;
        b=Gm8OpOehadPvojL1TJVYa1nBawXtYmoPOWhXBSWiKdJMnVlC/WQopsGTCS//na3r3Y
         XJ9kpqUCMsDgR9yPJLPPmzFZMM8QUUppy9bBkltD9kc98AewspH73KtXdz5DPre57jyv
         d8U12A0y3ZKpNLBAj/05C+vZql4izyWwfnzve/egdr7LdFEyzeISxSh+Hd4a1Ac1xoZM
         0irrOogoidO5BVYfU1+MxYq1zeT9dvzNhiYEHeVP8H3afdfDdeBEYjXsL/U5RZvdOEYj
         +yfp+QsfFJTAaXj3EfxFfJjrbbgmVGlsjqaFrL91ubq1BEIix9+vH7NPt0X7Z/D5x1CI
         ciog==
X-Gm-Message-State: AOJu0YzbzDjZw8DUAuGuuHTlBS1whgL9nyPkS+s/DFFavyERsd1XMe85
	R5z6FUUBwJ3UXupTTCDP6hWvV0ZEqBF2iZ+AIsKEq1kJhMhmRRYebZrg
X-Gm-Gg: ASbGnctSmlqboTexmAYgErMxi+7NTvuVRUmM91MiX4RhpDCJv0pLl58xbUbRtqy2H/T
	b06aUOKZxGbvElitylYnmH/9m6e/Nv8yxogmRKzL75L42k7b0300saQLg79xKg2jC9kdh9W+EAA
	VVi7Qs8sFcME+n34gTUSP9UxhwtauWh9jHvdUMaGAe+nxHORm04joAburHflVFvj8nioxttMb4h
	JhwpLajWyer3AxQgPQVsSb+2Ehed33kPtEaMiasfMRnJkNGdOT640WarojegYvOIYcpQ+faA1K8
	HI/JM1qqdMAlW64buNxqSiMlTg9QvaHk3Jd1iiJBX9Aqu4egNBeCwv2ewA+G+B9WYNTFfDHP
X-Google-Smtp-Source: AGHT+IFSRVKjlFXIGKetJ4CxS2ZPzNz5S6ls32lqD5TETxsuzvu+myFf5f6id6kdl8rGSPSy36/rZQ==
X-Received: by 2002:a05:6402:40c3:b0:602:ef0a:cef8 with SMTP id 4fb4d7f45d1cf-608d09c0ademr6978584a12.18.1750076671919;
        Mon, 16 Jun 2025 05:24:31 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a5bbdesm6153426a12.46.2025.06.16.05.24.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jun 2025 05:24:31 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	usama.anjum@collabora.com,
	skhan@linuxfoundation.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/3] selftests: correct one typo in comment
Date: Mon, 16 Jun 2025 12:23:36 +0000
Message-Id: <20250616122338.32678-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250616122338.32678-1-richard.weiyang@gmail.com>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The name is __constructor_order_forward.

Just correct it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995..674a6112e6e1 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -936,7 +936,7 @@ static inline bool __test_passed(struct __test_metadata *metadata)
  * list so tests are run in source declaration order.
  * https://gcc.gnu.org/onlinedocs/gccint/Initialization.html
  * However, it seems not all toolchains do this correctly, so use
- * __constructor_order_foward to detect which direction is called first
+ * __constructor_order_forward to detect which direction is called first
  * and adjust list building logic to get things running in the right
  * direction.
  */
-- 
2.34.1


