Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52AD1566
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfJIRUV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 13:20:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42424 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbfJIRUV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 13:20:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id f16so2905032qkl.9
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2019 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSnnhTNLEpTMeSCRUg0zBNoXVEz2bdMff0d8gEofvx8=;
        b=vmLzriJea9JtbJ3dUCxkyVASD8LkH0jrbWi177DzBd5kdV9y8H0axd0j/dksuMS0VP
         5PSNx+4WkojupjVWSrAhcwaxHoKb6yIMR0bQZ+2DKpfqdGJ52AfO/S9qJ8V1nsUisIT3
         D7ulZJ3gl7z3vLGIbhKWbyuxNOO5T5igY9PLHWdXpn6LvDpjtycJmZRO6LjwgBZIpRJQ
         kkhQEIyUH8I9e+oD/F+a7ABcjfv4a/zVFwUX/yz+i8saZRp+uxP9/+QFaQXJ2VVRI9MV
         yNql574fY231m3V5WLJn7YULrr65lsjoTQCizhH/aj4V5XuQ6vPboWIg+9R+xmOlWhkr
         ziOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSnnhTNLEpTMeSCRUg0zBNoXVEz2bdMff0d8gEofvx8=;
        b=IGj6ftNT9n9zEX9wtt7Zy6T3aQOZWeOtinfNDkk21Oz+D2zTMelYLLctGwQuJYrNCp
         PkZq4vNM3kO6TomZTrbl5nt7fYKwrC9N/iMt7lrfPV4D6q2kihhvjV+3390tAY6ciOwS
         sOvWIbJaGLW6UocIOQh4Z95d00MZEU456Ehjl2GNZpdWLth0QC1g0LzHLPE2KwGKratW
         qzZfpxuwYs2kLlXbRpToEgU/d/wmo9P850djkFFNYHZQdHiCOLIA/NTQrhTOB8pzaRr0
         IENSE9PwtbF7/EH7QyuSBNYzOgdkcVYCogTGgDqEdHx38jsh9lAGiMaM2wpM/b/iWStd
         /mBQ==
X-Gm-Message-State: APjAAAWCV+XJZmvzZFVE5o5hT3/brEcmK1X71eOgcw8XFlpScP18OSkL
        Yh098ikTT1YPhGqyzSXbgXFN98/o78v3xIZ+uFlbEQ==
X-Google-Smtp-Source: APXvYqzmXSw0dnv28CaF3ixV652xYWDLQfA5sQxOV7hnijQ3mOCKQz8+cBdfYKD/8JeIR4j+EEOpdaoC7VtTNcVEvLM=
X-Received: by 2002:a37:65d0:: with SMTP id z199mr4354968qkb.407.1570641618500;
 Wed, 09 Oct 2019 10:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191009142446.6997-1-rpalethorpe@suse.com> <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
 <20191009145416.GA5014@rei.lan>
In-Reply-To: <20191009145416.GA5014@rei.lan>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Oct 2019 19:20:06 +0200
Message-ID: <CACT4Y+ZL8ocQPpwR-_8+0PdF=r3AkFZKvOR==+P0y0GF67w1Vg@mail.gmail.com>
Subject: Re: [RFC PATCH] LTP Wrapper for Syzkaller reproducers
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Richard Palethorpe <richard.palethorpe@suse.com>,
        syzkaller <syzkaller@googlegroups.com>, kernelci@groups.io,
        shuah <shuah@kernel.org>, ltp@lists.linux.it,
        George Kennedy <george.kennedy@oracle.com>,
        Cyril Hrubis <chrubis@suse.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 9, 2019 at 4:54 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > I don't have prior experience with LTP tests, but from reading the
> > code it looks reasonable to me.
> >
> > I assume that .needs_tmpdir = 1 ensures that each test runs in its own
> > new temp dir, which is later removed.
>
> Indeed, it's removed recursively by the test library.

:popcorn:

It took me several years to figure out how to more or less reliably
remove dirs after the fuzzer ;)
(no, unlink won't do ;))

> > I've stared for a while at "rem / exec_time_start < 0.98" trying to
> > understand what is that tst_timeout_remaining() returns that we want
> > to kill that process when the ratio is < 0.98... provided that we
> > convert 1 to float but not the other var. I failed to come up with the
> > answer. I have potential answers for "<0.02" and ">0.98". But I assume
> > you know what you are doing :)

Ah, I see, it's not full timeout, then it makes sense.
Probably a comment won't harm.

> The tst_timeout_remaining() returns remaining test timeout, so at test
> start it returns something close to 300 seconds, since that is a default
> for a LTP tests, so this would probably kill a process quite fast, if
> I'm reading right, after a bit more than five seconds. I guess that this
> is something intended for a quick v1 hack rather than for later use.
>
> > Re tst_res(TINFO, "Timeout; killing reproducer"). Not sure how much it
> > pollutes output on 3000 tests. If it is, it can make sense to remove
> > it. Lots of tests run forever, killing it is not something of
> > particular interest generally.
>
> I guess so.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
