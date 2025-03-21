Return-Path: <linux-kselftest+bounces-29562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB35EA6BCFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 15:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65603B139A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6B81CB501;
	Fri, 21 Mar 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFi/D4Yz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A71553AA
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567579; cv=none; b=LUpZREbIavHoKtx7xyjGextiUCTbZObVIbGFCiqd7NPX4PQB9MoA/5T1m6PvtM0t/zPgn+R7ntPJANbshSFOUFn7UM3iNG0Ei05d2OYWfB7TkCDECl+k0M8b5S89tEF8HQpF8TdWwRO/yw4ADYzqNriJ0Zfj4GNmnL3r9JFU/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567579; c=relaxed/simple;
	bh=+LDlUo8we7HXs412riW2XVXscOex6Sq1qjsJfiM5m7E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a0gHZOk8a+MeWp7xShIlmKMVOVUqtvJO4F4xbj7cT/dyOlvyi4C0Az8pgFqANovhoHJO6229ZgFN/4tk+C22YUzxLJ4/1/Dj5sLcdmKVEIWyKeMnee2SOfZEMmLrIvh8NRigi7EcXgVo4Wg+qfu3IrfpAzAFDrX3RuHfhUseEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFi/D4Yz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso13539285e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567575; x=1743172375; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzFQfhx5F8dx0RL9AvvQYwg76iw5NXa4lMy+vsdeqMg=;
        b=kFi/D4YzOt770w/wvjc7ZyU62UJBn2euObrJKUlP60/QTnDz0WjYNyRKXyenjj3+d+
         8AZk3BM6HBEhEuboEEWBdaPijot2KJk1R+mOkr/H2hAabQl1NOd8ELA/Kl6wLzjp3oCE
         IQS4KvAYfhJhHX3vNTbRQ45jI04kVFtmuoFZ4sBeuddZ/kmc1iXJHZwePNhOfdULDkny
         SkrHecAg8qF0Y1r4LiI6qYbEg7biHopf4dE11IDR31/F71iIP9Wf7vCeaN5gGqCnh9Af
         KDhGkmBACtb8vNrH4I8mFFoVQUwY5gm059dGJMQT/7vZ7WJhZiJQdq1vWCauE8RtREL1
         t0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567575; x=1743172375;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzFQfhx5F8dx0RL9AvvQYwg76iw5NXa4lMy+vsdeqMg=;
        b=GEsMkd6G/By6H5guRIaagKcOjYXHi81u36nb3s/V/0K8WX44SMd0RwLCzTlXImyWe1
         9FakZPB9k4WqgIXVMQSK2cldUnaauywS1B89NMkHyRKj/cSP/S3y/YMoQMjKUFn6l8aB
         RE7e5LcUodGL27Zj6FO5fVoH4MBBA6PA4fvlcHdc8Sok8E/0Q5HIp7YCUSqXZNYD/LLg
         0rkWlAhfw0Tm2bHd246kuiL3XC/oat+mxWXmPHnPZ7E2rbPGnd5eT3hljnuxo4vbCFys
         Bi/6+dLc7yrm1tJfVMUd7nvvgot/c6xG1GrEPzFS3lFUaLgpdgBL9fsiu3fL7nJgeow9
         KTBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsg1J5rvUngViYWs4g8uroq+et+ZNPHPDimUh6aRaV46oFpQBDRDJN8C+aSFp1pOufzrLC+iZ02w8/nTgEXpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAmZ74HINA4T7pd0Z95kl6lpGtWNO6kpRLSbEl85TrB/u/Jos
	Rlv+qFEfSZW1cED7J1IHCWWOpBULe3EFIuNKn176uIZ3aOQ81TdgFwSmkpbST0E=
X-Gm-Gg: ASbGncvL9zTFSZMXMkoG76QX7p8UP82KH0Fw64OV7Nvx71kiXyOvKxiTLnva8vXpNO/
	WbqT12gd/Sdl91dDi8hi00p9xEy+MLJM8S8iaoVXFeIY9zo8K88g+ufABNTSFr/3QapYO5Kqs7T
	R+BZzaxYTLb40TNTr50Lw4rdlcTvEzpWHlqvVRrcmJ/2Mr7m8pr3+vEmoxikgqb0ZEzDEugYPa8
	5jz92Dlct6YeEGk/pvOR5+YfLcQLrQQkKP6JxjymiFwZ+RXXtShaH7qFG+/q1u4OpNn9qTG2Rpa
	f73/vWIehUN+G0QImGTY+PvhYaYA968jFeu82qKlt178na+yTA==
X-Google-Smtp-Source: AGHT+IFdHgCx4C5nFq7a41Rl1TdfpLB7mC6eqzVe1FxFvJX3eQdkfF3U3LPtyEx8bVlfn1VSsrBleA==
X-Received: by 2002:a05:600c:1c02:b0:43d:5264:3cf0 with SMTP id 5b1f17b1804b1-43d52a08ed8mr22225315e9.11.1742567575525;
        Fri, 21 Mar 2025 07:32:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fd27980sm28845345e9.21.2025.03.21.07.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:32:55 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:32:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricardo Koller <ricarkol@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Andrew Jones <drjones@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix a couple "prio" signedness bugs
Message-ID: <ca579322-dc9d-4300-bd74-7e9240e930c7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is an assert which relies on "prio" to be signed.

	GUEST_ASSERT(prio >= 0);

Change the type from uint32_t to int.

Fixes: 728fcc46d2c2 ("KVM: selftests: aarch64: Add test for restoring active IRQs")
Fixes: 0ad3ff4a6adc ("KVM: selftests: aarch64: Add preemption tests in vgic_irq")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
---
 tools/testing/selftests/kvm/arm64/vgic_irq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_irq.c b/tools/testing/selftests/kvm/arm64/vgic_irq.c
index f4ac28d53747..e89c0fc5eef3 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_irq.c
@@ -294,7 +294,8 @@ static void guest_restore_active(struct test_args *args,
 		uint32_t first_intid, uint32_t num,
 		kvm_inject_cmd cmd)
 {
-	uint32_t prio, intid, ap1r;
+	uint32_t intid, ap1r;
+	int prio;
 	int i;
 
 	/*
@@ -362,7 +363,8 @@ static void test_inject_preemption(struct test_args *args,
 		uint32_t first_intid, int num,
 		kvm_inject_cmd cmd)
 {
-	uint32_t intid, prio, step = KVM_PRIO_STEPS;
+	uint32_t intid, step = KVM_PRIO_STEPS;
+	int prio;
 	int i;
 
 	/* Set the priorities of the first (KVM_NUM_PRIOS - 1) IRQs
-- 
2.47.2


