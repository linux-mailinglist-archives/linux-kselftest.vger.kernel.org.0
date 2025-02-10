Return-Path: <linux-kselftest+bounces-26234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF35A2FA74
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D073A301F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 20:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F9250C05;
	Mon, 10 Feb 2025 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P+MOXZ/e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678425D52D
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219251; cv=none; b=aWja9dtZC9deNQfLbewC8m51WDcne0cjckY9uYWM17wIuq26Q6OrIhQ8/YVBbUoCYmSb64rzxD8G2bY5HHYPoh0ai6+9yqlPFPj51y3zUeb2f3VuSfMnVPpfXWbsvpynl8qQpo8NmhlMzvTotO7NUzoY49vpn+umVv+KP3w4K5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219251; c=relaxed/simple;
	bh=NmVWKk7RCdoTm8/kxl5H6XmDwgptfJerdilzp6YHjbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNJOD1EgOmP/8C17RlLAFR80yJneohRmZDGV1a0mid9UCjZJtVR4I/bev7fWkvuQ/nvVd/BDhIe39FKMYuP8aSwjbpbI9WtAHdMtCUA17o8Z8FLwVVuazAzvEz/X5VAsAchrFg1lJ8YD/FTBWJ7YHbxMbbf4EUEMkuFoARNffU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P+MOXZ/e; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f6d2642faso58717335ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219249; x=1739824049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEoq6zqSeLFMaXOoiuM7yp6ZSaKHVlNR4X3PvApIHRU=;
        b=P+MOXZ/ewCBOEQQ3PgRWhwMFXy7m/YkwALhtYvrVVVzozxwYXwirhID323RIFh2W85
         vqjoC4NX/rbn4nuPDdbnOXAHBHUPWcGRnooREnJp7dxZg96krfjR6f7hnUmZBZ2krWHf
         1nab+xxqifZnD+xo4LbJ5Fw/pMrGrtPNIeyrr/I2HnrWYprxlYSEzjG/bKwtxjo5s9Z3
         MOMKTstOqaxFfMlb6lU5cqpY2bjT1rPDhLTwRFzOiNfkO2cIfb1dCUTXpke99gbzmm01
         HZtjGAbEymku8yG/ceaHJaHRJY52Y4hXvV1Q7ZF83C2cLxGwRRtj4baLv+skbF16uUuB
         dPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219249; x=1739824049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEoq6zqSeLFMaXOoiuM7yp6ZSaKHVlNR4X3PvApIHRU=;
        b=THRVsW/+Mz7huN2IhraWPA5UV4+tgHgWT/RyZ4MdwlOLLsYq0c+3vE5ATOOOQ07djN
         tVME/BEebT5wV6YQgfr7xU+5nRDdfezafOky9aIp5gVOWbqLwO/uPwe2/9kbDmqzgB8G
         SvnnxWvNExf1WrrNHs8J9uQVxW7my4ThiGBd3RPzEOMh0XP44nId6emuWbDEb8fhnl36
         hKE2Ljr2gO/tv2tk1YqAtU/Bbf+L/IDZeD28YLy8YBMS6rgs43a9tcn+k7YTQUMg+H2G
         9K7fWh2xOq1ItnXNeTvA5SVHMM4iMxIbiVcMxnd0TBOeXZcQ/lZtyGWBw3PIBfNTxXPq
         gO0g==
X-Forwarded-Encrypted: i=1; AJvYcCVVV4lXdnIT4nxGf9DFr46BWQPsRDq4y47wbcD8vQ+inm+N5ctwVv9DJlCgqcKskf5HrApg3wEhPnTj6s4gxuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIhAeDOO/+TQSeY80Cj/YqiE9SwZU3yvapNCZRQ66QO90Nww2
	yV6E46rgLgUVA0vsVJdhHhbJYFl+oYo+rcSeLJJUY1tEl7/KgYKVpnr8YaWwRk8=
X-Gm-Gg: ASbGncuyCKUOpZBId4RHY2Ji/JjzOzLiE+/E2RCtcgcLCpA9x4s1GOwghf+tseCrL0u
	ZjF+v59KMcq3upUenB+6qxarxDnskkXxE5cC/2WpV79OMn0gA5fHIcF28pua3h+iOmiBx2qPVoy
	AbxVSFNBsmngKlrvowFjsU73BM2nEnAV5AO7mypTsTOxoeqikJgNmddM/LKuaaBhfo39wQt6Io4
	cY0oyL97n4ng5YAGTvUOkRVzuysC6g0tvFVlwOUIwn8TMjV4mQeK2IM2uDLd54ZppCfrdWn3yk2
	cJ0kF3fYAjVd4eOrzPrmMJTe/w==
X-Google-Smtp-Source: AGHT+IEt5F3RjsoBA/4cHXJN1Ltv5WX03R8vCEuQgHxCW+5M2vSetK20AA29/O7CLlddL+JvfC+2OA==
X-Received: by 2002:a17:902:d484:b0:21f:617a:f1b4 with SMTP id d9443c01a7336-21f617b009dmr211020025ad.45.1739219249583;
        Mon, 10 Feb 2025 12:27:29 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:29 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:52 -0800
Subject: [PATCH v10 19/27] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-19-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index c3c1cc951cb9..c1b537b50158 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
 #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 50)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 51)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index bcd3b816306c..d802ff707913 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -108,6 +108,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZIHINTPAUSE);

-- 
2.34.1


