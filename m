Return-Path: <linux-kselftest+bounces-29570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47E5A6C071
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 17:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECCD48109F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6429022D4D6;
	Fri, 21 Mar 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GKkM3tBV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71F813635C;
	Fri, 21 Mar 2025 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575560; cv=none; b=CQiYNNYfYoGUjXfB/ifdTkxchuKu/cEvw696RXpS3YXf0O7Hr082b6FIMN2AMItCyrSpl2NqpiDtStJmmmh1hfAc38MToiDrKII1j0szVjOKhBR7CIEV1M2/Q/07oTJGeRLjjhR1vZD9E0eGHXWtoPerjKh4zHHFplYWb48vpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575560; c=relaxed/simple;
	bh=KCrW6VdjTBGcG5xVhzV8cvLuTrSb7ci7ktDtNKfOARw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DVNUBfhdO9UfMcsgbO0OI9SSFkZkMvRKgmG5agZrI9oDh/oXeNTyPodYbL2dxGzpRUxjDjMEyRdaOXrV1bjPffw++R7U7m3nGuI6E/rIrOSaJ8BVMVU6R05PikuEQUu+dfu6s+rf2RO/Bb51j7RtbPR3w1f1PVRz5MvN/YNb/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GKkM3tBV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id A89482025381;
	Fri, 21 Mar 2025 09:45:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A89482025381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742575558;
	bh=UursI/xvhQ5hRWoBdi4h81h10JoUmiA8ppPrOg9d7nE=;
	h=From:To:Subject:Date:From;
	b=GKkM3tBVsycOdf6jHb5dpcy8KLpft53f4wjA2IPZJzp33BrUowjyMuBeab4vDu0ei
	 82qdEixW+e5Amvm2gEbC6NhFou3VSE3zIY1L/Lzr7CL3FGMXOjnV+Bk1Pg4Hmm8AH6
	 gI2yt5r0LevO0Sq1ppiQz8TgrD/HYS/E2VnbSVBc=
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
Subject: [RFC PATCH security-next 0/4] Introducing Hornet LSM
Date: Fri, 21 Mar 2025 09:45:02 -0700
Message-ID: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces the Hornet LSM.

Hornet takes a simple approach to light-skeleton-based eBPF signature
verification. Signature data can be easily generated for the binary
data that is generated via bpftool gen -L. This signature can be
appended to a skeleton executable via scripts/sign-ebpf. Hornet checks
the signature against a binary buffer containing the lskel
instructions that the loader maps use. Maps are frozen to prevent
TOCTOU bugs where a sufficiently privileged user could rewrite map
data between the calls to BPF_PROG_LOAD and
BPF_PROG_RUN. Additionally, both sparse-array-based and
fd_array_cnt-based map fd arrays are supported for signature
verification.


Blaise Boscaccy (4):
  security: Hornet LSM
  hornet: Introduce sign-ebpf
  hornet: Add an example lskel data extactor script
  selftests/hornet: Add a selftest for the hornet LSM

 Documentation/admin-guide/LSM/Hornet.rst     |  51 +++
 crypto/asymmetric_keys/pkcs7_verify.c        |  10 +
 include/linux/kernel_read_file.h             |   1 +
 include/linux/verification.h                 |   1 +
 include/uapi/linux/lsm.h                     |   1 +
 scripts/Makefile                             |   1 +
 scripts/hornet/Makefile                      |   5 +
 scripts/hornet/extract-skel.sh               |  29 ++
 scripts/hornet/sign-ebpf.c                   | 420 +++++++++++++++++++
 security/Kconfig                             |   3 +-
 security/Makefile                            |   1 +
 security/hornet/Kconfig                      |  11 +
 security/hornet/Makefile                     |   4 +
 security/hornet/hornet_lsm.c                 | 239 +++++++++++
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/hornet/Makefile      |  51 +++
 tools/testing/selftests/hornet/loader.c      |  21 +
 tools/testing/selftests/hornet/trivial.bpf.c |  33 ++
 18 files changed, 882 insertions(+), 1 deletion(-)
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


