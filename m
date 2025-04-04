Return-Path: <linux-kselftest+bounces-30148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F63A7C5D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 23:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD206177AB1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389CA1A9B39;
	Fri,  4 Apr 2025 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="djoVFmCJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407619DF4F;
	Fri,  4 Apr 2025 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743803747; cv=none; b=BuFj7e6pKqH/sETRAsdm3lhBoS8BGJgpXWhUfU2w/yAEe01qB1Z0KxF/PDXYGdMo/yVvo2RK7slGM0vlyIud3geiA3VxSyxeAgouHA8r04G0JnKDjLAPBANucNUaPYufpq/j9XhmgZ9FGXi8Yx69EzqpYAFiacRKQCBVJP28TZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743803747; c=relaxed/simple;
	bh=J78We6J2HcLadsfXet7EQXvV5nbB4sqDTC5iteeMCc8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gyV2eTLOPbzFRpkJsiRdSMZJ/XF7I357AF9+57mWObHMDJlRYFj512r5NhSfK+DKMhaR3oDUc2BpapGhS5OJn/0hXz3mc9y5d1WX3lG7Jd4NHuyUrwIUrvchjzH+j3f0aMropiSQkFcy2lAdYt7krpn6ODs+2R4ywCyPJ9hj5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=djoVFmCJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id F10C32025659;
	Fri,  4 Apr 2025 14:55:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F10C32025659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743803744;
	bh=FeA9Cf0c1PZ+ws0Z5CDTTAR7q+ny173QHBHM7KBUgtI=;
	h=From:To:Subject:Date:From;
	b=djoVFmCJ6IiEUFCgcnHVMYL2uhJrxONZOMEeqCPPJZ29Mlkcp78CX0ZSdnxS/9o9l
	 /fEb2VwO218boC8jjcffL5aTL62YId6BQ+gtUABHGlFJVKoARLb7cmHkfO5z3oAVzy
	 cYOkLZolxJNlLg45S5YOiA9ok749zp8yA2qASojw=
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
	xiyou.wangcong@gmail.com
Subject: [PATCH v2 security-next 0/4] Introducing Hornet LSM
Date: Fri,  4 Apr 2025 14:54:49 -0700
Message-ID: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
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

Maps are frozen to prevent TOCTOU bugs where a sufficiently privileged
user could rewrite map data between the calls to BPF_PROG_LOAD and
BPF_PROG_RUN. Additionally, both sparse-array-based and
fd_array_cnt-based map fd arrays are supported for signature
verification.


References:
  [1] https://lore.kernel.org/bpf/20220209054315.73833-1-alexei.starovoitov@gmail.com/
  [2] https://lore.kernel.org/bpf/CAADnVQ+wPK1KKZhCgb-Nnf0Xfjk8M1UpX5fnXC=cBzdEYbv_kg@mail.gmail.com/

Change list:
- v1 -> v2
  - Jargon clarification, maintainer entry and a few cosmetic fixes

Revisions:
- v1
  https://lore.kernel.org/bpf/20250321164537.16719-1-bboscaccy@linux.microsoft.com


Blaise Boscaccy (4):
  security: Hornet LSM
  hornet: Introduce sign-ebpf
  hornet: Add a light-skeleton data extactor script
  selftests/hornet: Add a selftest for the Hornet LSM

 Documentation/admin-guide/LSM/Hornet.rst     |  53 +++
 Documentation/admin-guide/LSM/index.rst      |   1 +
 MAINTAINERS                                  |   9 +
 crypto/asymmetric_keys/pkcs7_verify.c        |  10 +
 include/linux/kernel_read_file.h             |   1 +
 include/linux/verification.h                 |   1 +
 include/uapi/linux/lsm.h                     |   1 +
 scripts/Makefile                             |   1 +
 scripts/hornet/Makefile                      |   5 +
 scripts/hornet/extract-skel.sh               |  29 ++
 scripts/hornet/sign-ebpf.c                   | 411 +++++++++++++++++++
 security/Kconfig                             |   3 +-
 security/Makefile                            |   1 +
 security/hornet/Kconfig                      |  11 +
 security/hornet/Makefile                     |   4 +
 security/hornet/hornet_lsm.c                 | 239 +++++++++++
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/hornet/Makefile      |  51 +++
 tools/testing/selftests/hornet/loader.c      |  21 +
 tools/testing/selftests/hornet/trivial.bpf.c |  33 ++
 20 files changed, 885 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
 create mode 100644 scripts/hornet/Makefile
 create mode 100755 scripts/hornet/extract-skel.sh
 create mode 100644 scripts/hornet/sign-ebpf.c
 create mode 100644 security/hornet/Kconfig
 create mode 100644 security/hornet/Makefile
 create mode 100644 security/hornet/hornet_lsm.c
 create mode 100644 tools/testing/selftests/hornet/Makefile
 create mode 100644 tools/testing/selftests/hornet/loader.c
 create mode 100644 tools/testing/selftests/hornet/trivial.bpf.c

-- 
2.48.1


