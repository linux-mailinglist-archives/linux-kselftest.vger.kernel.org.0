Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5585F58D98B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbiHINoU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 09:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiHINoT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 09:44:19 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3A118B13;
        Tue,  9 Aug 2022 06:44:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 977AA429DBD;
        Tue,  9 Aug 2022 09:44:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id A2tXyMn9D4L2; Tue,  9 Aug 2022 09:44:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 17218429DBC;
        Tue,  9 Aug 2022 09:44:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 17218429DBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1660052657;
        bh=s4MwCgSocyslqz8qzo8aK6OHgXabE2tT23dUh+6dXe0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WY/02Qm5yS41kNoN/cNg3tLp3INF8QD6x80M50bSMHG0rPvTpcohEzEJ+m9T0Sgh8
         m63RBvDXINU2u2nkSES8DSygcKfYNJZBCeCdrMLLmGqHWOdrFkpRVl0PBpOIPHWFst
         S5zitE8F0woj3d8UGX0G9XzsWhMfCoVSednEvGn5QPf6piJoF83OMVE/g+Q+2g94SA
         x5vJNBJ6yDt//R57FTo3OATfaEfK2wV6lmRTHwL0s/hFHIOOVfcMKhgIfKklGUn1yd
         GofDXEDGnRNV11dizNmeF10xLouUIm2X1uRyHpFWKfGCmMm/VTaUCK3nv3dqMAXuPF
         wlRS+WWD8OA4w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kq9Zg0-sw3D5; Tue,  9 Aug 2022 09:44:17 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 034A1429DBB;
        Tue,  9 Aug 2022 09:44:17 -0400 (EDT)
Date:   Tue, 9 Aug 2022 09:44:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Gavin Shan <gshan@redhat.com>, shuah <shuah@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>, kvmarm@lists.cs.columbia.edu,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, maz <maz@kernel.org>,
        oliver upton <oliver.upton@linux.dev>,
        andrew jones <andrew.jones@linux.dev>,
        Sean Christopherson <seanjc@google.com>, yihyu@redhat.com,
        shan gavin <shan.gavin@gmail.com>
Message-ID: <1014177394.115022.1660052656961.JavaMail.zimbra@efficios.com>
In-Reply-To: <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
References: <20220809060627.115847-1-gshan@redhat.com> <20220809060627.115847-2-gshan@redhat.com> <8735e6ncxw.fsf@oldenburg.str.redhat.com> <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com> <87o7wtnay6.fsf@oldenburg.str.redhat.com> <616d4de6-81f6-9d14-4e57-4a79fec45690@redhat.com> <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with
 glibc-2.35
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF103 (Linux)/8.8.15_GA_4304)
Thread-Topic: selftests: Make rseq compatible with glibc-2.35
Thread-Index: oHLHOFY5Vh2uVE5+gR7UtW52F8t44qAjgRJ1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Aug 9, 2022, at 8:21 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- Gavin Shan <gshan@redhat.com> wrote:
>> Hi Florian,
>> 
>> On 8/9/22 5:16 PM, Florian Weimer wrote:
>> >>> __builtin_thread_pointer doesn't work on all architectures/GCC
>> >>> versions.
>> >>> Is this a problem for selftests?
>> >>>
>> >>
>> >> It's a problem as the test case is running on all architectures. I think I
>> >> need introduce our own __builtin_thread_pointer() for where it's not
>> >> supported: (1) PowerPC  (2) x86 without GCC 11
>> >>
>> >> Please let me know if I still have missed cases where
>> >> __buitin_thread_pointer() isn't supported?
>> > 
>> > As far as I know, these are the two outliers that also have rseq
>> > support.  The list is a bit longer if we also consider non-rseq
>> > architectures (csky, hppa, ia64, m68k, microblaze, sparc, don't know
>> > about the Linux architectures without glibc support).
>> > 
>> 
>> For kvm/selftests, there are 3 architectures involved actually. So we
>> just need consider 4 cases: aarch64, x86, s390 and other. For other
>> case, we just use __builtin_thread_pointer() to maintain code's
>> integrity, but it's not called at all.
>> 
>> I think kvm/selftest is always relying on glibc if I'm correct.
> 
> All those are handled in the rseq selftests and in librseq. Why duplicate all
> that logic again?

More to the point, considering that we have all the relevant rseq registration
code in tools/testing/selftests/rseq/rseq.c already, and the relevant thread
pointer getter code in tools/testing/selftests/rseq/rseq-*thread-pointer.h,
is there an easy way to get test applications in tools/testing/selftests/kvm
and in tools/testing/selftests/rseq to share that common code ?

Keeping duplicated compatibility code is bad for long-term maintainability.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
