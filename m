Return-Path: <linux-kselftest+bounces-39018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B423B27358
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E715E4A8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B05D15A8;
	Fri, 15 Aug 2025 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXAmW4XY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5563CF;
	Fri, 15 Aug 2025 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216603; cv=none; b=IlDIL6mj/JfuDBJ7EqaaDfQX2FP+MaWHLjdN2aTrEB8y/p5KoGTLel8qpNEC3lhBIvzHCFTTbwJv8bTyG5cOmWBPZolzLGrX35bthRrgAAJ3XZUTfUdBfsdmP/mTGNI7BB03Gr8bxr/QucKYUmmm2xkD8Y4y/Dy99t9KgCvbyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216603; c=relaxed/simple;
	bh=LeLrLXcF4B2D/r502SwuoJI5Jqp2w+Ye/rStaLUoDi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oeGiV+EmgPgje185Sqd6udc4UDRVXujwjUx4B5JRfhI5siuswsrVXy0F2GOZu++TNAsTGnq7S83QT7aAVC52BIIeVpxiqRvBViWUFMJlpz2YZxwpY2i3RGQbjOaXDJ8Ov1jDltB+dqWdQ0vZ7kT2Sn4UYy8WilhwipQszcZG3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXAmW4XY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea79219so1787048b3a.2;
        Thu, 14 Aug 2025 17:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755216599; x=1755821399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlLxjN4pkp49jDBSQ7gXFAZ4FdqJj7SbFZCOba3BMhc=;
        b=DXAmW4XYNP2pZmKg5Jc20qvwsJqYXg31cgoOGg+zZrOynWsjg9eNumVmtEDofOWrsj
         mnmTTYUcwqNq+vSjsW/eTij+lMh9hYp9rN3696i/Rdh8mVXWVWzp7TiLfvx6qc03Ay1+
         THCUBQGjopBU5TMtC+EIYesEvizj8pH86Akzi8jbuL77B2TvK1JKKKa3/X5t0PZfePSu
         edAyD7rPWl+l9Uvff7LP4J3gr70E9cXAHOmOAW7xJL8ZMinSjCo2lo31pLA5F0q27tff
         wo7xumxfdvsvQ+v/bN+Mcmwv4qvIHIdHP+1/fsPBJbICorrjsoSyKPm0wMrqAPYkLdsf
         k1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216599; x=1755821399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlLxjN4pkp49jDBSQ7gXFAZ4FdqJj7SbFZCOba3BMhc=;
        b=JEjtlaweEFPLf3NaXaGJEC6f6x+aJOOwYCmThTy2NgEKssgh9Laecd4xqFHBfZ773o
         OFzg92pJoman8C+Q4RuWy4dVzjqCecAjdRDhik0oHOL6YHmD9iV4QlYQx1GF9S5Pc004
         DNE7WZkC5tSjuPh+hgaTtrhvE6P3v9jd2NXAUMKWqVzYa4hkEErKDSwvhcIuwBYOKT21
         2qa/kgNJeLHFnLfwVI444al1qdcahMU0pKtewAIp5WIR87J86rEbchcIpmiLaFY1cwhU
         01U7CugwephkCT6J9e9ZZZqPU8O1B0Zz9xH0c6wbmK2N/4thK4PtV3NTMeIisaGjMrZ3
         6fmA==
X-Forwarded-Encrypted: i=1; AJvYcCUAQLi6yceSJWMOQ9OCjHOcqu4iZsbofET/yHOPIXXat6vQxXguwWN8wwolzIcwqlgGHtMbpB32LVs6E1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJ1NqugixUA12QfVQpoO6dvD7TS4Vu5nlJ5RDNWSsrw6aa8nu
	u1pe9wh6anQvdXnxy+E6gZqZIXqbz0T4jPNoLmXIoOfAezVbcQH/TTaSWWe9DpJG
X-Gm-Gg: ASbGncuvlK9dXZoazXh31HjY+GG9Iyu4IXu+w1tRzdIQ11cP+h0DRfbD5B1RT0HN6pV
	/0fIVdGsdTmBRZL3obvPirpL1Uy1+zhCuhzb2vNAlMdrzAjwKpp6uMqI7C2VIJLORklCTUB6g2h
	FloF4f6/keXlTLpqISceOhsJvwHx3F0efbIjDTwWyEA6Sbj8r5UZpfDYZV66Iprp+54P/VyS80j
	/x1NKJ4NcyY+Iz8phb2bgwB7A/UU6efCpD3r7pkI3MqQ/JXfu7xhiUZ0UCtWb4hE0Y4r6XW98aD
	OBdex7KyVu5CU69PcgkKGNQv3I7zXNtFjWlSW66ecBtiH8JWrSpB54t5G/iR9TJGKTUQRSM84hA
	DpqsiLn3Ppu46SmCKNgCgaDeX7PTt2t0=
X-Google-Smtp-Source: AGHT+IH4yIyU5+Vw7X3ZhdEpMKKKSLOLoQRegPY6V7frOv02QTJ899n6OOmUfl2yHMF7rrVED6sj5A==
X-Received: by 2002:a05:6a20:3c90:b0:23d:665b:cefe with SMTP id adf61e73a8af0-240d2d7d707mr315324637.9.1755216599521;
        Thu, 14 Aug 2025 17:09:59 -0700 (PDT)
Received: from soham-laptop.. ([103.182.158.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2efd89aesm21367854b3a.106.2025.08.14.17.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 17:09:59 -0700 (PDT)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>
Subject: [PATCH 1/6] selftests: filesystems: statmout: fix spelling mistake in output
Date: Fri, 15 Aug 2025 05:38:59 +0530
Message-Id: <20250815000859.112169-2-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815000859.112169-1-sohammetha01@gmail.com>
References: <20250815000859.112169-1-sohammetha01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

found/fixed the following typo:

- didnt't -> didn't

in `tools/testing/selftests/filesystems/statmount/statmount_test.c`

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
 tools/testing/selftests/filesystems/statmount/statmount_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index f048042e53e9..1278259231fc 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -545,7 +545,7 @@ static void test_statmount_mnt_opts(void)
 		return;
 	}
 
-	ksft_test_result_fail("didnt't find mount entry\n");
+	ksft_test_result_fail("didn't find mount entry\n");
 	free(sm);
 	free(line);
 }
-- 
2.34.1


