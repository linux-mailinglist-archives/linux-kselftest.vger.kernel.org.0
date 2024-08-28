Return-Path: <linux-kselftest+bounces-16524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A0F96258D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26742284A0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B716C847;
	Wed, 28 Aug 2024 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY3cH7Xo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325313D53D;
	Wed, 28 Aug 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843536; cv=none; b=LHebJbUMoRMolPP/2BmfIyK1tRS673HDP0YOTfblpI92CLsK1ygADEDb3nrbGaFXM0ag44ZEyoT8gFCNACqUDLH7xCNr4rUj0lJN00LyvAj9eaPNqAsuaKiO69d6KTirJ9EQQ8mt1lq/PEBWL0mYbHJ+xWjwYwkw4ba7ynvwat8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843536; c=relaxed/simple;
	bh=+WMgNDkUksrQ8WMCRM66s1BQjxl931y7etquxpQI1lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VKfxhJi4JQn96yu7zAXvh5hh2pWVB5seJNNQhVFS8O6kptwol79FYTOo2U+NisU91/vwpTj3c4PXxPUBRCKALHjbJPVROsQ7/XFEOe51ivnXIJh9/t7GDlPEpnI6UAqM9ip7qq4pZy5hrwmE6am/YqFJJsQielPEpRaDllSdTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY3cH7Xo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201fba05363so55810385ad.3;
        Wed, 28 Aug 2024 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843534; x=1725448334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WH5m/OQrXoybfAnjzluZiyKxVbMcLPHUwfs59ucNLhY=;
        b=SY3cH7XoW84FCmiDO4ZWbI9DtY8jBda231jHge1UfuloMPRfT4freP4aaNx8XUt0lu
         8LFdZHc1I0n688ZNJJiDhE7ZUtH3EAykn7UlKsTF+uW7DFPKusNilHkFlEvHOSuBDa5O
         AMPH4EkyZEGkv0tMubsM4ModjRumL4RISImuzMUxXtYYpfCf8/n/vVgd7Rund0HrwirO
         1dEYhsVa5e2VZUuaSk4ZbD7W/8ajR2cw54jsF0yv4FcuOZPeFxtS0EwQxjaTloByuvbj
         6YSOGS7WoluDu0WED1FVgeaTR/gR2MiJQSnSk3VYNaud/hLA4inKFINlPC+ilD/ETykJ
         wYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843534; x=1725448334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WH5m/OQrXoybfAnjzluZiyKxVbMcLPHUwfs59ucNLhY=;
        b=Zj1mwBPgM9RVsGa3fv5nqjaE9IqcmNDSZ0eyX78dukqD9C+QXfXIHWH8G7eGlKwwUI
         DGOFEBhAXRU6l/tWt+DN6Tp8iXE1/Wda+mvPSptCrLsv+gWgTlwFu+fKSmiBbK8eQBvK
         9Vk9GHLw4cz6EVvenwkgK4239yGYzESGZ+LjamVx/xJzgOTKY1OC+reOtpGBwLbgticp
         1f8qmOXBaU00z2e0V7fBOF/NyiY499oJuhEjxhvpjqNBqHRsdIpJSVPrj434CWn/4s6M
         ABqEMHGwPMVUA1BBoukLIDbamR18VevxFRfBL+ONtncus6mWgER+37IiH4nUP5zvjPSw
         rrfw==
X-Forwarded-Encrypted: i=1; AJvYcCWa6CvmsKrPUrlEMM8V+H1TttZ4YyfgcELo2fgQwf8+E46CcAf6091y9Nvjm3srOO+ik26ocSAdlTrF4kQIO4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7QC82dGvzxhR0/deLKInNGRnixO5tD4e46DZJS5pZgF2fgvZ
	qDZT8KNPdu6T2L+pJaWdzDBOVJDeoPumTTvogj855ek38z+ZJWvzk5gKPhJE
