Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6DA3EF6BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 02:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbhHRANS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Aug 2021 20:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbhHRANO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Aug 2021 20:13:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E89C0617AF
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Aug 2021 17:12:35 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z8-20020a0ce9880000b02903528f1b338aso851896qvn.6
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Aug 2021 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=b+D2wYBAlQke3x9JmkHfnRLEolzYl7vtoLkPYastC9U=;
        b=SPf96yhVitla9fan3IPn+20/DnpTxFcV2rJEUslNb4wU2oCEHWEr0TqYuejQIpJC6o
         jNSlYG+qBG8JbfyX7VG4m902MAYzTMIKxE+J/MrcopqG+WhchVZGJ22ACD9otOp/g1MJ
         y8nklKpCoREBa48CLrIfCPmMdB2GYVCrgtlvmB4GKsIMsEqBcxosOyXpoGKbtYzFUxZP
         Mm1I083bv5z0TQY7dAZh75UyzcpU/oojg63UuFCwEtyUQLcR51nv2dL3CjfuKg5iKWol
         K+EQ3dmDwhxcBXzNf+59Mx+svVE9z+9may7ss8OC49FzSgAQttlvHK9DI1ILn8qo818b
         bPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=b+D2wYBAlQke3x9JmkHfnRLEolzYl7vtoLkPYastC9U=;
        b=ZlGMCJocl0wnh/W7hG2+xMlXPa0pf5VUM3wKyoNNDSdx/X1lZBWyFZTDDAj2qk4XhS
         sC3/CzCVhJKnlpVI3QRkdJXKO065TPsgF+AkfmbxwbiqxF4j5Eam65zOSBX7wkqTg/4Y
         4l2diVzfpL+alDl+LfXdeOXjlCirPHTasuZZdvBjSIJSC1PX4ukghSR+m5xqMaN9qgDn
         YADBJB+Wpy0ZwG5ZKle/FjXXMnyeZJxWV1X4+R2XVJpBhgld5FYZf3g3TqZYo3cbOd30
         8sAZAUiSK/2GOmE65AZ5P3WOBB3BJrW9tMM6R5o6GJK8glWNRVu8nmH0+v8Ul2txF/fU
         Mv9w==
X-Gm-Message-State: AOAM530mqubmphwb1MXrgmDxF5XOpv8MYm+O8QOQkzjLdTLuZ43MJyl1
        J/OUtGVq4or5k07YJur5poKIn0OuPJQ=
X-Google-Smtp-Source: ABdhPJwjcybq5SY8/j4KCEcr/HLmkC+uHYVjqMZ/h+nMujuHcP7O+f1gmxV0bp94O0yeV50pIPXQ8l0qs8Q=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:158e:55a:74dd:5197])
 (user=seanjc job=sendgmr) by 2002:ad4:46cb:: with SMTP id g11mr6107577qvw.45.1629245554714;
 Tue, 17 Aug 2021 17:12:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 17 Aug 2021 17:12:10 -0700
In-Reply-To: <20210818001210.4073390-1-seanjc@google.com>
Message-Id: <20210818001210.4073390-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210818001210.4073390-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 5/5] KVM: selftests: Remove __NR_userfaultfd syscall fallback
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
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

Revert the __NR_userfaultfd syscall fallback added for KVM selftests now
that x86's unistd_{32,63}.h overrides are under uapi/ and thus not in
KVM sefltests' search path, i.e. now that KVM gets x86 syscall numbers
from the installed kernel headers.

No functional change intended.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/arch/x86/include/uapi/asm/unistd_64.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index 4205ed4158bf..cb52a3a8b8fc 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __NR_userfaultfd
-#define __NR_userfaultfd 282
-#endif
 #ifndef __NR_perf_event_open
 # define __NR_perf_event_open 298
 #endif
-- 
2.33.0.rc1.237.g0d66db33f3-goog

