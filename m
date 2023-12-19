Return-Path: <linux-kselftest+bounces-2205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831A98188F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 14:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05E71C239E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7476819BCA;
	Tue, 19 Dec 2023 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2rgLoyi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5ED1B297;
	Tue, 19 Dec 2023 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-5ca1b4809b5so1461400a12.3;
        Tue, 19 Dec 2023 05:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702993847; x=1703598647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7mA8MymjOnfLLN21jKPyYTlZV26MOBWF1PlZH9/rQM=;
        b=Q2rgLoyiy5Awat4HvtATMZhMvSpXXwjtjnNHz9/6UE6Bq4KvDw0rUkfxf5920jRV07
         vbDT+MXCVyO4kNJGhdBYpyyjUMoqNzGTR/neOPoWF4vvg5EFaT1AeoRYh8PHD50JTVCY
         G8IPDdekE8L3axJZbzIBHjlE8nGYE4CccQ/LGg2SMky2Oj5u9948IMCbEFrsGxqAVJew
         CTCxjYemGw6yC8Pu3oshRQCthWcv+sZyo25s8bJlyZ8mCD4pQMtAa3wYwAZ75zRm2qyX
         LCUUdK51JaZfGKw18ImLLYmPwCS+fqzq0kzp+b16VxVF5ey//7CXnSUm8mxrs0D1wj3b
         quwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702993847; x=1703598647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7mA8MymjOnfLLN21jKPyYTlZV26MOBWF1PlZH9/rQM=;
        b=ABv8f0MLIeTAAaqp4h7CjJjnznLVWSm+Ico55EyhxvZIcMBXbsiuR75Ble/jaBZq9l
         F7EYCsTnAJrfJr2YhAtNAPLwbAH3TvNruYg0zc/fnf3nlZ0Tv4cjsnJAlRL7qnFgeMZt
         DITVX0CnFNQuFrUngJALRW7Xe0uOcJJSVsr1Nuzovf8CYW9Q3ObCPZ4Bl5SUGG8K5Trd
         C1ueMcV8qjEWA304WXdha+OASE8DYMR8pkR/55Tj7O85T0S7IFxfyPa3zqgm+CmNrrJZ
         7tjnXr1jUVV69kfJqAsvclOSZBZQj42HSdM+VZ5IUN/VadTs8gFiuZN2XAiM28YCO3HR
         HKvg==
X-Gm-Message-State: AOJu0YwxSOdxN0BYJW1S+isilJaKA61mISOnVTVUNsf/vvVZPpoO8srQ
	Redg598uHpyr3hPoTjIvJLk=
X-Google-Smtp-Source: AGHT+IGHPIIKUI8Yhg8rr/cCt80nFAeuyks61zvvkfTfX9LSHq5MgdhqFMasfsrpp1iWrAMqly+mkw==
X-Received: by 2002:a05:6a20:7287:b0:187:703a:8658 with SMTP id o7-20020a056a20728700b00187703a8658mr9178168pzk.59.1702993847323;
        Tue, 19 Dec 2023 05:50:47 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d17-20020a056a00245100b006cddecbf432sm20695264pfj.96.2023.12.19.05.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:50:47 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	menglong8.dong@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 2/4] selftests/bpf: remove reduplicated s32 casting in "crafted_cases"
Date: Tue, 19 Dec 2023 21:47:58 +0800
Message-Id: <20231219134800.1550388-3-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219134800.1550388-1-menglong8.dong@gmail.com>
References: <20231219134800.1550388-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "S32_MIN" is already defined with s32 casting, so there is no need
to do it again.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 0c9abd279e18..3bf4ddd720a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -2097,10 +2097,10 @@ static struct subtest_case crafted_cases[] = {
 
 	{U32, S32, {0, U32_MAX}, {U32_MAX, U32_MAX}},
 
-	{S32, U64, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)-255, 0}},
-	{S32, S64, {(u32)(s32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}},
-	{S32, S64, {0, 1}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
-	{S32, U32, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
+	{S32, U64, {(u32)S32_MIN, (u32)S32_MIN}, {(u32)(s32)-255, 0}},
+	{S32, S64, {(u32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}},
+	{S32, S64, {0, 1}, {(u32)S32_MIN, (u32)S32_MIN}},
+	{S32, U32, {(u32)S32_MIN, (u32)S32_MIN}, {(u32)S32_MIN, (u32)S32_MIN}},
 };
 
 /* Go over crafted hard-coded cases. This is fast, so we do it as part of
-- 
2.39.2


