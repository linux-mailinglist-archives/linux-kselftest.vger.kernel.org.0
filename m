Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4961DEC2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgEVPiy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 11:38:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35457 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730591AbgEVPiy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 11:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590161933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76FoYd4vHwWJfp5NSdgXYMXT/svq3UBSXuFpWv4febA=;
        b=BCiL07iCxrkUfIdss+mI66H/pkRaOlumOeDPgejaH9oTUvl/WerwBbc2mvyWx1K6AymC8U
        Ju8zs3W8VFxh/60ObObzams/ho8YudTl2zbnDLj71VY7KbF7HWYpjHRXXzu6uxoLGjExc7
        D3PGvlxG32gmGAJFSMKxXam5G1MpJAQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-9oNpRm5xOgy6ppX07LFA3A-1; Fri, 22 May 2020 11:38:49 -0400
X-MC-Unique: 9oNpRm5xOgy6ppX07LFA3A-1
Received: by mail-oo1-f71.google.com with SMTP id x10so5490445ooq.5
        for <linux-kselftest@vger.kernel.org>; Fri, 22 May 2020 08:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76FoYd4vHwWJfp5NSdgXYMXT/svq3UBSXuFpWv4febA=;
        b=kos2uOlgdMzTfxf60JMiITzUNOrunHuB+Ec6WkFRsdGJYj9iAABH+8UKsZFW5ys+3g
         rNYZFqjdAhI9PqeTl2xysB0a0ihosj3J6W469MTIVK/jrXPsuYmdhQxc0kPPgJP8Qwq9
         rys3cbFV1uNeUzd/eTNdFTwSoDCIUgex397vdokndtCVakR4eRyZAsQX7KOeIc8E2XYx
         wDZ1+rKSNsse28oes/RRYpBf/Tjy7EBp30P70p4gRxwMeGkaXXckBwo1wqbSihEHlhFg
         QHwpjPJIVGEOrA1RtSu9XrKFmycJ+a1wwkeMN3gmk+ZGe8/UJe+6lO7oSgKmfwT+3SaS
         sckQ==
X-Gm-Message-State: AOAM531PCrs5BAUNDidCiKl9kOr5BR1eg8vUb23PyO0cRggRw+uVxOVL
        59OSN6kDs0FpQe6OFdoNibrqismatHpRLs6sSHwlI54a012BP8JU2+cEJtFyeoPIRNvTrnYfsjQ
        E6fmhw82orCMlLzP3gErsxBTqgcApWi7Y31qQmggSWi5M
X-Received: by 2002:aca:fc0e:: with SMTP id a14mr2819906oii.12.1590161928744;
        Fri, 22 May 2020 08:38:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwplnAypNt3q8AxSu1Z6dOXu0aYfLGnk8C7KF6d7Ab9BGArnW5SHUQ0dGfe6u0HgeKQPB8Pha5nmIPoPHuEOe4=
X-Received: by 2002:aca:fc0e:: with SMTP id a14mr2819896oii.12.1590161928553;
 Fri, 22 May 2020 08:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
 <689fe06a-c781-e6ed-0544-8023c86fc21a@kernel.org> <xunyblmknfmy.fsf@redhat.com>
 <4e0d1e4e-9ed2-025c-1164-fd52a88c1ed2@kernel.org>
In-Reply-To: <4e0d1e4e-9ed2-025c-1164-fd52a88c1ed2@kernel.org>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Fri, 22 May 2020 18:38:32 +0300
Message-ID: <CANoWswmZmHo=ha65u=D8XWD7u9decs6FqubPjVu2YOvm6bz-nA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] selftests: lib.mk improvements
To:     shuah <shuah@kernel.org>
Cc:     bpf@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Shuah!

On Fri, May 22, 2020 at 6:09 PM shuah <shuah@kernel.org> wrote:
>
> On 5/19/20 8:49 AM, Yauheni Kaliuta wrote:
> > Hi, shuah!
> >
> >>>>>> On Tue, 19 May 2020 07:59:16 -0600, shuah   wrote:
> >
> >   > On 5/15/20 6:00 AM, Yauheni Kaliuta wrote:
> >   >>
> >   >> Yauheni Kaliuta (3):
> >   >> selftests: do not use .ONESHELL
> >   >> selftests: fix condition in run_tests
> >   >> selftests: simplify run_tests
> >   >>
> >   >> tools/testing/selftests/lib.mk | 19 ++++++-------------
> >   >> 1 file changed, 6 insertions(+), 13 deletions(-)
> >   >>
> >
> >   > Quick note that, I will pull these in for 5.8-rc1.
>
> Patches look okay to me, however, just noticed, this series hasn't
> been cc'ed to linux-kselftest. Hence it didn't go through the
> necessary reviews.
>
> Please run get_maintainers and resend the series to everybody the
> script suggests.
>

Sorry for that. Should I resend to the ML?


-- 
WBR, Yauheni

