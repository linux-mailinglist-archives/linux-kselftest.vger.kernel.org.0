Return-Path: <linux-kselftest+bounces-4630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CFF85495C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 13:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962B31C22B5D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8652F78;
	Wed, 14 Feb 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aBEmgJoR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59C5467A
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914306; cv=none; b=Q/ROa7KNZD7kBL+Mw66XHC7eg7TFfqnRuNQ+Rhkn3+tlIEzyJMQLo063N7JVNAtxu48RbN5WJA+X1K6YXkpup+b2kl0krcvnlShx211Aq9rkGwbgYJeL1kkH/BGrc46OfAk93PadnLyxhI7AUZph72qj1zk52XRyUgWvhPHYkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914306; c=relaxed/simple;
	bh=cex5yCjawX5RILzSoRTQj5o40v+xzFY8ga4zlgODdvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Npi4AMZEW5B5Atua3susKN0Fy+iLHcg4aBg/8ZMZvEWDzydaEjKg4jhY8D9HsfNHnpnDtRdQbX8ZLYFKeB6BoXco82/zo1sauwcBWhSPWs0EC/ReNk8wec1X5Y4YUjs5aToabC/zU/u9B/DCpeXSbyAZQRSAIDa8w1wSckCJLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aBEmgJoR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d751bc0c15so48833525ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 04:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707914303; x=1708519103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBSxSTn4SzFgJCLw2mwbPUiKLRcghcd12QFIpuWImtY=;
        b=aBEmgJoRS6SLKU2l0Q9BAGWB0zodE2P2zJWD4EUST677LOW33zQ6GIrpbx9RhcpcRA
         lyTyr9/BVYDTyYzrv0ubbDb1GcnGUvR+eI00tWH/10eCf2gACaKkN4DHzCCSgKIEUj+y
         7NOqgrBKYDbkJxTeJ9o0Z1ddv2yvfIw+ijCssM+MiGXSEq1tQREcicm0MNEt/jIb/tNo
         CGlXobf/hBob63n1Mw6HSaCvLY9Uo3/rFPd63rAA+4FdctCLiDLaaKdXdqxj8EMq43L3
         EZp358EM/Uft6M0+DB+0bazDn41S0Kq7w/ko0VhjXxGvyzQlNdGyTazEsM+Zl2uB0nfI
         +Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914303; x=1708519103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBSxSTn4SzFgJCLw2mwbPUiKLRcghcd12QFIpuWImtY=;
        b=SXvMqISpUcAsApwd1Rj8HLUEQ2hXTQft/zZzqF34Qyge0mR0av0XfVveqg6VbXr0+z
         LpttDoJIaGOhWDko+g92QrKd8E/4HA+72RxH2gisbXU69LdYVGYL714U6QOKtJwHRNE+
         W0UnPG/8BVM9BjGnb2XjAE8sWBwNevcxyk16COCegoxcWHi2RZ4vvgvCgKZegFbnJM6U
         PZpji9gibdWmTm57qV+EKsHF41OeXn3oDATXQbGIxAKrOEucUz2jsKfk+9rvka2ny2Eb
         E78BcUTn7RsYb3BbTe0JnSHTs/SkWGwOafSHfB6nXQWRapv/yO5vWE4yMQ5FzKJCMcGN
         SB3w==
X-Forwarded-Encrypted: i=1; AJvYcCWVQFvZ4WAFDRTMFkftH/ps+/94FA+I+BrWJSnfCSS690XEQnsUzCzR9IsOUjywzSxvp7WbJ+0s1XUMIN536oId+FQ3xo9auwQ2gz9BC+pY
X-Gm-Message-State: AOJu0Yy4DB7kclInAIVlILTRlbrqd91dOB1a2OSd7WPTsjfYwLJj0bWW
	qpp9ZvladGX8qDOArf0ZY7k6PGVQ4zYI8f7tjVa7UuJkiQLMMb2q1mLFkwjRccE=
X-Google-Smtp-Source: AGHT+IHZQFnNrVkrei4j4ZNoY7pCPgZUX5vwqHY83d+LoRS42msBSa4XSwOZVWRzwbeoKajJ1Adrfw==
X-Received: by 2002:a17:903:32c5:b0:1d8:d5b0:aadb with SMTP id i5-20020a17090332c500b001d8d5b0aadbmr2210794plr.66.1707914303508;
        Wed, 14 Feb 2024 04:38:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoXP00E/iqkcjEmAUlBHrFJKYJoKL4q0+QeKcB6TPtbNEYX7VWrlUX2Uu4YkbXuRUJQslzZEHFfn4RRvKWNaoR1WGgwBvKaBbLuwi1AJnOnuRbkIMSuR7avQ1052diCkJpSrupZ3VKHRgEDuNPXtIbEhll4ygTcHqYxOA/MP4rJGThf+wtAPVi3AFCynE9gkIKexohY7Vd7k4vqbCkAHGmHho00ydthMQHcwzX88GbrObaKy1fPto4j+hoMuCbWMJrPdoFd6zCAhMaSq3mikn72w6/DpzwMNRrJHMsGUiBmghCZoY3PSJ0HRwHl/aGY9OJ1J0rJviin0rxG5PtBlecyMLe7mNfEE+tC7TTqPTFsxyL+evcZjOYIWg/SgZWHHLZB2lm5nnkEvTFrvx8F0KGw0C1erIDuDyRozFYxsy2oK+85SskFZaKJr2sRw==
Received: from anup-ubuntu-vm.localdomain ([171.76.87.178])
        by smtp.gmail.com with ESMTPSA id o20-20020a170902e29400b001d9b749d281sm3041419plc.53.2024.02.14.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:38:23 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 4/5] RISC-V: KVM: Allow Zacas extension for Guest/VM
Date: Wed, 14 Feb 2024 18:07:56 +0530
Message-Id: <20240214123757.305347-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214123757.305347-1-apatel@ventanamicro.com>
References: <20240214123757.305347-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We extend the KVM ISA extension ONE_REG interface to allow KVM
user space to detect and enable Zacas extension for Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index f8aa9f2ace95..37fb0f70b3e5 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -167,6 +167,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZVFHMIN,
 	KVM_RISCV_ISA_EXT_ZFA,
 	KVM_RISCV_ISA_EXT_ZTSO,
+	KVM_RISCV_ISA_EXT_ZACAS,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 38f5cf286087..f4a6124d25c9 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -40,6 +40,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(SVINVAL),
 	KVM_ISA_EXT_ARR(SVNAPOT),
 	KVM_ISA_EXT_ARR(SVPBMT),
+	KVM_ISA_EXT_ARR(ZACAS),
 	KVM_ISA_EXT_ARR(ZBA),
 	KVM_ISA_EXT_ARR(ZBB),
 	KVM_ISA_EXT_ARR(ZBC),
@@ -118,6 +119,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_RISCV_ISA_EXT_SVNAPOT:
+	case KVM_RISCV_ISA_EXT_ZACAS:
 	case KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_RISCV_ISA_EXT_ZBB:
 	case KVM_RISCV_ISA_EXT_ZBC:
-- 
2.34.1


