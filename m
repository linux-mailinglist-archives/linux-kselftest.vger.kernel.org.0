Return-Path: <linux-kselftest+bounces-43637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4D8BF41AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 02:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D2D189964C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 00:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EBF2AD13;
	Tue, 21 Oct 2025 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MSs0/fur"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF7AD5A
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005339; cv=none; b=ENIPBFxT6lZKao2mZZFvCjcZSEzzrt2e5HiG5E8dsSAuzZV5b2U0szZevI2fMTtbsyLo7o48IrzCcGsIyPoEIayniWXbTSuwEedyP5DTmkPFFu8jtavvblEKWZo5B6qVmjL77gLwpw1s0TySI57ZEbTYupIorP3RrEgAqc5jdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005339; c=relaxed/simple;
	bh=KJ1pfIvIDBKjZ6RN36ZBWQUth/hUxLDHaY5YAYkH5lk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C98ttNHuzwLuSSSE95asCveOV27HWIyckoop0Vsr+io70+fct5ilVhBezArwoE6+x4T1gHYgerVb9RfaFQF9z5VUSqKmc7z8NsLqK+om4UT1HCJWCaWAmKrRwj/E4i0pEwtyB3W0PWRY6Lq0x2fLCf82iX2zeXMHpcJCsymbeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=MSs0/fur; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5d42137abc2so4801302137.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 17:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761005336; x=1761610136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMeUvazcqYNdgA2hGT8nnzdOzY6TaJPwIdfsW5qe5JI=;
        b=MSs0/furUK7577VR2osMbpvrmfRWgTLR+4PDkAVAY9V1N7nBTljS5ZQwZ6LBCm7kVP
         N6M59PlTyr4BuuzcdxxkDMzxe/cXuIYOSY+tEThuBeIIPW8c2tvo8Sar1/I6EPaGIB/t
         oXbkOe3Uz+qYl5kPPmUPrTokbu/kVxVgbMbNoRtyBLv3FdSXDodhCK4RHuI0367TZIha
         Uywo0ruMjCH7/7ptMvFVXuE49D9ERTg2dtGk0+iQ6rV27u/0fJWNiFGdBFXGMY4t0lWa
         FrSoIxhBHY4wLzmyJ17Gr+29tBjWXUwD8dTCfkxOF1ALehOMdfdqTcCaEBMl+vC+eYeC
         ScrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005336; x=1761610136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMeUvazcqYNdgA2hGT8nnzdOzY6TaJPwIdfsW5qe5JI=;
        b=qHNtC1pVuI9BMGkR3uxC90ecjEhdUQgiR4fdgW8QVZg4UOrRoEdQCsehyWRG4EmmgS
         78eTL+lCvzleXaB11OES6pvgJVXUiG3X5UZznRu7DpzmOUEASt2Dq64fRmLaleZWbhfu
         fKD3A/oNwkmstcWpogJgZBFZsSsTy1EyQPdGZSH0KuWKtgCH5VLevxhQZ1uTn2FmsNMN
         0CSIOehZj7tRRNG5HKTrH1MsV4c394E4RwBg12bhIQNt+UB+oI+2kjpjwjjwa+FUOF7+
         Rq7YR+CG34jClezCcAtUhHWEqNdjET7lvDMeBxbXEnYcb79poqgm1TPxXQJ4jnpHC1m4
         TLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPEcj3Z951DzISLzyImcq2p4pnVZqMvDk9zEJxw0w//4dpde6PBkYvC3I0ndIXk3atigX/m0uE2iWyB1+VsGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoRXvEPPeKZF7fAs+V0cDSGRZiy96MdncDG7eeyg8WhoJykFj
	IKQLjUOP+TG5cDQDCN4L+IhhAB2CLajotPRXRQt5DJ5wTFhTETdFX6A2fknidu8ViG8=
X-Gm-Gg: ASbGncvnBuD5wnhCUDcAKgdrxYzKXik+73emYf2b/DUwVyitouv52Z0KLsdtgqxcRcr
	JcEdYkiSmfWcHY/xgDgAEIP1n7A8dKCdRbN8Essxe3VNCMQseB49d0MYjKjIOBqNqzfAk2Vb+QF
	5hbd1RnNYQ9vNFmE9JO9CkVFx9V6sxRbonaruCn0S00c0Zn4BCZiP0adE/EvbkRKygS2VcrT4Pd
	zGcL1EcV7lJODCZwqWP2ESh0HMXNPNzN95uGTyFjjurF5m0sNW/y+/5f7mH0qnKHwL7FIfPOpYr
	rvAJTmD/lvWAAD98UD9tupoK7LN2MbDQSFbYeyNHzwVa0WjzMKIjkV2K1aB2nucUg5H/bty6hhO
	QWHCInop303cKAlad1KBktFYYt/+o4arOklz1uV0zYT7CnBWkYBjMsvx/3uza9ISjMKEFh1rqxQ
	aUpmsyErFlCfn/d3CJ5w5PspAQDRPe6bY39PtJdg8oWjpwg7TIDUhwWwieN9Dne2ZzMOkhmB/ZI
	vNDGZ43H4AWd2UV7LfqdUzCpS1qOG7L
X-Google-Smtp-Source: AGHT+IHQnFwZNsQY3u2ASdTone7Vpn+Mv12WF26BhqGJWj8KVskl7uPN3iDlEwuykCnl85OEi5PdLw==
X-Received: by 2002:a05:6102:94f:b0:5a4:69bc:a9e with SMTP id ada2fe7eead31-5d7dd5b8b89mr5352453137.22.1761005336583;
        Mon, 20 Oct 2025 17:08:56 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f6e351sm2822882e0c.4.2025.10.20.17.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:08:55 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
Date: Mon, 20 Oct 2025 20:08:49 -0400
Message-ID: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a memory corruption bug in KHO that occurs when KFENCE
is enabled.

The root cause is that KHO metadata, allocated via kzalloc(), can be
randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
early memblock allocator is restricted to a "scratch area". This forces
the KFENCE pool to be allocated within this scratch area, creating a
conflict. If KHO metadata is subsequently placed in this pool, it gets
corrupted during the next kexec operation.

Patch 1/3 introduces a debug-only feature (CONFIG_KEXEC_HANDOVER_DEBUG)
that adds checks to detect and fail any operation that attempts to place
KHO metadata or preserved memory within the scratch area. This serves as
a validation and diagnostic tool to confirm the problem without
affecting production builds.

Patch 2/3 Increases bitmap to PAGE_SIZE, so buddy allocator can be used.

Patch 3/3 Provides the fix by modifying KHO to allocate its metadata
directly from the buddy allocator instead of slab. This bypasses the
KFENCE interception entirely.

Pasha Tatashin (3):
  liveupdate: kho: warn and fail on metadata or preserved memory in
    scratch area
  liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
  liveupdate: kho: allocate metadata directly from the buddy allocator

 include/linux/gfp.h              |  3 ++
 kernel/Kconfig.kexec             |  9 ++++
 kernel/Makefile                  |  1 +
 kernel/kexec_handover.c          | 72 ++++++++++++++++++++------------
 kernel/kexec_handover_debug.c    | 25 +++++++++++
 kernel/kexec_handover_internal.h | 16 +++++++
 6 files changed, 100 insertions(+), 26 deletions(-)
 create mode 100644 kernel/kexec_handover_debug.c
 create mode 100644 kernel/kexec_handover_internal.h


base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
-- 
2.51.0.869.ge66316f041-goog


