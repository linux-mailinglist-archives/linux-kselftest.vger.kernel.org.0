Return-Path: <linux-kselftest+bounces-10913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7498D4A8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 13:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6441F1F22C38
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 11:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE7183A9A;
	Thu, 30 May 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+UGOqrK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF3178CEA;
	Thu, 30 May 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068022; cv=none; b=D9aLlfhSWQ8KZaaIyJ6ugTddD1lWpwRqHWFPq1sYAK4TyKTccNPIBldg1JmikVMD9DNrx6iFcRnufqPLmGxqqcQLnymGkGbIf/d0CECw6z0kkrs477wDZNTK0PYrl15V/p/M7szkwo+72l/OhNTBoZy5iMAE/xtkxw5iREir5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068022; c=relaxed/simple;
	bh=z/Xh6Oh4/edMyA0oTGEdVRRBweOMR/LS4ucNKKx8jxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxiEOmCvaluevVwRPzuJZojWqBfgIHaD47AxeyxdZKP5PeHSmgafTsMCLfFjdYp7uiFa/1+CHI9wTBKZXnzdwxbQz35Qlru+WDCBD70FqmXBjwYIAI/xXZ50+FeIQhg/AtArKAenVqgOL/uU9S04vZ6t9/BBDAlcQP/6h7Nf+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+UGOqrK; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1f082d92864so6321675ad.1;
        Thu, 30 May 2024 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717068020; x=1717672820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10Khnm7VAFiOR+x13kGKX5QXUNu8EX2jhqaMmuaAe9Q=;
        b=R+UGOqrKtg1VYvd9/MONETnPsfFk6x/Xw7fqLOjrIKGt77/n/NfbRi+2DjI/2dK843
         n70vcYEUZYb9NOmpInG6cPnOA4i6P2Sgm6gQVDhRhutZH8sy/LllX6sucmqZf4zbouMQ
         mVSQgl56pAQnuCetDJyajRr8Mui0gnwsZiBMoPYroF1/oE05vgdhcg65Ul6N+jzMYqyr
         1V0Cp7CMt2SYnyN5n/0dD7XXH8lQcl9t4SnUik5cjELuE6eYTeKSqHS7JLT+itgFOgiO
         XkOgJksh1/eWb6yl3w3PqtT0BiC7IBKM1GLAiQVszDyG1rG9XmTeZazjD9JCkX4qyekO
         vv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717068020; x=1717672820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10Khnm7VAFiOR+x13kGKX5QXUNu8EX2jhqaMmuaAe9Q=;
        b=j6uJvfi1ZrGqNUYqdMxDxNsUGF9rKDAugo2iBTo6Yb/I0gDVewuJMELOuXzTaJ+TK8
         q9G1vWuBy2t8zzba5+l/Rz5+uEjXEGeJl/IuewZ6rZfO80qLwLeLTTQvfKvKXWCadSCS
         5tmlwZ1w/vyMALClpINIeKILD25LLJsk3ZyJr+wV2TCZuIUPeZIjZuNLlUeQm9MewY36
         O+9TaW3U5ObImopCmvnXxTZ90V6qNCkMWn4t9FzYZbl+MsCXO+xwJ9DvTGBCnMyWyBei
         2rTUSUB5bjFGwgUFYQ4FZloCoJMsExDzQ3UY6CgugYvMIwan1QTFL2YPxVZxFQygTUsM
         3W7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4WtzNaVU0sC9tip6V1vfZlPE0198JHrHHov6/oprn6H8tFTCjZ6rJo8kVbiSHKUeVTyTSUo0k0Rx6xLdm1lyeqoRwTcG5zSmo0p2YpvRf9ZpEfOsV14oFHPErt2p3OtEwyy4ZN4APzt11ufMYqgLQxh/VoK8lz76bma4pwviiVYDT0lgimRi2Vh0WrSOXvq8xOmrhufK9lBw46rD8XJFcqNH+DwGE+75WYMKNZl7HCWXuNK7I14pho6ccnZj91I3lKO8kYnnP70gKA0du7/v8
