Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CEE58F4EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 01:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiHJXfs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 19:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiHJXfa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 19:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C7596CD00
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 16:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660174507;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4aqIasYhaSzV49q+EWgbsENRoxcrDk8IPfuEQBuSyc=;
        b=AmysuECMBK366zTUC8ssSB0JeSkJWhT5I7CmYMhQLDKW0+PT3K0XnqucWERJcm1KtuqZln
        y46rk+6e16k8kQ2ILPhkJjApg38pCgt6KqO2bRaqKb63n74l2dkblXEsVPCJiSDARVwY1B
        pZmwTS+TifKJrptqgqBkfXzXpiF4H7Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-BD_3TpmPM_y3UTMOCkcRrg-1; Wed, 10 Aug 2022 19:35:04 -0400
X-MC-Unique: BD_3TpmPM_y3UTMOCkcRrg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A52D29DD9A3;
        Wed, 10 Aug 2022 23:35:03 +0000 (UTC)
Received: from [10.64.54.77] (vpn2-54-77.bne.redhat.com [10.64.54.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 798FF492C3B;
        Wed, 10 Aug 2022 23:34:59 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        maz <maz@kernel.org>, oliver upton <oliver.upton@linux.dev>,
        andrew jones <andrew.jones@linux.dev>,
        Sean Christopherson <seanjc@google.com>,
        yihyu <yihyu@redhat.com>, shan gavin <shan.gavin@gmail.com>
References: <20220809060627.115847-1-gshan@redhat.com>
 <20220809060627.115847-2-gshan@redhat.com>
 <8735e6ncxw.fsf@oldenburg.str.redhat.com>
 <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com>
 <87o7wtnay6.fsf@oldenburg.str.redhat.com>
 <616d4de6-81f6-9d14-4e57-4a79fec45690@redhat.com>
 <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
 <bb97efaf-4f58-c192-a489-e71ebbebce8c@redhat.com>
 <392275844.358.1660133856396.JavaMail.zimbra@efficios.com>
 <ae135a39-4190-041b-93dd-be2610125631@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <49d8b8fb-4053-cdd2-4d3c-9bf693c23a47@redhat.com>
Date:   Thu, 11 Aug 2022 09:34:57 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <ae135a39-4190-041b-93dd-be2610125631@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paolo and Mathieu,

On 8/10/22 10:19 PM, Paolo Bonzini wrote:
> On 8/10/22 14:17, Mathieu Desnoyers wrote:
>> Indeed, this hack seems to be a good approach to immediately fix things without
>> moving around all source files and headers. In the longer term, I'd prefer Sean's
>> proposal to move rseq.c to tools/lib/ (and to move rseq headers to tools/include/rseq/).
>> This can be done in a follow up phase though. I'll put a note on my todo list
>> for after I come back from vacation.
> 
> Great, Gavin, are you going to repost using librseq?
> 

It seems you've merged v2. I will post additional patches to
use tools/lib/librseq.so, depending on what Mathieu will have.

Mathieu, Please let me know if there are anything I can help.

>>> Yeah, rseq_test should reuse librseq code.  The simplest way,
>>> if slightly hackish, is to do something like
>>>
>>> diff --git a/tools/testing/selftests/kvm/Makefile
>>> b/tools/testing/selftests/kvm/Makefile
>>> index 690b499c3471..6c192b0ec304 100644
>>> --- a/tools/testing/selftests/kvm/Makefile
>>> +++ b/tools/testing/selftests/kvm/Makefile
>>> @@ -37,6 +37,7 @@ ifeq ($(ARCH),riscv)
>>>      UNAME_M := riscv
>>>  endif
>>>
>>>  LIBKVM += lib/assert.c
>>>  LIBKVM += lib/elf.c
>>>  LIBKVM += lib/guest_modes.c
>>> @@ -198,7 +199,7 @@ endif
>>>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>>>      -fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>>>      -I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
>>> -    -I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>>> +    -I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES) -I../rseq
>>>
>>>  no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
>>>          $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
>>>
>>>
>>> and just #include "../rseq/rseq.c" in rseq_test.c.

Thanks,
Gavin

