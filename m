Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493ED49242A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 11:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbiARK5M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 05:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiARK5L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 05:57:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE64C061574;
        Tue, 18 Jan 2022 02:57:11 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q25so77638572edb.2;
        Tue, 18 Jan 2022 02:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/+Rln8yIeY2uKlTugrdAq1LQtFz1C8SbxruWoDiWt8=;
        b=GdltdvYWpABQWF7iC433i9pHg5GIRb7ksm5UoXnhYQgMrg+rtMXyICAXwoK/dHYCdH
         5hN5+yDPhfjmSteuFvD5RyPs7Xwymxt923uFTYNQNp9ACvCbV6RaYn98pIOOH0JcHLET
         29lj3IBT67extlSzPrH1bS+AWg1ddisr8NvUdxRJxCtM5KNe/mfCrTFuO0uCuS4eiDAS
         DBw0alRHMoMiJrLeQhCrOI3c/ShYg+Tk+Tv84DjTvRzK8Y6ZzJrjjmn/KGNk+gH/13Ba
         F67n2cKZgEbU1vbe/+wK7MEHeyIYIGh0GcrTL3DWRLD/LHzKzVgtn2rta7MlbBUgR+Ge
         oV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/+Rln8yIeY2uKlTugrdAq1LQtFz1C8SbxruWoDiWt8=;
        b=SuQ6jsmt9Fz8QDkhYgNBWwSNv77VhBjssJEhsf53g7BlmDwAIbACOqzaNi7eu6VfPN
         AyXzTBO8nPyFEJILywYR+1iwLn1DJtQOn2mE4a0X2bZwGNgN+1c5x1ozv8UBGxgA3n2o
         U9Zjb/rHpptjHKIFRuhpwAz+liGdIH4A/EntXp/dSonicvgaOxclDOdx0wFT1re3oK5a
         6fJc0SIoVKbywXSEnwsm+0HaR734JECCOmoRDakzG6BCIl02rBTuBGq/Gem5T4q6P8ym
         6PBH59IQ44vo1Tp2bxTRvkpxyJ31DHDvkvMzl7yjmcacuuAcxLuTWBl918N38wzoGoSE
         T9qQ==
X-Gm-Message-State: AOAM533oMLwEyPLW5yS7ofkR8FU94mWQg1RieYdFOC34OVPOaZl97hOR
        lahxxa+0LXAYFdxIVcM+MqSNhvrtYtdL0GydEj434eU4kCw=
X-Google-Smtp-Source: ABdhPJxFWa1fIhr9NflphOlvPjj1hEt8/v2QIGbyuQbqzz04sN8Ptqt+EN74NOeeXYQKEl6VS3ChBCpU+TqOFHIXJ3U=
X-Received: by 2002:a17:906:99c3:: with SMTP id s3mr20830140ejn.486.1642503429968;
 Tue, 18 Jan 2022 02:57:09 -0800 (PST)
MIME-Version: 1.0
References: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
 <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com> <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
In-Reply-To: <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 18 Jan 2022 18:56:58 +0800
Message-ID: <CAABZP2zY_+pJHYL70YyTK2-K=LbB20Uvw1Y-C-zHT4nR1NUUFQ@mail.gmail.com>
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other failures
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Paul

On Tue, Jan 18, 2022 at 3:56 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Zhouyi,
>
>
> Thank you for your quick response.
You are very welcome ;-)
>
>
> Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
>
> > I have studied the rcu torture test recently. I am also interested in
> > this topic.
> > But I can't open
> > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.out.txt
> > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.txt
>
> Sorry, about that. I should have checked those. I had put them into a
> directory:
>
> [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/allmodconf-Make.out.txt
> [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/rcutorture-log.txt
I can open these URLs now, thank you, I will try my best to analyze
the logs in the coming days.
>
> I am going to try to test your suggestions at the end of the day.
Thanks a lot, looking forward to your test results.

>
>
> Kind regards,
>
> Paul
Cheers
Zhouyi
