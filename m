Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB95035003A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhCaM1l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 08:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235584AbhCaM1O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 08:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617193634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9iBaLNrNdHy5Myw5Ru7jrMYIVd0xBvqef8GrfatpKg=;
        b=hvKxHHNaHlurVTS7kY70bGU7VjSewrgWN89UkLFD7WMoj7HeMIQ8f0amlQGEJc7X1/ZtIJ
        bfMpZkV4rCDyyGeJNKupE2VxjedFo3YYs1ViMxpNoXt/tRSsm5GDA6ItikJpw+PBgxwV+G
        YYqbEacvwJTlz+NSEv5qGAugHAo5VGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-CDBisXgpPgyy02PVaj0T5A-1; Wed, 31 Mar 2021 08:27:12 -0400
X-MC-Unique: CDBisXgpPgyy02PVaj0T5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41E641922964;
        Wed, 31 Mar 2021 12:27:10 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-218.ams2.redhat.com [10.36.114.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E99FD1895C;
        Wed, 31 Mar 2021 12:27:05 +0000 (UTC)
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
Subject: [PATCH v2 2/4] Documentation: kvm: update KVM_GET_EMULATED_CPUID ioctl description
Date:   Wed, 31 Mar 2021 14:26:47 +0200
Message-Id: <20210331122649.38323-3-eesposit@redhat.com>
In-Reply-To: <20210331122649.38323-1-eesposit@redhat.com>
References: <20210331122649.38323-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KVM_GET_EMULATED_CPUID returns -E2BIG if the nent field of
struct kvm_cpuid2 is smaller than the actual entries, while
it adjusts nent if the provided amount is bigger than the
actual amount.

Update documentation accordingly. ENOMEM is just returned if the
allocation fails, like all other calls.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 Documentation/virt/kvm/api.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 307f2fcf1b02..8ba23bc2a625 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3404,12 +3404,10 @@ which features are emulated by kvm instead of being present natively.
 
 Userspace invokes KVM_GET_EMULATED_CPUID by passing a kvm_cpuid2
 structure with the 'nent' field indicating the number of entries in
-the variable-size array 'entries'. If the number of entries is too low
-to describe the cpu capabilities, an error (E2BIG) is returned. If the
-number is too high, the 'nent' field is adjusted and an error (ENOMEM)
-is returned. If the number is just right, the 'nent' field is adjusted
-to the number of valid entries in the 'entries' array, which is then
-filled.
+the variable-size array 'entries'.
+If the number of entries is too low to describe the cpu
+capabilities, an error (E2BIG) is returned.  If the number is too high,
+the 'nent' field is adjusted and the entries array is filled.
 
 The entries returned are the set CPUID bits of the respective features
 which kvm emulates, as returned by the CPUID instruction, with unknown
-- 
2.30.2

