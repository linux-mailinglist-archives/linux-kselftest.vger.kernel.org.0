Return-Path: <linux-kselftest+bounces-26708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFDBA36C99
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 09:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8023B0CF4
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F51190063;
	Sat, 15 Feb 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD8BHgtc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB5D531;
	Sat, 15 Feb 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739607605; cv=none; b=EGE04UpbZyMpNZcCZIluK4dp3/xeLfTB67xuhB1pySwBXEvPiRzakygGH8uxhgNq6xfgsHIIvFoYm7stc+ncWZxcs9Qe2+LV6is77BVzrqzUEmgKewmwormphJnn0VJmW+jh55HP3V+CnvkbkzVn/X05+pzze2ogPe8f4Ms+vtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739607605; c=relaxed/simple;
	bh=1Rq60lGAm9WHXqdbVFaeMnZAWopONGmftrnCk/c80vM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GXeU2MnUmmXpgaYfHjEUTuwwyVNqRJqJeNXABJLYGOFlMxsCLLUUxhoWbtI0s/EwdHaNckR0mgcvZGA5yqFjG9D9J7XU4EjZ8+HJET1zMEWj4mCttUjq6xeMX7NuvLTcn3HfApj5xyN1JS1L3qV5jcPKQ4Xw6Rx3+3Glpu+eDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD8BHgtc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d28c215eso39839295ad.1;
        Sat, 15 Feb 2025 00:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739607603; x=1740212403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Lqriar441znn0tsHZljs7R112A+g/IhNWty/0dvefA=;
        b=lD8BHgtcvNaxXfcFEmvJGg9TdKgajAGr0zl8Y2IPwk52HlZFa+9G90c2PKW3TlY/aS
         AX6OvH0FHHgNo3Aow31Qdsyq5J3nE9al4wMNQ+rsY2UZ//icVPqb0DehxuqOP7Ea25Q+
         sS/HES93rK4DvRbORG0m4hPzCLSGKY49TmZRH9ZTNZGUVXDNi/vS+XBqwRu+77qTZh5y
         ZAWLm/YykEa9YThkAMTEUFPgYYmfHlVxbXYjwNxN5at1tjZkaecxXHjawPT1Mt7J4kKb
         73VdT9UDgUZ3WjN8uyMdEVFyBLViPMDGsm4rvhofOrPNP2/pFbGybhePifQwxkJ7LKf8
         0bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739607603; x=1740212403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Lqriar441znn0tsHZljs7R112A+g/IhNWty/0dvefA=;
        b=DhbouL47NO2r8G3/LLf+ntrnBE9KY3zLelYTA+GB3IvhAmtSZBaRm5BgHa+V1Uo9tH
         R70FvZTaLKdTilPeCHXA+3MW8tuNmZ+sVuXKuR8FjdEA35J6kkZVkAqbYbW6clDNcYJW
         491n6xM4wjXP8nTTuF+uZyWM2KJw/LkNaFgyH+1fnzvFlZ69l+GvW+DVhHdmyb2BhGs4
         Nn/GAYmVa7vgifecjJwUfxEJg7lG1IXZsZG7Ekes6Rc3RNzqf5Elfgwm8AkBNa9OoOh5
         qraijztORYLVPrGAi0L746Jm5URQXfZv3iFCs7DeXEnKQxdu8/4Uc/jYbM/3sV48AQ6x
         aFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJXLNIecOSW0C0VRn8icwWSRiOeNu9TNkv+6m+mxaHd9NBvRQv9DMcptnAyRYTcjNE6FX5HYn1mgZRTs4BVIN4@vger.kernel.org, AJvYcCXMWxk27Drxku3m1EXpbVc5SsgDDHR12+RHRLxZe/Gm4eq8O6cWM66F8qvzLPL9A0aibK1acTZn6QkoF3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+iP+JrLMoAOA8/nwZlMlr6jOUxltiuxgbvgyu4KExzT9EQTGx
	0yJp849wABEuebJ6scHA/Utte8RM/kFVi5nhADynZJfxrgCZNpUZvHXAjso3aQ==
X-Gm-Gg: ASbGnctxMiPFlKmNoAq3Bo47WqtUmU8r3d1elPb9uG/ptTKsyVrxDJwu5kleg2WrJ3F
	mljLG96bgv/6heezbmoNsCWsGvOSTEMGybguX++SFRf7A4TZA2wc3mQnhe0M3FRRKe3bBkdrRiO
	Mpsi8Zm8KkGmwN6G1LUJqaOu3rwFomHmaxfUbk9NV/ta9dz8xDPpSok4oExaTyBK5fWW6nLxJX7
	xmHVWUshoUQMEOC/oWvDYo5fyeaQNWzI6miLzYvLPDxlpspGGTrqON50JmkO2bcg0iLefUfkX7v
	Jy7kiReV0KIDcDCuCFWcCsg4
X-Google-Smtp-Source: AGHT+IEmBkDPjv1gpIY1JD1vS+fZ6IgNJJb2PSqHzg73HUzp0gX0wX2QJy5CC/mvtrBPGXDZ67KXEg==
X-Received: by 2002:a17:902:f547:b0:216:6769:9eca with SMTP id d9443c01a7336-221040b12eamr29424675ad.37.1739607603147;
        Sat, 15 Feb 2025 00:20:03 -0800 (PST)
Received: from debian.ujwal.com ([223.185.133.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d608sm39543435ad.171.2025.02.15.00.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 00:20:02 -0800 (PST)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/mm: Fix spelling
Date: Sat, 15 Feb 2025 13:48:03 +0530
Message-Id: <20250215081803.1793-1-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misspellings flagged by codespell.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 tools/testing/selftests/mm/uffd-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 717539eddf98..254409972ddb 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -323,7 +323,7 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	ret = userfaultfd_open(&features);
 	if (ret) {
 		if (errmsg)
-			*errmsg = "possible lack of priviledge";
+			*errmsg = "possible lack of privilege";
 		return ret;
 	}
 
@@ -348,7 +348,7 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	/*
 	 * After initialization of area_src, we must explicitly release pages
 	 * for area_dst to make sure it's fully empty.  Otherwise we could have
-	 * some area_dst pages be errornously initialized with zero pages,
+	 * some area_dst pages be erroneously initialized with zero pages,
 	 * hence we could hit memory corruption later in the test.
 	 *
 	 * One example is when THP is globally enabled, above allocate_area()
-- 
2.20.1


