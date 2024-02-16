Return-Path: <linux-kselftest+bounces-4885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E200858933
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 23:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B131C221AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 22:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256021468ED;
	Fri, 16 Feb 2024 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsEPWQX+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224117BC4;
	Fri, 16 Feb 2024 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123901; cv=none; b=aqN70wNqJgP6fvbSsAjVsQfbJl92aKlZr5ro8Lio6Jqa2PYRP61RKUDmske42+uTXfpI6xOM0VascupceMuCb3aB7dzPEscBDA3zHwJFQJJndh5Qm/slE1C6DVE1Av5Xs/tuQNUneviuhqm2aKmytSX31Oiwxw2z8GkC0/YBO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123901; c=relaxed/simple;
	bh=hOmzS5SJMxt/Y5VNiAfAYsPCia8dfM+pw8DUfVZOG/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQCGtRIswKaTPflwyRzVgimQm5Ye0+aFK3BWpj7lRwtK7oqbbOtsz+CmwYWw3bNV1o8jphSkD2zygnp27JviTV9k56igOLHXyYpMkFJOFLh4Uh1mWg9yLodZjiazGG0Owojpbj8nS+tj5Vfshnzseov4WZ7ILH3BoWfnSIqoyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsEPWQX+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d911c2103aso17671735ad.0;
        Fri, 16 Feb 2024 14:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708123899; x=1708728699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFfXHdvN/5mUfAanVfariAJApfAz/jLdm9t29L3ltRk=;
        b=jsEPWQX+1zG/3l+hdyqsgZtnzG6s4hc4+w3OWqqj83q1Su3yQ3nn2ZOhhf5+0clyk4
         MXnHZ0uzfQLO8BkNUJC5kscGxM5CphdMxjqsAChinClb0OpoPm0J7Ka4OlOr4q8kPAZZ
         VxR8Yfj+kQjzVyd4NfgG4unvEwJwxPVBi7FNR9pfQQP4bwiv3UvJAmy6E/KvoXaFFg5t
         Q1zVrlxBskcI1wK6sIsqQ+zlHMXKyMcaTgO8ztKQZnGxNJp3/HWi5/ZFJWc4/85RwK38
         V9i3W3P+ytFtyDJNACmDcQi3PZr2Z04L9/wKC2iF5iLM7+jt8m4m7f2Mr0xg2SeeGTiy
         kqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708123899; x=1708728699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFfXHdvN/5mUfAanVfariAJApfAz/jLdm9t29L3ltRk=;
        b=IUXhWqeRBAWhBFumu1XjbfBsv9S8S0cRxm6lS27kVjAez7MnI7Hh3WNGP0BVgzUtI6
         EOUzjrxuI6F88DNg9IydOWLNWBHwUCc7Cclre9esFOxaqjqXs9wZwwQQiG8pNLC3hLLV
         gY5sjMzjAgOjWYJ3rxh3AsfE7WFz3xpCvetCe8vS8JiXitKI0l+3jfTNl8eIcxVqcT09
         gkSpsnLurAvQxaIhd3U12Mz7AG1Lyu7/zxbFQAjnU+Z00O2ItQey75pDAN4ZBJGHbSBa
         eqlgItS1Ga4MJOZYUW9wCW/IiqrAoaUPk6qLXAeP9snL1OaVmCQiJdsVx/KeYDL1B3Jv
         Lr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV4wikSIAxyLU2xMCl5ln52sHT8Eqz4yqnxC7zTwub2UL3JNDUYNPZ+6SpCBF7rj53ZtA3dXbFXYjDdtAxeNC4Q+VUWcSAejn1yLTsKcAvV4BgNkLa0Dxmv5Va0hSFT9x8RY+V0rvMQWDnyeLd
X-Gm-Message-State: AOJu0Yy7NynWHKfDcj5hSzaf93giElJOm9fI9nIRjUzKlOat1f0CGCL6
	czrIz5MeQaokOnqtyW9kFgnMWf/mIb1AxAysKN2x6uI7Rr5H7yX6
X-Google-Smtp-Source: AGHT+IHeAkmfXPrbWoFN5dC/QoVyRZxnAGSBvRQsSqGZPXxRNVKgHNClKRWIqa3PNVjwIgKGo3jvdA==
X-Received: by 2002:a17:902:bd0a:b0:1d9:4ebd:b94d with SMTP id p10-20020a170902bd0a00b001d94ebdb94dmr6267345pls.55.1708123898663;
        Fri, 16 Feb 2024 14:51:38 -0800 (PST)
Received: from shresth-aspirea71576g.abesec.ac.in ([139.5.197.147])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ee8200b001dbaa8c97e8sm348573pld.225.2024.02.16.14.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 14:51:38 -0800 (PST)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH]     Fix implicit cast warning in test_klp_state.c
Date: Sat, 17 Feb 2024 04:21:26 +0530
Message-ID: <20240216225126.454999-1-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

    The function `klp_get_state` returns an `int` value, but the variable
    `loglevel_state` is of type `struct klp_state *` and thus does an
    implicit cast. Explicitly casting these values fixes:

            - warning: assignment to ‘struct klp_state *’ from ‘int’
	    makes pointer from integer without a cast [-Wint-conversion]

    on lines 38, 55, 68 and 80 of test_klp_state.c

Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
 .../selftests/livepatch/test_modules/test_klp_state.c     | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 57a4253acb01..ae6b1ca15fc0 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -35,7 +35,7 @@ static int allocate_loglevel_state(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = (struct klp_state *)klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
 	if (!loglevel_state)
 		return -EINVAL;
 
@@ -52,7 +52,7 @@ static void fix_console_loglevel(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = (struct klp_state *)klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
 	if (!loglevel_state)
 		return;
 
@@ -65,7 +65,7 @@ static void restore_console_loglevel(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = (struct klp_state *)klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
 	if (!loglevel_state)
 		return;
 
@@ -77,7 +77,7 @@ static void free_loglevel_state(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = (struct klp_state *)klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
 	if (!loglevel_state)
 		return;
 
-- 
2.43.1


