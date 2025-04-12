Return-Path: <linux-kselftest+bounces-30639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B77A86E40
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 19:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FC0171E92
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EFA1FC0E6;
	Sat, 12 Apr 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ1mI9Ha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6711662E7;
	Sat, 12 Apr 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744477599; cv=none; b=fXJqCwv0ecrKKgQ94FiczfrW4SusdAg65kta+VZs732xLmris9K6ZkRFyXjHIuUP5Y2tFG3Y3dRKOPivoEJhFciLZPzDR7BukA6krATuArCQw7qFUQtcoMBAD4p3Y9pVEa7vGYdGW+zQPAB52iKXUg3bgwPRwd4vLJS9jiZU9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744477599; c=relaxed/simple;
	bh=4M7MIAR8fg1JNtgZTxQ7Z8KhaeG1APh1tXeqKA3NEvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uf5q10AvocRGeHTVBClPKkMEs3YkO2+l4ub9juedjIinTfM5iUwfQuYqjkp9z+vSTZtWJ629RtirdB+X18pI2/zWa/yRyqpJJTDjcMOJ9HSivk8ALpSZS+F243XI6XtaCRE+v3503YTdSmUsRHVJuXC0BYUCMK9y7nkl+gtEYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ1mI9Ha; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7399838db7fso2950675b3a.0;
        Sat, 12 Apr 2025 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744477597; x=1745082397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDfkpLrFjXgARz5gUMVb0iGct0QwoJRyYU1szy4WksY=;
        b=BZ1mI9HaBvy7eXW4HMqINjpYT3MFBi2tFpDMTPlV/W4sbszc22kv6FbQ+9iR4hC6ES
         nmeDw/k6uyFhtuwxg9tpKtb/yllCLsQ0LWApqOJzJ4BM/7FXEyAsF0Pbxka5UiiCDAbw
         m9LcNsop70/tJS6xqf6kx3wm6VdaWhmjBkvZdJtWh1NNXCDlq3w+kFW259frrWOeDmZx
         S7KowkvZ5Th1OEY6LmJ9uOM5HA3eR1Jr92vKKT/r8xDSBuqP193JSTWk+7oc6Ck61NR2
         9mp2lVGuUe3Td3jY/ZQaa+ER+8vxOd9zDX+kEOKrTW9Y7CsHNq69AJ9e39DDR4PaNHAM
         JVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744477597; x=1745082397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDfkpLrFjXgARz5gUMVb0iGct0QwoJRyYU1szy4WksY=;
        b=MqvRoRX+G4IGXcv12IE/ouTq9fiSCVj35RFV3oREF0stUAWzo+lbWW/NRlCxys37v0
         8Ff+lLteCdRT7cc4gpDrVGOnQJOZAn5BXGa0NoTjgRsi/aZQDc6FzpogOMIPIQAY9PTH
         JLd8PdLib/PY17OSTID0Cai3QTYHEey6FueQkJzCGW42wKSqOOMU7aZckzButvyWqDto
         L1za+fxAG6+AJiQ8Vd/QYQ5wDj9ANd0Gsrv0jATMkOebJd7gWb8S/xTgO7JQReraCtSk
         7D5pfYncUtdhJSPGOl3T3MmUIT+xmTeOuyXzfuzRCfDnlDeNUwLQBjRnjFBBb9PxG4oE
         LRig==
X-Forwarded-Encrypted: i=1; AJvYcCV9SnigoVP8zjrVuH6ZB4mStsRc98YvaRn6s1hs0C1u/0JuSMPjh6MgCx7/YVn0GVzeeTCfbt7q4gaDQiLGCAJm@vger.kernel.org, AJvYcCX53eDACOKGz3si63FMsrk8wSeDc5YdJ9p+z+/kj8LAUpIyBIE8+QPXQzvtu6GKPshKaqmM0D1cwVVooXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO68iRPphGUa28CSuUmiNpZUeb9AMEiAbHPqbU3qj5VwPfjz3D
	Cmbgj3ezDQxqkK1VnkCArtHvKcxHhNRY8yMyTndniT/2HWOFeb9f
X-Gm-Gg: ASbGncuyXLKDzvbKhvzzPcdjnnF1xBemcab/6/HiXUa5QyrjalYuP+1FxiJbKwhEE+X
	CDj3Y7AsSn7SX9PSJD4t6OxnMCZiFy25MnBNxN/BqGMid5p7EnO0wPkIRMajpEZAiKPzEuLoyZq
	KBiFZkvd8oA8phSmdsbrZyqxVMXvRKfrsGdSjcvS/QDsTGAb8i+qTmd4/FjfHeFxnb5kszVbsCj
	0SwUxWVB3FQIyCKTyCH9ri8Ct5Wb43Xz7PrEfEtozkDePzkrPH2Vxaf8+XbQuPS8VROIrkuou17
	DfDkufKOOc+8oGKHTqxK4XjBUp75eU5OqpLpNSFDnBpv
X-Google-Smtp-Source: AGHT+IFmHTbrhMwLyhHd3P9FPqMobUomm6+KomqsrHzvH8JYKaw49WhnpAdB1C+A99DlziEO5YWqng==
X-Received: by 2002:a05:6a20:9f45:b0:1f3:26ae:7792 with SMTP id adf61e73a8af0-201795ec5cbmr8837115637.18.1744477596779;
        Sat, 12 Apr 2025 10:06:36 -0700 (PDT)
Received: from ubuntu2404.. ([125.121.98.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c20f3sm3610710b3a.39.2025.04.12.10.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 10:06:36 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
X-Google-Original-From: KaFai Wan <kafai.wan@hotmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kafai.wan@hotmail.com,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next 0/2] bpf: Allow access to const void pointer arguments in tracing programs
Date: Sun, 13 Apr 2025 01:06:24 +0800
Message-ID: <20250412170626.3638516-1-kafai.wan@hotmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi, 
Tracing programs can access arguments via BTF [1]. Currently we allow 
tracing programs to access pointers to string (char pointer), 
void pointers, pointers to structs, and int pointers [2].

If we try to access argument which is pointer to const void like 2nd 
argument in kfree, it's an UNKNOWN type, verifier will fail to load. 
typedef void (*btf_trace_kfree)(void *, long unsigned int, const void *);

[1] https://lore.kernel.org/bpf/20191016032505.2089704-7-ast@kernel.org/
[2] https://lore.kernel.org/bpf/20211208193245.172141-1-jolsa@kernel.org/
---
KaFai Wan (2):
  bpf: Allow access to const void pointer arguments in tracing programs
  selftests/bpf: Add test to access const void pointer argument in
    tracing program

 kernel/bpf/btf.c                                       | 10 +++++++++-
 .../selftests/bpf/progs/verifier_btf_ctx_access.c      |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.43.0


