Return-Path: <linux-kselftest+bounces-26049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095FFA2CDF2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 21:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F89188D9BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC31A0BF1;
	Fri,  7 Feb 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uio/iQLI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC719DFB4;
	Fri,  7 Feb 2025 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959252; cv=none; b=Rm5WyhIuH8TLPeSM/7dwv6hzLIHJI/r8dncPG9m5M1X/ZQIZLj0WPt811BJ+BykMwZT5hAs5LaPOCnr9KjKLbAuPpD4vYR9oZ9ikI4LzdAMLy2pX+5vYP1Vipwhw0FIes4GB+DutaNeBOHvnSzi5EXYYcLHNUbtocBZE0UGfwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959252; c=relaxed/simple;
	bh=CkmqeKdb4UmlPMqyL7e2jFIV9Sf8zIq378b0S2c6DzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J181gG7/H9uVzobeAOAl/XK8tRwfZZ20lyja6rOxrkzegW4ayRebeiyxxdfkAMSR4/jvVHv3k/4dXLcBJS7TvJo1gB5EjOHPR+e8jlFefg7vRLX96HR48lAHAGLT0vO1RgwfIXDOa8/2bUTFzAsJkK6cl+Zr3mK3xuj5WHXcF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uio/iQLI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6f19a6c04so216242385a.0;
        Fri, 07 Feb 2025 12:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738959250; x=1739564050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZxkSETWBGyS9QsIncAjdUCkDXpgCrsMQVJ3J6dEfbc=;
        b=Uio/iQLIhLNgL6GOdu51GJqwFtmPNPBJ837A5lHhsHl/e0OxNYtsHu7+Ud4+YoTNZz
         xIRPLofNYFvI1WlHS7GfGh7d/f+S5OH5kHnlJdIIwCmuBaebYPeZ2Olgl8Q4uGzg1Bqv
         cbUGkkR6D/uM/T2PQNvKqmVfnReS9ojksaywk8GwtuZTf0zwvYred97/8keGuxmdajE6
         QYXu0dNuCPD3iM2ZSZhPhravtH1qJ5WzFHY5zGC6Ljp1nvXqhIqUydfv10QLH92UF3n0
         8HSyHqQsG/tbnyQj6rhIS5j2nphW9hChV1cUJnnJKrMETnXmiUmVQYYaFgzYR2p7eqpK
         9VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738959250; x=1739564050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZxkSETWBGyS9QsIncAjdUCkDXpgCrsMQVJ3J6dEfbc=;
        b=oKAHHa0Q26wIJyweNgX84A2XXQXGlskvyxOhsvl4aT7H43dNZbZfOs49ZC2sbjPwY/
         qBt/tf34ZKDW5wUJNEmrY7+SjMgszVR9vJOJNUBTgthxm9w4e5cfBiywcRvufsVBLXh4
         O3rOG5lkBbErJ+C3mfCGynT6qXamF5h4RTtoTN/EGclDyfwjvCQM5YbXim7YFhdGCmx4
         chuVyAzr9tmQL4CdTP/nTQkxJlhQBRh5IBy1dFDOUlyiFcuRdOFxdiRxxe4inSmHXK+a
         6KnoanRqtbz1fi5O4NofR+2WMkXs991LgeAKvt/mKYvaAh9cAmF7SDxuRBv5VEl1ogPY
         +FsA==
X-Forwarded-Encrypted: i=1; AJvYcCV0tSFLeDRJHVXH06zKWeRXlgAywVid4WrE22dOzvW0EG31ip8DQ6UaPH9GLFeEaEpovMcAA2RrkQR/cF1F6LIf@vger.kernel.org, AJvYcCXTYnTTLELJ7DVNzduOl0Y3E0ZApyczoqyCQKaOn4B4Jfc43kne9PjHb96qMvznqxtin5lC8y+spFeBw+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HG2B86BYyC1L+dJac8f24S8cAzxFJyh4Cex3bXiuiB34tKmQ
	5DCRiyrD0hdkOxZ/jeXfP/H9BtrOVgBgcSalbIjANxKnJsDE5jKh
X-Gm-Gg: ASbGncuaPR+TQT1P6P6I+jzZOluuZA9Pp2WNBe+nfm40TDmTccuR5AxEkjF1NhqmjiD
	u193Y+sCOFFMLPNnE0AdMnKHkO8Zq2J/ssMfUW/DZZrAzNS8ZixQ0HdgJMycshdZTXP+tAiVYiG
	YIu7xkFL3ru4hz0VyGN2rKhrc5+NtsD9vAxn4e7lJwS9D02HYpoaslI6tTZOYsLsszKOm05Dbd/
	LoRdBiINDlcghUaPZ0u3+Y3Swot75uTVc0ZZ135LR5S4trYV/cJDfWboDVB+grF8tj4JTTv3TTZ
	PaBEcoxlr+S4P04lZpU+eZQdf8j+cmUX8xJF3Xn98Rkaj9ekEvLVMmYYTQEFNQzTF5qPiE+ReC9
	Ivw20iQ2kV9vz/wnuzuC9lZ9wIhoI4cj0BOmUYQ==
X-Google-Smtp-Source: AGHT+IFu3LnMnZppr9scjvCc/cSU/9PZACsPok2gL4YMsF6uEMfT/WzvaxNeLs4vM8mQeUo9sHI+ow==
X-Received: by 2002:a05:620a:2621:b0:7be:2a68:6d79 with SMTP id af79cd13be357-7c047c34ad5mr860389785a.7.1738959249714;
        Fri, 07 Feb 2025 12:14:09 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:c58e:ed03:1b60:c56d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e13895sm228851285a.58.2025.02.07.12.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:14:09 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Feb 2025 15:14:02 -0500
Subject: [PATCH 1/3] bitmap: remove _check_eq_u32_array
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-bitmap-kunit-convert-v1-1-c520675343b6@gmail.com>
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
In-Reply-To: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
To: David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>, 
 Kees Cook <kees@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This has been unused since commit 3aa56885e516 ("bitmap: replace
bitmap_{from,to}_u32array") in 2018. Remove it to avoid the need to port
it to KUnit in this series.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/test_bitmap.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 65a75d58ed9e..c83829ef557f 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -100,34 +100,6 @@ __check_eq_pbl(const char *srcfile, unsigned int line,
 	return true;
 }
 
-static bool __init
-__check_eq_u32_array(const char *srcfile, unsigned int line,
-		     const u32 *exp_arr, unsigned int exp_len,
-		     const u32 *arr, unsigned int len) __used;
-static bool __init
-__check_eq_u32_array(const char *srcfile, unsigned int line,
-		     const u32 *exp_arr, unsigned int exp_len,
-		     const u32 *arr, unsigned int len)
-{
-	if (exp_len != len) {
-		pr_warn("[%s:%u] array length differ: expected %u, got %u\n",
-			srcfile, line,
-			exp_len, len);
-		return false;
-	}
-
-	if (memcmp(exp_arr, arr, len*sizeof(*arr))) {
-		pr_warn("[%s:%u] array contents differ\n", srcfile, line);
-		print_hex_dump(KERN_WARNING, "  exp:  ", DUMP_PREFIX_OFFSET,
-			       32, 4, exp_arr, exp_len*sizeof(*exp_arr), false);
-		print_hex_dump(KERN_WARNING, "  got:  ", DUMP_PREFIX_OFFSET,
-			       32, 4, arr, len*sizeof(*arr), false);
-		return false;
-	}
-
-	return true;
-}
-
 static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 				    const unsigned int offset,
 				    const unsigned int size,

-- 
2.48.1


