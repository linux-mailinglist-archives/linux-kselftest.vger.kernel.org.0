Return-Path: <linux-kselftest+bounces-43255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5592ABE0493
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 21:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35E2543DCE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201742BDC3B;
	Wed, 15 Oct 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sTXEtr7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D0303A1F
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554818; cv=none; b=coccpHUX28PMCvrLKs0uqNWgD8k5X9OgHeEpF9QrRUb1+3DyyxfR0hYBrErOiaIDfrjsZ3ttx3fUXZclWgjME0GJvag2/AOkTc0sa2CygoSX51MYVnWirewdZWd//0uMrYNv/zkhbTJRVJU/ZfnUxAZWUjRZbL7WGUFdRth/5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554818; c=relaxed/simple;
	bh=sdq4ws5usmc98rsRoCAVeqpBx+16F1AHykhqmbfPX2w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MApzNqt4MIw6Wl+BBMF4tFhPEWpWyF5dhZoTR+HMqmHF6IcydBf2F/jQdlmVuLVGzA0fnHKFfXi1HYX4CVa/uGQNa0KQlKeR8E9e2VNFqrqOCPq+TCZRik+T+3pK13mmElubYEWdctsyDCia2QuYOkHyTmtV0VVQu0a7EgeFF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1sTXEtr7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-269939bfccbso128484335ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760554812; x=1761159612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqsd/vPXiuTR4hJNd2SCH3oN5KwWIK1dnn9ppreK3H0=;
        b=1sTXEtr7vUkiMkQ0uHR08smc/iooqnEyjuY+W9wks1tsBYPA+m+6Lx3ca4hy/SZyFb
         ATnMlJ/BVgpcUNTguAiYaD2KfbD+ZoRU7aK7GynqE2O8C4WqZMrYMbStaxnLY5qxSnW1
         d4cf29GXLL2X/IDonSpO9lJJrONMW/YtyY7o2p93jbzit+lFQfvuSqgmvpi5TXaMcB7T
         F7oX8KU0xjEItAtgkTT5DkGRKI2ONtD33MMGl2NqQ4EIL74n8F4SZkw6OgAA/uKVwURn
         yUotVHDKCLff4DHp2OJ/3H5zbQIBi9bHAKBQZPU8e7fC1L1Q+ZcwDZkp3M1UIJ658puv
         ymOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554812; x=1761159612;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqsd/vPXiuTR4hJNd2SCH3oN5KwWIK1dnn9ppreK3H0=;
        b=OwitVEZKTvjtguXWU70s8mCKHbUH+q8h8eupT2sCA2eJpvra5Lu8IbUeFk7b0Yr3A/
         wTpZ2T0djYSqeJ6L36UMau7pdnPAh3xyhNioEgbV0jF+r6YWB3k3iGtf8I9VVS58uEiE
         u5oVlfsS7wrV3gaTPjS1PNnGhQ0pKvrUHz/T1cEszPUElesxBAS0D6bV/L71o1+i0KrE
         sd2dRpQNvpPvPPMVQD2x+KtlPA8nYrSeykjMbi/v12R+GwkHTynAKqVDpALKFkKCcsDs
         JqEJawq4LTqunWLJHTQLZPIIqCO7bD2J0siAMp5waWhpcyVvDfMjcPEI+Jd3/3Nk1GcA
         PoFA==
X-Forwarded-Encrypted: i=1; AJvYcCU3B/QaXpqxYq1ZjjVxARl2ywn1kwuuUYdNKX8PLEPd6x8qjwTlcWAQKxghW9OqWUuIlTHlQn4+aGyjC7KZL5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBkzdZ8R4fdWiUsd/GoiOLXYrR3XuWfxoyH50Zvevx7TfgvM/
	MeWrXDOod17TU8xavesO5WEvZoz9AM9SQO9F1/kTS2Zsd5ID5KMScg2zYnxcWVXjFTFNTAW4OPo
	wCwxxDA==
