Return-Path: <linux-kselftest+bounces-32866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85834AB3F53
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 19:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058B5465542
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE334296D1F;
	Mon, 12 May 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVbHoNju"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68525178A
	for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071652; cv=none; b=LRVqXqcge6PKPTcZgiCDvvfkHG9heKjQteGEk+zqX/N+Nx0CbXoLaf0vamRxVsW8Jp0amFG2VGmPTd0hZu5zf/6dHy//Z/mFp7K6jMFeXDN51dl956bDFavCPiMdTRT394tcCCMtJlnOUilK4zbIe85Gz4w0767AwMx/uSEHFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071652; c=relaxed/simple;
	bh=YG5ad+PrUTXpbhaNPVc/UH5K2lqsFYPckT+HG7VIWJQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zfbp6qrtxVxyJGYLv90xWCPmCUjARgq0cQR/TD2eanMvuP/0xbzRzVRfriKD3A1ElLfAguhbLZuLsQQbCVGU9wfHvDesZOGy4Y3AS/ZPSV9Qy6TLLHhaBgEMzgubTohPFXOwou/99zYAZZR5vxzQlle+FnejE/BTTIVQ+HPcWkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVbHoNju; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30abb33d1d2so7484843a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747071650; x=1747676450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eBYOHelJunIHuJksv+29i3wZCe50rVCOEbtcj9aAZWE=;
        b=lVbHoNjuRmQbfa3vgasLVrIHPQJzi3QvKTkh70tYBry8mbQxAM6HNlwVr64C6DjEkk
         OzbE+G0dnYh1tyHUGLZLpryGdonw5e8VSo3e8GDESdjsHCXetkwD9u70NGY2hAvUvTY7
         OrJ1cAFHEOxcy+6xdcnvfu2jyKJFOBA8Rknkdp0UNbWueR/EyEFIecb2vhMyi7H3K6VS
         we0gTXEBfZrByVsMQJxOs/z7b9pOv460xKbXPYqYwb+k0lP2GLSwnP6q635gwPST6Q2T
         +L3qb/01UT5h2tMQRb9gakp0FRZ8fwZaEnS57mhk9C5/6TFgJuV8HfGMuyWIRjqiT4f3
         fJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071650; x=1747676450;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBYOHelJunIHuJksv+29i3wZCe50rVCOEbtcj9aAZWE=;
        b=s0IAdo7FgxdapcIAk05rpxbLIV/WtpUwnv/HsOsUgjHJfp9//nfgZeW3EiKk1ICggw
         G9jzV0YGx54+3zQL+zaC1Zmkib2wpYPdoC2e5JkMrKrS5PZtwldLgJ/Z5wULy4yCmx6f
         JpKMsplsAfw/4g5RUAHXxKz6nG9DTpqhfc06BWoZzZ73ETEYyUIovVQIVz6MOEosn0Lt
         IkcsPmsCIyFXjtOLmdGQZ1g8RS6I85dKHEDwa4lwJ5xAkc0dfxuSfCWcrOLQFH33V3CY
         aLfbNvjdpQIl0BNJjAgR3aexmnf2Y++AnoN+95cQ9LiKsSDNf8dYdkyt1TBcD1RPcIqd
         Xo+w==
X-Forwarded-Encrypted: i=1; AJvYcCV/edy9iYffg0FVLoijiPux2D/bXCoJG4ZfvEu5h+EHTpJ69OcSkP/1ZYGKrUd/NnhqHAc1CxspaxXXjRM6HSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5gL+m/0ZXk8qSJpzoO0kDSNbuJ024EX/5jiN2eb/+WZyK8d3
	6d/aoH6w5lSW4469cCyYglKkfci+vfvJRLmtaG/CFZu8z87/l643CocqCiZNqcBCzj+QbZxudLe
	UyQ8BxMMxH3gqsA==
X-Google-Smtp-Source: AGHT+IFzMCh38Oc1kAsUKXxU9hlKM203yvfUD0dvHa7bGIfNoTLZ2frsFjS+If3JtUJ6jRpxlO+Sx3tWCnqzocM=
X-Received: from pjbse15.prod.google.com ([2002:a17:90b:518f:b0:308:64af:7bb9])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c8e:b0:2fa:1851:a023 with SMTP id 98e67ed59e1d1-30c3d657026mr21415776a91.35.1747071650573;
 Mon, 12 May 2025 10:40:50 -0700 (PDT)
Date: Mon, 12 May 2025 17:40:31 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512174036.266796-1-tjmercier@google.com>
Subject: [PATCH bpf-next v5 0/5] Replace CONFIG_DMABUF_SYSFS_STATS with BPF
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, song@kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Until CONFIG_DMABUF_SYSFS_STATS was added [1] it was only possible to
perform per-buffer accounting with debugfs which is not suitable for
production environments. Eventually we discovered the overhead with
per-buffer sysfs file creation/removal was significantly impacting
allocation and free times, and exacerbated kernfs lock contention. [2]
dma_buf_stats_setup() is responsible for 39% of single-page buffer
creation duration, or 74% of single-page dma_buf_export() duration when
stressing dmabuf allocations and frees.

