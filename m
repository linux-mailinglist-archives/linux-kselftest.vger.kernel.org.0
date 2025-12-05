Return-Path: <linux-kselftest+bounces-47133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFECCA8AC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 684793014C3E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60085347FC0;
	Fri,  5 Dec 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="TWpwCyzg";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="xZsXrtD5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9433F368;
	Fri,  5 Dec 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956411; cv=none; b=kFaaVbwh4RXMI5B32bc6buz0KF0gposs1yf/3J2iNpuWQhARS1IVz4ylAuF2ZpG2ofA0WGl1eBSmop7CHQgzrJPF00TRYVyJ2+GIS+hQ5LdvLPhUqcGB5Jypn0VDmrT6ejFLsJYFY+506ImbN890Ih/o4TvvewOcIRrLPFVkoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956411; c=relaxed/simple;
	bh=8uchhBNj6BK/KhFDe8mYfRWRhb+wBNysW5VCuQdG9fU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBV4GlA1FURRkFX1ae+IGdwKzXREZ872MTJhsxJ947yEBTCELio7ZltEew7hl9W3eRpG5KXFPGQD0ZEroUfl9DL2GN8moVI4Cif0p/XCD+K80lOVxB62sfFkb82DQPiZ4VchuGm3hmGrWfMBqIrp332mIBRu0yDqAPMYlkierfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=TWpwCyzg; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=xZsXrtD5; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1764956364; bh=weK/aS7u/TYhdycr7iNp9dK
	H2X/8olqegVmxJ3UYEh0=; b=TWpwCyzgmjzOhKNoTqftKQSRtAWxOw2iAR7GO71aL42dHSqyR0
	Huxwib6OcovyRPSYHYR9WP6pcqWhb8AWcjL+Iiq/ev6BOfNEUfsxckNtKXGeIOUDVmv33c4S0Fn
	VTVH7FFi2H6VA1Wa/tykMp4RpOeqUzJLzFXZ+UBjUTp8jRcllkgrKR+Tfv6uvl7xfTjyXS6oLvq
	TL5JcIKed5YgQ3CRd1G7oTuhbAsI0EZTILCF8RfQcca6B+HnI9stTDTldxYWqxvpR7S8zb0qWvZ
	ZC64K2tebcKA9EqVy7FlFyOoksdgYQpimrM4F/ybF0CACQaGwheXDPh8fjEw9MyKNYA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1764956364; bh=weK/aS7u/TYhdycr7iNp9dK
	H2X/8olqegVmxJ3UYEh0=; b=xZsXrtD5JaadNjtoFKD56YlPIzrXmOpT/KAwG1yJQJzQtg3ozW
	TktA6hmcde2fI9Sb9MB8D+ZVRxpuZz9OqVBQ==;
From: Daniel Hodges <git@danielhodges.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	vadim.fedorenko@linux.dev
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v2 0/5] Add cryptographic hash and signature verification kfuncs to BPF
Date: Fri,  5 Dec 2025 12:39:18 -0500
Message-ID: <20251205173923.31740-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends BPF's cryptographic capabilities by adding kfuncs for
SHA hashing and ECDSA signature verification. These functions enable BPF
programs to perform cryptographic operations for use cases such as content
verification, integrity checking, and data authentication.

BPF programs increasingly need to verify data integrity and authenticity in
networking, security, and observability contexts. While BPF already supports
symmetric encryption/decryption, it lacks support for:

1. Cryptographic hashing - needed for content verification, fingerprinting,
   and preparing message digests for signature operations
2. Asymmetric signature verification - needed to verify signed data without
   requiring the signing key in the datapath

These capabilities enable use cases such as:
- Verifying signed network packets or application data in XDP/TC programs
- Implementing integrity checks in tracing and security monitoring
- Building zero-trust security models where BPF programs verify credentials
- Content-addressed storage and deduplication in BPF-based filesystems

Implementation:

