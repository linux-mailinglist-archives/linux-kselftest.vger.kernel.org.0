Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3CB9708
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2019 20:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406297AbfITSPG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Sep 2019 14:15:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41275 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405222AbfITSPF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Sep 2019 14:15:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id f5so7960050ljg.8
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2019 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zt1SAAFEs8ODGQeBze+y3jkP3GGDWb6CUJZJ+mep9IQ=;
        b=BsWbLr4w/0GDvh9Ak8RFLIst3kS16o2QLFg9WZj4E50GhmHASYFPC7ui83Iczmw1Ri
         jYHP2sgVjW0qSCtVtqmf3H1cJVLPDAG+fC7X0/HxU15K1OFCjiu+JyzQZfy/KKGn1mHN
         dFhnS0YTcemB+7Lffoo7831CoRVoUMp47IEP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zt1SAAFEs8ODGQeBze+y3jkP3GGDWb6CUJZJ+mep9IQ=;
        b=hVNU+aUrHuDCznRtB4lBQEBhXi8vcwsWK7szZxO4sxmD/dEoniO1nRGmDncrLyX1vF
         0gCvMNFeNuIYxcIzssVYZ2eqdhSktz4+Uj4xFiBgla6iMJAYARxw/fFzPTJATcz97HCb
         PYSiOjZVQxtgku+/FSO2beI4haj+BY6G3Ak4OteItVdG600rmpqDmZ+DB1ozFx7GniOY
         qUBbLf1GEvLz+iKNRouHPdl2IVPO0eCipXiumsu0iMbjsEbhKeCqeIUjc+UIDyI68HLH
         fFnACQVQSj/8wSxWLeNp4RPHmnqJvIVseYcYvPpzS3b7eBRB7p4Gw2Xl+Ea760aGa4xr
         +DmA==
X-Gm-Message-State: APjAAAV/LkjTzFHCMZ/7hXtCbV0eHxU2p7mva0VvSw0DUFjVY+WrU3iG
        PQl8R/8FK0mxIHPvu+XQsBJ8zfLGHFM=
X-Google-Smtp-Source: APXvYqzll1BhqxCGcs7UGNap9U+fsNURWrTwAlcd5oLAJbucYbAVl6Lzrb0NSn4E88qtFOzs1RWZRA==
X-Received: by 2002:a2e:9a83:: with SMTP id p3mr1776850lji.136.1569003303322;
        Fri, 20 Sep 2019 11:15:03 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o5sm636836lfn.42.2019.09.20.11.15.02
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 11:15:02 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id w6so5691235lfl.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2019 11:15:02 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr9438094lfe.79.1569003302026;
 Fri, 20 Sep 2019 11:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com> <CAFd5g46b1S5TZYGMP4F2f3Xhb1HrYTUFBOEK5gXuMBFEkzhZ3A@mail.gmail.com>
In-Reply-To: <CAFd5g46b1S5TZYGMP4F2f3Xhb1HrYTUFBOEK5gXuMBFEkzhZ3A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 11:14:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whr5K4ZH2K9pj=PZNWbiHfuz4noorjJa746_FOxLAgfxw@mail.gmail.com>
Message-ID: <CAHk-=whr5K4ZH2K9pj=PZNWbiHfuz4noorjJa746_FOxLAgfxw@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 20, 2019 at 11:03 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Fair enough. On that note, are you okay with the `include/kunit/`
> directory, or do you want me to move it to `include/linux/kunit`?

"include/kunit" should work just fine for me. At least I didn't react
to it immediately when I had done my test-pull, and it doesn't change
any auto-completion patterns for me either.

[ We already have two 'k' names under include, but even if that wasn't
true, I don't type those names anyway so I wouldn't have had
muscle-memory for those two directories in the first place.

  Under include, it's "linux" (and to a smaller extent "asm-generic")
that I autocomplete. ]

            Linus
