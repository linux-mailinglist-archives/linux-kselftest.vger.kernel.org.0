Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D72DF255
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Dec 2020 00:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgLSXwN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Dec 2020 18:52:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8665 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgLSXwM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Dec 2020 18:52:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fde92020000>; Sat, 19 Dec 2020 15:51:30 -0800
Received: from [10.2.61.104] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 19 Dec
 2020 23:51:24 +0000
Subject: Re: [PATCH v4 10/10] selftests/vm: test faulting in kernel, and
 verify pinnable pages
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
CC:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Michal Hocko" <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        <mike.kravetz@oracle.com>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        <linux-kselftest@vger.kernel.org>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-11-pasha.tatashin@soleen.com>
 <75b6fb52-ef2c-e17b-2e43-45be913c6206@nvidia.com>
 <CA+CK2bBXRHwNoaT=Nveeb=YaZodS56K+frujvuzGXGCTMvpN7A@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ea5054d9-4b0a-dd02-5a5a-5cd517ae77da@nvidia.com>
Date:   Sat, 19 Dec 2020 15:51:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBXRHwNoaT=Nveeb=YaZodS56K+frujvuzGXGCTMvpN7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608421890; bh=ZdeBd0BbzbdYcoBgcsN6Gcv7RySQm047MWmGyhm/Q4w=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=VU3xoUIAKyYTRXZJj5hbeW6JG3aj20eNcmjRs6lzjeo6tFSBXCscv5H5eCUJhZEl9
         qwXO2SbHXvvZwnNcqgL86EA26VHOYbV+prKzy8ovlihhdKlMSySLScmiCtRuuXI0qS
         jPITu7FAReECPOGwas7m9C+ziTbL8hgDQELG2EWiQH1WjxmMHFzN8f6SbPdEUHgw5M
         hNC+gg/nUoMNEMsvKhSQIA0B4jCym053ETpv9lF2jv3w9grjYsovFDjmNH1m5CAAfP
         mKVNzrjkviBg9Qsfv82nanhdb4dwg1OI7xUtKhbJiwhfGgtvwpxg8KpBKYMgVFtmeS
         ySzh9KgLoawkg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/19/20 7:22 AM, Pavel Tatashin wrote:
...
>> Add a new test to gup_test, to verify that only "pinnable" pages are
>> pinned. Also, use gup/pup + FOLL_TOUCH to fault in the pages, rather
>> than faulting them in from user space.
> 
> OK
> 
>>
>>
>> ?  But I don't know why that second point is important. Is it actually
>> important in order to have a valid test? If so, why?
> 
> It is crucial because when pages are faulted from userland they may
> end up in a movable zone, we spend time migrating them during pinning:
> performance suffers. When pages are faulted from the kernel, they do
> not need to be migrated as they should end-up in the right zone from
> the beginning, and performance should be fast.
> 
> Here is sample run to pin 512M 4096 pages at a time:
> 
> Before my changes:
> Fault in userland:    get:4787 put:1093
> Fault in kernel:      get:80577 put:1187
> In both cases pages in movable zone were pinned. The fault in kernel
> is slower compared to userland, because pages need to be faulted and
> zeroed before returning.
> 
> With my changes:
> Fault in userland:   get:150793 put:1111
> Fault in kernel:        get:81066 put:1091
> In both cases pages were pinned in correct zone. The fault in kernel
> is faster than userland, because userland pages needed to be migrated
> from the movable zone.
> 
> 

OK, I see. So then that second paragraph should read more like this,
instead:

"
Add a new test to gup_test, to help verify that the gup/pup
(get_user_pages() / pin_user_pages()) behavior with respect to pinnable
and movable pages is reasonable and correct. Specifically, provide a way
to:

1) Verify that only "pinnable" pages are pinned. This is checked
automatically for you.

2) Verify that gup/pup performance is reasonable. This requires
comparing benchmarks between doing gup/pup on pages that have been
pre-faulted in from user space, vs. doing gup/pup on pages that are not
faulted in until gup/pup time (via FOLL_TOUCH).

Now, I was going to write the following sentence to finish off the last
paragraph above:

"This decision is controlled with the new -z command line option."

...but see below, before we go with that.


>>
>>
>>>
>>> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>>> ---
>>>    mm/gup_test.c                         |  6 ++++++
>>>    tools/testing/selftests/vm/gup_test.c | 17 +++++++++++++----
>>>    2 files changed, 19 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/gup_test.c b/mm/gup_test.c
>>> index 24c70c5814ba..24fd542091ee 100644
>>> --- a/mm/gup_test.c
>>> +++ b/mm/gup_test.c
>>> @@ -52,6 +52,12 @@ static void verify_dma_pinned(unsigned int cmd, struct page **pages,
>>>
>>>                                dump_page(page, "gup_test failure");
>>>                                break;
>>> +                     } else if (cmd == PIN_LONGTERM_BENCHMARK &&
>>> +                             WARN(!is_pinnable_page(page),
>>> +                                  "pages[%lu] is NOT pinnable but pinned\n",
>>> +                                  i)) {
>>> +                             dump_page(page, "gup_test failure");
>>> +                             break;
>>>                        }
>>>                }
>>>                break;
>>> diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
>>> index 42c71483729f..f08cc97d424d 100644
>>> --- a/tools/testing/selftests/vm/gup_test.c
>>> +++ b/tools/testing/selftests/vm/gup_test.c
>>> @@ -13,6 +13,7 @@
>>>
>>>    /* Just the flags we need, copied from mm.h: */
>>>    #define FOLL_WRITE  0x01    /* check pte is writable */
>>> +#define FOLL_TOUCH   0x02    /* mark page accessed */
>>
>>
>> Aha, now I see why you wanted to pass other GUP flags, in the previous
>> patch. I think it's OK to pass this set of possible flags (as
>> .gup_flags) through ioctl, yes.
> 
> Sure, and I will rename .flags to .gup_flags as you previously suggested.
> 
>>
>> However (this is about the previous patch), I *think* we're better off
>> leaving the gup_test behavior as: "default is read-only pages, but you
>> can pass in -w to specify FOLL_WRITE". As opposed to passing in raw
>> flags from the command line. And yes, I realize that my -F option seemed
>> to recommand the latter...I'm regretting that -F approach now.
> 
> But, that would reverse the current default behaviour where FOLL_WRITE
> is always set. I introduced "-W" not to break backward compatibility
> where the "-w" option was already available, but since "-w" is the
> default it basically does nothing, where "-W '' removes the
> FOLL_WRITE. Do you want to reverse the current behaviour?
> 
>>
>> The other direction to go might be to stop doing that, and shift over to
>> just let the user specify FOLL_* flags directly on the command line, but
>> IMHO there's no need for that (yet), and it's a little less error-prone
>> to constrain it.
>>
>> This leads to: change the "-F 1", to some other better-named option,
>> perhaps. Open to suggestion there.
> 
> Perhaps disable "-F n" and print a warning about the ignored flag
> until it is found to be useful?
> 