X-Google-Smtp-Source: AGHT+IFnNgFHzdVwVBgjv1vYxeJtKWTDydfUHZWWQm4sogrJBUuU/RaThVnJNJ/l8yi1LMJs0OC3cJqUm/M=
X-Received: from plhy4.prod.google.com ([2002:a17:902:d644:b0:290:9abe:4419])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec81:b0:290:6b30:fa8
 with SMTP id d9443c01a7336-2906b301097mr149049165ad.23.1760554811768; Wed, 15
 Oct 2025 12:00:11 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:58:54 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <cover.1760551864.git.wyihan@google.com>
Subject: [RFC PATCH RESEND 0/3] mm: Fix MF_DELAYED handling on memory failure
From: Lisa Wang <wyihan@google.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: david@redhat.com, rientjes@google.com, seanjc@google.com, 
	ackerleytng@google.com, vannapurve@google.com, michael.roth@amd.com, 
	jiaqiyan@google.com, tabba@google.com, dave.hansen@linux.intel.com, 
	Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resend to correct the mailing list address]

Hello,

This patch series addresses an issue in the memory failure handling path
where MF_DELAYED is incorrectly treated as an error. This issue was
revealed because guest_memfd=E2=80=99s .error_remove_folio() callback retur=
ns
MF_DELAYED.

Currently, when the .error_remove_folio() callback for guest_memfd returns
MF_DELAYED, there are a few issues.

1. truncate_error_folio() maps this to MF_FAILED. This causes
   memory_failure() to return -EBUSY, which unconditionally triggers a
   SIGBUS. The process=E2=80=99 configured memory corruption kill policy is=
 ignored
   - even if PR_MCE_KILL_LATE is set, the process will still get a SIGBUS
   on deferred memory failures.

2. =E2=80=9CFailed to punch page=E2=80=9D is printed, even though MF_DELAYE=
D indicates that
   it was intentionally not punched.

The first patch corrects this by updating truncate_error_folio() to
propagate MF_DELAYED to its caller. This allows memory_failure() to return
0, indicating success, and lets the delayed handling proceed as designed.
This patch also updates me_pagecache_clean() to account for the folio's
refcount, which remains elevated during delayed handling, aligning its
logic with me_swapcache_dirty().

The subsequent two patches add KVM selftests to validate the fix and the
expected behavior of guest_memfd memory failure:

The first test patch verifies that memory_failure() now returns 0 in the
delayed case and confirms that SIGBUS signaling logic remains correct for
other scenarios (e.g., madvise injection or PR_MCE_KILL_EARLY).

The second test patch confirms that after a memory failure, the poisoned
page is correctly unmapped from the KVM guest's stage 2 page tables and
that a subsequent access by the guest correctly notifies the userspace VMM
with EHWPOISON.

This patch series is built upon kvm/next. In addition, to align with the
change of INIT_SHARED and to use the macro wrapper in guest_memfd
selftests, we put these patches behind Sean=E2=80=99s patches [1].

For ease of testing, this series is also available, stitched together, at
https://github.com/googleprodkernel/linux-cc/tree/memory-failure-mf-delayed=
-fix-rfc-v1=20

[1]: https://lore.kernel.org/all/20251003232606.4070510-1-seanjc@google.com=
/T/

Thank you,


Lisa Wang (3):
  mm: memory_failure: Fix MF_DELAYED handling on truncation during
    failure
  KVM: selftests: Add memory failure tests in guest_memfd_test
  KVM: selftests: Test guest_memfd behavior with respect to stage 2 page
    tables

 mm/memory-failure.c                           |  24 +-
 .../testing/selftests/kvm/guest_memfd_test.c  | 233 ++++++++++++++++++
 2 files changed, 248 insertions(+), 9 deletions(-)

--=20
2.51.0.788.g6d19910ace-goog


