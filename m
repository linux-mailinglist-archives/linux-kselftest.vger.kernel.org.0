Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2BF358240
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 13:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhDHLn3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 07:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230434AbhDHLn0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 07:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617882195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TlJwbyVHILxzSJx1fvaYPc1QqoC+7GiXUwRC58bfvdQ=;
        b=Gl/LwUlT1qQiSGn9Aj/ndNlOyh8ujI9R/qmlhl0TbqSmuQKvNcr44qpAvZvbkcZoW/s49U
        qgetNWJ/EtnjtIMpgOXMlBuRtYMDtp+mJLW5xHRKG+osDMIln7uSCRAqA0WjffHgSB1Hn7
        v22IV+2dt4u//eyRFSj/e+WCbrvwIE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-h2uHmcYrO_GCbt-Sf0xvuw-1; Thu, 08 Apr 2021 07:43:13 -0400
X-MC-Unique: h2uHmcYrO_GCbt-Sf0xvuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4343E5B378;
        Thu,  8 Apr 2021 11:43:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-155.ams2.redhat.com [10.36.113.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D56E18A60;
        Thu,  8 Apr 2021 11:43:05 +0000 (UTC)
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
Subject: [PATCH v4 0/4] KVM: cpuid: fix KVM_GET_EMULATED_CPUID implementation
Date:   Thu,  8 Apr 2021 13:42:59 +0200
Message-Id: <20210408114303.30310-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
v4:
- Address nitpicks given in the mailing list

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