OK, now it's clear what to do. My (other) mistake with -F was that I
mis-predicted what the next future feature would need: I thought we'd be
adding sub-flags for the dump pages test, but instead we are (at least
so far) adding flags for the gup/pup calls. So let's adapt to that.

Some of this contradicts what I proposed earlier, but now it forms a
consistent API as a whole. How's this sound:

* Change the meaning of the -F option, slightly: it now means "raw flags
to pass into .gup_flags and thus to gup/pup, and these will override
other options".

* Use -F 0x2 (the value of FOLL_TOUCH) instead of the -z option.

* We can remain backward compatible with -w at the command line level,
with a caveat: passing in "-F 0" or "-F 2" (anything that doesn't set
FOLL_WRITE) will override -w. The rule would be that raw -F flags
override other settings, just for a consistent way to think about it.

* No need, obviously, for any option to undo -w. -F can do that.

* Do *not* provide direct access to .test_control_flags. Just set those
according to a new command line option. Because these aren't (yet)
exploding.

If this is too much fooling around, let me know and I'll send some diffs
or even a patch. I don't want to take away too much time from the main
patch, and I feel some obligation to get gup_test straightened out. :)




>>
>>
>>>
>>>    static char *cmd_to_str(unsigned long cmd)
>>>    {
>>> @@ -39,11 +40,11 @@ int main(int argc, char **argv)
>>>        unsigned long size = 128 * MB;
>>>        int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 1;
>>>        unsigned long cmd = GUP_FAST_BENCHMARK;
>>> -     int flags = MAP_PRIVATE;
>>> +     int flags = MAP_PRIVATE, touch = 0;
>>
>>
>> Silly nit, can we put it on its own line? This pre-existing mess of
>> declarations makes it hard to read everything. One item per line is
>> easier on the reader, who is often just looking for a single item at a
>> time. Actually why not rename it slightly while we're here (see below),
>> maybe to this:
>>
>>          int use_foll_touch = 0;
> 
> Sure, I will move it. I also prefer one initialization per-line, but
> tried to keep the current style. I can also correct the other
> initializations in this function.
> 
>>
>>
>>>        char *file = "/dev/zero";
>>>        char *p;
>>>
>>> -     while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHp")) != -1) {
>>> +     while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHpz")) != -1) {
>>
>> Yes, this seems worth its own command line option.
>>
>>>                switch (opt) {
>>>                case 'a':
>>>                        cmd = PIN_FAST_BENCHMARK;
>>> @@ -110,6 +111,10 @@ int main(int argc, char **argv)
>>>                case 'H':
>>>                        flags |= (MAP_HUGETLB | MAP_ANONYMOUS);
>>>                        break;
>>> +             case 'z':
>>> +                     /* fault pages in gup, do not fault in userland */
>>
>> How about:
>>                          /*
>>                           * Use gup/pup(FOLL_TOUCH), *instead* of faulting
>>                           * pages in from user space.
>>                           */
>>                          use_foll_touch = 1;
> 
> Sure.
> 
>>
>>> +                     touch = 1;
>>> +                     break;
>>>                default:
>>>                        return -1;
>>>                }
>>> @@ -167,8 +172,12 @@ int main(int argc, char **argv)
>>>        else if (thp == 0)
>>>                madvise(p, size, MADV_NOHUGEPAGE);
>>>
>>> -     for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
>>> -             p[0] = 0;
>>> +     if (touch) {
>>> +             gup.flags |= FOLL_TOUCH;
>>> +     } else {
>>> +             for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
>>> +                     p[0] = 0;
>>> +     }

Here, the test would change to "if (gup.gup_flags & FOLL_TOUCH)".

And we need a comment somewhere (maybe right above that) that says something
like:

	/*
	 * FOLL_TOUCH, in gup_test, is used as an either/or case: either
	 * fault pages in from the kernel via FOLL_TOUCH, or fault them
	 * in here, from user space. This allows comparison of performance
	 * between those two cases.
	 */

...OR, you know what? We can do even better. Because the above is too quirky
and weird. Instead, let's leave FOLL_TOUCH "pure": it's just a gup flag.

And then, add an option (maybe -z, after all) that says, "skip faulting pages
in from user space". That's a lot clearer!  And you can tell it's better,
because we don't have to write a chunk of documentation explaining the odd
quirks. Ha, it feels better!

What do you think? (Again, if you want me to send over some diffs that put this
all together, let me know. I'm kind of embarrassed at all the typing required here.)

thanks,
-- 
John Hubbard
NVIDIA
