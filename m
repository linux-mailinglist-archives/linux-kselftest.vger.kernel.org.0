Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F7D35824D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDHLoH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 07:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231305AbhDHLoF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 07:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617882234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9iBaLNrNdHy5Myw5Ru7jrMYIVd0xBvqef8GrfatpKg=;
        b=ZzhLaX7XVlHnNA98G3ayqHGPO7DXUh7luxQZKKv92xktPJBKLi/wRdYavGcPr9mWuDFTfi
        zZeLJLC/BsNj25uPdd5BSELOuxIv/L67MaCcV3QG1ZifrZF+Hbsk6U5H1Zs7bUWqbb+98A
        mTGwvSnbkT1BhFhC/4hyEA1nMNqGLaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-RoBmdd_GPzeBTTdDIISv6A-1; Thu, 08 Apr 2021 07:43:50 -0400
X-MC-Unique: RoBmdd_GPzeBTTdDIISv6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D931B1883525;
        Thu,  8 Apr 2021 11:43:48 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-155.ams2.redhat.com [10.36.113.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A6C45B4A8;
        Thu,  8 Apr 2021 11:43:31 +0000 (UTC)
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
Subject: [PATCH v4 2/4] Documentation: KVM: update KVM_GET_EMULATED_CPUID ioctl description
Date:   Thu,  8 Apr 2021 13:43:01 +0200
Message-Id: <20210408114303.30310-3-eesposit@redhat.com>
In-Reply-To: <20210408114303.30310-1-eesposit@redhat.com>
References: <20210408114303.30310-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

