Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8940259CF3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 05:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiHWDLg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 23:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbiHWDKt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 23:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D185C9DB
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 20:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661224185;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdyIPdKorQDXK1tldjSfL+LVZR0k6xko4u2KPDklhbE=;
        b=FE9xcAhj/+Mye7s95OCm6E0yJNr/ovAhTY36Y41UYU+STxAV2xmjLs+oh1lvFQUz0Gk4tv
        hHFeQec84JEXGWw7YxAYaOHPBJT6raJkaaVNtD2NEJ/GCIejgdxuSnanw2ZkuvsRNeJAlx
        shNTxgaCmRwowuCvSPJrFjlE61zKbAU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-d3zYu98qMW-lWG9QS1UrQg-1; Mon, 22 Aug 2022 23:09:42 -0400
X-MC-Unique: d3zYu98qMW-lWG9QS1UrQg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EADE185A79C;
        Tue, 23 Aug 2022 03:09:41 +0000 (UTC)
Received: from [10.64.54.16] (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E92E492C3B;
        Tue, 23 Aug 2022 03:09:32 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v1 3/5] KVM: selftests: Dirty host pages in dirty_log_test
From:   Gavin Shan <gshan@redhat.com>
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
 <3abb690f-e616-630f-ba40-e590ec8bb5c1@redhat.com>
Message-ID: <0496fe72-e3da-9778-b307-eb5cc157e8fe@redhat.com>
Date:   Tue, 23 Aug 2022 13:09:28 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <3abb690f-e616-630f-ba40-e590ec8bb5c1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Drew,

On 8/22/22 4:29 PM, Gavin Shan wrote:
> On 8/19/22 3:28 PM, Andrew Jones wrote:
>> On Fri, Aug 19, 2022 at 08:55:59AM +0800, Gavin Shan wrote:
>>> It's assumed that 1024 host pages, instead of guest pages, are dirtied
>>> in each iteration in guest_code(). The current implementation misses
>>> the case of mismatched page sizes in host and guest. For example,
>>> ARM64 could have 64KB page size in guest, but 4KB page size in host.
>>> (TEST_PAGES_PER_LOOP / 16), instead of TEST_PAGES_PER_LOOP, host pages
>>> are dirtied in every iteration.
>>>
>>> Fix the issue by touching all sub-pages when we have mismatched
>>> page sizes in host and guest.
>>
>> I'll let the dirty-log test authors decide what's best to do for this
>> test, but I'd think we should let the guest continue dirtying its
>> pages without knowledge of the host pages. Then, adjust the host test
>> code to assert all sub-pages, other than the ones it expects the guest
>> to have written, remain untouched.
>>
> 
> I don't think what is clarified in the change log is correct. The current
> implementation already had the logic to handle the mismatched page sizes
> in vm_dirty_log_verify() where 'step' is used for it by fetching value
> from vm_num_host_pages(mode, 1). Please ignore this patch for now, as
> explained below.
> 
> The issue I have is the 'dirty_log_test' hangs when I have 4KB host page size
> and 64KB guest page size. It seems the vcpu doesn't exit due to full ring
> buffer state or kick-off. I will have more investigations to figure out the
> root cause.
> 

[...]

Please ignore this PATCH[3/5], I think this should be fixed by selecting
correct dirty ring count and the fix will be folded to PATCH[5/5] in next
revision.

In dirty_log_test, we have 1GB memory for guest to write and make them
dirty. When we have mismatch page sizes on host and guest, which is either
4kb-host-64kb-guest or 64kb-host-4kb-guest apart from 16kb case, 16384 host
pages are dirtied in each iteration. The default dirty ring count is 65536.
So the vcpu never exit due to full-dirty-ring-buffer state. This leads the
guest's code keep running and the dirty log isn't collected by the main
thread.

     #define TEST_DIRTY_RING_COUNT           65536

     dirty_pages_per_iteration = (0x40000000 / 0x10000)
                               = 0x4000
                               = 16384

Thanks,
Gavin

