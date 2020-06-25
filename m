Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C462209849
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 03:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbgFYBqM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 21:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388930AbgFYBqM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 21:46:12 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B2C061573;
        Wed, 24 Jun 2020 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=NCWiNmIOvXFRmSsuJI33xCe+sMXLvcNiaaT5Vwwk2zY=; b=cXl7H9JBrqku6ErGyhwsfoFhGG
        Qx9bzx6Uz8DkjiQOKXUQMIbz1yHIiC/sAUlb3gKjXZuYOeaP/dQsN1vq2rZMz/RUDKTJ0NaI2i4NV
        FdURPIemnxB5i7p65LLgYJMVdYwbczkxdI9T6zlOpgdciD2w0+B2tG5Qu0/LjC3Koyka0TYqFcDWC
        uUqmgq6WdvcBBf6u6mDgwY59jooOxQUavebqLhFUi8QR/Y0v4qXl/rjU4g55uYtkUtYocGnegDwxB
        6LutkeU57yjLL3RAwBp5lVnmxGG7QUc/v/n/A5kmza74hzZn8hSHk59I4rHoM/ETbD2Z/RFOPd6HM
        stAgAi7w==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joGxc-0000WM-3w; Thu, 25 Jun 2020 01:45:52 +0000
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook>
 <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
 <903628180.54697.1592983405305.JavaMail.zimbra@nod.at>
 <202006241335.2C0FB5DF90@keescook>
 <b97853f0-c4be-7039-1d4c-96b3ab802472@infradead.org>
 <CAFLxGvxiyyX9s=y4phGxvWh-vonS1WPOUbRZr9mgq-B+wY+2nQ@mail.gmail.com>
 <10f7c20a-0a32-f5cf-7fdf-761db22afcd9@infradead.org>
 <03486f13-b138-2fc6-4d90-2737d86add2f@infradead.org>
Message-ID: <80f501f4-d4fb-1f22-5603-57b5490a695d@infradead.org>
Date:   Wed, 24 Jun 2020 18:45:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <03486f13-b138-2fc6-4d90-2737d86add2f@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/24/20 3:35 PM, Randy Dunlap wrote:
> On 6/24/20 3:23 PM, Randy Dunlap wrote:
>> On 6/24/20 3:01 PM, Richard Weinberger wrote:
>>> On Wed, Jun 24, 2020 at 11:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>
>>>> On 6/24/20 1:36 PM, Kees Cook wrote:
>>>>> On Wed, Jun 24, 2020 at 09:23:25AM +0200, Richard Weinberger wrote:
>>>>>> ----- Ursprüngliche Mail -----
>>>>>>>>> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?
>>>>>>>
>>>>>>>> True that, we can rip the file.
>>>>>>>
>>>>>>> Has anyone fixed the uml build errors?
>>>>>>
>>>>>> I didn't realize that this is a super urgent issue. ;-)
>>>>>>
>>>>>> Kees, if you want you can carry a patch in your series, I'll ack it.
>>>>>> Otherwise I can also do a patch and bring it via the uml tree upstream
>>>>>> as soon more fixes queued up.
>>>>>
>>>>> I think the lkdtm change will tweak this bug, so I'm happy to carry the
>>>>> patch (I just haven't had time to create and test one). Is it really
>>>>> just as simple as removing arch/x86/um/asm/desc.h?
>>>>>
>>>>
>>>> I just tried that and the build is still failing, so No, it's not that simple.
>>>>
>>>> But thanks for offering.
>>>>
>>>> I'll just ignore the UML build errors for now.
>>>
>>> This is a allyesconfig?
>>> I just gave CONFIG_LKDTM=y a try, builds fine here.
>>>
>>
>> I'm building linux-next and it fails.
> 
> More specifically, uml for i386 fails. x86_64 is OK.
> The problem is with the <asm/desc.h> file.
> I'm tampering with it...

I'm not getting anywhere with this. Too many mazes of tiny twisty passages.

>>> But the desc.h in uml is still in vain and can be deleted AFAICT.

Looks like lkdtm/bugs.c needs to get/use arch/x86/include/asm/processor.h
but it actually uses arch/x86/um/asm/processor*.h, which does not have the
needed structs etc.


Here are the build errors and warnings that I am seeing with allmodconfig:


  CC [M]  drivers/misc/lkdtm/bugs.o
In file included from ../arch/x86/include/asm/desc.h:11:0,
                 from ../drivers/misc/lkdtm/bugs.c:17:
../arch/x86/include/asm/cpu_entry_area.h:65:42: error: invalid application of ‘sizeof’ to incomplete type ‘struct x86_hw_tss’
  unsigned long stack[(PAGE_SIZE - sizeof(struct x86_hw_tss)) / sizeof(unsigned long)];
                                          ^~~~~~
../arch/x86/include/asm/cpu_entry_area.h:66:20: error: field ‘tss’ has incomplete type
  struct x86_hw_tss tss;
                    ^~~
../arch/x86/include/asm/cpu_entry_area.h:89:26: error: field ‘entry_stack_page’ has incomplete type
  struct entry_stack_page entry_stack_page;
                          ^~~~~~~~~~~~~~~~
../arch/x86/include/asm/cpu_entry_area.h:100:20: error: field ‘tss’ has incomplete type
  struct tss_struct tss;
                    ^~~
In file included from ../drivers/misc/lkdtm/bugs.c:17:0:
../arch/x86/include/asm/desc.h:45:25: error: ‘GDT_ENTRIES’ undeclared here (not in a function); did you mean ‘LDT_ENTRIES’?
  struct desc_struct gdt[GDT_ENTRIES];
                         ^~~~~~~~~~~
                         LDT_ENTRIES
../arch/x86/include/asm/desc.h: In function ‘__set_tss_desc’:
../arch/x86/include/asm/desc.h:186:10: error: ‘__KERNEL_TSS_LIMIT’ undeclared (first use in this function); did you mean ‘__KERNEL__’?
          __KERNEL_TSS_LIMIT);
          ^~~~~~~~~~~~~~~~~~
          __KERNEL__
