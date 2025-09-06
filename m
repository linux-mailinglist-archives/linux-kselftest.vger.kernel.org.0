Return-Path: <linux-kselftest+bounces-40877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B6B47346
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 17:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499411887B6B
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB97225762;
	Sat,  6 Sep 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si/Qnn3F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A422541B;
	Sat,  6 Sep 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757174388; cv=none; b=qlZvSqGnTM1Pw54XqZXVvFQrGv4NveokGuFrO/4+oOMh3ZRqpN3xuDQ+2qoNMU0XU5SY7kdl/AA4S3N24N9tnhiEvhEIto2aoGwdcdcrhkJBkYsfsxBer8S4U9kAJFdoa2ZaQF2f7wG3al224o3xhcwbZXEQj+Q7Wrswn28sfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757174388; c=relaxed/simple;
	bh=h4wiwBgaByzT8nTZ1ZqpoQOXMs896bVUy0Kfjd3++Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OHhAXn3b9pHhxqfQzqqlPqUFPA7xWLI7gxRmlFAeiIDRtuQ81a7yKQ22QXihnUUtOfAcHPTdpuUnOqYYTbwKWugg2vbMKAxzrh4l8II3AwtZo0vjEwOCeqQanv1faizqe4e39kMRM0RI11C22ceK85WqgSu491+IfN6enpTlRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si/Qnn3F; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2715881b3a.1;
        Sat, 06 Sep 2025 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757174387; x=1757779187; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrIFwtSt9A6lyVVU3dEeMrt9dG3SP7YLN7A/4OIq3Uc=;
        b=Si/Qnn3FUJ7ggnRygw+Rmo8TxUHUCcu2TGnl3aCDkAuMhSV2CvH1v81QK+/Zi7We3o
         Cn7KWuPbEBIGNmx1TKaxZeCqTPXmeozbRmcbrjXtukK7JIQLjU3xHDJ+Ylq9Jd9Aho2r
         Bnz9cHYtWI0iatbf5/Oi1kCisr/RIEvfJ0nmGkNIFzH0BMkiKwvssPMdgTquPqCjQBmm
         IzC1Hc7w+W7ysoaPReN/7/p7lmgbzjbozlU9B//OechzqMqCqTyM1IObsb/3DbyaoaJL
         jUnWAlJs6UG0GKAIC0nXV2KoTWrGzYtWMUjw2N6VzYaM//adUarSMlWXEllwGPTtR10A
         P+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757174387; x=1757779187;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrIFwtSt9A6lyVVU3dEeMrt9dG3SP7YLN7A/4OIq3Uc=;
        b=YZsjeJQ0nqpH4FBU1OAYN7hvwgWniFXEMCBjQlGT+odRptPgyMEFRHg2dQsxLnVx9V
         KVpg4EO85b7hOfgb2Zjs+iHwFtbPDVjvtm02/z9pMrDH6a0sUhgbTIQuXi0Hd3+r/kCD
         xCoQW2Q3BSYOqovshDJ5dn10W82hMlRI8PVupg0S8W0vYF480YEfJeS2EO2OhdKjLwFW
         cJHqUs/oSLl331nHL+f797R+pVbYwoQfpTvwC0p24X2YyJ4B2B2jQ/KHvLanmYcgxxkh
         xkBl5BYXCh6Ttq1+r0ekw4Ni//ICQYYSJ88rIvxfsReWgnUrzQcQK3J8/ClzgILur7th
         TOWg==
X-Forwarded-Encrypted: i=1; AJvYcCUMdbQ8M96wSjcA3wN2UsIQef7EF9uNGD6QqEddO6cbbrkejVPMiQ8TvKNIprLQb4wGLXhk5AAdvrUw1seO6LZy@vger.kernel.org, AJvYcCV/rQuP/tD8KxNo8XzC86ln+nFQaAwQPPRr5wEUviRJ96tNzgk7ElaLT7J4ExBYfYyajiQEHRCm7Nmuajw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFL+Ao+Hg22XzpWexljCf1NQV5i4M6ul37FEr37EV99W0l8LmD
	2Kuth5+YhjewBWOhBhkq1c4hNJK/JQj/Sd77FRfhi5vYa9j97VXpdj/V
