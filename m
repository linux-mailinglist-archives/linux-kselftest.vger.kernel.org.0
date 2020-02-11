Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CF515991D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 19:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgBKSsb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 13:48:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37708 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgBKSsa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 13:48:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so4622862plz.4
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 10:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CU1W+ehrAiS3jw2NJvVJpdaUBPu6nkbnRDzhgkpWwa0=;
        b=dlqQhCmuU8Uioh1M8bOeS+GLp9N1MbISkwrAfoMmSuChZxiDVR397U7J+9XD3riMI2
         8V6PLYYK4JZ/5qhJF2R/sfHyPLuErPmjTkqKN44uiSfNvd8WJMpVvAMpZDHQTMYyQ+Fx
         lgS31IAh+J0IdJPNMYcvqtyOV2jkqRWOlMfJMwyyHc0E+IfbWg9MMgUR/8nWFxOb6z0+
         bshcTHAfb3KR6uEGGp8sca69Kve7JaCeJ9Rr/J41Rk0BYi0/QshjvfXwyQuEqMR40uIi
         g81JgSc+2rBNpyRq7x6Xo0DAhHfu8HZIoXxxX29qDSnjXyFGDTPkvmpuNV+Q1TBBPU4C
         TleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CU1W+ehrAiS3jw2NJvVJpdaUBPu6nkbnRDzhgkpWwa0=;
        b=Bs0C9wErbV+J9F/B4p5Jw4IpAI3Fwwalx7Ohz/vgDukJtqPl6S26RxgKxKlvamXTFM
         xtQXgggsrnz7IBCCcMxXKRQMnbsqfnTSLLmxk5UzqfoWWK6BQtmshRhuFFH5vf7oZdJF
         yTlyqrx1/aaVJgcmGsg1JIXesUzqF+xxs/9eYoEW+4SUR7rmu8SjtqEKj48qj4KfR+2l
         2zeMvM1V9E/QHA38eMaKNOuqUm0/IsoQRH0Dfw5v1fBWiWA0j8JP4fOb9IKt2k70g3ir
         SnPoTw9wITk+iH69SzIpTviTzlSViNt/mfbAM4b5K8Q68OW64I06ytAmITHxEYGkOxdB
         p/9w==
X-Gm-Message-State: APjAAAWXFRfXGEY9WOLL0yabu/XqtJw6fxQ9ToMJPlZe2T0GDLsxbpo0
        h+j9+cyhrcz5D2rKHfIxkZ7ouWaUDJTRQQrvHv4lvg==
X-Google-Smtp-Source: APXvYqzCtifK++9lU+veDLagxYT88pdnTXDwtsRsjuJox3lr45kptA7x3tmjR8V6/ceymntHN46hg1A0VktNhSWpNEg=
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr5191369pjn.117.1581446909986;
 Tue, 11 Feb 2020 10:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20200211002551.147187-1-heidifahim@google.com>
 <CAFd5g47LFvRxHMJ+XHcw2dFe2xU+1GmDnXsm=STvCFAT74rm7g@mail.gmail.com> <MWHPR13MB08959C9951D826A9D0B19BCFFD180@MWHPR13MB0895.namprd13.prod.outlook.com>
In-Reply-To: <MWHPR13MB08959C9951D826A9D0B19BCFFD180@MWHPR13MB0895.namprd13.prod.outlook.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Feb 2020 10:48:19 -0800
Message-ID: <CAFd5g44E=OFaMun7Y4FaOrjGewZybjgC54hBzMrBeLi51g7Nag@mail.gmail.com>
Subject: Re: [PATCH] kunit: run kunit_tool from any directory
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Heidi Fahim <heidifahim@google.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 11, 2020 at 10:26 AM Bird, Tim <Tim.Bird@sony.com> wrote:
> > -----Original Message-----
> > From: Brendan Higgins
> > Sent: Monday, February 10, 2020 5:32 PM
> > To: Heidi Fahim <heidifahim@google.com>; David Gow <davidgow@google.com>; Daniel Latypov <dlatypov@google.com>
> > Cc: open list:KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>; KUnit Development <kunit-dev@googlegroups.com>; Linux
> > Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] kunit: run kunit_tool from any directory
> >
> > On Mon, Feb 10, 2020 at 4:26 PM Heidi Fahim <heidifahim@google.com> wrote:
> > >
> > > Implemented small fix so that the script changes work directories to the
> > > linux directory where kunit.py is run. This enables the user to run
> > > kunit from any working directory. Originally considered using
> > > os.path.join but this is more error prone as we would have to find all
> > > file path usages and modify them accordingly. Using os.chdir ensures
> > > that the entire script is run within /linux.
> > >
> > > Signed-off-by: Heidi Fahim <heidifahim@google.com>
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
> Sorry - I'm not a current kunit user, but does this mean that the
> kernel source has to be present in order to run the unit tests?
> That's problematical for embedded systems.  Maybe that's outside
> the scope of what unit tests were envisioned for?

No worries.

It is already the case that the kunit_tool assumes you have the
source. It's purpose is to build tests, run them, and collect results.
We are working on separating these functions, but right now given that
the script assumes it will build the kernel for you, it is necessarily
the case that you have source.

You can, nevertheless, build and run KUnit tests without the use of
our scripts, which should work for most applications.
