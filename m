Return-Path: <linux-kselftest+bounces-41783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAEFB82066
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C651188FDBB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C9B30DEBF;
	Wed, 17 Sep 2025 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTtD2/8g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8C2E5B19
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145873; cv=none; b=bz/pl8rbg7cldwdr7lksk67D87Vn5POyWGTvyJfrkMCs+A8UDJ3TbP77ggBjXSVtZYfiv4hzZlaI65RW+RunxgqB7jdMGvqM21nvAOn1a0nWTJmjoNyQ6EkoqJjAcPNsOXbkun5s+2/82hUSfALCksvNkTbMM+7my+Wcq/7e3ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145873; c=relaxed/simple;
	bh=7Kikigzj6v7xQLQkTso8DrWCMmvI9Q61cMxM45M2JCk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pW1ZqQ3wC6kszTd3Q8GDSk5pcgoGnwwKoh3h/8yY41IzWyiF+Bw8D0r2jCJ1Cutb+ouRsUbsD+2JJW21ugacE4uvjNrQAChwR15ws8ULB0KAAIVzCiFHChOjDpICmXUwAMF6aS1zUAli8YlW2niP+p454ku5TKaXoyR/d5H0pIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uTtD2/8g; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so163379a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758145870; x=1758750670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ajM88/oUy/Yl0c0O6x2AHxAgHs6Y/TSXT+30tD2YHi4=;
        b=uTtD2/8gWgJ7p0YrhfzpLA3sTUGCQuuGJ24bGofdsTBkQiYkbm9qpHhKvRmQGUsjtb
         gE1z9MqTgOJt+d6tII2srs3avatl49bEJ6QbEXrs6iO7p21pZXAdOHQ42h/xpXWrptmN
         9AaQAybRMuKrdmA/3mk1mGVok9sbzvJJX1fw+XNsR31sqSoEbqvQCYYCKLWHMkXs2klf
         EIl0eI1Bsr/ghcdDdNueV2D2xOfmAPRttF2h6gg3jXIizjFJYFUJzsXna/5r8/rktuHC
         bTxAliiaYPRKi8iMHezte7o3CIDJRaZecjmiF9vBLrxt7yjKM6vOCc849DKBzLxRLO8c
         Nxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145870; x=1758750670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajM88/oUy/Yl0c0O6x2AHxAgHs6Y/TSXT+30tD2YHi4=;
        b=eBUudsPJvLOVI9zSnmnWsSr0bbySrYyZ3cvwRf7R7mFSKM42s6CHuvZUdxDzPJ3rAc
         oD4WjfG23/ZZACL7L5IvjOw8hER5B07+QHSvV+yoSIRGDGbDxDTkvtHanaK9ENymNnTB
         UYkvDOnExzc0Ie8VWC+ZAnv5quAtSNJoRqNTqs7mO3MNWxk+5zmQO91hr1ToOa1wzJXj
         yi4/cs0MmvpNGcEIf/vX8JOnzZDzATdRjIS19X1Q+B21zVSZJOPhn6sXEMl0tSxi9xPI
         gH594M0tRrWbIn6zShI7ajhpWxFB3w8QnR0LD/UA7hgw2uS7qhKk1buzk+V5dRlkXUU8
         HXpA==
X-Forwarded-Encrypted: i=1; AJvYcCXKi6NQkfVBap7Gbc7MCHvXSqHfjPU8dgKs3luuF1lAZagjcmebGnThc9G4zGcyvE5jGARjVh9YPZ+zmk3q0yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/uyJ0Fm2lXSu+DUTtOicZUdBScVjIznpRWTbpZzQfGhwka0fR
	QsNXY6x6n3dhSdtm0knKKPSMwGBknfhG8Sk17FOjqKpRCW8Nawols7RuBl9IOuqpGCj+yNWnsuu
	kDtKI0mTuTl6rLg==
X-Google-Smtp-Source: AGHT+IGuJ6InU1uwz1vQZt4vJlEgwJ4Yf4LegHTymtlEqGFSXxcpP7nsg41o2ag4+s55H5sX67g9OdL22Qxqig==
X-Received: from pjbhl16.prod.google.com ([2002:a17:90b:1350:b0:32d:a0b1:2b03])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:264d:b0:329:e4d1:c20f with SMTP id 98e67ed59e1d1-32ee3e9047bmr4178903a91.9.1758145870033;
 Wed, 17 Sep 2025 14:51:10 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:48:36 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250917215031.2567566-1-jmattson@google.com>
Subject: [PATCH 0/4] KVM: selftests: Add test of SET_NESTED_STATE with 48-bit
 L2 on 57-bit L1
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Prior to commit 9245fd6b8531 ("KVM: x86: model canonical checks more
precisely"), KVM_SET_NESTED_STATE would fail if the state was captured
with L2 active, L1 had CR4.LA57 set, L2 did not, and the
VMCS12.HOST_GSBASE (or other host-state field checked for canonicality)
had an address greater than 48 bits wide.

Add a regression test that reproduces the KVM_SET_NESTED_STATE failure
conditions. To do so, the first three patches add support for 5-level
paging in the selftest L1 VM.

Jim Mattson (4):
  KVM: selftests: Use a loop to create guest page tables
  KVM: selftests: Use a loop to walk guest page tables
  KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
  KVM: selftests: Add a VMX test for LA57 nested state

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  21 +++
 .../testing/selftests/kvm/lib/x86/processor.c |  66 ++++-----
 tools/testing/selftests/kvm/lib/x86/vmx.c     |   7 +-
 .../kvm/x86/vmx_la57_nested_state_test.c      | 137 ++++++++++++++++++
 6 files changed, 195 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c

-- 
2.51.0.470.ga7dc726c21-goog


