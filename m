Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB7D9C2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 23:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437362AbfJPVEr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 17:04:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41730 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437357AbfJPVEr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 17:04:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7so153330pfh.8
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5DXDICv1BrxMLav/y/sfl9xCxyyzw1drlgwbHD31nnY=;
        b=FWkoFloQxqdaQka3gkSOdU2FjYC82UVpcLvBPA+LhkTGD2zoh1EqJ/NJcg/VuM9xMw
         LQPtwTu+DqbdtcrjLCaLgAIgngoW3vpTVInKU4Me3dquBIDQVLnrR1YVrcsQWXKT5X+O
         ikZFC1UaNa2r2IIfJ+3essGQck5FXh05KI35c0sB3QbhKUv6vvAgjQBSWzi3zeYMKf95
         zm5enTgoOz1Zvs20nQiB1aR9xElr4/PVPH8CKY5o5xJxFcb+l0LUquBzHNbJguy0Raqa
         V0ycfJlE3eTprsS9bV7plvSkSZ7suja7XE+xfhYJlAYp08QaF2I5SH3ANkzK/cNFui+N
         AMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5DXDICv1BrxMLav/y/sfl9xCxyyzw1drlgwbHD31nnY=;
        b=PUGgYQAstc5fyotkJaZfMJaJJ+s/qs2sTY+mzwwGSWfZyJyUyXmcBCzkFL7bEL9qxB
         zFG1wrVnhzHe2J+dNq0GwmFLm8PkqIv2+9zlfprtPyxCS8W4/f9fEm7DgcMmsOrxfN4h
         yGKskArIoUnCNJ3SnFx6zOGCkpaEnYkjGfV5iJXe8Eln48mvSb+iOaeBhJgXDcB81qK2
         uPdUGC1+qoFwJ2Ld1+zO/RNLAXhprAxsUsa6fO3ePM+3inVlI3HFpkFAJjUEwZkMqmx5
         FxjCo5l/1GqCX/LeqU2zEGv04ZZh7st+IeVQ2IYS1OXo4nxJnFq2hkMEggit6Hgd0byC
         Hvog==
X-Gm-Message-State: APjAAAXlk6K0WGD+RCn3I1wvbuR6ohyzgYO+/Q1MsW44t5KujdagoILC
        RFOo8Wg/Vf86EjqXIAfeXV47LNraaF7WIU0DpixA2A==
X-Google-Smtp-Source: APXvYqyiqxKyVbkEVFmDCthHWZQr49t/vJ4HZGux1rVCJ7ndOOvolG1P3fk1rEx5g5l1l+wu/M/J8MojP//24p2Kwrk=
X-Received: by 2002:a63:5516:: with SMTP id j22mr136267pgb.201.1571259886189;
 Wed, 16 Oct 2019 14:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <c99604e5-2ea4-4075-9a39-470104298368@googlegroups.com>
 <CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com> <291f012c-0ffd-599e-0dac-a6b4e05ebb97@infradead.org>
In-Reply-To: <291f012c-0ffd-599e-0dac-a6b4e05ebb97@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 16 Oct 2019 14:04:35 -0700
Message-ID: <CAFd5g455KciviPA50cVDxK8XMB8ufcLrRq9DPA0d=f-1qXezWg@mail.gmail.com>
Subject: Re: kunit.py should default to --build_dir=.kunit
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Theodore Ts'o" <theodore.tso@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 11, 2019 at 7:56 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/11/19 4:19 AM, Brendan Higgins wrote:
> > +open list:KERNEL SELFTEST FRAMEWORK In case anyone in kselftest has
> > any thoughts.
> >
> > On Thu, Oct 10, 2019 at 7:05 PM Theodore Ts'o <theodore.tso@gmail.com> =
wrote:
> >>
> >> I've been experimenting with the ext4 kunit test case, and something t=
hat would be really helpful is if the default is to store the object files =
for the ARCM=3Dum kernel and its .config file in the top-level directory .k=
unit.   That is, that the default for --build_dir should be .kunit.
> >>
> >> Why does this important?  Because  the kernel developer will want to b=
e running unit tests as well as building kernels that can be run under what=
ever architecture they are normally developing for (for example, an x86 ker=
nel that can be run using kvm; or a arm64 kernel that gets run on an Androi=
d device by using the "fastboot" command).   So that means we don't want to=
 be overwriting the object files and .config files for building the kernel =
for x86 when building the kunit kernel using the um arch.   For example, fo=
r ext4, my ideal workflow might go something like this:
> >
> > That's a good point.
> >
> >> <hack hack hack>
> >> % ./tools/testing/kunit/kunit.py  run
> >> <watch to see that unit tests succeed, and since most of the object fi=
les have already been built for the kunit kernel in be stored in the .kunit=
 directory, this will be fast, since only the modified files will need to b=
e recompiled>
> >> % kbuild
> >> <this is a script that builds an x86 kernel in /build/ext4-64 that is =
designed to be run under either kvm or in a GCE VM; since the kunit object =
files are stored in /build/ext4-kunit, the pre-existing files when building=
 for x86_64 haven't been disturbed, so this build is fast as well>
> >> % kvm-xfstests smoke
> >> <this will run xfstests using the kernel plucked from /build/ext-64, u=
sing kvm>
> >>
> >> The point is when I'm developing an ext4 feature, or reviewing and mer=
ging ext4 commits, I need to be able to maintain separate build trees and s=
eparate config files for ARCH=3Dum as well as ARCH=3Dx86_64, and if the ARC=
H=3Dum are stored in the kernel sources, then building with O=3D... doesn't=
 work:
> >>
> >> <tytso@lambda> {/usr/projects/linux/kunit}   (kunit)
> >> 1084% make O=3D/build/test-dir
> >> make[1]: Entering directory '/build/test-dir'
> >> ***
> >> *** The source tree is not clean, please run 'make mrproper'
> >> *** in /usr/projects/linux/kunit
> >> ***
> >
> > Should we maybe drop `--build_dir` in favor of `O`?
>
> Yes, preferably be consistent with the rest of the kernel makefiles.

Alright, probably a good idea to make this change fairly soon then
before we have to worry about backwards compatibility and such.
