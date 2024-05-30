Return-Path: <linux-kselftest+bounces-10912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF0D8D4A86
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 13:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694991C22822
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 11:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B392183A74;
	Thu, 30 May 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbL8+wIm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945441822DE;
	Thu, 30 May 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068020; cv=none; b=n8gf0WzpZW8y6kNBo21jkENBYNrtenTzv2VFMTgFadU1elRWz7LRUWxY/ekIyjFXcWxqPAfLfqUGmuLudO9a6p6ulrpCpJeqaofI37hLsAJGFisKvOuBxxPXuT16SIk07vIT858O0BKHI7cQELDxYxX/jEiOTraJRwPimHzR2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068020; c=relaxed/simple;
	bh=kOqrnzdbmJCW+4DZmJVchuzFR6LT5fL9WaReqTWmC8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvdplWOxTXy+XBNetXpqIvH7NZpwokeC6SAIIzjB7nOS9DEV5wO7i7TKt9QRd+v6LcbxWI5reurWQ/4QU8gLqEXplmVjOgiU151gIgU6ChBaB2SUhT5ryOLqtYlzobzmsD99acSEg77ClAAtmdVqtTCYimTCFQEPD9uhSBMADr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbL8+wIm; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1f082d92864so6321225ad.1;
        Thu, 30 May 2024 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717068018; x=1717672818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGiqpKa0bHIEpa15rly2elByLBlsz+mavCGVuSQB03U=;
        b=hbL8+wIms0NsKfkllbK5ezh3dF3BjZi01WPEZXQCnV63F1bbb0GhoX2yH6OobjcNSy
         Ow7UpDyff62nwu2c86FA/GnSH4UifPZGr3CnQnhYunv5BfcV4FOrjc/4D66OxDUzQB9C
         HLoev9+M65qOz5rVGiaa9OXNsdwm/iSvHqxjH0nX5loRPk2QlGCLDXf925uWeEILf3UR
         sIKlIeZyFTyCszYu4r8halTmplXIzbud4YVElw4VjHcCqLRKpys27DW/k/Ue6suZFUJp
         XLhpegxv+8nNZxS9rrcQDz2wqNXyzZIxfn880FsM1kEjqq1JesoPwg8yrRx2S96Qo3HS
         uVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717068018; x=1717672818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGiqpKa0bHIEpa15rly2elByLBlsz+mavCGVuSQB03U=;
        b=fOocuwZesnvDue7T+SBXcp9mMpF5FaZ2l15jtQXgiSwulYipaaYnVrXM/KanvyDXFi
         60XjVa1dteKSjhuYmwzgrrBZUd/jXHFgVD/wAIJHbnY4e7BUHqMQqjAVkhhTs46puOve
         b3aRoGgWbzlLINzXhVLACkRRpnoZduqMYmbTN5jjhpPTLiMUGMgTek5TJGwzyvN01cdD
         CO1E+Pkhe6zRHwgKDEuf6xX5eml0mVjqI4/Rl2GY7KDtxeUaQLnIWPgiEoMRIZpLnw1E
         VLrHl2ivg+OnrWAJdChMXrF0QHggana6OiX8uYWk1JkI/ZOkaxCrFY2A1McepqfOENI6
         plLA==
X-Forwarded-Encrypted: i=1; AJvYcCX5/sqWPSidEZ91HNjwe+zdbUq8jT3leB3qwNfjDOx89S1FDncOaU5fPeIGboOzAR5lm6wNzTZcgHMHXbq2L6Z6w4sRylVxJ4tleiwI2Ts1N33ReWvP1rdoTiuXS2UBNktMedDgdcmPAhTweoTJXMPPaTTC2SLMSkpp9z61HpRstsa1k+3ksAxP6JqelXjcJ8mK10E1NLuZkVm43j1gYQ1DICmJfVK9qZQ6IR+7dEkkqqC3kfRkORwN4pYL+uPYAJYvspxy+4IldT9oMinqftd6
X-Gm-Message-State: AOJu0Ywn8g1of0TAWw0X6CUgyJr7cI6/PQ9TVPIKheAbo5cP8TSOUGp6
	mc7gaHUZZ1C1QXR8B2R1bW45Rplc6WH4CAZMbpmQal/x55i2rZWP
X-Google-Smtp-Source: AGHT+IH8SBUM4HFPal7PP4GlEtGKEuppsnSX92o9KNQGYi+syJrrgm3CpsZ+Cwm0ovcoR5ODsoOSkQ==
X-Received: by 2002:a17:902:f1cb:b0:1f4:f1c1:646b with SMTP id d9443c01a7336-1f619610e86mr13465395ad.33.1717068017750;
        Thu, 30 May 2024 04:20:17 -0700 (PDT)
Received: from localhost ([212.107.28.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f62218d9e6sm9517475ad.117.2024.05.30.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:20:17 -0700 (PDT)
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
Subject: [PATCH 5/6] sh: defconfig: drop RT_GROUP_SCHED=y from sdk7786/urquell
Date: Thu, 30 May 2024 19:19:53 +0800
Message-ID: <20240530111947.549474-13-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
References: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=CoelacanthusHex@gmail.com; h=from:subject; bh=kOqrnzdbmJCW+4DZmJVchuzFR6LT5fL9WaReqTWmC8g=; b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMaREJNwub0yXLjr83sFl6+r9m9kR/++RbfTfmNMpv7 my3dmlavLujlIVBjItBVkyRRWzn09fLSh99WMZrMgNmDisTyBAGLk4BmAiHHSPDiWeRLf+fbOwM 1WVrORm/XDDz8bQ1DJ+etga9dN23//qBHoY/HAcKm/+7fhPVYMsRuzTfViI8IXPz8oWr86eHXVw Sp9rHBgChF03a
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp; fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863
Content-Transfer-Encoding: 8bit

For cgroup v1, if turned on, and there's any cgroup in the "cpu" hierarchy it
needs an RT budget assigned, otherwise the processes in it will not be able to
get RT at all. The problem with RT group scheduling is that it requires the
budget assigned but there's no way we could assign a default budget, since the
values to assign are both upper and lower time limits, are absolute, and need to
be sum up to < 1 for each individal cgroup. That means we cannot really come up
with values that would work by default in the general case.[1]

For cgroup v2, it's almost unusable as well. If it turned on, the cpu controller
can only be enabled when all RT processes are in the root cgroup. But it will
lose the benefits of cgroup v2 if all RT process were placed in the same cgroup.

Red Hat, Gentoo, Arch Linux and Debian all disable it. systemd also doesn't
support it.[2]

[1]: https://bugzilla.redhat.com/show_bug.cgi?id=1229700
[2]: https://github.com/systemd/systemd/issues/13781#issuecomment-549164383

Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
 arch/sh/configs/sdk7786_defconfig | 1 -
 arch/sh/configs/urquell_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 7b427c17fbfe..3599b1683593 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -17,7 +17,6 @@ CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_CGROUP_SCHED=y
-CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_CGROUP=y
 CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 00ef62133b04..9cf4a719001e 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -15,7 +15,6 @@ CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_CGROUP_SCHED=y
-CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
-- 
2.45.1


