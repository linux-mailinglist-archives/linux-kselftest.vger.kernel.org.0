Return-Path: <linux-kselftest+bounces-46878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A5C9BBFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 15:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F583A73A7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF07A2192FA;
	Tue,  2 Dec 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVQNfwkS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29D2101AE
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685199; cv=none; b=dFJUZKseklhv663H4Fy34HemdLfwq4Zer++UYsCjadw0K2hOX9sY9acmP9tfJ68PK38+B0rHOHTpWMe1rQIwHJCM/xKfPfm+sfzvQzncl6lSzMgfOpIgPGbuvAcwFMhIWV0WJFV3A+ZOMt3wE1RqiU4YGGDLyBah1Vkj3vaMbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685199; c=relaxed/simple;
	bh=TvhO8/wWsryTXGAN0owlp5rKTKABTyepxFYULy3W2mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSkuFN5rxsvy3NH5cc036DF6CnsedYEr6r1JEcWJLHk8WvGl7InmXm9lFnapW6MwIW3HiO4vtmCvhMAXPrvrkCy6xglLz5rFlaggFwbOdZGgyayGkHItRPeFNaFQ4XFI04b3YqBe3071Jry6qvQzLdV29c3vFNpo0gYrfehTAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVQNfwkS; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6432842cafdso4982036d50.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 06:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764685197; x=1765289997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZYiG845U9rknD0u3O9bp1/PvtZ8OwPH+UQAfLpgMIw=;
        b=IVQNfwkSQTVE/cj/HGW3SAvX2ZCamyuGLhFtiFuage7RozWddsEOXUfEDDgQzzJCsC
         /IYhg8ziRD2jvu+wcokxqSUaP+ROWGJL6MFEQpabuZdXR6TgHYZp4D9idQYqw2qukBfv
         cYmv0E54pihH6GK6dwn4NXaisBOPkVJpvGUmvX9rKMV+tRo7HWejyjtZHUQewniL/k+J
         k4KGmuYyWq5z+Y0D7gaCxQ5ngx8QY5KiwNtBjRakhtvj5XpmCvVaL67gqkYJftzLGN/F
         8Q/Tgx9zK4YVyR5wEryhItze4uAGhmlrhSoIoX8XpmlSXpLoVldNAM1tmEYwNMgApsSF
         uSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685197; x=1765289997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZYiG845U9rknD0u3O9bp1/PvtZ8OwPH+UQAfLpgMIw=;
        b=RJbmYX58zTuAC+X7PXGi5oJQVBfXdt9qYOlXlEe6/wdxz/O9Na2ncBehqngNh4iX4I
         ufbfdlv0H4PpI14vSqj04B+jPchgHgvDWnfNSmtJVFjt16j6CATPpfOFIL13/aOWcJQw
         J+Te9NvSqzQCcwQKRfrF3+Qy2TS9YlI9jdDbdUBDOtbHopsv1USk69bg8wY+jp8SC420
         h5IZFXzHXTiUi8FTDRtdNtAOEg05utNMFGmStSOqSDqhcK6XD3AtkHEJJxAV7LzT1BzX
         rMhnsEXXHfVzQWu6jRtKjfYNAlI2UDYv5PbxcsGE2z/pfrVlEyaYMG5AB5fFgiAE0KDR
         7CaA==
X-Forwarded-Encrypted: i=1; AJvYcCXAnHwOev6+XmhAPwVEzpIffASi+EqTxYiFSOHhNDLAqQlJ3rGpsOkyLm9zP54luxFVW7OZa/gMHfrBi6HWc5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQnvqUviNiGw0T0HVamQC9XF5UmtN2atuSTtxNhlU1ejwSkVD
	on5stZgw9767QP/hBZutFl/roY4UHaLIb7aZGSqMUQFnCY8s0ZiR9HSz
X-Gm-Gg: ASbGncsQ2MtPu4++c6ch91oNubpBkr4cyM1eRgDDIVb5SVakqTydoVoEPLtztstN8ly
	wsj1eIway1mPfoCqrhmtLZa6lTRZ1zZdMTkh8+eLnP7O2Fu4Sk2gmuD4w9ihbvwVy2/viXVfU+I
	bwpWVLW78uOSvjPfZvCHcMWESeJM57/0P7dSvKw6Ruuv/FjXEuAWUZz5s54bSr/BT+bXgCnIqnV
	ufuwLN1Pc4Ep1vhcaN3N+8J3kp0lScwgoSvtqsKkIqfeHFaTcmoRPAE+KYMUDIY3QPBuWCkGfgj
	a2NvNyIDqyN0GoQCrzMAMMSVmPYjLVAscjR0EVLYgMn8GZAcmjMoQGAmtzvAr6UmiJt4CaT7BCz
	IFAQWrMmJFsHDXsaLVVT2G21VDWPGKMCd3P/pF7PH/yzMB6uOr6MptU5+mvkBMShykMQF0O/maQ
	ASi68hZNyKQNc83IYchPfAzEVQZwiEHJH6W1MU3JZsWlrhKO4m8tiL4+GTBkYtLQ==
X-Google-Smtp-Source: AGHT+IEBiHZjjwJYZm4wcRsjMQxrAiRlrUNXkeZHkzrztMI4TVsP7sWW8UWzi8YGWUgGsSgqi5H7mg==
X-Received: by 2002:a05:690e:12c9:b0:643:1a78:4492 with SMTP id 956f58d0204a3-6431a78497dmr23565216d50.81.1764685196722;
        Tue, 02 Dec 2025 06:19:56 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c497768sm6257715d50.25.2025.12.02.06.19.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Dec 2025 06:19:56 -0800 (PST)
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
Subject: [PATCH bpf v3 0/2] bpf: fix bpf_d_path() helper prototype
Date: Tue,  2 Dec 2025 22:19:42 +0800
Message-ID: <20251202141944.2209-1-electronlsr@gmail.com>
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
regression test to cover its use from an LSM program.

Patch 1 updates the bpf_d_path() helper prototype so that the second
argument is marked as MEM_WRITE. This makes it explicit to the verifier
that the helper writes into the provided buffer.

Patch 2 extends the existing d_path selftest to also cover the LSM
bprm_check_security hook. The LSM program calls bpf_d_path() on the
binary being executed and performs a simple prefix comparison on the
resulting pathname. To avoid nondeterminism, the program filters based
on an expected PID that is populated from userspace before the test
binary is executed, and the parent and child processes are synchronized
through a pipe so that the PID is set before exec. The test now uses
bpf_for() to express the small fixed-iteration loop in a
verifier-friendly way, and it removes the temporary /tmp/bpf_d_path_test
binary in the cleanup path.

Changelog
=========

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
  selftests/bpf: fix and consolidate d_path LSM regression test

 kernel/trace/bpf_trace.c                      |  2 +-
 .../testing/selftests/bpf/prog_tests/d_path.c | 65 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
 3 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.52.0