The implementation follows BPF's existing crypto patterns:
1. Uses bpf_dynptr for safe memory access without page fault risks
2. Leverages the kernel's existing crypto library (lib/crypto/sha256.c and
   crypto/ecdsa.c) rather than reimplementing algorithms
3. Provides context-based API for ECDSA to enable key reuse and support
   multiple program types (syscall, XDP, TC)
4. Includes comprehensive selftests with NIST test vectors

Patch 1: crypto: Add BPF hash algorithm type registration module
  - Adds bpf_crypto_shash module in crypto/ subsystem
  - Registers hash type with BPF crypto infrastructure
  - Enables hash algorithm access through unified bpf_crypto_type interface
  - Implements callbacks: alloc_tfm, free_tfm, hash, digestsize, get_flags
  - Manages shash_desc lifecycle internally

Patch 2: bpf: Add SHA hash kfunc for cryptographic hashing
  - Adds bpf_crypto_hash() kfunc for SHA-256/384/512
  - Extends bpf_crypto_type structure with hash operations
  - Updates bpf_crypto_ctx_create() to support keyless operations
  - Protected by CONFIG_CRYPTO_HASH2 guards
  - Uses kernel's crypto library implementations

Patch 3: selftests/bpf: Add tests for bpf_crypto_hash kfunc
  - Tests basic functionality with NIST "abc" test vectors
  - Validates error handling for invalid parameters (zero-length input)
  - Ensures correct hash output for SHA-256, SHA-384, and SHA-512
  - Adds CONFIG_CRYPTO_HASH2 and CONFIG_CRYPTO_SHA512 to selftest config

Patch 4: bpf: Add ECDSA signature verification kfuncs
  - Context-based API: bpf_ecdsa_ctx_create/acquire/release pattern
  - Supports NIST curves (P-256, P-384, P-521)
  - Adds bpf_ecdsa_verify() for signature verification
  - Includes size query functions: keysize, digestsize, maxsize
  - Enables use in non-sleepable contexts via pre-allocated contexts
  - Uses crypto_sig API with p1363 format (r || s signatures)

Patch 5: selftests/bpf: Add tests for ECDSA signature verification
  - Tests valid signature acceptance with RFC 6979 test vectors for P-256
  - Tests invalid signature rejection
  - Tests size query functions (keysize, digestsize, maxsize)
  - Uses well-known NIST test vectors with "sample" message

v2:

- Fixed redundant __bpf_dynptr_is_rdonly() checks (Vadim)
- Added BPF hash algorithm type registration module in crypto/ subsystem
- Added CONFIG_CRYPTO_HASH2 guards around bpf_crypto_hash() kfunc and its
  BTF registration, matching the pattern used for CONFIG_CRYPTO_ECDSA
- Added mandatory digestsize validation for hash operations

Test Results
============

All tests pass on x86_64 for both crypto_hash and ecdsa_verify test suites.

Daniel Hodges (5):
  crypto: Add BPF hash algorithm type registration module
  bpf: Add SHA hash kfunc for cryptographic hashing
  selftests/bpf: Add tests for bpf_crypto_hash kfunc
  bpf: Add ECDSA signature verification kfuncs
  selftests/bpf: Add tests for ECDSA signature verification kfuncs

 crypto/Makefile                               |   3 +
 crypto/bpf_crypto_shash.c                     |  94 ++++++
 include/linux/bpf_crypto.h                    |   2 +
 kernel/bpf/crypto.c                                | 306 ++++++++++++++++++++-
 tools/testing/selftests/bpf/config                 |   2 +
 .../testing/selftests/bpf/prog_tests/crypto_hash.c | 158 +++++++++++
 .../selftests/bpf/prog_tests/ecdsa_verify.c        |  74 +++++
 tools/testing/selftests/bpf/progs/crypto_hash.c    | 141 ++++++++++
 tools/testing/selftests/bpf/progs/ecdsa_verify.c   | 159 +++++++++++
 9 files changed, 931 insertions(+), 8 deletions(-)
 create mode 100644 crypto/bpf_crypto_shash.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/ecdsa_verify.c

-- 
2.51.0


