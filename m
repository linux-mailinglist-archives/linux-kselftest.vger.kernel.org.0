Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7DC1A2A82
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 22:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgDHUjm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 16:39:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38342 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgDHUjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 16:39:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so2961507plz.5
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Apr 2020 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWPVwHfU8jzDLk3ae09dfiN1BX23LAx3aANE7CXdLQY=;
        b=YmTT0fwy1WUEzBp9Z1goRnM/TD0Fnvto2oYgcXnayKtXrUu+GoX4IZFZLhgmDBN41r
         y4kxHBpnOpmPwqGd0K9jjeD4atEgAVqJZCWrPetVQY2tsPzAkrznrob75GMqCv6Ij/p9
         d64ZyWsoa86eSO3O6xnntJcpJEYBeXuRmh2mtak+hiNdfnB/ENhXfZedJgW/h3NL5OBS
         4W0Z4ieQVDa39l0kxJq8TARCOurZDu+aGAWmUXhPLejdzFlUIa/L0GvWoloA6DZ3gQga
         kF8yRNyPtKYVOn2Jh83WgcofolE92A1n2+VpAhEp9LGGziWOHS7B1ZkO0sSPVkLr+xFy
         FqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWPVwHfU8jzDLk3ae09dfiN1BX23LAx3aANE7CXdLQY=;
        b=GOXnnjMuM2eOOigWlZBGZy2LFPi0LoDZc4mX3mSVqMe5FqAHQzXHR2LViZbzrZZKq0
         YzUhSj+dnADi1D/+5R3DKc9VeVbBGd8EV/kETbCGTZ6bXR5lWCN2I8TlVu3uhWPxylsR
         /tu8DoynXjB7nJgK+y10J/W+GKhvhz8qgOT3l53HuUiEcJR3Iz7nc1ieMTw41CU0Qtg+
         RBSt8GnrGHwDX4GUVkLY3vmS0218nDQ6F2CkMDB/GbGIFqh60xL12VgljELlpm+euwCo
         /3HXbQFgDtIqr8E/nmbejc4JMv2Z4lpvs297dxn0/ZnxlSlW7p9vCe1keo8+WxxLGKlz
         TKJA==
X-Gm-Message-State: AGi0Pua4fRyMWoDAJEgF3aGFEc93Ox2a1igEkl66kt6ZdzHG0PYRVEgB
        oPn8EaniE6FdWWCoVCAtNHG46B4U2tozynBIflI=
X-Google-Smtp-Source: APiQypKodbyHuSNZPbpYcNJIJwIb2MFlQpNZmfSEx5v6ew2QmnH3RiTDZPNHRwJ4fS7zZMLq6CPN2MU20zhDj9j/vMM=
X-Received: by 2002:a17:90a:7302:: with SMTP id m2mr7286039pjk.7.1586378381823;
 Wed, 08 Apr 2020 13:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200406214130.21224-1-l.rubusch@gmail.com> <CAFd5g448Qz0bGkNCPR+zS-gH-T9A64L1tExgKb_-jQO3bysGOA@mail.gmail.com>
 <CAFXKEHYvE5N4go9KvBbMOaCWTT3vsb8M-G1JXTeKNsYBP0R1bg@mail.gmail.com> <CAFd5g44L7Ho1zc8cunfC_T-OGgdkTMngX8LW_Jt83WRKL2M5QA@mail.gmail.com>
In-Reply-To: <CAFd5g44L7Ho1zc8cunfC_T-OGgdkTMngX8LW_Jt83WRKL2M5QA@mail.gmail.com>
From:   Lothar Rubusch <l.rubusch@gmail.com>
Date:   Wed, 8 Apr 2020 22:39:05 +0200
Message-ID: <CAFXKEHYXvL2kw3YnsBrpcVmGvobbHpo+vGMFDwsmbvDVr4exAA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: test.h - fix warnings
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

(...)
> > > > @@ -232,7 +232,7 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
> > > >   * kunit_test_suites() - used to register one or more &struct kunit_suite
> > > >   *                      with KUnit.
> > > >   *
> > > > - * @suites: a statically allocated list of &struct kunit_suite.
> > > > + * suites - a statically allocated list of &struct kunit_suite.
> > >
> > > So, I am pretty sure you can name the variadic arguments and then that
> > > gives you a valid parameter to use with kernel doc. Can you try that
> > > out?
> > >
> > You mean the warning "Excess function parameter 'suites' description
> > in 'kunit_test_suites'"?
>
> Yep, I just tried it out locally and it should work.

Something like '@...:' should be possible, to list the variadic under
"Parameters", and display the corresponding description.

For curiosity I went through the kunit docs and fixed some formatting
issues. Great piece of work, thanks for realizing kunit!

Last but not least, going through the document, there is a chapter
"API" consisting of a single page with one link to "API".
Is this on purpose? I would suggest to take out this level of
indirection and remove the .rst file, linking API directly.

I'll send my proposals in a PATCH v2. Let me know then what you think
after that.

Best,
L
