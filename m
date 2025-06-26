Return-Path: <linux-kselftest+bounces-35865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D985BAEA300
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D731C4422A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98122EBBBC;
	Thu, 26 Jun 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn5mUtat"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF62EBBB7;
	Thu, 26 Jun 2025 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953202; cv=none; b=YaPYDx0DIbQHKhf/uzhc/a9uLvXHDBYfz3bfdg947d8Te1vhy1RDVcxqPdU7fnZvASAoNW/cl7L/DvCD5qRVVAHKNd4M2aYDV/HZLP5SD5eoKIP481q9haoh1S19lo1KeBq+Vf+0egMMjVBkifp1UehY7VEJUCNhz6ffD2IDOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953202; c=relaxed/simple;
	bh=e5jne99j/PjgMC8iBi5xVdZitnL5gRo9pNSlFrlr/bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHk6UpaFZXq7azN4WvSrTuTRFommQSZaMvm1hjQlWf1v4RAAH1lKZgdlbQ5SvUPjUV1bzxKj4KHLi4kPikKz+nxL9T36ISVbc4kvRkK009ynq+P4kpXYQlUxcIHOZjU/9D+6Q2RRiSJeJFoK7oUCRIkKgskEy7Q4r0W304BGR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn5mUtat; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso5735825e9.2;
        Thu, 26 Jun 2025 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750953199; x=1751557999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85LSIRMBS4iQhNeyJfvZAHlKe8QbguEfspE6yY9/H54=;
        b=Fn5mUtatCqwFBOxINK+fOXALEazj2PW9rLu3jr6ZfIkEn5B2SIZU6wLZnd3mjHmfX7
         zhihFwqvr+MXXgB9pKCVjv4bHlNNqsk0IvUXEzZnFC20k0FAhofHbwtZe34Y2X24Pta2
         sp8HSJR7r2q/H+LQVuVpPV6kxc8cfMAUH5T/0sx8Fb2JXHnGspMduFuqZN5IqV7oiUnm
         gFaD1mXvUrxhU4XCUYt5QGvlIa6vKdgV0RXL6Adaeu69HsAZKTzOw9qLElYVg0py3BZS
         CMjmC6X5gEO8AInxc/jGC8/ydzhwevpYnGqdgT7SnLDyBRYctsg+gl6eig6ijlLd4sGk
         n+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750953199; x=1751557999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85LSIRMBS4iQhNeyJfvZAHlKe8QbguEfspE6yY9/H54=;
        b=Gb4ZHLw3sf9Alf1ifQUSSdVA763KKt234vJTtNudZA497dl6ThaKtQGpLrmBimccQN
         Ri4qA0o+ZlpJsuVazXaRiGTcZJQQYrErVFjWEHUcBGXCEd4XlKuHEj2CQ8VIWCOXFWZp
         BqlwTioXpUOByMY5zvxBEJWBAPAdPq+aM4SFDq3U7BopxGtvPirl4USrec78XKmL+BYy
         bY4/aH+BlJozUALhotg1eyoVqGmrmGburDs7DP2XSG0nb6abr2c9yPqpIwaH/dUOrJfZ
         z2/wUjbWFn+8LAp0JbPQLFGXKWQQ5AHej6O9+XUJMEvqmpuPWp3a862++9PMjyIBSB+M
         OE6A==
X-Forwarded-Encrypted: i=1; AJvYcCUrFar7VjKS78NVwM2tM8VQT7Lg0jYVpo6G6vC5gXjzgfH3CKuuE016Y1paMy7zSfgZlGVdJlWVmVY4YV8=@vger.kernel.org, AJvYcCXqHi3OKbSVmLEJzBKKjkQWDOJhtFGPVIpTVuKG5N6cieLez2tAtSKehOPjNGtgUXGfuShuz+eRB6ozi0q0sWpe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4R1/nB9ncfQT+wCWEloa/3k/UrQe1dek5/wn02xhN1il8/gnz
	kBIp8/2neG0M4THJnGu+TU5RdajLAfSlGAFLewhMyasWdt6LvTbtlJ+lUT2TB8rT5bo=
X-Gm-Gg: ASbGncupG5abecBpZFJQ9b7r0EaNpUq5wscE8d7udRRR/z30Q/pKmyq16NL7vJGa3GT
	uFAupAC3twr7COqAr71YsdHwvT8e/zJzZ5WCRXJaO8T0vziinKQFGTsQxe7rg1Stfkf8+mIxpFN
	RpbSRgJD1OeW0ygzVGNQ6D0pGMvNE6csQHmCCMC9X2DBh38cGFv0KurJIzuMvRYAf6oc5t9FZj2
	JYiDADXlaFlNSKfrMj92iFB9qxRkftjoqYNuuoUQnkOgQd042JQxHJ3LdbHMhSbRnX8iZPtYGun
	ddu1FSMXALBgPozqjWSqoaWR8oY4k+O2fKa/GmIADqmHDQLUadB7aFAVvmUCPRTBR5LJq39s2S6
	Ieyu9yglBNxKv3s8iM8scg6oKE3atw8x4W2xk5JET6w==
X-Google-Smtp-Source: AGHT+IEaXq/gCsm/KVr5OT9Ln1BiVc42EAdeq6lldyMdzkuaVmpS6k4/YjeqBXGVfOkE3y9QONqwfQ==
X-Received: by 2002:a05:600c:3b95:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-453879e27acmr48087785e9.6.1750953199234;
        Thu, 26 Jun 2025 08:53:19 -0700 (PDT)
Received: from puck.. (watf-12-b2-v4wan-169542-cust1006.vm45.cable.virginm.net. [81.98.219.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45380705351sm51727455e9.0.2025.06.26.08.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:53:18 -0700 (PDT)
From: Dylan Yudaken <dyudaken@gmail.com>
To: mathieu.desnoyers@efficios.com,
	paulmck@kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dylan Yudaken <dyudaken@gmail.com>
Subject: [PATCH 0/2] membarrier: allow cpu_id to be set on more commands
Date: Thu, 26 Jun 2025 16:52:55 +0100
Message-ID: <20250626155257.81256-1-dyudaken@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I noticed that only the RSEQ membarrier command allows specifying a
specific cpu. I have a (extremely toy) lib I was playing around with [1] and
noticed this and that being able to specify the cpu would be useful to
me.

I'm by no means an expert in this code though - and so could be
totally missing something.

Additionally this seems really difficult to actually test. I added a
self test that just proces "some" interrupts are being sent, but
nothing more than that. I don't know what else can be done there.

Patch 1 is the main change
Patch 2 is the self-test. Which maybe you don't want at all.

[1]: https://github.com/DylanZA/rseqlock/commit/be7bc7214fd5aacec47e26126118f8bbdda0f0ea

Thanks,
Dylan


Dylan Yudaken (2):
  membarrier: allow cpu_id to be set on more commands
  membarrier: self test for cpu specific calls

 kernel/sched/membarrier.c                     |   6 +-
 tools/testing/selftests/membarrier/.gitignore |   1 +
 tools/testing/selftests/membarrier/Makefile   |   3 +-
 .../membarrier/membarrier_test_expedited.c    | 135 ++++++++++++++++++
 .../membarrier/membarrier_test_impl.h         |   5 +
 5 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_expedited.c


base-commit: ee88bddf7f2f5d1f1da87dd7bedc734048b70e88
-- 
2.49.0


