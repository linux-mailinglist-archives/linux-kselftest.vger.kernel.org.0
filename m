Return-Path: <linux-kselftest+bounces-29252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39897A65A1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4793AFED1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5A1EB5FB;
	Mon, 17 Mar 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2qkOmLwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D771DE2D6
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231299; cv=none; b=bdDbzvqbON5ykWwK/bPoFyNUcZ8t2K4VsHA8mVsSSzql28SYtHtTsSFrrPG27RpxjmcWPuDO56xvfgcX8FJOUX2sRzApMt8ur65uJ/v5C0YyJ9of1Nxei9PRFbjOI3emPfzd5KAXm07APG0E5MaX4qU4nRAHSpS9pzgLiNBp3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231299; c=relaxed/simple;
	bh=URKzj8Sa7kgDDDlyaeXh5hfGFe5Tx1TfaYrSR/tVBTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehCDfrijztBDtpg0U/FQfk9amFqhx7P8LctTIP3walVJsRve17W8884nu9A/x9AI8/fREZjpTsmWiHx4xDCjvGDzoFJiFiz3BMbB3YOiZIPBLv9CMLjDLTLQ0F5JW/V3bkKheKC8xcA6QQsxI74P5hav2MS7cyhwC5BLp9qWPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2qkOmLwQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so24606805e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231296; x=1742836096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU7F+Sv/M47Pn2Qo6/tW45mjDMKI8ET1F5gpFniyHfw=;
        b=2qkOmLwQrpndyOnNnJY1Io08m3nA8cnKEb2BfXVs6Ma3AxvKvLrekN7O3SDY3HQLD6
         uDHunCw7HiilmZmMQVh2Z4+kNK4gzv+Zy9Nw+uEEnyFHuk6l6liVgE3la2MY/pk0xZeM
         q4Gef5+6Lvi/+kBpwQFYN17Gcw7NlkP+XK3KLeXFdzOE4xmkyuZn2pFTzYGNvLfE7pKz
         P7uA0gziGZGzLLGAKAnM8WvBQ/smwpXMKJrRhYtYNkSUQxh3JhxgrTKENnu4UpIfVhPB
         PBIbeDJ96LVwibmr31mrzcFVkbLSWedY73PtbknXg8gWBTwe4OL+SPRiTPFb7SZhOCPU
         1gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231296; x=1742836096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AU7F+Sv/M47Pn2Qo6/tW45mjDMKI8ET1F5gpFniyHfw=;
        b=h57QpBJ/oGyAAx5IIN+r+y76HW4VY1oVI7ADkPzCJJ3CvryYjwsOB6HUK9G82QbTHu
         spVYS/RMEM0Msads3Z3VuRdXeSX8r+8wi7z4VsGp3brzPNmtenhxZwgA/0ZlEW0SEuG/
         m48cqoA7xqPm0aUmPOB0H5JgtWpEYcKWOZ3BHH2glFIV0D/rm4SvNIKAwEbUG7YKFBty
         5jhRC1VjuyrMHpL1+9S4t0KHiXn+3Y9KtQ2ViKfiDsQmk5uHc199ahsIU3HkwSumEuoz
         Mcy0VABwcfIK7nz6/Rk3ovP5bufntMiWPyF/RXATQva1FulTrreBqNzIIeFMulk5Sx8w
         DF6g==
X-Forwarded-Encrypted: i=1; AJvYcCWZHU6Bw/JN6HcYdT7TOsYaQsOtxNiCtUjOUEJtAaxfJzh0DIs+f1lso94f7Be1j88HSCooMgAlrnpzQx3Ps3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7N1zWUa6f87vHgeCJETRRweQiENtrlv0OOodyaJYTCD66qtc
	DzG0S+BtV9tACO2c4nK46wBmwlQdXBNINm5VA+f887lAzx2t7za3p4kXXCVXnmk=
X-Gm-Gg: ASbGnctEvJw1AXNciqDkCtMXvAgqyU77ZgV2S6AQuMETSc6GkRhBxvIl9CwmsDOQ1Vc
	CeLA4xDIfyTwIy5CNcY/1u+q7cPlf9Wx7iuTTP7Z/q758bVIHawZLM3uZPfYbwRBNuLwZIz4V1G
	tn1r9lYrnEAnWt80nW266SUgdf49JObnzFBdg9kYJ7OUsOm836IMsifHsHUcyw4TEwHPbS8Hn7M
	oI97ppKTt+iUOSeu9+nGsZsSPIOKa2svwbVvzi+fS5c2Wq2/e7njBt/h9GbvGZ5xMApxOBcbUiZ
	M3xuVL/XhV17HYYCeM1Gz7TlaYSFoEhuPQrpilNMlqYhfg==
X-Google-Smtp-Source: AGHT+IGpDbXWpDYRUzGh2bTIaNirJTVxXi2O+kKj5FZQdCmID2IJ/McRsJVBPF2vymf5U0IMdZpfhQ==
X-Received: by 2002:a05:600c:3b9f:b0:43d:94:cff0 with SMTP id 5b1f17b1804b1-43d1ecd83demr128705695e9.19.1742231295702;
        Mon, 17 Mar 2025 10:08:15 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:15 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 08/18] riscv: misaligned: move emulated access uniformity check in a function
Date: Mon, 17 Mar 2025 18:06:14 +0100
Message-ID: <20250317170625.1142870-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317170625.1142870-1-cleger@rivosinc.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Split the code that check for the uniformity of misaligned accesses
performance on all cpus from check_unaligned_access_emulated_all_cpus()
to its own function which will be used for delegation check. No
functional changes intended.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/traps_misaligned.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 8175b3449b73..3c77fc78fe4f 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -672,10 +672,20 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
 	return 0;
 }
 
-bool check_unaligned_access_emulated_all_cpus(void)
+static bool all_cpus_unaligned_scalar_access_emulated(void)
 {
 	int cpu;
 
+	for_each_online_cpu(cpu)
+		if (per_cpu(misaligned_access_speed, cpu) !=
+		    RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
+			return false;
+
+	return true;
+}
+
+bool check_unaligned_access_emulated_all_cpus(void)
+{
 	/*
 	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
 	 * accesses emulated since tasks requesting such control can run on any
@@ -683,10 +693,8 @@ bool check_unaligned_access_emulated_all_cpus(void)
 	 */
 	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
 
-	for_each_online_cpu(cpu)
-		if (per_cpu(misaligned_access_speed, cpu)
-		    != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
-			return false;
+	if (!all_cpus_unaligned_scalar_access_emulated())
+		return false;
 
 	unaligned_ctl = true;
 	return true;
-- 
2.47.2


