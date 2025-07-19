Return-Path: <linux-kselftest+bounces-37628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25289B0AFF3
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60441AA0E4A
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C16286436;
	Sat, 19 Jul 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4584JBp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838E220F33;
	Sat, 19 Jul 2025 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928890; cv=none; b=jvyXGgLrY8w682YDb9ubcZVt1Gf2omIvGWW7RxoeZm1ps/nkZwJ1XSoxKmZrGHKZdD9376PkDiMoD0a3OQwUlO5acZVJ15VutM1Op+/FFHTlC9TkY3FLw37YtUw3tXvBdeWmCzyxhHKzA4NJNmknzKA67Eh3INIfPMQ7edtg/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928890; c=relaxed/simple;
	bh=js+NEXzscP4oAohjSSvFlh4ITLOaKJD+68LJUSDlPeo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cJLoaEWWz5j71eFpUze4G4zgVy9YwjiTFZmd8MmREYK3llFdhGOuguw11bqB8ezvnRIS3lyagZGvVP3dHDtEJK3+ojhIVBGglwdVUcVGjXTddxemAu0UJBLEjRbRh0Q00E0x+rOXYMCKm7ifL8J9oeXLM6+exQWPsVfNZmgaSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4584JBp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748d982e92cso2093862b3a.1;
        Sat, 19 Jul 2025 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752928888; x=1753533688; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+A9fG1vUwfNuLTOBYgLudT4FTnVYQKEY46ePYx2dj0w=;
        b=g4584JBp75LMH7VNMbN0ThOhJ0nQeb6eN7jYL3LYWKS2ahRmHIFSqHVM6b+MKryvQR
         LBB9qtwnufZcx2ZqRBFRI4zYdR3ecPGmHhUIeBP+pAYKZ2vlXCSDdIKxuZmYAO1YaAPo
         lXcAPhgmi7KndX2upM33WdBBa0MzBv+FHRaelHGQDe6ISEY3eVVUZOkcEExLFEzeA00v
         VdaP+qxlbJLSvua/pT9ECdGKbPPrqVbpbY1A8PpHUWKqwprBLMQarSEFgfJKuQAjHIuI
         HrCyxZx3nc6Zy/nmop4jfof7oDDRdUUeQx+8G7vtojW0wcy7UrmTPz4D95dB7g6R0qZ7
         lcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752928888; x=1753533688;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+A9fG1vUwfNuLTOBYgLudT4FTnVYQKEY46ePYx2dj0w=;
        b=xDcKNBKnJ/9LxcWzGHPDpFEoz0F2QPVlJCZEp9Ep50IuQyOP8CAv15Id41uybjmh/D
         qbCAo7HRFRqZ63SADTy1oiOBpyUcj4Ieqi521Gsgi1zxFKd0O9aax1J8BW2S9YKixOCC
         Ogo5NhUa2ByPQynqh/+jLBsNlbVcZgMO+Bg0uJ8z+qOUluGyqHsqn4KkegPuUT17TEA9
         aDK8/ZEtc99pR6uRz8yVhGZyoYAD2ibopcPZ/lhmbWGaasSyyVoNL6j2x7dGnXcJevqL
         +8rrVzBb8jD0/Pam7r53+syLU6A3ye1oEzHmaKn+3otZA4I+O3DcP7XUFnFXQ59tXp3Q
         8LHw==
X-Forwarded-Encrypted: i=1; AJvYcCV4s9J/Z+ZJS2sqeK7lLP0C5gw8VVhxY4VpcEOTHrtY4hLDMB93hGEbB5wtiqxAgro/FYXEtFU/NI6bZDPOoMVX@vger.kernel.org, AJvYcCXtKrdmEHDeCJNssUX5dvYMUCY+/uuOLE5TcY6/hCcSfh5HRWMpu2CLLAk+3mo82/Db30Z9yLqDVGVG6Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnRtM57v9Us8bVWRWH35CuJlLw06Jdj9HbOyb5+pvU1Nz9K9P
	rG2sjxN+4zUPe6/h359t8lgj2jdAJwHtmga76ICYbz2yHo/X1hjn7+cfYoPkOP9hYzM=
X-Gm-Gg: ASbGncstgtLjkL/5SHCF2297fULUXGeBqwkLM0eNi4LwEiEpfNcJYQGTLFRHk9f+3jK
	jRLEVsD220P4P84AQqW2JxUCzjzmnvWWBKLKATM1nzaCFQTev3MfQwryoG9GW6yXccxVwazH+s0
	1gPFLgcdRje5NCaCMrEz148/cmP6fZxDxQPi0G41XZjDtlmJ//tJoYCjmreYXIySeiJCe/QcdzU
	LQRcR7iQkga4VHDtkse5thUW7Xtepaj+5SGCl1ekIcHesh0eb/0LiAi286yaznV6ah+wprlwkn1
	l/wyU37YFMd3XamOeMIumg9278nvoGG/63pdLx/Bs0dT3Qa/iGSqtQrpYOv6Ut2Q5vYYvOqIndb
	F4fEAHY78BbrQ0P+GMlte
X-Google-Smtp-Source: AGHT+IGC6z7QNyz2PZQgG7VCCcPICPxMUNj+Y+sYGA5Syj47O6zNcy2fpWE6AIBAPerBeZvodkx5bQ==
X-Received: by 2002:a17:902:f745:b0:22e:421b:49b1 with SMTP id d9443c01a7336-23e24f9477dmr221114035ad.48.1752928887646;
        Sat, 19 Jul 2025 05:41:27 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4b36sm28630285ad.92.2025.07.19.05.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:41:27 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH RFC 0/3] selftests/landlock: scoping abstractions
