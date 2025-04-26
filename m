Return-Path: <linux-kselftest+bounces-31711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581A7A9DBFF
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AEE923C2E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8031DED6F;
	Sat, 26 Apr 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsVvjLcp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFE8488;
	Sat, 26 Apr 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745683243; cv=none; b=kJAWN7IgX8haunInpDzJu53Us35ugvt6TsY3PUydlhUaCWNhkKo5YQpQFgAYhombefB44PsoXw8+9BKmyEJ+HgXkFkjLxpk8XxBTb193oDMaC/F5bJW3uNwuz7oEw+h4MxuXpD/h4XrbTDW/4EZHw0lxbq+r8Y/Rb7q7kdXDMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745683243; c=relaxed/simple;
	bh=wGwWAknTOCMxz0RPq8zv6IjjubENWlU5qOlxtfmR5t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bw1e9dvfXaYxWDgUHk15J1Fk+q/mXNTrg+Veu0MUqwIti8ogsvhvbCF3fW5k5qxWoe64k7snOyn/1camGMMWhGZwbUSOx/KqQSIeKdDPC4CZYLka0ZZKQCpPcRohfDyVGU3GVL8J8awTBsdM2Rh1EzVDSaVYNWzUvQebncyha1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsVvjLcp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7396f13b750so3723612b3a.1;
        Sat, 26 Apr 2025 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745683241; x=1746288041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znOdau2L+/dcZkQ6O6k0/5CeHr55iQYi/h0B2Jyxhy8=;
        b=QsVvjLcpUWuSmXDhdUa5Cg3pBT0j7m1Be3Ay0GK0Ry4rST89vNLbHjj0ix7WOSIx4B
         opqQT3A/o5UzNK74vpfnC+g54Motqm+E24ZXmZVpf066Nel9s5a0KvxSQYc24QfJaXFk
         ewaHWEs4leWsPCRew5PqozsWSjg6TMx9LM+GqHRVlhuZ3bMA8eZjvJahXUUJAmvseeiz
         TX0dlOZ2CYlJDL4Xyl33jc3AwbaDYh7/x1Q19mLXWY2STy4nJwyPFsO3NMsPSQ/cKKVa
         E/foO0auvQYkb5oUQS3TCGipkWCv/7C+aG4/aCSnt5Iw9Wz7U8y7iuKAjO8Y99Lh60Fk
         gH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745683241; x=1746288041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znOdau2L+/dcZkQ6O6k0/5CeHr55iQYi/h0B2Jyxhy8=;
        b=gRBbPx5PPyryQdRnqf8022gycSIjU4KvdG0CVJHAnM7hRA7hBcP0jSckgDEEJ3C8Y+
         1ZRXsv81w55KwtEH2Z3V3jN4U2nHFzoBSdrfzxPFCC4Ge2KZ0/UHhmhFnFZdjnZ1TFgT
         7OyVmpRE3L24Xq7h7BMOD3+wSoruWkyj82WinWiI+pDHw+lFMj16b/osVfbI61ONlfVM
         inadJ5ZUbrnvrJgzGkpyrjg2XXOXcYxzhOkwdhy8Qidx/Td4WFeAbdtooUGJBVDXXM8W
         NDOx6xNY9lTUxDu7AVogE6uhuz9WRDDS0XwkPo9UKJrD2l9PLCX2RG5GN8v4jUuYuRY5
         worA==
