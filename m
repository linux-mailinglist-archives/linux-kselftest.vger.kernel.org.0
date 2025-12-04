Return-Path: <linux-kselftest+bounces-47038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1828BCA470B
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A7B305B584
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59BA346A00;
	Thu,  4 Dec 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpNaN9N/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D62345CBD
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865070; cv=none; b=a89QmeEVLeaGY+GmNQKJRN9olXHjZcoKQhtOojITWMy1qHF7/2qoN1EezP1+unVrL2pSb6vX+yq4Ys1mwSkZJ/7N2XpxZ8SkjZDgeUp/XQuCFHwqwHCg3TBBcEeMVvXVosKpgefljuwzBs6YJVlOQ6xJiiASYy3DwfCjAhYsAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865070; c=relaxed/simple;
	bh=W/OQe5SBE/hGcbbtQ1DcT8TO1Zhva6jnYh6vp52AP/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fO3szsa+86zgO1zDJgUv1BFmWhJ5h34c98maFnnDIRLNbOrLaxd91H7Eubpcrx1tFKxsHokU1BXqH7WuS8ueQu5YFP28N4iHpUEPXY4JPKwbifWU5Zfk7rJkbhEDDof0wKjYgoeMBcyuIQrOXQVBkIKVW7OfEI5SZRepo/3v/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpNaN9N/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7baf61be569so1341880b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865068; x=1765469868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqotmNbVaSZDa6RHeR/dZGNbL7atfR/Dwuv0KZcoFLg=;
        b=kpNaN9N/eED3awn5YgAFGIbIBjH6BCEe1ugH6xbjeGnxYPWFTeGm3F/l0EEiL7LRhf
         TkqrvGjrzeAyES8YAIn1YZ7TWcsdD2APybxkrjRUOzG21VrbTHlP0+LuHNPuJnAT7XbN
         d0urJX3LiRN+K4JvOGmr6NwQQLlFf5tHZ/5YwszAlb/261tH9D+Zg+tw93YiMBc43XEv
         ViwDQSJNryP46AJpply7vowXa5KqIWNxnzoHC4LCfGcpb4qMUcnsQRFT2OqdhEp+aP3W
         gHV0Op5fn+tf3xVkrjefB01CWEJ324QGKzrBXILs9/Vdan1a8jLWznDUvbll0sG1xPYZ
         kzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865068; x=1765469868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqotmNbVaSZDa6RHeR/dZGNbL7atfR/Dwuv0KZcoFLg=;
        b=dbcDO6bNhi9QIVu2zz2Jy135ox243vylZ8lD1itwvaFLuN7Mji2qSW++2nT0/T0JYU
         jRFIdFuJp6Glr+I4eqIvAGVqzm9eSeJ8Q9SmWD+HaDNy7iKUC/nOZW9j34rgbCKXY9PQ
         QDk3bxm6FFCzzYMWK7CS90MAPsUFwQ0sUj1gFNXmXKCsPII1XpCC/bhW9Se3XH5B2xku
         X8+/ZLve/7mV0UqFHndIlOTjYVX+QUQhc+cUvEfh/AF+HXsVoVdA9tYodTXjh8wwAfWC
         vcGzOyuC1wpDDmP349MTVwsFZBMaGuuB05zc5C6j+KnksoHCBChpK43BMf47BRbNCIzI
         vmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/goUNSvvD++r4RQAD36oDGUEXEHNZbmdQcfwhu/O8bvSzeDlvHltiigx46TZoafMIKv+FHCRhr4fRmINRHow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjaH/WfP/w9s1FrQmumgbmNxxz66aIkDemRDsUCc5BhO63LbBl
	8+1vTihR1xvhGWhDp7iFso/o8o/8X0d/FmcWCJqFIBPvMwtSQh7bLryR
X-Gm-Gg: ASbGncsFl20VqefQs7pf2s2Q/yyPt4XUQtBPbnjDnWw0klZtRQKggpBcPPoY5/BrodW
	oQvUOReFbc7rVgmbwu3VgPSDDJL5jWNCED9i4lf9W8vG5nAe56p76Pr7hSNDSITVLcnKUyqZVr9
	eZWbol6m16f6MxB2jAXGPqRey6tUIHGb+pS3JpGx289nsfEh7FBKEUliIy2P0kCIjLm5jXd5DT5
	XFltqeVW8m1s6d07yHzdR/NxnLKKqiyda5EbyZZWaAQk2TRBpXc1kHwVoGNWtDqPYa0z4UHQ1Lt
	zkx1K2Cnow0pgP2OCqC+y6vTFiZ1jikgpAqYBZLKs5YhGJFDa+luDlGBV0LFeIWaOPWv1n3TXin
	Rcg1WFJREEXQdxqjtlSRGsHSNXxtee9tDY9fdmXiA2PW4vugW7atiGX+FJjD56CbdHQKRYYcWYS
	5W8QcCmH4VYVzpNV+eSm86W5g=
X-Google-Smtp-Source: AGHT+IHVpqKaMcm1FDJ5yjab03bifOuUjE2BJB72SixSC6x+ndj2E9PzKZDdx0HSGekHKIlUwqYNWg==
X-Received: by 2002:a05:6a21:33a3:b0:350:fa56:3f45 with SMTP id adf61e73a8af0-363f5e029bdmr7709680637.35.1764865068434;
        Thu, 04 Dec 2025 08:17:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ed2fesm2637768b3a.14.2025.12.04.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 11/13] selftests/fs/mount-notify: Fix build failure seen with -Werror
Date: Thu,  4 Dec 2025 08:17:25 -0800
Message-ID: <20251204161729.2448052-12-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix

mount-notify_test.c: In function ‘fanotify_rmdir’:
mount-notify_test.c:467:17: error:
	ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’

by checking and then ignoring the return value of chdir().

Fixes: e1c24b52adb22 ("selftests: add tests for mount notification")
Cc: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index e4b7c2b457ee..c53383d4167c 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -464,7 +464,8 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		if (chdir("/"))
+			;
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.43.0


