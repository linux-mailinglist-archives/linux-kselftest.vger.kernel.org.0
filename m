Return-Path: <linux-kselftest+bounces-44241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F01C173F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 23:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8823D3B4C53
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114F36A604;
	Tue, 28 Oct 2025 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rg5BM50R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9D36A5E7
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692335; cv=none; b=iyBmExa6Bog8uK3xzhlTyS7a/nW7izoR6KHNVogYCrcXEu1KbZUcDlPxUeUhBDcQpxLaXhBG2+Lpcfk7mv+Aea9KCTCLyQJ1t48Z5SfZCWVTbR84/9/5S5u3f+ZCmo4AOpOUG5+V9KDAJz9okx2x9Ma410PrbVmSgAJ8gjElzEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692335; c=relaxed/simple;
	bh=NmfTEh2w90Vx1EUJhCoQ1DnPlLs96QxCb3TH8vg/crY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Xlj+IvCKJxBRzYAVMdrcl3WaZnvFr9IQFtb9/974WvSn7rlP2t9evOGdEHwLSiZlt+mN0YZUmAl7387sZbkOz3nOx/a81y4MjgoU64NWVQxUTu19zLihfpnVaTWU+5JrZSXjglUxorCWDMyFzofs5Urp4rpmzcj4HU+h34FaU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rg5BM50R; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27ee41e062cso73407615ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761692332; x=1762297132; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bafyIACgjKK14wqI7+UpK/XBf9Tl8hwNLLXvm7vBUiQ=;
        b=rg5BM50RbDfzDUoax+0Rg/P1gDZJHGNwZo+CuD7g5t4F0GRiwLg66Hy4/obTCnfM/8
         p2i1WBzwE5OR1dfm9erzIPV4PNgQzq0Z9+/OYVJQDGnYZYCiLOfqArpB4iTke4edxBOi
         /GWhXs8sa5RITns1Pu4+qo+eUpC3LKSKKHlJnFigfjyOqW4oYELByesmYjOzfYLQwYMp
         D0YyQO//FfiiHS52u/zh+LmI8o1Dnjg+jqUGYRGgG3olOFyGc/ONGVPLm2/No/FAzdqK
         Zyuxrnp4/oxOQ7E4Qb1tQXUWFdyBVK57loc9EY/y01FOGGRAfWQ76UFE+Yuef6xEg2dJ
         Op1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761692332; x=1762297132;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bafyIACgjKK14wqI7+UpK/XBf9Tl8hwNLLXvm7vBUiQ=;
        b=Hem60p3U/Xvjv9G+R7idLnH1qddvIiCJt8iIY9/YUAjxc4tBsWkB9SBNRqQZzoH3s7
         OhztLey8uGIJdYvTZjQQA7RrnJShCb5EtkyvaF94XVIvGFnqpQmu7jjQsbEVsh24xQ4s
         0C25K35N2S3TrT8BccnNzMQNqm/KqS7bJrQJ/R33gF3rq3n39peHx3HPl/TYtuxNNV/I
         LAYDwI/Bdd2u4xszYwECMTzkep4EIxblM6DWuyBQbE5P3yd2gJdQRytudkC4H3yclsAl
         0A6Zn41yxNmN+APqP1qJX41VBPYK/uwsS4UB8gRMFBL1Y6dPd4xt1HwQ+B55xxWJYluH
         YeUw==
X-Forwarded-Encrypted: i=1; AJvYcCUkocHHyDoxoWn7a72X0UE5qKzElYo5N7s7vBHh4XY0jotgeBZ8RWKSFIlmLxkyQBrg2cvxWJYv5gVVkjkI7KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHH3i3jwveiEIjJQmgfu3GmsS4m+NzRxDKjrymUNIJ8vK42h6
	mInGeAsU+ByItoGgAxzm1YT5MoUbBL50UAHAGsi+F96VazEwl4yPLk9RI3rwaqxHGquoUlSlSX1
	Q/3zxYN33XLznoQ==
X-Google-Smtp-Source: AGHT+IHKY2pClvohg4IWDjCOvNKT01DkzF2lTStYT3sIYIsj1O8Psfszn4vksBsANMyqzlJojr3dGZ1p5DLaig==
X-Received: from pjbgq17.prod.google.com ([2002:a17:90b:1051:b0:33d:acf4:5aac])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e847:b0:293:e5f:85d7 with SMTP id d9443c01a7336-294def69091mr8641645ad.55.1761692331928;
 Tue, 28 Oct 2025 15:58:51 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:30:38 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028225827.2269128-1-jmattson@google.com>
Subject: [PATCH v2 0/4] KVM: selftests: Test SET_NESTED_STATE with 48-bit L2
 on 57-bit L1
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Jim Mattson <jmattson@google.com>, 
	"Pratik R. Sampat" <prsampat@amd.com>, James Houghton <jthoughton@google.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Prior to commit 9245fd6b8531 ("KVM: x86: model canonical checks more
precisely"), KVM_SET_NESTED_STATE would fail if the state was captured
with L2 active, L1 had CR4.LA57 set, L2 did not, and the
VMCS12.HOST_GSBASE (or other host-state field checked for canonicality)
had an address greater than 48 bits wide.

Add a regression test that reproduces the KVM_SET_NESTED_STATE failure
conditions. To do so, the first three patches add support for 5-level
paging in the selftest L1 VM.

v1 -> v2
  Ended the page walking loops before visiting 4K mappings [Yosry]
  Changed VM_MODE_PXXV48_4K into VM_MODE_PXXVYY_4K;
    use 5-level paging when possible                       [Sean] 
  Removed the check for non-NULL vmx_pages in guest_code() [Yosry]

Jim Mattson (4):
  KVM: selftests: Use a loop to create guest page tables
  KVM: selftests: Use a loop to walk guest page tables
  KVM: selftests: Change VM_MODE_PXXV48_4K to VM_MODE_PXXVYY_4K
  KVM: selftests: Add a VMX test for LA57 nested state

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   4 +-
 .../selftests/kvm/include/x86/processor.h     |   2 +-
 .../selftests/kvm/lib/arm64/processor.c       |   2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  30 ++--
 .../testing/selftests/kvm/lib/x86/processor.c |  80 +++++------
 tools/testing/selftests/kvm/lib/x86/vmx.c     |   6 +-
 .../kvm/x86/vmx_la57_nested_state_test.c      | 134 ++++++++++++++++++
 8 files changed, 197 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c

-- 
2.51.1.851.g4ebd6896fd-goog


