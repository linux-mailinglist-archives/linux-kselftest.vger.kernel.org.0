Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6B708A06
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 23:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjERVEN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 17:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjERVEM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 17:04:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F31127;
        Thu, 18 May 2023 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684443850; x=1715979850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BKZkWqVM3TSRGEgi6QXPku0HgKD5sRN6Pggh4RMq1Xs=;
  b=kXlQB1qE7j7rFWimfJOBEKNC8OZnKlsbJ8o+7u30W6vIILmL/u/ahlOl
   swMvwDkdctb9dwet+MFfbrKgYwwt5kw925ox6IstbswtmbAGZRJbCUujJ
   kMpnmlEy76YDBH4gV9OpKQ1kV+48KyFPMwTrDJ4CbegWOSDNDRhqRQHxJ
   QEdHfOTMv3FQZmHjE3E0fXHWSZcQwI1rw1qRptSUlJ2gPn/R7UVp06dmd
   jTsrRONT3oxU/CphaTUhRUHKACsdmF3rUr3y3/umT968SyAD/sNXx055K
   4lFlAMjuxKx+3+SGmrr8d7kPye1h5lSeqZX/nhdV7bKri7FnLcY9dRiGf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355412910"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="355412910"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 14:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="772026268"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="772026268"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.209.81.123]) ([10.209.81.123])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 14:04:08 -0700
Message-ID: <9d64c949-6d5f-06c0-47ef-caade67477e5@intel.com>
Date:   Thu, 18 May 2023 14:04:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     =?UTF-8?Q?Stephen_R=c3=b6ttger?= <sroettger@google.com>,
        jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com>
 <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com>
 <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
 <b69f6809-b483-158f-8be9-4976fad918d8@intel.com>
 <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
 <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com>
 <CALmYWFuSTc5Q7Hrra8FijE11+Y1KiROa=xCZWL1D3ifthrrDMQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CALmYWFuSTc5Q7Hrra8FijE11+Y1KiROa=xCZWL1D3ifthrrDMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/18/23 13:20, Jeff Xu wrote:>> Here's my concern about this whole
thing: it's headed down a rabbit hole
>> which is *highly* specialized both in the apps that will use it and the
>> attacks it will mitigate.  It probably *requires* turning off a bunch of
>> syscalls (like io_uring) that folks kinda like in general.
>>
> ChromeOS currently disabled io_uring, but it is not required to do so.
> io_uring supports the IORING_OP_MADVICE operation, which calls the
> do_madvise() function. This means that io_uring will have the same
> pkey checks as the madvice() system call.  From that perspective, we
> will fully support io_uring for this feature.

io_uring fundamentally doesn't have the same checks.  The kernel side
work can be done from an asynchronous kernel thread.  That kernel thread
doesn't have a meaningful PKRU value.  The register has a value, but
it's not really related to the userspace threads that are sending it
requests.

>> We're balancing that highly specialized mitigation with a feature that
>> add new ABI, touches core memory management code and signal handling.
>>
> The ABI change uses the existing flag field in pkey_alloc() which is
> reserved. The implementation is backward compatible with all existing
> pkey usages in both kernel and user space.  Or do you have other
> concerns about ABI in mind ?

I'm not worried about the past, I'm worried any time we add a new ABI
since we need to support it forever.

> Yes, you are right about the risk of touching core mm code. To
> minimize the risk, I try to control the scope of the change (it is
> about 3 lines in mprotect, more in munmap but really just 3 effective
> lines from syscall entry). I added new self-tests in mm to make sure
> it doesn't regress in api behavior. I run those tests before and after
> my kernel code change to make sure the behavior remains the same, I
> tested it on 5.15 and 6.1 and 6.4-rc1.  Actually, the testing
> discovered a behavior change for mprotect() between 6.1 and 6.4  (not
> from this patch, there are refactoring works going on in mm) see this
> thread [1]
> I hope those steps will help to mitigate the risk.
> 
> Agreed on signaling handling is a tough part: what do you think about
> the approach (modifying PKRU from saved stack after XSAVE), is there a
> blocker ?

Yes, signal entry and sigreturn are not necessarily symmetric so you
can't really have a stack.

>> On the x86 side, PKRU is a painfully special snowflake.  It's exposed in
>> the "XSAVE" ABIs, but not actually managed *with* XSAVE in the kernel.
>> This would be making it an even more special snowflake because it would
> 
> I admit I'm quite ignorant on XSAVE  to understand the above
> statement, and how that is related. Could you explain it to me please
> ? And what is in your mind that might improve the situation ?

In a nutshell: XSAVE components are classified as either user or
supervisor.  User components can be modified from userspace and
supervisor ones only from the kernel.  In general, user components don't
affect the kernel; the kernel doesn't care what is in ZMM11 (an
XSAVE-managed register).  That lets us do fun stuff like be lazy about
when ZMM11 is saved/restored.  Being lazy is good because it give us
things like faster context switches and KVM VMEXIT handling.

PKRU is a user component, but it affects the kernel when the kernel does
copy_to/from_user() and friends.  That means that the kernel can't do
any "fun stuff" with PKRU.  As soon as userspace provides a new value,
the kernel needs to start respecting it.  That makes PKRU a very special
snowflake.

So, even though PKRU can be managed by XSAVE, it isn't.  It isn't kept
in the kernel XSAVE buffer.  But it *IS* in the signal stack XSAVE
buffer.  You *can* save/restore it with the other XSAVE components with
ptrace().  The user<->kernel ABI pretends that PKRU is XSAVE managed
even though it is not.

All of this is special-cased.  There's a ton of code to handle this
mess.  It's _complicated_.  I haven't even started talking about how
this interacts with KVM and guests.

How could we improve it?  A time machine would help to either change the
architecture or have Linux ignore the fact that XSAVE knows anything
about PKRU.

So, the bar is pretty high for things that want to further muck with
PKRU.  Add signal and sigaltstack in particular into the fray, and we've
got a recipe for disaster.  sigaltstack and XSAVE don't really get along
very well.  https://lwn.net/Articles/862541/

>> need new altstack ABI and handling.
>>
> I thought adding protected memory support to signaling handling is an
> independent project with its own weight. As Jann Horn points out in
> [2]:  "we could prevent the attacker from corrupting the signal
> context if we can protect the signal stack with a pkey."   However,
> the kernel will send SIGSEGV when the stack is protected by PKEY,  so
> there is a benefit to make this work.  (Maybe Jann can share some more
> thoughts on the benefits)
> 
> And I believe we could do this in a way with minimum ABI change, as below:
> - allocate PKEY with a new flag (PKEY_ALTSTACK)
> - at sigaltstack() call, detect the memory is PKEY_ALTSTACK protected,
> (similar as what mprotect does in this patch) and save it along with
> stack address/size.
> - at signaling handling, use the saved info to fill in PKRU.
> The ABI change is similar to PKEY_ENFORCE_API, and there is no
> backward compatibility issue.
> 
> Will these mentioned help our case ? What do you think ?

To be honest, no.

What you've laid out here is the tip of the complexity iceberg.  There
are a lot of pieces of the kernel that are not yet factored in.

Let's also remember: protection keys is *NOT* a security feature.  It's
arguable that pkeys is a square peg trying to go into a round security hole.
