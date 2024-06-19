Return-Path: <linux-kselftest+bounces-12274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A95590F9A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 01:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE531F235E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 23:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13F15CD72;
	Wed, 19 Jun 2024 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrwsdxZY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7615B98B;
	Wed, 19 Jun 2024 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718838447; cv=none; b=s/DXwNRmwj7AgDvM95yl0LVVEV3K6D6KyYQdAm6ZClTI7PPrYdP5zuLTo85y69kX8lBlic2F84NMjyCh6fzHFOw71/4V1DvQJcmEcLJE6QjeBY4+GxyG9J1pVmKV5Um55wgXVg/1L/66UgWmfy0vceYIplzIlhUlETFWSy7Ynuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718838447; c=relaxed/simple;
	bh=gkaLVKEUL3lbPtEZ2EXss+0oLV810gqFDcmSVpCYBVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f9miaIqj2DEyXYrjZbOS/E7PMDCbLEJzIIWP/vDyLxi3xZGfOf7HyKSKQTGYopvgkISVJBZ7F8zBHaytcZUpHt8QIic1rVzeGtHOCzZjGrGdXIPzoUaDXoFA6iXBKgw5zllwVwG9/5eS/YbkCt/cGTiNsmJNhMg7+dOxHIcZnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrwsdxZY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-705d9f4cd7bso300948b3a.1;
        Wed, 19 Jun 2024 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718838445; x=1719443245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qN8gPqKBPJkUNHcQlK7Q4bJYi1fFC2bhS3Wri9N3oWI=;
        b=MrwsdxZYWfVjuqIdRgzK9ojp/dmJ4tQy4CvYTe1D0xT4Qj3awQBtep5ilxYG6mOSKZ
         d1Nb9B4SC0eSt6zaV4Ydj5MI4HAZprs5RlGdGyZhSmxyH9aVwI/f9OrmKdH7WaQPLFDk
         Lonk/hh5zCl11rrvsaSg5AYajHASgeBRyusjkGTiXe82+u5CB4PgSEDztL0m/8flhLdR
         Mi67ye+XBxUPmi+CfpZjLlkNMby47xNZ5NDgjnx9x4aC7mm1tbj7XAxe+XSwEq3adBV8
         BbJPmIqwUX7Mezz7dCN5U20wprOODQvNUmYi6YItkowi7huPNin3C619y6TCdlxdtQQ1
         Fvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718838445; x=1719443245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qN8gPqKBPJkUNHcQlK7Q4bJYi1fFC2bhS3Wri9N3oWI=;
        b=DQKS/0+zxUCY5Hv2gQdEbcAINhET4Hqful3zDQT+SBPYi9GSm4fWzPqs9n8GL545fU
         EcpGe2uQrWrOsWpag7bvzpYt7B0jj5716QXrQ52EuG0nkW8bSPwwzJPZBtf8vSAc8EGu
         F/8RgrokJO4oSEcX9UF6yuAZUSxuFEh+w3MFf4yX1YN9UgFVK4ZBH/bd8bUZLCHEqpzm
         IFA7qnM5WPAI1MPB2U/HculH/Pmp4PRs8NlglR8xwY8Yu4Sos9/ymrEcCKqEeQVwsVzE
         d2AfsjdBHurJCrjrq2HTdN5Ob1rTvFqgSB13hWFAdrEb6Fr0bvGOqEZRJSMqa0MR/cr/
         MeXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZq82oO6BVUj8/pUEUjMLlOPzLAJJiwhqxlbuKyaF6cLqQJLkGzq56YAeaOeHOGRz8orwh7LITkM1HI6RXplHMzPFvz52QwBCB+l7q9xWguaR+WwnxaSa+248+8Lqt215pxuvRKXEUccfbdlAmPLzrRRUsJRrNYQYhsYOuXfaxYiWa
X-Gm-Message-State: AOJu0Yw62RU1ltycIcyWUD5bSp9Cukk/n7Xevl+N7/Jpyspw2aF0byYD
	5Di0e4l4CZwx0kXEuHBD51a9fEc1GEi4MiRTIzv3Q2Y8Q6RbkG/W
X-Google-Smtp-Source: AGHT+IFlePG119J2Dj5ca4f+myd0lorlQ73LIGPhBojW7JeYQ3rVUmsG0e5p0gs+gwyLEAV1hPUE5A==
X-Received: by 2002:aa7:9a5c:0:b0:705:d988:f05d with SMTP id d2e1a72fcca58-70629cedb71mr3846714b3a.28.1718838445167;
        Wed, 19 Jun 2024 16:07:25 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705e5fbe103sm8101558b3a.72.2024.06.19.16.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 16:07:24 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lance@osuosl.org,
	mark.rutland@arm.com
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH V4] rcutorture: Add CFcommon.arch for the various arch's need
Date: Wed, 19 Jun 2024 23:06:58 +0000
Message-Id: <20240619230658.805185-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CFcommon.arch for the various arch's need for rcutorture.
    
In accordance with [1], [2] and [3], move x86 specific kernel option
CONFIG_HYPERVISOR_GUEST to CFcommon.arch, also move kernel option
CONFIG_KVM_GUEST which only exists on x86 & PowerPC to CFcommon.arch. 
    
[1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
[2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
[3] https://lore.kernel.org/all/ZnBkHosMDhsh4H8g@J2N7QTR9R3/
    
Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
   
Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh        | 2 ++
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon         | 2 --
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686    | 2 ++
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64  | 2 ++
 5 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
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
index 0e92d85313aa..217597e84905 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
@@ -1,7 +1,5 @@
 CONFIG_RCU_TORTURE_TEST=y
 CONFIG_PRINTK_TIME=y
-CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
-CONFIG_KVM_GUEST=y
 CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
 CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
new file mode 100644
index 000000000000..d8b2f555686f
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
@@ -0,0 +1,2 @@
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_KVM_GUEST=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
new file mode 100644
index 000000000000..133da04247ee
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
@@ -0,0 +1 @@
+CONFIG_KVM_GUEST=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
new file mode 100644
index 000000000000..d8b2f555686f
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
@@ -0,0 +1,2 @@
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_KVM_GUEST=y
-- 
2.39.2


