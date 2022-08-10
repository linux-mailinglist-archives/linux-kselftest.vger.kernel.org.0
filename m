Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F68B58EC13
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiHJMgF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 08:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiHJMgD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 08:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C9A77545
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660134961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87CTfpJXv+5cfHg/lnngjOgN/RrqyzIAd1Oqc8i/xvY=;
        b=CLaOp2MFGYVDG6aOnBuHa0MG8PK4au6a+U1RXLQHD2pQdySSAWijpX8rYpVNRkChrkf+5w
        xKA9PhP53zByyPpmm6CVv66grh6VxnaN5dowNVf1LVQbc9dr2BuYEdD3T0RIokFl0pWzK+
        vIokSS0vpcHWCq73kKhvfV6TRhUpv/M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-dN-67rYvNc66c8axxit4Xw-1; Wed, 10 Aug 2022 08:36:00 -0400
X-MC-Unique: dN-67rYvNc66c8axxit4Xw-1
Received: by mail-ej1-f71.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso4144871ejc.18
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 05:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=87CTfpJXv+5cfHg/lnngjOgN/RrqyzIAd1Oqc8i/xvY=;
        b=Sf7bKhJ/zs8EGprxOCg1kYHnH5ds1hComkpfa+XbSMuXjdoOQ/iF6jqRLAN0VUoXFK
         p6+MBpayOWJdsv2hxIWZZcgK+l7q2rRDpQKPFIj25pnaC1qetltTTWpvAms3ZwdyhVXh
         CBSALRvZAwexuFDuRqlPFlRra9ofhwOSCI5H3ryb7RHs08UnbAY0tkJHyGiYtARDfx2I
         SHdhwhc1YIKsNQM94td46iyIvYTeARc5jv95NQOc7XHI2LdKbI38rzvwZn9STNyV7613
         /2KdwH2jWS9N61RajyQjZVWdHduz0DkOG0Trp0zb9GsLYh7gc/lVRpYsGV3H8MG62KSP
         f6bA==
X-Gm-Message-State: ACgBeo3VzM8v+KnCFKpNUaOlEWuNOCmxXwrM+kkBYR4xuW1MVYsaiC0U
        qdJx3LJgOJILDiDPNvU5q3nzmLkyYY6RfN+2P6VDhE5YGzgSPAXO6pxMerJrjbiezO3ralksc2P
        lPCVfmsh9XTZE8BMlPEsOMofG67Lp
X-Received: by 2002:a17:907:7f9f:b0:733:76c:44c9 with SMTP id qk31-20020a1709077f9f00b00733076c44c9mr2231309ejc.642.1660134959426;
        Wed, 10 Aug 2022 05:35:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4VclOIWxDOiejEyzXNHWLBzTYbNnvJLzw2rnHm34/ZQmU9fDQpff2RJbtcZ+lFjHCJIwCYxQ==
X-Received: by 2002:a17:907:7f9f:b0:733:76c:44c9 with SMTP id qk31-20020a1709077f9f00b00733076c44c9mr2231285ejc.642.1660134959206;
        Wed, 10 Aug 2022 05:35:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id ky16-20020a170907779000b00730a73cbe08sm2246142ejc.169.2022.08.10.05.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 05:35:58 -0700 (PDT)
Message-ID: <c95aec97-6fbd-dca5-6aa6-b8242d5a379a@redhat.com>
Date:   Wed, 10 Aug 2022 14:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gavin Shan <gshan@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>, shuah <shuah@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        maz <maz@kernel.org>, oliver upton <oliver.upton@linux.dev>,
        andrew jones <andrew.jones@linux.dev>,
        yihyu <yihyu@redhat.com>, shan gavin <shan.gavin@gmail.com>
References: <20220809060627.115847-1-gshan@redhat.com>
 <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com>
 <87o7wtnay6.fsf@oldenburg.str.redhat.com>
 <616d4de6-81f6-9d14-4e57-4a79fec45690@redhat.com>
 <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
 <1014177394.115022.1660052656961.JavaMail.zimbra@efficios.com>
 <YvLT1fd8ddybF5Uw@google.com>
 <8c1f33b4-a5a1-fcfa-4521-36253ffa22c8@redhat.com>
 <1316061904.375.1660134559269.JavaMail.zimbra@efficios.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1316061904.375.1660134559269.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/10/22 14:29, Mathieu Desnoyers wrote:
>> - By design, selftests/rseq and selftests/kvm are parallel. It's going to
>> introduce
>>    unnecessary dependency for selftests/kvm to use selftests/rseq/librseq.so. To
>>    me,
>>    it makes the maintainability even harder.
> In terms of build system, yes, selftests/rseq and selftests/kvm are side-by-side,
> and I agree it is odd to have a cross-dependency.
> 
> That's where moving rseq.c to tools/lib/ makes sense.
> 
>> - What selftests/kvm needs is rseq-thread-pointer.h, which accounts for ~5% of
>>    functionalities, provided by selftests/rseq/librseq.so.
> I've never seen this type of argument used to prevent using a library before, except
> on extremely memory-constrained devices, which is not our target here.

I agree.

To me, the main argument against moving librseq to tools/lib is a 
variant of the build-system argument, namely that recursive Make 
sucks[1] and selftests/kvm right now does not use tools/lib.  So, for a 
single-file library, it may be simply not worth the hassle.

On the other hand, if "somebody else" does the work, I would have no 
problem with having selftests/kvm depend on tools/lib, not at all.

Thanks,

Paolo

[1] Kbuild is a marvel that makes it work, but it works because there 
are no such cross-subdirectory dependencies and anyway 
tools/testing/selftests does not use Kbuild.

