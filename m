Return-Path: <linux-kselftest+bounces-18027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D04979CDF
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2927DB21297
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB9013D899;
	Mon, 16 Sep 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuCkJVxJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDE94E1CA;
	Mon, 16 Sep 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475886; cv=none; b=L/UlDqVmZqN/s1jN9sewQHci7N/i0tqamVZ++mV5fU/V02IJTzvPPtcCrqaJZ3ylNAnfgTo8HZChQZKaPVbQaXVIUtRz1MtcDn3hNgkcAZWTm+JJiQoqFOO1tNLylex0+E3v31+yTwJKczKH3dudsiy5vTlP1IkOsq+rxoIwYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475886; c=relaxed/simple;
	bh=gqRynQUSZRGqxwHr46iMVMHj3+s//YFrC4V67dY74CA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KeVri+xbaKkCQrYJnoMBMctWGl9KeCvRoAA7G9+x1y+ttRVMoW/Z5LK2XxhkpOuPCfakkXw7sm0sYWM0Mk6uKHYIuROinVZK8ug25G4z77Iv1tWC1LqsBttErv1F7HNnACNIMUrZsrmzYYG9A8NTrpsdGMli6pMUdHySTPLJdnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuCkJVxJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so2464624a91.0;
        Mon, 16 Sep 2024 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726475884; x=1727080684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLvVzrKdki4ZOPaZqxzjdk+2YCizHOHVU3+2UYEzRGs=;
        b=fuCkJVxJSlMV1yKhlhECoSNOQz+WRghUYDmjrvESANUdJaENX+sKl4RcMhMzPzr0gp
         oun3/0Imc9VhjG4SmzujoQzOl/jd/j6xYQLipOBOKJztS8ktF88h0KlpOL4RgfCqVbIW
         boY6J8JhEyW69nmW0H7bL0P3y5uPBNq6IuuNUBLwNNjOf+gNpzcIeBe+NCb/LuCwOtd3
         HmVIpxEwzugVdS+BPIs3htxumMMaGteyAMQ6UUBWJoD0gAzyKBCLp9hjZ1xTJ8qA1h8K
         yGsbyF9qYXQo9TIPqvhY0uzQHyQUaJgTsVew0rfmMjos1ATc5Q1oBZRSqJN7PgQyX3Ep
         uLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726475884; x=1727080684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLvVzrKdki4ZOPaZqxzjdk+2YCizHOHVU3+2UYEzRGs=;
        b=J9rsQuN0lJGhXuUbR8pC3D5eJf9AwYSVSh+/gCkPW0QILRBoKU7igKUOgUepXKwE1M
         nGorkCfwvFPIcIt2IaYn3hE/TTf58MRngv5Pq4qZEbaQtYZZ3HWacRw5I5BKaY/uIsRO
         GSTbUur6BxLS+sXZdJCvzibercVfGA7Ro/DEIuNhQZbyjQafbbT2fyramhsgBKPCWVvJ
         7qqT2ZiEaPsurg4r3bRKz62Z/C7EHCZau3SY6umKh0ig8XMDbb2E4nqssK9DtgimglPI
         dYLBsFZXXvAISE0MfVprFe/H2hfyDWlSIh+lj5fcynqRv18VZYDEbTXL8IQycf/gDTXF
         mUEg==
X-Forwarded-Encrypted: i=1; AJvYcCVY1Wk9Y1HCe9Aht7xjlgjIthcPryKDXANEf1E/A3+gvAG9Ea8+rKE5vOcHU8env0/M9JPxQf/I8/O4js6j6xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0kZHr1JONS9Dxs8aWpLoNQKUvSR2OLBRQVJEC3ZI/V1NBRGZ
	aT4LAt+yjFvXp9X9VOphanef1qJgef0fwmDgs2AIOIZvj/cGrOyS37JnAg==
X-Google-Smtp-Source: AGHT+IEboUnWxuhNVJyEqs9ttMk9g3ULjcgesX7u77Kjpke1Y06cM3l1+AtojH6ept1ZfnQuQIQkcg==
X-Received: by 2002:a17:90a:d489:b0:2d3:cd57:bd3 with SMTP id 98e67ed59e1d1-2dbb9f3a7cemr15931466a91.29.1726475884227;
        Mon, 16 Sep 2024 01:38:04 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcbb424sm4585832a91.7.2024.09.16.01.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:38:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/8] libbpf, selftests/bpf: Support cross-endian usage
Date: Mon, 16 Sep 2024 01:37:39 -0700
Message-Id: <cover.1726475448.git.tony.ambardar@gmail.com>
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
v5: https://lore.kernel.org/bpf/cover.1725347944.git.tony.ambardar@gmail.com/

Feedback and suggestions are welcome!

Best regards,
Tony


Changelog:
---------
v5 -> v6: (comments from Andrii, Alexei, Eduard)
 - clarify info_blob_bswap() by making it explicitly conditional on
   non-native target endianness, and merge a pair of related debug
   statements
 - reformat debug statement in bpf_object_bswap_progs() on single line
 - update existing info setup functions to validate and parse info
   section metadata prior to any byte-swapping, and drop earlier added
   validation checks
 - rework cross-endian BTF.ext handling by using callback functions to
   byte-swap different types of info records, but after initial parsing
 - fix a bug always outputting BTF.ext raw data in native endianness
 - include v5 "Acked-by:" from Alexei, Yonghong

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
 tools/lib/bpf/btf.c                  | 284 +++++++++++++++++++++------
 tools/lib/bpf/btf.h                  |   3 +
 tools/lib/bpf/btf_dump.c             |   2 +-
 tools/lib/bpf/btf_relocate.c         |   2 +-
 tools/lib/bpf/gen_loader.c           | 187 +++++++++++++-----
 tools/lib/bpf/libbpf.c               |  56 ++++--
 tools/lib/bpf/libbpf.map             |   2 +
 tools/lib/bpf/libbpf_internal.h      |  45 ++++-
 tools/lib/bpf/linker.c               |  80 ++++++--
 tools/lib/bpf/relo_core.c            |   2 +-
 tools/lib/bpf/skel_internal.h        |   3 +-
 tools/testing/selftests/bpf/Makefile |   7 +-
 13 files changed, 527 insertions(+), 147 deletions(-)

-- 
2.34.1


