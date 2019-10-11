Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1CFD3E31
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfJKLTt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 07:19:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39822 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJKLTt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 07:19:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so5916066pff.6
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2019 04:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0ljULyIMp5Dm2RbiLSJ5YpQ+1SlP+EDqs8VnjvFtPbs=;
        b=SBukcD6G/E4Q++e2MZyOopU4xjNmSBLIyw2OjHpHEArm5yavHfcNQMcy3hp1jluvT4
         pn2E1VFZ01pACE++91eD6JY72tto6e+WxedlsanzH8AklUqB/3sr2lQn8wdyPTZKlcWX
         dbbd2t3v4vZYcmALClOA3exUTHL0Iw8lNRNsCNuesZkxRfL/U22AngssU5rBVBGSOudG
         BenLYRW4LtdSmaJQN3IyO38RPqNZ6nkaPcIma0B+ppZBMXcbUJAuWkgVL5V4oggQGKJh
         rOr48xytLkVF/U1/V1iBDpiotUPGzuPGHnTbjrv9VcWJF9FLcP+fTLUfIDCwcrbFzXd/
         XiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ljULyIMp5Dm2RbiLSJ5YpQ+1SlP+EDqs8VnjvFtPbs=;
        b=i2jvg1wg6LLlNLRxaTNekhU8DWsrcyf6TBSrAgfjWFjohs8nhcoP265sUW3XWCg4y3
         TV3aeIxPL7Z4nBqMEuF2M5HUKUc7luDTlnJqax2pjG9e5YqLYckHI0fC5Vi9YlMEEVTj
         +IRQK0M4Buufb5ecDpKc6FE9q6JAbajzpTIDcJdFfOOW6ObBoiLSJ2Ea7OFt2nNXDBFN
         9tgJiWyB1WkizzOykgQRkNUoXiiw2G0Ia2taX/3CyVjV0xRFyi2BUgoCxM8/86r/qIdt
         U/d8G8RsKRUTtzgLTbEbErnZo+TwrocnzPCRVLGZ5MXBH/6uwQVjTLkLDiKEiVv/dWU1
         a0rw==
X-Gm-Message-State: APjAAAVzzZZpuy71aHXmmRRb0XSCF2ZoQ3Hi+7a5NGjJCNlH56BxqcnV
        an5slDyyCwXaaA+ur6sI0CJZmtpU9wEviq11IWWEqg==
X-Google-Smtp-Source: APXvYqxcSK91sAbjydy8izO3KdbH6dlPRpO+hbZFf3Yur0zrcqyASWP1dCZqgyrB4WUpHZP16rqu7e0PrcNPMh+RL1s=
X-Received: by 2002:a17:90a:f495:: with SMTP id bx21mr16324796pjb.84.1570792788221;
 Fri, 11 Oct 2019 04:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <c99604e5-2ea4-4075-9a39-470104298368@googlegroups.com>
In-Reply-To: <c99604e5-2ea4-4075-9a39-470104298368@googlegroups.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 11 Oct 2019 04:19:37 -0700
Message-ID: <CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com>
Subject: Re: kunit.py should default to --build_dir=.kunit
To:     "Theodore Ts'o" <theodore.tso@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+open list:KERNEL SELFTEST FRAMEWORK In case anyone in kselftest has
any thoughts.

On Thu, Oct 10, 2019 at 7:05 PM Theodore Ts'o <theodore.tso@gmail.com> wrot=
e:
>
> I've been experimenting with the ext4 kunit test case, and something that=
 would be really helpful is if the default is to store the object files for=
 the ARCM=3Dum kernel and its .config file in the top-level directory .kuni=
t.   That is, that the default for --build_dir should be .kunit.
>
> Why does this important?  Because  the kernel developer will want to be r=
unning unit tests as well as building kernels that can be run under whateve=
r architecture they are normally developing for (for example, an x86 kernel=
 that can be run using kvm; or a arm64 kernel that gets run on an Android d=
evice by using the "fastboot" command).   So that means we don't want to be=
 overwriting the object files and .config files for building the kernel for=
 x86 when building the kunit kernel using the um arch.   For example, for e=
xt4, my ideal workflow might go something like this:

That's a good point.

> <hack hack hack>
> % ./tools/testing/kunit/kunit.py  run
> <watch to see that unit tests succeed, and since most of the object files=
 have already been built for the kunit kernel in be stored in the .kunit di=
rectory, this will be fast, since only the modified files will need to be r=
ecompiled>
> % kbuild
> <this is a script that builds an x86 kernel in /build/ext4-64 that is des=
igned to be run under either kvm or in a GCE VM; since the kunit object fil=
es are stored in /build/ext4-kunit, the pre-existing files when building fo=
r x86_64 haven't been disturbed, so this build is fast as well>
> % kvm-xfstests smoke
> <this will run xfstests using the kernel plucked from /build/ext-64, usin=
g kvm>
>
> The point is when I'm developing an ext4 feature, or reviewing and mergin=
g ext4 commits, I need to be able to maintain separate build trees and sepa=
rate config files for ARCH=3Dum as well as ARCH=3Dx86_64, and if the ARCH=
=3Dum are stored in the kernel sources, then building with O=3D... doesn't =
work:
>
> <tytso@lambda> {/usr/projects/linux/kunit}   (kunit)
> 1084% make O=3D/build/test-dir
> make[1]: Entering directory '/build/test-dir'
> ***
> *** The source tree is not clean, please run 'make mrproper'
> *** in /usr/projects/linux/kunit
> ***

Should we maybe drop `--build_dir` in favor of `O`?

> One of the other reasons why it would be good to use --build_dir by defau=
lt is that way, building with a separate O=3D build directory is regularly =
tested.   Right now, "kunit.py --build_dir=3D" seems to be broken.

Good point.

> % ./tools/testing/kunit/kunit.py run --build_dir=3D/build/ext4-kunit
> Generating .config ...
> [22:04:12] Building KUnit Kernel ...
> /usr/projects/linux/kunit/arch/x86/um/user-offsets.c:20:10: fatal error: =
asm/syscalls_64.h: No such file or directory
>    20 | #include <asm/syscalls_64.h>
>       |          ^~~~~~~~~~~~~~~~~~~
> compilation terminated.
>
> (This appears to be an ARCH=3Dum bug, not a kunit bug, though.)

Yeah, I encountered this before. Some file is not getting properly
cleaned up by `make mrproper`. It works if you do `git clean -fdx` (I
know that's not a real solution for most people). Nevertheless, it
sounds like we need to sit down and actually solve this problem since
it is affecting users now.

I think you make a compelling argument. Anyone else have any thoughts on th=
is?
