Return-Path: <linux-kselftest+bounces-8494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F298AB7B3
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEB12824FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2736145B17;
	Fri, 19 Apr 2024 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ovqiwdIm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81837143C55
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570484; cv=none; b=j7n21r1vsUFajKT1C8CotIECnN34yZkzgpzw2RgHcE+09KkAa/PqmMr/tTX9U6vRMGIfD4SxV+u5RXZuttL+MF1mlmrNRnieWTYBxUeU++vjPHtVEP+oJ/TZSsYn0y3rYUn4/NUjNUEakzkpSTfJpn0p1fxxiUD13lOjq+2pEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570484; c=relaxed/simple;
	bh=i4/+SnhxIOkVH6jnqRPVGKLSvQvEdBjQqHeh5YP3SQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/oZmCFBG/VI+Vsur0r/WsJhMIT1f5xwp4x79b+yR4Cj+XUqyeWX2bkAZ/nUC65KRkwU2EQD0ERPzRKhtKHwmmsZQTQgMfVZbuRTXP+/EU7v2kMCfSbc+5cZEwagjX8i/XID3befbqJsWiVhCAn0BP7r215ddAkRC+6D1VNgYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ovqiwdIm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e3c9300c65so24854895ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570483; x=1714175283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=ovqiwdIm+tdsGciS90weKXkMlO8DwB/UxneEkFaoo1mgU3NtFEq9GEIpJ3XVa/Mm6S
         3ZOYsl2x5iVjNX97pFAyN4vhzf7q7c1t5XoXq2nKgxpzwfhBApvWe1coJSx5AbgFe2AI
         ShfAxvxpBDe9pe3CsftZqHSL+WRdSI7oN+RYk5YxOMUEKqS6jSih5ex7GljPZ7LdUlvm
         i+XrwrppMxr126gsSHB0zAj9YKIR99SBZupyqErK6Lxzs1b1ERFLY4gzpKk8hooNDtrj
         RWe+8IJ/OdGtO49ugND1qQJUuoZhxo87/3NO1Afc1/UAi1J+5Pdz4TfXKkpRU+gO9nux
         +voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570483; x=1714175283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=l/YXpKswXnaJPnc2U0XOQXtTNn/MiE6h2NLlbPDtyvzQAOAubo38tPIkJzUhmC4saI
         TLY2j1r0Gh84ROQyoY9jTj24xlKYcYrZpDEOPPBkIqrm/SG5FnIzNo8JVq7xzpoyCBH1
         tW3l6kC6gxmts6kQl3SrO/EIopMcTtJCfAaoZZhqhxRVTuyQr5XhTlixDotVWR+gnHBA
         gUYUMhn/gd8Dy5ivswIvt2/9EMTgkkkSKaXhB8scl3ZQnb9vbZyaFImi177ck5xLBeJz
         hutuNFq0O4pKiOiX3NnLsGEiYyoW38PTBhGdEwKfzPQM0n1/1vPdUCMKsyP2ueckjGDs
         b3YA==
X-Forwarded-Encrypted: i=1; AJvYcCXIQAiUZ+DLDwDA4RRmkSaLdRlONxZsucRjRlAfL0ph0SkRJoL3cdmxAEJPu7U77rYsKXGQb4zebtq1liXp1QgzMQeuU23nQl3g9N3iBdWg
X-Gm-Message-State: AOJu0YzeSLMY5mbe/1yUd2rT2DbkTn6Oy9jMsLEsDhBbuJ7R22Z3L7Ej
	BW3jYnzw4k5tDfj/isqsjsbwlk1q0/zGO7HPOgxC+lIAd4tllDv761lY3QJAxAQ=
X-Google-Smtp-Source: AGHT+IFuxivVAucFqLYqwANgIIbEmyPV0tNMGWLxqaH8776sBq/Go9KZec7LTwKbbmPafjRvAwUZ5w==
X-Received: by 2002:a17:903:22ca:b0:1e5:2ba9:a667 with SMTP id y10-20020a17090322ca00b001e52ba9a667mr4212130plg.3.1713570483020;
        Fri, 19 Apr 2024 16:48:03 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:02 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	samuel.holland@sifive.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v8 10/24] RISC-V: KVM: Fix the initial sample period value
Date: Sat, 20 Apr 2024 08:17:26 -0700
Message-Id: <20240420151741.962500-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial sample period value when counter value is not assigned
should be set to maximum value supported by the counter width.
Otherwise, it may result in spurious interrupts.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 86391a5061dd..cee1b9ca4ec4 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
 	u64 sample_period;
 
 	if (!pmc->counter_val)
-		sample_period = counter_val_mask + 1;
+		sample_period = counter_val_mask;
 	else
 		sample_period = (-pmc->counter_val) & counter_val_mask;
 
-- 
2.34.1


