Return-Path: <linux-kselftest+bounces-46974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D97ECA2AF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 08:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 140A2305A3FB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 07:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBBF2F9998;
	Thu,  4 Dec 2025 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYGpd9Gi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3D301027
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834420; cv=none; b=X/M3vJYxSg/303BYDb/jJL2mh1CxCHrPqINoU/h13J71z9vMualGjHsB1KgIKAR/I6/aPci9fmIJqG5TcsqRuHqyPGQPEnvno4Srge8lXbgupKWj/6bZeJAnXtGJCS4ZD7cO19h1JySG7/FKt1rw2+RlvRwe2DKu83FQmaqbPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834420; c=relaxed/simple;
	bh=80SRJuOgcTTOlotUZtwxNq10fJ7vLgfVquViWgwDO0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNErWeHcmlA1Dmz34XGRBL7VI6lw/jsv7tFelZgw1U8rItiG2yJw02G4X9ekkk1IfkSr7j78/61r9R1sRHofmDr1UiCN+EOpWOrkPrhTCESjGHvW6QVm/iivUH1/94vHTjxRlxEVHCN4NguoyTKqYuRw80ixuoMSmcNVmIabn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYGpd9Gi; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-641e4744e59so550005d50.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764834418; x=1765439218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64al5XjBckKJlAGYWOzuZ9pNtheivLV4ZpzNmU/B6No=;
        b=VYGpd9Gi9+XUN1o1QF1ftGMaiBlY7c8AWMnkdyCUt+KEXYy/h+27pTSr5l/VBQ9P9K
         BL4LQP2mxLgWUNAAtxZj2ad+cVfRCXs5aYOhBuoVcd9wIFPzJvt4DoikNjyFDjKwqq/u
         TBTtJKolDpVgyWgTXONv2CUme93uYgj1MArdB4nUAtwWG6vCyGgIEidQ+9wBRveKHxEd
         lTSjmX9vHn/zWdkCqUsZxyimK+6i1PIz9Xv3Sf0q8x58XPd13++e0gYtX1jZjGsKdGcN
         sPTGyK0QfroDBZhZm4gSG6BHL0h1wrpTTQKHuEKCAmNu13Osne2oplw1cXSA0fzIfDbI
         w/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764834418; x=1765439218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64al5XjBckKJlAGYWOzuZ9pNtheivLV4ZpzNmU/B6No=;
        b=fqRxKduIjQKelIN4XrAHQmK9g21mtAnv/2wbt8Rc8zWvesF47pRYTIlR+yNAoLCndz
         p0AL+o47NpIT6aKiHvGvDVgIdUFZ6UKB25TDfwJeqDrbdi37U5I8rHr/2KNEDqF/p81N
         +wrbwZkLlG3gyEKlpkGVyGx/kZaqF3nyDpSA9rV102McHiOl3gcjw3M7FwbTfOPZhoG1
         5ZHlDgL20QLX1Ae0VptYxyhyPqvFVLcedzHYO7wbgkTf+zqDQlz9RK1YoXzUZyx1zws1
         g8M/+FJFsmzn14X3104Rw3WxnxI1/1L0u4tYofFGCHC5NrXh2Sem1oAPavt5sYaBfULj
         +fYg==
X-Forwarded-Encrypted: i=1; AJvYcCXOjmquoOOSiDd2vLJJm+eAbxclikaCG76/TI6PZ3rq0qaYRdxjiLzZr3GRbv06v9PIuxW9CPP1XUUbvYTuKpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTETyZNuxp/Zz6GTpmNVoDqGs0XXeBtahgteSAfStgrEKhvws
	iDnjsJ61J+sRYu6D1SAMePGM4CTy1u9+UmCohhF0JXP2nqBLSS396DV2
X-Gm-Gg: ASbGncvnZhYFg+J6zbGzERfxSDFmssvsvAIRkALFib1uMh27udKHjEqAv0lDnrcgAA8
	VE03rqdl2xjmMXGGl5uz0BTGfYJKOyi+uXMGLZBCQ0SrUjyYvusIda2HaeoYp5qF+OEuAiRLZjj
	1aFxdywHubX8faMVabMq+9peT9SwKse4RD5y2b3xTOrf4jpo6lEwHXmHeMsFsawYAJhcM4UNkhA
	6hxwRwIfFpRj/xQkA6uAn7Os+wfMPtq2aBRxON1UWTyxqvbowkYCPpi/dGGOavvKDlC+L7Gg6cv
	ov/bIp3iV1FFAMo2+5C+umwCfBvTCUFzKnUr8V5wzbsDNWIfAoRg5PLCY+YL56HDHigN+10ahFc
	SzrRSHsbLodk+jgWqcSVM3kF05SV9Sr6uibVjbl9q+mycZrMM0r4MfMEdvLOW7z4kHR2XBhSY2t
	sG7BHtt7yfXVE/vuX/FZXZOFnlCnZIXBM0Qt+t3eRnESVnRl4kdxs=
X-Google-Smtp-Source: AGHT+IH9QdNew3zKd3MAg8XQ76QMKfr9y+L0i90gdPpGFMiV8Q8w/KZTKg3m0AoyZ7lPvAh4HwpkBg==
X-Received: by 2002:a05:690e:4101:b0:641:f5bc:6981 with SMTP id 956f58d0204a3-6443704bc86mr3412127d50.77.1764834417911;
        Wed, 03 Dec 2025 23:46:57 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5bcbbesm364495d50.23.2025.12.03.23.46.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 23:46:57 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com
Subject: [PATCH bpf v4 0/2] bpf: fix bpf_d_path() helper prototype
Date: Thu,  4 Dec 2025 15:46:30 +0800
Message-ID: <20251204074632.8562-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a verifier issue with bpf_d_path() and adds a
regression test to cover its use within a hook function.

Patch 1 updates the bpf_d_path() helper prototype so that the second
argument is marked as MEM_WRITE. This makes it explicit to the verifier
that the helper writes into the provided buffer.

Patch 2 extends the existing d_path selftest to cover incorrect verifier
assumptions caused by an incorrect function prototype. The test program calls
bpf_d_path() and checks if the first character of the path is '/'.
It ensures the verifier does not assume the buffer remains unwritten.

Changelog
=========

v4:
  - Use the fallocate hook instead of an LSM hook to simplify the selftest,
    as suggested by Matt and Alexei.
  - Add a utility function in test_d_path.c to load the BPF program,
    improving code reuse.

v3:
  - Switch the pathname prefix loop to use bpf_for() instead of
    #pragma unroll, as suggested by Matt.
  - Remove /tmp/bpf_d_path_test in the test cleanup path.
  - Add the missing Reviewed-by tags.

v2:
  - Merge the new test into the existing d_path selftest rather than   
  creating new files.   
  - Add PID filtering in the LSM program to avoid nondeterministic failures   
  due to unrelated processes triggering bprm_check_security.   
  - Synchronize child execution using a pipe to ensure deterministic   
  updates to the PID. 

Thanks for your time and reviews.

Shuran Liu (2):
  bpf: mark bpf_d_path() buffer as writeable
  selftests/bpf: add regression test for bpf_d_path()

 kernel/trace/bpf_trace.c                      |  2 +-
 .../testing/selftests/bpf/prog_tests/d_path.c | 90 +++++++++++++++----
 .../testing/selftests/bpf/progs/test_d_path.c | 23 +++++
 3 files changed, 96 insertions(+), 19 deletions(-)

-- 
2.52.0