X-Forwarded-Encrypted: i=1; AJvYcCV1HigWYTBiSl2IsbjPMKlGm9KnKmiBaszJlwRkM/iKmBgt3ptokDCpnX+85b4K0l1O774=@vger.kernel.org, AJvYcCV9BP6HuAt8ToBI2+b8ENl5McLD0OhSA9mGdIhQQOGX29lu8y7FKmEQE8s4RWlB28QOzpUE6Aqv@vger.kernel.org, AJvYcCVrFMH4bMmoJ2CdFEx32xWNz4Paqktpk1OwB4CxsaWB4g5Dyg27MINW3QgPczaiJjCu4sUVB9tj64+CTSX5pQLQ@vger.kernel.org, AJvYcCX/+/IU54gc+EPU61Ljd9NzgSkN6Du9SmlBgP68BWbURITPvSWmAPgDSjG6kJ4MniUnq/jHeB2dqtKUdXd3NQkkVtLM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5A0I3gS5xEAGV6GAUi1t3Em3FkNbkwuHrjLCVMDIxd6gtWot
	xH/8I/kqPCBy93XFex5+92mJ6UR9qy28p2YDw4h8Tgjp3Q+tp7uo
X-Gm-Gg: ASbGncvFIxs/k6CiZddY2f75cuL/0oLnSjUGYYUxq0ecypkpoOmzuPz8oEJiqXmNeaT
	8BIgWFW6qd/GFFSgCqPeFU6VPZJiuabEaNX2/GgMbYf6uOE/8tcL3HL5go20blZwXpFmVEUEfrP
	aMcU398Bkkx2ESsGv41xpnzy1DbzcukvnwbPS6UFNY5jnosVYa8d/cdFW9GLzF21MRLKlTXV0Ju
	1VcDIFgPZ4TZL3tpi0Zrr9+qIPcF+GydA+sAEB+Ey7fVHzIjM+7SD7/8xwDn5CDcXndWZHgSenQ
	RPP+DPFiucsIlWfX7CT2JJGWie00/nK1wpppDuYv6fI=
X-Google-Smtp-Source: AGHT+IGcovqBau2DivQ0yh8b8PJpIgtx+uIrmZAQJE5XOKpzVaC3xkNekpOyApo9s2Jjcrh6mQst/g==
X-Received: by 2002:a05:6a00:1742:b0:736:5822:74b4 with SMTP id d2e1a72fcca58-73fd8f4e0c7mr8710527b3a.21.1745683241340;
        Sat, 26 Apr 2025 09:00:41 -0700 (PDT)
Received: from ubuntu2404.. ([122.231.145.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941cc1sm5174760b3a.60.2025.04.26.09.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:00:40 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/4] bpf: Allow get_func_[arg|arg_cnt] helpers in raw tracepoint programs
Date: Sun, 27 Apr 2025 00:00:23 +0800
Message-ID: <20250426160027.177173-1-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi, 

We can use get_func_[arg|arg_cnt] helpers in fentry/fexit/fmod_ret programs
currently[1]. But they can't be used in raw_tp/tp_btf programs.

Adding support to use get_func_[arg|arg_cnt] helpers in raw_tp/tp_btf
programs.
Adding BPF_PROG_TEST_RUN for tp_btf.
Add selftests to check them.

Thanks,
KaFai

[1] https://lore.kernel.org/bpf/20211208193245.172141-1-jolsa@kernel.org/
---
KaFai Wan (4):
  bpf: Allow get_func_[arg|arg_cnt] helpers in raw tracepoint programs
  bpf: Enable BPF_PROG_TEST_RUN for tp_btf
  selftests/bpf: Add raw_tp_test_run for tp_btf
  selftests/bpf: Add tests for get_func_[arg|arg_cnt] helpers in raw
    tracepoint programs

 kernel/trace/bpf_trace.c                      | 17 +++++--
 net/bpf/test_run.c                            | 16 +++----
 .../bpf/prog_tests/raw_tp_get_func_args.c     | 48 +++++++++++++++++++
 .../bpf/prog_tests/raw_tp_test_run.c          | 18 ++++++-
 .../bpf/progs/test_raw_tp_get_func_args.c     | 47 ++++++++++++++++++
 .../bpf/progs/test_raw_tp_test_run.c          | 16 +++++--
 6 files changed, 146 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_get_func_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_raw_tp_get_func_args.c

-- 
2.43.0


