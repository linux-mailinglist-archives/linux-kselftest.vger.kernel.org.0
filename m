Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE4D229F43
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 20:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgGVSaE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jul 2020 14:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGVSaE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jul 2020 14:30:04 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7EAC0619DC
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 11:30:04 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id x9so1508641ybd.4
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4e/KF48f9JUg5sygJxwMfUiq+YIbJ7Nlc7LSKPnv3rI=;
        b=elNYwD1e4l5A1KsSeru0ittmsBZcP9Qvxdm6i1W2vAadzRzceSIF8GOqVbab64YGjI
         xla+wgOFhaQAak7QezviTywlZwEDOs3EXob3DAeRjPBLlU/sRfiK0NJkdC02HnGu3cmm
         9Tza53NoK+Rx72dBOeEZt1gA3coJhMDCGjdVwsJMp35icIDjL/wLEA4XVM/l3n55IkYS
         LYiOBfmW64KojOHqjG6zVHTj5OVcDb9Q0fpMkzzJQon9sjivSRMjJguIdTyhBEQqBFMl
         I8ZkXOoRyc93D0lDVv7Jvo31XOVIfoCPP9bzu+FUgajm3oMoxsvj+snvVne/3F1M2nu0
         gj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4e/KF48f9JUg5sygJxwMfUiq+YIbJ7Nlc7LSKPnv3rI=;
        b=GcU4IR9TUGfRqkC/5ruzc75DjI50hs3YJ3eigfzzogA/WYtXJuQq9FePBFh6GPBSnw
         rRUk/K4vNfAn3DncNGTgXjfarg6M6gMqU9KalkaqWfz3Yf6ZzbHaF2xEJ8ns4pK0CkRM
         4OUVLYQoIlKTtgLN7G7x4m2fM/LWSmb/W0jLzToVN0jgSCw+nhZt6G1CqG75dm4fGgUn
         rilC+8L1L2wWCoujHy/nQAhxTuQ7oS6+LjA8EYsD9rKWcsh7Ubjms0E4YK43hEhzodAh
         AcnZlRZfSf0ybc+2A0qJsYFmOgtytMFlncQQmQHSyF5xlTtUX4+dHGALjPgbE+hH6VVv
         8unQ==
X-Gm-Message-State: AOAM533Xoyg5b6TJlOyme3D2OFIRlWucF3k0v7azOrKKmAmCqlhrZg9s
        pICA8wdHTetFGuN6iz0RuKj1+Cb4QO+u4CxFlNzPCA==
X-Google-Smtp-Source: ABdhPJy+ZrG8SAw6xEmL/PrEzWg/CRqYaJT9N71mtGNjeBynwVo4OjeQbE9HHYEo9y47LHFPFKU+nTWaSv5a+5HPYl0=
X-Received: by 2002:a25:4e45:: with SMTP id c66mr925374ybb.333.1595442603378;
 Wed, 22 Jul 2020 11:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174654.72132-1-vitor@massaru.org> <202007211207.5BAA9D8D@keescook>
 <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com> <202007211911.666E080@keescook>
In-Reply-To: <202007211911.666E080@keescook>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 22 Jul 2020 15:29:27 -0300
Message-ID: <CADQ6JjUgVXBfHfb=V2ajwm=rHi12rxiqEtpivjY03xZbp6k7wg@mail.gmail.com>
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

On Tue, Jul 21, 2020 at 11:12 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jul 21, 2020 at 07:19:12PM -0300, Vitor Massaru Iha wrote:
> > When you talk about end-of-test summary, is it what is written in
> > dmesg and not the kunit-tool?
>
> Right, if I build this as a module and do "modprobe user_copy_kunit",
> what will show up in dmesg?

No, It doesn't. I'll put the messages again.
