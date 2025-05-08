Return-Path: <linux-kselftest+bounces-32670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FCCAB0281
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 20:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF654A57F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB462857FD;
	Thu,  8 May 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GH6P/gdQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC91C3306
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728441; cv=none; b=ndR2QjPnBC3yg+GPZhE9DWPIjtecezRltjj2l6klIpQ7GsBfwCTcrZbCceqGl2bc2jPz7jy32Yz5LeiJexV+Jr+laK9/mkxc88e7u9nIesnwaV5WF9GnDoVBxp+5+Wy12h+fBk70AKT4XNiLasSfgY2SEO+XYPyBQiPed47YXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728441; c=relaxed/simple;
	bh=AFojxG9aPrDK+YfWSqvqEl4BPFnRhOZEHrJHlhsV/As=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iS2jkcLNwn9fAEVoWlLh4OhrXbf0BBajSWKnALk/BKspWWEnTZRxcMlCaW0zHnvMi9akSi1Dj25djvN8t94RbJ6jn1+IyHhJaLnVAcsuBgnO4QgFBJXc14ZaZL+V/nUf4jD6+6/41izhPfrX/fSuhzYECo+cm1N3Esok8xcZymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GH6P/gdQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-306b51e30ffso1252621a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746728438; x=1747333238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9TcbK/nWa/YXXDAxnZVOVArGjAtkdTEqGETT2oQJ+Q=;
        b=GH6P/gdQbCfyiNTZTvQY/Q1sXpBQiShC91YBtntu0G6FBjsKcfLYry2gIDK5NhwfIx
         H6tdhflGOiVY4s6HhEG73a/vzQbr1AMo9Is7rik6unTbMtoQ7pxDdYibA9+5VesIoIjq
         DyBwbyKOgAPVAVIIl+l0dQbTPR2QS+Qqzt14Tf+cjlW/2kNYqv4GVdr28Is5YemtGplV
         ALCbSc3FRijAd0igRqPpgAyvXKbNqWOvsHMMtgOwKIVdhViic5oss50JOlGqVACLRiHX
         KBExDt2iVVKQIXMNYD+5E92dh1qqcCghFRaANVxhd87a2RjOzuzHccRbjLlAumMk26Mi
         Gn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746728438; x=1747333238;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9TcbK/nWa/YXXDAxnZVOVArGjAtkdTEqGETT2oQJ+Q=;
        b=gYEaWc9EGDmpC3/FVB6rhYDRdww3fLvHoK+OyKhLwbaleRXron7/2oZTJ7cWhuo28M
         /UfNU7Sx4nNkXK62RhTD1D79jR/ZMqvvqbuCjGIP4o18z0WbXSRUdn88iOwkIlOAzia4
         ygN3AlOczD1HKqhKgq9IODc7DQqwKNCq1xPe/k5kdDtpS5GolMhaPr0qqR4HpjJh99Qj
         /gmbkbaQi2L2D9Uyymb5zXST6Z4MgUfM2gbld2z2NmNTCzx7cH5OiLx2bvDErdCz/y7W
         cwATMOa02s5BZquic4WZyc9H8M12JXn7zl9v8qO6tgDwAJEIE7Rwf8C7nxVw0Tfzv9gp
         FCGg==
X-Forwarded-Encrypted: i=1; AJvYcCU+pj5f6nx5aI0yUsJ1Useb71VvM5LRI1XcQDixaeybtDlg4UaFFLptp6gD4ilDcV0Ud7MSaCWBEpiAH/GzlXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjsSYJVmk7y+PlNOkmh3PbglH/h9pPA5VXU+Ygcwvs8CvlAh9
	3tjeliniKIpBMlj6xWfgTKa/P0rCkJNJJweFtpaFeTtullK/eU4QpiOcyfUHy6U2nKjdxrTMHuk
	Ydv6m59eTGBaykA==
X-Google-Smtp-Source: AGHT+IFhx3d+8kkrdtF5uHVOpa/4HuyLlmn9NJKawhhnSvvJ/pAtFwroXUkydqUIaRt0a+bCKTAGt+Mq8FzXwso=
X-Received: from pjtd8.prod.google.com ([2002:a17:90b:48:b0:2ee:4a90:3d06])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:268a:b0:2fe:8282:cb9d with SMTP id 98e67ed59e1d1-30c3d6467cbmr760151a91.28.1746728437874;
 Thu, 08 May 2025 11:20:37 -0700 (PDT)
Date: Thu,  8 May 2025 18:20:19 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508182025.2961555-1-tjmercier@google.com>
Subject: [PATCH bpf-next v4 0/5] Replace CONFIG_DMABUF_SYSFS_STATS with BPF
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
v3: https://lore.kernel.org/all/20250507001036.2278781-1-tjmercier@google.c=
om
v3 -> v4:
Fix selftest BPF program comment style (not kdoc) per Alexei Starovoitov
Fix dma-buf.c kdoc comment style per Alexei Starovoitov
Rename get_first_dmabuf / get_next_dmabuf to dma_buf_iter_begin /
  dma_buf_iter_next per Christian K=C3=B6nig
Add Christian's RB to bpf: Add dmabuf iterator

T.J. Mercier (5):
  dma-buf: Rename debugfs symbols
  bpf: Add dmabuf iterator
  bpf: Add open coded dmabuf iterator
  selftests/bpf: Add test for dmabuf_iter
  selftests/bpf: Add test for open coded dmabuf_iter

 drivers/dma-buf/dma-buf.c                     |  98 +++++--
 include/linux/dma-buf.h                       |   4 +-
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/dmabuf_iter.c                      | 149 ++++++++++
 kernel/bpf/helpers.c                          |   5 +
 .../testing/selftests/bpf/bpf_experimental.h  |   5 +
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 258 ++++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c |  91 ++++++
 9 files changed, 594 insertions(+), 22 deletions(-)
 create mode 100644 kernel/bpf/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c


base-commit: 43745d11bfd9683abdf08ad7a5cc403d6a9ffd15
--=20
2.49.0.1015.ga840276032-goog