Date: Sat, 19 Jul 2025 06:41:23 -0600
Message-Id: <20250719-landlock_abstractions-v1-0-2c4fd61f8973@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHOSe2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0NT3ZzEvJSc/OTs+MSk4pKixOQSoIZi3ZSkZIPExKQ0QwMzYyWg3oK
 i1LTMCrC50UpBbs5KsbW1AKdFmoBsAAAA
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752928886; l=5045;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=js+NEXzscP4oAohjSSvFlh4ITLOaKJD+68LJUSDlPeo=;
 b=i25NBAWuy6eBEXAUiiOmp/jRKEy9droqXe2PEgVaQNZ1zW9rDDcMmLg7q9J57ou6MWSUUsFko
 mVOFJka2i/0DNxH4w05JlAh++dV46uQs9QOXIV6nEo8eIx84AC2AOb4
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

Hi all,

I was starting to work on the memfd-exec[1] feature and observed that
Landlock's scoped-IPC features (abstract UNIX sockets and signals)
follow a consistent high-level model, which I'm calling a
resource-accessor pattern:

Resource Process <-> Accessor Process
    - Resource process: owns or manages the asset
        - socket creator (bind/accept)
        - signal handler  
        - memfd creator
    - Accessor process: attempts to use the asset
        - socket client (connect/sendto)
        - signal sender
        - memfd executor

RESOURCE-ACCESSOR PATTERN FUNDAMENTALS
======================================

This pattern appears fundamental to Landlock scoping because:

1. Consistent enforcement model: Landlock restrictions are enforced
   only on the accessor side; the resource side remains unconstrained
   across all scope types.

2. Reflects actual security boundaries: In practice, sandboxed
   processes typically need to access resources created by other
   processes, not the reverse.

3. Scalable design: This model works consistently whether processes
   are in parent-child relationships or independent peer domains.

4. Real-world usage patterns: Container runtimes and sandbox
   orchestrators routinely start multiple workers that restrict
   themselves independently.

CURRENT TEST COVERAGE GAP
=========================

Existing self-tests cover hierarchical resource <-> accessor pairs
but do not exercise the case where each task enters an independent
domain. While 'sibling_domain' tests exist, they still use
parent-child relationship patterns rather than true peer domains.

Current Coverage (Linear Hierarchies Only):
-------------------------------------------

Type 1: Parent-Child (scoped_domains)
   P1 ---- P2

Type 2: Three Generations (scoped_vs_unscoped)  
   P1 ---- P2 ---- P3

Variations tested for both types:
- No domains
- Various scoped domain combinations  
- Nested domains within inherited domains
- Mixed domain types (SCOPE vs OTHER vs NONE)

Missing Coverage (True Sibling Scenarios):
------------------------------------------

Root
 |
 +-- Child A [various domain types]
 |
 +-- Child B [various domain types]

Missing test scenarios:
- A <-> B cross-sibling communication
- Mixed sibling domain combinations
- Sibling isolation enforcement
- Parent -> A, Parent -> B differential access

SOLUTION
========

This series implements the missing sibling pattern using the
resource-accessor model. The tests create a fork tree that looks
like this:

    coordinator (no domain)  
    |
    +-- resource_proc (Domain X) /* owns the resource */  
    |
    +-- accessor_proc (Domain Y) /* tries to access */

This directly addresses the missing coverage by creating two
independent child processes that establish peer domains, rather than
the hierarchical parent-child domains covered by existing tests.

Both children call landlock_restrict_self() for the first time, so
their struct landlock_domain->parent pointers are NULL, creating
true peer domains. The harness exposes four test variants:

Variant name       | Resource domain | Accessor domain | Result   
-------------------|-----------------|-----------------|----------
none_to_none       | none            | none            | ALLOW    
none_to_scoped     | none            | scoped          | DENY     
scoped_to_none     | scoped          | none            | ALLOW    
scoped_to_scoped   | scoped          | scoped (peer)   | DENY

The scoped_to_scoped case was missing from current coverage.

TESTING
=======

All patches apply cleanly to v6.14-rc2 and pass on landlock/master.
The helpers are small and re-use the existing kselftest_harness.h
fixture/variant pattern. All patches have been validated with
scripts/checkpatch.pl --strict and show no warnings.

This series introduces **no kernel changes**, only selftests additions.

Feedback very welcome.

Thanks,
Abhinav

[1] https://github.com/landlock-lsm/linux/issues/37

Links:
- Landlock documentation: https://docs.kernel.org/userspace-api/landlock.html
- Landlock LSM kernel docs: https://docs.kernel.org/security/landlock.html
- Existing tests: tools/testing/selftests/landlock/scoped_*

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
Abhinav Saxena (3):
      selftests/landlock: move sandbox_type to common
      selftests/landlock: add cross-domain variants
      selftests/landlock: add cross-domain signal tests

 tools/testing/selftests/landlock/scoped_common.h   |   7 +
 .../landlock/scoped_cross_domain_variants.h        |  54 +++++
 .../landlock/scoped_multiple_domain_variants.h     |   7 -
 .../selftests/landlock/scoped_signal_test.c        | 237 +++++++++++++++++++++
 4 files changed, 298 insertions(+), 7 deletions(-)
---
base-commit: 5b74b2eff1eeefe43584e5b7b348c8cd3b723d38
change-id: 20250715-landlock_abstractions-dbc0aabf1063

Best regards,
-- 
Abhinav Saxena <xandfury@gmail.com>


