Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4368B1CC26
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2019 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfENPqR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 11:46:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40396 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfENPqR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 11:46:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so8828879pgl.7
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ht6pxgJxCDqu7Xno6rhiZPX8FdrXO7AhHKR0qXSh20c=;
        b=Q7ZLzRgrnJ44XxrjCUZSi7zx+AOwv7aQBuOFxC2DZsVbaemJ+M2ZaOBoVm+xzy96i+
         ZBleTsQ8GggaCI/2ky8YByajtlpbZz+tqRv6MOunZqHHNBlPo214qEWkZswKRpDc0W74
         bZM5jvV1dRlKOVa2DhXvF6xfxsWDzl/AwB5GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ht6pxgJxCDqu7Xno6rhiZPX8FdrXO7AhHKR0qXSh20c=;
        b=NW1ZAKOoC/yyZpfG1vl5UOe5+1558n2IGmuQ9Pd9VXI4n04WDL9A/d0tMepzgONMrP
         f6SpR/lnc12TnBXIkJWflsErRfJa0Zdho8aCi9inqKQkAGeFwg/QjvR3flYgtab1mALK
         sx4VfmsaorkwtMdpBn6bafsMwL1/2y/MttbjnyBfyMZHzVSsVe40lNUHY8aE1ks7nnnh
         sILmxkpC/3kUtIKtIlFaOIeanJ2bgbR3JvJuR8UiJRP7l82k5glcQUP6D+Wm4UPRGPjR
         7+pNqTSFstkbzwnRqjccSMuq0QmRRZkQ8HP0m7sVuQUKIldXavzPPUyV2uQCwnYM9OIf
         CgQA==
X-Gm-Message-State: APjAAAXVixueq6lrP37AHsbTzAOhey+boDg7ltLNGbE9W0KpSFajImNq
        8cYvLpwpjJU+wEHl0l4cblbmp9iEhVg=
X-Google-Smtp-Source: APXvYqwLjLP7RkDkndtWasLl8X6lASAL0hAKylQwaWRx1KriH+78lmS0JPO3XrgbL5Q/78s5ZQ03Gw==
X-Received: by 2002:aa7:8a11:: with SMTP id m17mr18812370pfa.122.1557848776617;
        Tue, 14 May 2019 08:46:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j10sm793908pgk.37.2019.05.14.08.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 08:46:15 -0700 (PDT)
Date:   Tue, 14 May 2019 08:46:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Dan Rue <dan.rue@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: next-20190510 kselftest results
Message-ID: <201905140843.B972AA13B6@keescook>
References: <359070592.29.1557569697898.JavaMail.jenkins@db10df53eddc>
 <201905110746.D6C85E86F6@keescook>
 <CADYN=9+nwM4Kw-PWHHDpQ5hpf=N5N8Ewy=h7Y2RTyO5Kwak88A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9+nwM4Kw-PWHHDpQ5hpf=N5N8Ewy=h7Y2RTyO5Kwak88A@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 14, 2019 at 05:28:45PM +0200, Anders Roxell wrote:
> On Sat, 11 May 2019 at 16:51, Kees Cook <keescook@chromium.org> wrote:
> > > Test Suites
> > > -----------
> > > * boot-lkft-kselftests-master-519
> >
> > What counts as a "pass" for this? I looked at the x86_64 log, and there are lots of kselftest failures, but the dashboard counts it as a "pass"?
> 
> The boot is passed when the auto-login-action in suite 'lava' is passed [1].
> 
> There's is two issues:
> 1. We had a way that changed the run_kselftest.sh file in order to
> skip tests that hanged (that results in no test output from the run)
> various boards. Since the new change to kselftest, the patch to
> run_kselftest.sh got added that breaks our way to skip the tests and
> kernel hangs.

There's a fix in -next that adds an "alarm" check now so no tests should ever hang for more than 30 seconds now:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?id=a745f7af3cbd04b9c9c9e803429e1c20775b538d

> 2. The way we parse the output doesn't match the new output format.
> 
> We will turn off the "next-* kselftest restults" until we have
> resolved this issue.

I'd prefer to keep the tests running -- they're still valuable logs to
have. I was just curious about the specific reporting. As long as the
issue is known, that's fine. No need to disable it entirely. :)

-Kees

-- 
Kees Cook
