Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6F207F0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 00:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbgFXWBx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 18:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388217AbgFXWBx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 18:01:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C699C061573;
        Wed, 24 Jun 2020 15:01:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so3470872qkc.6;
        Wed, 24 Jun 2020 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+dO/ioQWt3T8AvV5aff/AMizNQQLCT7fqnhXdAkqk4=;
        b=rsOmUdmbDN2ygjsqhsIUfmvhPSs5PSzlm9vAGODNW3uLXepvp7iQP8EhB8q5M3pj30
         AJWGMa4bS0MjpMr5B+BpTDFZSHIbAacMKW1YZqO2P7TSMZ3FwyraqL/c7yEPNktOng4y
         IPtDaUtJ14IYswX2hzjFnvYxAk6Bp1Do+h+AMkqazS+BQmEdKa5A4iRmlUcQuP3pq8WS
         yaZpl32xlKxhQkhdJI39JXdlqgZ86sAuTSkA0krVh9sSaLWIq7RbOCZyCWoWoLlh+bGM
         bxqpi+jTQHjLlvw3ZlwqmL4UsNk59HAnGA4PlM60pXZ4mmg4DYR1iCIPGS1ybo3wqraq
         bstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+dO/ioQWt3T8AvV5aff/AMizNQQLCT7fqnhXdAkqk4=;
        b=fSEQklHjprEPz4cm3TXQxHr+SS9SLtEcu04XElFVumhQlZrxkPsLn9NKgNSGDF3cPC
         Iz8SEZ7oN1X5KHPHTmfoqa/pauviHW7RJPygb1j3LHHsk7m2JlsqfFdFkT2Ty0vuOpEB
         9XfZpWMnHnLDy6qYVGFOilqXWcbcru11x427fEUjUEx8FEpkYI6rm/D9Zki4bb9KJpn4
         DLcigpO5opk6rqJyt8cW6sq7VNsBKwgJp201LHG8qM8ceu6C2D3+i+YVz7T6XbVZ+jsb
         VKc7Mq011eOLcu6TNsx0NgNOdWNlp6lgMX5+Z+sTErVW4JDUYgsrOeLNSBakUQsndM/v
         NFKQ==
X-Gm-Message-State: AOAM530yEI/fFHLsyy6cLK9PVd1Pgw0j7pIqwYr+KVOHAWpr7rHjAZQe
        lpa67v9BoMllE5Kvlrfb2FvdvbFJAfWovuZitDU=
X-Google-Smtp-Source: ABdhPJxVcJnRADQ8YB2nP+DfXbZqgZhpXB8HRCLWtoU1zQZhJGGsJLPJPeTgVdzTWu3TCDrWgRFrxiExvBX6NSBO5UE=
X-Received: by 2002:a37:2781:: with SMTP id n123mr27646540qkn.106.1593036112542;
 Wed, 24 Jun 2020 15:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook> <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
 <903628180.54697.1592983405305.JavaMail.zimbra@nod.at> <202006241335.2C0FB5DF90@keescook>
 <b97853f0-c4be-7039-1d4c-96b3ab802472@infradead.org>
In-Reply-To: <b97853f0-c4be-7039-1d4c-96b3ab802472@infradead.org>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 25 Jun 2020 00:01:41 +0200
Message-ID: <CAFLxGvxiyyX9s=y4phGxvWh-vonS1WPOUbRZr9mgq-B+wY+2nQ@mail.gmail.com>
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
To:     Randy Dunlap <rdunlap@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 24, 2020 at 11:29 PM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> On 6/24/20 1:36 PM, Kees Cook wrote:
> > On Wed, Jun 24, 2020 at 09:23:25AM +0200, Richard Weinberger wrote:
> >> ----- Urspr=C3=BCngliche Mail -----
> >>>>> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?
> >>>
> >>>> True that, we can rip the file.
> >>>
> >>> Has anyone fixed the uml build errors?
> >>
> >> I didn't realize that this is a super urgent issue. ;-)
> >>
> >> Kees, if you want you can carry a patch in your series, I'll ack it.
> >> Otherwise I can also do a patch and bring it via the uml tree upstream
> >> as soon more fixes queued up.
> >
> > I think the lkdtm change will tweak this bug, so I'm happy to carry the
> > patch (I just haven't had time to create and test one). Is it really
> > just as simple as removing arch/x86/um/asm/desc.h?
> >
>
> I just tried that and the build is still failing, so No, it's not that si=
mple.
>
> But thanks for offering.
>
> I'll just ignore the UML build errors for now.

This is a allyesconfig?
I just gave CONFIG_LKDTM=3Dy a try, builds fine here.

But the desc.h in uml is still in vain and can be deleted AFAICT.

--=20
Thanks,
//richard
