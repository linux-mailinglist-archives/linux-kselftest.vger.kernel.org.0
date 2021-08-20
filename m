Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65F3F36BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 00:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbhHTWvL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 18:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbhHTWvK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 18:51:10 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C876EC061756
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 15:50:31 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y185-20020a3764c20000b02903d2c78226ceso7411431qkb.6
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=I/xOfL043wSWIjKBt5HEcjocrLFqM7QFZBSdMiXJO5I=;
        b=M3kumjeMVm4eYjRmGUO/zlfNkMo/9WsvowPCfp+9Abh1lIA5cu2tJl3skXJ/c/DpNR
         DLaw0wylFTflUtaBDHF3r8l7A76rdGodfuy8Xw4K2Xaz3gqIPcTyNFWKlYle9HWjHKGq
         qU3WbdHt/DBXmgLXabDaUFuqIQYx2gN5h7frBxsWiYmFdafmGsqF2epkbsV/DTDNzjzg
         PCJTz+nVi+FBxX5K3c+PMjIS5Pxl13qw5qxXA6951o10atA6WmUd5KSBBUoWmQdqTUG8
         8FvYZ0DNWMFeNHDNeMBE9g+GRNrPryzsmQCKYDRVSsmTYkEKei9vpwFi3kpWR9Pluy7M
         t7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=I/xOfL043wSWIjKBt5HEcjocrLFqM7QFZBSdMiXJO5I=;
        b=b6UvH8YVhGji4P9T5oL/5DlhI0OOarKzf+jOBU+VLmiDInskYWPOHuB5299l73IzO/
         3Jorfe9pDziutzc8sd/xB0zhOgHd1baMcrJuAy05vxRg0rLd3DwD3TihOadRUoo1uiMy
         0HBZs0Rewmd1otqcW/C+OaSLPascdOB+GiMjzHek4gAJCvY2blqUDeDSZhqOTLIoRwtI
         AL8j+6WnOdEGc6H4na/stNOyzru/923MwmOT8wpGCSxJ/Jt8qACnmvtdXN5RJ7M5HBEK
         DRKDVIjqAD436/vZaJUgUHsz+fNEySFPVVb6rORMg48xylr3vFhPbKUYyFr8FMKGNELJ
         85jg==
X-Gm-Message-State: AOAM531OutmhKuQ+87TudtVeMm3IKOsIU5aCsFsdtp9ciNMMhqHIr9J6
        tHEKfuTFYKSQ3cdyOmUOk2k8qO1GKtc=
X-Google-Smtp-Source: ABdhPJwPDeDEGSWBZzPAgrzEB3/9Tm6acMQwHqWt26WElPNAfJ7mDGPZ+5pXO64WxmSA3x2M0eH0pY71OXc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f11d:a281:af9b:5de6])
 (user=seanjc job=sendgmr) by 2002:a05:6214:728:: with SMTP id
 c8mr22408148qvz.53.1629499830911; Fri, 20 Aug 2021 15:50:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Aug 2021 15:50:00 -0700
In-Reply-To: <20210820225002.310652-1-seanjc@google.com>
Message-Id: <20210820225002.310652-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210820225002.310652-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 3/5] tools: Move x86 syscall number fallbacks to .../uapi/
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Move unistd_{32,64}.h from x86/include/asm to x86/include/uapi/asm so
that tools/selftests that install kernel headers, e.g. KVM selftests, can
include non-uapi tools headers, e.g. to get 'struct list_head', without
effectively overriding the installed non-tool uapi headers.

Swapping KVM's search order, e.g. to search the kernel headers before
tool headers, is not a viable option as doing results in linux/type.h and
other core headers getting pulled from the kernel headers, which do not
have the kernel-internal typedefs that are used through tools, including
many files outside of selftests/kvm's control.

Prior to commit cec07f53c398 ("perf tools: Move syscall number fallbacks
from perf-sys.h to tools/arch/x86/include/asm/"), the handcoded numbers
were actual fallbacks, i.e. overriding unistd_{32,64}.h from the kernel
headers was unintentional.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/arch/x86/include/{ => uapi}/asm/unistd_32.h | 0
 tools/arch/x86/include/{ => uapi}/asm/unistd_64.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename tools/arch/x86/include/{ => uapi}/asm/unistd_32.h (100%)
 rename tools/arch/x86/include/{ => uapi}/asm/unistd_64.h (100%)

diff --git a/tools/arch/x86/include/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
similarity index 100%
rename from tools/arch/x86/include/asm/unistd_32.h
rename to tools/arch/x86/include/uapi/asm/unistd_32.h
diff --git a/tools/arch/x86/include/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
similarity index 100%
rename from tools/arch/x86/include/asm/unistd_64.h
rename to tools/arch/x86/include/uapi/asm/unistd_64.h
-- 
2.33.0.rc2.250.ged5fa647cd-goog

