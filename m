Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3BD3FA20A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Aug 2021 02:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhH1AHW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Aug 2021 20:07:22 -0400
Received: from mail.efficios.com ([167.114.26.124]:47366 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbhH1AHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Aug 2021 20:07:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 334D2383D90;
        Fri, 27 Aug 2021 20:06:25 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dJnw97AVp-6J; Fri, 27 Aug 2021 20:06:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AABF53839D9;
        Fri, 27 Aug 2021 20:06:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AABF53839D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1630109180;
        bh=aNbnUoaMo9qyJFeAmPDlGUugMe1xHV+lzHQym41zPgk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ibXqVy9zMTh8pzWhCDOoh0A6j0FvWS8eYDH852Q65ZQn7p1jJGIre5/cPOpdeIP+y
         aA3o07Eg6BWPXmQhKAcL/ut69D3yBdvdejeJXIhzPTSWYfZet9c55De2zXu/+jv9qb
         9rMBUNtRH3XFmY4l5818jP7JeOTnYOyaVW6g21SlH6hM5lnPmcjj7mBKimFhzIieoI
         r/xa04WF8N3Rq/3K+SW2ss83aevuy6/MvU/Sy30Y15mPyUw7HSYrNN1GbX2+DRw0YH
         7ZItjz+GSSq3DkuqubXPIjIIupZU9sNhSleF8+cDrSh10TSYD5CLywa6jmXG5NyjL6
         CV8mJ14ojbACA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9JJ04Y5MGhgL; Fri, 27 Aug 2021 20:06:20 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 87F07383C99;
        Fri, 27 Aug 2021 20:06:20 -0400 (EDT)
Date:   Fri, 27 Aug 2021 20:06:20 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     dvhart <dvhart@infradead.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-csky <linux-csky@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Ben Gardon <bgardon@google.com>
Message-ID: <1054916754.30218.1630109180443.JavaMail.zimbra@efficios.com>
In-Reply-To: <YSlz8h9SWgeuicak@google.com>
References: <20210820225002.310652-1-seanjc@google.com> <766990430.21713.1629731934069.JavaMail.zimbra@efficios.com> <282257549.21721.1629732017655.JavaMail.zimbra@efficios.com> <YSblqrrpKcORzilX@google.com> <1700758714.29394.1630003332081.JavaMail.zimbra@efficios.com> <YSgpy8iXXXUQ+b/k@google.com> <339641531.29941.1630091374065.JavaMail.zimbra@efficios.com> <YSlz8h9SWgeuicak@google.com>
Subject: Re: [PATCH v2 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4101 (ZimbraWebClient - FF91 (Linux)/8.8.15_GA_4059)
Thread-Topic: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs
Thread-Index: eu98ugrRMaO1Ldp5KUn1lSy5MLrp5Q==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Aug 27, 2021, at 7:23 PM, Sean Christopherson seanjc@google.com wrote:

> On Fri, Aug 27, 2021, Mathieu Desnoyers wrote:
[...]
>> Does it reproduce if we randomize the delay to have it picked randomly from 0us
>> to 100us (with 1us step) ? It would remove a lot of the needs for arch-specific
>> magic delay value.
> 
> My less-than-scientific testing shows that it can reproduce at delays up to
> ~500us,
> but above ~10us the reproducibility starts to drop.  The bug still reproduces
> reliably, it just takes more iterations, and obviously the test runs a bit
> slower.
> 
> Any objection to using a 1-10us delay, e.g. a simple usleep((i % 10) + 1)?

Works for me, thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
