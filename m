Return-Path: <linux-kselftest+bounces-29724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B870CA6E7A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 01:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4215F7A492D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 00:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F8149E13;
	Tue, 25 Mar 2025 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vzjgsISD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C384131E49
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863246; cv=none; b=ltlBVtBI62JRX3xX1UIZQKiBD8KHtr/lo6MCL4yqsyHErgecfPy+xdgz7DGQjmg0KIoPQp7EHEduQ0KEBHYZLlvp4Z8gIECwY4uE/ZPAVNlEqhT7owhO1TCix4zOlzR2EryZVaCzIOAEqZffnoHOBXdbXycYKlK2t8O663DdlrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863246; c=relaxed/simple;
	bh=UZcog3mRBfgDIVNyVqpr/WZMV5y7aYCguce1QWDBp+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sr6exaJWc8HZwSuv22uAlr+wJKTa/hGrcGnOXbOHz5y9Vuch8u5huZTXRM9n8Q9HJoTbJlOhwoAYly413ujwhABOQibb2KRQqucsGB54fBPVdPZdZ5VNhFlLAwnQGc2SJERHc0Kw1nnFwNOl3XDN7KT59fOtBckdEvBRKQUQKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vzjgsISD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2264aefc45dso84379725ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742863244; x=1743468044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkzfSG0KriYdqKt2ggB4CIBVtIx+E6Xmjf6eqJhLj/A=;
        b=vzjgsISDbS21tLEVJbOL79zwvgQWiJDwOw6Bw6dTInRioPpS/RdDNHDf9nsFw+8qbM
         tPQeX8boB5Ww8ueip61n7pb7t+e17uC8YQ36KA+qrso2swKeXJQdSmo00CAxqSOkCPWe
         aQjhDX/CVGQtkl0VywJcEZPsdzjdxJI/sGOyS+7GcRvU0AvXAhJzNV+16uXd2HLI0Ss7
         mv77MlF954f1/QBcnu5qBGNbh5/l1m8OC7/8WBPJ7EO3zQq04eAY1YQevcc6XyAbwfwT
         ajL/MsWhG4nWfCT1Dtl5OXF+6QKbXvpgZ/Pbj0hSYieyWV4kjg1QDblrFBD6PgUtXSXr
         yOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742863244; x=1743468044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkzfSG0KriYdqKt2ggB4CIBVtIx+E6Xmjf6eqJhLj/A=;
        b=w22PEiqXFeQuR5Es+v7PxQzTBYiqvBxE0hnInFB2JhhWFDs0M6+4L7RTZMQYvJxIW6
         ZfohnF1LszCBm9X4fBs/5wtegdyci5GTH0SoExL3HbfB6DMRf3cesk4tT2Nv2RN4nu2R
         YxfpuhAWJbcxf1kLoXscwVLXt4PAHcwKl0Vlo6es/fLGzIZVp4POk0lWXJ6tVQp0LukR
         e6RhqQwb5tMTe5WJx44l7qwn8RO1mgZFq9Iwu5lHPTu3FLEcz5e+Xa/RWXQ4mxQsQpy5
         urraa7davcA+KybdNi4DNPVdS1z883FKyFMlLvvQKp5n5/rqtxu253/o6LVhbim3O6DB
         yqDA==
X-Forwarded-Encrypted: i=1; AJvYcCUtUoCpdFaR40G0JQnLIRLhUaMkqFtYEiVdsXGtxcbPUFWFC0bgacqDCfh5pBuXEEKsU7Beq5iHuKfw7/jIA/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcAELORUzUz4POPACS6HKNDosQzX+xZHSIWU+/NVMJzC0hB1M
	Uaro4QvzhGbKujARm14H0r7wDSZiPo5lWgN2K+qTQYgd7DSrNVw5Z00ubZ2RDKA=
X-Gm-Gg: ASbGncvM80r9A1tl7aY+c+PaVSaspVqNxjjcn5vaLUo1tfGud37pWGA/FwmjgGnDQyi
	OJEb0Y4hiL/8PO6N6r9t4uL7n9ukxfQ0ov5lAW1PgONioX+FxG30AzIfbxO24LIGqxfST26WgTZ
	JsNvBzNU/PtM2WISXHl9tD84qGJmiPZ6U6q43XU/PmlrQpH6135z7CqeuyMO3Ibub8QVsXGSRNk
	cLpeb4em/vXfxdmcGI5cii6Ya0wHf1WT5w/Yp1HSrpSGIWepQYR6QvIjymMd8DyjLNYBd6c/WBo
	Z7OKW25uBN0jp1VbNa0D4bGyDgk7fmzFDtkELb45m3jzGUjULs2ylv+YkQ==
X-Google-Smtp-Source: AGHT+IHZo9yFD5wVvlHsZ2Ob2mdY/LteNi32aWoOs7e7aKFg5g40FhjpBRzw6PFwuzSYjgzfZKYYEw==
X-Received: by 2002:a05:6a00:180c:b0:736:5e6f:295b with SMTP id d2e1a72fcca58-739059b301fmr19822371b3a.12.1742863243652;
        Mon, 24 Mar 2025 17:40:43 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600a501sm8705513b3a.79.2025.03.24.17.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:40:43 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 24 Mar 2025 17:40:29 -0700
Subject: [PATCH 1/3] KVM: riscv: selftests: Add stval to exception handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-kvm_selftest_improve-v1-1-583620219d4f@rivosinc.com>
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
In-Reply-To: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

Save stval during exception handling so that it can be decoded to
figure out the details of exception type.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 1 +
 tools/testing/selftests/kvm/lib/riscv/handlers.S      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 5f389166338c..f4a7d64fbe9a 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -95,6 +95,7 @@ struct ex_regs {
 	unsigned long epc;
 	unsigned long status;
 	unsigned long cause;
+	unsigned long stval;
 };
 
 #define NR_VECTORS  2
diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
index aa0abd3f35bb..2884c1e8939b 100644
--- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
+++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
@@ -45,9 +45,11 @@
 	csrr  s0, CSR_SEPC
 	csrr  s1, CSR_SSTATUS
 	csrr  s2, CSR_SCAUSE
+	csrr  s3, CSR_STVAL
 	sd    s0, 248(sp)
 	sd    s1, 256(sp)
 	sd    s2, 264(sp)
+	sd    s3, 272(sp)
 .endm
 
 .macro restore_context

-- 
2.43.0


