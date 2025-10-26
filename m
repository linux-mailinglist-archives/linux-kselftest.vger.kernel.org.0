Return-Path: <linux-kselftest+bounces-44058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6723C0A40C
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 08:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57BD18A0B8B
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 07:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CAA26CE32;
	Sun, 26 Oct 2025 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N09uaRca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC942A80
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761463575; cv=none; b=iwoz/GglUmGArtsJl45zz+XaGRU/VwRm+eAC11A8rzF38Ie39ILAmyDqQl8KMV4jjmaZqmxN09d/rywEBPIJAgnF6tosM+CBz2odys90bmk8S2SMp87IkWf1LouFO8ThBkTTwsY1FzD5uxCiNKeSyeEkR6Y/fH/Zh/tP4i1Yusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761463575; c=relaxed/simple;
	bh=Wsp8cxVy22klAhiDGv9P8tZ3IPZ7LUZzLpg3S21IfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uht6DICF2Pr2+u+ap1338ERl57B81Qncsq1mQczPvS6qeq1hUrGnoCek2xl9g8k7fGspAzS+BUDm0zrXWqn2LIqWYQ/IYxQmZSUMjPU67HE2DbvZp70h4eUuB+gm84qKfHL7+c+IQCn2XTQCFM/JMerVYLnTHClbg2z5iSTodok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N09uaRca; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27c369f898fso58078295ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 00:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761463571; x=1762068371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdMa6HWGVI8flyxHcsiTS5cMCkPtytHGgTVFhKdr0DY=;
        b=N09uaRcauINW+Qrk0LiGLJ1eBJ/aA8Zbltog3vai8RA5VpFjQv4QT+5skFfGNBNk4e
         1UoW4uzC21LoYB30lznALNevGBgD+X4npyUyXysENnfGi9sks7VWOHQ+n3uogHR8kDkm
         YgGnWTRlWSn9jBULLV2Zk/P7bE77WsdnNqV/NIkmcxAc6OomkjItaDJ1VcJAJViQwLLM
         YqDnkXIHGTN7hUYGv6iSyX/K7/ELUdu1e3+vhR+HZBTVyaD1TAZVLBP9hubZnGP2PyqJ
         mi2HcL/CAszieu39xTUUP683OjgXcNbyv2zZIs8trVbKdT4DSECbBVg5g4jdfIlOi6i6
         MfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761463571; x=1762068371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdMa6HWGVI8flyxHcsiTS5cMCkPtytHGgTVFhKdr0DY=;
        b=oO5Z/ECyN/xdXTYnQDbbszHHH6pmYIGZ8mOEU4dNSfFclJHHN8PZSWo/PoGOUYstoP
         HNN6lg1DTurKGUGq/mIGbi2E8UhARjvzHew7lEZRiZ6FoStLmRNi5AoK4Xcbb8Hw1lKj
         xUJNvpOBK4N1RkHJvnZ39tYBBJWsqGAwz+rcG/BNT+WXggT+RczeykWzOGnm2JYVpupv
         2CTCT22L2OVVNWOnHDmvFZyCk3f6LFP9hcj48N/1RakqSOvwz0nmsNeuRladfyLEcrHs
         rKGbF2omshtfDIPovYiGTz+fD7Wnc7bZgK2TYeg/6G6zP+DK9QXoSdAkonjnCgMAkyAL
         4XkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHxcaJVZflIEeKEWrVYxODA+18mc0TBUtOwFlp/5ZpkE6cvr6DqIBR1Y6AmtypvciCgw+8xz8PW23P2mbqwxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyurvqHbrHtRBUkoEc8GkJUiK+PoUkfbTZ54fdcGGOJAm67Xu9G
	Gi7RAbM6TBGG4ZkdAuaUSELmf46W7rD88pDuZIx+NJXjRDN//Kqnz91z
X-Gm-Gg: ASbGnctpcK091GExEPPf5e+sZ42y+3sB1hoKIvS+09zv7hfkzkJKpnmO/bjjtbtdqLw
	UiuSmwlSP0ldquASzkHYgpc+mUdIOD+NZAopy8eMxD5ex9Uty2WNZ/c/V5sOh2E5IF6W2gchIaD
	ulRd5sfiEZ4s7z5VufqCHF/sGEz9Z9GEtCf1SBuIXFUFkIIJ2Q088IeCh9c8d0z89C81WB0zMLE
	E/NTg5Dz/q2NxKcxInMl/kFHoogtr6PdEWAq6Qs5BpNfHI0pvltrAUIhwo0u/RMQ0j/GNJ1Ab/k
	yfwzLUPHBrOyI9TVQ4x+6gCTBd5XxHTACQjf7gq9kKEDJcmvYS35GoVU9OGumy3q5SYee3thtS/
	R3Gw/G/mzpB9EKVY++SZx4kfX+74Yrev/ScNxG4Ix5SDh9sw1GifOMP5/1OboBHbjFonkGGqPDk
	8jRmqTajwbrEC9a7Gj0Q+meJAO6EZPys+h5x7tMU/N
X-Google-Smtp-Source: AGHT+IE5U6eGzQVnJuOp2Y8MluTWBLNlPfwZGE50frkHscCUegOKsjhIR8XeTV7M1ymJACtKk/unFg==
X-Received: by 2002:a17:903:2441:b0:271:479d:3de3 with SMTP id d9443c01a7336-290c9c93d94mr423076345ad.12.1761463571105;
        Sun, 26 Oct 2025 00:26:11 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2903csm42817175ad.63.2025.10.26.00.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 00:26:10 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: shuah@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH v2] selftests: tty: add tty_tiocsti_test to .gitignore
Date: Sun, 26 Oct 2025 12:55:46 +0530
Message-ID: <20251026072554.48786-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d1a483dd-5405-4e8b-8a38-816d49fffbc3@gmail.com>
References: <d1a483dd-5405-4e8b-8a38-816d49fffbc3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the tty selftests generates the tty_tiocsti_test binary, which
appears as untracked file in git. As mentioned in the kselftest
documentation, all the generated objects must be placed inside
.gitignore. This prevents the generated objects from accidentally
getting staged and keeps the working tree clean.

Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
staging the build artifact and maintain a clean working tree.

Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details

Suggested-by: David Hunter <david.hunter.linux@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog:
- Improve the commit wording and explain clearly why this change is needed.

 tools/testing/selftests/tty/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
index fe70462a4aad..2453685d2493 100644
--- a/tools/testing/selftests/tty/.gitignore
+++ b/tools/testing/selftests/tty/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+tty_tiocsti_test
 tty_tstamp_update
-- 
2.43.0


