Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1759B971
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 08:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiHVGaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 02:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiHVGaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 02:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3574315FC8
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661149809;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igi6SCsR/ObSuD1+1UNbW/kz76/mLSNsS0/F0XSJRwQ=;
        b=Z0ep5JfX/iVtZN0Bq1b2I3ddAh2PzIkJ4XyLxjG+OfJDsi4lXBIlZT6VEfiwwiYewM7s8R
        dTaFq94GBmGjva4om+g2knpc2obC8OQbbPHpvgFTUUTFsx2xaGqviTrMbI6LU8Wbk911Fk
        53NtWrKFbQACMED6uUbaqUNTYh0HffI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-MWAu8DFOPdeT1R7mPJoJIQ-1; Mon, 22 Aug 2022 02:30:05 -0400
X-MC-Unique: MWAu8DFOPdeT1R7mPJoJIQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3D7D1C01B20;
        Mon, 22 Aug 2022 06:30:03 +0000 (UTC)
Received: from [10.64.54.16] (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08EE12026D4C;
        Mon, 22 Aug 2022 06:29:54 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v1 3/5] KVM: selftests: Dirty host pages in dirty_log_test
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        peterx@redhat.com, pbonzini@redhat.com, corbet@lwn.net,
        maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        seanjc@google.com, drjones@redhat.com, dmatlack@google.com,
        bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
References: <20220819005601.198436-1-gshan@redhat.com>
 <20220819005601.198436-4-gshan@redhat.com>
 <20220819052805.qnhw2d3arxixzvhl@kamzik>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <3abb690f-e616-630f-ba40-e590ec8bb5c1@redhat.com>
Date:   Mon, 22 Aug 2022 16:29:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220819052805.qnhw2d3arxixzvhl@kamzik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Drew,

On 8/19/22 3:28 PM, Andrew Jones wrote:
> On Fri, Aug 19, 2022 at 08:55:59AM +0800, Gavin Shan wrote:
>> It's assumed that 1024 host pages, instead of guest pages, are dirtied
>> in each iteration in guest_code(). The current implementation misses
>> the case of mismatched page sizes in host and guest. For example,
>> ARM64 could have 64KB page size in guest, but 4KB page size in host.
>> (TEST_PAGES_PER_LOOP / 16), instead of TEST_PAGES_PER_LOOP, host pages
>> are dirtied in every iteration.
>>
>> Fix the issue by touching all sub-pages when we have mismatched
>> page sizes in host and guest.
> 
> I'll let the dirty-log test authors decide what's best to do for this
> test, but I'd think we should let the guest continue dirtying its
> pages without knowledge of the host pages. Then, adjust the host test
> code to assert all sub-pages, other than the ones it expects the guest
> to have written, remain untouched.
> 

I don't think what is clarified in the change log is correct. The current
implementation already had the logic to handle the mismatched page sizes
in vm_dirty_log_verify() where 'step' is used for it by fetching value
from vm_num_host_pages(mode, 1). Please ignore this patch for now, as
explained below.

The issue I have is the 'dirty_log_test' hangs when I have 4KB host page size
and 64KB guest page size. It seems the vcpu doesn't exit due to full ring
buffer state or kick-off. I will have more investigations to figure out the
root cause.

# ./dirty_log_test -M dirty-ring -m 7
Setting log mode to: 'dirty-ring'
Test iterations: 32, interval: 10 (ms)
Testing guest mode: PA-bits:40,  VA-bits:48, 64K pages
guest physical test memory offset: 0xffbffc0000
vcpu stops because vcpu is kicked out...
Notifying vcpu to continue
vcpu continues now.
Iteration 1 collected 1903 pages
<no more output>

'dirty_lot_test' works well when both host and guest have 4KB page size.

# ./dirty_log_test -M dirty-ring -m 5
Setting log mode to: 'dirty-ring'
Test iterations: 32, interval: 10 (ms)
Testing guest mode: PA-bits:40,  VA-bits:48,  4K pages
guest physical test memory offset: 0xffbfffc000
vcpu stops because vcpu is kicked out...
Notifying vcpu to continue
vcpu continues now.
   :
Dirtied 1006592 pages
Total bits checked: dirty (1020487), clear (7106070), track_next (974104)

Thanks,
Gavin



