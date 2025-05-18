Return-Path: <linux-kselftest+bounces-33286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C827ABAE29
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 08:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBA6177333
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 06:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887741DE2D7;
	Sun, 18 May 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="StQl3kXn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB403548EE
	for <linux-kselftest@vger.kernel.org>; Sun, 18 May 2025 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747549944; cv=none; b=pJbx5QiWtlu5A7bRw085D+ORbvFWoVltftqcvP7tn5tl71X9XdQ4/hGUBasWr02zdKJSGEBQf8ZBScAkZgs9COVpn3C3uNOy7xNwILYRAi/rd3Q3LlPWMRjUplTWHLAtw/byp3Mgf5SzXlR6c1xnGTdTrj7fsilj3PFqlBwi3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747549944; c=relaxed/simple;
	bh=k7e232aRXBYnLIidA4C1W6sTVW1tyPAB4FFr/gmyPl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCQEG63sKIlKqYgnrbYjTMnXLDdtCrmXZGu0qDijTgIBCKLVOcG0qTiHj8E6uBRVj/ISWRKfNnHunW+stMzv0dCuGJzzizrrcY4LE5/F9rne6eQHlhXJEjTfYSwooAamAPUUtDBoEBWTKUExaKC4FzcznGWN2XZj5lSX9Otqcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=fail (0-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=StQl3kXn reason="key not found in DNS"; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3db7b3de375so25753965ab.1
        for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 23:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1747549942; x=1748154742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwP48AH0f+VzkpR044SBe5hj4tEB/4qffvp665GiJdI=;
        b=StQl3kXnZecP1Yh4PJyQXbDqdsKBvk8LZNxvhqhlgTqm5V9E3Uqcx2VoKcHdPqDKLc
         LQgCLAkOI54zZ8AkOUNHz5+FgHE76DyIfc5EmIMdMGhNkRQNJcaLR5xeYpkyfiFQ9JJ7
         YrALxyO+l6gm7zlvIKxNCr3J9+MJeKclOCJ4Gh/fjfMBolagwwlyEcCfEmm7LDCzGohs
         yAEmj3p0fEZPABOL+S5vcC1sy47aK+edikphDfVKi1/THPmiOmyNp9MrO+FnyEuEZu3f
         MATZ7DlbRiXXV1GYbZaAwzUUQCPTZMhXqqJEGyVJzcyyIF9XB0yqKLyhBZhMnjRfbpfe
         9Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747549942; x=1748154742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwP48AH0f+VzkpR044SBe5hj4tEB/4qffvp665GiJdI=;
        b=vvJWnUT3LlejfxHWmSWAlbNiYxWvjlgcBSi7/3JfXREPzhGdeVYDEVtT78i7O6ExYx
         nyBnvIc+xK1Q2r5sepycJnk86vszY40mhw+f3PF03Id3U0cWfyW8WDwbY2YPknRlYpTS
         Lr2N4C7Z47Dwf/bZVAO7hYZ+h3bf1VDfDspe9pSDDXsqRm6XsFQl69CwQ9mEHr1c6BYV
         v6fGEdr9CqeRJYaKJUq4mdcYIl/1jB7TTvaZSomkSPtHnTr9wXdOM1vyFCawup2Z1lZ1
         9wMPGvZYFY4TJSqj77FhHdhc2fikdUt64G7aWzXRCCJCnaOS/4tVLOxzfa2rJe4mQkBa
         WBTw==
X-Forwarded-Encrypted: i=1; AJvYcCU5aRhjh18QxA55RPc/cHN4GW2RAQFpFSEyEQD7bYMZXNFQdsCWUknbcDjwOYnpr9PgNqT0T4/zE0AOFldYuR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTyTjn0jrwRm0Jk89lzRbcK2OmrFbwBIHB5b+AnX4jSambl7l
	Wv6EH6mRjb2xthRX/7ZU6ajj7jSdPx5gEQqHnZ8H82Ywq2hVFqV7cbZwHJLJFgMz24g=
X-Gm-Gg: ASbGncuA0c7ry6Ch+V897R4giWVg5S6vFYKMrOogfti+GiR++axvKptOjoj13HVvc3r
	sy8LOcLbi76Wm8+Ghl2YlhsFUONnxFULAUDyipms+GqH7jLqib57rfRzIBiY/7FsFQ0yi+vFvdl
	z9US8iUg2VifTX2GmnOITU/MEiQ7+6apF57PyIf5XXTe8U512fdpPOugfBaRTFMFXt9OMVlOFD1
	CFshhsoJdL56jEKlODX7PCnqVZBa3i4Z6LbO6BwmvjaG+M2n529NE2u6f7MARaWHSWPVpETr3N+
	HfkiFKEwi0s0RQTRrh/EUj5rOkczLcBqf3CijwCGBuEAsgaNmLRUOyt9k4BaUe2qLxbH6q9epi5
	ovKp3Nrg=
X-Google-Smtp-Source: AGHT+IEJnu7rOfOWw165nj2xc2++BeA1tyNcutxhMIII9tv0OpltHssTeqXnkk3yhpYX2DQ5ZUgMnQ==
X-Received: by 2002:a05:6e02:330c:b0:3db:839d:7b36 with SMTP id e9e14a558f8ab-3db857bc504mr89067845ab.21.1747549941790;
        Sat, 17 May 2025 23:32:21 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc61e15b2csm4945525ab.58.2025.05.17.23.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 23:32:20 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: shuah@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH] kselftest: x86: Improve MOV SS test result message
Date: Sun, 18 May 2025 00:30:26 -0600
Message-ID: <20250518063025.1467672-3-me@brighamcampbell.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently, this test completes successfully when it completes execution
without either causing a kernel panic or being killed by the kernel.
This new test result message is more descriptive and grammatically
correct.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 tools/testing/selftests/x86/mov_ss_trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index f22cb6b382f9..d80033c0d7eb 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -269,6 +269,6 @@ int main()
 			);
 	}
 
-	printf("[OK]\tI aten't dead\n");
+	printf("[OK]\tkernel handled MOV SS without crashing test\n");
 	return 0;
 }
-- 
2.49.0


