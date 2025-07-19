Return-Path: <linux-kselftest+bounces-37622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACEB0AF7D
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 13:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044741C200CF
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A184D23535F;
	Sat, 19 Jul 2025 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSH3AGrZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A722157B;
	Sat, 19 Jul 2025 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923596; cv=none; b=HaNVXT6sqmTbSxct1tK0ZYUsrAnFx6E049rJB8B9skNkdYq3WbJhyS6jicFe3DKQxaI+29yWF0wa0izzWRdm2mnmr5uTyxe2ecNXqbpFI+yFV/zqLotU0ospqSE+W87EbQgaMBh20eaQjr49JnbMibC9R+UK5CiU2qeS5GyHG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923596; c=relaxed/simple;
	bh=0mwzNFeEDlJbURltDxuzC/0HvB2I9wVfuHC9hjlqpfM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dKlafO1jvIe+31gsnpSJxjVBnNb0f07JxVQ4nyWWaQbItJNjvCBQRmXvokhvYgKRo12NskmN5HVDznvuZJQvtaZAVOoQEpyn/DRnEZQKVR+u7bgn+2ufsMlPIwd04QzjTY2v1uyQcNLYPrL24ZWFbBDI8QbAM3G+qOf2zp0LC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSH3AGrZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2363616a1a6so24755135ad.3;
        Sat, 19 Jul 2025 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752923594; x=1753528394; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErnUj0TrfehYqLSfVNQWUCMO7rE+AGCV77A73SWWF44=;
        b=HSH3AGrZak25Ym9+4VyTEznPsLXnNjUbBIGa2OwQmNWCl7+UmiMaKq5h7+QpducAtv
         QtVMBJ9NgRb0MYc0m1/g4PmJ3SWdRjyOpNJhakxLB3cd0Bs3mI8XyYmLMjEHGPsUaBy1
         +HvuXRDvif9JU+Xq/1QQG2ler3jDBpcGINWBbSMlDS/TjNJkDOUxzGd/CFMemKl8YyJM
         hXHkpK9nDAeI/prd74p9v/kS3Fd8SOc6fRm4mG+CxwdjtxzW4z1Snm0HXi/WfZkF8bpH
         4HcRocax9tsBnMZxyR2VTD0o8qcWPSWg4yj0bTaMZHwqr2sO5H8TMqMiGmo4jmbitptr
         DrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752923594; x=1753528394;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErnUj0TrfehYqLSfVNQWUCMO7rE+AGCV77A73SWWF44=;
        b=FlUOwTsgLAu8LEDds7egJXA2PFK4QQ3rbVOrYU2uvNqf7rUeEiqAj4p4s+4qL0JRv4
         75Hz4qOukvPnRf6w4Qw/ksskNd/0LWJNlM7YhMEgqAskmgKqmJ/wk13tyFoVTQ6uwf86
         eDug+KL1IAwAaz00HCg7IQMUY1YED/6WQjqii3jKkviW/JQcJsOEfk8hzNIWQRwvpf5S
         KWTitlOMP7xR/zWR13qZ+8Z8xhPCG40rGnUofqIEIgPuXGok+iz0DFZSlOT/zWRVf6Fb
         lQ0kjTqweYCXlPSEutFfo0qEWdX1q4PZLL1f43NO9E7R9YTeIbGk84N62RKApkgoQgad
         KbNA==
X-Forwarded-Encrypted: i=1; AJvYcCWU2EpzsjVxls8aGAaS+icZFNUldXm6WqENHtBF3NBL3BB9G/BrG3mFupYD+EjaFYAy1mEZ6GXuujLP/Hg=@vger.kernel.org, AJvYcCWVEpE79K/Zhe7TnoQScc2h+eBHDT8AwP5P3fnXio/zuviF/ly9lCUM6Xdmu8EQFmhCX5/WcXgUKauE/RT+h93Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1sCYnJP1WMW5/iZCF+W9Jb4pFWTq3tOCwMRIFbga6OZStOmA
	7H7xqGJmGr3Sj6LVUeYRZ6piabpyglkyUNnqOHfQ5VO+QyQbces+6qR+
