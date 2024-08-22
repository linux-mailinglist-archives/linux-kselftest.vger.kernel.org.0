Return-Path: <linux-kselftest+bounces-16028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B46495B189
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0148228844B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7617CA04;
	Thu, 22 Aug 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCbC0oNZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11113BC3D;
	Thu, 22 Aug 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318682; cv=none; b=CT5g5XA66ExYrM5PPwOXlnyCIV2cbD2eWFfMzui8SsdvYQfPif0DLkTRL6j5hgiz9so9IJKZ2zLKTaIoBiymK1msnCwnG890nK813UlV7x7coIoOtVe++hYFa+vqPY9N0z3bG7a80IMr6UQT56BklUfSqG601tpnuEmnFbOAEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318682; c=relaxed/simple;
	bh=O+7vIwkn/EXTMnTLCRf3IlxWJfoNQzKPpnXbF8XPI88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QnQRBYq2bWG4Hi6SjyTgdwe77e4JhJeITEHoBRv32VR7+Ko+MEBI2OPLq/vv900G0WkgfyCAbTjMFsb3hqvpPzKs1LinIWRtdZgXISZs6CwxgmI+UgTNdrPVS71bzctuQYgyvLCG/+T/b6FzO2yUbuCOXUdJ2HfGnoN8ANOnPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCbC0oNZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd830e0711so566016a12.0;
        Thu, 22 Aug 2024 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318680; x=1724923480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IB+cT4BA0Vn52rTceQGY6oWJuUow1FaiD8i6KayzgAg=;
        b=VCbC0oNZR9LkvBBU1fwF2dqtbbqOKPMEtLj/bnCubuXODjc4I9dtqUHFq0I7QZKvaS
         HCZdgL5qvsfzVK9NkhQmTTF5NfBaw9PG77Q4y5UViaWsX5Yip6n6Scka7uoJ+C1QlxLo
         Cqyam7R5LryQsyJ4Hu11R5GfR/iuE25UDP5WI/ySrrARhZOFWCS3kinoNJhViha76PKw
         ubkFTU31FS7ggISB6i/KVz2dvkNsnnWA+0J8sKFikfv7vXcufgRB4s1LPjlt4JQkPwiF
         QJHVGlzrTc7N5O2VrvcLUqpLfM6LgwYZwYwa28+vnudvGsfYBJ/Hc18LAR+36HQbbZUt
         Vu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318680; x=1724923480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB+cT4BA0Vn52rTceQGY6oWJuUow1FaiD8i6KayzgAg=;
        b=iGFC3DflncL6THObVQd0R0UiMs4KWffXCX8YBqE3XyGW9uPIK7/k7ETK2pvGA1NG/b
         73AAxisJlPMcr3TN3oC9VoyU4DWnx9yFu/lV6Jy9GnRtzMRfrgxYEAU/mr/RNKOjMYKC
         67yLBdX1hCX+tRgy6/sUnTaMR5SOvxDw+m2j8BKfAaostV3WBTNd3EF+fqPA/UpQ0mVl
         1h8dtqeqbXMgDsQb08VCfejWuBlWpBkXkvAODvhf2B0/AcyPQF4jeILNrdJ1rac6Shq3
         TAjM/7GMhU1VuBtH7EuHJ2HMWJiUjTPsLX2spPz+66ISZN0XMD9L4zjyAePwp7ONRscX
         u52Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4Jzq31Nb7/k0IhNww7Sk+uJemPTKfAKF+YlThvt9Y+7ZuX/ju+AoVRLPoNUzFq9d6hytd7OB6AFwjPPdtVBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8dfv+5ojqGG8Wc+6JkxTmmx4R/WCZ2i1lsaQrKtMN2p8aentz
	dNyCYEMjsqzEIAG7Dq+/dHdgA2wZMM7XYBbm6nUocTQzhBc7kIlhlSvsmeAz
X-Google-Smtp-Source: AGHT+IFB7TXsuAeG80hU2AvSletPzbdFSpTYlu3vP9KFoYisdovm/LPm8im2D3mvpaEu1RAOmPnoSw==
X-Received: by 2002:a17:90a:a791:b0:2d4:6919:c978 with SMTP id 98e67ed59e1d1-2d60aa1aedamr3294803a91.21.1724318679605;
        Thu, 22 Aug 2024 02:24:39 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90decasm3548820a91.23.2024.08.22.02.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:24:39 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
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
Subject: [PATCH bpf-next v2 0/8] libbpf, selftests/bpf: Support cross-endian usage
Date: Thu, 22 Aug 2024 02:24:23 -0700
Message-Id: <cover.1724313164.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

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
 tools/lib/bpf/btf.c                  | 168 ++++++++++++++++++++++--
 tools/lib/bpf/btf.h                  |   3 +
 tools/lib/bpf/btf_dump.c             |   2 +-
 tools/lib/bpf/btf_relocate.c         |   2 +-
 tools/lib/bpf/gen_loader.c           | 187 ++++++++++++++++++++-------
 tools/lib/bpf/libbpf.c               |  26 +++-
 tools/lib/bpf/libbpf.map             |   2 +
 tools/lib/bpf/libbpf_internal.h      |  17 ++-
 tools/lib/bpf/linker.c               | 108 +++++++++++++---
 tools/lib/bpf/relo_core.c            |   2 +-
 tools/lib/bpf/skel_internal.h        |   3 +-
 tools/testing/selftests/bpf/Makefile |   7 +-
 13 files changed, 444 insertions(+), 84 deletions(-)

-- 
2.34.1


