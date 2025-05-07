Return-Path: <linux-kselftest+bounces-32541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3D0AAD1E2
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 02:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8759848D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E46D8F4A;
	Wed,  7 May 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6zE1Wh1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC78F4A00
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746576645; cv=none; b=AIx62eZ7o8zYpoygKQOsv5XLSPS+u/tZqsYVA2hN34qeQ+2oTEZP4ONgIbvpE1gOWzomUBltJ98CBnNmoQ0g2gZD0FJVg5FhJXIg8vn6F9Na3ucYJQ26WAxOPd6T6HppM31aAp38BuGPSYItyNDvP7awEozLcCTXu7tR2Q18Axs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746576645; c=relaxed/simple;
	bh=JWPtOoz4EA9bjCWVXaVjCq9xtrf9Nr3J1ZEFcVK7PCQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q3I08uiebHU7TdNtXtZXgeCJcFUHLQttxaFXYq64l2NfHgjXE6hCeiA4ywmcdcm5KxR9FLtm6osTo1nv6HVRqQAErALaOpe1lxvCmDlaZMB2Y+v8qlXg31hWzftq++fH4z8xApkxeIA/3beOMhCVAwdZOTvmo8LZUX48GvjrMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6zE1Wh1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so4885706a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 May 2025 17:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746576642; x=1747181442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbM0hT4nN9Qi5ds4e0j9GLdbgAxkWG3cIrhqKGc4+Co=;
        b=z6zE1Wh1jqc1zVo2RKxx5qf3UqRp3AivPx8ywhzMdyJpeVk+detvcZNfuzJo2lsQWi
         Uk8vMN9KkyX/ROSP6ZzObgY8GbTVz3MK107TuH7V+humhGnKbNXGL5FGRY1BahJBvjC0
         v8vktJ/qKjsLNPuyFEJP2INkYu9AylF53V8Xl875YOGRJQQ4LPhlsgEGiBCkci/YWaqy
         jtr/CE8WHzFCZJ2Nd5XHSxlgHlqp7/QWyZXYDK7soDp81xoqQ05CeU4/YU5EF2BYCxvG
         GyZf1eGLtZsCx0SxSoHJsTI8zBml9GPoisCl77nosoteyTSwfz2Mcbc7GZVJOhAXhkYR
         19oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746576642; x=1747181442;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbM0hT4nN9Qi5ds4e0j9GLdbgAxkWG3cIrhqKGc4+Co=;
        b=ZTFkqumWTrPQqL0xsQ/pT0eJe5kr0cIWeFwGIFJUiD4uzreD1FTqg+uAT8ofpf5NQ1
         cniqu0T41dU2SkyHsKwsiY4VA9FcqPP1xmD3Hrdzct3xYr/34xXAk8OdZJkgWlZ3n7ba
         1cyRFchb7rZpRkpk+LviYfc8S5rj3xXsYNWj2CGtaY0QnSGExSf6+JD9IlYEJne3yNxs
         4D2Pve0bxweDc2IFIIc08mZZ/scEZo+zPVLbmFNAFrnrHXq4tOYk/BPl6pZtjb1MExG1
         9ld9p/4UPx83c2yhJEWCS1/Gizk8mLmyiwUg9zD0Fwa6ahkCccrob+YKYrUpJ0LPUAQM
         mweQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSxg7lcLvKoRYfCtD2IrxdSdWL0oJkSRLejKOz3xTXGHlcSMGWueDZOdJECBllI+IuoBz0I3lSWKRPzmE6D4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ4oohOdPNUYBU+W63nogykGPyhpUX1sqsEoA/tJdEMArEbCvr
	oYp8QEZe6leUSwaU+gg8ZYkSXoNf8GUAzGW2mwkltB3N3I0u7YcbXD0/XqwGWufB1WFqU0CVTcM
	7ginTT1y651hu0Q==
X-Google-Smtp-Source: AGHT+IGgh9HyAs9Nj/w00VjUmiwsbbsyaNDbuDxCtSFIr9y5AQvyC41+3cohLwHox+GxYYqlbWOuGxl6mDGD8Sc=
X-Received: from pjbpt3.prod.google.com ([2002:a17:90b:3d03:b0:2fa:15aa:4d1e])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d8c:b0:2ee:e317:69ab with SMTP id 98e67ed59e1d1-30aabf6f73emr2662572a91.0.1746576642184;
 Tue, 06 May 2025 17:10:42 -0700 (PDT)
Date: Wed,  7 May 2025 00:10:31 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250507001036.2278781-1-tjmercier@google.com>
Subject: [PATCH bpf-next v3 0/5] Replace CONFIG_DMABUF_SYSFS_STATS with BPF
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, song@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, "T.J. Mercier" <tjmercier@google.com>
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
Make the DMA buffer list independent of CONFIG_DEBUG_FS per Christian K=C3=
=B6nig
Add CONFIG_DMA_SHARED_BUFFER check to kernel/bpf/Makefile per kernel test r=
obot
Use BTF_ID_LIST_SINGLE instead of BTF_ID_LIST_GLOBAL_SINGLE per Song Liu
Fixup comment style, mixing code/declarations, and use ASSERT_OK_FD in self=
test per Song Liu
Add BPF_ITER_RESCHED feature to bpf_dmabuf_reg_info per Alexei Starovoitov
Add open-coded iterator and selftest per Alexei Starovoitov
Add a second test buffer from the system dmabuf heap to selftests
Use the BPF program we'll use in production for selftest per Alexei Starovo=
itov
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

T.J. Mercier (5):
  dma-buf: Rename debugfs symbols
  bpf: Add dmabuf iterator
  bpf: Add open coded dmabuf iterator
  selftests/bpf: Add test for dmabuf_iter
  selftests/bpf: Add test for open coded dmabuf_iter

 drivers/dma-buf/dma-buf.c                     |  94 +++++--
 include/linux/dma-buf.h                       |   5 +-
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/dmabuf_iter.c                      | 149 ++++++++++
 kernel/bpf/helpers.c                          |   5 +
 .../testing/selftests/bpf/bpf_experimental.h  |   5 +
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 258 ++++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c |  91 ++++++
 9 files changed, 591 insertions(+), 22 deletions(-)
 create mode 100644 kernel/bpf/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c


base-commit: 43745d11bfd9683abdf08ad7a5cc403d6a9ffd15
--=20
2.49.0.1045.g170613ef41-goog


