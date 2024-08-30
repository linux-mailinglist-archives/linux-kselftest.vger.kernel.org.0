Return-Path: <linux-kselftest+bounces-16802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C1966406
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5969C284D25
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA61B1D5A;
	Fri, 30 Aug 2024 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHmConxU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74D190674;
	Fri, 30 Aug 2024 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027584; cv=none; b=j2bBlOw35OzN8zpuIL7V8xwE9hY9nMhpbkfn8A1SGBNTWOcCMz73J3NwaNM3GzVVfZr+g3kfO4hbEcnTHXFLWaf4fwD/sfivuEMQjBvFwqkH1ltQgq3I61F1/2nN5ojdKPQoouAFrA1OQiwwxPeNV8QFi4MY4dnNgsyRHWLvGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027584; c=relaxed/simple;
	bh=1e3MUgjgWXzRSJUuFDa3vTmsSIiBZyZhqGC/ySv1Zs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0g1OPZMjfuvqFwFHSXj1RgqHMwxqdHHUmn4WqZA9YlelDCwX9W7CRZE/hMJFzO3wjRI/K224+QeTopFVl/mAB7r36VPUfMlJhJCjDwOjhLYBfLkiAtnQs/oHzVWcU29aJCwAUAN5P9vnYHB+ZRJHYJSPmNGqrupmlBCncrV1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHmConxU; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e11693fbebaso1989060276.3;
        Fri, 30 Aug 2024 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725027580; x=1725632380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfe6zttTzVpVvtYCi1O7xaTd2TioSyAR6dyxSNkT3Oo=;
        b=XHmConxUbXfFodJLEHxFhbRO8XVVLR8wAtfLeOu1zTPKA2SykRGrDB2zgYkLWT6w3S
         qhgeX2R3L4gQVUKq1Lyk74ACtBc+OfAhGA22AfxPmYmm7Kja96EW9g95siwB973VJHp2
         chLQznAUDGyVccNz2PKe1a8q8h8j2Q02DiRyTN0e36kfCRgCIqJCBzsN77EEo+2RDWc4
         UoD0J/ltnR1sbmaPyAs3M+YJ5G1v0xvWGkgcjUPSST5CX13CkFThgZ6c5iuIZgqe8nf2
         +3a+G6+Jfx9c9emU9ET2lHd6CJwx6xXoS5Zx099nTbKMX1rzX6+WXJ2i1uE9CapXcOKV
         OCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027580; x=1725632380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfe6zttTzVpVvtYCi1O7xaTd2TioSyAR6dyxSNkT3Oo=;
        b=KrMX5iPfzYiuMnrVjAfsT6y9J5wOD+xRv1ResdzDEj5V00LGU/LgrCDs4hNV7wPT5K
         eK5k28DezlfseHHvoOTzX7+ElUfyl3fDREj8BX++HD6MRcv676bgqauieHdnae1xT3Es
         bOxjlRFP7pIzDKaKHu2D1OvQ338NDKOQWUa5pLQEARD+aQ2qC1dLp6Qc55KFZEW3itiY
         69An3MZMOMue0hSY7r2vrp3SBQSyYSjkMrtOKEK81un11/7liw1mHmPgyG8AaEBPmESd
         x5yVnOrfIzFGV2fdl1p6SDHq85qnHTpg2Avtr6gLSALlv1xengOR4w4iR84oiVuqChC9
         Wjkg==
X-Forwarded-Encrypted: i=1; AJvYcCWfyKEzEMR6MPO5A0HsAK05tBlHPb/rdAb6wYNBGgRHqwycZgePcT/OcP+Vxt/b79nuESTJoalz5Tz9RPs=@vger.kernel.org, AJvYcCWivzwHVXWaVrlNzhSRmVQl7RQoo7Bq6uYk91rVzPOVE5JyoQkXY1WfhV0kfAMIZfmPpqviPGhX0O8A9+XaweBf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Tn4F0AUVYi6lt7sOV49wHg34IpirKrmfSbuJXEHNhKt5OtmI
	buuqUZRT+E2CzHrlBd39GwX4M4GNYUOu7S976w/Awnt3/sZyjgPW
X-Google-Smtp-Source: AGHT+IHZanvw8xYvRCKZ/FqOO7F9+r86rkv4tVHkTpjrpQERdFvCnS7J1FmA83BAUtXTsB1YvHIxXQ==
X-Received: by 2002:a05:6902:161a:b0:e13:cafb:ceb6 with SMTP id 3f1490d57ef6-e1a7a17a9dfmr2811948276.46.1725027580543;
        Fri, 30 Aug 2024 07:19:40 -0700 (PDT)
Received: from localhost (fwdproxy-frc-019.fbsv.net. [2a03:2880:21ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a62682f6bsm617220276.35.2024.08.30.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:19:40 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: tj@kernel.org
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	shuah@kernel.org
Subject: [PATCH v2 0/2] Exposing nice CPU usage to userspace 
Date: Fri, 30 Aug 2024 07:19:37 -0700
Message-ID: <20240830141939.723729-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hahn <joshua.hahn6@gmail.com>

v1 -> v2: Edited commit messages for clarity.

Niced CPU usage is a metric reported in host-level /prot/stat, but is
not reported in cgroup-level statistics in cpu.stat. However, when a
host contains multiple tasks across different workloads, it becomes
difficult to gauge how much of the task is being spent on niced
processes based on /proc/stat alone, since host-level metrics do not
provide this cgroup-level granularity.

Exposing this metric will allow users to accurately probe the niced CPU
metric for each workload, and make more informed decisions when
directing higher priority tasks.

Joshua Hahn (2):
  Tracking cgroup-level niced CPU time
  Selftests for niced CPU statistics

 include/linux/cgroup-defs.h               |  1 +
 kernel/cgroup/rstat.c                     | 16 ++++-
 tools/testing/selftests/cgroup/test_cpu.c | 72 +++++++++++++++++++++++
 3 files changed, 86 insertions(+), 3 deletions(-)

-- 
2.43.5


