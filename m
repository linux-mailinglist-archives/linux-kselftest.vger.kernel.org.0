Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D761B1241
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 18:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgDTQtb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 12:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTQta (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 12:49:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63197C061A0C
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Apr 2020 09:49:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d17so5354039pgo.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Apr 2020 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2yvI22+u+gf9MypeTzZela5sCiKd871YLPLu1ATUeBk=;
        b=GxgFXMK2rL0HnR0HxmuJ2hgV61hAWHC2J6x6EEfY2BMzNDUfsfr4hotTf0FRdlCPt+
         Rvepb9Hka80bMuFrumwybzQHSQy+Yv0ctg4EnJq9owlquXt/LJ65biZedGtAoak6JObw
         MuolE9od/S/Nr71GwAl+yoF0rTT2Cm/NQnXPQQWwdoIGh43ZVji4sPiQvwR1yqm9SPi3
         ZMbo9nMEBvOOKWAnXeCkyb/j8uaQUYpcJHNB3v2leaL9ZMnoHrF/32U5FPGE0dYBoAye
         NPzTO8zCOLdVQ3NdONA10/onsZWxExGCbIFUzaEUAWnQtkFk1zO/UF+N8Gp+94S2f9W/
         +3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yvI22+u+gf9MypeTzZela5sCiKd871YLPLu1ATUeBk=;
        b=p459AWG40DTrvDLmE/Q0ihi2B2OgtOuH4+uezsez0hylWqRr4Yi0k/wlFTyy7F2ozF
         RdmEDtf2ZITVyqUWgTfP1WmiZ2bj8Bxgu+S5iXEs0AqZMjC3f70pZgwiNh4xmmQJJ31h
         LCqc1wZ82br/WiQXCbhIaAB5iKm5v+jsUKCrpGqKF2gCnXEn44mTRkF6/LGQUHc761JD
         h3k+WQzuUv9xeQKNH7NtrX0KyE8PGGCuQF8L6HIL3QInpTVioiRZnp2q8v3p0GajJ7Ox
         kZndGwYFjNpJwU1R/KiPR3AVdOakzalcQo17f2SKoibqUeUHoK7om4nZShUQFNoYh2IW
         w/yg==
X-Gm-Message-State: AGi0Pub/IX6+KZHAmP4f/x9MLWbXAbGd76eaHApJJmMWEPF8JXB1EZaP
        7207xf/s+s4r9j7feR1DJLYKT4E2kO5t1AvdstX72w==
X-Google-Smtp-Source: APiQypJAptSKDPqDUjCokIUFPP2sEcqLJFp/eeN8JZNdVnqASMauA0erPS1uMYEJXo5BV/Q9vv53Z7IwabW/O9TPK60=
X-Received: by 2002:a63:1007:: with SMTP id f7mr15364892pgl.384.1587401369605;
 Mon, 20 Apr 2020 09:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200415201653.106-1-l.rubusch@gmail.com>
In-Reply-To: <20200415201653.106-1-l.rubusch@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 20 Apr 2020 09:49:18 -0700
Message-ID: <CAFd5g47tOo2fQCc4GSFAist9b3pef0C6fYiV9bOf=sdfgAyd8g@mail.gmail.com>
Subject: Re: [PATCH v5] Documentation: test.h - fix warnings
To:     Lothar Rubusch <l.rubusch@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 15, 2020 at 1:18 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> Fix warnings at 'make htmldocs', and formatting issues in the resulting
> documentation.
>
> - test.h: Fix annotation in kernel-doc parameter description.
>
> - Documentation/*.rst: Fixing formatting issues, and a duplicate label
>   issue due to usage of sphinx.ext.autosectionlabel and identical labels
>   within one document (sphinx warning)
>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

FYI: I already gave you a Reviewed-by. In the future, please add
Reviewed-bys you get to any follow-up patches. (You don't have to do
anything if you get a Reviewed-by and don't have to send follow-up
revisions.)

Let me know if you have any questions about how this works.

> ---
> v2: Several documentation fixes
>
> v3: Do not touch API documentation index
>
> v4: Replace macro argument in test.h by named variadic argument
>
> v5: Patch format fixed
>
> NB: checkpatch.pl will complain about flow control statements (i.e. usage
>     of "return") within the macro kunit_test_suites(suites_list...).

Yeah, it's a "bad code smell", but not necessarily always wrong, so
right now we don't have anything better than to just always warn and
sometimes ignore.

> Better?

Looks good to me!

> I feel I'm making you a lot of extra work. I'm really sorry for
> all this fuzz!

No worries. Our documentation/on-boarding processes are at best not
very good and at worst non-existent, so this is pretty much just par
for the course.

Thanks for sticking with this! I know getting up to speed on upstream
Linux kernel development can be painful and tedious. I have been there
myself, and I still make lots of silly mistakes. :-)

Sorry, if I ever seemed impatient: I am not annoyed. I respond to
dozens of emails everyday, so I can sometimes get rather terse as a
result of trying to be expedient. I hope you understand!

Trust me, once you go to a Linux conference and you meet some devs,
you will find that in person, most of us are super nice people, even
the ones who can *seem* mean and frustrated on the list.

Thanks for the patch! Hope to see you around in the community!
