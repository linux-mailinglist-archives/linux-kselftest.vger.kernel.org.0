Return-Path: <linux-kselftest+bounces-47031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B01CA47E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 131B7304AEC3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E357314B76;
	Thu,  4 Dec 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5v2143l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA0313527
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865061; cv=none; b=Cu2yHUwPl5Fe80jZxv7NmNqb/j2xd8M3+EfPqk+r5ynNX5qPeYA+vLXDzmqr2b88amTFhijwrd1J883OnrFkrtbLdCeO8g0y/ZASab+LpI+VZKKVwdwioIG5g6BwFmHA8UF4LMGz9SuRSudNbDorJPG1E/8C6NsMt8PPc3pzo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865061; c=relaxed/simple;
	bh=uojvQcHou5oXqNNEnLZdn5nZm+d1gWRdW3OC5Z/daso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4SrsDC3cP7evNc2awDUg/5c03ng+CKbiAKubN3U1yIxQmSN/C4ZqhchS8a8lgCeoynytZtgNME7OfMblEY+WxL640s1MBXKlbe6rdM8ECmwT2wjzVBQ1LNmaKZbMVj0w7+3YSCntD4tHLtx28hshu1xVVS3IoKH+hTxgg45uIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5v2143l; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297f35be2ffso17173075ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865059; x=1765469859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOzZfIH9Lo6vEdAA49vWqjJXfX2W8pQl4mAmhvon218=;
        b=R5v2143lgd8e48JQqvoXR8DoQj9CWMt1B7SZVQ2YY4soQMeaNeafYH4NkvCtuZLVvI
         inn7nPPGC9nnu0dD0mg1b7pxXofWCMu4631B24LEAk/iHQQsfzOXtZRpsnHgOwregXSe
         haKnwQyPGz3RU/9Mi0+QY9oKM9P+pZu7Cq5ZAM9KoTyb05udMISW+cazO/G3n2Zx60Rd
         9A4rcYXaZLDjfxRUEpHhQz2cdXhFzf274gZ6fl5Mr+MD1FMFU6i2cZsgAOXFkGSNwiKo
         2n1QUt2eaxh9f3LDvsW1oizDoyx0Evv4+J7NUtFt21Ta7C1how4kOlY+WZDayVinOPrc
         5+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865059; x=1765469859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOzZfIH9Lo6vEdAA49vWqjJXfX2W8pQl4mAmhvon218=;
        b=LGxfXXtjPjIZC9ecr0ALjC1jxP9jqunpM/Huuf25XVTyfebgBOBPYPOufU9YWFGauW
         aKWYw80FaK4Rk0K2Px2SSW6ukMSIEoRBu4VQHZgZLZLVM2zAPpQTwSl9hQVrSmYja4tW
         widMqg6qQlLjNGWyxz9DY6zThuKNO/epX6VQPDwGh0tTSJdt0k5Gc3VuaGrMBlh5flAJ
         GJdSstWxPODFpnENbTrt2B4tUiysTCUdAnbzlud1rhUKCpNNNUDfzMsM6M1upLGpYtoO
         AhlcKCYXSGJ99khPUAGHnJEnOdsXfzgJ1QsWymCJI2W0fty0CBsGae6/GzRyKKuZhD9i
         uwgA==
X-Forwarded-Encrypted: i=1; AJvYcCVpFQUT3CdPMcVKDgQD4dH5/cmxiT26Dfu9BZYQBN+VndMOei6lkNHQCvTro6eSDM4LRgmLV2EX6du3fQGDRKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhV6Wyr76esuh5C9rrjIxxT0yDnzjcuu759FIpjwu1cWTJKdoB
	IE+BwU2fROmWOqJPz142Pi/ic/FHziZrjByLCt8+egMSKecxlMCmI7Iv
X-Gm-Gg: ASbGncvwmwmYYJGr0axw0E7CoLxxsT0f89mmHbOtvU0nHHqeJhK1uxF6HKo3a9BB5ab
	xRG5VAJlTVhoA2w6jUhBuAjsZbcmzBvbZ02hgnAOe/Suy5LzVVE/JiXk25n6oH0K6ChccT4mJR5
	Tj2d/YGkBQvfZclpdgPw7JHifjbgVW9q7/xG2mqxTwhl7sAtxKybQ1mhK/3fGvGp/nOMAVtgcvi
	Tof9yUiI9/aaHyC6PQAVN9URCDEDKu0TaQCAn9WbhbUTL9WB84ijOsqPD6USNLH3d/GJAnNNj1c
	OgV4pOAeMbOUobqs6EAERSRl5YGDKfiMYtmlj3L076uEsvkPwT8Z7OEUpaN3MFbnYPdq5fe7ml9
	X4cAtkO+qTp6QxNOy5qh08K4bSEbwmX0drTI2eVL+9n66qtaIurbyBkPxTjNFVotSxmDa8jovtU
	xXDSaYJjGpvxDJ9KpcVfY+Joc=
X-Google-Smtp-Source: AGHT+IEhqjbEuXaysSF/wkAXhEmzAlPFdTVX3OMfc8S/rfmItTqonwqGE1/z5t8WZPXeAov5Rk8BdA==
X-Received: by 2002:a17:903:3504:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-29d683eb3a8mr83132745ad.61.1764865058842;
        Thu, 04 Dec 2025 08:17:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f1cfsm24139315ad.55.2025.12.04.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:38 -0800 (PST)
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
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/13] selftests/filesystems: file_stressor: Fix build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:18 -0800
Message-ID: <20251204161729.2448052-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

file_stressor.c:112:9: error: unused variable 'pid_self'

by dropping the unused variable.

Fixes: aab154a442f9b ("selftests: add file SLAB_TYPESAFE_BY_RCU recycling stressor")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/filesystems/file_stressor.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/file_stressor.c b/tools/testing/selftests/filesystems/file_stressor.c
index 01dd89f8e52f..4f314270298d 100644
--- a/tools/testing/selftests/filesystems/file_stressor.c
+++ b/tools/testing/selftests/filesystems/file_stressor.c
@@ -109,8 +109,6 @@ FIXTURE_TEARDOWN(file_stressor)
 TEST_F_TIMEOUT(file_stressor, slab_typesafe_by_rcu, 900 * 2)
 {
 	for (int i = 0; i < self->nr_procs; i++) {
-		pid_t pid_self;
-
 		self->pids_openers[i] = fork();
 		ASSERT_GE(self->pids_openers[i], 0);
 
-- 
2.43.0


