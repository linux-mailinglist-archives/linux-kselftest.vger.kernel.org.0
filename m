Return-Path: <linux-kselftest+bounces-16759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D161965889
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 09:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12941F26278
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 07:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2515855F;
	Fri, 30 Aug 2024 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+h9PsQD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB51547D3;
	Fri, 30 Aug 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002993; cv=none; b=kg1R30nho4ZODkfpvxBIheR19AyrfEcgLo7Ol3Afouv/4xXgBgbpTC7DOo+Pr57IH6ZRiNrgpPqjzKwG7z1Sb9Zp667cmIh7UFtfoLP5cE3G2/6x/IyX0qQpi8smd077qdFqM07ifJjRlQPp//L88xa1/lVCmHdmAthIK8uk/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002993; c=relaxed/simple;
	bh=RTdhyC27zQmypfW45BAxn61iGISEveoyH4wC1jTicwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GnPPiwmd059/OoHlSOS66KXQU2beveqz8O4FurtlK7phG/PXIn1u1MNKlHEoGBi+rwqrtaNVMroQs8KFqBD3CxiRc1mrARMfTBUhdha6MlDFgyewBQGqE7EHM65nxsg+8YueNhG8drl5kDDL7xJBsYYV3pHq/Hm5b0KdW6oawZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+h9PsQD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71430e7eaf8so1279265b3a.1;
        Fri, 30 Aug 2024 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725002990; x=1725607790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6YAcG5QnyuO5s+Vuv1Woft5PQkjDq1iFkiBl9PUWN4=;
        b=Z+h9PsQDlClQZww0GhMghA9ZFVlBvvzSJaXhgvPYZfREjVYZSSzM+4g7UBYVkD3pEM
         XpBHRdy2YfanRK+x011UmzH96lRtjGZqMspyPapX4xZVjXXRz7xBntjzuYbik7Xw5t92
         C8HQiUcqbXo7OeZ/Sr1xdN54fxoERfRg7EsIIsZSfeh2ThVoU9lwZC3/rNLA+rc+fk2m
         REHfvFqciDH9HZoeFJFV5Ked1QrZVPbjjgt+Lz4HTiZLMCaJn+EkmC7yyVbgCD2g0E43
         4BxQ4xBoFBxGaw1bKikqvD5lTBWKmk8Uc/VikZBufSnFN2NIdCw7YWdwsK9KvzXooyd0
         pxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725002990; x=1725607790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6YAcG5QnyuO5s+Vuv1Woft5PQkjDq1iFkiBl9PUWN4=;
        b=pjBtcGKSRu+G66tUzp83Ye4Bhbd8EYgFvC6UFxSsphbRLN6ZGnmzwBJd7iGCBlvM28
         aw2PPdyQP/lN62eKN9FuNUNkb+D5oL2nRVj3vOE+5qWg1aDIVJm6GmsdxhS18jvzDP/v
         lUi+zslcDcMK/bkIizYA2PySgzaVHQD+RqzWVXxyCONepBeZ2fee3FrTGAjtTL+1f8S3
         U/EjU6wjXBqNGCDAsZRG11VCyQHS2DUB8C/cB0zaXkdZM/bnJTwk1joz9xDww7tQ3S1F
         luK6Px5EmaAizXxzpD+aCTUvL+nncfAOx3Kn+tJBl954tjJ9Rnt/kIHmFBLb1bnXFhgr
         jqaw==
X-Forwarded-Encrypted: i=1; AJvYcCWTgSn8ehhLUGdco/+K/HMORlMxcAJ4RKRYBBUzrWy8YS8aua+i2t0YMze/CNMvylVtkJ3cfx6Kp5s7So0+tQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGd3VPob3M1Xg/kshHBB25sMPzCaQJ74iKJ0E8tyn/SIpL/y+
	4/o/tGz51tzua1fzVeex6kX066icFHUi9+b+xo0LNWLem1pRUfRuIIlE8bo3
X-Google-Smtp-Source: AGHT+IHG3B/lzMFMDCwLq1/yIMVkl7LdK285Ei+xmw99rsCHgIqQWKcdke+yJPsCV/PDI2L2mRSDkQ==
X-Received: by 2002:a05:6a20:d492:b0:1cc:eadd:754c with SMTP id adf61e73a8af0-1cceadd7daamr3019033637.50.1725002990500;
        Fri, 30 Aug 2024 00:29:50 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b4dd0sm21698085ad.15.2024.08.30.00.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:29:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/8] libbpf, selftests/bpf: Support cross-endian usage
Date: Fri, 30 Aug 2024 00:29:22 -0700
Message-Id: <cover.1724976539.git.tony.ambardar@gmail.com>
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
 tools/lib/bpf/btf.c                  | 196 ++++++++++++++++++++++++---
 tools/lib/bpf/btf.h                  |   3 +
 tools/lib/bpf/btf_dump.c             |   2 +-
 tools/lib/bpf/btf_relocate.c         |   2 +-
 tools/lib/bpf/gen_loader.c           | 187 +++++++++++++++++++------
 tools/lib/bpf/libbpf.c               |  54 ++++++--
 tools/lib/bpf/libbpf.map             |   2 +
 tools/lib/bpf/libbpf_internal.h      |  48 ++++++-
 tools/lib/bpf/linker.c               |  92 ++++++++++---
 tools/lib/bpf/relo_core.c            |   2 +-
 tools/lib/bpf/skel_internal.h        |   3 +-
 tools/testing/selftests/bpf/Makefile |   7 +-
 13 files changed, 502 insertions(+), 97 deletions(-)

-- 
2.34.1


