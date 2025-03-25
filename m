Return-Path: <linux-kselftest+bounces-29772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0697A708F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 19:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DF61897F5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21FF19992E;
	Tue, 25 Mar 2025 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtW2u0f+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA219066B;
	Tue, 25 Mar 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927026; cv=none; b=aAF6uquiZASd5PmvgaoUnehjCaAgH/E+TpEJRUNJLXpGKGYmRCjvqFZI6qawfwrQu8ANky33dgP6dp7WTrfrqhMLZRowqNg76TEmwg8MLqtE2bRdkpRegSQzDQ0+XyjBpw0YbVhQB37FVzDt55S2SKb0+ld3OUqGPUFWSaM97ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927026; c=relaxed/simple;
	bh=mcnEau1wEvdkMarh9SDVAW8uBdhX35UZa+0DBSnS++Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbtqY92bBdRQ1XrEj1+uSt+QBt7KPMFisBmr/T9z0R2oup0DM77A21IRxC6ZzV2FGxg1Ktfq7T9KdJ9OyRjWyem1CL+pGoYK+kwlHOfjhbJmu8s23tju5UE9pmLcDz5LcwTHmjki5x7RxAEch9/7mdvi/y3x1wAbk6VDfKYBD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtW2u0f+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3035858c687so3333352a91.2;
        Tue, 25 Mar 2025 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742927025; x=1743531825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vCaqNT6Z4XukVuCat8lSt865NhuPSV6jdLTRDZQ+QQ=;
        b=XtW2u0f+7sKqoQB60/LHMFkv8cChZHlYwDanJlmM7gb9mJY/epeO9FofcuGiJglRDq
         Afo4pCEetYVZ8vTPWN7A38G67pOzj+U7/8DVIMu2wbalVplc/0LS3j5gC/UoPQrq1PCZ
         oK18MFIEhv+X6/Svkyxxrv22DPereZ77V+XtGQV3hUHMcVlAfdnSYoc9PHCmMPQXJNxF
         pn1GTOTS+24WOy8sAYa6LbRsEK3O3SuLWbjT2Gn54mntYh6DqpRrodJ1Gqz8kFHJQYVc
         TfofxUcHiFmT4solLNb7+y8h9IkeJw7q+4j/fvkh+d3RDjkLpVeSjBg5gpEBSaN6jcL6
         5a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927025; x=1743531825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vCaqNT6Z4XukVuCat8lSt865NhuPSV6jdLTRDZQ+QQ=;
        b=TTxpXxo1hsOri7VsEQ36Oe1Mufw3KNvBm7skR42MLX58n76jWztY6mfICSfnZ5Ycm1
         PB5xahs9Fv1501vBqHp1WASSuNYcQwbhwC6+hPqeClgScDNTwZwLuSWhraO+TJUbDbZb
         K4GyEolKFiTc+f1r2LTgA63y72fc/kDERuY2lCLYkOj1TfQ9lvygfKI4sCdyRItQR13V
         /arA6saTbfA9waTWhKee/x44PyrRlLiiMYuPgkUt4PvL9n5pgfSy10vhqu032RuSThBR
         h25chUNiAeGnmQaLLJ9zG+HqbP7ie/gkHBiWhm2RHF0scp+izikKW4X38UCB7JMlsmAK
         7aaA==
X-Forwarded-Encrypted: i=1; AJvYcCUxQRK/6qua6QnwxEgkAV23MmO1oYdzCDTPzZVMlO/7BjZD5f5kal+HZRwYad2hKjxNfV66oA4MvIL2q+z64CHs@vger.kernel.org, AJvYcCV4YhB4PfHAaXsgNPFN9z0OFbsAN6Ly+uXXmvTWjAlH47g+cEaeBgZBTpzRVVLXTQgU4V0zk3Qgku5e/YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK6vJxK3vWMsSuiUmTwd+plCXAxBizFgky67DjVQtg2XyKsIPy
	16X5xQfl7pTaqNkXFcyixy9bjrrQLqvNCUtVrAkzXCyiDa5Y2Zjr
X-Gm-Gg: ASbGncuYmKCo4jDkmoasXszMB8jtR+tYmu9k3DSMLXwsvXYjKtzw7qm6rQklF2WKBqF
	T7099nSUVRvtpimlhcrrtIZbfYTKHOSk5zNsej7ACUeKG3zSjcPpOKGXaoO5dYNeKxcId5ajFfY
	pv86iu2gtV5GIoLaRjWVsh9vQgRq8k5pGnPLcwOA6p5niQca4MrlOvh4DGFeUURPclEmXvJcZoa
	M7Lkti0BBUdU4JdXvl01V6f1hUm3QTITZtZInG0Uvpm0KBnDqA/mEnXe9eHCh9nbRmzuKFRKj7E
	hKFWY1R9dbE5+X3Od0KbQZyKDQXZupf7ch/Qnz5XhExpLhmn3eYehqqZZA4uYqBgewceOytK2zU
	TQruXVdeb7cAqYSvjP3Flv8WI8t8=
X-Google-Smtp-Source: AGHT+IEuRRdtDJ7J706QxzLdO+4/epryr3zMKq0ApySo1GrbkiLWxZVJJTSujlolia+qBaD3KpAWrg==
X-Received: by 2002:a17:90b:3950:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-3030fe988c3mr26901615a91.20.1742927024329;
        Tue, 25 Mar 2025 11:23:44 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f7ea12bsm10646401a91.33.2025.03.25.11.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:23:43 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: malayarout91@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] selftests/mm/cow: fix minor memory leak in child_vmsplice_memcmp_fn()
Date: Tue, 25 Mar 2025 23:52:55 +0530
Message-ID: <20250325182319.29352-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static Analyis for cow.c: error
Exception branch exits without releasing memory 'old' and 'new'

fix the issue by releasing the allocated memory.

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/mm/cow.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 9446673645eb..fdee42850548 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -168,18 +168,18 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
 	memcpy(old, mem, size);
 
 	if (pipe(fds) < 0)
-		return -errno;
+		goto out;
 
 	/* Trigger a read-only pin. */
 	transferred = vmsplice(fds[1], &iov, 1, 0);
 	if (transferred < 0)
-		return -errno;
+		goto out;
 	if (transferred == 0)
 		return -EINVAL;
 
 	/* Unmap it from our page tables. */
 	if (munmap(mem, size) < 0)
-		return -errno;
+		goto out;
 
 	/* Wait until the parent modified it. */
 	write(comm_pipes->child_ready[1], "0", 1);
@@ -190,10 +190,15 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
 	for (total = 0; total < transferred; total += cur) {
 		cur = read(fds[0], new + total, transferred - total);
 		if (cur < 0)
-			return -errno;
+			goto out;
 	}
 
 	return memcmp(old, new, transferred);
+
+out:
+	free(old);
+	free(new);
+	return -errno;
 }
 
 typedef int (*child_fn)(char *mem, size_t size, struct comm_pipes *comm_pipes);
-- 
2.43.0