X-Gm-Gg: ASbGncvCnsW6s0lzuxAmBbI6HpQpTxSJRmnAINN279dyZ9orB5ZhVJf/HK5D/ScZRm0
	Q6mEYTB6LhYopEDvs6QauJ/559IVOIGmZjlVgCOuWArl2pdAgOJpno9hBtsVvbqtCsL8sRuGd3y
	/otUQyL/OWyNGwZWurk9007jJ76UD3yhuwBtHqD4nrbty3vkwqBsM9zit2Xm4i1SgpNP2h7a2+6
	P9S6W2JgQJ9nyLyD4lFOIZeGfFJeK76esXZwki6+wWZ5sOO4O7dTvJndQQ+dNrLMK2tcN+R3u7a
	YR5ag9I+G0fC8HzySrIU3Tvjgb14nj3K66AhtjXpGNRo3Qo1xKaPOlUe7OEFeAY+zydnOqA6HL3
	nCMYuWGlWKUhs3A0k8kMs
X-Google-Smtp-Source: AGHT+IHgWhFSIa0YZjtHFpdAkGBDwT7thwYY+GMM19qe0nKu2IjFjS7vlWftbrR/tzPZYceTmT3k2A==
X-Received: by 2002:a17:902:c947:b0:23e:1aba:410e with SMTP id d9443c01a7336-23e25684a2dmr216606045ad.2.1752923594262;
        Sat, 19 Jul 2025 04:13:14 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4c81sm27388875ad.114.2025.07.19.04.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 04:13:13 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH RFC 0/4] landlock: add LANDLOCK_SCOPE_MEMFD_EXEC execution
Date: Sat, 19 Jul 2025 05:13:10 -0600
Message-Id: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMZ9e2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Mz3dzU3LQU3dSK1GTdxGSDFFMLIwNDi2RjJaCGgqLUtMwKsGHRSkF
 uzkqxtbUAqeaksWEAAAA=
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752923593; l=5097;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=0mwzNFeEDlJbURltDxuzC/0HvB2I9wVfuHC9hjlqpfM=;
 b=T4or0kAxS6LcwdHdKgCeBBFyDGKhf/asX5RpBfbbUWJjkblUmKpVWY70jaqgVbPgLfxQYmtiS
 NzlQebThU1DA2nC8KYDs2QQ60bEC06s47uwrz042tvQxY67+Xvs5ufU
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

This patch series introduces LANDLOCK_SCOPE_MEMFD_EXEC, a new Landlock
scoping mechanism that restricts execution of anonymous memory file
descriptors (memfd) created via memfd_create(2). This addresses security
gaps where processes can bypass W^X policies and execute arbitrary code
through anonymous memory objects.

Fixes: https://github.com/landlock-lsm/linux/issues/37

SECURITY PROBLEM
================

Current Landlock filesystem restrictions do not cover memfd objects,
allowing processes to:

1. Read-to-execute bypass: Create writable memfd, inject code,
   then execute via mmap(PROT_EXEC) or direct execve()
2. Anonymous execution: Execute code without touching the filesystem via
   execve("/proc/self/fd/N") where N is a memfd descriptor
3. Cross-domain access violations: Pass memfd between processes to
   bypass domain restrictions

These scenarios can occur in sandboxed environments where filesystem
access is restricted but memfd creation remains possible.

IMPLEMENTATION
==============

The implementation adds hierarchical execution control through domain
scoping:

Core Components:
- is_memfd_file(): Reliable memfd detection via "memfd:" dentry prefix
- domain_is_scoped(): Cross-domain hierarchy checking (moved to domain.c)
- LSM hooks: mmap_file, file_mprotect, bprm_creds_for_exec
- Creation-time restrictions: hook_file_alloc_security

