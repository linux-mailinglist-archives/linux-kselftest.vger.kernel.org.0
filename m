Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E5443F7B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 10:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhKCJlY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhKCJlX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 05:41:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321CCC061205
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Nov 2021 02:38:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m14so7095848edd.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Nov 2021 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEyIczqFSHpavkegJTGcffG0KJRQlbVgPG2I11SEzIk=;
        b=vE8celaAZhFLiXMY3hj+ux1f4WpUOtB+IYPgxA+T3rNqveRNEQm86XNOSQ7+s9eVJn
         GELJidoE/FALVgt0sG3aOE+fD/QYwbJjtvBMP2BG/I77YXX1+zxkPFgFEjzuIi9SoMwO
         RSXHZld3YZhMd6yXkQNEk15b28o4td9KGN+hOkrjxmr4fN6kxERAFDOB8ralLISEDiFK
         Z4lpDlK9gSUHrwPDYHDoV30hbKcHE/jPhgpceG9mTT47ADu5zyKrpUs/PmasPL51k1Q/
         8Nda7xOAFirJX1iOO0xRXBrMaHaSyz/0FrkkVQsPv4JijQpkp77F7idxvjr0jZXCLle8
         O+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEyIczqFSHpavkegJTGcffG0KJRQlbVgPG2I11SEzIk=;
        b=xlpTxwnCUz4ynqdqD0drJfJxvHG6/+tqL4qtLEqiwy3evd5grRDsYWEYF6ZvIVqQro
         MkNz9gOGHmhhEhKIvsDDI7+YA7MwxKiqRspXOB0h+3IkCZnHdTuY6k78XEJBC7blUDYt
         WDALvlqNvxK2EhnwH4bh1/M1mQTQIkUXlIYxQqsPKVdJV0XRgdJk6kof1Fjzr/J2g7Zv
         vO+aD9wkmDxQm5MnjwmBoRNoiO0vbVhETyf8jq4nqI+4lOG2jfJ18a4M/H0CS/ZebDn0
         0CVjU3hNdhaY8un66Nw+M/20i0idJvyAVrFZnt2q9wdz+Ts1mXdl5iGRoTvQUd8ZMMJj
         57qA==
X-Gm-Message-State: AOAM5330hdv3mr6PlAYOKFi3TjDDTf8xBdrLgcCYDWFw26h4A1nQaWYK
        hqGuJ0RHinPbMYfOVitIkDBDg5lEo9/+p+sVwvAnSg==
X-Google-Smtp-Source: ABdhPJylvEHPgODpfxQWb3myB8GzOfRCv9ha0X5xGunFbmsG+KmnpYDbhMqV4MR+y93eMexM+Aj3CQofSDWo2t+wrHA=
X-Received: by 2002:a17:907:10cf:: with SMTP id rv15mr2446809ejb.383.1635932308691;
 Wed, 03 Nov 2021 02:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211029114312.1921603-1-anders.roxell@linaro.org>
 <834d18b6-4106-045f-0264-20e54edf47bc@linuxfoundation.org>
 <CAKwvOdk8D5=AxzSpqjvXJc4XXL8CA7O=WY-LW0mZb3eQRK_EWg@mail.gmail.com> <CADYN=9+iueC3rJ4=32OM9rOUDLLmvcKY-y_By4hwAj1+9gxRiQ@mail.gmail.com>
In-Reply-To: <CADYN=9+iueC3rJ4=32OM9rOUDLLmvcKY-y_By4hwAj1+9gxRiQ@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 3 Nov 2021 10:38:17 +0100
Message-ID: <CADYN=9+e=qLGBN+qxmKObiOp0hTQ_sGHSusn+4YvAXuprGVp2A@mail.gmail.com>
Subject: Re: [PATCH] selftests: kselftest.h: mark functions with 'noreturn'
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2 Nov 2021 at 23:04, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> On Sat, 30 Oct 2021 at 00:08, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Oct 29, 2021 at 11:19 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> > >
> > > On 10/29/21 5:43 AM, Anders Roxell wrote:
> > > > When building kselftests/capabilities the following warning shows up:
> > > >
> > > > clang -O2 -g -std=gnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o test_execve
> > > > test_execve.c:121:13: warning: variable 'have_outer_privilege' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> > > >          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
> > > >                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > test_execve.c:136:9: note: uninitialized use occurs here
> > > >          return have_outer_privilege;
> > > >                 ^~~~~~~~~~~~~~~~~~~~
> > > > test_execve.c:121:9: note: remove the 'if' if its condition is always true
> > > >          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
> > > >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > test_execve.c:94:27: note: initialize the variable 'have_outer_privilege' to silence this warning
> > > >          bool have_outer_privilege;
> > > >                                   ^
> > > >                                    = false
> > > >
> > > > Rework so all the ksft_exit_*() functions have attribue
> > > > '__attribute__((noreturn))' so the compiler knows that there wont be
> > > > any return from the function. That said, without
> > > > '__attribute__((noreturn))' the compiler warns about the above issue
> > > > since it thinks that it will get back from the ksft_exit_skip()
> > > > function, which it wont.
> > > > Cleaning up the callers that rely on ksft_exit_*() return code, since
> > > > the functions ksft_exit_*() have never returned anything.
> > > >
> > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > >
> > > Lot of changes to fix this warning. Is this necessary? I would
> > > like to explore if there is an easier and localized change that
> > > can fix the problem.
> >
> > via `man 3 exit`:
> > ```
> > The  exit() function causes normal process termination ...
> > ...
> > RETURN VALUE
> >        The exit() function does not return.
> > ```
> > so seeing `ksft_exit_pass`, `ksft_exit_fail`, `ksft_exit_fail_msg`,
> > `ksft_exit_xfail`, `ksft_exit_xpass`, and `ksft_exit_skip` all
> > unconditional call `exit` yet return an `int` looks wrong to me on
> > first glance. So on that point this patch and its resulting diffstat
> > LGTM.
>
> I'll respin the patch with these changes only.
>
> >
> > That said, there are many changes that explicitly call `ksft_exit`
> > with an expression; are those setting the correct exit code? Note that
> > ksft_exit_pass is calling exit with KSFT_PASS which is 0.  So some of
> > the negations don't look quite correct to me.  For example:
> >
> > -       return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
> > +       ksft_exit(!ksft_get_fail_cnt());
> >
> > so if ksft_get_fail_cnt() returns 0, then we were calling
> > ksft_exit_pass() which exited with 0. Now we'd be exiting with 1?
>
> oh, right, thank you for your review.
> I will drop all the 'ksft_exit()' changes, they should be fixed and go
> in as separete patches.

tools/testing/selftests/vm/memfd_secret.c has the
'ksft_exit(!ksft_get_fail_cnt())'
statement and when I looked at it it when I did this patch it looked correct.
However, when I look at it now I get a bit confused how ksft_exit() can be used
with ksft_get_fail_cnt(). @Mike can you please clarify the
'ksft_exit(!ksft_get_fail_cnt())' instance in
tools/testing/selftests/vm/memfd_secret.c.

Cheers,
Anders
