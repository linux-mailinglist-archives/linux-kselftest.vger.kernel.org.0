Return-Path: <linux-kselftest+bounces-47224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2FACAA843
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 15:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10B063011317
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0382F239E7D;
	Sat,  6 Dec 2025 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifc/rVTk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515332868AD
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030351; cv=none; b=rNmypFLOPF1NpJ11mjc5VDUcq+MGztRfdWJE+kdYJuoMufaES9VDbwdxs5St3PLmsQa+rnDHUap53I5bEu4flo8ZxFAzH+CRm3OOlElVPCe3pXNa5qRUFmkMjf8qd/LFVr1/0ZjJBUEKTi0kk8KmrkhmCPFDZDpTaEv21e8UNN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030351; c=relaxed/simple;
	bh=ZlQkzCF1C8y3eJv+vkyc47wyu4GZ27t0Z1J8dCFjLW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODVnLMY1mIzO1s7dizjyS3d5iFRKWG1cmy4toGeemjJacZ55jmQfHp2V13X5/HqMfhcPsMR0mmek+3r8viOEOzDi/K19LwwtKn1FzwBr8/4s9GQdeyNOMnJ6acst+jgDMitcIRtM9ORwqA6QNB5WpeIP7F+o2Jbp54AuBo+lOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifc/rVTk; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-641e9422473so2598728d50.2
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Dec 2025 06:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765030349; x=1765635149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+Zmv47iVrnahLufmZFWkL2mj+W3enGkIKbG6tGkYz4=;
        b=Ifc/rVTkV8O7dgXCkR3xclpEavYlOXQ4YhBEOFjfXUyAQAa4CCEC+/T3hY4FdPu3By
         0QPA7lzrU7xjhZxn1uDdHw8TIrxSc19+HpPRNv176oLZWCIOkXS2txEB1fzModCAzYwC
         7QBmhX0Xyb3PYqH7BSn42L33IIzv5VuXPrHEjTpCA1xDt51HNfbjrdnFkx2T0o9eZ6aY
         qmjGxZL3nlWqeMExYQ9A/+b/mlJLjTBc9r2UrXCKJalCMHZJSkA+z1/YJ0flD3H7dXJR
         qskTNNY1Jg9RIPL+pP0CUO5QxfP1dVLQtcv28PF06UKKMuXjuc7zjCm1t9zDgyMllgLF
         upgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765030349; x=1765635149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+Zmv47iVrnahLufmZFWkL2mj+W3enGkIKbG6tGkYz4=;
        b=N0/Ksi/zVyzCJHX0kKAh7ZoUowS2SiWQqXGdXZ4yzp6Gi97AiAVqIASkq7gUesJkH0
         FQX0X3i2oFpoZ9ywRPGHw8hvXpur2aAtwHdSGdtbXSF3IXqQ3mzHnowhEFW7X8MvOyVq
         kvJG8mMoAQQQ8bibIVBrfRr0kxaWtpfdH8HU2dfo+uUU9hg1Z830VTXow0+5JFFlKmsZ
         iN9o0vr/wcMGntQwcIbePGfHPePuX1qQEHRMWWWYVMZtK10HLLmAmMvw5thsChDayGhG
         Chy9w9bABEM29lHjxJlQCLJ8rTDvffO5Nng+VOir2iqAeV58Krwn9LXefHQVr4SdNH48
         OsKg==
X-Forwarded-Encrypted: i=1; AJvYcCVED8eXhnfK2PvDrLyJunJb77WeeKa4+MY5XSoFOezY5Mqqcnz2d7mAPxDG/ifFWiEzyf9+9J1jhu63vRF+qE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBIQs+VCIXp5fttLE1CnyN5XtkUkws9mxOfszhwFHutWA0uAb
	m+xAy2cP0ObRqYTXpPKLtJQBXoiru+reujAgjERXhxF9JaKsAaWIf0Zu
X-Gm-Gg: ASbGncvgAVW8cLBEJAf+Ek7p18Tt3PS95ZcKzRNKFtiCZBxY5Gcc29obDWYwE3AJNhC
	cu6S+P6yIzDyBhi14URMogAHeFryVJgvpSe+1E0MezkiM7zCpzEUa0Ei1aZyOIhHSip7L9sxg5L
	Rqg6pPfDNQPkymiUQPTFQap5U7HtAAdTGGut0Kr5Z7X4Kafh6WC9Z62zeaG5fOyycxg/LnM5vWI
	YRxJ6EPw9YdAXCiuh+zt0WkLfSfuWTOPwMXTVAZBT0nCB4JgX3W39+5Brs6guRgAre0SO9mxKmK
	ZsiZmpPYIwW7NHsJ3xUcTcN2D6MGiJDtKzixY+XxikWuWBZKDgKOdzoZF41RPfkkfguPZREeNYc
	HEpjqPJxG4DpC18+kxtcMHI3wWctuxB8zFtRCRhE2il7oEe0F7jB7JfhphOzsPj5EZiv5ZjcZKa
	pTMH68/DnbEiqhTwbXRk9EJaoJt2EnTLKdle+6KMTLnFt3rs1ym98=
X-Google-Smtp-Source: AGHT+IGXT/FkBsu1rpLHAlAmny1mLfVllU0DBntkMVzmVYn+VzFmM0k1kwwxMw8jnzlc+lU/alw6kg==
X-Received: by 2002:a05:690c:4a02:b0:787:ed2a:79df with SMTP id 00721157ae682-78c33b1ab52mr45455537b3.10.1765030349217;
        Sat, 06 Dec 2025 06:12:29 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm28038027b3.3.2025.12.06.06.12.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Dec 2025 06:12:28 -0800 (PST)
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
Subject: [PATCH bpf v5 0/2] bpf: fix bpf_d_path() helper prototype
Date: Sat,  6 Dec 2025 22:12:08 +0800
Message-ID: <20251206141210.3148-1-electronlsr@gmail.com>
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
bpf_d_path() and checks if the first character of the path can be read.
It ensures the verifier does not assume the buffer remains unwritten.

Changelog
=========

v5:
  - Moved the temporary file for the fallocate test from /tmp to /dev/shm 
    Since bpf CI's 9P filesystem under /tmp does not support fallocate.

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
 .../testing/selftests/bpf/prog_tests/d_path.c | 91 +++++++++++++++----
 .../testing/selftests/bpf/progs/test_d_path.c | 23 +++++
 3 files changed, 97 insertions(+), 19 deletions(-)

-- 
2.52.0


