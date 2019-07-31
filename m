Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6D7BC06
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 10:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfGaIoR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 04:44:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfGaIoR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 04:44:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62E3B883D7;
        Wed, 31 Jul 2019 08:44:16 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64BEF1001281;
        Wed, 31 Jul 2019 08:44:07 +0000 (UTC)
Date:   Wed, 31 Jul 2019 10:44:05 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
Message-ID: <20190731084405.tn3x6nmt2svkjkiq@kamzik.brq.redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <20190730105721.z4zsul7uxl2igoue@kamzik.brq.redhat.com>
 <a9824265-daf8-db36-86b8-ad890dc73f14@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9824265-daf8-db36-86b8-ad890dc73f14@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 31 Jul 2019 08:44:16 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 31, 2019 at 10:19:57AM +0200, Thomas Huth wrote:
> On 30/07/2019 12.57, Andrew Jones wrote:
> > On Tue, Jul 30, 2019 at 12:01:12PM +0200, Thomas Huth wrote:
> >> To run the dirty_log_test on s390x, we have to make sure that we
> >> access the dirty log bitmap with little endian byte ordering and
> >> we have to properly align the memslot of the guest.
> >> Also all dirty bits of a segment are set once on s390x when one
> >> of the pages of a segment are written to for the first time, so
> >> we have to make sure that we touch all pages during the first
> >> iteration to keep the test in sync here.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> [...]
> >> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> >> index ceb52b952637..7a1223ad0ff3 100644
> >> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> >> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> >> @@ -26,9 +26,22 @@
> >>  /* The memory slot index to track dirty pages */
> >>  #define TEST_MEM_SLOT_INDEX		1
> >>  
> >> +#ifdef __s390x__
> >> +
> >> +/*
> >> + * On s390x, the ELF program is sometimes linked at 0x80000000, so we can
> >> + * not use 0x40000000 here without overlapping into that region. Thus let's
> >> + * use 0xc0000000 as base address there instead.
> >> + */
> >> +#define DEFAULT_GUEST_TEST_MEM		0xc0000000
> > 
> > I think both x86 and aarch64 should be ok with this offset. If testing
> > proves it does, then we can just change it for all architecture.
> 
> Ok. It seems to work on x86 - could you please check aarch64, since I
> don't have such a system available right now?

Tested it. It works on aarch64 too.

> 
> >> +/* Dirty bitmaps are always little endian, so we need to swap on big endian */
> >> +#if defined(__s390x__)
> >> +# define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
> >> +# define test_bit_le(nr, addr) \
> >> +	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
> >> +# define set_bit_le(nr, addr) \
> >> +	set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
> >> +# define clear_bit_le(nr, addr) \
> >> +	clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
> >> +# define test_and_set_bit_le(nr, addr) \
> >> +	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
> >> +# define test_and_clear_bit_le(nr, addr) \
> >> +	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
> >> +#else
> >> +# define test_bit_le	test_bit
> >> +# define set_bit_le	set_bit
> >> +# define clear_bit_le	clear_bit
> >> +# define test_and_set_bit_le	test_and_set_bit
> >> +# define test_and_clear_bit_le	test_and_clear_bit
> >> +#endif
> > 
> > nit: does the formatting above look right after applying the patch?
> 
> It looked ok to me, but I can add some more tabs to even make it nicer :)
> 
> >> @@ -293,6 +341,10 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
> >>  	 * case where the size is not aligned to 64 pages.
> >>  	 */
> >>  	guest_num_pages = (1ul << (30 - guest_page_shift)) + 16;
> >> +#ifdef __s390x__
> >> +	/* Round up to multiple of 1M (segment size) */
> >> +	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
> > 
> > We could maybe do this for all architectures as well.
> 
> It's really only needed on s390x, so I think we should keep the #ifdef here.
>

OK

Thanks,
drew 
