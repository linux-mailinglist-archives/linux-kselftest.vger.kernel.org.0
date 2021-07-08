Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF53BF2CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 02:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGHAZ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 20:25:56 -0400
Received: from mx1.riseup.net ([198.252.153.129]:56494 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhGHAZ4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 20:25:56 -0400
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4GKxpW2Z8mzDqnG;
        Wed,  7 Jul 2021 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1625703795; bh=pvt2GmZluGo+Vd3qf4sFKFHEiik1KEJHbeFnIzmGrkM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ozKuyFK+anmeJciSG5eLbJbnpliiHUYLQ2oolHxgqlNjJmHLeqFRMHFG9EweGD8ea
         pSMKFGPJPpO/5vICTNQEFvjqosy47eX9j1KuunEQbzvxQ2j3Qb7tWCbS9Jq2X0ouBg
         XZvThdPybymiL1KfYD87Lr/VUk82Y17Ibvz4fZls=
X-Riseup-User-ID: 26D00A07A8C4611893A4A0F0AD48FF6F6F3136CB4F00FEA64C6A8EE3AE4C6F23
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4GKxpS2lfLz5vbC;
        Wed,  7 Jul 2021 17:23:12 -0700 (PDT)
Subject: Re: KUnit Hackathon
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, ~lkcamp/discussion@lists.sr.ht,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <n@nfraprado.net>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Leandro Ribeiro <leandrohr@riseup.net>,
        kernel-usp@googlegroups.com
References: <83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f@riseup.net>
 <CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
Message-ID: <ac99a1ca-ed9d-78e7-ad71-ac3c1219b2fe@riseup.net>
Date:   Wed, 7 Jul 2021 21:23:10 -0300
MIME-Version: 1.0
In-Reply-To: <CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Daniel,

Às 03:48 de 07/07/21, Daniel Latypov escreveu:
> On Mon, Jul 5, 2021 at 1:41 PM André Almeida <andrealmeid@riseup.net> wrote:
>>
>> Hello,
>>
>> We belong to two student groups, FLUSP [1] and LKCAMP [2], both of which
>> are focused on sharing kernel and free software development knowledge
>> and experience with fellow free software developers and newcomers.
>>
>> As part of our efforts, we'll be organizing a KUnit hackathon in the
>> next Saturday (July 10), where we intend to help newcomers convert
>> existing runtime tests (the ones found at lib/) to KUnit and maybe
>> create new ones. Depending on the number of attendees, a high volume of
>> patches may be sent throughout the day. We will do our best to review
>> all patches before they go to the kernel mailing lists hoping to avoid
>> wasting your time with minor patching issues.
> 
> That sounds great!
> 

:)

>>
>> So we wanted to let you know of all this beforehand and give you the
>> time to send any suggestions or comments on all this. For instance, we
> 
> Some random, unorganized thoughts:
> * I (as a kernel newbie) found the ownership of tests under lib/ to be
> a bit unclear.
> 

Indeed, but we found that tests under lib/ are the easiest ones to
convert, given that they deal with more "generic" programming aspects,
like linked lists and sort, and doesn't requires subsystem specific
knowledge.

> * Make sure to base on 5.14, there's some new features that could be of use
>   * QEMU support in kunit.py: it's no longer as big of a deal if we
> can't get tests running under UML. Brendan's made it fairly easy to
> run tests in an x86 VM.
>   * Skipped tests support: can now mark a test skipped. Some of the
> lib/ tests could benefit, e.g. test_hash.c
>   * another lib/ test conversion just landed in 5.14, [1], along with
> kunit_kcalloc/kunit_malloc_array() helpers
>   * Documentation/dev-tools/kunit/running_tips.rst - has instructions
> for how to generate code coverage reports using UML/kunit.py
>     * This seems like it could be useful... [2]
> 

Thanks for those info! I wasn't aware of those features.

> * I feel that the hackathon will surface a number of feature requests
> for KUnit. Some patches might be blocked on these features (like your
> uuid patch).
>   * Might be good to track these as they come up and note which
> patches are blocked.
> 

Good suggestion, I'll try to track this.

> * Should we make a decision beforehand wrt renaming test files and
> kconfig options to match the style guide? In the most recent
> conversion [1], I left them as-is. The answer depends on the test
> owner, but we should probably be consistent with what we do in the
> v1's at least.
> 

I believe that to left as-is is easier, and we will suggest people to do
that.

> * I assume test modules used in selftests (test_bitmap, test_printf,
> etc.) should remain untouched for now ?
>   * KUnit does *not* return a non-zero exit code when you modprobe the
> test, as the userspace part of those tests assumes.
>   * We could write a wrapper like kselftest/module.sh, but for KUnit
> test modules, but this extra in-flight patch would become a dependency
> for maybe multiple other conversions.
>   * I'd like it if we had ^ eventually, but I don't know how others
> feel about that.
> 

Yeah, I don't think we would be able to deal with all of this in this
hackathon, so we won't touch those tests for now.

> * I had some small patches for converting test_min_heap.c and
> test_sort.c that I should get around to sending out.
> 

So this means that we shouldn't convert them, right?

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebd09577be6c15ee2d343cf60e5bb819946a5ee8
> [2] I currently see
>   Overall coverage rate:
>   lines......: 16.4% (20034 of 122481 lines)
>   functions..: 18.1% (2032 of 11205 functions)
> with the following kunitconfig
>   CONFIG_KUNIT=y
>   CONFIG_KUNIT_ALL_TESTS=y
>   CONFIG_DEBUG_KERNEL=y
>   CONFIG_DEBUG_INFO=y
>   CONFIG_GCOV=y
> 
> This might be a neat way to motivate participants by showing #s going up.
> Note: I'm more interested in the # of covered functions than anything else.
> The %s are nice to look at, but not that useful since we're only
> compiling a small fraction of kernel code.

Cool! In the end of the hackathon we will compare the numbers to see how
much we were able to do in the event.

> 
>> may ask people to add a special tag to their patches so you may batch
>> review them all at a later time if you wish.
>>
>> Anyhow, we'd really appreciate having your opinion on this.
>> Thanks!
>>
>> [1] - https://flusp.ime.usp.br/
>> [2] - https://lkcamp.dev/
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f%40riseup.net.
