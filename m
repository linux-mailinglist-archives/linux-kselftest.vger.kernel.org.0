Return-Path: <linux-kselftest+bounces-8704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DFC8AE6B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 14:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D0F1F225CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E2C13B293;
	Tue, 23 Apr 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c0XJltOj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4711137C54
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876235; cv=none; b=V3YGNE9SAmMpq1hXA+ZfGWtJLs4z5sHMuqVDMZN/6MyjlTuywfWs/PaJaw/Ga5LijNyYZ5rDk7JQblgNnhElJHpFYA6C9Mep6wnG0hWCjZnBmmY03JzgitC2iuoAUR+tICR95VBXpoRIF1+OeBUcX3KPiQA/4KdsmNumEJ3D5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876235; c=relaxed/simple;
	bh=a0XzsdggPUj0Ja28kYjSZ2eAp6PAvvyuna/HjP+bSA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=db8zsPq/n/l7XQBSh8lPAk4sc5g85HmxJBGXSCJJLRnu4dIfwM0on+W8i/huliL6oyKPsAYOrNNhEYiQ3wbRyu6SAYTeOKWg7WXWuKbtnxQZfHSH51GOI7pC/+kIyW7VdMqoJBU1jX9yUsf4bNIJX5yIVRVDvsdgFfgY/knfT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c0XJltOj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-347c6d6fc02so875607f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713876232; x=1714481032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCiDEygHIpDe3Ww8uIgQjb2MclVWFXcZkaD66mBe1pc=;
        b=c0XJltOjiNF57/b+YdDEOIGt4isxWKV7BV1IoApSsRcpNWY86kZV/VygOxWAyB84j8
         ZTMKTaN5gtrvhH/+1CbR66Il1a1Z9vWoCEAZEqYgwxsEJLHgyFWV+jtcC8mtvWV1jk7r
         0KiVugH8UiGRIYxtPvfBf+/B/v/GSwvf0o354DuroONxu+k01hX4IWDtIMB8MddqKieD
         PP7LRF3WzfJ+tx/yHAZcZWHekpnL08XTsIps85/ZWA55DptlHhloyDWIsDbHiZ75+UEr
         uoiyBUQ/UxODKLAKol5tZulk6YZ3q2sZQmfnoTnAkFqPBxcZJ10xBBjSF6ziHrq40JlN
         dwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713876232; x=1714481032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCiDEygHIpDe3Ww8uIgQjb2MclVWFXcZkaD66mBe1pc=;
        b=PL5li/gkBnU8/gy24z/rsb/mf52iiybzcXI3cUtgpDvn49Jt7VB61+7fMcJSKAuyht
         L9Z3Vu6SLDoJEhBe4tVrrGn4l0VYRmlsw9HXHndYV0OE1CMfsBFqGt8sk7lY7jCme8F1
         QyiRFqyxkomwpgMcJDmJBPKg4KmVC/vknR7zHUuhrZak9kFBOlKBD4H3N+h34lvZQCcT
         Nol2njttH84q6Rxf5M7i+pmAX2BJm6SDRLHEGe5fe9WFstT+rJFY8MRi6T4i2Q23rp7z
         G4zfIM9ZlUaI7KTp010TW/xWAb2WIHzyZKSKlL4wRBXynu1LJNvAa/QqJ+7ImmgCTo4t
         IFZg==
X-Forwarded-Encrypted: i=1; AJvYcCXTHkj6y4EuBD48+ucKe8GpW7LiEkkMhe+G795kG0vuwDw5Qs8sBJX4/znwOvos+HQD9onCsFavwVN+AvAYtE+FraPYQtzzaQ4L9SSLA4z/
X-Gm-Message-State: AOJu0YzBlhpCZIyL0UD6hJLhw15rjEfXtQ6ovtBJocEID7jspIvIekP3
	IzrEGwrTY2Cxdv5988oSieM5zfmLmxpcZ03pPxi8K33V3uVpl+S3PSWfk+ScYGA=
X-Google-Smtp-Source: AGHT+IG8Y0QuKdCdamw6m12y/zyBhHBAXQlGn8wgQVKcyAjav27SlxD5OClQSLzPK55ylnTNKzC2Ow==
X-Received: by 2002:a05:600c:3d95:b0:41a:c4fe:b0a5 with SMTP id bi21-20020a05600c3d9500b0041ac4feb0a5mr958105wmb.4.1713876232338;
        Tue, 23 Apr 2024 05:43:52 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:71cb:1f75:7053:849c])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b00418a386c059sm19975709wmo.42.2024.04.23.05.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:43:51 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 10/11] RISC-V: KVM: Allow Zcmop extension for Guest/VM
Date: Tue, 23 Apr 2024 14:43:24 +0200
Message-ID: <20240423124326.2532796-11-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423124326.2532796-1-cleger@rivosinc.com>
References: <20240423124326.2532796-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension ONE_REG interface to allow KVM user space
to detect and enable Zcmop extension for Guest/VM.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 57db3fea679f..0366389a0bae 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -172,6 +172,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCB,
 	KVM_RISCV_ISA_EXT_ZCD,
 	KVM_RISCV_ISA_EXT_ZCF,
+	KVM_RISCV_ISA_EXT_ZCMOP,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index a2747a6dbdb6..77a0d337faeb 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -52,6 +52,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZCB),
 	KVM_ISA_EXT_ARR(ZCD),
 	KVM_ISA_EXT_ARR(ZCF),
+	KVM_ISA_EXT_ARR(ZCMOP),
 	KVM_ISA_EXT_ARR(ZFA),
 	KVM_ISA_EXT_ARR(ZFH),
 	KVM_ISA_EXT_ARR(ZFHMIN),
@@ -136,6 +137,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZCB:
 	case KVM_RISCV_ISA_EXT_ZCD:
 	case KVM_RISCV_ISA_EXT_ZCF:
+	case KVM_RISCV_ISA_EXT_ZCMOP:
 	case KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_RISCV_ISA_EXT_ZFHMIN:
-- 
2.43.0


