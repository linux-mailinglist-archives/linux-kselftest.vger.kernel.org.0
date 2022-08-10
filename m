Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7152A58F4FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 01:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiHJXxL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 19:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiHJXxK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 19:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC4E0286C8
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 16:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660175587;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RK+rr0mfAx0H6DNfJ38VHaiOqlQCgpVZGMqD2Vgy3AU=;
        b=TPyFX7bL90IFrpgQWHO3L4GUarxCWNc7UdWFVTXyzCDv2VXYtf8PX/qxIThGf5wmZ6WkJF
        In76RF2zn5v6tWPQiOXnrSVscmm6gpfp/o3P+KHvxwSY8ZXYOPNdgUCmo1mPRIMse0h7WC
        J8NETjLAPGxHQNsr8ezRBcm/v+lFzH8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-xWnBAyr8PHS6t1-mPqJvlw-1; Wed, 10 Aug 2022 19:53:03 -0400
X-MC-Unique: xWnBAyr8PHS6t1-mPqJvlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4495885A587;
        Wed, 10 Aug 2022 23:53:03 +0000 (UTC)
Received: from [10.64.54.77] (vpn2-54-77.bne.redhat.com [10.64.54.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8611C9459C;
        Wed, 10 Aug 2022 23:52:58 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     shuah <shuah@kernel.org>, Florian Weimer <fweimer@redhat.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, maz <maz@kernel.org>,
        oliver upton <oliver.upton@linux.dev>,
        andrew jones <andrew.jones@linux.dev>,
        yihyu <yihyu@redhat.com>, shan gavin <shan.gavin@gmail.com>
References: <20220809060627.115847-1-gshan@redhat.com>
 <8735e6ncxw.fsf@oldenburg.str.redhat.com>
 <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com>
 <87o7wtnay6.fsf@oldenburg.str.redhat.com>
 <616d4de6-81f6-9d14-4e57-4a79fec45690@redhat.com>
 <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
 <1014177394.115022.1660052656961.JavaMail.zimbra@efficios.com>
 <YvLT1fd8ddybF5Uw@google.com>
 <1478461718.353.1660133626967.JavaMail.zimbra@efficios.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <1191ef05-ef2c-fe8e-656d-cb89141b36fb@redhat.com>
Date:   Thu, 11 Aug 2022 09:52:55 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1478461718.353.1660133626967.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mathieu,

On 8/10/22 10:13 PM, Mathieu Desnoyers wrote:
> ----- On Aug 9, 2022, at 5:38 PM, Sean Christopherson seanjc@google.com wrote: 
>> On Tue, Aug 09, 2022, Mathieu Desnoyers wrote:
>>> ----- On Aug 9, 2022, at 8:21 AM, Mathieu Desnoyers
>>> mathieu.desnoyers@efficios.com wrote:

[...]

>>>>
>>>> All those are handled in the rseq selftests and in librseq. Why duplicate all
>>>> that logic again?
>>>
>>> More to the point, considering that we have all the relevant rseq registration
>>> code in tools/testing/selftests/rseq/rseq.c already, and the relevant thread
>>> pointer getter code in tools/testing/selftests/rseq/rseq-*thread-pointer.h,
>>> is there an easy way to get test applications in tools/testing/selftests/kvm
>>> and in tools/testing/selftests/rseq to share that common code ?
>>>
>>> Keeping duplicated compatibility code is bad for long-term maintainability.
>>
>> Any reason not to simply add tools/lib/rseq.c and then expose a helper to get
>> the
>> registered rseq struct?
> 
> Indeed, moving rseq.c to tools/lib/ would allow building a .so from any selftest
> which needs to use it.
> 
> And we could move the relevant rseq helper header files to tools/include/rseq/*
> as well.
> 
> Thoughts ?
> 

One question is how librseq.so can be built automatically, when I'm going to
build tools/testing/selftests/kvm/rseq_test.

     # cd linux/tools/testing/selftests/kvm
     # make rseq_test

It's not perfect if I have to build tools/lib/librseq.so in advance, in order
to build tools/testing/selftests/kvm/rseq_test for the sake of dependency.

Thanks,
Gavin




