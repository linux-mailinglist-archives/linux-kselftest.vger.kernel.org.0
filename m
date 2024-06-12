Return-Path: <linux-kselftest+bounces-11725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1797904878
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 03:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37828284F40
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5994A15;
	Wed, 12 Jun 2024 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHOJVDHK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700984C90;
	Wed, 12 Jun 2024 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718156150; cv=none; b=sr8aOhQ00c+rBcERpS5CGab8Z4ZK7JyyFVz0IVP6x7w1JzuoIUaMgCiks/K6zjwa8ZD09Ffsem44OK8gIrucNRkop6Tfkw2/xcLFICmYVzht/zI1jxguuvbRXmsQ9ev1UcBfQd6PU0xtw5N/pcYnCx1PY9lr0+N8BB73iP5RNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718156150; c=relaxed/simple;
	bh=yTYu+zjzSnvVXtDPpg8jDiEvElerW8Sdp2y1QzZxXgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O3E/fDKkRjWLi4ftU+/VwIb9QcZYL0D+24eUDaTFQs4pQc1SObZHSZyEYiyriWqQ9Jk62lle3Y08C7opUZiJS9AgMDB20PrHL/oVoBzU2TjIF1zpCULHHEGmMYFUe7cI2xNfQPtUp42XuF/esDRlOiL2evI1oY6dRu+hcJi2ou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHOJVDHK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2ecd25e5aso2995715a91.2;
        Tue, 11 Jun 2024 18:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718156149; x=1718760949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHJbujBLIYDpnFz6RlBGq04LsufYNQpcJYJ5eGH4g8U=;
        b=cHOJVDHK62uNRG3x2xbt1KLyVLQXGM3F9zzb6103EX2vZT0/kx0yQNL4kbNMmO1zFg
         jmkEFmyuUiprnMXtv6HEuGLVQ7fH6tK95ZL6Hdj3sHf233Jp1PzxHx06psghV9vtVG/5
         kvptRyfxwyQlOsPQ+YbV97W84MbQ6kC44gAAFb0iWcTjq08hnLTaLV6CoZ9A1Pnq3q7s
         Tv38bXla56TlQigJg/fZW8OJKz7Q5SsHTyG6BrGwX5D+yoaaykiBOGjVKiVEEyLCUT4M
         rkrEdstTQlVbG/bF6a5UbU5cm3M6WMqgYo5t7N+M3Ua/6C5znL2ZbXJF1jBbwFVF9Q3x
         m7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718156149; x=1718760949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHJbujBLIYDpnFz6RlBGq04LsufYNQpcJYJ5eGH4g8U=;
        b=LRvkivQEhsZh31Maox69gWir4QVStrkHWidBHeaX5EaDi82obhS3ipVDR901jPCNeJ
         dlTCQSpX+EfyNBW1joUIXyTHb9x8dcSXzIgAp2zTc2WV5fgBQtO6FTrVfFGZ0wmQc9l1
         ZnyWnb93DJG8B1tOBgZ3HrKN9Yf1hnjKr1UcoUBFoVN7k+juk2hktqRifRVppSz5ewWw
         xtH/JzevtgXdMkfwAP0sZIuvpDU6/1peDiEkiDyI3bOkPIjf0TclRdLuSrdb0Wc4rNFg
         IvGUL43cNoY+RKoEQ5EwdXL54xKvBLkiaWiMHfeea1E9GhRk72ylj6z5COhub0JjiuhX
         LuqA==
X-Forwarded-Encrypted: i=1; AJvYcCWKaqKAckizLeRzxvOCsrIyfLkvPBLIqJBbFn057nS7uWUHpvrOlqdzDtI6QOqlhaKuNFyMmyYkUbGMb4DARKlHCja1HYel3b56CL+prhaVa4wHidbLMMZbLh5Vzu9ak0GKEIuD+DQL/7qReJmoBpWTXZWc1d1EtxQF4u0d0x7bEh5h
X-Gm-Message-State: AOJu0YzamCECoQhNclHP6jk3/pW8GJR3TnTbZWicpk+TGHudiPcYviOs
	pwddbImHzhmfCegn7qbhABRmxw8sEL5lf0cAvzzaiAdjbi7wLru/
X-Google-Smtp-Source: AGHT+IFoOJlhlpGlmRm6t3JCw3P6OWv/Au5K+gL709xRpxP59BZGI0pbcGS0VqxcrwG3Ji8SDkGPXQ==
X-Received: by 2002:a17:90a:c4:b0:2c4:aa8e:4efb with SMTP id 98e67ed59e1d1-2c4aa8e5204mr240435a91.40.1718156148586;
        Tue, 11 Jun 2024 18:35:48 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a76abe66sm295715a91.56.2024.06.11.18.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 18:35:48 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH V3] rcutorture: Add CFcommon.arch for the various arch's need
Date: Wed, 12 Jun 2024 01:35:27 +0000
Message-Id: <20240612013527.1325751-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CFcommon.arch for the various arch's need for rcutorture.

According to [1] and [2], this patch
Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options") by moving
x86 specific kernel option CONFIG_HYPERVISOR_GUEST to CFcommon.arch

The patch has been revised and improved under
Paul E. McKenney's guidance [3].

[1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
[2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
[3] https://lore.kernel.org/lkml/cd3709dc-2c08-4ac2-a19b-d8edb66195e3@paulmck-laptop/T/

Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh       | 2 ++
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon        | 1 -
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686   | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64 | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index b33cd8753689..ad79784e552d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -68,6 +68,8 @@ config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
 config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
 config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
+config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
+		      "`cat $config_dir/CFcommon.$(uname -m) 2> /dev/null`"
 cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
index 0e92d85313aa..cf0387ae5358 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
@@ -1,6 +1,5 @@
 CONFIG_RCU_TORTURE_TEST=y
 CONFIG_PRINTK_TIME=y
-CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
 CONFIG_KVM_GUEST=y
 CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
new file mode 100644
index 000000000000..2770560d56a0
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
@@ -0,0 +1 @@
+CONFIG_HYPERVISOR_GUEST=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
new file mode 100644
index 000000000000..2770560d56a0
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
@@ -0,0 +1 @@
+CONFIG_HYPERVISOR_GUEST=y
-- 
2.25.1


