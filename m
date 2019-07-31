Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512C17BB6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 10:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGaIUJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 04:20:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfGaIUI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 04:20:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4E8E307CDFC;
        Wed, 31 Jul 2019 08:20:07 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7ACE600CC;
        Wed, 31 Jul 2019 08:19:58 +0000 (UTC)
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
To:     Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <20190730105721.z4zsul7uxl2igoue@kamzik.brq.redhat.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Organization: Red Hat
Message-ID: <a9824265-daf8-db36-86b8-ad890dc73f14@redhat.com>
Date:   Wed, 31 Jul 2019 10:19:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730105721.z4zsul7uxl2igoue@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 31 Jul 2019 08:20:07 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30/07/2019 12.57, Andrew Jones wrote:
> On Tue, Jul 30, 2019 at 12:01:12PM +0200, Thomas Huth wrote:
>> To run the dirty_log_test on s390x, we have to make sure that we
>> access the dirty log bitmap with little endian byte ordering and
>> we have to properly align the memslot of the guest.
>> Also all dirty bits of a segment are set once on s390x when one
>> of the pages of a segment are written to for the first time, so
>> we have to make sure that we touch all pages during the first
>> iteration to keep the test in sync here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
[...]
>> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
>> index ceb52b952637..7a1223ad0ff3 100644
>> --- a/tools/testing/selftests/kvm/dirty_log_test.c
>> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
>> @@ -26,9 +26,22 @@
>>  /* The memory slot index to track dirty pages */
>>  #define TEST_MEM_SLOT_INDEX		1
>>  
>> +#ifdef __s390x__
>> +
>> +/*
>> + * On s390x, the ELF program is sometimes linked at 0x80000000, so we can
>> + * not use 0x40000000 here without overlapping into that region. Thus let's
>> + * use 0xc0000000 as base address there instead.
>> + */
>> +#define DEFAULT_GUEST_TEST_MEM		0xc0000000
> 
> I think both x86 and aarch64 should be ok with this offset. If testing
> proves it does, then we can just change it for all architecture.

Ok. It seems to work on x86 - could you please check aarch64, since I
don't have such a system available right now?

>> +/* Dirty bitmaps are always little endian, so we need to swap on big endian */
>> +#if defined(__s390x__)
>> +# define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
>> +# define test_bit_le(nr, addr) \
>> +	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
>> +# define set_bit_le(nr, addr) \
>> +	set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
>> +# define clear_bit_le(nr, addr) \
>> +	clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
>> +# define test_and_set_bit_le(nr, addr) \
>> +	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
>> +# define test_and_clear_bit_le(nr, addr) \
>> +	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
>> +#else
>> +# define test_bit_le	test_bit
>> +# define set_bit_le	set_bit
>> +# define clear_bit_le	clear_bit
>> +# define test_and_set_bit_le	test_and_set_bit
>> +# define test_and_clear_bit_le	test_and_clear_bit
>> +#endif
> 
> nit: does the formatting above look right after applying the patch?

It looked ok to me, but I can add some more tabs to even make it nicer :)

>> @@ -293,6 +341,10 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
>>  	 * case where the size is not aligned to 64 pages.
>>  	 */
>>  	guest_num_pages = (1ul << (30 - guest_page_shift)) + 16;
>> +#ifdef __s390x__
>> +	/* Round up to multiple of 1M (segment size) */
>> +	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
> 
> We could maybe do this for all architectures as well.

It's really only needed on s390x, so I think we should keep the #ifdef here.

 Thomas