X-Gm-Gg: ASbGncvaHfJ6eJ0VSh1+9OubJ1SmTlOWbRq44G54DXGOI4dJnCUa9Pf0on3GYbU2RXf
	HgZP3ZTTkyJtgr1G8HGHhzt3miJPnkbiRWmAHmtaA7YAlW/fzr4rs2o43BTz8/FJV4813eBFqFN
	8Dt9gQKro7n+OtqWZS4Mkleyk0wS7o//GJ87RepTY+DeyoMxXa9iL6bZ5oRyEJ6J33nnLokIpq9
	EFyCntQQOltBHNU2gYn6q0G7Eu1fRGxTuKj84K0blEnIhg58O7FMiabA3nkwYpvir51Qhywaqeh
	NQZrtoxoFv41/SL5dbs5ikoj9nJbKf1ZcsBacnt6ZKJN9VdQcwZDP9O6arI4v6VECS9JrRZgXXk
	RlaegRm7hgM/p6PatSvKRxBkiGyspS1g=
X-Google-Smtp-Source: AGHT+IHJkBfbaRZTfiawC3YBCWrAP6hCVu4FwytpXR+uUzJyLvZ6bKq0SL4BUl4mZxqTv0swGQezkw==
X-Received: by 2002:a05:6a00:9162:b0:76e:7ab9:a238 with SMTP id d2e1a72fcca58-7741bf66911mr8160961b3a.15.1757174386587;
        Sat, 06 Sep 2025 08:59:46 -0700 (PDT)
Received: from localhost ([159.117.70.219])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a26abdesm24451555b3a.1.2025.09.06.08.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 08:59:46 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
Date: Sat, 06 Sep 2025 23:59:28 +0800
Subject: [PATCH] selftests/net: fix unused return value warnings in ksft.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-selftests-net-ksft-v1-1-f1577cea3f68@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF9avGgC/x3MSwqAMAwA0atI1gZqqxW9irjwk2pQqjRFBPHuF
 pdvMfOAUGASaLMHAl0sfPiEIs9gWge/EPKcDFrpSjXKotDuIkkU9BRxExfR1NraxtTjVM6QwjO
 Q4/ufdv37fk3QvfpkAAAA
X-Change-ID: 20250906-selftests-net-ksft-37266937bc4d
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 Nai-Chen Cheng <bleach1827@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757174379; l=1664;
 i=bleach1827@gmail.com; s=20250730; h=from:subject:message-id;
 bh=h4wiwBgaByzT8nTZ1ZqpoQOXMs896bVUy0Kfjd3++Q0=;
 b=doHOCBxnaG5mpY+1/18TuD7d+TAkG2uLQIUjLXuWgnXjJqEMnp8qGuPA1VO2R5Gi3UhOoJ2Gb
 LZoWaVMySTBBc8DNJv13kgiS7zFebHmdowBV1UgYRBbP4MjMtupYCNE
X-Developer-Key: i=bleach1827@gmail.com; a=ed25519;
 pk=jahFPRplw20Aaim8fIt8SxlFMqkHbJ+s8zYBGbtHH5g=

The write() and read() system calls in ksft_ready() and ksft_wait()
functions return values that were not being checked, causing complier
warnings with GCC.

Fix the warnings by casting the return values to void to indicate that
ignoring them is intentional.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---
 tools/testing/selftests/net/lib/ksft.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/ksft.h b/tools/testing/selftests/net/lib/ksft.h
index 17dc34a612c64e549f634e82a23f317b2ff6a282..0ca2cb408c643bc76c0aaea684f0e7e28e6b05a6 100644
--- a/tools/testing/selftests/net/lib/ksft.h
+++ b/tools/testing/selftests/net/lib/ksft.h
@@ -10,6 +10,7 @@ static inline void ksft_ready(void)
 {
 	const char msg[7] = "ready\n";
 	char *env_str;
+	ssize_t ret;
 	int fd;
 
 	env_str = getenv("KSFT_READY_FD");
@@ -24,7 +25,8 @@ static inline void ksft_ready(void)
 		fd = STDOUT_FILENO;
 	}
 
-	write(fd, msg, sizeof(msg));
+	ret = write(fd, msg, sizeof(msg));
+	(void)ret;
 	if (fd != STDOUT_FILENO)
 		close(fd);
 }
@@ -33,6 +35,7 @@ static inline void ksft_wait(void)
 {
 	char *env_str;
 	char byte;
+	ssize_t ret;
 	int fd;
 
 	env_str = getenv("KSFT_WAIT_FD");
@@ -48,7 +51,8 @@ static inline void ksft_wait(void)
 		fd = STDIN_FILENO;
 	}
 
-	read(fd, &byte, sizeof(byte));
+	ret = read(fd, &byte, sizeof(byte));
+	(void)ret;
 	if (fd != STDIN_FILENO)
 		close(fd);
 }

---
base-commit: d1d10cea0895264cc3769e4d9719baa94f4b250b
change-id: 20250906-selftests-net-ksft-37266937bc4d

Best regards,
-- 
Nai-Chen Cheng <bleach1827@gmail.com>


