Return-Path: <linux-kselftest+bounces-15834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9D595986C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E69B2297E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65C61CB15F;
	Wed, 21 Aug 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK6iMP8a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F91A284A;
	Wed, 21 Aug 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231385; cv=none; b=T6+ChN4M+X7n1o0edIpWijuLezRLn2ciSTv01eE15JV0EGI5WIj8NBxqxjnsCGo2IDzOdoNXlRfVPAAqaXzUIs2bc4QbPIF91FUCuACtIuEHkYjD3Rm1GBzK1gHD9xhyeHe2A7gejLot9qAs6XHt1/CnNBYJQYEi1iyoMUOtF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231385; c=relaxed/simple;
	bh=jItsKl48G4HoacL29xhAgJj4C5vLekKV/E7V7Qii9S4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uCAOMdieR0XLHyDurMe5CmGaW5WCy5cN/vYNyTfmze7decnrzupM+9BtKe8S5NkSfsfuVDjHNmi2jFtcC+dP7wibhLfaRfZ/JLAyLJNnYi8ar8aqjzc46fdrEsG/Sr3QFclxB4LwA8PA/lRdNLtZwiZG/r37Ur+uBOPaK2dcFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK6iMP8a; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20227ba378eso31374505ad.0;
        Wed, 21 Aug 2024 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724231383; x=1724836183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6TlrI1/hqehlwT1+UXhIaV4LOdcr7ZDugFdaqdnHRc=;
        b=YK6iMP8a++9ilvXLBYMk6joi+lVlSIli7pKPz4FQiA5O+JE4yU8/vjPkHZBlDAApht
         5Y+3yyd03p0KS5dSPHh4J8pAgpjYPHRtg2rnWh9Vj16l7zkO6N7meVpOSb/S29AuXGEG
         fLrgk4Zvv/lYuO9MC03IFuvvTL4X8hvNz3a59z0Ohs4YRyO+kyEMfJb2L4XX5HyhM/CJ
         75iPq28FOPvMK1PT8ZQZQWUJt1yZK+0g+vVYQdfgE+w1g8RCNOapV33wAqhiE80HlEUf
         jJ+7PObES0GoiPdKUO/bn+Lo3MUXL+x2/B1MYqBasbiddmrPfzcoWZ5nzRzawKLQy1nZ
         FnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231383; x=1724836183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6TlrI1/hqehlwT1+UXhIaV4LOdcr7ZDugFdaqdnHRc=;
        b=f43z0RPxzscIIyrltvzCocShipcYCOC6i34uRs7uXGSSGZn2UmnlG8W6QeaQMkWXu7
         vtbT8mssouBdffAIFzuywl/uXhu1KIsZIQaDdcFsHTQdIDlrIPwsnIfo0TeKK4qTSsd6
         Oxo44q+AxMn0IKhSmkwbNUw0eab9oQ7mQHa3hhzXd/i8PMQKmWwLg1wEHnt4SICZwbAh
         SJkrvdBwzIkF50H3MprUIZuvHCmQ0QmcrlcDHoOAjik3Wqi4LOPvuBYXUZ8K3iWqju5P
         WD+X8zmJo78cguiAs8ZZVfUMHWK0ZgddJzTzS+IuKhn71BtuKdUSkYfCLn2DazRbs7sN
         jiew==
X-Forwarded-Encrypted: i=1; AJvYcCX/XLmVtMlxJzFsPUcvnpx83PjlyZXTS8e1XqknDj7scGtIe5PXfhkiClwr7FkGLE4wJzpMotdDgkaSwZdYEfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02I5K+iKpoUuSOBNSJGLIapNnscaxbShonCJVi4QffYucQ0M2
	j9hUwoyNqrd/t190OGpq1Q94HDp3SirtRwNYl2mmdeo5e7v4E5m51i9det2O
X-Google-Smtp-Source: AGHT+IHzb7nc6m6ZvtWkvuuaiJyGDWXiVwuH/sMqDdtlEYgziLv0hatT6M5q7BXoC/3idsagqCu3tg==
X-Received: by 2002:a17:902:ec83:b0:1fb:973f:866 with SMTP id d9443c01a7336-2036819f6a4mr14720415ad.52.1724231383408;
        Wed, 21 Aug 2024 02:09:43 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm90191405ad.94.2024.08.21.02.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:09:42 -0700 (PDT)
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
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v1 0/8] libbpf, selftests/bpf: Support cross-endian usage
Date: Wed, 21 Aug 2024 02:09:18 -0700
Message-Id: <cover.1724216108.git.tony.ambardar@gmail.com>
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
libbpf and cross-endian build targets for selftests/bpf. Use cases range
from better BPF support for embedded systems based on e.g. big-endian
MIPS, to more build/test options for s390x systems.

Initial development and testing used mips64, since this arch makes
switching the build byte-order trivial and is thus very handy for A/B
testing. However, it lacks some key features (bpf2bpf call, kfuncs, etc)
making for poor selftests/bpf coverage.

Final testing takes the kernel and selftests/bpf cross-built from x86_64
to s390x, and runs the result under QEMU/s390x. That same configuration
could also be used on kernel-patches/bpf CI for regression testing endian
support or perhaps load-sharing s390x builds across x86_64 systems.

This thread includes some background regarding testing on QEMU/s390x and
the generally favourable results (3 failures running test_progs):
    https://lore.kernel.org/bpf/ZsEcsaa3juxxQBUf@kodidev-ubuntu/

Feedback and suggestions are welcome!

Best regards,
Tony


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
 tools/lib/bpf/btf.c                  | 167 +++++++++++++++++++++++--
 tools/lib/bpf/btf.h                  |   2 +
 tools/lib/bpf/btf_dump.c             |   2 +-
 tools/lib/bpf/btf_relocate.c         |   2 +-
 tools/lib/bpf/gen_loader.c           | 179 +++++++++++++++++++++------
 tools/lib/bpf/libbpf.c               |  26 +++-
 tools/lib/bpf/libbpf.map             |   2 +
 tools/lib/bpf/libbpf_internal.h      |  17 ++-
 tools/lib/bpf/linker.c               | 108 +++++++++++++---
 tools/lib/bpf/relo_core.c            |   2 +-
 tools/lib/bpf/skel_internal.h        |   3 +-
 tools/testing/selftests/bpf/Makefile |   7 +-
 13 files changed, 438 insertions(+), 80 deletions(-)

-- 
2.34.1


