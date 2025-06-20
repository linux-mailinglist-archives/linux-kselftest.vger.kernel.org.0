Return-Path: <linux-kselftest+bounces-35472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B23AE2500
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E788179502
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C64B2441B4;
	Fri, 20 Jun 2025 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJpAyO/B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A92405F6
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457922; cv=none; b=pbebpS+nj8OIEAI0OGMNGBOt8sjWcOyCNE9tCiOJCo4ZaKK0op+jjs2auKID35JT4ApTpT58rViTKanYuIs5eNzA3EOC+iwGYh7rOeOfMWUCHbXlw0j+SO7P8D9ZiXJA84TpvPfmMTArGtNPXOlrS7puWWL5oJZxHCrwfqGLbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457922; c=relaxed/simple;
	bh=hEI+Ws5Ed4T0XYMyDeyGmT0ZhHqtHUDKeUxZmkH++E0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AY/YFlDzIqOBhd+l/DYG9wVLJ/ANCL3IOLCbIvZxOmPyuz07UQxrYeOfljvjhWNRHSfJzpXta5P99UfvGA+4y+feT8MpE3CifPAKOZggeUwiyOVOF057cLHIVgE2rd71p1+Xmwe2eh2glbUXcoFgmnum15+BhS0fWdK8N4iEdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJpAyO/B; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddc65f95b8so44628765ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457919; x=1751062719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzpL3Ld7f3Wg7N4Mr5qllGNQ06XKr05fHXYYgZEl88s=;
        b=BJpAyO/BtidrS4k3gtcxF0or8fzizr8Vz9hZeEeiJYHA55yAh419X4bhab/XKH/5mB
         nUB83IBqajn29noD1PY/k3oLa2fORyHziD2wlBBQjAM8ob9lrGdGjIYoSUQlI23gDJj1
         wDY16PKaPpH7PQYTUikCzVi8Wl6JcqON+9frJ6AOtNZMkDbg4Ll30xG1kelIWdOWwXiK
         +dNDtVVuWJaf3vPQkPKv7bwLEmB+TxlPew538h06TuxYXDZo8BdFI8YFOenanmnGbZJB
         1NGElBTA2caOAkGifvt/qQQFeR5NIL+pa6FlXBLLTwKuz1iOXN2PNGRufnKY8SuB88jy
         pFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457919; x=1751062719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzpL3Ld7f3Wg7N4Mr5qllGNQ06XKr05fHXYYgZEl88s=;
        b=oURIWAshnDR8xisbGM9JRiBkRddpCuXB1Imt0r+9DQrKYe90BGE2f+VnQvQr5qY/h3
         D6ehCbdydp6ZX1Kn9DDtklP4sT1okxiTMRMZTHX9GI6fQZRccJVweu/1juWe6bGM3NN2
         foqeHZucwCczGd4MlgQDw4phlApcc+o5Eek4U2Ug4rS8Eu1N7er/RGFLrKzy/1Kc9ffe
         jXDKM6IDaEC7bq49/21yo0JOCW600WsYoLMLUWlDL5Z2IGycbMHUGlddOgPwrz9UHILu
         eYoqBaFmgQY0xLQotjKFHyypruMqI6Ig3UU5R/Kc8k4XXI6CUwcb38REBE/wBbxeWV2h
         xR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRBx7hhi9PEroYCe9ArPG8eaYDAuJ0n8MK1PtwM7DkukN4FWLX3e6I7oe5vO3cy89UDee61oxJMwuW6yYwdm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0vHK+4SRf0kcMyLNSvARoRpdAE0vnH8OoyzZpO6nQSw4ziQH
	amgn9ft5sW/VQG4pEAKEPoKisvtd0l8XVXJV4b1XWFshCbp8ZEAXyCw1lU37SDs1MYYLe6JBkEN
	yJnIP9pqcEnbwnXNlt4Q5jln4Cw==
X-Google-Smtp-Source: AGHT+IGe+i459NmOZi236cX8Bur8HwnWegO6n5YG8V2oQ3pdTXQJfj8y4MrKY8v3FuSI+vF/XixyV2nwOspzfQufmQ==
X-Received: from ilbea3.prod.google.com ([2002:a05:6e02:4503:b0:3dd:d24f:26bc])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a92:cd83:0:b0:3dd:cdea:8f85 with SMTP id e9e14a558f8ab-3de38cc7adbmr52345645ab.20.1750457919574;
 Fri, 20 Jun 2025 15:18:39 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:04 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-5-coltonlewis@google.com>
Subject: [PATCH v2 04/23] arm64: Define PMI{CNTR,FILTR}_EL0 as undef_access
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Because KVM isn't fully prepared to support these yet even though the
host PMUv3 driver does, define them as undef_access for now.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/sys_regs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 76c2f0da821f..99fdbe174202 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3092,6 +3092,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility  },
 	{ SYS_DESC(SYS_FPMR), undef_access, reset_val, FPMR, 0, .visibility = fp8_visibility },
 
+	{ SYS_DESC(SYS_PMICNTR_EL0), undef_access },
+	{ SYS_DESC(SYS_PMICFILTR_EL0), undef_access },
+
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
 	  .reg = PMCR_EL0, .get_user = get_pmcr, .set_user = set_pmcr },
 	{ PMU_SYS_REG(PMCNTENSET_EL0),
-- 
2.50.0.714.g196bf9f422-goog


