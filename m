Return-Path: <linux-kselftest+bounces-17021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7382596959B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF11BB23FAE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E641D6786;
	Tue,  3 Sep 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP/Ilcwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8CF1CFEA8;
	Tue,  3 Sep 2024 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348809; cv=none; b=oyGusoHwRa2VZJoXZmaFtajVlOM+pspXGEMvIpecXcbApXWq563aIIJepaj6ETB7qOo0yCTyk2CcSCLYT1mMMVD9QfTf40nUjahSMPqoOfjDA0BKBTTnwU6WTnPT0OUREwDJa2tvyPhvc0WZmKk8kLPRIBwPHRtAMQ5OShnG070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348809; c=relaxed/simple;
	bh=8eDxNUm16by693x5IjWAMeNlaxP/Dqky+pJCWa/k2Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CxyFwXXw4pG/50xJgLs+RU+oOMRV/cB6O6VzNVQ+OU3nqAH0QrRkLxQEXxY4s7WX+v6jgmzjTlByNUTOlezFUFSxa4WTMKtncxKEW68gQEUT+94159ytyS5ThpXz3+Ud6dwCffSQaU2J8dzbGmTnV8SI0IKWSkUsmC7cVQymiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP/Ilcwx; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5df9a9f7fe2so3116042eaf.2;
        Tue, 03 Sep 2024 00:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348807; x=1725953607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=plLaSOidIzq39oUlh7BQH7yfvERVCjZcsctiX0iwMTQ=;
        b=eP/IlcwxSFSfWR9JGopiP0aSEmj/cu+kI/KUk1JL6tiLI1ucMgU+LBBh/ep5tq5LQl
         fg8tBce+NdPBZceMMIb50kJY65AJxwPLYNZuQmJPwrgzTXOXpR9Pp4ap/eIsZWyAqVpo
         r/SRBi15msgjb1Akx3XlR55BbeGap/NrDzBrn8thrAfnKV2fFKftcGyrIqnJKNvUiEth
         EVgec1JqCgMYV3e3tcnKMnnQ4CaEwMQUTN6L0qIMU7VKzyq++0vYhuRd3o+/npSBJqdZ
         Q7dfex+B4LSTsVL8szjxmQ/6TE3nY7Aioyp0JgksiqMLEc7XjS1zMaD4O7nmNHlvV3TP
         /SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348807; x=1725953607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plLaSOidIzq39oUlh7BQH7yfvERVCjZcsctiX0iwMTQ=;
        b=ieYsaKlBY45/B5JBt9fAGIBF52DLfeTKoJxjGdvmFIkgcOld2J1P1L6O80+qSKPKuM
         OJiSe1MOTvE1kPMcexFKRYwt+1fAMtGnsm0v/iEbEgyS9xvgrcaaLHjkxN61JyYQfId6
         4Ghy6GWjNfa6TRl4KNagk0T2fQZZxK3MYGXdCLLmAHfq30VbRLQA5d1P7O1Jc9loCsTP
         KjNS3NsFOqQX3MPMDihCVc3abRnN226gD/VWNdj+i94tocXmYx4klRS2OPUKj6LbFsFu
         ifSXLQrsyEmvQuDKDQlMqIyHKuu74oaW5U+kR+1Lf/54tUj1wkSYFy3LYn1sfIYWzPjY
         o9cw==
X-Forwarded-Encrypted: i=1; AJvYcCUxytnB++9yZ+0qfSS8H+0o27HErW+bVS/sH1xGH2NWXgmxuoYPLfUkZI4IW2x6YJ6ziI9MKg73BXd43OJouDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBqc1lrAm5pvz59ZHC89Zmm+EenK7O2JEDnJ8DOc++7zbRzE1O
	aMbgZIK2ci2RfTzZIwjxNd+NgqM12m9pgoU/hA9enhcLIXC4u+MIxHp+hXUB
X-Google-Smtp-Source: AGHT+IHhbpNE1UGPoef70eW11jjz7LK3FdPA5SJjNe4wUzhFM1xurfyUFjjKKxod9PFHqBGdCXzuxg==
X-Received: by 2002:a05:6870:56a1:b0:25e:1f67:b3bb with SMTP id 586e51a60fabf-277d0329191mr9964826fac.10.1725348806739;
        Tue, 03 Sep 2024 00:33:26 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7176882e523sm1172980b3a.164.2024.09.03.00.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:33:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/8] libbpf, selftests/bpf: Support cross-endian usage
Date: Tue,  3 Sep 2024 00:32:57 -0700
Message-Id: <cover.1725347944.git.tony.ambardar@gmail.com>
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

The series touches many functional areas: BTF.ext handling; object access,
introspection, and linking; generation of normal and "light" skeletons.

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

Earlier versions and related discussion of the series are here:

v1: https://lore.kernel.org/bpf/cover.1724216108.git.tony.ambardar@gmail.com/
v2: https://lore.kernel.org/bpf/cover.1724313164.git.tony.ambardar@gmail.com/
v3: https://lore.kernel.org/bpf/cover.1724843049.git.tony.ambardar@gmail.com/
v4: https://lore.kernel.org/bpf/cover.1724976539.git.tony.ambardar@gmail.com/

Feedback and suggestions are welcome!

Best regards,
Tony


Changelog:
---------
v4 -> v5: (feedback from Andrii and Eduard)
 - add separate functions to byte-swap info metadata and records, and
   ensure ordering so record bswaps occur when metadata is native endian
 - use new and existing macros to iterate through info sections/records,
   and check embedded record sizes match that of info structs used
 - drop use of <cough> evil callbacks
 - move setting swapped_endian flag to after byte-swapping functions are
   called during initialization, allowing funcs to infer endianness and
   drop a 'bool native' call parameter
 - simplify byte-swapping macro used to generate light skeleton, and use
   internal lib funcs to swap info records instead of assuming all __u32
 - change info bswap library funcs to void return
 - rework/consolidate new debug statements to reduce their number
 - remove some unneeded handling of impossible errors, and drop a safety
   check already handled elsewhere
 - add and clarify some comments

v3 -> v4:
 - fix a use-after-free ELF data-handling error causing rare CI failures
 - move bswap functions for func/line/core-relo records to internal header
 - use bswap functions also for info blobs in light skeleton

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
 tools/lib/bpf/btf.c                  | 242 +++++++++++++++++++++++++--
 tools/lib/bpf/btf.h                  |   3 +
 tools/lib/bpf/btf_dump.c             |   2 +-
 tools/lib/bpf/btf_relocate.c         |   2 +-
 tools/lib/bpf/gen_loader.c           | 191 +++++++++++++++------
 tools/lib/bpf/libbpf.c               |  57 +++++--
 tools/lib/bpf/libbpf.map             |   2 +
 tools/lib/bpf/libbpf_internal.h      |  43 ++++-
 tools/lib/bpf/linker.c               |  80 +++++++--
 tools/lib/bpf/relo_core.c            |   2 +-
 tools/lib/bpf/skel_internal.h        |   3 +-
 tools/testing/selftests/bpf/Makefile |   7 +-
 13 files changed, 529 insertions(+), 106 deletions(-)

-- 
2.34.1


