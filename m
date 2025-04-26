Return-Path: <linux-kselftest+bounces-31713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5372A9DC07
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 18:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C317467C1A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3CA25D52F;
	Sat, 26 Apr 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/XbNTC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4A253F24;
	Sat, 26 Apr 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745683262; cv=none; b=NQ10LiLbPwdBU9++8NrEMrjB040gGwfEhzveIMJPnS3OekIU6McgfoiA3ndMq27kLdzrong3PXPWrWWskfageapB0nKgbnCEHPO4x6iKuW9qQcsAyBeUpalBo5EloWDJcDtK9G/TtLZu3DnRmRocmVHSDTkdFea+W/kvWFgwOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745683262; c=relaxed/simple;
	bh=7EA6hhpeHbVYqXYkZALdzPQEkiddr5+VhaiimhyaAJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kb51lrWP4JRzK3ynU6LU8ULAR34eW1Jyw8eOP0khZlz55Kjc6LXu1rHpAb17tfh7wxYpx36N5X1btlw9sIAru1Z5oDI70kUGMXY7EjAgqrpi5f9HUeJRmt4Iy4Bs5U+KHdlIfZo0HW3qLEDm+e7FcGuSk6mcwvtBG/VGxZGc6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/XbNTC4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736c062b1f5so2858737b3a.0;
        Sat, 26 Apr 2025 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745683260; x=1746288060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx9tLjJ69ao0Ttn6mcN/Ke4GGkgbccuSZK0yZYt++zk=;
        b=S/XbNTC406YiZu62DqDcrrqMZMErQsmPsQSRwbV0301J51L1V3kqGN4zaq4RQcyb/Z
         VPWULcTnKMiDlfsUcPIf5bSQ0NuxY9hcvKG8LcGknCKfMc6/I/YGtFYsl0Nfl4fZItLX
         tU3fcyd+FXX4hQyUpgCUFocTfg/VCVX+8/Bao0uJyoiD9WIrof64V0X7pjdarqNH0aUF
         BZuV7RCDcASwt+HfczIYR66lAkYN85mVkQ/exealn9aY1mGyurSGERzC7X60iFdLygBv
         KyILFnwf+rVKZxmjxvMfBvEfhpdfIngB4ru1L6QheO3ATXSH0KDgr/90amS5hBg2nVhE
         tVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745683260; x=1746288060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx9tLjJ69ao0Ttn6mcN/Ke4GGkgbccuSZK0yZYt++zk=;
        b=OBuY6lGQutdEPGuppIWycKp8OOIni78doM7SUIWADGQ5b5aAANRPcZ+03V1KXFv2n1
         3I3v0jhYDkdqgqg99G21IDD/hTQtZP7/TnRIDlQfcdpFMscX0/hpRV6MmhZG8qm1kwdW
         FF/eDTgg9LeN0XofGIueTROhDcRHfefvZaWZ3bZUfxV26PWq3W4/IPNg6GsoeA5CqfQ7
         zCYGGFIamDnzNit5IXZ9d82Q1qovBjGDmC1MqGj9a8K8vVklLR78AAwQJK+mCS3BH5LX
         8uZPYTjwOOXC5jpXrFJNBMvyWAACnm/C8j6VXUVOifXGwTT0bUQw6WI5t5ptjBsJXEwa
         m5AA==
X-Forwarded-Encrypted: i=1; AJvYcCV+9Cqzz6RtZqATCnoOhZxi/HFlLeZa8ubmyIjYth8B5QL3eyF0cA+nme1yFGcDtbsa6Hs=@vger.kernel.org, AJvYcCX+M58ontdwzN7Gul4DXjrPoIjj4P61atfWYNbuUsfs3GZ0wpL8V1SEhyCQeBQgmgghRN0v97eovLEqSUVnOJPkhst3@vger.kernel.org, AJvYcCXTkcnzohVz9pZptziIMIvyMV4HQhc4QTQrJgxqk1WSWlTFo7euV8PMt7P6bvodISXBy9DTjyHqfeWh93NnhXae@vger.kernel.org, AJvYcCXij7j/VcKAqrpttFT81NmTRDnS1tHyT1/Mit02ziLoOVuODeCmZDZjxLjieF+gN3TMt/+cSgSm@vger.kernel.org
X-Gm-Message-State: AOJu0YziBffLDQ8pY220cnz19Z2XyeY8lCxz3BLrky8xYZDaJaZ1Fn3Q
	vg4EMmIc1pR0NOzL5xAQyG9rZT9ljnuCGKqbLSsQDiW7XgRvhUsz
X-Gm-Gg: ASbGnctC0mfK3Pt/XpMav3V71OZkWn/7VJEgLgGBzuxDGMB8WpQs+Drmu2VuTMk+FIm
	rdSG8rQU1s9SGKfaHIxL63jymFC2MkK21x9u6DoFPA2YfxQYmhDHUzFZv52jHA3wjJeSKXRMeNT
	NeFT68M3Yp0b1AdfcJWoE2Ts4NauYbjCJOn/mD/kCHTPMIVxkDNxH5MIhoQSt3c5/ME9cry+EVG
	lUR19B49oVgEs/yUNMTurwiOEcP/aQ2/C89zRyAC5P2uxF1WFLZDcXPdwU4qjy56FJSN8z7yDke
	B1NPynktA6Hn5dWcATit8bF8otZkXBwLy2gYNPU6Kso=
X-Google-Smtp-Source: AGHT+IEDyzhR7wng6IWBJ4bIfZ/KPJ2uEby6DK0Yi2omYF4qz4F3oJwL2SznPWd7fMBKEjoTCxS84A==
X-Received: by 2002:a05:6a00:cce:b0:739:4723:c4d7 with SMTP id d2e1a72fcca58-73fd8e53d55mr7469160b3a.22.1745683259731;
        Sat, 26 Apr 2025 09:00:59 -0700 (PDT)
Received: from ubuntu2404.. ([122.231.145.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941cc1sm5174760b3a.60.2025.04.26.09.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:00:59 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev,
	mannkafai@gmail.com
Subject: [PATCH bpf-next 2/4] bpf: Enable BPF_PROG_TEST_RUN for tp_btf
Date: Sun, 27 Apr 2025 00:00:25 +0800
Message-ID: <20250426160027.177173-3-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250426160027.177173-1-mannkafai@gmail.com>
References: <20250426160027.177173-1-mannkafai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add .test_run for tp_btf. Use the .test_run for raw_tp.

Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 net/bpf/test_run.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8cb285187270..8c901ec92341 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -690,6 +690,9 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	int b = 2, err = -EFAULT;
 	u32 retval = 0;
 
+	if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
+		return bpf_prog_test_run_raw_tp(prog, kattr, uattr);
+
 	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
-- 
2.43.0


