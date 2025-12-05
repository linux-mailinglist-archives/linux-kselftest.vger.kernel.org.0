Return-Path: <linux-kselftest+bounces-47124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C12CA898C
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AB7131A0C2C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2478A3491F5;
	Fri,  5 Dec 2025 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP3cAG4e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFE34575D
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954760; cv=none; b=vCqYe+cv0IYtlIv8sdYp+Rr+d8dUV5KBUiB3/Z03kFPQWrkbTjo8Nkqymx8SggkRA8sqxR3tVMnIuJHhNMsQlVEJto3jHodEmm8LO6Jybydm+Pc8+Yy3zWRABiMKJivFrMYeSyskEV1WMU1RKUL6zoqq9aPyY5XUPKu5mvg4fVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954760; c=relaxed/simple;
	bh=ThCJjVG5RVMfr+zdrGxXazrxZX2CekhpjLmMxCxTOIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzK/324FUvlKbRWtMJMPTjtmC+dFCQYqFgo9QH9tKwWsjHS2brSt3TowdH1i/Ciu2yaUngRdqmv+o2B4l8g/7bN3eYigQvdvcu6ahP1McquWIHbHImTpTJuwZ4lCilnzgdYObk9l0iNWNol3T9ADpkj1jLY0z6AZh6ssModldak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP3cAG4e; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29555415c5fso28610175ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954746; x=1765559546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KthOHDXIygNvoKbYqyGnez1cqEGX3CMF/hwkpTkQzU=;
        b=eP3cAG4ezK1TsESvpI45ZoOcnw7xSCR3V/ZH08uto4kj8uVfS6myIq6k4a+yWYITwV
         MpKBhj2XDnKKPUUo0397EHk2lN/jaKzwXyo5QNb3A25HSpyS2vbHSA0Y7aJfDq0AEsEX
         YkRGBmih/vz/fghrwW+OJ3JFRCyv8A7WKlArZg3G9hSxMeQaZwzXxssG0b5xf3swXBKg
         wSpJ8m6KDusuVt3CN2T5MWwm8BJt95BPq1ra25XqrTHm7/2WfEubQaIBsz5V7hnKpOEz
         b9vsgmI7uBjDM6e84Bd7JgZHixFTHceBd3F9sI+c4zq9yZnQxNe7pEwL//jt7sPzQIFN
         ttdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954746; x=1765559546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KthOHDXIygNvoKbYqyGnez1cqEGX3CMF/hwkpTkQzU=;
        b=kVUbbVy1CENhqzFLiZnbbFS7OZhTyBQgCQTHvHabquZsVIScmYPnhO4KDBtok4qMd4
         mB+rVfKlkWqfv136b46Im9zoeZvTHur4z2WrNPbw6Gqo5bU+XbmAYvIU5ZGmWhTuiMgz
         rug9cedl1+VtOZExqDldbWbpUTbSDlUGHTDMrgBgTjUq3VDF1yL+UfkJtcZVyX3eFHWp
         Gmn3cr7P2NFQFyv3Xuel461MhySyc2D0Pa2CbP0FiJvQ7euaCuCEzowzvLfFqA6CQ5zy
         RVWSfgmzR+1nixybeYOtd9/hkVptSsAzmndE96mEgSs0Q1QyYI3hGykfmjLOeGcjfHLG
         GkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl0qiv+qV9tM+mW7qgbLdl9xj0uz6hQCPpaUsMclnWfWAhbfa6O//pZyrc03ffSCL0jNgdA+OFxMIgLG7Oi7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1KpffKyJL6F6lcEk/JbuL1gL1VZ2xFEGVVh9qER2RkYkTNwO2
	xjDCiXTdxlJhHCCNJgiI4+U5RgiJUmoto/1NzI7bOUsA5MuhXPGks+N0
X-Gm-Gg: ASbGncvTkDCeHXF41tI/pSlkBi0Xj41WjCngebGYjDs3JPN/+wNbuFI5DpOq3OITlX2
	ZbJk5XWTY2QIPqd6uDdL3JiNY2lWScv3WPU1QFuId+W8jTBNKylAfaloNFqYd3A3F4T23PxyPPk
	YqGva3bZUzDWZPYxpTCm6ulUyfutw0/bqy3Vrxzsv46HUhFONuYN46eyXHpz1OXR/OV2iMZDzJJ
	4aqxRlFMnV4gjLNqFc2WIR/q0fsyrX68KqZeVeTaGpgnMF6FglBI8KxdJn6+9S5P/tVyk7V5Gpx
	Sq4GZ4gFll+SXn/pIG/KKmPJucRLnDgNiQJ9uMq1aGq8dhQIukMNFWUnl/D3ChKe4YMm4CDH0YE
	FXLen5lVouh6ThYR0yL87IJgS9Pu9zZTgGJsnNQ9C1skRSGCRmAfGmAhO0RuIxlpxJkYVD8eaa/
	S7Pdu5cCQhG7Nx2PRP2GkZr1s=
X-Google-Smtp-Source: AGHT+IFGP5H8TS9l/ZWNTkIDFkoqd//BYSN576PH3VvQ3NUTIBZhXN9o4FjDBwMKRZAasheLBNdWLg==
X-Received: by 2002:a05:7022:ebc9:b0:11a:2f10:fa46 with SMTP id a92af1059eb24-11df0b44724mr9060052c88.0.1764954746240;
        Fri, 05 Dec 2025 09:12:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7552defsm20339483c88.2.2025.12.05.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 12/13] selftests/fs/mount-notify-ns: Fix build warning
Date: Fri,  5 Dec 2025 09:10:06 -0800
Message-ID: <20251205171010.515236-13-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix

mount-notify_test_ns.c: In function ‘fanotify_rmdir’:
mount-notify_test_ns.c:494:17: warning:
	ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’

by checking the return value of chdir() and displaying an error message
if it returns an error.

Fixes: 781091f3f5945 ("selftests/fs/mount-notify: add a test variant running inside userns")
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning.
    Use perror() to display an error message if chdir() returns an error.

 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 9f57ca46e3af..90bec6faf64e 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -491,7 +491,8 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		if (chdir("/"))
+			perror("chdir()");
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.45.2


