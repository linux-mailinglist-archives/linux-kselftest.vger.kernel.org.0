Return-Path: <linux-kselftest+bounces-47247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9DCABE78
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 04:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E443302A976
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BCB2E3AE9;
	Mon,  8 Dec 2025 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="Ul+sjP0K";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="igfOJXoE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49A32E5B2D;
	Mon,  8 Dec 2025 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162893; cv=none; b=P1rBDe8kNqhLbYgwfp3oSn3ewalHJj5tlmTuodpQiTMhMzwdxt4bX3w0d18C+50/bFkwGeWyFKJTSMVJRE8Z/2nQqGiGpjDwjLNzuRPR8xw0BmWbGojPwO3CmyqXkv2YDFqSdqNbait7DlT0DcOfwOzLkL76CSKl1CEQvJN+qOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162893; c=relaxed/simple;
	bh=hu6jl0a0wm7wKVWRdG1m6js9GdxZ0mHusHLso1jO/e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDbFFVm3Zod0ja4IAblj69lRMroraKNT27B50vVOthNPvIBZyi4NS6zQbK99Pgm2ETyi/fV1Bl5GCjMxOzP8jjDkblEytnPpOqYckI+RM4CF3Ze3JOT9Cj8ArpGwxZrlI/N/IrT2LN0yfTcc875O5l3tj35kFWqv26ev/5o47po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=Ul+sjP0K; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=igfOJXoE; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1765162877; bh=xYdpvWfCIMhh9LM+lJV+F39
	nsDyNJgaKBAWFxKYe3lY=; b=Ul+sjP0KE919sBR75McIDn1FwAq8Um9zJ0w4PId6M9tz7xvalm
	hHYcJRsXLzFm18pxKMmxQ1FCor0uVR00OmiBn07v7TO5JZkNl4SXqIs6Ocb7eCB57QYsQa6c4c8
	uFjVS+Vt1+Bdve/pP/JejFACgm282RrBzc28IPKfkOUD7AxlMdn1l2iCPRXMkPscflfkvK8iiKm
	3uol3O9e4s77ETPWtXZp8j+H8FW9MpF6Xq5YaJmFVTzKFvv17GF+TTG7FB8UpE4Q0R6fSEv4XI+
	o2htUabsoF+9ygg/0xljBw9btUIVpvSVuQu7mflKfy5ZbQiMEFQRMxK1i5rULoXm5jA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1765162877; bh=xYdpvWfCIMhh9LM+lJV+F39
	nsDyNJgaKBAWFxKYe3lY=; b=igfOJXoEtji4lIZtJPSBorNLObeFu2eVP8E9Ig7XencCFp48ia
	7mLDzcnF7Yaif+vnX70kKGLd2Cy7C4lhktAg==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	vadim.fedorenko@linux.dev,
	song@kernel.org,
	yatsenko@meta.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	yonghong.song@linux.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v3 0/6] Add cryptographic hash and signature verification kfuncs to BPF
Date: Sun,  7 Dec 2025 22:01:11 -0500
Message-ID: <20251208030117.18892-1-git@danielhodges.dev>
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

Patch 1: bpf: Extend bpf_crypto_type with hash operations
  - Adds hash operation callbacks to bpf_crypto_type structure
  - Adds hash() and digestsize() function pointers
  - Must come before crypto module to maintain bisectability

Patch 2: crypto: Add BPF hash algorithm type registration module
  - Adds bpf_crypto_shash module in crypto/ subsystem
  - Registers hash type with BPF crypto infrastructure
  - Enables hash algorithm access through unified bpf_crypto_type interface
  - Implements callbacks: alloc_tfm, free_tfm, hash, digestsize, get_flags
  - Manages shash_desc lifecycle internally

Patch 3: bpf: Add SHA hash kfunc for cryptographic hashing
  - Adds bpf_crypto_hash() kfunc for SHA-256/384/512
  - Updates bpf_crypto_ctx_create() to support keyless operations
  - Protected by CONFIG_CRYPTO_HASH2 guards
  - Uses kernel's crypto library implementations
  - Fixed u64 types for dynptr sizes to prevent truncation

Patch 4: selftests/bpf: Add tests for bpf_crypto_hash kfunc
  - Tests basic functionality with NIST "abc" test vectors
  - Validates error handling for invalid parameters (zero-length input)
  - Ensures correct hash output for SHA-256, SHA-384, and SHA-512
  - Adds CONFIG_CRYPTO_HASH2 and CONFIG_CRYPTO_SHA512 to selftest config
  - Refactored test setup code to reduce duplication

Patch 5: bpf: Add ECDSA signature verification kfuncs
  - Context-based API: bpf_ecdsa_ctx_create/acquire/release pattern
  - Supports NIST curves (P-256, P-384, P-521)
  - Adds bpf_ecdsa_verify() for signature verification
  - Includes size query functions: keysize, digestsize, maxsize
  - Enables use in non-sleepable contexts via pre-allocated contexts
  - Uses crypto_sig API with p1363 format (r || s signatures)

Patch 6: selftests/bpf: Add tests for ECDSA signature verification
  - Tests valid signature acceptance with RFC 6979 test vectors for P-256
  - Tests invalid signature rejection
  - Tests size query functions (keysize, digestsize, maxsize)
  - Uses well-known NIST test vectors with "sample" message
  - Adds CONFIG_CRYPTO_ECDSA to selftest config

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

Daniel Hodges (6):
  bpf: Extend bpf_crypto_type with hash operations
  crypto: Add BPF hash algorithm type registration module
  bpf: Add SHA hash kfunc for cryptographic hashing
  selftests/bpf: Add tests for bpf_crypto_hash kfunc
  bpf: Add ECDSA signature verification kfuncs
  selftests/bpf: Add tests for ECDSA signature verification kfuncs

 crypto/Makefile                               |   3 +
 crypto/bpf_crypto_shash.c                     |  95 ++++++
 include/linux/bpf_crypto.h                    |   2 +
 kernel/bpf/crypto.c                           | 306 +++++++++++++++++-
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/crypto_hash.c    | 147 +++++++++
 .../selftests/bpf/prog_tests/ecdsa_verify.c   |  75 +++++
 .../testing/selftests/bpf/progs/crypto_hash.c | 142 ++++++++
 .../selftests/bpf/progs/ecdsa_verify.c        | 160 +++++++++
 9 files changed, 925 insertions(+), 8 deletions(-)
 create mode 100644 crypto/bpf_crypto_shash.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/ecdsa_verify.c

-- 
2.51.0


