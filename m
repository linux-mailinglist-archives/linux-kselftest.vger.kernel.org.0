Return-Path: <linux-kselftest+bounces-40400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A50B3DB31
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B38189BA48
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0126F445;
	Mon,  1 Sep 2025 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW5OtWNz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199826F2BF;
	Mon,  1 Sep 2025 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712183; cv=none; b=eDsLPCH6VVQcxouujj1x87tAaQir6rEkxDeW/6FwjlBW+vlGeWRE/Vl5azwBCzFG4qkWQZZyCMxDjfHfQqmrhkDM5JvNdGfJ3dZ8Kz8Gzm9Xe028gwC2Gh6QtsLe0xRP9WWjTaJCY8N+5gIrUGOiMF1l7u08DDh1p2/f5+G64oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712183; c=relaxed/simple;
	bh=LPo0JG8mkphRNQlJnM0Of6TNLhAtCZ+rwOl1RvG95zA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFuhuQ8eTUkSuVpR+6pfaN7UhSGsebYuKC/8I7HJ5Zd0FXToduoAcgPWAjctG28noxHr6cBFRAkGwUZaQ21IRn0mS+F6ZjPS6pt1hEL2SXOmPV27nqeOwwwtn5Ev3sIdiW/N518sEOeQeOnHMLnYhqAxgLn1NsuRWCNbt3YKcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW5OtWNz; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2445806df50so31519965ad.1;
        Mon, 01 Sep 2025 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756712182; x=1757316982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lI7sqxzwAb6+8qpfDyLKKtJ7Me1UGv0S+1RIHhygZjU=;
        b=MW5OtWNzBLP6Chz0zz+6UQEKk5wdrymAKPsea3l5mMu/vju5D9hF5HXQ3CIugGg6QZ
         C+6m/sxPlvgYFjeQuA1pLb7bGHtL1y+TPtGI2zkrUyA7D9IWnSacvfjXPjaMwuArHPlu
         dRZvaJLKHuvo27Pa3GCa/a2GhEW069lJm7usQHJrX+UKxeLaIyyaAITiBedCnRYFJ6+i
         eUVGhMEvJ5XY/cVWQOJBPuaepXinq4OERyiDp4UsuRxeH8JVeS+2AsdMoM3D3J34drru
         8oTWC2tQ/9qMWIDUR19GPRNzSagCo7KM+jDlBN2hVI40MGfz2JKjOf1IvBf5DKDgNYTM
         s7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712182; x=1757316982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lI7sqxzwAb6+8qpfDyLKKtJ7Me1UGv0S+1RIHhygZjU=;
        b=l0d09+9NsxtLsRT2JNTb97I35sBTsQoJIJwo5gGN89PRUz89xXOjay5DpN9pxJI1V+
         V0PbqbTiqZVoSfpganiiUuK3vJBSBWWvkBMjN6wjM7BwMHhtOdHWGr2h4ksUd3UzjDI0
         H82XLdkAiNuIVSLpmeRiH9SPprS7iDuSZVqlUU2IofSC063bXf+znNks6kMO0XiSUZZi
         65D9tpr7ErcyHfUmEvjk5EnrHsPCHPKvsi94ZLpUmMlBtzhc28pnBuReZhZXc8JwI1YE
         RFcNV4xCmrPtG6QRG0t5a/pSscSdmuAeIDPuYg2IcEnAYtSXAAPZ6gIA8UKvzmcJpJXh
         TdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWikFD6qKdexhBpk+m3isxEils23u5M5edPs6NuyjjGRvg+bS09Dteg3IN48UdPoFkb+6slztc7KeRG/V+S@vger.kernel.org, AJvYcCXBWdHqtheyMUSbKZkmtAW8s6JGWg7byZ+8YI8zPi2DZ2CybKbN9nGlyHt9mE/aswnQZWU=@vger.kernel.org, AJvYcCXNOc+hv1dNPCwb9C/E7pFvauCQOCoeItm9NqmtEEbZIxzD5Bdc80xu2RHxKyxLm7PwM5ZmLBZYFFBS3AjRZlGa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7drK8PsUixd9RZs6a9eoNZXSMDKN88KjWHYPC77xoeNqvjXi9
	6Xo4NZJvEcohjt60BUpk/Z2UfbupdDAhv9VDaa5i/YkAMSBQhgPVF4No
