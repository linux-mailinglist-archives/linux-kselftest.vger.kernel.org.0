Return-Path: <linux-kselftest+bounces-10909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC308D4A6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7F81C21EE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07717FAC7;
	Thu, 30 May 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Let0hHlB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DD17FAB1;
	Thu, 30 May 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068012; cv=none; b=Lvmw914NkPo379tYy3t/WsyNxBAbE8XU9r2Yh9aB4KObdYu3beASgscn7NDKx+a88O3O0TYBIGftOZmz/OTtInAitOY9FfYVsxc7GGtu/+HGcP6YkTW0R66JjZF+JaFIBg3ApMrYFTQfl63GSeKVhCo+GWoAXYfVL5e5+78K4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068012; c=relaxed/simple;
	bh=h4glHeoHIj1lCrO/9cfcaGCSQbc7rI3O4B300cL/OlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgNdXZCwSLqJiIDMC7OC4/zqBUoAy/0Yvxlnq2GZiztbAmvFdeqmPZMOB+Ws9pE/t2M790MzqLjBe4mOWYCz58SZp9AVoNYpZG5n2+So8jj3In76xqlva+2GI/ojTm8RMdjzXOsyCRG1qHfTO6WeZiDkr58QSZkgnu2HgeB2Fbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Let0hHlB; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2b9702e05easo567360a91.1;
        Thu, 30 May 2024 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717068010; x=1717672810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKDbsptHUOf10z9ycdwLPkvcPnlZIVKylvaMWlEqffg=;
        b=Let0hHlBBdRiZl1HOYO00Iygkx7PhYJ7iepve126di3HcJccBPoyk8sNdpLNPHFm+/
         YTKrz4hrG7E5vb7Dm6O5jBxb5x8bcecg5ikNxtMvYE7Num2RUENXfEmIm0CxMycU4oa8
         p6az3UVYWNXxKaAvWsfr+fbu/rl+xPPbNke6vuoVMTERz/MVTOQpWp/wQZvOBPKwXzP6
         KT5881Cto7BvwyRFdUxwmEsN3wEL/ZG8OVrNKMt0Prc0CuQU9Y8dqvnLX4h/fbaKBpQR
         TIy506TJYOhSJFHw4kWL4CeweniEVvAcCNBJjAsiEIGbmTFb0i2B/eHAabT4fDqZFUUA
         yCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717068010; x=1717672810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKDbsptHUOf10z9ycdwLPkvcPnlZIVKylvaMWlEqffg=;
        b=wPO5FzaExngm6wpiIkDpSiMzokx0Xft4sWrF7KhkOPf43HR8bhY48SbNyL9UmSiPKm
         2fQuU2KQSAcGH6qVlcp/wEpU6tiGKmw/vSMF/aOlnavW7id9maesqgeF7d5oscCc0/7I
         svMjy0WXH2wkxR0UvjQT5ovAJOPpoP2CEV+jPoqS+qZA8ae/87PbVmoiFMVFOgfKtG8V
         p3ALjxSr9aqmP0SmE02sqGJlyYsMZtjfUSc/vautWulJHJtTY4jYCTQa379bdAoFmN2F
         KqmTEy0ISeBK5+xN/MquQFwDOokVEAPoVOY7RO1m0b64gaO3r7zpaxUxUzCcF1gcSKsu
         p4hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIRwcyyqXYxiLzQcwnW8U1llTJxjwIC2oao+JtP1uYylXWIqHVayLqgJhNAvqT7bkNh/h0qAh5xs8RzB3i2ocfF1avC/Co5SKGp6nU5Xk9QK5CryHZ6168bnrPHzC0hQVx3Z0DYmRP8jkurz4wCo4bh5EJSgxTXrmqSK/OFNFndwaVL2esH6bOR2VS7epK4PebZaDyBU2DkN2zLMgA8xTj0gw1oaXmdaRQ9W1NbM+paGVDFqhp9vMrpNcoF2muZJxET1e/DQHV5z3t+5kp89Dg
X-Gm-Message-State: AOJu0YyiRhcILucFdHIwVi8NcEBbJ3KBdLr0UpoRWOSGYl0TmNSaCLNQ
	2HING/Zvwcb6LU5KEfkTfnC+4R41vX+KmBPw8XadRtpXaBkdqVW6
X-Google-Smtp-Source: AGHT+IG8jDyJ8as1gn+77mY1eHAg+/C0hnh88tNUqGm5hMTpX2IBrtY6RK5OpQr2kS5B3uzx1FXS4g==
X-Received: by 2002:a17:90a:b005:b0:2bd:f3dc:62d0 with SMTP id 98e67ed59e1d1-2c1abc41427mr1745172a91.37.1717068010054;
        Thu, 30 May 2024 04:20:10 -0700 (PDT)
Received: from localhost ([212.107.28.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a777a976sm1534201a91.20.2024.05.30.04.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:20:09 -0700 (PDT)
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
Subject: [PATCH 2/6] loongarch: defconfig: drop RT_GROUP_SCHED=y
Date: Thu, 30 May 2024 19:19:50 +0800
Message-ID: <20240530111947.549474-10-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
References: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=CoelacanthusHex@gmail.com; h=from:subject; bh=h4glHeoHIj1lCrO/9cfcaGCSQbc7rI3O4B300cL/OlA=; b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMaREJ1/n69Xxaeu7NP36NP963pkB213cGx83nk+e+3 76w6tID+4kdpSwMYlwMsmKKLGI7n75eVvrowzJekxkwc1iZQIYwcHEKwESKNRn+WU/3fra1weNu krm/TiCjVtvfa8brLyYvXBxW9+bE9hjTBwx/hWUiri0SdmdLcHzGfvl11UovoVVOsWVy29fF/F/ 2874CBwCfBE2n
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
 arch/loongarch/configs/loongson3_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index b4252c357c8e..4d93adb3f1a2 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -23,7 +23,6 @@ CONFIG_NUMA_BALANCING=y
 CONFIG_MEMCG=y
 CONFIG_BLK_CGROUP=y
 CONFIG_CFS_BANDWIDTH=y
-CONFIG_RT_GROUP_SCHED=y
 CONFIG_CGROUP_PIDS=y
 CONFIG_CGROUP_RDMA=y
 CONFIG_CGROUP_FREEZER=y
-- 
2.45.1


