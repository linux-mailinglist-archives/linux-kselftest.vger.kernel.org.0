Return-Path: <linux-kselftest+bounces-7770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA88A2702
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0849C1F23CC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F87C4D11D;
	Fri, 12 Apr 2024 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rdi7Ix4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AC4CB2B
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904555; cv=none; b=VM6zUZkkHItqSJ5jE6GeO29P5vjGrrmoa775XweDSk/vQqBqyaD/VE8/zHmculqbcotM+BeaaaGrb1coTMtTnPbJZTqHZD1uVeF5XrWzt6HNQW56sBu27d7ecDHMEIunTAAaaIkogRCDdTXXtj4unZ1AmVHn5LhCMteak7NhlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904555; c=relaxed/simple;
	bh=a9rwcEjnh21QIPCAXbkgAFKpx5pi2e8+mY4wvsy1GA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMckPzU7UkPZgnnPT93H/sGEigQf6+RzKD3re4HXKcYXU7Eyc/w3rQjEy3NoHCHpzbRpoidaVIWMI0qx6jorCuEvm1OAFpZEXCbJemZMjB0NP3A8KRTHApFv1f+4LadJz5CMAErwDJ9Kp5msqYqhqWqel8fJtJ0I1c7g4vj3oaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Rdi7Ix4c; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2c725e234so12291275ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 23:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712904554; x=1713509354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OADn3kHEewLkE3kxFhkvk62eojDLq3ulyri6MOmjFqk=;
        b=Rdi7Ix4c0p8kVPHHQ7VI96HupW78pU5L74+2ZrqwsX/On0/34FzVKjLYQUqFQw1NQP
         8KS4IpBzBJML90BDRCFZpAEFFbGFl8Dg554PtQE8GxckJqlhlglWsWiEemfE6kWjW02V
         bOKJD03Oxl1nkQqJYV24cH1UgeGya55AdZRp23MgiwNQLhdnXUPo6JZHAcjHHiaKAy4c
         xip4un2gC/fgpsf0SwFAxc/RK1G5vS4fYwoTTckcuCjJBbeHjSZvSPMajZPfm+PoQB8x
         1WZcF4S/H0nBUoS1/W+rSG89atc5/NoXvISHElhbiErKiCm6IhXS+XMYXfBIyd0xJ8ax
         hH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712904554; x=1713509354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OADn3kHEewLkE3kxFhkvk62eojDLq3ulyri6MOmjFqk=;
        b=R72FblQRW2wGnfgHzr4v7wIlI7flh+G3lMasxQ47BzNlDrQPAk6nST+xpvoM+eb5Z4
         eiL6L5GRcEGOY9glb2ArReRa1EzgZDAdiGe2pxsKxz8WSrpdXKrSi4aQPEco53/mgzhu
         MvalDtyUzHyor/h/kwPBYfhEPHLEpnZmoLi3RCo+sGZkNH2PAtw0fSbq5m53+Z7Tq5d+
         t2yAgEBlK8r8NnUJO2xC8wTUZoqrInKWw6gpA8gudAPRYC4cWl/kZsjL0EXh3pJTiTxO
         BRrTjYyvWVmHL7TqID4lSj3MlEuQwD9G4KqaDoW3xHNtxETkwp7QmSFWkPEilUlxJzGM
         qXKg==
X-Forwarded-Encrypted: i=1; AJvYcCXn7H0il1FpZ4mSPUHydj61102Wm/JT/BJ/dLVP/wHM3Zu2nWSAvdlvycD7MHSU5iofvdH0BZfadX7PTdZ4GmNEIVrOh2bqA4RmqGAF5sO+
X-Gm-Message-State: AOJu0Yy+UVlPMr99TCPNatBGPchMyHjateau2ME6QxaJO9Te9QLnCjjP
	T9kb2tXJLCyA6Ntd8Q50n3xStRQE0h1YuN2bASGSmASqMoJ0G1SP3EMlda2CVP4=
X-Google-Smtp-Source: AGHT+IFbQ2c5TpJxdrKyUl2ru1yHmpDc6XY0Qm2Yv9aIIgLh9stQZB1+mDwKdX6s0oRU3mLmFdEA7w==
X-Received: by 2002:a17:902:cec1:b0:1e3:ce12:ef77 with SMTP id d1-20020a170902cec100b001e3ce12ef77mr2423696plg.11.1712904553854;
        Thu, 11 Apr 2024 23:49:13 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001e107222eb5sm2258818plr.191.2024.04.11.23.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:49:13 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 12 Apr 2024 14:48:59 +0800
Subject: [PATCH v4 3/9] riscv: cpufeature: call match_isa_ext() for
 single-letter extensions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240412-zve-detection-v4-3-e0c45bb6b253@sifive.com>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
In-Reply-To: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Andy Chiu <andy.chiu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Vincent Chen <vincent.chen@sifive.com>, 
 Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13-dev-a684c

Single-letter extensions may also imply multiple subextensions. For
example, Vector extension implies zve64d, and zve64d implies zve64f.

Extension parsing for "riscv,isa-extensions" has the ability to resolve
the dependency by calling match_isa_ext(). This patch makes deprecated
parser call the same function for single letter extensions.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
Changelog v3:
- Remove set_bit for single-letter extensions as they are all checked in
match_isa_ext. (Clément)
---
 arch/riscv/kernel/cpufeature.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d22b12072579..f6f3ece60d69 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -468,16 +468,15 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 
 		if (unlikely(ext_err))
 			continue;
+
+		for (int i = 0; i < riscv_isa_ext_count; i++)
+			match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
+
 		if (!ext_long) {
 			int nr = tolower(*ext) - 'a';
 
-			if (riscv_isa_extension_check(nr)) {
+			if (riscv_isa_extension_check(nr))
 				*this_hwcap |= isa2hwcap[nr];
-				set_bit(nr, isainfo->isa);
-			}
-		} else {
-			for (int i = 0; i < riscv_isa_ext_count; i++)
-				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
 		}
 	}
 }

-- 
2.44.0.rc2


