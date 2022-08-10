Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B454D58EBDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiHJMTV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiHJMTT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 08:19:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4FDC6C10B
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660133956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0z7Zcbu+4x+/8ByQeQoUUCbO5l7ndOcAPekSmvOfATk=;
        b=iataZB7t0KvU4TuKQ661NFatO3dECgsWpahJx2nCBcKBHoICvzYoHU/Cr7INbaotBy6dhP
        x7/3paPMCAs6+Zrde031uXrXBkMhrUWv1wtUAVk1s9PIpOTLjH2ZfPwRyz4UmE1PfjqMyX
        Uji/rhKecV3TATVeBmenrE5FGHxZTrc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-npjMbOQbN-ii9O91Nq1t6A-1; Wed, 10 Aug 2022 08:19:15 -0400
X-MC-Unique: npjMbOQbN-ii9O91Nq1t6A-1
Received: by mail-ej1-f69.google.com with SMTP id qf23-20020a1709077f1700b007308a195618so4126758ejc.7
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 05:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0z7Zcbu+4x+/8ByQeQoUUCbO5l7ndOcAPekSmvOfATk=;
        b=SSHve+mlwa5dBjof4WfNiPDpIMfSoha+1bT8d0s8HTytykymvNyfcUP+5xdILdKKm8
         KkUsFbs26amJ5zq129WXfkJwhBZlpi3KFbl7PeKgJcJm4mVxpcIU5BKT6ee5frWO9YSL
         VNWroZK8aKSBDwNK/Le0QJp4HvuLvuhh+1JLRpPoN3eC/6Afcks4sulHDJAMkcgMtjfA
         LkSEXLCo0ibmMzH7Hl4MwP9uZE/g+GS3Kc3DFaVEpDPpvuEAjaLR+KoAYLoov68Dx2Uo
         514LEcyCbRg3chYT48nMv2ADFxQ4bTEdTPwNKyoC9s0QJjAwK/IFNZhrqZ92+1j3COKL
         AD8g==
X-Gm-Message-State: ACgBeo0To+aI4AsOBGLto8pEPAJgEsQWOUiwd8+SR5bWW2U4E7oXfggG
        ylak6kxFZpKNVnzt04sfYoTP8tgkeyT6MxeCt3DabGZxRwXjCakDD30dV87bEpZbdarc+A3swLK
        kd3QUnD0OFL1nCg+SIkFqtRH48d3l
X-Received: by 2002:a17:906:5a6a:b0:730:bc8a:57dd with SMTP id my42-20020a1709065a6a00b00730bc8a57ddmr19475539ejc.301.1660133954448;
        Wed, 10 Aug 2022 05:19:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4KWNsnIMIIjdxc45teRDYtyGYIM95O2JKOc/vdql5qtoATPjlBo5mU4aLGO+26B65zs0mtZQ==
X-Received: by 2002:a17:906:5a6a:b0:730:bc8a:57dd with SMTP id my42-20020a1709065a6a00b00730bc8a57ddmr19475525ejc.301.1660133954210;
        Wed, 10 Aug 2022 05:19:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id fu14-20020a170907b00e00b007330ad36237sm699707ejc.151.2022.08.10.05.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 05:19:13 -0700 (PDT)
Message-ID: <ae135a39-4190-041b-93dd-be2610125631@redhat.com>
Date:   Wed, 10 Aug 2022 14:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Gavin Shan <gshan@redhat.com>, Florian Weimer <fweimer@redhat.com>,
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
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <392275844.358.1660133856396.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/10/22 14:17, Mathieu Desnoyers wrote:
> Indeed, this hack seems to be a good approach to immediately fix things without
> moving around all source files and headers. In the longer term, I'd prefer Sean's
> proposal to move rseq.c to tools/lib/ (and to move rseq headers to tools/include/rseq/).
> This can be done in a follow up phase though. I'll put a note on my todo list
> for after I come back from vacation.

Great, Gavin, are you going to repost using librseq?

>> Yeah, rseq_test should reuse librseq code.  The simplest way,
>> if slightly hackish, is to do something like
>> 
>> diff --git a/tools/testing/selftests/kvm/Makefile
>> b/tools/testing/selftests/kvm/Makefile
>> index 690b499c3471..6c192b0ec304 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -37,6 +37,7 @@ ifeq ($(ARCH),riscv)
>>  	UNAME_M := riscv
>>  endif
>>  
>>  LIBKVM += lib/assert.c
>>  LIBKVM += lib/elf.c
>>  LIBKVM += lib/guest_modes.c
>> @@ -198,7 +199,7 @@ endif
>>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>>  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>>  	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
>> -	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>> +	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES) -I../rseq
>>  
>>  no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
>>          $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
>> 
>> 
>> and just #include "../rseq/rseq.c" in rseq_test.c.



Paolo