I prototyped a change from per-buffer to per-exporter statistics with a
RCU protected list of exporter allocations that accommodates most (but
not all) of our use-cases and avoids almost all of the sysfs overhead.
While that adds less overhead than per-buffer sysfs, and less even than
the maintenance of the dmabuf debugfs_list, it's still *additional*
overhead on top of the debugfs_list and doesn't give us per-buffer info.

This series uses the existing dmabuf debugfs_list to implement a BPF
dmabuf iterator, which adds no overhead to buffer allocation/free and
provides per-buffer info. The list has been moved outside of
CONFIG_DEBUG_FS scope so that it is always populated. The BPF program
loaded by userspace that extracts per-buffer information gets to define
its own interface which avoids the lack of ABI stability with debugfs.

This will allow us to replace our use of CONFIG_DMABUF_SYSFS_STATS, and
the plan is to remove it from the kernel after the next longterm stable
release.

[1] https://lore.kernel.org/linux-media/20201210044400.1080308-1-hridya@goo=
gle.com
[2] https://lore.kernel.org/all/20220516171315.2400578-1-tjmercier@google.c=
om

v1: https://lore.kernel.org/all/20250414225227.3642618-1-tjmercier@google.c=
om
v1 -> v2:
Make the DMA buffer list independent of CONFIG_DEBUG_FS per Christian
  K=C3=B6nig
Add CONFIG_DMA_SHARED_BUFFER check to kernel/bpf/Makefile per kernel
  test robot
Use BTF_ID_LIST_SINGLE instead of BTF_ID_LIST_GLOBAL_SINGLE per Song Liu
Fixup comment style, mixing code/declarations, and use ASSERT_OK_FD in
  selftest per Song Liu
Add BPF_ITER_RESCHED feature to bpf_dmabuf_reg_info per Alexei
  Starovoitov
Add open-coded iterator and selftest per Alexei Starovoitov
Add a second test buffer from the system dmabuf heap to selftests
Use the BPF program we'll use in production for selftest per Alexei
  Starovoitov
  https://r.android.com/c/platform/system/bpfprogs/+/3616123/2/dmabufIter.c
  https://r.android.com/c/platform/system/memory/libmeminfo/+/3614259/1/lib=
dmabufinfo/dmabuf_bpf_stats.cpp
v2: https://lore.kernel.org/all/20250504224149.1033867-1-tjmercier@google.c=
om
v2 -> v3:
Rebase onto bpf-next/master
Move get_next_dmabuf() into drivers/dma-buf/dma-buf.c, along with the
  new get_first_dmabuf(). This avoids having to expose the dmabuf list
  and mutex to the rest of the kernel, and keeps the dmabuf mutex
  operations near each other in the same file. (Christian K=C3=B6nig)
Add Christian's RB to dma-buf: Rename debugfs symbols
Drop RFC: dma-buf: Remove DMA-BUF statistics
v3: https://lore.kernel.org/all/20250507001036.2278781-1-tjmercier@google.c=
om
v3 -> v4:
Fix selftest BPF program comment style (not kdoc) per Alexei Starovoitov
Fix dma-buf.c kdoc comment style per Alexei Starovoitov
Rename get_first_dmabuf / get_next_dmabuf to dma_buf_iter_begin /
  dma_buf_iter_next per Christian K=C3=B6nig
Add Christian's RB to bpf: Add dmabuf iterator
v4: https://lore.kernel.org/all/20250508182025.2961555-1-tjmercier@google.c=
om
v4 -> v5:
Add Christian's Acks to all patches
Add Song Liu's Acks
Move BTF_ID_LIST_SINGLE and DEFINE_BPF_ITER_FUNC closer to usage per
  Song Liu
Fix open-coded iterator comment style per Song Liu
Move iterator termination check to its own subtest per Song Liu
Rework selftest buffer creation per Song Liu
Fix spacing in sanitize_string per BPF CI

T.J. Mercier (5):
  dma-buf: Rename debugfs symbols
  bpf: Add dmabuf iterator
  bpf: Add open coded dmabuf iterator
  selftests/bpf: Add test for dmabuf_iter
  selftests/bpf: Add test for open coded dmabuf_iter

 drivers/dma-buf/dma-buf.c                     |  98 +++++--
 include/linux/dma-buf.h                       |   4 +-
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/dmabuf_iter.c                      | 150 ++++++++++
 kernel/bpf/helpers.c                          |   5 +
 .../testing/selftests/bpf/bpf_experimental.h  |   5 +
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 276 ++++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c |  91 ++++++
 9 files changed, 613 insertions(+), 22 deletions(-)
 create mode 100644 kernel/bpf/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c


base-commit: 43745d11bfd9683abdf08ad7a5cc403d6a9ffd15
--=20
2.49.0.1045.g170613ef41-goog