X-Gm-Message-State: AOJu0YxzGPns+bKO6vLKDpnR1N/yJ3IsxdrFWWetui5DfCEmLOMRjJXU
	Z4i/UxFMQpKay7HTbcN/hPQsf7jjHME+mdNuUJs2Znh9KNze02jy
X-Google-Smtp-Source: AGHT+IFxkZxBxtRo803YeGMuC8sIHF/n8GOkz3SCFQuOwIu4wbjvdjgInTxjR211s2831JVg1Df+Ag==
X-Received: by 2002:a17:902:f682:b0:1f6:846:c15d with SMTP id d9443c01a7336-1f61983ab3dmr21091605ad.47.1717068020137;
        Thu, 30 May 2024 04:20:20 -0700 (PDT)
Received: from localhost ([212.107.28.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f48e95c85asm80546745ad.34.2024.05.30.04.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:20:19 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Anup Patel <anup@brainfault.org>,
	Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Sven Joachim <svenjoac@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Tony Lindgren <tony@atomide.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mykola Lysenko <mykolal@fb.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>,
	Icenowy Zheng <uwu@icenowy.me>,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: [PATCH 6/6] arm: defconfig: drop RT_GROUP_SCHED=y from bcm2855/tegra/omap2plus
Date: Thu, 30 May 2024 19:19:54 +0800
Message-ID: <20240530111947.549474-14-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
References: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729; i=CoelacanthusHex@gmail.com; h=from:subject; bh=z/Xh6Oh4/edMyA0oTGEdVRRBweOMR/LS4ucNKKx8jxk=; b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMaREJt//Jpz1/9vq+ftrjnHPOdUJ7Zl16y3oqfNMJ2 c4TmxeuZVnZUcrCIMbFICumyCK28+nrZaWPPizjNZkBM4eVCWQIAxenAExEIJzhf8HRRdu8P/5W lRSfdEtSzuIjW+AJrhe/BHfb27mxp8vLBjP8D+rcabfgddQ8Botz1wy6Gi5ev2tY0Ppvy/7rzt8 y5t8MZQUAhClPwQ==
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp; fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863
Content-Transfer-Encoding: 8bit

Commit 673ce00c5d6c ("ARM: omap2plus_defconfig: Add support for distros
with systemd") said it's because of recommendation from systemd. But
systemd changed their recommendation later.[1]

For cgroup v1, if turned on, and there's any cgroup in the "cpu" hierarchy it
needs an RT budget assigned, otherwise the processes in it will not be able to
get RT at all. The problem with RT group scheduling is that it requires the
budget assigned but there's no way we could assign a default budget, since the
values to assign are both upper and lower time limits, are absolute, and need to
be sum up to < 1 for each individal cgroup. That means we cannot really come up
with values that would work by default in the general case.[2]

For cgroup v2, it's almost unusable as well. If it turned on, the cpu controller
can only be enabled when all RT processes are in the root cgroup. But it will
lose the benefits of cgroup v2 if all RT process were placed in the same cgroup.

Red Hat, Gentoo, Arch Linux and Debian all disable it. systemd also doesn't
support it.

[1]: https://github.com/systemd/systemd/commit/f4e74be1856b3ac058acbf1be321c31d5299f69f
[2]: https://bugzilla.redhat.com/show_bug.cgi?id=1229700

Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
 arch/arm/configs/bcm2835_defconfig   | 1 -
 arch/arm/configs/omap2plus_defconfig | 1 -
 arch/arm/configs/tegra_defconfig     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index b5f0bd8dd536..27dc3bf6b124 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -7,7 +7,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_CFS_BANDWIDTH=y
-CONFIG_RT_GROUP_SCHED=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_DEVICE=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3a166c2f02bd..9cb265c8d414 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -13,7 +13,6 @@ CONFIG_MEMCG=y
 CONFIG_BLK_CGROUP=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CFS_BANDWIDTH=y
-CONFIG_RT_GROUP_SCHED=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_DEVICE=y
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index d2a094ad360c..3a9bda2bf422 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -6,7 +6,6 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_SCHED=y
-CONFIG_RT_GROUP_SCHED=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_DEBUG=y
-- 
2.45.1


