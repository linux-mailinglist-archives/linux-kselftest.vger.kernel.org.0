Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6003D58E431
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 02:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiHJAqH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 20:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHJAqE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 20:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB3024B4BA
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Aug 2022 17:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660092361;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/MAn6qAg/Jsbs3sbj308t0Whag8V+DOtIapBcO490g=;
        b=JGzN7HUkemSs5/rkHWzwXuSsXBxqonPlbreNMjjufGbp4y3DWhQvbL3bWrAMMOOa86UqlG
        m3wBCFqg2syrhWkL+kHerg+DhyJJvJMoRNgTMsIiab/aLSy9hKuiU+1D+ejZIQbA/JyOKL
        +QYc8VfLZR2pWat2KOJND0aqkt3OlzA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-XoWcY8H1PiqgLZYkjOgRSg-1; Tue, 09 Aug 2022 20:45:58 -0400
X-MC-Unique: XoWcY8H1PiqgLZYkjOgRSg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2ADD8039A1;
        Wed, 10 Aug 2022 00:45:57 +0000 (UTC)
Received: from [10.64.54.189] (vpn2-54-189.bne.redhat.com [10.64.54.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B797492C3B;
        Wed, 10 Aug 2022 00:45:53 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Use getcpu() instead of
 sched_getcpu() in rseq_test
To:     Sean Christopherson <seanjc@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        oliver.upton@linux.dev, andrew.jones@linux.dev,
        mathieu.desnoyers@efficios.com, yihyu@redhat.com,
        shan.gavin@gmail.com
References: <20220809060627.115847-1-gshan@redhat.com>
 <20220809060627.115847-3-gshan@redhat.com>
 <87y1vxncv1.fsf@oldenburg.str.redhat.com>
 <87mtcdnaxe.fsf@oldenburg.str.redhat.com>
 <ea2ef1a2-0fd8-448b-d7ca-254603518823@redhat.com>
 <YvLJUEOcxaZKW0y1@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <2f8f9062-3e89-7a09-02c4-ab1b2dc07356@redhat.com>
Date:   Wed, 10 Aug 2022 10:45:50 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YvLJUEOcxaZKW0y1@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/10/22 6:53 AM, Sean Christopherson wrote:
> On Tue, Aug 09, 2022, Gavin Shan wrote:
>> On 8/9/22 5:17 PM, Florian Weimer wrote:
>>> * Florian Weimer:
>>>
>>>> * Gavin Shan:
>>>>
>>>>> sched_getcpu() is glibc dependent and it can simply return the CPU
>>>>> ID from the registered rseq information, as Florian Weimer pointed.
>>>>> In this case, it's pointless to compare the return value from
>>>>> sched_getcpu() and that fetched from the registered rseq information.
>>>>>
>>>>> Fix the issue by replacing sched_getcpu() with getcpu(), as Florian
>>>>> suggested. The comments are modified accordingly.
>>>>
>>>> Note that getcpu was added in glibc 2.29, so perhaps you need to perform
>>>> a direct system call?
>>>
>>> One more thing: syscall(__NR_getcpu) also has the advantage that it
>>> wouldn't have to be changed again if node IDs become available via rseq
>>> and getcpu is implemented using that.
>>>
>>> Thanks,
>>> Florian
>>>
>>
>> Thanks, Florian. It makes sense to me to use syscall(__NR_getcpu) in
>> next revision. Thanks for your quick review :)
> 
> +1, and definitely add a comment to prevent future "cleanup".
> 

Yep, I will have something like below in next revision:

     /*
      * We have to perform direct system call for getcpu() because it's not
      * available until glic 2.29.
      */

Thanks,
Gavin

