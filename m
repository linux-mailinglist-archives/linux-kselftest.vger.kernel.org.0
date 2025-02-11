Return-Path: <linux-kselftest+bounces-26398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2F6A3126B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 18:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D70618833EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7F261362;
	Tue, 11 Feb 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af5HmPyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB524E4C2
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293618; cv=none; b=ikES6bHiSWtVfQjwHfkVteJGnJQRLXo7DOHEF/9fB1TVFjpBdLtA4ywKZ1UdNY2+MAMhDwuoI43dgCpgUcNa1IVKfBF8kbcBDpWFzL2dIFOKg2zOYtGKywg9CHxT0o2srhl9NKG2YC/TYmcfzOkpAWWuuwMVX2GNThoq3snCp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293618; c=relaxed/simple;
	bh=KUxFX+4f0Aizw7Mg85WPdNi8c0DEahMb6LLBmtuIvak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZujR+04G41o1RIgRUrrSVof7kxg4lOoXILvm+/v23wmj2N8u9QrB0Ih2pYjysopzNUhn15mBYiEUm9/5kNP6wMGjjoRJBSpZrvx6BKYkjCnZ8AWSD/0eIMONoptkSiV8gw4xDW+MYKlEkM8sjw1gLa0136kR5Nbe9FdrdgamQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af5HmPyt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f5268cf50so63444785ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 09:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739293615; x=1739898415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K89iMvYVIaxnJ+fqwfSq5htV0qyp5rhqJml9Bv4LRmc=;
        b=Af5HmPytN5k1ufG3zUC/85D/n2BZQINgBxWu5Cq6DtA/2TPQUWbXdWUtU+4NHKti7y
         sUQw+Zd/3WvSXSTfyhJiuFqhNEyU6iR6I0atGR7DnXkJk8zxy8zkTp3P3D0OoIsDyYvE
         W8Ew8lJ77yJMStx+Cj6uontf+iymwsCAY1mlZ8oNKOMLgpsuQDtstNi4X8+pJDgpn9Ok
         5hGFq9kT3KYUBa57EjXz2Ki77ZlAm7M1YMhyxJJuLWpJ7iCKhrnsrL96c83IPQHHWmI7
         6JVFMRSRPSQvfy/IRmUYLrZ1ZAJRlGOtRrIdTjwIz9ACc/lj7VMGdsFigzqw2+TM1WwY
         2vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739293615; x=1739898415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K89iMvYVIaxnJ+fqwfSq5htV0qyp5rhqJml9Bv4LRmc=;
        b=klmDDPnCXdB03CUS6nonXmUJQHBHUu2sr5Z34WATygwZIeZDTHqJIN+oJG6GfTTViD
         LdB1kKRcArUXxqFu8BSTlb5DUWi1OUHkkgF738Oq4zi1Vf+3GMzfZ1uHW+5W7QbBYE4/
         bmt+X9ofkXzcy/VVK9CmSUnNrNcK+5P/84zlx0kuiM3pGQqut+12clqNbOsAY4AyX9ij
         GbJcR+33MDSYyi9OEgcm/UWtiIUTcS9ozQT9dQq+W3Kebt+iIgeAHSiYC2+LfAmczm41
         82+wc/BMVL3sk7Am+JYewUSPU62uifJFE7PKmXJ/Ct5zb9vNpQa99UtcgK3sI0eKCxiV
         4fRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEtmL3pZWssMEA/aJo5sHsfEhrHClnQN1IBFeU4MajKIS2r19d1nkde+iun5XhaTJvOGu3MneFwCeZQHL6Bvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46HKrljmplJAWG6pT/LIkO3ndfAakXwAEV/zHg9Zlz2/GQJ1X
	ESiE/kqgGAkwkYqsIy2inn45qXvocfZEQiy9idy11KUYE++n3YHOW54F9cHi
X-Gm-Gg: ASbGnctSRiEx7a1JhGR1sZz4Tcts/jdp4rx8xbKIVU3XlgTeUPU5eZevRxAONGVFiXQ
	C61DpbpqWzdzQWndJ02vA43dCKvigahX7+PIk96cFMHUzJphpd+zrCWgMF+t5VZGdvzUoXlFfVg
	QLmTyGveMycg6OSiMdYCisdEdcxglGQam39AbCu6XAxwe5ZVfY+H24Bo4Z/+tPiKixzB+7FR258
	5PSE4aZ21IOSmPo/DIZ7Ygn/XvaSJG2WyQVJYJ68zMU4vuPGTRsqCZPoKnm2WrDKyvKZTwma2Mg
	jECzx/kAxGUawTWzUU0DkGrQVVHYGie2XmH66A==
X-Google-Smtp-Source: AGHT+IGB+vjQ5s0SwmcosKl7wURY8go+C8mrSt4nLtcwIuChxJS2yP9IT5jNJEi+3sPeTRIN45Suqg==
X-Received: by 2002:a05:6a21:496:b0:1e0:ce11:b0ce with SMTP id adf61e73a8af0-1ee49f9c009mr8682058637.35.1739293614486;
        Tue, 11 Feb 2025 09:06:54 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c08:585d:6eb6:f5fb:b572:c7c7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad5572d641asm3337229a12.12.2025.02.11.09.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 09:06:54 -0800 (PST)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: horms@kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] selftests: net: fix grammar in reuseaddr_ports_exhausted.c log message
Date: Tue, 11 Feb 2025 22:36:33 +0530
Message-ID: <20250211170633.4458-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a grammatical error in a test log message in
reuseaddr_ports_exhausted.c for better clarity as a part of lfx
application tasks

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 tools/testing/selftests/net/reuseaddr_ports_exhausted.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
index 066efd30e294..7b9bf8a7bbe1 100644
--- a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
+++ b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
@@ -112,7 +112,7 @@ TEST(reuseaddr_ports_exhausted_reusable_same_euid)
 		ASSERT_NE(-1, fd[0]) TH_LOG("failed to bind.");
 
 		if (opts->reuseport[0] && opts->reuseport[1]) {
-			EXPECT_EQ(-1, fd[1]) TH_LOG("should fail to bind because both sockets succeed to be listened.");
+			EXPECT_EQ(-1, fd[1]) TH_LOG("should fail to bind because both sockets successfully listened.");
 		} else {
 			EXPECT_NE(-1, fd[1]) TH_LOG("should succeed to bind to connect to different destinations.");
 		}
-- 
2.47.1


