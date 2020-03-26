Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1BEF19441E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgCZQRI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 12:17:08 -0400
Received: from mail.efficios.com ([167.114.26.124]:56988 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgCZQRI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 12:17:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3EF6F278187;
        Thu, 26 Mar 2020 12:17:07 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OhHjHl1pXjeQ; Thu, 26 Mar 2020 12:17:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F3D5C278186;
        Thu, 26 Mar 2020 12:17:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F3D5C278186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1585239427;
        bh=yfGF8y3/6vcwYWjtaZyIkK6AJFhIURCxE/sEYU8BVHM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=VrkzUYw7ljYE9ZaynEDEZSKCkvSslxsNn7fbwTiQ4EXYQhTJrj8Y8QNql9pH4r4MC
         4V+VIeXD0L5XNxKi1YYFSJWF2ea+6iq9uXxuWm5MriWRvg9+xBLzd5yftW5otrxDPs
         Sm7wAKVIsQ4Y/WYCNNbrbJ6XyGm4HPa4lHA3T1sKzGJpWzOQ5hwOnRW6anX6LgDe/B
         xZ8e40oOR04qFXczRTzzD637M2yiehRUfYCxc6YgbfcjcwAuCoqd7B66jt9HsRh7Rr
         /yO2IyMVoDo969+6NgK8dpiw88htGlteLMsB5YXivF0LQ1XaCq06ZRvRC/JZB1VETd
         ygvLkRXYj68Tw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8cLdYGRVPu8v; Thu, 26 Mar 2020 12:17:06 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E80ED278112;
        Thu, 26 Mar 2020 12:17:06 -0400 (EDT)
Date:   Thu, 26 Mar 2020 12:17:06 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Message-ID: <490218026.13345.1585239426829.JavaMail.zimbra@efficios.com>
In-Reply-To: <mhng-e1457171-db30-49be-9e98-298f4d1453ed@palmerdabbelt-glaptop1>
References: <mhng-e1457171-db30-49be-9e98-298f4d1453ed@palmerdabbelt-glaptop1>
Subject: Re: [PATCH V2 3/3] rseq/selftests: Add support for riscv
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF74 (Linux)/8.8.15_GA_3895)
Thread-Topic: rseq/selftests: Add support for riscv
Thread-Index: YI3KdsKu7N2vjVdS5o5Dpon/zWRp1A==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Mar 26, 2020, at 11:49 AM, Palmer Dabbelt palmer@dabbelt.com wrote:

> On Sun, 08 Mar 2020 22:59:52 PDT (-0700), vincent.chen@sifive.com wrote:
>> Add support for risc-v in the rseq selftests, which covers both
>> 64-bit and 32-bit ISA with little endian mode.
>>
>> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
>> ---
>>  tools/testing/selftests/rseq/param_test.c |  23 ++
>>  tools/testing/selftests/rseq/rseq-riscv.h | 622 ++++++++++++++++++++++++++++++
>>  tools/testing/selftests/rseq/rseq.h       |   2 +
>>  3 files changed, 647 insertions(+)
>>  create mode 100644 tools/testing/selftests/rseq/rseq-riscv.h
> 
> There are a ton of checkpatch errors in here.

Is it just my mail client or the main issue is:

ERROR: DOS line endings

?

As far as other issues are concerned, I know there are a few checkpatch
false-positives that trigger for my rseq-{$ARCH}.h header, from which rseq-riscv.h
is derived, because it has issues with extensive use of inline assembly.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
