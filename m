Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40B223490A
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jul 2020 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgGaQPK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jul 2020 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgGaQPJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jul 2020 12:15:09 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9216EC061574
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jul 2020 09:15:09 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ed14so14370476qvb.2
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jul 2020 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3d01Lmun8Mhs3FkTX0Od32vSs3Xvk7kXc2qFlp3wiUg=;
        b=QAPjzBXkNWldUvi1YrspeozuNR/f3rc8UlT6mt4uMq0QEn01P+wmztAlxGa6yYQUQ5
         nB/dqGphJjqy/jfbUpB/YwYurg7h7bGGW+4It1AmNy5pfCJgTkQLx369UiQbuXSiTAGE
         1Rdn7nbhxpkzwJgGD5WkNOoC8WqjhJGwT/9y9LTa+5P+QO7tTwtQef4hKiDDmKzBxvWA
         1dF/A1BrQtaHvOpM9GREJ0qZfdgDlqFQ64yGetdXGfgjhHQBCJCtznWM8rQ6C7iWWPBL
         9fjiBXfygQ1/WdUL8jSEA0qSUtH9TQ1rKtENxbM5mFXugMSispxiTkU7jv3/sAB7RxwS
         ABoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3d01Lmun8Mhs3FkTX0Od32vSs3Xvk7kXc2qFlp3wiUg=;
        b=j/1R5mZeGIsk/H4msXq0mh+h1iL5uPaaEoViaEqP53ZdXWPCI3JcsC756oeCa3dOwZ
         +lH/TgHZvfcIHSo96vie0Z/M4CdWb0G4u+uRc/io6nwvtqjRBIofGjDyuIl7GQOIWGX0
         tU8dcyIp8907fI0Fb2EjRlqW1pyGu0cSV8xw/sy4VgisoaZis7yMZAMzLdFCkzy1hzet
         PKopjCxYZ4Q8yuA2wdzdJQX5vwNVGELO4+Stdgj5Vp5ijfV/YlMWVx4ZCxqiIdyTgsql
         y12k4saIk6MH510Y8JkS1pYGE4IVEc4MVtv3d0oa0wmKInbuUpN1Ys8ctlF2bOElSm71
         tnMw==
X-Gm-Message-State: AOAM531UvfCxQCjY05Kj0ChTajzZuSx3Hq2NENwBiGj6o8STz6zBmnAo
        YC5q64aUoxQTBLcz2ndsWkSSaOOkzFq5dB7dUTrVnIvvVxnP/g==
X-Google-Smtp-Source: ABdhPJx/Vs5MD1g4yuquxDXYaN0xWQoZ2JpAeK0MwDeFRjYiOEyOXF1wYuLTBmPzgMVk4/0HdAaBmB6/lp3WRgQFIic=
X-Received: by 2002:a0c:9c03:: with SMTP id v3mr4920686qve.34.1596212108421;
 Fri, 31 Jul 2020 09:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <7heep067yt.fsf@baylibre.com>
In-Reply-To: <7heep067yt.fsf@baylibre.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 31 Jul 2020 18:14:56 +0200
Message-ID: <CACT4Y+Z9wsS_m4humVcx-4CAbD2rvUxRHCVfgUYTWXVVzreXOA@mail.gmail.com>
Subject: Re: CFP open for testing/fuzzing microconference at LPC
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     automated-testing@yoctoproject.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 24, 2020 at 9:14 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Hello Linux testing enthusiasts,
>
> The CFP is open for the testing/fuzzing microconference[1] at Linux
> plumbers conference.
>
> Please submit your ideas for discussion topics usin the LPC CFP tool:
>
>    https://www.linuxplumbersconf.org/event/7/abstracts/
>
> Click "Submit new Proposal" at the bottom of the page.
>
> There are some suggested topics in the MC announcement[1], but feel
> free to submit ideas that are not on that list.
>
> And yes, LPC will be virtual this year as announced on the LPC blog:
> https://www.linuxplumbersconf.org/blog/2020/linux-plumbers-conference-2020-goes-virtual/
>
> The tools and logistics are being actively worked on, so stay tuned to
> the LPC blog for all the details.
>
> Thanks,
>
> Kevin
>
> [1] From: https://www.linuxplumbersconf.org/event/7/page/80-accepted-microconferences#tf-cr
>
> The Testing and Fuzzing microconference focuses on advancing the current
> state of testing and validation of the Linux Kernel, with a focus on
> encouraging and facilitating collaboration between testing projects.
>
> Suggested Topics:
>
>     Next steps for KernelCI (data formats, dashboards, etc)
>     Structured data feeds for cross-project collaboration
>     Integration with kernel.org tools (e.g. b4)
>     Continued defragmentation of testing infrastructure
>     Better sanitizers: KASAN improvements, KCSAN fallout, future plans.
>     Better hardware testing, hardware sanitizers: how the USB fallout was handled, are there efforts to poke at something besides USB?
>     Improving real-time testing: is there any testing for real time at all?
>
> MC leads
>
>     Sasha Levin <sashal@kernel.org>
>     Kevin Hilman <khilman@kernel.org>

Hi Kevin,

What is the deadline? I almost prepared a proposal, just want to make
sure I won't miss the deadline by a day :)

I see some other MCs have "CFP Ends:", but not Testing MC:
https://www.linuxplumbersconf.org/event/7/page/80-accepted-microconferences#tf-cr

Also what are the options for duration? Can I ask for a particular
duration in the proposal comments?
