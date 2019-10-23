Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF6E1C72
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2019 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405266AbfJWNYa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Oct 2019 09:24:30 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:40957 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404607AbfJWNYa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Oct 2019 09:24:30 -0400
Received: by mail-qk1-f180.google.com with SMTP id y81so15815911qkb.7
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2019 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1I0pWUfYUgrXRcgSgVyPgnqp+oKuHpScMNhUln3N88=;
        b=YPdXmdGb3bPYgrtIISkPhTK3td1GoZV3DZmvVHmPN8TvXObYtL/COamsZvjOD0AdeM
         SaCVUdQs8615qQOS1ykocnB0s9TMh3ArIfx82IUNqlfYe4wvyzz46EgRVZvrV3pVmqBQ
         zkxUicsMa2ift64sHb/xc8TA72/aKXdJAL7FW/49gxUUVNK3/nSwghtP2liopfBzYqV0
         HZ/Typ/o3FbjXc3hHFJSNJkDJMtCLWAMPaiDQIM0yZU9GNfXLn378kpHIfzJSDcsfh2O
         yL4FraEBmLSrJ1zY69J66TKIcNwriVl6e3ZX+t6bwT6ZnSNyNnoE1/Fsj7HwUeeXxVH0
         h70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1I0pWUfYUgrXRcgSgVyPgnqp+oKuHpScMNhUln3N88=;
        b=AAWad00cFQUm84rTkM8OdocDP/XUyEnIGXUA2JrbLCGSRmnoJP0jaTpz58jxNYNGpU
         m0OkKPYfzcZSk/K1sU2iyJAQNJxTaLNemf9bn5RJKjkdgbkxiAyR6Ep7M1R8VnZiKN86
         GXqtUAPd2gprs38JGeyT3erwvDoT75Sqa0LfUrY6BPTUveEcdvUdTRXhhKXp8fMcdneq
         D/x9griyTdkjXRAa8qccCluA9faL7XWOvELe4a7rJN48ZHADKAnQcsoIMtHPkEc9YKZo
         a57BxnGILDCzUOM4vgQr8Xt6un+tJwjMuaa3hgxuNlKVLxG0PRX4kQ8oYvcNE08QUVEp
         ln9w==
X-Gm-Message-State: APjAAAXyT4VkpRLoLDP9FApLfYKlSaOe62Vd4SI2xq/SEXXxPivpbxUA
        HpQhOW9lma/A9oHpKg3dhGpxD+ycy8j+3gspmi5fJQ==
X-Google-Smtp-Source: APXvYqzhTeVXJx2TMFzjxF3vak3/WfQeQkq5QLdY1QN85PWJc1hUKLZZX0BMJR1TOB0q8IPAS2DTAoBoE2PO5V7nxYM=
X-Received: by 2002:a05:620a:16a6:: with SMTP id s6mr7591354qkj.407.1571837068783;
 Wed, 23 Oct 2019 06:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
 <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org> <226099bc-9763-3a73-e26a-b292f601494c@kernel.org>
 <20191011180248.GA24089@rei.lan> <b715f3d7-547f-9a43-dc41-2e46ec3bfd51@kernel.org>
 <20191014085414.GB31760@rei.lan> <CACT4Y+aKbgT=i8C5aZvp8ZV52PamGm=GdnR6kQecczLQOQSGqA@mail.gmail.com>
 <62903a33-8ffc-56b6-de1a-539f10b5de2a@oracle.com> <20191015134407.GA12523@rei.lan>
In-Reply-To: <20191015134407.GA12523@rei.lan>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 23 Oct 2019 15:24:17 +0200
Message-ID: <CACT4Y+azc_6aoEf4GaVFwwZgLp9QcCk3jJB-spM9s5BUB8Gxqg@mail.gmail.com>
Subject: Re: [Automated-testing] syzkaller reproducers
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 15, 2019 at 3:44 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > >> I do not think that these scripts are ever supposed to be the used in
> > >> production testing, you need much more than this to produce results
> > >> reliably. I would expect that they are supposed to be a form of very
> > >> minimal documentation.
> > > Yes, I just added them as quick hints: some repros are 32-bits; each
> > > needs a new dir; some external timeout is needed for each test.
> > Thank you again for the collection of repro C programs!
> >
> > Hitting a lot more crashes with the collection of repro C programs than
> > in all the hours of running Syzkaller. Wonder why? Any idea? This is
> > with the same kernel and VM that Syzkaller is run on.
>
> I would guess that these reproducers are product of countless hours of
> fuzzing, so it's about to be expected...


Probably. Hard to say.
If you used KCOV, KCOV_ENABLE_COMPARISONS, KASAN, LOCKDEP,
FAULT_INJECTION, all other debugging configs, compat instance and some
required image/cmdline features, then the only reason for difference
that I see is indeed longer fuzzing time.
