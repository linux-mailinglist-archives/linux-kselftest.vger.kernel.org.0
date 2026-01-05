Return-Path: <linux-kselftest+bounces-48223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8111BCF505B
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 18:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED31A30090F6
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716CD31D380;
	Mon,  5 Jan 2026 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="KeIJmOjl";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="ywIlBxqJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981F14B96E;
	Mon,  5 Jan 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634778; cv=none; b=cYVzmy7M1Smhw1heVjJA8CRmaXkof1i08ex7jREphTzgobwmPMFXmrpNSLJtsJhnvp6DLctLvtFknn4LyGJbDeiUBYEPCtwBNCktKNuCmsq8GcQx9yJVJC6iEjUy1lXCvocjtSEZvfkP1C9uTqvrFoDsKCvSav5SvQj/fVTrvYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634778; c=relaxed/simple;
	bh=obs6thHji5iuQOiAZYiCgDDd+cav0QJu2vIzAWiiWJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oATZFMNMCWQvNbCcEDby4ZJG8RCN/R613e6SgTwyRIM32meN4k/zGdrxBYy8nw3MdD3rEpJz5Ey7FwV7UH3eeqZdQ1HaiI6t64GWDHA/aEFBeX4qonOGGEF6nKVhPpJnUOc2EECtASjB73YEQWiE6dJduYiEYkK3enwLRYUI5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=KeIJmOjl; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=ywIlBxqJ; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634676; bh=7dDcV1YLkUsP3eAwr4dlK/7
	tiXGtJ0DA2WX0a2C+Xi8=; b=KeIJmOjl/3Cp7si8p6HJrruyDQ3xwibsUDXakEthMMTLW5tr8e
	oKoLmFHWVQXCIVsDQQtp46fSJdMsCUITJ9xGrQAN6r7yA4EPoy8pwfVkWgRaz1te1Ce+k1qPX2D
	2At/0dZLjT3M2aCICdyd7yk8xk2jR5cJfyxsIeJKONg4C1ngtDEtDkG4SjT3Ft4GOwR25wyP1l0
	mY+yLGsr5S/VqyimVeTfccA68FxvpJLMEtGPtw8XMu9/ezBEsz7XHg5s7/K9MpEfeQAc8WUWrJh
	9W3q4PdnFLM5bHESZfdBBUk82YAsaLX7zQlISt9RlGYUD4t3c6k9L0qL8jMgzXmqeYg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634676; bh=7dDcV1YLkUsP3eAwr4dlK/7
	tiXGtJ0DA2WX0a2C+Xi8=; b=ywIlBxqJb6KQb6zoLxSEHboPEl9z1qM7o/ECmFo0x6f1aGeubK
	SY8b8NMiBwgmI2J3NW/0RaniAUicVAh8J3Dg==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Song Liu <song@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v4 0/6] Add cryptographic hash and signature verification kfuncs to BPF
Date: Mon,  5 Jan 2026 12:37:49 -0500
Message-ID: <20260105173755.22515-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series enhances BPF's cryptographic functionality by introducing
kernel functions for SHA hashing and ECDSA signature verification. The changes
enable BPF programs to verify data integrity and authenticity across
networking, security, and observability use cases.

The series addresses two gaps in BPF's cryptographic toolkit:

1. Cryptographic hashing - supports content verification and message digest
   preparation
2. Asymmetric signature verification - allows validation of signed data
   without requiring private keys in the datapath

Use cases include:
- Verifying signed network packets or application data in XDP/TC programs
- Integrity checks within tracing and security monitoring
- Zero-trust security models with BPF-based credential verification
- Content-addressed storage in BPF-based filesystems

The implementation leverages existing BPF patterns: it uses bpf_dynptr for
memory safety, reuses kernel crypto libraries (lib/crypto/sha256.c and
crypto/ecdsa.c) rather than reimplementing algorithms, and provides
context-based APIs supporting multiple program types.

v2:
- Fixed redundant __bpf_dynptr_is_rdonly() checks (Vadim)
- Added BPF hash algorithm type registration module in crypto/ subsystem
- Added CONFIG_CRYPTO_HASH2 guards around bpf_crypto_hash() kfunc and its
  BTF registration, matching the pattern used for CONFIG_CRYPTO_ECDSA
- Added mandatory digestsize validation for hash operations

v3:
- Fixed patch ordering - header changes now in separate first commit before
  crypto module to ensure bisectability (bot+bpf-ci)
- Fixed type mismatch - changed u32 to u64 for dynptr sizes in
  bpf_crypto_hash() to match __bpf_dynptr_size() return type (Mykyta)
- Added CONFIG_CRYPTO_ECDSA to selftest config (Song)
- Refactored test code duplication with setup_skel() helper (Song)
- Added copyright notices to all new files

v4:
- Reused common bpf_crypto_ctx structure for hash and signature operations
  instead of separate context types (Song)
- Fixed integer truncation in bpf_crypto_hash when data_len > UINT_MAX
- Corrected KF_RCU flags for ECDSA kfuncs (only bpf_ecdsa_verify needs KF_RCU)
- Updated MAINTAINERS file in test patches
- Refactored selftests to use crypto_common.h for kfunc declarations

Daniel Hodges (6):
  crypto: Add BPF hash algorithm type registration module
  crypto: Add BPF signature algorithm type registration module
  bpf: Add hash kfunc for cryptographic hashing
  selftests/bpf: Add tests for bpf_crypto_hash kfunc
  bpf: Add ECDSA signature verification kfuncs
  selftests/bpf: Add tests for ECDSA signature verification kfuncs

 MAINTAINERS                                   |   6 +
 crypto/Makefile                               |   6 +
 crypto/bpf_crypto_shash.c                     |  96 +++++++++
 crypto/bpf_crypto_sig.c                       |  60 ++++++
 crypto/bpf_crypto_skcipher.c                  |   1 +
 include/linux/bpf_crypto.h                    |   7 +
 kernel/bpf/crypto.c                           | 193 +++++++++++++++++-
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/crypto_hash.c    | 147 +++++++++++++
 .../selftests/bpf/prog_tests/ecdsa_verify.c   |  75 +++++++
 .../selftests/bpf/progs/crypto_common.h       |   7 +
 .../testing/selftests/bpf/progs/crypto_hash.c | 136 ++++++++++++
 .../selftests/bpf/progs/ecdsa_verify.c        | 157 ++++++++++++++
 13 files changed, 886 insertions(+), 8 deletions(-)
 create mode 100644 crypto/bpf_crypto_shash.c
 create mode 100644 crypto/bpf_crypto_sig.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/ecdsa_verify.c

-- 
2.51.0


