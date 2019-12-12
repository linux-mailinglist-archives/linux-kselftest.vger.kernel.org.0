Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2614911C30D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 03:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLLCMt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 21:12:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33401 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfLLCMt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 21:12:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id 21so430340ljr.0;
        Wed, 11 Dec 2019 18:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjKmmGGr7I3bsVNJKL/MxiBjYqhZ6jr8Q64gi26fwIo=;
        b=Pgm7k7+8rcTU4r4nhE+uDFkUt/ZfwVcD12TahrGqBNOH5eEmSn8PR4UBye4oscgPgo
         9R2SoKez8rU10trp+OrKrfgmh1buPD85G/fzawNqQFqwxybb6m11WDq+1lsh7QRmt+5s
         tVqEZdP/SbaLYsZxxjWbUOr1V4i+7ULo9yTpdc7RblvzyDhWIKmnyNuBfBaxmZjuDYRH
         lPStXJOcFZolOrUN7TOJnapCtf1Go7NR5cOtD9YR7wC7A995pXQwh9xhyG9hJoO5Cw0A
         GFNYRvYpP6glqv75ITaGjca0jDAWJU2WWtBHUTTuXQAdBlnVldHp3Ye3qKpy2eAGgw8s
         jSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjKmmGGr7I3bsVNJKL/MxiBjYqhZ6jr8Q64gi26fwIo=;
        b=Lrt9aDQAUEAi3eG8sQMi/99DsgPZd/XVbdiwrJArBdT+IefnfXqqpUi7cAKtNgW0or
         yIDvEfFJb5YMB85II4e+kCpKcKlUNUbZ76uwGYHP0+PZIw4IEm8iVxeNbyrNx4GB0Exi
         /5UH0Wib/Hsnqo4BX9/FjkEy9OcAiF8t3OkI3KIUhODSg0VFHOHFk//OVj4dMWopPybT
         qPPGfQ6llgAQTAEl2f1GnxT/6RZzJbOjvGFdYWneUnmjNWgWVbzja8gysP8RsI347tCc
         fGbPmtg11gvE+n6iz970MMKaNo3ZKJbQAvyREZa4Jqxauuwb/049pmFcggpdyPoJw0Zy
         4BVw==
X-Gm-Message-State: APjAAAXnxVRo0MnbvtX0qoNWh3bgZZbjkkcpbuKS6JGsjLvve6WORizw
        GV003INkaBDfyRhmkaF0A+e2KZTmEAVX0CT6XDM=
X-Google-Smtp-Source: APXvYqwnVnMEcO2L0aq3+e/XrVxcjJi+EM9wQHdAG97WqFaRKIj/dPQSuFGOyBqLbmoUl7OlVvHnx/n4pHceTKzRz+0=
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr4162594ljm.53.1576116766664;
 Wed, 11 Dec 2019 18:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20191211163310.4788-1-sj38.park@gmail.com> <3dab421e-6aa5-90e4-791e-53482f5c1fe8@kernel.org>
 <CAEjAshqjjVgtf_JxNvi3WOvkrjOp_-YjK=rY7GE0Mt40Y1EMqQ@mail.gmail.com>
 <CAFd5g4649_C0tSy3W-KzN05Y8K5zZtGUGVYFA9iAKvaXsPentw@mail.gmail.com> <CAFd5g46X4P7dfJWVw9hdvhVupanuZU-_KWGzostRy_e1Z=P1Og@mail.gmail.com>
In-Reply-To: <CAFd5g46X4P7dfJWVw9hdvhVupanuZU-_KWGzostRy_e1Z=P1Og@mail.gmail.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Thu, 12 Dec 2019 03:12:19 +0100
Message-ID: <CAEjAshpxvhL_h9tVDy9fX7ocs=cc1ihtqE5L39RhJh9CDD8bpw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Fix nits in the kunit
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>, SeongJae Park <sjpark@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 12, 2019 at 3:06 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Dec 11, 2019 at 9:45 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Wed, Dec 11, 2019 at 9:40 AM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > > On Wed, Dec 11, 2019 at 6:22 PM shuah <shuah@kernel.org> wrote:
> > > >
> > > > On 12/11/19 9:33 AM, SeongJae Park wrote:
> > > > > May I ask some comments?
>
> SeongJae,
>
> I reviewed and tested all your patches. Everything looks good to me
> with one minor caveat: I tried applying your patches on
> kselftest/fixes[1] and got the following error:
>
> error: patch failed: Documentation/dev-tools/kunit/start.rst:21
> error: Documentation/dev-tools/kunit/start.rst: patch does not apply
> Patch failed at 0005 kunit: Rename 'kunitconfig' to '.kunitconfig'
>
> I think the merge conflict is fairly straightforward, but it would
> still probably make Shuah's life easier if you rebased your patches.

Appreciate your nice response, I will rebase it and send the next version!


Thanks,
SeongJae Park

>
> Cheers!
>
> P.S. Thanks for the patch adding the test case for test the build_dir
> thing. I really appreciate that!
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes
