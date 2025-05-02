Return-Path: <linux-kselftest+bounces-32214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C8AA7962
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 20:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC889C5812
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 18:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C899B266EF9;
	Fri,  2 May 2025 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZebQyXQN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69E376;
	Fri,  2 May 2025 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746211474; cv=none; b=u3u86x7ofDZziWrhPLKlRKmdrOIvhnb0uuBisTSLE/svA9b3FRf1zDGl0A5QIWLVyLWTc5fCzaD4i/tQCcXJ2sGQcG+ULxy1PO06t5gAhapkS8mDZyMxV/JY+4rz9KDxGkhwtxWKyz+kiy/abzJHXuR1xWVl32EAwtobsLjou0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746211474; c=relaxed/simple;
	bh=LWm2Mewi0nFsm/A6RwwDy26RvhP0+n0VoXoQ4yv8rig=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e/pjH2iw6VUElVu2h28WRYK2lx/dKLYyAsPLal7eToKdsE4kRSRc6a3VyX0s9T2rKKC74oREr6QCihxXu0Fpka3EDuwoyfbnfmrsewVa5dCg0bJRTFM5vwDM9Dt+QFKKv6UFybuH/tF4fye8jcEukcQsWgoO/Zo4K6RAVVFMZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZebQyXQN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2C212111574;
	Fri,  2 May 2025 11:44:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2C212111574
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746211472;
	bh=aEe0PfwCQ3p3kPpyx+RuNZSjsrvOc2pL1wXnh7jwV18=;
	h=From:To:Subject:Date:From;
	b=ZebQyXQNFVO/se60BdDeY4wGv06VFo7Ggfizpn795gClnXruqrZ2LZWKTCxrAvIx7
	 EsftJAIyCwyPDU/Fxjd5QombyTS2FTw3NBrVGIVAtxI3Rqv+JPjlvgEMDKg4I/Jj4Y
	 o3mmqY9LLD8zmV/n5/QyvRTHOGmkyZAf/fZMO5+4=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Jonathan Corbet <corbet@lwn.net>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Neal Gompa <neal@gompa.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	xiyou.wangcong@gmail.com,
	Tyler Hicks <code@tyhicks.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [PATCH v3 0/4] Introducing Hornet LSM
Date: Fri,  2 May 2025 11:44:06 -0700
Message-ID: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces the Hornet LSM. The goal of Hornet is to
provide a signature verification mechanism for eBPF programs.

eBPF has similar requirements to that of modules when it comes to
loading: find symbol addresses, fix up ELF relocations, some struct
field offset handling stuff called CO-RE (compile-once run-anywhere),
and some other miscellaneous bookkeeping. During eBPF program
compilation, pseudo-values get written to the immediate operands of
instructions. During loading, those pseudo-values get rewritten with
concrete addresses or data applicable to the currently running system,
e.g., a kallsyms address or an fd for a map. This needs to happen
before the instructions for a bpf program are loaded into the kernel
via the bpf() syscall. Unlike modules, an in-kernel loader
unfortunately doesn't exist. Typically, the instruction rewriting is
done dynamically in userspace via libbpf. Since the relocations and
instruction modifications are happening in userspace, and their values
may change depending upon the running system, this breaks known
signature verification mechanisms.

Light skeleton programs were introduced in order to support early
loading of eBPF programs along with user-mode drivers. They utilize a
separate eBPF program that can load a target eBPF program and perform
all necessary relocations in-kernel without needing a working
userspace. Light skeletons were mentioned as a possible path forward
for signature verification.

Hornet takes a simple approach to light-skeleton-based eBPF signature
verification. A PKCS#7 signature of a data buffer containing the raw
instructions of an eBPF program, followed by the initial values of any
maps used by the program is used. A utility script is provided to
parse and extract the contents of autogenerated header files created
via bpftool. That payload can then be signed and appended to the light
skeleton executable.

Maps are checked that they are frozen to prevent TOCTOU bugs where a
sufficiently privileged user could rewrite map data between the calls
to BPF_PROG_LOAD and BPF_PROG_RUN. Additionally, both
sparse-array-based and fd_array_cnt-based map fd arrays are supported
for signature verification.

References:
  [1] https://lore.kernel.org/bpf/20220209054315.73833-1-alexei.starovoitov@gmail.com/
  [2] https://lore.kernel.org/bpf/CAADnVQ+wPK1KKZhCgb-Nnf0Xfjk8M1UpX5fnXC=cBzdEYbv_kg@mail.gmail.com/

Change list:
- v2 -> v3
  - Remove any and all usage of proprietary bpf APIs
  - Add optional systemd/pid1 whitelisting
  - Minor Makefile cleanup
  - Fixed buffer leak
  - Handled null current task
  - Made magic number required
  - Defensive checks against invalid buffer signature reads

- v1 -> v2
  - Jargon clarification, maintainer entry and a few cosmetic fixes

Revisions:
- v1
  https://lore.kernel.org/bpf/20250321164537.16719-1-bboscaccy@linux.microsoft.com
- v2
  https://lore.kernel.org/linux-security-module/20250404215527.1563146-1-bboscaccy@linux.microsoft.com

Blaise Boscaccy (4):
  security: Hornet LSM
  hornet: Introduce sign-ebpf
  hornet: Add a light skeleton data extractor script
  selftests/hornet: Add a selftest for the Hornet LSM

 Documentation/admin-guide/LSM/Hornet.rst      |  65 +++
 Documentation/admin-guide/LSM/index.rst       |   1 +
 MAINTAINERS                                   |   9 +
 crypto/asymmetric_keys/pkcs7_verify.c         |  10 +
 include/linux/kernel_read_file.h              |   1 +
 include/linux/verification.h                  |   1 +
 include/uapi/linux/lsm.h                      |   1 +
 scripts/Makefile                              |   1 +
 scripts/hornet/Makefile                       |   5 +
 scripts/hornet/extract-skel.sh                |  29 ++
 scripts/hornet/sign-ebpf.c                    | 411 ++++++++++++++++++
 security/Kconfig                              |   3 +-
 security/Makefile                             |   1 +
 security/hornet/Kconfig                       |  24 +
 security/hornet/Makefile                      |   4 +
 security/hornet/hornet_lsm.c                  | 250 +++++++++++
 security/selinux/hooks.c                      |  12 +-
 security/selinux/include/classmap.h           |   2 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/hornet/Makefile       |  58 +++
 tools/testing/selftests/hornet/fail_loader.sh |   3 +
 tools/testing/selftests/hornet/frozen_skel.h  | 393 +++++++++++++++++
 tools/testing/selftests/hornet/loader.c       |  22 +
 tools/testing/selftests/hornet/trivial.bpf.c  |  33 ++
 24 files changed, 1336 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
 create mode 100644 scripts/hornet/Makefile
 create mode 100755 scripts/hornet/extract-skel.sh
 create mode 100644 scripts/hornet/sign-ebpf.c
 create mode 100644 security/hornet/Kconfig
 create mode 100644 security/hornet/Makefile
 create mode 100644 security/hornet/hornet_lsm.c
 create mode 100644 tools/testing/selftests/hornet/Makefile
 create mode 100755 tools/testing/selftests/hornet/fail_loader.sh
 create mode 100644 tools/testing/selftests/hornet/frozen_skel.h
 create mode 100644 tools/testing/selftests/hornet/loader.c
 create mode 100644 tools/testing/selftests/hornet/trivial.bpf.c

-- 
2.48.1


