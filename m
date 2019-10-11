Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33551D4384
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfJKO4X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 10:56:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKO4X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 10:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VzyDG8mxkOlQKgeR6xFwM1BuSTEYj9mJKpZy596fXRw=; b=oxmdRYkaaBxT1jEXuvrJL3yuF
        1iwfgVy1QyrJ20/ej5EtZZ9yZeUmj/n1n/Jxs5hcla/9fjHcLPPyJCqd8UyZpx7UpH2EgJVlm1Voo
        WA1ImROfo+fjnUWaesJXxDOpCc3XwZ7W4mW/cCTnkJDhYCkfRHEyYWRzVioQ7CkpDrKAPyT2j/8EJ
        fVd3JPlH0EZpUJDjtdHz7eM+zEWIG4yD137Jy1X0pO1RrBNgrQQv9Zs2XljfYfbQG7RL1GwjL8mpG
        j3oK+E+2k8hmvPdoA3RgaCf+YuUyIyLtddlnzqbzEhyWKAbhpQg6Ev0/ZSV34dqbGCRPtL/gdIv5A
        6LTE5hK9w==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIwL7-00056i-UJ; Fri, 11 Oct 2019 14:56:21 +0000
Subject: Re: kunit.py should default to --build_dir=.kunit
To:     Brendan Higgins <brendanhiggins@google.com>,
        Theodore Ts'o <theodore.tso@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>
References: <c99604e5-2ea4-4075-9a39-470104298368@googlegroups.com>
 <CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <291f012c-0ffd-599e-0dac-a6b4e05ebb97@infradead.org>
Date:   Fri, 11 Oct 2019 07:56:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/11/19 4:19 AM, Brendan Higgins wrote:
> +open list:KERNEL SELFTEST FRAMEWORK In case anyone in kselftest has
> any thoughts.
> 
> On Thu, Oct 10, 2019 at 7:05 PM Theodore Ts'o <theodore.tso@gmail.com> wrote:
>>
>> I've been experimenting with the ext4 kunit test case, and something that would be really helpful is if the default is to store the object files for the ARCM=um kernel and its .config file in the top-level directory .kunit.   That is, that the default for --build_dir should be .kunit.
>>
>> Why does this important?  Because  the kernel developer will want to be running unit tests as well as building kernels that can be run under whatever architecture they are normally developing for (for example, an x86 kernel that can be run using kvm; or a arm64 kernel that gets run on an Android device by using the "fastboot" command).   So that means we don't want to be overwriting the object files and .config files for building the kernel for x86 when building the kunit kernel using the um arch.   For example, for ext4, my ideal workflow might go something like this:
> 
> That's a good point.
> 
>> <hack hack hack>
>> % ./tools/testing/kunit/kunit.py  run
>> <watch to see that unit tests succeed, and since most of the object files have already been built for the kunit kernel in be stored in the .kunit directory, this will be fast, since only the modified files will need to be recompiled>
>> % kbuild
>> <this is a script that builds an x86 kernel in /build/ext4-64 that is designed to be run under either kvm or in a GCE VM; since the kunit object files are stored in /build/ext4-kunit, the pre-existing files when building for x86_64 haven't been disturbed, so this build is fast as well>
>> % kvm-xfstests smoke
>> <this will run xfstests using the kernel plucked from /build/ext-64, using kvm>
>>
>> The point is when I'm developing an ext4 feature, or reviewing and merging ext4 commits, I need to be able to maintain separate build trees and separate config files for ARCH=um as well as ARCH=x86_64, and if the ARCH=um are stored in the kernel sources, then building with O=... doesn't work:
>>
>> <tytso@lambda> {/usr/projects/linux/kunit}   (kunit)
>> 1084% make O=/build/test-dir
>> make[1]: Entering directory '/build/test-dir'
>> ***
>> *** The source tree is not clean, please run 'make mrproper'
>> *** in /usr/projects/linux/kunit
>> ***
> 
> Should we maybe drop `--build_dir` in favor of `O`?

Yes, preferably be consistent with the rest of the kernel makefiles.

>> One of the other reasons why it would be good to use --build_dir by default is that way, building with a separate O= build directory is regularly tested.   Right now, "kunit.py --build_dir=" seems to be broken.
> 
> Good point.
> 
>> % ./tools/testing/kunit/kunit.py run --build_dir=/build/ext4-kunit
>> Generating .config ...
>> [22:04:12] Building KUnit Kernel ...
>> /usr/projects/linux/kunit/arch/x86/um/user-offsets.c:20:10: fatal error: asm/syscalls_64.h: No such file or directory
>>    20 | #include <asm/syscalls_64.h>
>>       |          ^~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>>
>> (This appears to be an ARCH=um bug, not a kunit bug, though.)
> 
> Yeah, I encountered this before. Some file is not getting properly
> cleaned up by `make mrproper`. It works if you do `git clean -fdx` (I
> know that's not a real solution for most people). Nevertheless, it
> sounds like we need to sit down and actually solve this problem since
> it is affecting users now.
> 
> I think you make a compelling argument. Anyone else have any thoughts on this?
> 


-- 
~Randy
