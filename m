Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0784350034
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 14:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhCaM1J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 08:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235548AbhCaM1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 08:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617193621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w05Yiprz2DAkrl/VfB1KsTtz5xzVGlEVY+yQ28kxkrM=;
        b=SIY+dSUAvGt0j89PWIWggTmaD1IvkQel7beacsv5iwhu6Uf+Qjp2+qxsm1HzTFNBXydSyu
        2EXBKgJCzOzJMGjML7+sCIuxUE0mJLNj2Lqawourzkez/MDrMqj8F9uj34yNLkDzmTQZPA
        MGrd/c0gNtdfCoe3Qa2lulGTyhI1Uxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-jZzSQNsxMoaIKLo1-3Tg7A-1; Wed, 31 Mar 2021 08:26:59 -0400
X-MC-Unique: jZzSQNsxMoaIKLo1-3Tg7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B5191018F7D;
        Wed, 31 Mar 2021 12:26:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-218.ams2.redhat.com [10.36.114.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C04FB23E1;
        Wed, 31 Mar 2021 12:26:52 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/4] kvm: cpuid: fix cpuid nent field
Date:   Wed, 31 Mar 2021 14:26:45 +0200
Message-Id: <20210331122649.38323-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series aims to clarify the behavior of 
KVM_GET_EMULATED_CPUID and KVM_GET_SUPPORTED
ioctls, and fix a corner case where the nent field of the
struct kvm_cpuid2 is matching the amount of entries that kvm returns.

Patch 1 proposes the nent field fix to cpuid.c,
patch 2 updates the ioctl documentation accordingly and 
patches 3 and 4 provide a selftest to check KVM_GET_EMULATED_CPUID
accordingly.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
v2:
- better fix in cpuid.c, perform the nent check after the switch statement 
- fix bug in get_emulated_cpuid.c selftest, each entry needs to have at least
  the padding zeroed otherwise it fails.

Emanuele Giuseppe Esposito (4):
  kvm: cpuid: adjust the returned nent field of kvm_cpuid2 for
    KVM_GET_SUPPORTED_CPUID and KVM_GET_EMULATED_CPUID
  Documentation: kvm: update KVM_GET_EMULATED_CPUID ioctl description
  selftests: add kvm_get_emulated_cpuid
  selftests: kvm: add get_emulated_cpuid test

 Documentation/virt/kvm/api.rst                |  10 +-
 arch/x86/kvm/cpuid.c                          |  35 ++--
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/processor.h  |   1 +
 .../selftests/kvm/lib/x86_64/processor.c      |  33 +++
 .../selftests/kvm/x86_64/get_emulated_cpuid.c | 198 ++++++++++++++++++
 7 files changed, 256 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/get_emulated_cpuid.c

-- 
2.30.2

