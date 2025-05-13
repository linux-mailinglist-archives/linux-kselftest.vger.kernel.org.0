Return-Path: <linux-kselftest+bounces-32906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5243AB5A2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 18:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358BA173E3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC55B2BFC89;
	Tue, 13 May 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1DgjMK8U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833932BE7BC
	for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154179; cv=none; b=mmJNbu4CvDJ0SXslklqALw2YRZQyAY9mM5iG6LzRPrKTlK+TlOMdze/j3nsNzNoIR/RxVNsm9XUlmKzP/fKRjl+wxJdALCRWKfG+gWT3uJHlDfsqyyHVZfgKeQlK0nZRnzF0Jg6LxfHLm0+VOHA8zZfFA/ff+AsBz98rFfCH9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154179; c=relaxed/simple;
	bh=vhAKvGj4H8z2TL7t91336n083KzQfTEuSIvTQuKEhrI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uQ9nn5gcajg65cL3nAHuMqA+mKsS/y59SBor0qS++xor1QXYYlKBQAh6I304zqsSUXrIpd4DrGBKxI43eZWlp8kQ04Rp+fOJPICXfPYt6bNVYqQ/P6WESt72yYa3XEQ7q891MlzSolIo+HS2ltC78GPyXLeL/ZW0Bi9W3ZgypZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1DgjMK8U; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ab4d56096so6037099a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747154176; x=1747758976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJer6fjOgFGncHrv8GbyId4RjSKe5It7mnfoP9OBkic=;
        b=1DgjMK8Ul1dvSS5L+PtZL6/wSw3h7hr0r0a2yBbTajMGjUPMkB8hti04TUtg+F6Lyv
         LvrGRMGptDshcO4lsyY/z+0dIEQu+JxP1KqJG1jtsnWOP7zSuzqqJgImJDN8ulYTQ/UH
         y+RZQkSSMLwfzpeNibcqiX8iVbDlZAfwv8e2Hv+FBhy45z4nxK0BVS/i4T9G8Cp83ggK
         F9R5PpDXi+mHuW857AjNZrreQoZKr9XPn37+FJILyHi/cyGzKf2x1hmyRiqhZsaC0+zV
         WkNwEsO10U1Mw6/ZIpKoE2+fbcbWYSH3ZDjN4R4x3KgZvCAaT9IfX1chAuLU67FPFsjA
         Mjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747154176; x=1747758976;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJer6fjOgFGncHrv8GbyId4RjSKe5It7mnfoP9OBkic=;
        b=MgDG4hD1frY4HPFh7e+uHIH1Buztex3Fgo/k9B2xK3Hz8/HaAPx/TQqi6BsQkVJsU4
         Rixwwtz79Zb10u24qiwVKsCTAwxmoVyQJ0HZH8zwSxgCS36DFUoMds20rAmbcXKIZU8j
         Uiirzb4XcVHVqnafUlMBd215ZIJIMpGUONIQeg2vrEwhwNQgyXNLCNi5dSuT7bAwcX1a
         BzpoVVcu3VWcQMIktonFW9Affcn8wp8vJSwGtX402E8dw22BSPcy6vhWPuiF7EaYDBlx
         /1UCzM1tcux5rkTAM/1l5dOt9zWbKPfa7AS1t4XPsa6McPlOhaRqL8v+Ujmn9mDZzSvU
         5Hig==
X-Forwarded-Encrypted: i=1; AJvYcCWk4cVLwKbUW3CVFZEukeDbxNtDJhiaRoYpsV1IeI1eZQ+pbRnBYj6g/oe3XT2cVz/RQUU2Up5F1BkM+03Cuz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWkbSugcZdOXhrEMDoK90KEzeD1Lt+xY4kK+B3nWySw4W1nc3
	n2LjGXQUfZ2CowJiYcDXr8oO1ysMOU2QxIgtdkQ46fXkJRs8idDWdARXKQH6aJKyfvz9whIdWte
	l2Ae7kfqMfwoS6Q==
X-Google-Smtp-Source: AGHT+IFLXwNyuqw3BPAw9IFVtogyMsIvYUR/6UrnN3Mp/J9XKI4f1JlNZHjYttRZ2m57eFxpb3dpvQfVwfvavvA=
X-Received: from pjbpm17.prod.google.com ([2002:a17:90b:3c51:b0:30a:a05c:6e7d])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3949:b0:2fe:e9c6:689e with SMTP id 98e67ed59e1d1-30e2e5f0626mr297720a91.8.1747154175825;
 Tue, 13 May 2025 09:36:15 -0700 (PDT)
Date: Tue, 13 May 2025 16:35:56 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513163601.812317-1-tjmercier@google.com>
Subject: [PATCH bpf-next v6 0/5] Replace CONFIG_DMABUF_SYSFS_STATS with BPF
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
v5: https://lore.kernel.org/all/20250512174036.266796-1-tjmercier@google.co=
m
v5 -> v6:
Song Liu:
  Init test buffer FDs to -1
  Zero-init udmabuf_create for future proofing
  Bail early for iterator fd/FILE creation failure
  Dereference char ptr to check for NUL in sanitize_string()
  Move map insertion from create_test_buffers() to test_dmabuf_iter()
  Add ACK to selftests/bpf: Add test for open coded dmabuf_iter

T.J. Mercier (5):
  dma-buf: Rename debugfs symbols
  bpf: Add dmabuf iterator
  bpf: Add open coded dmabuf iterator
  selftests/bpf: Add test for dmabuf_iter
  selftests/bpf: Add test for open coded dmabuf_iter

 drivers/dma-buf/dma-buf.c                     |  98 ++++--
 include/linux/dma-buf.h                       |   4 +-
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/dmabuf_iter.c                      | 150 +++++++++
 kernel/bpf/helpers.c                          |   5 +
 .../testing/selftests/bpf/bpf_experimental.h  |   5 +
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 285 ++++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c |  91 ++++++
 9 files changed, 622 insertions(+), 22 deletions(-)
 create mode 100644 kernel/bpf/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c


base-commit: 43745d11bfd9683abdf08ad7a5cc403d6a9ffd15
--=20
2.49.0.1045.g170613ef41-goog


