Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E827828414
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 18:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfEWQnR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 12:43:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731045AbfEWQnR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 12:43:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1326F3003A4B;
        Thu, 23 May 2019 16:43:17 +0000 (UTC)
Received: from thuth.com (ovpn-116-94.ams2.redhat.com [10.36.116.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96EF56090E;
        Thu, 23 May 2019 16:43:12 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v1 0/9] KVM selftests for s390x
Date:   Thu, 23 May 2019 18:43:00 +0200
Message-Id: <20190523164309.13345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 23 May 2019 16:43:17 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series enables the KVM selftests for s390x. As a first
test, the sync_regs from x86 has been adapted to s390x, and after
a fix for KVM_CAP_MAX_VCPU_ID on s390x, the kvm_create_max_vcpus
is now enabled here, too.

Please note that the ucall() interface is not used yet - since
s390x neither has PIO nor MMIO, this needs some more work first
before it becomes usable (we likely should use a DIAG hypercall
here, which is what the sync_reg test is currently using, too...
I started working on that topic, but did not finish that work
yet, so I decided to not include it yet).

RFC -> v1:
 - Rebase, needed to add the first patch for vcpu_nested_state_get/set
 - Added patch to introduce VM_MODE_DEFAULT macro
 - Improved/cleaned up the code in processor.c
 - Added patch to fix KVM_CAP_MAX_VCPU_ID on s390x
 - Added patch to enable the kvm_create_max_vcpus on s390x and aarch64

Andrew Jones (1):
  kvm: selftests: aarch64: fix default vm mode

Thomas Huth (8):
  KVM: selftests: Wrap vcpu_nested_state_get/set functions with x86
    guard
  KVM: selftests: Guard struct kvm_vcpu_events with
    __KVM_HAVE_VCPU_EVENTS
  KVM: selftests: Introduce a VM_MODE_DEFAULT macro for the default bits
  KVM: selftests: Align memory region addresses to 1M on s390x
  KVM: selftests: Add processor code for s390x
  KVM: selftests: Add the sync_regs test for s390x
  KVM: s390: Do not report unusabled IDs via KVM_CAP_MAX_VCPU_ID
  KVM: selftests: Move kvm_create_max_vcpus test to generic code

 MAINTAINERS                                   |   2 +
 arch/mips/kvm/mips.c                          |   3 +
 arch/powerpc/kvm/powerpc.c                    |   3 +
 arch/s390/kvm/kvm-s390.c                      |   1 +
 arch/x86/kvm/x86.c                            |   3 +
 tools/testing/selftests/kvm/Makefile          |   7 +-
 .../testing/selftests/kvm/include/kvm_util.h  |  10 +
 .../selftests/kvm/include/s390x/processor.h   |  22 ++
 .../kvm/{x86_64 => }/kvm_create_max_vcpus.c   |   3 +-
 .../selftests/kvm/lib/aarch64/processor.c     |   2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  25 +-
 .../selftests/kvm/lib/s390x/processor.c       | 286 ++++++++++++++++++
 .../selftests/kvm/lib/x86_64/processor.c      |   2 +-
 .../selftests/kvm/s390x/sync_regs_test.c      | 151 +++++++++
 virt/kvm/arm/arm.c                            |   3 +
 virt/kvm/kvm_main.c                           |   2 -
 16 files changed, 514 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/processor.h
 rename tools/testing/selftests/kvm/{x86_64 => }/kvm_create_max_vcpus.c (93%)
 create mode 100644 tools/testing/selftests/kvm/lib/s390x/processor.c
 create mode 100644 tools/testing/selftests/kvm/s390x/sync_regs_test.c

-- 
2.21.0

