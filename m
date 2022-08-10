Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B058EC04
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 14:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiHJMaW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 08:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiHJMaT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 08:30:19 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8266211803;
        Wed, 10 Aug 2022 05:30:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6761A43E865;
        Wed, 10 Aug 2022 08:30:15 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id C0olCMiwtd8x; Wed, 10 Aug 2022 08:30:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E324A43EA38;
        Wed, 10 Aug 2022 08:30:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E324A43EA38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1660134614;
        bh=B/qxBoi9o1gVsk6Eb1UYEgPxbL1rMsh9NZ46kRFuqiI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZnWadkVDov0vTB6CEnrUksXNICt4XyoIbKAR3c4uKk8HwV3O0DaHjQq2u/PvgAaaD
         W3hRqGWplND4ju3MSOHu69aetic44PIzYZ+ljvscPnKijmjj2wmMfMa0enwC75acJU
         1LBG3LsY1C/AK+ALZ5jT9RHT8jcat7rkTkAQ+gneTHIPpdRf1RmL8fFRdGunfOWmxQ
         vY2LeFGXKCzmqrHWH587oVs9Fyc5KDKEUSgA1S4mfdOTKbC7/ZUT8DJpFbQxkvlsBn
         qDKxjQydYPR8wdmlkZfkI+fPsEo2aP++gCdrhOhPGeGSM8ddMgPvDglo3W3PL6Med0
         d36xj+4uG4qKQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2qdFW4ojRKgE; Wed, 10 Aug 2022 08:30:14 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D642243EA37;
        Wed, 10 Aug 2022 08:30:14 -0400 (EDT)
Date:   Wed, 10 Aug 2022 08:30:14 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Gavin Shan <gshan@redhat.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        KVM list <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        shan gavin <shan.gavin@gmail.com>, maz <maz@kernel.org>,
        andrew jones <andrew.jones@linux.dev>,
        yihyu <yihyu@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        oliver upton <oliver.upton@linux.dev>
Message-ID: <264792101.376.1660134614855.JavaMail.zimbra@efficios.com>
In-Reply-To: <1e41a634-0419-e0a8-364c-2e30ed2dbe4d@redhat.com>
References: <20220810104114.6838-1-gshan@redhat.com> <20220810104114.6838-2-gshan@redhat.com> <876568572.367.1660134156963.JavaMail.zimbra@efficios.com> <1e41a634-0419-e0a8-364c-2e30ed2dbe4d@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: selftests: Make rseq compatible with
 glibc-2.35
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103 (Linux)/8.8.15_GA_4372)
Thread-Topic: selftests: Make rseq compatible with glibc-2.35
Thread-Index: yiYIM7vHUMcuFpAstZPcUYWmBolt7g==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Aug 10, 2022, at 8:29 AM, Paolo Bonzini pbonzini@redhat.com wrote:

> On 8/10/22 14:22, Mathieu Desnoyers wrote:
>>>
>>> 	/*
>>> 	 * Create and run a dummy VM that immediately exits to userspace via
>>> @@ -256,7 +244,7 @@ int main(int argc, char *argv[])
>>> 			 */
>>> 			smp_rmb();
>>> 			cpu = sched_getcpu();
>>> -			rseq_cpu = READ_ONCE(__rseq.cpu_id);
>>> +			rseq_cpu = READ_ONCE(__rseq->cpu_id);
>> #include <rseq.h>
>> 
>> and use
>> 
>> rseq_current_cpu_raw().
> 
> Thanks, I squashed it and queued it for -rc1 (tested on both
> glibc 2.34 and 2.35).

Thanks a lot Paolo,

Cheers! :)

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
