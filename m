Return-Path: <linux-kselftest+bounces-11072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2E98D6D0A
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 01:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425B4288740
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 23:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E284FD8;
	Fri, 31 May 2024 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAt2F2Lz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B27168DA;
	Fri, 31 May 2024 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717199650; cv=none; b=sdutHGOUBHpnGD/uu2FyKgfMFz97Wfg2SVDnYiZE91hWGH6ZuoCOyyk13AWvU6XdRxMVIDprjA+8bWolGhqu0YNY/ZrdxmAjHvHCu4UGvGuTBXcki2xErC3RY6ZFjKka9bPiyogpUagODimb83W5T8P1efY9UJWOiGUxghz65no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717199650; c=relaxed/simple;
	bh=VlJJGuQ/INt5Twxrps3pJWq5cUDg6Be/kjaj9j/3Akc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FM7DP+aoGo1YMLGSQ3qjDwm/NvqgsbnLf04Ncw5KdF7gg4E4ksEDCBj7PLKqZk+Vg/Wc8tcE538zeFYc/Ptn0TP/WxzxxNBE0pv2L8zNyysnBwib6BHHSVbfPTZ6lmGDrawlrAiMbJNLVGRZZU3EgyDZbVpH6ZBZ3CvA7u7xbIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAt2F2Lz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso723776a12.2;
        Fri, 31 May 2024 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717199648; x=1717804448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFMiJ7E5LpCWaF4kYeMHqCEjQOyhSVH+OwE9eYErSSc=;
        b=lAt2F2LzZeGo+hfJLesFZgSdvUlOFwOdj6gmrKZooXPnhBKyd+4WDHMl91rvtVoHfj
         q9PbYsaA7hPBW7dCCXM8eiKxOlg1+ImBXS324pDdf74GiU6Lcdu6XZqqIjgk1hcm3QfG
         qw70P38KDPFYP68Rn1wpWSD1t5Tg4JYWc8pLl3Tn+jxpfbU7jqKHXl93yVre65tXfKc5
         1wnV23y7AsG9ZyEwT6JRLJlQPzTx+JFknk8hFw6i619edCk37hXfUVTPAyRvRIQmI/+p
         9o4PyraMeX/3Ax208sYC3zTvuJuAhzdEyMRsA/79q5Z1GhKBcuTh9qNdEiXPZZg5bxjy
         pIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717199648; x=1717804448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFMiJ7E5LpCWaF4kYeMHqCEjQOyhSVH+OwE9eYErSSc=;
        b=ttAe2sF1R9/MhPzSVfAO3d8X1JWDqNyvIXpF1coZtLyYgPet+acvvJMnUARYIKRHmh
         xLCwib5+GP7c+PU3EA6qrIEBEG0c0NYIWgyI5hZR5WdD3emd7WIiyl0HaP/A63Gw9XzG
         kvkEhyk+dyg0wazd6KYVGLyeJQisjVEm5dh6/p3+cMRaYY4Ex8ki+lJSoQlkg8YmSpjo
         HN83bj/TNeU92xzo3hdxmF8ds8qenmbyH2SMrhiPwuUjs15AITmh90mFC/SlDCfcJ8CA
         qzAfj/jQQ2AqSit3SWZ31PhYOkfzR207y645/VvuofpElOTE8C+RV0ODdNrKybT3bb1t
         qDWg==
X-Forwarded-Encrypted: i=1; AJvYcCVg0yKbRcsaFCVhRz9sA+8EMQC/5DCvttF+kmWp6YiuStrTLEQ0ab+y05AI4woUlmhfdkNknOb1wKBYgwDnmWPX7mVWNZT18I5z7OIFaCrmbyelDC7Q7D0K1fckQMM/CBAk8NO2kKa1OJCn0B5P9u/jExlq3eU8SDy4P/i0G4GOFc1A
X-Gm-Message-State: AOJu0YyI3JzEnoC2/owxWlwqyJ5R50Zi3VpKm3kHMxfTFbaaeKaAQ5EJ
	frLsnbvG8/KMVQMJ5blqkCfx8prcL1x5EifziD8xkxffkdJwHszA
X-Google-Smtp-Source: AGHT+IHNmspc6tPXm8RMsasak9EMHsw+2m9yjctxLXP1JVTV0cBXIFMy2CZ6XOsBGF0nhgM5ShRUJQ==
X-Received: by 2002:a17:903:2311:b0:1f4:6057:99fd with SMTP id d9443c01a7336-1f6370a0c02mr36478215ad.42.1717199648050;
        Fri, 31 May 2024 16:54:08 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632416d7asm22553065ad.286.2024.05.31.16.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:54:07 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH V2] rcutorture: Add CFcommon.arch for the various arch's need
Date: Fri, 31 May 2024 23:53:47 +0000
Message-Id: <20240531235347.1118612-1-zhouzhouyi@gmail.com>
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
x86 specific kernel option CONFIG_HYPERVISOR_GUEST to CFcommon.x86

[1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
[2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/

Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Hi Paul,

I tried very hard to find in Linux kernel on how to dig out
the x86 specific kernel option CONFIG_HYPERVISOR_GUEST before configcheck.sh
generates ConfigFragment.diags.

I can only find this functionality in scripts/kconfig/conf which travels
the Kconfig hierarchy.

But the output of scripts/kconfig/conf, which is .config
is also one of the input of configcheck.sh:
```
kvm-recheck.sh:	configcheck.sh $i/.config $i/ConfigFragment > $i/ConfigFragment.diags 2>&1
```

I feel some logic paradox in it ;-)

So, I pick the simplest way.

One more thing, recent change in include/linux/bitmap.h cause the make
of allmodconfig fail because of warning on both x86 platforms, I am
going to do research on it.

Thank your for your guidance
Zhouyi
--
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 9 +++++++++
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon  | 1 -
 .../selftests/rcutorture/configs/rcu/CFcommon.x86        | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index b33cd8753689..5332224238ba 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -62,6 +62,15 @@ config_override_param () {
 }
 
 echo > $T/KcList
+if uname -m | grep -q 86
+# TODO: add other architecture-specific common configuration when needed
+then
+	if test -f $config_dir/CFcommon.x86
+	then
+		config_override_param "$config_dir/CFcommon.x86" KcList\
+			"`cat $config_dir/CFcommon.x86 2> /dev/null`"
+	fi
+fi
 config_override_param "$config_dir/CFcommon" KcList "`cat $config_dir/CFcommon 2> /dev/null`"
 config_override_param "$config_template" KcList "`cat $config_template 2> /dev/null`"
 config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
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
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86
new file mode 100644
index 000000000000..2770560d56a0
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86
@@ -0,0 +1 @@
+CONFIG_HYPERVISOR_GUEST=y
-- 
2.25.1


