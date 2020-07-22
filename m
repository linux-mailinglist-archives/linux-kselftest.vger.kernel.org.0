Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FCB22A0AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGVUWK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jul 2020 16:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgGVUWK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jul 2020 16:22:10 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33F2C0619E1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 13:22:09 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a30so1663425ybj.5
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QkphWxYyazumKClniN3MUn39GFFNV/nqPhj6OvEhnM=;
        b=WxmbK4zLKLPTSwQ1E7baf6yDcVLqwcJsyAhxGJR3HqQXrPyLqw80Ilsz4CmV98R3E3
         ykXnZbm22OEkV71kwSuxesfswDStT/W7VQsHh5BYN3mqSpnl92ADXaYVTEkA50YlrJBx
         eX27OG4A5GtogpwQqq9cNK6uhUCwa7ltuuXg6YBp1Vn8HrJAevfa13SL064Y8IjVi2AV
         x4VlSbu6eFUXR0wtXKPl6ISo7KiWovLNe00yv6GKSB754nY64cFgkTIhKunjaXspBlgE
         zkMsHCKN1X0eajnW2LMh7Mq03QC9Tr/Quph6S4ULRkZF54a6Ug93P8sOt9asK5HNUTkX
         /9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QkphWxYyazumKClniN3MUn39GFFNV/nqPhj6OvEhnM=;
        b=VXM4KqsgB0g3nYehgHWtgQ4EhvoSA1bvwp7P3xuSwJ23Bixa2waK51woSuT5F5bzAS
         9GzV+DuaXaKc4hTaTozFFMXz3csrp/KA0aPuCchjrA6EPKk2BVg4SPyhkvknZUIWWvcc
         hanPpgyUTV5JihQiLB5SraRW4PiAiptqJnOYtGmsu1+yOqvR1DpXc2JQq5dFN4oX8lCE
         ssZdtk58ogUJG6zaoYgyIAwKyBk8O9nica85DgaL6byqUnSIEphI00WQ1TzUgc0ONc+p
         tXfXr89jX4FdYwHzuIdRCxJfawdlbnpj+b7TItqFP3STfUT34XYc+M5p0EwDVP02UKQj
         bMqg==
X-Gm-Message-State: AOAM530CDBXyAgJ6bXvLTqAurPpmxWQox9XdMR8UZBlWJ/ZXlm6E9dXE
        ScYfSfqy4qi9kaqL9p0XKz/0RH90xIds2I0nB+t2Tg==
X-Google-Smtp-Source: ABdhPJwzOAVu8VbvSYiVCfE5fyc/hdk3WFhsSAt26VME4J8FZBKqRr512J8/MfvNYYd0oO8b8AzGIYGc9Pk1gR6M8+c=
X-Received: by 2002:a25:bb0d:: with SMTP id z13mr1566548ybg.488.1595449329066;
 Wed, 22 Jul 2020 13:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174654.72132-1-vitor@massaru.org> <202007211207.5BAA9D8D@keescook>
 <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com>
 <202007211911.666E080@keescook> <CADQ6JjUgVXBfHfb=V2ajwm=rHi12rxiqEtpivjY03xZbp6k7wg@mail.gmail.com>
 <202007221244.4E3C9E45@keescook>
In-Reply-To: <202007221244.4E3C9E45@keescook>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 22 Jul 2020 17:21:33 -0300
Message-ID: <CADQ6JjXmXnHr9O1q3h5smVosvffFByJTtr49P7H0eT9A7+0pxg@mail.gmail.com>
Subject: Re: [PATCH v3] lib: Convert test_user_copy to KUnit test
To:     Kees Cook <keescook@chromium.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 22, 2020 at 4:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jul 22, 2020 at 03:29:27PM -0300, Vitor Massaru Iha wrote:
> > On Tue, Jul 21, 2020 at 11:12 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Jul 21, 2020 at 07:19:12PM -0300, Vitor Massaru Iha wrote:
> > > > When you talk about end-of-test summary, is it what is written in
> > > > dmesg and not the kunit-tool?
> > >
> > > Right, if I build this as a module and do "modprobe user_copy_kunit",
> > > what will show up in dmesg?
> >
> > No, It doesn't. I'll put the messages again.
>
> Would it be possible to add that behavior to the core KUnit output? Then
> all module-based tests would include a summary line?

I will check what can be done.
