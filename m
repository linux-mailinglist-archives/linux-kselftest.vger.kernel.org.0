Return-Path: <linux-kselftest+bounces-42986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C57BD2381
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 204EA349158
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B02EAB79;
	Mon, 13 Oct 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YKMEYGmE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D11BDCF
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346806; cv=none; b=SA6K5SHuUDLo72hHZB0lioss+InvM9Hmrwmtr6IqVMPEqNYkyTG3qLJKX1EbISobudJz9fVryAKnvNFigb17gMWp8nReoBzXIsTyORcpWsSvQHt/DvLzKnmhawZARqJ9vmwhlNhYmb44TMEqjeEIp5pzJfvH0gXfYZHo4zVX30o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346806; c=relaxed/simple;
	bh=1rGLpmr2Rc988K6c4+jGB9nY9XYW/BSrv2mqDgcSFAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HvP2cXnELchSKxg4zIioFCUJKvnYiSXOIFMlCkJUOmRYZN8qcvs2ppkLaprDBrhCYHUzEPdJvl1nsLiHZT5DK1NNDhCWODCDeJRElpsys8fzPu2LA1EEgln6AXQBrDpRCNDOJ0+l5k4fnNGp2LprK/nslL8VR9FhjhR4qnGWeX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YKMEYGmE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7811fa91774so3354365b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760346804; x=1760951604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puEhtlhHdjNZJq9B7H+sgmW+MNQKHkmLHApkYcMFYqw=;
        b=YKMEYGmEAoK1EhWXSJ7AOFGK8GcEic4r6wK6dXQ3eMmXIERcnjyeQgW1rpgKmFZ2B7
         2hSbx5NL9bu2IVORQaVsxYD0yMvDab/QbKMs7VE6abEbMM1+KLiLJHTYDpiTm4B2+c3J
         gs2ScpE6DzSc0MaK5KBA1Cwfww4lzaFVCDUY5xzjrPQCUn5LD/6UB5VnZyQFtyFI0qOo
         FtGwm20n41w6dIoQjVD7rtptKUqEhVmWQWyWnXvYsc2LD+Un7ejlXRgxkbNOP4KAKTdp
         KTTkaj6B2fit1tG/FS8cJWWMJbNJwbxzV7vtaQax6QdeaTm4uH9+LbbcB332ku4WFM5r
         XtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760346804; x=1760951604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puEhtlhHdjNZJq9B7H+sgmW+MNQKHkmLHApkYcMFYqw=;
        b=q5xOfBLzBpGJWi+PYzzuxgXryXtFR4UQAIxNuex6zepPcl5T73HAATYRomBcjJofWx
         9voqelclKB2L+QDPz/jC/pRjXGitw5UCKzHykeHRjp26nUSFvddm3lqnZU4aL4b3Wolq
         Uyy5FvTTzHbM81848XDxfYQ0ZXZUyge/tIGYEx0hFzVcb1kAtNUba3tpv1Fa+8jLPUEY
         VUgQKlyLHrMdXtSoX7s2MZ+9141kJyOGuH3zC1u1FxtA4Z84OaGdtQmvDVQwHpriM1gq
         2DXC/ldryy51L0iFIYdurTnj76tuxxx8xk2AMU0pd8VELd2u/gXaAzNp7VnQuur3HBCV
         V07w==
X-Forwarded-Encrypted: i=1; AJvYcCVlCbAjII9V5xv82f/FUuknXrwdNceSQgYff4unoqObV91OT5Af+Pyl1YdlzA7gXk27iI01PubKBj8NQqC6z9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wLQqA0vpLdPeMJzRTY55W5y9DwByMykkgs6aw5A5+vlaocc8
	Gj+GxWlNp/WRXncYz5SHItQxQVeBf6mBa/0RXbTqalmRKqczxlc/6lRLAMJJoXxTlJc=
X-Gm-Gg: ASbGncsgA/Az9kjdstrVNlvclaaaTPLleQZgXtUCpyvgCnV6l1sbQ8XkgTMqrRJN5ht
	0IoqkieKmx5Ue8vInwnV6UfhuoiBk/GaNLKGduD/YTwYUUGzESTAsTvrthlcIaD3QkOubDcCzSU
	xR/n4O7LRCvbzKEKItoEy2VqHFUJ4Kp1ziv+gXDSY8VdnYyfofpEWrUsPcEzbH1H96MSe798sMB
	1ByBXR1ImzYjGZcTZedvsP85+/wuSh1SVGhpDUP5Ou80Mtt7Hv8S1goPH8eFbgOt2gOk5UuY15t
	ZPy0xN7Es2mbNps1DUGOEBUsRzou2lE6JsdlHkPt7KrIKsyGM5Nipko2L1228rlV5XBbTcT0r6x
	Vl7mZoZ18yg+LCoEZ7/36OWhjt1+EevJkYONiSW96/BF9K2Ptv/N1adFQ0pJyzn5wgGKbbtQ=
X-Google-Smtp-Source: AGHT+IEoj7YdDMoreA1spQJTu0BCnH14OzuerL3I7BC4yPUexYDFbRuPl/Tikz8AnuBBaxg3bqJ7SQ==
X-Received: by 2002:a17:90b:3b90:b0:32e:3830:65e1 with SMTP id 98e67ed59e1d1-33b513be284mr29173869a91.33.1760346803844;
        Mon, 13 Oct 2025 02:13:23 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a3cc0dsm11727220a91.9.2025.10.13.02.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:13:23 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 0/2] Optimize the allocation of vector regset
Date: Mon, 13 Oct 2025 17:12:30 +0800
Message-ID: <20251013091318.467864-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The vector regset uses the maximum possible vlenb 8192 to allocate a
2^18 bytes buffer to copy the vector register. But most platforms
don’t support the largest vlenb.

The regset has 2 users, ptrace syscall and coredump. When handling the
PTRACE_GETREGSET requests from ptrace syscall, Linux will prepare a
kernel buffer which size is min(user buffer size, limit). A malicious
user process might overwhelm a memory-constrainted system when the
buffer limit is very large. The coredump uses regset_get_alloc() to
get the context of vector register. But this API allocates buffer
before checking whether the target process uses vector extension, this
wastes time to prepare a large memory buffer.

The buffer limit can be determined after getting platform vlenb in the
early boot stage, this can let the regset buffer match real hardware
limits. Also add .active callbacks to let the coredump skip vector part
when target process doesn't use it.

After this patchset, userspace process needs 2 ptrace syscalls to
retrieve the vector regset with PTRACE_GETREGSET. The first ptrace call
only reads the header to get the vlenb information. Then prepare a
suitable buffer to get the register context. The new vector ptrace
kselftest demonstrates it.

---
v2:
- fix issues in vector ptrace kselftest (Andy)

Yong-Xuan Wang (2):
  riscv: ptrace: Optimize the allocation of vector regset
  selftests: riscv: Add test for the Vector ptrace interface

 arch/riscv/include/asm/vector.h               |   1 +
 arch/riscv/kernel/ptrace.c                    |  24 +++-
 arch/riscv/kernel/vector.c                    |   2 +
 tools/testing/selftests/riscv/vector/Makefile |   5 +-
 .../selftests/riscv/vector/vstate_ptrace.c    | 134 ++++++++++++++++++
 5 files changed, 162 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/vector/vstate_ptrace.c

-- 
2.43.0


