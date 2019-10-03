Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4819EC96A4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2019 04:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfJCCP6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 22:15:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47056 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfJCCP6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 22:15:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id d1so852065ljl.13
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2019 19:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XPJw67qkd12M/fpxa6MM7i/QvppDSThKPkOUHHPDQnc=;
        b=LOQjlPX98sHCwL2yTPq/Ox/FjQSsvg4kmKrjbsLTUdGgoTcMH1iLLeVWmVfOB9UbEp
         HEyFNxwpr1vIAXDnuSiCm0hKOa4NLM86cgU8QGQAa8KIqnB3F+aMGGY2x1o/3AD6/1TA
         g78QVLSpln/puHxbjnXatEBVdvqG1ICo7YN17D3YRAE7X3XdsN9JQCTQNAi59T372YPO
         ILosIZvAQVk3+qWom+dk/fDZ6PiWzIim+LpGLaF1ie7dcbBZvcOPVF6k5XYiYlUaoofr
         jJKRronbeXQmIpcsfkyqeZxAu3p0u5mDt9djIcGyvmU1irVh4zQV72vZfHoqbVAd8m/Z
         Iv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XPJw67qkd12M/fpxa6MM7i/QvppDSThKPkOUHHPDQnc=;
        b=VAnIDlsRKh5lrKGCTXQK49WWL/3+a1hylfTyyLBI3bKiq+G7puk8xwkaH+68TjAb3p
         JOBRPtnT/NU5ckKd4SUoPy4TzX5Ygqud0cbH1vkQ3q0Nd2TrYvWW+WL8AkrDq1fobOVF
         0CVZCf41yQY/byh81InavRAx/aPjJawSgSD+gxwVVRzcz0PprpbZ3Xi3+C05+2Z2vAki
         JlchX3EkS1fvj1TCN1gB2ozauSOnHMoAuNGpdheiFm4jIUu5T2knqSNZmdIMIFIWDLU9
         NFgytnoZxsWHKIM35HITlMKkYDE2mqrhkDs3tri2SL7xTdimiPZiGJulCWEShVIs7qYy
         VFAw==
X-Gm-Message-State: APjAAAX0xVoIREJjcUQbw6WdcAfes9pNTEV+bPr+a9GX5t8U7RRy9rG/
        dIWz3MnYIWNIrfLWMKjWhudeu/SX2mVGM+Btn5Kp2Q==
X-Google-Smtp-Source: APXvYqxgxoDGdvw2tS6Ag+JiS/ckcaLNi7fyP+LDWPHW6SCqvwbPOSeQtyBAXRm/VJNL73JLiVYDAG6vvNIcpenaUZ4=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr708953ljj.129.1570068956987;
 Wed, 02 Oct 2019 19:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <1018171707.4561.1570021237760.JavaMail.javamailuser@localhost> <09618fd2-eb41-5a82-3fb4-4f4ca18bd075@kernel.org>
In-Reply-To: <09618fd2-eb41-5a82-3fb4-4f4ca18bd075@kernel.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 2 Oct 2019 21:15:45 -0500
Message-ID: <CAEUSe7_+RQ9UPjJW1TzFwfCpcFuOv9ha7k_Lf46RJTg-=gVf_Q@mail.gmail.com>
Subject: Re: next-20191002 kselftest results
To:     shuah <shuah@kernel.org>
Cc:     lkft-triage@lists.linaro.org, Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello!

On Wed, 2 Oct 2019 at 20:52, shuah <shuah@kernel.org> wrote:
>
> On 10/2/19 7:00 AM, ci_notify@linaro.org wrote:
> > Summary
> > -----------------------------------------------------------------------=
-
> > kernel: 5.4.0-rc1
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git
> > git branch: master
> > git commit: a32db7e1172439240202b843642465618498170d
> > git describe: next-20191002
> > Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/ne=
xt-20191002
> >
> > Regressions (compared to build next-20191001)
>
> This report is nice for quick glance of test pass/fail/skip dashboard.
> I am finding very difficult to figure out why the test failed.
>
> Can you please save the test run logs and stash them for access?

Logs are saved. You can click on the test details:
  https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191002
then opening "kselftests" in Test Results, choosing an environment
(say "x86_64"), and then (here's the tricky one) "job_url":
  https://lkft.validation.linaro.org/scheduler/job/948404
Running kselftests starts in line 1276 in that particular log.

Hope that sheds some light on that.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