../arch/x86/include/asm/desc.h:186:10: note: each undeclared identifier is reported only once for each function it appears in
../arch/x86/include/asm/desc.h: In function ‘native_set_ldt’:
../arch/x86/include/asm/desc.h:202:40: error: ‘GDT_ENTRY_LDT’ undeclared (first use in this function); did you mean ‘GDT_ENTRY_INIT’?
   write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_LDT,
                                        ^
../arch/x86/include/asm/desc.h:123:75: note: in definition of macro ‘write_gdt_entry’
 #define write_gdt_entry(dt, entry, desc, type) native_write_gdt_entry(dt, entry, desc, type)
                                                                           ^~~~~
../arch/x86/include/asm/desc.h: In function ‘native_load_tr_desc’:
../arch/x86/include/asm/desc.h:259:31: error: ‘GDT_ENTRY_TSS’ undeclared (first use in this function); did you mean ‘GDT_ENTRIES’?
  asm volatile("ltr %w0"::"q" (GDT_ENTRY_TSS*8));
                               ^~~~~~~~~~~~~
                               GDT_ENTRIES
../arch/x86/include/asm/desc.h: In function ‘native_load_tls’:
../arch/x86/include/asm/desc.h:278:33: error: ‘struct thread_struct’ has no member named ‘tls_array’
   gdt[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i];
                                 ^~
In file included from ../arch/x86/include/asm/string.h:3:0,
                 from ../include/linux/string.h:20,
                 from ../arch/x86/um/asm/processor_32.h:9,
                 from ../arch/x86/um/asm/processor.h:10,
                 from ../include/linux/rcupdate.h:30,
                 from ../include/linux/rculist.h:11,
                 from ../include/linux/pid.h:5,
                 from ../include/linux/sched.h:14,
                 from ../drivers/misc/lkdtm/bugs.c:10:
../arch/x86/include/asm/desc.h: In function ‘force_reload_TR’:
../arch/x86/include/asm/desc.h:288:18: error: ‘GDT_ENTRY_TSS’ undeclared (first use in this function); did you mean ‘GDT_ENTRIES’?
  memcpy(&tss, &d[GDT_ENTRY_TSS], sizeof(tss_desc));
                  ^
../arch/x86/include/asm/string_32.h:182:45: note: in definition of macro ‘memcpy’
 #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
                                             ^
In file included from ../include/linux/kernel.h:11:0,
                 from ../drivers/misc/lkdtm/lkdtm.h:7,
                 from ../drivers/misc/lkdtm/bugs.c:8:
../arch/x86/include/asm/desc.h: In function ‘invalidate_tss_limit’:
../arch/x86/include/asm/desc.h:327:32: error: ‘TIF_IO_BITMAP’ undeclared (first use in this function); did you mean ‘CONFIG_SBITMAP’?
  if (unlikely(test_thread_flag(TIF_IO_BITMAP)))
                                ^
../include/linux/compiler.h:78:42: note: in definition of macro ‘unlikely’
 # define unlikely(x) __builtin_expect(!!(x), 0)
                                          ^
../arch/x86/include/asm/desc.h:327:15: note: in expansion of macro ‘test_thread_flag’
  if (unlikely(test_thread_flag(TIF_IO_BITMAP)))
               ^~~~~~~~~~~~~~~~
In file included from ../drivers/misc/lkdtm/bugs.c:17:0:
../arch/x86/include/asm/desc.h: At top level:
../arch/x86/include/asm/desc.h:334:0: warning: "LDT_empty" redefined
 #define LDT_empty(info)     \
 
In file included from ../arch/um/include/asm/mmu.h:10:0,
                 from ../include/linux/mm_types.h:18,
                 from ../include/linux/sched/signal.h:13,
                 from ../drivers/misc/lkdtm/bugs.c:11:
../arch/x86/um/asm/mm_context.h:65:0: note: this is the location of the previous definition
 #define LDT_empty(info) (_LDT_empty(info))
 
In file included from ../drivers/misc/lkdtm/bugs.c:17:0:
../arch/x86/include/asm/desc.h: In function ‘get_cpu_gdt_rw’:
../arch/x86/include/asm/desc.h:54:1: warning: control reaches end of non-void function [-Wreturn-type]
 }
 ^


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
