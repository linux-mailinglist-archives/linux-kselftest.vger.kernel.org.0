Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3914E359F4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhDIMys (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Apr 2021 08:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232615AbhDIMyr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Apr 2021 08:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617972873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t1x564ycJ2gyj0RLJZ2QQlV+6k3Blj33nf5guRDQz0g=;
        b=K8u28eslDeUMPRMvGBn2nlOazM2GYBCuBi3EJbNEHbpF7bub8oaPoIzGHklJzAHphdngb8
        0UUmYtkWbeelLYbG2+oqUS2Wfe4hF0G1VLS1o2f1UVRYdSS5AzLE3M1Wr9SEL7DcmNFk60
        UKgYPKLGqvblZ/Ufy9cHfoAvcaZWavQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-TDr1uGSDMkO_hGXeTkomAQ-1; Fri, 09 Apr 2021 08:54:31 -0400
X-MC-Unique: TDr1uGSDMkO_hGXeTkomAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FB5910054F6;
        Fri,  9 Apr 2021 12:54:29 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-61.ams2.redhat.com [10.36.114.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE51E10013C1;
        Fri,  9 Apr 2021 12:54:24 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v5 0/4] KVM: cpuid: fix KVM_GET_EMULATED_CPUID implementation
Date:   Fri,  9 Apr 2021 14:54:19 +0200
Message-Id: <20210409125423.26288-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series aims to clarify the behavior of the KVM_GET_EMULATED_CPUID
ioctl, and fix a corner case where -E2BIG is returned when
the nent field of struct kvm_cpuid2 is matching the amount of
emulated entries that kvm returns.

Patch 1 proposes the nent field fix to cpuid.c,
patch 2 updates the ioctl documentation accordingly and
patches 3 and 4 extend the x86_64/get_cpuid_test.c selftest to check
the intended behavior of KVM_GET_EMULATED_CPUID.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
v5:
- Better comment in cpuid.c (patch 1)

Emanuele Giuseppe Esposito (4):
  KVM: x86: Fix a spurious -E2BIG in KVM_GET_EMULATED_CPUID
  Documentation: KVM: update KVM_GET_EMULATED_CPUID ioctl description
  selftests: add kvm_get_emulated_cpuid to processor.h
  selftests: KVM: extend get_cpuid_test to include
    KVM_GET_EMULATED_CPUID

 Documentation/virt/kvm/api.rst                | 10 +--
 arch/x86/kvm/cpuid.c                          | 33 ++++---
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 .../selftests/kvm/lib/x86_64/processor.c      | 33 +++++++
 .../selftests/kvm/x86_64/get_cpuid_test.c     | 90 ++++++++++++++++++-
 5 files changed, 142 insertions(+), 25 deletions(-)

-- 
2.30.2

