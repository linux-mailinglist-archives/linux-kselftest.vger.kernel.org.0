Return-Path: <linux-kselftest+bounces-18319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD3984A7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 19:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74902853D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993871AC88A;
	Tue, 24 Sep 2024 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/5t8i/3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29002F855;
	Tue, 24 Sep 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200523; cv=none; b=ZApVpMD3RZo1uW97T1JZYBMF44SFuf8q2q1vD3+5nSqrPTb7v90tzt6Pqi0xOoiQGdT5hvPgSbSEeWGn2KVyZvC0CpAHcfwQ4nrL9icrKCxOe8bwVkXc7SfPFEUnXcluIxSgjhpfwtF/QgQU/xn57NkwutOLYhqtcHU8MYO14tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200523; c=relaxed/simple;
	bh=QxT914bDA0RfhWDMhfLmy+RtduzqQ8elqZ2JNEBwLdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miXYLIujX1vGQ6xJLTKCaXplxebRjXa/NWtb93nQKBIlNX5T7zcmet3+xdAtQdKn1U3jZ6LHtogV9ZtM17UbBqNFDMzp5a8NUGbl1UAPdZ/ilGIZB7NqwoQYDpnzjXpr/4dmRqLHm5ts6aaZH8Fkwme24aHlgwMfSF+VoSUUfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/5t8i/3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6de15eefdd3so43262227b3.0;
        Tue, 24 Sep 2024 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727200521; x=1727805321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhO9HuyHJw2V+eJWsbkCc/m6qGmvadaQTKFPjTTqDRs=;
        b=W/5t8i/35sj5mGGY/hR68HPK7T1S4xOKjI3yv4kaGU17VrsPuy76Oaomht2iQCFmHs
         vPHgcwrBbvx6WZcz/QIBgVBMgbxib7UZ9rxRQg6jFZ6tiyEi0xF7IFoXGUuAR2a1EU/9
         1I/E7IznHdR4iMnHDZgCy76vGh+e2cGE9ywo467QT/7wSSkdrIunLx7HM+SDbx5Cctmt
         D+Q8m0gHTwjkzqnmnnYcsl5JoWQTenhZH/EJd3na8NBcVF73R1LGR+peinCRcqhE11P6
         nUAjTnUL0lZf0rQs97yQYqeG3LEK1cDIdHK4yiLf8ApvmU/ZZhwP7glwWTVcfQ8VSH+q
         SY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727200521; x=1727805321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhO9HuyHJw2V+eJWsbkCc/m6qGmvadaQTKFPjTTqDRs=;
        b=p2RcorfMEZxA74PWZLMW2HRX8LYFhedU1AnnG/q0qAyfcXZH0WI40IPI3zU7NjjMRs
         S2pULx7GZ09HGf0/U1RW1sUherpaz+Bvkb3G703bwYmoxyVpEnu3pQkTF+XKjIafkg89
         6Am6U3IOULmBqgfLoaEcOTGSo9J4r/q7QMNGdP5Qy4ZlMm4gJRBHVAYAHSv72/w0cpHy
         86GqiHYn3upR0zpEkLSQJwaKX/ovjgRx4EKdoYtJR1eIohJZtFeZmIwSBGWmAERIzVTk
         pJvpwwbTZE/bz6162xrrlZNa+wYTpgY/ZgZFgLk9C5OsXzV1aN4jn/NwMiBLDnRiluyx
         ZU2w==
X-Forwarded-Encrypted: i=1; AJvYcCUFKLucMcfFbScufO9gnwwzZjIefMLXB7LkPYbNK1mzpSFA4wjCEnZLDcDYfW/L1Tlz8l2ayKgs@vger.kernel.org, AJvYcCUkszacWUJlR2fiu/bdPVpADVI/jDx3Ypcsjtl3g1YnsbNSwfEHKBjXKARyhBvLSwLRn8UFRkze3OSVx+M=@vger.kernel.org, AJvYcCV1Kmf51gg/AvKSUXaatgSviouGQRs5WSnv7+OOnjaxvKTSfo7/+gzHXY/CVb2jsdEJGGXmjkQUOTHCJUCiBwps@vger.kernel.org, AJvYcCVE/4X7aH3Pv8gVHe7LhWp7KxKgpM/bdcLA73YQTXXr8jF35Bm1klbAdmHbemT7OhhyrhK9sm5L8S5cuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHi+SlWQU88w4EIdituOVzdErTYQ4TDn6rrqae3/mbHxxIjZL6
	3+k0ORdoSuRz77bJ6CSSxsuiVneFLJSTI2jzVC0O1MI1yWk08VpQhdLcmQ==
X-Google-Smtp-Source: AGHT+IGoGHDLRqSqcbdYZpBp/Ik1TaSCEKbTqZMOHeO0TcNrA4v/Gon8yURePwJaL0JDdo0Gddcv6w==
X-Received: by 2002:a05:690c:6d88:b0:6dd:ba68:4bd1 with SMTP id 00721157ae682-6e21d84a573mr3032407b3.21.1727200520967;
        Tue, 24 Sep 2024 10:55:20 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e21a2224bcsm1077837b3.53.2024.09.24.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:55:20 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	damon@lists.linux.dev
Cc: David Hunter <david.hunter.linux@gmail.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH v1 1/1] selftests: set executable bit
Date: Tue, 24 Sep 2024 13:54:57 -0400
Message-ID: <20240924175500.17212-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn on the executable bit for the following script files. These scripts
are set to TEST_PROGS in their respective Makefiles, but currently, when
these tests are run, a warning occurs:

  # Warning: <file> is not executable

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 tools/testing/selftests/damon/damon_nr_regions.py                 | 0
 tools/testing/selftests/damon/damos_apply_interval.py             | 0
 tools/testing/selftests/damon/damos_quota.py                      | 0
 tools/testing/selftests/damon/damos_quota_goal.py                 | 0
 tools/testing/selftests/damon/damos_tried_regions.py              | 0
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh      | 0
 .../damon/debugfs_target_ids_read_before_terminate_race.sh        | 0
 .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py    | 0
 .../damon/sysfs_update_schemes_tried_regions_wss_estimation.py    | 0
 tools/testing/selftests/net/rds/test.py                           | 0
 10 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/damon/damon_nr_regions.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_apply_interval.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_quota.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_quota_goal.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_tried_regions.py
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
 mode change 100644 => 100755 tools/testing/selftests/net/rds/test.py

diff --git a/tools/testing/selftests/damon/damon_nr_regions.py b/tools/testing/selftests/damon/damon_nr_regions.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_apply_interval.py b/tools/testing/selftests/damon/damos_apply_interval.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_quota.py b/tools/testing/selftests/damon/damos_quota.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_quota_goal.py b/tools/testing/selftests/damon/damos_quota_goal.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_tried_regions.py b/tools/testing/selftests/damon/damos_tried_regions.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
old mode 100644
new mode 100755
-- 
2.43.0


