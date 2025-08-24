Return-Path: <linux-kselftest+bounces-39798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E53B32DB2
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 08:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2C7443678
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 06:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31A233736;
	Sun, 24 Aug 2025 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwuTKpwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4F165F1A;
	Sun, 24 Aug 2025 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756016074; cv=none; b=EL/bQVUqnv/hfRH4ebz8n4wCiJzdWevrriR2PJuMqdGnq37/pImVQPxqWESsoZrtPk3DSCM/u5oOnvghIwRHP4tmtPYVTCD+BW9UZL90NUPjVXD9l4GmGTvWzH/pImKipNNFy9gVlFRIvkZQ8wzImOtlu5CGQdHViopYu5RtvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756016074; c=relaxed/simple;
	bh=2Krz1q4dLXwXDvNiRnwBsAnhUvKZtc4rAuQ9af6bRPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=meQll7WGbj/Jg/Fg6vwvkJ1dlDDF1PJK//stIGVYk1sHUfM4MeaYHuac25W1vko+YZPlTOthEeAEp6Ts4+3QlPtRkn7H/WOUxAkHPFIx8pge6lpWMxeDwlQ2cTDH2ZA+UJZqO/wVvkEzr3jLUDLahjHXjJ1u5Veht2i3D1nYxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwuTKpwO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-770d7dafacdso53390b3a.0;
        Sat, 23 Aug 2025 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756016073; x=1756620873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kp6ZpPi7OjGlmUly9kUQqc77MGv9H1CyM6s09oVZLEQ=;
        b=NwuTKpwOuLNZNs/HjPvqKBHpJNl//w5Uwhqz3kuWPS+FXwZtYOwvuPjwaVRhIPo4Cf
         jniLwOaeTm9TQBsndVVNnVK7UUgmSeBuzLpyL5rYG0GDnvTEFoukPJX2q3+PvGIRhM8x
         uLn301FmWbbAGjRKDtb2QDz3Ti30QHdYFrnAUnO5fF1qccECxVUzNT1Nzh/SGiMWk2cu
         uZxCNZxhiwYWw13bM1JKbak35giN+ImNQyJ/yQr9duoXQhQOV93IIOLpQAa3wz7XGDwJ
         5JuRLXbBVqepq2CjOBpW1wMQaA/ml1vVFg8dXNWzRuM94RpbSNyfIPYsk24If2lPgYCP
         uEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756016073; x=1756620873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kp6ZpPi7OjGlmUly9kUQqc77MGv9H1CyM6s09oVZLEQ=;
        b=lcMUUKsdlx+iA/jis0ky5YOHRaom5zIevqJmp9PQsFUxPp/E4ROu8B2pKllSPgFBI0
         F8TumbzTBp67Bgl9JIZiUggLsuklqwuOZ/aC21nFvKQq0kna7fKVQk5syhFaoSpiT2ae
         vq5UR+FrdW+biRdur/LzWkUpybWprOnmnS9qFa5zhV5ipvoFCxZ1bW2JAqn528y7+L9I
         eHk/ryLHTey+RY6pbZwPuMty3G9D48siERdy470VAG63ShWiA2fHhqeqJduHA53whnsh
         2MW2i1eMtHlt7KV7jvrMLoBHSnxCrAUYJ5/n2s7yecLLlDvbb/nYSDzRFl57fK81tSme
         npUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2M1ZjiO6/ZCOGCJav3PNoIo/57V/pHBCULrQ2Vgzm80VaIRmg6sFnE1lVmB+P4JeY442ySkbcXcbdNdFLUSM+@vger.kernel.org, AJvYcCUT9f+REk8hscwW+vsXhv5zFAK8t/+Z3ZgZ9zwh2o7HOlofP1vF8iJ0niksupuQx7TiDJTMw8+TO37z3qkh@vger.kernel.org, AJvYcCUo8Mlu5AA4/w3flsq9JidupJ3prh26n5dn6inRPMOkZ/AP/G/RrG9cUHbI4vpcCfPDyx57jX9G1gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqIJcm/reQCm35OILPNYCaK2o1ktyBtxQto4WKniL5ddUen4o
	WLiBI/80amkJOS/2uTtSwDNy/C1il/8vIJTeBnUBYDVS5IA8H+gZZuNl
X-Gm-Gg: ASbGncv6l/xS78CU/FL027LVyq8cbg2mmjB86lbFyayMcFmyPS7PDHhtdjxF/WsvMp/
	X1NIaop6XhNPF2g6J5AtZCU3Twty9auEu8DvFm9Cl6dg+GUYvTOKlL+z/bDWsBl8IWpuKaoUmny
	3q96ZJnpsXA5b6JQmZD9NRLnhVZChby19lSTEcdt6JUSWSi4Ks3XH9obld2g8wJvGZIEIXbQ74O
	ZtGhDi91vfROUvROu8figjZbNkyxZCGC8W9ghjhqb5mfiNAqW2nrHbbtQIddHrLG6Frd3cE1zzr
	HeChGly431dsxAb+0Vujt9ko1uxmBreMmAQ3tIBQCpVUA75lzsAvsnosd9Nfk2m1RoqxF+Xx8Bz
	qWSsYGuvSVIo8QZ4oQem6IVzMtidsHjhtAbWQgZAsFav58wtUBuaF
X-Google-Smtp-Source: AGHT+IHTB0sh55lPsQjkIFNymMCMskciLiGeZrY5LBODEDl6ZzyrY2seKOgvSBVSBIbrFshQ1YI7Zw==
X-Received: by 2002:a05:6a20:6a10:b0:243:78a:82aa with SMTP id adf61e73a8af0-24340d5e73dmr12948421637.50.1756016072582;
        Sat, 23 Aug 2025 23:14:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770529149bdsm1654943b3a.98.2025.08.23.23.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 23:14:32 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH 0/3] kselftest/arm64: Cleanups and readability fixes
Date: Sat, 23 Aug 2025 23:13:59 -0700
Message-Id: <20250824061402.13432-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Hi all,

This small series makes cosmetic style cleanups in the arm64 kselftests
to improve readability and suppress checkpatch warnings. These changes
are purely cosmetic and do not affect functionality.

Changes in this series:
  * Suppress unnecessary checkpatch warning in a comment
  * Add parentheses around sizeof for clarity
  * Remove redundant blank line

---

Vivek Yadav (3):
  kselftest/arm64: Remove extra blank line
  kselftest/arm64: Supress warning and improve readability
  kselftest/arm64: Add parentheses around sizeof for clarity

 tools/testing/selftests/arm64/abi/hwcap.c       | 1 -
 tools/testing/selftests/arm64/bti/assembler.h   | 1 -
 tools/testing/selftests/arm64/fp/fp-ptrace.c    | 1 -
 tools/testing/selftests/arm64/fp/fp-stress.c    | 4 ++--
 tools/testing/selftests/arm64/fp/sve-ptrace.c   | 2 +-
 tools/testing/selftests/arm64/fp/vec-syscfg.c   | 1 -
 tools/testing/selftests/arm64/fp/zt-ptrace.c    | 1 -
 tools/testing/selftests/arm64/gcs/gcs-locking.c | 1 -
 8 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.25.1


