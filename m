Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EB8409169
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 16:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbhIMOBR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 10:01:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58060 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245106AbhIMN7I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:59:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC9A61FD84;
        Mon, 13 Sep 2021 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631541468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hH7Iy2pE2qXXycVl+pdgp/YjaWw0chbvKCaG1nR6wMw=;
        b=rskVLjWzWO+SQgKM7whOVKZMJUU4eAWiaaJMkUHgZ4o7XtDWNqJkR0Wr4hdo3PNSaEbKzB
        Exa6amYfD+QDBiQhuM+DEZysqjzQngjO3Q3MK8s9iFamZnSgC1AeJZJ+unDND6ZpNFUZSC
        o24T08ZH8M+lcBm0flqCa3TxOm58Cks=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B52D13AB2;
        Mon, 13 Sep 2021 13:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ucX7ANxYP2FMUwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Sep 2021 13:57:48 +0000
From:   Juergen Gross <jgross@suse.com>
To:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 0/2] kvm: fix KVM_MAX_VCPU_ID handling
Date:   Mon, 13 Sep 2021 15:57:42 +0200
Message-Id: <20210913135745.13944-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Revert commit 76b4f357d0e7d8f6f00 which was based on wrong reasoning
and rename KVM_MAX_VCPU_ID to KVM_MAX_VCPU_IDS in order to avoid the
same issue in future.

Juergen Gross (2):
  x86/kvm: revert commit 76b4f357d0e7d8f6f00
  kvm: rename KVM_MAX_VCPU_ID to KVM_MAX_VCPU_IDS

 Documentation/virt/kvm/devices/xics.rst            | 2 +-
 Documentation/virt/kvm/devices/xive.rst            | 2 +-
 arch/mips/kvm/mips.c                               | 2 +-
 arch/powerpc/include/asm/kvm_book3s.h              | 2 +-
 arch/powerpc/include/asm/kvm_host.h                | 4 ++--
 arch/powerpc/kvm/book3s_xive.c                     | 2 +-
 arch/powerpc/kvm/powerpc.c                         | 2 +-
 arch/x86/include/asm/kvm_host.h                    | 2 +-
 arch/x86/kvm/ioapic.c                              | 2 +-
 arch/x86/kvm/ioapic.h                              | 4 ++--
 arch/x86/kvm/x86.c                                 | 2 +-
 include/linux/kvm_host.h                           | 4 ++--
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 2 +-
 virt/kvm/kvm_main.c                                | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.26.2

