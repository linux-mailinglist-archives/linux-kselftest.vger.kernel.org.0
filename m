Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD1C96D0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2019 04:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfJCCrw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 22:47:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45550 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfJCCrw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 22:47:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so903808ljb.12
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2019 19:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pN0um+kQSs9flJznbqYPiNwCThq7sqsv6/WwbAw4wo4=;
        b=h4ATNZYKw7PwNNqG3nr4vohB1AmTAIAIy2xiiP8xP6+kXrPICl1hAGWYquQvckEELv
         klDkW+KeI8y0kCaxrM38c2wUlQwg3V14BrMpDoK+tcEcunvR1dF0PaXKSF1kcZyZx8h6
         E41kLUF8P0bLTkimMTdYgZF+vLUaNvTx+SY4gQmYjTM6Pz411c9ZA1CLbckUqxEItrJU
         uSl8WxeJlo8/A4lg6LlSmFrqUuhbTOaCt9r/vPzfI2ULgUPEbeyJKScqULA181Hy8q6Q
         tSZi/tJLSRtNx5feMJ8kCz40RxmSsKgEyiB6IOtz4CAqkGY4IBDIDQ+GRTEzXqmZeuTr
         MQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pN0um+kQSs9flJznbqYPiNwCThq7sqsv6/WwbAw4wo4=;
        b=pyizm/GE40TPI39ZqzUmU0cjf98j4V9housxnX/zI2NgydpazKJicGq9I3sLFe2MAx
         iePll10r2JYl4ecGkh7HEQw33TOl7hIRPW9gHxyupDgGBALh3p5o0p3tz22kGqZKvc13
         0WPhWwmv+FQgOXEcdjh+kg202MqVayu9OJF1JI9Qe0YTV/vRuvgEUCSiZo7zG3y0kkBm
         vFhbziAAHXI/m59XvIjUn+e7IvCynSjO/y/U8n1UEu3IzmkOfZxHlcvx9noWbZiSzfpu
         s+cc1AWXaW7vWLJKk5PP7eEw4JqL5vzLfso2hT9YGLho9vMZzOCL9nSXg04sk0CE9U/Q
         m94g==
X-Gm-Message-State: APjAAAUT/juWSc2hqqGQQ3+xaHrehqEXtgki6oiqaD9/Mxt14sT/Yu38
        X1YdThrnYIc5Hq/nwD6/LnG0bpTrB1Y6bS+fTfwsYQ==
X-Google-Smtp-Source: APXvYqzBmAcLMUf52wfvCXWS7QcJ9ibAblcUgy0hiIu9SLf9sB4ZMG1TVebM5tx14n53yjkONyCWNA3x7/MqhC1I78s=
X-Received: by 2002:a2e:8889:: with SMTP id k9mr1916898lji.252.1570070868795;
 Wed, 02 Oct 2019 19:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <1018171707.4561.1570021237760.JavaMail.javamailuser@localhost>
 <09618fd2-eb41-5a82-3fb4-4f4ca18bd075@kernel.org> <CAEUSe7_+RQ9UPjJW1TzFwfCpcFuOv9ha7k_Lf46RJTg-=gVf_Q@mail.gmail.com>
In-Reply-To: <CAEUSe7_+RQ9UPjJW1TzFwfCpcFuOv9ha7k_Lf46RJTg-=gVf_Q@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 3 Oct 2019 04:47:37 +0200
Message-ID: <CADYN=9LeWLqQ4cYAQ=Fk-xD_O4UxPN+GSwgqyB3UH3j=xH0KLA@mail.gmail.com>
Subject: Re: next-20191002 kselftest results
To:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc:     shuah <shuah@kernel.org>, lkft-triage@lists.linaro.org,
        Dan Rue <dan.rue@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 3 Oct 2019 at 04:15, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wrot=
e:
>
> Hello!
>
> On Wed, 2 Oct 2019 at 20:52, shuah <shuah@kernel.org> wrote:
> >
> > On 10/2/19 7:00 AM, ci_notify@linaro.org wrote:
> > > Summary
> > > ---------------------------------------------------------------------=
---
> > > kernel: 5.4.0-rc1
> > > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
> > > git branch: master
> > > git commit: a32db7e1172439240202b843642465618498170d
> > > git describe: next-20191002
> > > Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/=
next-20191002
> > >
> > > Regressions (compared to build next-20191001)
> >
> > This report is nice for quick glance of test pass/fail/skip dashboard.
> > I am finding very difficult to figure out why the test failed.
> >
> > Can you please save the test run logs and stash them for access?
>
> Logs are saved. You can click on the test details:
>   https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191002
> then opening "kselftests" in Test Results, choosing an environment
> (say "x86_64"), and then (here's the tricky one) "job_url":
>   https://lkft.validation.linaro.org/scheduler/job/948404

If you want to download the log and do grep locally you can find that
under "Related downloads" the button "Log file" that will download the
complete log also.

Cheers,
Anders
[1] https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191002/te=
strun/948404/

> Running kselftests starts in line 1276 in that particular log.
>
> Hope that sheds some light on that.
>
> Greetings!
>
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org