Security Matrix:
Execution decisions follow domain hierarchy rules preventing both
same-domain bypass attempts and cross-domain access violations while
preserving legitimate hierarchical access patterns.

Domain Hierarchy with LANDLOCK_SCOPE_MEMFD_EXEC:
===============================================

Root (no domain) - No restrictions
  |
  +-- Domain A [SCOPE_MEMFD_EXEC] Layer 1
  |     +-- memfd_A (tagged with Domain A as creator)
  |     |
  |     +-- Domain A1 (child) [NO SCOPE] Layer 2
  |     |     +-- Inherits Layer 1 restrictions from parent
  |     |     +-- memfd_A1 (can create, inherits restrictions)
  |     |     +-- Domain A1a [SCOPE_MEMFD_EXEC] Layer 3
  |     |           +-- memfd_A1a (tagged with Domain A1a)
  |     |
  |     +-- Domain A2 (child) [SCOPE_MEMFD_EXEC] Layer 2
  |           +-- memfd_A2 (tagged with Domain A2 as creator)
  |           +-- CANNOT access memfd_A1 (different subtree)
  |
  +-- Domain B [SCOPE_MEMFD_EXEC] Layer 1
        +-- memfd_B (tagged with Domain B as creator)
        +-- CANNOT access ANY memfd from Domain A subtree

Execution Decision Matrix:
========================
Executor->  |  A  | A1 | A1a | A2 | B  | Root
Creator     |     |    |     |    |    |
------------|-----|----|-----|----|----|-----
Domain A    |  X  | X  | X   | X  | X  |  Y
Domain A1   |  Y  | X  | X   | X  | X  |  Y
Domain A1a  |  Y  | Y  | X   | X  | X  |  Y
Domain A2   |  Y  | X  | X   | X  | X  |  Y
Domain B    |  X  | X  | X   | X  | X  |  Y
Root        |  Y  | Y  | Y   | Y  | Y  |  Y

Legend: Y = Execution allowed, X = Execution denied

Scenarios Covered:
- Direct mmap(PROT_EXEC) on memfd files
- Two-stage mmap(PROT_READ) + mprotect(PROT_EXEC) bypass attempts
- execve("/proc/self/fd/N") anonymous execution
- execveat() and fexecve() file descriptor execution
- Cross-process memfd inheritance and IPC passing

TESTING
=======

All patches have been validated with:
- scripts/checkpatch.pl --strict (clean)
- Selftests covering same-domain restrictions, cross-domain 
  hierarchy enforcement, and regular file isolation
- KUnit tests for memfd detection edge cases

DISCLAIMER
==========

My understanding of Landlock scoping semantics may be limited, but this
implementation reflects my current understanding based on available
documentation and code analysis. I welcome feedback and corrections
regarding the scoping logic and domain hierarchy enforcement.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
Abhinav Saxena (4):
      landlock: add LANDLOCK_SCOPE_MEMFD_EXEC scope
      landlock: implement memfd detection
      landlock: add memfd exec LSM hooks and scoping
      selftests/landlock: add memfd execution tests

 include/uapi/linux/landlock.h                      |   5 +
 security/landlock/.kunitconfig                     |   1 +
 security/landlock/audit.c                          |   4 +
 security/landlock/audit.h                          |   1 +
 security/landlock/cred.c                           |  14 -
 security/landlock/domain.c                         |  67 ++++
 security/landlock/domain.h                         |   4 +
 security/landlock/fs.c                             | 405 ++++++++++++++++++++-
 security/landlock/limits.h                         |   2 +-
 security/landlock/task.c                           |  67 ----
 .../selftests/landlock/scoped_memfd_exec_test.c    | 325 +++++++++++++++++
 11 files changed, 812 insertions(+), 83 deletions(-)
---
base-commit: 5b74b2eff1eeefe43584e5b7b348c8cd3b723d38
change-id: 20250716-memfd-exec-ac0d582018c3

Best regards,
-- 
Abhinav Saxena <xandfury@gmail.com>


