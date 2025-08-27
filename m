Return-Path: <linux-kselftest+bounces-40060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A952BB38705
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 17:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB827A335F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E72ED16D;
	Wed, 27 Aug 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mdei8Blz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F61DB12E
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310007; cv=none; b=VUVFARSPCP+Oa/yBEl6mPe4iaP6z3KWzAJwlUJEwgG9zFuWQt5FoThZOKWTUFrRRK5imyscjWjdXKwK88jot149iH+0i2MImUdVIYsY42WaDGU3ZBp69CwN0oSTvxdu3SZluYjJ4JaOS6ADZyf/3D2iMRwMaFFU05e1u1pIfpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310007; c=relaxed/simple;
	bh=2UpO1FfSAolEpwSPP2EWg5tZVoQy9P86m/xL7KfQJgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Siptfz5QTGdSQxslzB2jMu3Kf0Yxo4PWuKhFWGQS4+EnQ9qpQgBoE5xLjb3EXxh+Q+HganQWAzCF0sZpKiw2/aken4KWA+TFlqNIzZrYxPNcSrBgqOLBw3ac/bzo8R00Fcb/pUU1WGZ3EX6qnTNhEhWWyU5gWsUOXQStX9OdEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mdei8Blz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c7aa4ce823so2809693f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756310004; x=1756914804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aORFJsOtxyBIbTBxZVPj8pyaIXM9Qpd2XimaL1nX9eA=;
        b=Mdei8BlzidHlMFtXLumS0ZsUqFWiWb+0kthjbPJCsnP7SG/xBcYW70cDalvWBqod8E
         yp7Q9RAXor9QcZQlvZZR8/8jkkhAUch3s85Z/05Jd9p94JYmQaMsYJYBeOBkHda+i8Xh
         L1uy593IEV5wVbDWgRBeYeI4IQaqzRzqT+2JORr4a/Xpjs/Qg8JM08xob2lu1+0pLowN
         LRgkX0wAQf98/Bw8UZw7m4q2ar79B192i+AoQ9PWGaRSF5pW4afqqTDFHMe5s8M+WlBg
         c9nAqsds2S/lbndU3fJJkmgZy2Y9KEBhPLGk3AYUHC5ZsSesMwTL3MiFEKYj/c7HXkLQ
         4MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310004; x=1756914804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aORFJsOtxyBIbTBxZVPj8pyaIXM9Qpd2XimaL1nX9eA=;
        b=QWd1zenaN6QzwaiwvsAaO1B3a245kazlCQ8OVAt5vDOfq5xUI7j47cFvtEW2FUCTB1
         Z8JysUuDN7FWOxTbT6oAqNKr9GHw7jyFFG+qaZEX7VZY1EPHKD7uO+E7/2oHel04frrz
         8CCmF8kr+QVjXFmaC5iQFH37zMqhATp1vrZOYIPD1qGeOhpPXolTVfkP0AE6XzhHjQBP
         TKqSIQlGkaCnUWQPRuexIWaFv03BrG2OX6OOY4WclTviiylK6hFNZJQ1mjtD9PsQEy1X
         gXDlkla6Qp9hsgoKSax7X4pckOzwCUknmnlmn2AA/eH/qyGOAMUrzI9IxMPwGMvrAKfu
         ulHA==
X-Forwarded-Encrypted: i=1; AJvYcCWx04eFGTx/IiljpnHsIn27DbN7t4/eJOuGbA8c6SEiACN6xHlqCv2KQJT4D9T3oF0lnWO8wop6UyA35ASw4+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLtqIgQkr5ynmDhgX/ooCGlKbNgaSAYRd8Uh9+SCuJr5TIojl
	bcFdiNB4daZqg9XUK7HGtYqZxPhUst6MVr7j7F+boSHxSgcpFcvk73YHUbV+mkqit10=