X-Gm-Gg: ASbGncsbpR5h7mVPuJ1ESvL2dD9MIckt0aSGTKUKZwle3jx6xpRn0+W4Id4fcsBmT6q
	vBzNXqTLhpKmMXxCt859YvqCqWwQwWHu8tN7X5aFmuA8dNkhAOKNtjUAtauHpe3ZsuxznUgguRY
	jIXsJAb3lM2ie2SHyp2MMNHRGbr5fr1TWBadhqafa/gv/hgKTzZjjMtOJNEf4qQMM5y8W29fqh/
	skhxLVsswgTu/MCTPqEEILU6sum2smUPWehR4wdbcRFkMc8EDLDTc0UCJrBcdX51408HoweGean
	uimBC8Ka2tMjwkbubthSPK9Ee1naDsp2pbqxPh9c9RYR7KMi82GxXAaLYKwr2P+q7ZVhns8qZ8L
	/OZrUdfungsvdeZNlHHnK
X-Google-Smtp-Source: AGHT+IH+dCQY4Kqqb6suPsSi0/Emx7fwwdzdMp+EJ6/IyH5dxTgGWWtb0vd7ZMANbaRLjtbZGTJDPw==
X-Received: by 2002:a17:902:ef52:b0:248:dddf:e3f0 with SMTP id d9443c01a7336-24944a4faf4mr88999825ad.19.1756712181651;
        Mon, 01 Sep 2025 00:36:21 -0700 (PDT)
Received: from days-ASUSLaptop.lan ([2406:8dc0:6008:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903737b05sm95867045ad.49.2025.09.01.00.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:36:21 -0700 (PDT)
From: dayss1224@gmail.com
To: pbonzini@redhat.com,
	shuah@kernel.org,
	anup@brainfault.org
Cc: atish.patra@linux.dev,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Dong Yang <dayss1224@gmail.com>
Subject: [PATCH v3 3/3] KVM: riscv: selftests: Add common supported test cases
Date: Mon,  1 Sep 2025 15:35:51 +0800
Message-Id: <c447f18115b27562cd65863645e41a5ef89bd37b.1756710918.git.dayss1224@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756710918.git.dayss1224@gmail.com>
References: <cover.1756710918.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quan Zhou <zhouquan@iscas.ac.cn>

Some common KVM test cases are supported on riscv now as following:

    access_tracking_perf_test
    dirty_log_perf_test
    memslot_modification_stress_test
    memslot_perf_test
    mmu_stress_test
    rseq_test

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dong Yang <dayss1224@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f6fe7a07a0a2..88613a851cc1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -195,9 +195,15 @@ TEST_GEN_PROGS_s390 += rseq_test
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
 TEST_GEN_PROGS_riscv += riscv/ebreak_test
+TEST_GEN_PROGS_riscv += access_tracking_perf_test
 TEST_GEN_PROGS_riscv += arch_timer
 TEST_GEN_PROGS_riscv += coalesced_io_test
+TEST_GEN_PROGS_riscv += dirty_log_perf_test
 TEST_GEN_PROGS_riscv += get-reg-list
+TEST_GEN_PROGS_riscv += memslot_modification_stress_test
+TEST_GEN_PROGS_riscv += memslot_perf_test
+TEST_GEN_PROGS_riscv += mmu_stress_test
+TEST_GEN_PROGS_riscv += rseq_test
 TEST_GEN_PROGS_riscv += steal_time
 
 TEST_GEN_PROGS_loongarch += coalesced_io_test
-- 
2.34.1