X-Google-Smtp-Source: AGHT+IEi+jDEx7edkLUvCVzoB4kBtO6HaMBuGTtcKccQ2HoOmi4uGf5dPw4bACHq0DrlI5WorXGoag==
X-Received: by 2002:a17:902:e5d1:b0:202:17f7:8373 with SMTP id d9443c01a7336-204f9bb6944mr17952005ad.33.1724843533683;
        Wed, 28 Aug 2024 04:12:13 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855678f9sm97369395ad.1.2024.08.28.04.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:12:13 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v3 0/8] libbpf, selftests/bpf: Support cross-endian usage
Date: Wed, 28 Aug 2024 04:11:50 -0700
Message-Id: <cover.1724843049.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

This patch series targets a long-standing BPF usability issue - the lack
of general cross-compilation support - by enabling cross-endian usage of
libbpf and bpftool, as well as supporting cross-endian build targets for
selftests/bpf.

Benefits include improved BPF development and testing for embedded systems
based on e.g. big-endian MIPS, more build options e.g for s390x systems,
and better accessibility to the very latest test tools e.g. 'test_progs'.

Initial development and testing used mips64, since this arch makes
switching the build byte-order trivial and is thus very handy for A/B
testing. However, it lacks some key features (bpf2bpf call, kfuncs, etc)
making for poor selftests/bpf coverage.

Final testing takes the kernel and selftests/bpf cross-built from x86_64
to s390x, and runs the result under QEMU/s390x. That same configuration
could also be used on kernel-patches/bpf CI for regression testing endian
support or perhaps load-sharing s390x builds across x86_64 systems.

This thread includes some background regarding testing on QEMU/s390x and
the generally favourable results:
    https://lore.kernel.org/bpf/ZsEcsaa3juxxQBUf@kodidev-ubuntu/

Feedback and suggestions are welcome!

Best regards,
Tony


Changelog:
---------
v2 -> v3: (feedback from Andrii)
 - improve some log and commit message formatting
 - restructure BTF.ext endianness safety checks and byte-swapping
 - use BTF.ext info record definitions for swapping, require BTF v1
 - follow BTF API implementation more closely for BTF.ext
 - explicitly reject loading non-native endianness program into kernel
 - simplify linker output byte-order setting
 - drop redundant safety checks during linking
 - simplify endianness macro and improve blob setup code for light skel
 - no unexpected test failures after cross-compiling x86_64 -> s390x

v1 -> v2:
 - fixed a light skeleton bug causing test_progs 'map_ptr' failure
 - simplified some BTF.ext related endianness logic
 - remove an 'inline' usage related to CI checkpatch failure
 - improve some formatting noted by checkpatch warnings
 - unexpected 'test_progs' failures drop 3 -> 2 (x86_64 to s390x cross)



Tony Ambardar (8):
  libbpf: Improve log message formatting
  libbpf: Fix header comment typos for BTF.ext
  libbpf: Fix output .symtab byte-order during linking
  libbpf: Support BTF.ext loading and output in either endianness
  libbpf: Support opening bpf objects of either endianness
  libbpf: Support linking bpf objects of either endianness
  libbpf: Support creating light skeleton of either endianness
  selftests/bpf: Support cross-endian building

 tools/lib/bpf/bpf_gen_internal.h     |   1 +
 tools/lib/bpf/btf.c                  | 230 ++++++++++++++++++++++++---
 tools/lib/bpf/btf.h                  |   3 +
 tools/lib/bpf/btf_dump.c             |   2 +-
 tools/lib/bpf/btf_relocate.c         |   2 +-
 tools/lib/bpf/gen_loader.c           | 185 ++++++++++++++++-----
 tools/lib/bpf/libbpf.c               |  39 +++--
 tools/lib/bpf/libbpf.map             |   2 +
 tools/lib/bpf/libbpf_internal.h      |  17 +-
 tools/lib/bpf/linker.c               |  92 +++++++++--
 tools/lib/bpf/relo_core.c            |   2 +-
 tools/lib/bpf/skel_internal.h        |   3 +-
 tools/testing/selftests/bpf/Makefile |   7 +-
 13 files changed, 488 insertions(+), 97 deletions(-)

-- 
2.34.1


