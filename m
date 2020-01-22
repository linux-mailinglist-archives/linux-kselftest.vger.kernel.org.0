Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8629145AA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2020 18:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgAVRQe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jan 2020 12:16:34 -0500
Received: from mail.efficios.com ([167.114.26.124]:33022 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRQe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jan 2020 12:16:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0DB0925AF86;
        Wed, 22 Jan 2020 12:16:33 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4stJu28RmvV4; Wed, 22 Jan 2020 12:16:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BA38C25AEA7;
        Wed, 22 Jan 2020 12:16:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BA38C25AEA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1579713392;
        bh=9LMEjxtXO3DcVhBO+WK54vbQNVt6wfm87h8asYpsTpA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rMeSQ8cXwgEJi10a+NrDWSJslrcR1JcaoqUB62X8OJYwp1iBoN1eQvqtcqcC01S+U
         lvt9z4hldAreTc3ggArc7tcmdi/v9l33zfVBieVm/sJ5OBB/xjrPVup+2I8C9z92KR
         jUYCOByauv7H6kHe5AIiOTkg7Yrf01Qxrzsw0ZI2PWiJzKHuAn2k4aOUzcHqSCrqd8
         B+R6TGAAuwgZJ/Rcvbg/xxRfCzoSPWEF/YLwLlhUeo0ieRBOZ4LDjRFJqqiu6Ulm9s
         2jLcjztV0a703bBxgymj8Iht3R0nVPVXAtKUMTDfTqnwPZC0Ri0cfFTiVWiUwqTzOr
         TXfiS6FaLkW2A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QUb4Vmo1dyGh; Wed, 22 Jan 2020 12:16:32 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9F5B225AEA6;
        Wed, 22 Jan 2020 12:16:32 -0500 (EST)
Date:   Wed, 22 Jan 2020 12:16:32 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Andi Kleen <andi@firstfloor.org>, Ben Maurer <bmaurer@fb.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Lameter <cl@linux.com>, Dave Watson <davejwatson@fb.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Joel Fernandes <joelaf@google.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>, rostedt <rostedt@goodmis.org>,
        shuah <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Message-ID: <1813399266.597377.1579713392568.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAODFU0rTLmb-Ph_n1EHaZmdOAjsa6Jmx=3zkuT8LH3No=sOk5w@mail.gmail.com>
References: <CAODFU0rTLmb-Ph_n1EHaZmdOAjsa6Jmx=3zkuT8LH3No=sOk5w@mail.gmail.com>
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system
 call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: pin_on_cpu: Introduce thread CPU pinning system call
Thread-Index: dvBLZ91ySDgPt1Gh4255dg7wp2uMvw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

(replying again as plain text for mailing lists)

----- On Jan 22, 2020, at 10:44 AM, Jan Ziak 0xe2.0x9a.0x9b@gmail.com wrote:

> Hello

> I would like to note that this does not help userspace to express dynamic
> scheduling relationships among processes/threads such as "do not run processes
> A and B on the same core" or "run processes A and B on cores sharing the same
> L2 cache".

Indeed, this is not what this system call is trying to solve. Does the name "pin_on_cpu" lead 
to confusion here ? 

I thought that cgroups was already the mechanism taking care of this kind of requirement. 

Thanks, 

Mathieu 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
