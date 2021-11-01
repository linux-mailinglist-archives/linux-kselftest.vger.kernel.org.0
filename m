Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880CB441C1C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 15:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhKAOGa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 10:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231366AbhKAOGa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 10:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635775436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lHflTYf5NLbENikWzp+YZTdDYwuB7z5GdZSkSzXcqu8=;
        b=D3ZFw3lFpf/Y4UjvmWXkzbmc8+V4ZAVrq5X5/YiWia7c/WJ99nCzJr675HcPiqoa6sSfKs
        t/Mr3jP+fGbxZk8kXILqw7DrSuPO1m+wOonxsW8AgqSV2fNLEaEiTZMRP8ySI74k99RusM
        IbqVxaXSn4xES8HkAbClPvh+hwOEbRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-gEQNqKeLNLKgLtOtHIhZQQ-1; Mon, 01 Nov 2021 10:03:54 -0400
X-MC-Unique: gEQNqKeLNLKgLtOtHIhZQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5BB080DDE0;
        Mon,  1 Nov 2021 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81AE9101E59B;
        Mon,  1 Nov 2021 14:03:25 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Wei Huang <wei.huang2@amd.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 0/6] nSVM optional features
Date:   Mon,  1 Nov 2021 16:03:18 +0200
Message-Id: <20211101140324.197921-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a resend of a few patches that implement few=0D
SVM's optional features for nesting.=0D
=0D
I was testing these patches during last few weeks with various nested confi=
gurations=0D
and I was unable to find any issues.=0D
=0D
I also implemented support for nested vGIF in the last patch.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (6):=0D
  KVM: x86: SVM: add module param to control LBR virtualization=0D
  KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running=0D
  KVM: x86: nSVM: implement nested LBR virtualization=0D
  KVM: x86: nSVM: implement nested VMLOAD/VMSAVE=0D
  KVM: x86: nSVM: support PAUSE filter threshold and count when=0D
    cpu_pm=3Don=0D
  KVM: x86: SVM: implement nested vGIF=0D
=0D
 arch/x86/kvm/svm/nested.c |  86 ++++++++++++++++++++---=0D
 arch/x86/kvm/svm/svm.c    | 140 ++++++++++++++++++++++++++++++++------=0D
 arch/x86/kvm/svm/svm.h    |  38 +++++++++--=0D
 3 files changed, 228 insertions(+), 36 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D

