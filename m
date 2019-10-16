Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E659D9C24
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 23:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403935AbfJPVDF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 17:03:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42830 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfJPVDE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 17:03:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id f14so9892924pgi.9
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vpZ4Oc090+KnujFeuCFJ+cKpyfxb6wOtJjAoHIu3NnY=;
        b=MS/rC9k4L8rrosbVj04PWfX01V3ALSoquW3vdv4n3vFWUMirInVMrEtTt1ALLkJBKX
         mPn9R1yD5S8MeC2BqzdwAEF8Zy+DXn9X2PVcsDV4g8H0H8OC6eEfdQmzPdKv2CDAKuFo
         esSRFxWoq7+X+p2pFoSndUX4OewT1CzkJydddSAjGuqCKOu75lk8p7eepXGvOnSFwrij
         02dVKSWoeQ/hDuzzoCkYXExsQn+OKWVsFIurKzpEMghVNEy3LF2rzzhi9fObleAMzolP
         ntry7V6AGAcmseeFVvKHnsY/VKqOEGWbHhuG/UeuFnFaXh/y1VEFKidRlH0IA4jtSWns
         +moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vpZ4Oc090+KnujFeuCFJ+cKpyfxb6wOtJjAoHIu3NnY=;
        b=g5ac8Bgjo5mFMxrSEijxo2pz16sPPBglCz6NSquegrRQQ1p45YolC5ytuhpOVXEOvi
         qm4kz7aE1kCUd1wEX/5tFRQR45L4da6ZXF/6AHtopaOnJOj72EFnD2k7x9Kx//sBg48c
         Q3/uPnI22czXkGwxAMMMD0HeJ0YhIDEydzIPtv3jiwucZ7hHp7zpTLtm4BgyEJaKSzWy
         LsEuh1xf8PC9tFVjTjPNh0nFKrwZQwGvMskRp3CIXXwxWjraTTr3QqTkSKnhL8lwvnZn
         lZrvylEvkWYgx9mDdPRbemgbGILUNZMbOUen9xPhS2SoTWaytsB+SbTls4SWPlHu7kyW
         HpDQ==
X-Gm-Message-State: APjAAAWlul5EeFIRrnMn326jxv28xxIfJrhydXz3E92KYEzihZ1Dg9mQ
        LGjn9wCBjRIpXIpRFX7Fn7F86IZZHZMbxNmVOsC0Dg==
X-Google-Smtp-Source: APXvYqxfiyKp/rDmduMg+1DhJNYcQf9st5xOkzTkbbQOoWJX7h9oiwwYKaKPU/SkzN2uY8iZrLw/Q/uOhott38n8+NM=
X-Received: by 2002:aa7:8ece:: with SMTP id b14mr47363437pfr.113.1571259783360;
 Wed, 16 Oct 2019 14:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <c99604e5-2ea4-4075-9a39-470104298368@googlegroups.com>
 <CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com> <551223d0-7712-41df-90f2-3ca3da301435@googlegroups.com>
In-Reply-To: <551223d0-7712-41df-90f2-3ca3da301435@googlegroups.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 16 Oct 2019 14:02:52 -0700
Message-ID: <CAFd5g44EE3A3kXOFQD5vMOXZoJ_PzD=h9dac+KJmgxeXUycJGQ@mail.gmail.com>
Subject: Re: kunit.py should default to --build_dir=.kunit
To:     "Theodore Ts'o" <theodore.tso@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah <shuah@kernel.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sorry for the delayed reply. I was on vacation.

On Fri, Oct 11, 2019 at 5:16 AM Theodore Ts'o <theodore.tso@gmail.com> wrot=
e:
>
>
>
> On Friday, October 11, 2019 at 7:19:49 AM UTC-4, Brendan Higgins wrote:
>>
>>
>> Should we maybe drop `--build_dir` in favor of `O`?
>
>
> How about if "make kunit" results in "./tools/testing/kunit/kunit.py run =
--build_dir=3D/.kunit --allconfig"
>
> ... where --allconfig automatically creates kunitconfig but in includes a=
ll of the CONFIG options which depends on CONFIG_KUNIT, so that all unit te=
sts are run?    That way, we make it super easy for people to run the unit =
tests.  Since most users are used using make targets, this I bet will signi=
ficantly increase the number of developers using kunit, because it will be =
super-duper convenient for them.
>
> Also, it would be nice if kunit.py first looks for kunitconfig in build_d=
ir, and then in the top-level of the kernel sources, and we put .kunit in .=
gitignore.   That will make "git status" look nice and clean.
>
> What do folks think?

Having something like --allconfig is the ultimate goal. I had been
talking to Luis and Shuah about this for some time.

I think the best way to make this work would be for kunit_tool to be
able to detect all the tests with CONFIG_KUNIT as you suggest (or
something like it). Luis actually already suggested it; however, we
identified that this would likely not be as easy as it sounds as it is
possible to have mutually exclusive CONFIGs. Luis pointed out that
some researchers are currently working on a sat solver for Kconfig
that we could use to potentially address this problem. Nevertheless, a
complete solution in this regard is actually somewhat difficult.

Shuah's solution was just to use CONFIG fragments in the meantime
similar to what kselftest already does. I was leaning in that
direction since kselftest already does that and we know that it works.

Shuah, Luis, does this still match what you have been thinking?
