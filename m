Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468A93EBCAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Aug 2021 21:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhHMTr6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Aug 2021 15:47:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMTr6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Aug 2021 15:47:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4FD241F44A5A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Will Deacon <will@kernel.org>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, luto@kernel.org,
        linux-kselftest@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2] selftest: Add test for Soft-Dirty PTE bit
Organization: Collabora
References: <20210603151518.2437813-1-krisman@collabora.com>
        <20210813150009.GC8451@willie-the-truck>
Date:   Fri, 13 Aug 2021 15:47:23 -0400
In-Reply-To: <20210813150009.GC8451@willie-the-truck> (Will Deacon's message
        of "Fri, 13 Aug 2021 16:00:10 +0100")
Message-ID: <87lf553z5g.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Will Deacon <will@kernel.org> writes:

> On Thu, Jun 03, 2021 at 11:15:18AM -0400, Gabriel Krisman Bertazi wrote:
>> This introduces three tests:
>> 
>> 1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
>> check if the SD bit flipped.
>> 
>> 2) Check VMA reuse: validate the VM_SOFTDIRTY usage
>> 
>> 3) Check soft-dirty on huge pages
>> 
>> This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
>> Invalidate TLB after clearing soft-dirty page state"). I was tracking the
>> same issue that he fixed, and this test would have caught it.
>> 
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> 
>> --
>> Changes since V1:
>>   - Fix last minute build break with page_size
>> ---
>>  tools/testing/selftests/Makefile              |   1 +
>>  tools/testing/selftests/soft-dirty/.gitignore |   1 +
>>  tools/testing/selftests/soft-dirty/Makefile   |   9 +
>>  .../testing/selftests/soft-dirty/soft-dirty.c | 254 ++++++++++++++++++
>>  4 files changed, 265 insertions(+)
>>  create mode 100644 tools/testing/selftests/soft-dirty/.gitignore
>>  create mode 100644 tools/testing/selftests/soft-dirty/Makefile
>>  create mode 100644 tools/testing/selftests/soft-dirty/soft-dirty.c
>
> Although I think adding a test for this is great (and I certainly wouldn't
> want to get in the way of that; quite the opposite), I notice that we
> already have test_softdirty() in selftests/vm/madv_populate.c. Would we be
> better off extending that test instead of introducing another one?

Hi, Will. Thanks for the review.

Looks like selftests/vm/madv_populate.c was merged after I sent this,
which explains why I missed it.  From a quick look, it also doesn't
verify the corner case of I'm checking here.  I will look into merging
the two tests, or at least moving this to vm/ and remove the overlap.

Thanks,

-- 
Gabriel Krisman Bertazi
