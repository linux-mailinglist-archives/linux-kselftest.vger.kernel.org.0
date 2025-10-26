Return-Path: <linux-kselftest+bounces-44062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C880DC0A53C
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8323318A12F2
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B9289367;
	Sun, 26 Oct 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN2KKfDs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC528314A
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470002; cv=none; b=s1qE+5unE6QfZIoCmq5tP8X6QAAkErNopireYs5/Nsdyev71b2YUssjte+E2SslNS/FSK87j4wS5i3SXR331TkdlhrOEfriaqIY9Z+gAe0HtzBnJrxvj5DpYNQ/6+HaafIicALMkkKfCzOrskQu1tAKN5SCxzfaan77QKofOZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470002; c=relaxed/simple;
	bh=5b5PYMxopEb8YY4FdGelcJUO0Yvn+/7BT0Giy57xNWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYi0uQ8Z8u+lXSXSHGrtfJiT+tM7Dz6qhMmL+WL3HNjcZLvmFmHoLuWAIsHYQuCsJ2jR/jnI8+Pjae3yMrJCvso6G/sHVX0Vl5j+eRmuxCW9+TjKkzlWQVyHO+PwpW2ddcVw3mvFZFVIJ7peO4gIQAOux5kiMcqUlF9DNLQd+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN2KKfDs; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33255011eafso3410320a91.1
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761469999; x=1762074799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMX23+YLvbC4KKYE3owkIF/POC5qa9l7q+YDn+rGhBs=;
        b=SN2KKfDsQkeTqdseEQyG/hCI7cTwgkEZdcfVDhayZ7m0K26eYWv62CVqOEhqj8S6GH
         y3symXdmxE0YzyqQW1Ti1PAHRB+GHkK0kZa3HbLi3CVtHlPkMHfPg6Kqz43mvLXaIzHF
         MMkTRx2ehLRvXhuO4Tc784kYtE1pX/xhrGrWmoMEXTeDEX7Rledc/GbVFqAqOjoo4aui
         bqdcjmMetRx+BbiPX+gAd2dsd4/EVNlV/YsAf4OvdBXKEmL7zugyp6Q75Q/QVU12cqfJ
         gEAta1gPws2MZSIEgn4E9Kr3r0GrpQdk5sDzDxZiHaxSMli9pVeUlzAnpqDV+K/nV47D
         eo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761469999; x=1762074799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMX23+YLvbC4KKYE3owkIF/POC5qa9l7q+YDn+rGhBs=;
        b=mQqaa2pv9AG6qy2r/8Xp8NsaI69WMFvPo4uHQYSb2FAk+fgMNofp6aU/JU93ZvJkU/
         kVXyiq4pubH8hgCo1sgI2h8q4UpSNNWeh2ZUW9K27dx5KaTPmJ9FFL+81ViagOhzD7dA
         6Li8pnNmSjb+IzSIULhDF8H5HvI4d88Wer160hUEUUD0stp+G4bd2UNNbiZq5yN6mQmh
         q0GIQlOqIj3PqSTPDqCv+SZObKDMM+CAwStYztzSHDqWCZw83ylh1CvgAeT8vKwUrPM1
         umD63lMvBo/21LjRKeg/ia1IXWmIM3v42NWDboT+hr1w+p9701bcQ1w3/JBd6c7NreoO
         VfFw==
X-Forwarded-Encrypted: i=1; AJvYcCUqaDkromwnvdrveoN4P2ZFpZOq7IlNWvV40ktPuQwfySGguP7XluukTCQuAOZ8vUKF7R8fC2d9G0pSllCoERE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwriIC37iAgHmhMWT+CEBgBJ/ZgmxlHijJcddlQu7C2W73yCljf
	WdqjeJeyJhgBKwl1BQjBmawYCe07kI3n5psXdlvk4e+J4CM76WqbGTQj
X-Gm-Gg: ASbGncuLS/PSyK8c+zglLSBqpZpMcjb/NJ1vjlPlD0+39PpD1d2s0OATpaqKcTCUipZ
	ShTPCGARZbQ42ukaVHCCeN1IHuLdPlzR469DZJThH9Q3JSw1NkmstD4IqkNUkga4ge7+pi+PEdQ
	ACmXSQ+H4NeeMTMhX2fvShYzF158fzeGRoM7TjQh28dSc7NYcxYcU5bN2o3gnUn0Vx1pPEtU53H
	Q9G/JxReaCXtHblXSvwBKggZz7sPiZquapUqCB+RSOO4//hOjudfnGBL5COS7uihYB1bHZ56xe+
	VCmupNOh362EPIJIetY+eHndNrrrZQDyOWwkZ3QGeLvyEvgNJQ3TEjYk5lIxzyNiMPDURYv2ozz
	M5txmdgzY8ckp5S8F+F8HmWaVS1w5Fho23osjs/XYagjUJIPSBnTEKR83yO7PWd3qPPIj1bckrg
	T9fyKQ6OqHZFPSibVX3IawUDMiz7EdqItrAPEgn/GbLXofz/Y9Ost1wXU=
X-Google-Smtp-Source: AGHT+IFQFXNUYIY4vSpSr/xv31CBewG848HOy0cOfx8lxhYhMoQ5KdF68P3/KWEwPTs9NKzCL3WWXg==
X-Received: by 2002:a17:90b:5386:b0:33b:b308:7655 with SMTP id 98e67ed59e1d1-33bcf861fc3mr44925100a91.8.1761469999250;
        Sun, 26 Oct 2025 02:13:19 -0700 (PDT)
Received: from prakrititz-UB.. ([2a09:bac1:36e0:1c0::10c:2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a42aa5d9a6sm789558b3a.62.2025.10.26.02.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 02:13:18 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jiri Olsa <olsajiri@gmail.com>,
	sam@gentoo.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH v2] selftests/seccomp: fix pointer type mismatch in UPROBE test
Date: Sun, 26 Oct 2025 14:42:33 +0530
Message-ID: <20251026091232.166638-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <aP0-k3vlEEWNUtF8@krava>
References: <aP0-k3vlEEWNUtF8@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation error in UPROBE_setup caused by pointer type mismatch
in the ternary expression when compiled with -fcf-protection. The
probed_uprobe function pointer has the __attribute__((nocf_check))
attribute, which causes the conditional operator to fail when combined
with the regular probed_uretprobe function pointer:

  seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
  expression [-Wincompatible-pointer-types]

Cast both function pointers to 'const void *' to match the expected
parameter type of get_uprobe_offset(), resolving the type mismatch
while preserving the function selection logic.

This error appears with compilers that enable Control Flow Integrity
(CFI) protection via -fcf-protection, such as Clang 19.1.2 (default
on Fedora).

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..e13ffe18ef95 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe ?
+		(const void *)probed_uretprobe : (const void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.48.1


