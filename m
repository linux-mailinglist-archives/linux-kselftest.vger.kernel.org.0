Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A4A19C350
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgDBN4a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 09:56:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20958 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728281AbgDBN4a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 09:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585835789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LynRBm0QdjHVu82HMM2DCC2CaC+mcsg4vB8dlsKoP9A=;
        b=EYmJPkWRoCqVN3SdAcVr5xawEpQyvYCxy+w9U4NjpWK6jTE+sf6TlzX0mXCH4HloIOjnXe
        3ahyB2wovLj7YwtA1SKGIRThmBA0uxO8pAm5hhaCQHjOeJgiCOSDelILuxDvoVM+3apNCu
        JcKXGioxIhD+WuQ+qCnOn4w3Swhr4wU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-RDG4fjfhMsyhNBw_9UBvww-1; Thu, 02 Apr 2020 09:56:27 -0400
X-MC-Unique: RDG4fjfhMsyhNBw_9UBvww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DA9E18A6EC1;
        Thu,  2 Apr 2020 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5A151001938;
        Thu,  2 Apr 2020 13:56:20 +0000 (UTC)
Subject: Re: [PATCH 2/2] selftests: kvm: Add mem_slot_test test
To:     Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        david@redhat.com
References: <20200330204310.21736-1-wainersm@redhat.com>
 <20200330204310.21736-3-wainersm@redhat.com>
 <20200402090029.pc6w6iqikgthflhq@kamzik.brq.redhat.com>
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <e6676068-3214-f9bf-832b-889facc8b091@redhat.com>
Date:   Thu, 2 Apr 2020 10:56:18 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200402090029.pc6w6iqikgthflhq@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/2/20 6:00 AM, Andrew Jones wrote:
> On Mon, Mar 30, 2020 at 05:43:10PM -0300, Wainer dos Santos Moschetta wrote:
>> This patch introduces the mem_slot_test test which checks
>> an VM can have added memory slots up to the limit defined in
>> KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
>> verify it fails as expected.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>>   tools/testing/selftests/kvm/.gitignore      |  1 +
>>   tools/testing/selftests/kvm/Makefile        |  3 +
>>   tools/testing/selftests/kvm/mem_slot_test.c | 92 +++++++++++++++++++++
>>   3 files changed, 96 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c
>>
> BTW, in kvm/queue we also now have
>
> x86_64/set_memory_region_test.c
>
> I wonder if we shouldn't try to make x86_64/set_memory_region_test.c
> arch-neutral and then integrate this new test with it.

When I started work on this test I called it "add_max_mem_slots" but 
then I realized it could be rather a suite for other tests, so it was 
renamed. So yes, I think we can try to merge those memory region tests 
altogether.

I'm about to send a v2 where I address all your comments and hopefully 
we can use as the base for such as integration. Makes sense?

Thanks!

- Wainer


>
> Thanks,
> drew

