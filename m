Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFCA144938
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2020 02:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAVBLL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jan 2020 20:11:11 -0500
Received: from mail.efficios.com ([167.114.26.124]:50896 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgAVBLL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jan 2020 20:11:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 38908255E0E;
        Tue, 21 Jan 2020 20:11:09 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MslKScO_bmKG; Tue, 21 Jan 2020 20:11:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C556F255E0D;
        Tue, 21 Jan 2020 20:11:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C556F255E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1579655468;
        bh=vJKDkNMK/FLSt2eC6/LRNCYWIf1IG5FTD/IjIMMwFWI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZH9YqKI6GFgaRAoZ444GxKdwL/g6G6lPnJs8S+WG5C/fFq4reVEF2QAr9eO3czO+B
         /z/rwFgmA+AT+tVFx3mvExOYCe57kJTPL+hdJ+17zT737Ck0h1bXoJK8v8Wu3gc6ni
         P4YZ3cq1QZ9h4lCGHah18RDVcrAwo+XP3wofldu7lTYVSlgkfDS2Yvx6Y9mmCsAggq
         +pKhZ1zNjq8D2LP6PsqCwrDFURxBc9/7xgAQVqDHDssdtH4kOE2sQ0K76PPAND3Qh0
         Ss/E0ov2hlz72LTLHu+8ULw8qe+gKw6SiSY9EQGYPsmK+9mBVpGWTBCZ4BiD8qeRfi
         zDYysctLP5wmQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bp3r5mOtDFmO; Tue, 21 Jan 2020 20:11:08 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A92BB255A59;
        Tue, 21 Jan 2020 20:11:08 -0500 (EST)
Date:   Tue, 21 Jan 2020 20:11:08 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Chris Lameter <cl@linux.com>
Cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>, shuah <shuah@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Message-ID: <1648013936.596672.1579655468604.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.2001212141590.1231@www.lameter.com>
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com> <CAG48ez2bQdoT9y7HkyU06DTazysUDdPdJe+gyV-NxgQA7JWQVQ@mail.gmail.com> <430172781.596271.1579636021412.JavaMail.zimbra@efficios.com> <CAG48ez2Z5CesMfandNK+S32Rrgp_QGQHqQ1Fpd5-YTsCWGfHeg@mail.gmail.com> <2049164886.596497.1579641536619.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.2001212141590.1231@www.lameter.com>
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system
 call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: pin_on_cpu: Introduce thread CPU pinning system call
Thread-Index: 5iCm1hRPFgMRFMEqWj/joD1uPFSiZA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Jan 21, 2020, at 4:44 PM, Chris Lameter cl@linux.com wrote:

> These scenarios are all pretty complex and will be difficult to understand
> for the user of these APIs.
> 
> I think the easiest solution (and most comprehensible) is for the user
> space process that does per cpu operations to get some sort of signal. If
> its not able to handle that then terminate it. The code makes a basic
> assumption after all that the process is running on a specific cpu. If
> this is no longer the case then its better to abort if the process cannot
> handle moving to a different processor.

The point of pin_on_cpu() is to allow threads to access per-cpu data
structures belonging to a given CPU even if they cannot run on that
CPU (because it is offline).

I am not sure what scenario your signal delivery proposal aims to cover.

Just to try to put this into the context of a specific scenario to see
if I understand your point, is the following what you have in mind ?

1. Thread A issues pin_on_cpu(5),
2. Thread B issues sched_setaffinity removing cpu 5 from thread A's
   affinity mask,
3. Noticing that it would generate an invalid combination, rather than
   failing sched_setaffinity, it would send a SIGSEGV (or other) signal
   to thread A.

Or so you have something entirely different in mind ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
