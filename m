Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8AA40B372
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhINPt4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231600AbhINPtz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YZMobtPiLymC8tuLOJluN+oODsj69C/BDz562LLkYOc=;
        b=KQocFR89eE4i6JeIDEFHWzBwf8YkndsPDjTRgUN4Z5Mz7u63eLPX5QbmcUEYDZsKCrNima
        0kox9aHS87QlKRjiWW8J47SaG0cYWEwsvUt4S3QksRaEZUH6OuviA4nNX08C3tX3c8zvA/
        W7eAJM3HeZ2JjotFo3gLaH4FfkcvJPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-7cyYFuGVNLK5QGArfF8b_A-1; Tue, 14 Sep 2021 11:48:36 -0400
X-MC-Unique: 7cyYFuGVNLK5QGArfF8b_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F93D19253C0;
        Tue, 14 Sep 2021 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F6245C1D1;
        Tue, 14 Sep 2021 15:48:26 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Maxim Levitsky <mlevitsk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 00/14] nSVM fixes and optional features
Date:   Tue, 14 Sep 2021 18:48:11 +0300
Message-Id: <20210914154825.104886-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Those are few patches I was working on lately, all somewhat related=0D
to the two CVEs that I found recently.=0D
=0D
First 7 patches fix various minor bugs that relate to these CVEs.=0D
=0D
The rest of the patches implement various optional SVM features,=0D
some of which the guest could enable anyway due to incorrect=0D
checking of virt_ext field.=0D
=0D
Last patch is somewhat an RFC, I would like to hear your opinion=0D
on that.=0D
=0D
I also implemented nested TSC scaling while at it.=0D
=0D
As for other optional SVM features here is my summary of few features=0D
I took a look at:=0D
=0D
X86_FEATURE_DECODEASSISTS:=0D
   this feature should make it easier=0D
   for the L1 to emulate an instruction on MMIO access, by not=0D
   needing to read the guest memory but rather using the instruction=0D
   bytes that the CPU already fetched.=0D
=0D
   The challenge of implementing this is that we sometimes inject=0D
   #PF and #NPT syntenically and in those cases we must be sure=0D
   we set the correct instruction bytes.=0D
=0D
   Also this feature adds assists for MOV CR/DR, INTn, and INVLPG,=0D
   which aren't that interesting but must be supported as well to=0D
   expose this feature to the nested guest.=0D
=0D
X86_FEATURE_VGIF=0D
   Might allow the L2 to run the L3 a bit faster, but due to crazy complex=
=0D
   logic we already have around int_ctl and vgif probably not worth it.=0D
=0D
X86_FEATURE_VMCBCLEAN=0D
   Should just be enabled, because otherwise L1 doesn't even attempt=0D
   to set the clean bits. But we need to know if we can take an=0D
   advantage of these bits first.=0D
=0D
X86_FEATURE_FLUSHBYASID=0D
X86_FEATURE_AVIC=0D
   These two features would be very good to enable, but that=0D
   would require lots of work, and will be done eventually.=0D
=0D
There are few more nested SVM features that I didn't yet had a=0D
chance to take a look at.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (14):=0D
  KVM: x86: nSVM: restore int_vector in svm_clear_vintr=0D
  KVM: x86: selftests: test simultaneous uses of V_IRQ from L1 and L0=0D
  KVM: x86: nSVM: test eax for 4K alignment for GP errata workaround=0D
  KVM: x86: nSVM: don't copy pause related settings=0D
  KVM: x86: nSVM: don't copy virt_ext from vmcb12=0D
  KVM: x86: SVM: don't set VMLOAD/VMSAVE intercepts on vCPU reset=0D
  KVM: x86: SVM: add warning for CVE-2021-3656=0D
  KVM: x86: SVM: add module param to control LBR virtualization=0D
  KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running=0D
  KVM: x86: nSVM: implement nested LBR virtualization=0D
  KVM: x86: nSVM: implement nested VMLOAD/VMSAVE=0D
  KVM: x86: SVM: add module param to control TSC scaling=0D
  KVM: x86: nSVM: implement nested TSC scaling=0D
  KVM: x86: nSVM: support PAUSE filter threshold and count=0D
=0D
 arch/x86/kvm/svm/nested.c                     | 105 +++++++--=0D
 arch/x86/kvm/svm/svm.c                        | 218 +++++++++++++++---=0D
 arch/x86/kvm/svm/svm.h                        |  20 +-=0D
 arch/x86/kvm/vmx/vmx.c                        |   1 +=0D
 arch/x86/kvm/x86.c                            |   1 +=0D
 tools/testing/selftests/kvm/.gitignore        |   1 +=0D
 tools/testing/selftests/kvm/Makefile          |   1 +=0D
 .../selftests/kvm/x86_64/svm_int_ctl_test.c   | 128 ++++++++++=0D
 8 files changed, 427 insertions(+), 48 deletions(-)=0D
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c=0D
=0D
-- =0D
2.26.3=0D
=0D

