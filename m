Return-Path: <linux-kselftest+bounces-10908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593B68D4A65
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 13:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB15281F34
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 11:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF68817E476;
	Thu, 30 May 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5HunbHT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209117E461;
	Thu, 30 May 2024 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068009; cv=none; b=qYRQdcTL+SWNZ0v3S3TlSCuZ+mAvdDI+bu87E1xx28sXNZKEmxL220ZwcsLaOipCJch8pjHeXg4yCGgAGXQzoV/bECQwPYFevR3TG6N+ecBclig9A/jh3G48k7wPO1wu0DaD7la3b9ZWNlpI/YmNLgYnxwQcB/jVMy5Ct0HiJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068009; c=relaxed/simple;
	bh=FEk4ZichD7CqTRAppezRH+4H9dhTF4GYT9EUDpibpAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM/TZDCMNLKOP85Crrre/PKF9qv/pr63vaJDb4fMwmGjOWzrCD6RUFqIN5oqiZ9JEGMg5TQmlRc1zjBr1VwjjoyGA90W+IITCe74dAd65odJ0QkE9FS34Gkm7bhNOPwvFT2nBJNLQMF0SvbzLbd2qR4KPu3OeNaKfasOsdwXDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5HunbHT; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-7e9c80adc25so31713439f.3;
        Thu, 30 May 2024 04:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717068007; x=1717672807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMLg5P8GKaZTkgjzD8R/QqO0sSQDVLJa6m0BArXde/g=;
        b=L5HunbHTjQf/FMD67jee6pfwWDic5Cl/YM3tE0jl16JNwLuNOcZXd4ehBHh1Bz+kn9
         utpsMvW+7US0AnkpB3ejfi2xVy5yE/4imbS8zko/Oy2fkFayOty9YVKY6Es4RMeBMOdD
         CENQZz09yawO/EH48Ny3ZUfrU27sYEZBASu2OY5fO51fPUSLGyiWRJXDCs49auRsdNDK
         r2AXvtL3k9Ir79xK/ranHuYxnOnYjM0+07U6aLecHyZg6ehqC7EmU0uKYhgThyzjvL65
         eOSee4cswhoqfbbGvplQEJxjL4YhuCNm3yFGgOEeCmI7UkPHRKqeiuRlHVWHCbVTC1e8
         EVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717068007; x=1717672807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMLg5P8GKaZTkgjzD8R/QqO0sSQDVLJa6m0BArXde/g=;
        b=EsV483e7/MQH3jdnR0VB89TVTs6QOzafU9wNVGVC68RGExI6YxzjpKqr2U06rqK6Mb
         IRpivlIIODiAMXx61vQZ8+xwcSPnIY6juyxA7xQWVlWZ6c5RAiAYiuhIDLad721TtU3b
         07H00Lt6pAYHAPzFkVlZQYq1xcPhvbiwm9MZvaTHU7JsLqluqxVrxWIX2hmahZmL9TYK
         Ep1qXdZW/8LoOh1ztJrRcs7q2IfOEv7fiQT5bUdTB0z+ND++O1MsZwmJ2tffUZhCM442
         2gq0E7U4k1/YFQ/8NDiTAbV1HCCYqnSXhchpFuXQXFjVzaKtKItKKZpdUXsq++pRdsQ6
         0+kA==
X-Forwarded-Encrypted: i=1; AJvYcCWKWMHKZ0Gy1P2bZnqWshp6/Igq6JyLbECARu9LWpxItuCHRwydxhFUuakswmTQhcaGtSpjkbmuXzzq3Z8M38EPpfyf17IbQP2x8BCX7GECaL/yq/q76sZdAeIoGxOCIsyu4xYIYhdUwSEoPwpWEO+Q3dQ9dNh6kCEM9v9JQS9eI7exjiJVenAPaA41NJFOHuVPdpjZT4pZ07ORUOoB1BqOvO3HpDH0WDt9SyX1hBTeXX4H/scwA7qZNSOBGjE7sod8flVGvz7NqO3IPhuyIjZx
X-Gm-Message-State: AOJu0Yz11+KXtFkNtsvFIJOzykNhVT11Zyl3n/Q9s/e4Ignq7ERqjMPN
	jfS262iSWH7NroC6AKQHMig1wM2MYKQpvmzWPV+b3RlzcgW1tLXp
X-Google-Smtp-Source: AGHT+IFxgfGuk4WvYoxrChp+N4lQDR0Si7/7Vlzjuk7wpmJrGZ30ttsy31urG1IDYNTmVV6Zs/i1hQ==
X-Received: by 2002:a05:6e02:b27:b0:374:6472:d923 with SMTP id e9e14a558f8ab-3747deba9demr23632145ab.0.1717068007160;
        Thu, 30 May 2024 04:20:07 -0700 (PDT)
Received: from localhost ([212.107.28.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822198a7e3sm10550697a12.34.2024.05.30.04.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:20:06 -0700 (PDT)
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
Subject: [PATCH 1/6] riscv: defconfig: drop RT_GROUP_SCHED=y
Date: Thu, 30 May 2024 19:19:49 +0800
Message-ID: <20240530111947.549474-9-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
References: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=CoelacanthusHex@gmail.com; h=from:subject; bh=FEk4ZichD7CqTRAppezRH+4H9dhTF4GYT9EUDpibpAE=; b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMaREJ16rP/zv78xijc+SbFuluq7KoDVxfdGb3ntmwV 4b5b/rJ87kdpSwMYlwMsmKKLGI7n75eVvrowzJekxkwc1iZQIYwcHEKwERiuRj+FyWbH5kg7nGC bXudX8b5SVrfDn7ffNohZmU9l4bwcat4U4b/tfNS9VctvP7+NI+h5NrpGpcrHCr9as+x9XPYVM9 LOc3JBwDwgkw9
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp; fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863
Content-Transfer-Encoding: 8bit

Commit ba6cfef057e1 ("riscv: enable Docker requirements in defconfig")
introduced it because of Docker, but Docker has removed this requirement
since [1] (2023-04-19).

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
support it.[3]

[1]: https://github.com/moby/moby/commit/005150ed69c540fb0b5323e0f2208608c1204536
[2]: https://bugzilla.redhat.com/show_bug.cgi?id=1229700
[3]: https://github.com/systemd/systemd/issues/13781#issuecomment-549164383

Fixes: ba6cfef057e1 ("riscv: enable Docker requirements in defconfig")
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
 arch/riscv/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 12dc8c73a8ac..de85c3ab261e 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -9,7 +9,6 @@ CONFIG_CGROUPS=y
 CONFIG_MEMCG=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CFS_BANDWIDTH=y
-CONFIG_RT_GROUP_SCHED=y
 CONFIG_CGROUP_PIDS=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_HUGETLB=y
-- 
2.45.1


