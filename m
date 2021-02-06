Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98053119B0
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 04:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhBFDP5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 22:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhBFDMr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 22:12:47 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315F8C06174A
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 19:12:31 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id z3so2011990vsn.9
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 19:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsLsTSGcpqtzuUbk3YX89NPog3YmrVsNBJTPMwBGe2g=;
        b=XtIOXJZQ3fM6FwkYsovu1TIs3/qQqZ8j7DL5iQwBKXozfzGW7le7+1sf9c/LK8Ooaz
         70FIQ7MPpfc4r/jY2WWtIPWFwdo+Yf038f8XIocRg3S/ryVLabJzJgtOyGjHNNIa2wye
         eiKjxYOzQXmkKqybE1YXNgpZsvNbEs/RScat3A+fvZeux6BR5c6Iq9q8m1IIuTdgQtsZ
         AnOx8I8cfN8w+WKvLb3Cea1evx1345aK1h8niq+pq4VZzstx7jx0U0VPIKs9yTf2+uLY
         EUx+3FI5aykeMQ4fpmGpPXtqJFQJaCtUkn0P89l0hK5mm/jPXvR6tyGbl38HcdAhbqQX
         DyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsLsTSGcpqtzuUbk3YX89NPog3YmrVsNBJTPMwBGe2g=;
        b=PCtmj9Qhk9ZnUk4k+swM41ycyEMrhMLCVbvKF/MgkXTh8MkmXpGHr1RwmygXXmlYqI
         6hQQjuL0aGp5xRb+7B6DsTFeYh0axjT0m5BtFK8MnlPcR8UZQCGqFl8rRNo6d9V4hazu
         omTh8dj1kAgMLLlVZxkxqCYbbsU5RgZRXBw7kYEGc3p+tlt1cM7/G7SVu4/fbqmcI5/o
         wxfUMLdUwNH+fptb20/9ThHOggpRjxUKc8xESziSCgg5H16SbsIGi4TSlZtKA+MTdPla
         7ilV6l8n6Tmuc+lm20bpRaHw9I5roMKbdCful/c09X8KSTbdKramPWcsX6as1UDM8cWn
         C4Yw==
X-Gm-Message-State: AOAM5318BMKzHlLJQ3nN5AqABq0plnvi1JIkq8t9goVSbCU/TflzNC2d
        maWl77iMBE3frCW5z98h86FkJI1seyc=
X-Google-Smtp-Source: ABdhPJzNZqErgv3u8x09+xDgylWmQYA/qZHAEoixMNhqBI2XdHNrrDTd01ZcMELL73MVvV0apdBb7w==
X-Received: by 2002:a05:6102:199:: with SMTP id r25mr5710001vsq.5.1612581149892;
        Fri, 05 Feb 2021 19:12:29 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a70sm1266459vki.16.2021.02.05.19.12.28
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 19:12:28 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id i3so2808621uai.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 19:12:28 -0800 (PST)
X-Received: by 2002:a9f:2a8e:: with SMTP id z14mr5289156uai.122.1612581148246;
 Fri, 05 Feb 2021 19:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20201210231010.420298-1-willemdebruijn.kernel@gmail.com> <202012111013.46FEA48C@keescook>
In-Reply-To: <202012111013.46FEA48C@keescook>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 5 Feb 2021 22:11:52 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdVS5Q7mw-of93T3=501J-PO_eXuNzRKwFg4vUd6xUvZg@mail.gmail.com>
Message-ID: <CA+FuTSdVS5Q7mw-of93T3=501J-PO_eXuNzRKwFg4vUd6xUvZg@mail.gmail.com>
Subject: Re: [PATCH] selftests/harness: pass variant to teardown
To:     Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 11, 2020 at 1:15 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Dec 10, 2020 at 06:10:10PM -0500, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > FIXTURE_VARIANT data is passed to FIXTURE_SETUP and TEST_F as variant.
> >
> > In some cases, the variant will change the setup, such that expections
> > also change on teardown. Also pass variant to FIXTURE_TEARDOWN.
> >
> > The new FIXTURE_TEARDOWN logic is identical to that in FIXTURE_SETUP,
> > right above.
> >
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
>
> Thanks! This was on my TODO list. :)
>
> Acked-by: Kees Cook <keescook@chromium.org>

Is this patch staged to be merged as is? Should I resubmit it?

Same question for another slightly older (2020-11-23) kselftest patch:

    tools/testing: add kselftest shell helper library
    https://patchwork.kernel.org/project/linux-kselftest/patch/20201123162508.585279-1-willemdebruijn.kernel@gmail.com/

Thanks,

  Willem