X-Gm-Gg: ASbGncujkZ7384EOfoMTJ7UDpaVtCHZSKPjcoe9vQ0EL2fy5lHoFW19bhkv0/W/n+d8
	xzI2W5Tk2yDgTEg/Dr36hFWrrxZw6LisP3IWulSzUQFn3gIA3Xovr60ba5DiJGSpoHvHDK6o0Eu
	jw1pZIwCiDCs89s8I7S+AJTkRXCMIXdLwmVTUWR1ZIJhMDD9Mr7LVCGjAyepdEm92O4Ae1yu5Od
	5/LKTttBZkB4Aks3kOQ4l82QRY22J0TAQYzT98mPK0UV57npj80mW8MQwlEV5SmJwQUc7lG48ZP
	qMucGw04f1KkT7tuDyY2bkcJ52wYEcSFA7dS460DExLc/BvOkYDSossJZF6+2VKlKwgw7SR047J
	9+xOW89rVhqO3ii3cLURFNov0+VIdigG7EmTszeWONb0=
X-Google-Smtp-Source: AGHT+IGQf2UmLaVHAm6UjBH25TTecRgnSigoijo7WLq5hvG014tdSr/Fk88m3djJQxTIxXjypPIDGA==
X-Received: by 2002:a05:6000:24c9:b0:3c8:c89d:6b74 with SMTP id ffacd0b85a97d-3c8c89d7067mr9715618f8f.46.1756310003930;
        Wed, 27 Aug 2025 08:53:23 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3278c74ce0asm1070677a91.20.2025.08.27.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:53:23 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests: cgroup: Make test_pids backwards compatible
Date: Wed, 27 Aug 2025 17:53:00 +0200
Message-ID: <20250827155301.174365-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The predicates in test expect event counting from 73e75e6fc352b
("cgroup/pids: Separate semantics of pids.events related to pids.max")
and the test would fail on older kernels. We want to have one version of
tests for all, so detect the feature and skip the test on old kernels.
(The test could even switch to check v1 semantics based on the flag but
keep it simple for now.)

Fixes: 9f34c566027b6 ("selftests: cgroup: Add basic tests for pids controller")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Tested-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 tools/testing/selftests/cgroup/lib/cgroup_util.c     | 12 ++++++++++++
 .../selftests/cgroup/lib/include/cgroup_util.h       |  1 +
 tools/testing/selftests/cgroup/test_pids.c           |  3 +++
 3 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 0e89fcff4d05d..44c52f620fda1 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -522,6 +522,18 @@ int proc_mount_contains(const char *option)
 	return strstr(buf, option) != NULL;
 }
 
+int cgroup_feature(const char *feature)
+{
+	char buf[PAGE_SIZE];
+	ssize_t read;
+
+	read = read_text("/sys/kernel/cgroup/features", buf, sizeof(buf));
+	if (read < 0)
+		return read;
+
+	return strstr(buf, feature) != NULL;
+}
+
 ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
 {
 	char path[PATH_MAX];
diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index c69cab66254b4..9dc90a1b386d7 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -60,6 +60,7 @@ extern int cg_run_nowait(const char *cgroup,
 extern int cg_wait_for_proc_count(const char *cgroup, int count);
 extern int cg_killall(const char *cgroup);
 int proc_mount_contains(const char *option);
+int cgroup_feature(const char *feature);
 extern ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size);
 extern int proc_read_strstr(int pid, bool thread, const char *item, const char *needle);
 extern pid_t clone_into_cgroup(int cgroup_fd);
diff --git a/tools/testing/selftests/cgroup/test_pids.c b/tools/testing/selftests/cgroup/test_pids.c
index 9ecb83c6cc5cb..d8a1d1cd50072 100644
--- a/tools/testing/selftests/cgroup/test_pids.c
+++ b/tools/testing/selftests/cgroup/test_pids.c
@@ -77,6 +77,9 @@ static int test_pids_events(const char *root)
 	char *cg_parent = NULL, *cg_child = NULL;
 	int pid;
 
+	if (cgroup_feature("pids_localevents") <= 0)
+		return KSFT_SKIP;
+
 	cg_parent = cg_name(root, "pids_parent");
 	cg_child = cg_name(cg_parent, "pids_child");
 	if (!cg_parent || !cg_child)

base-commit: 04a4d6c24eef8a1fc89d8b6129ac00ca2f638aff
-- 
2.51.0


