Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214E21A824
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2019 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEKOvf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 May 2019 10:51:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37865 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEKOvf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 May 2019 10:51:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id g3so4785972pfi.4
        for <linux-kselftest@vger.kernel.org>; Sat, 11 May 2019 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UrrXDUi/gk4zCyFpyH/sUqkS9od81YeirKCBp09sQiM=;
        b=YzjUW3KoSuX20gVLnLnNHa5BlAUXnLPUpbvBYRR4PcPZvrEyjqUnf6To98mrQKrcAT
         I0aRhH/Wwdxp56dyfGcmfTyaD7B+SffqgnmXZHrqkg3wJ2qXRI2ct7qfec902aeFdBg5
         GG1uXyWJt7u5cYM/IAYwQjXZpFp1uBisXZEf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UrrXDUi/gk4zCyFpyH/sUqkS9od81YeirKCBp09sQiM=;
        b=Pos12IwfZNaxG1aD/PKVwUoJajE5++u2ScJWpqe4HTFapEzDE9EIJ4LPcall8/0TAg
         yr0b3X+jDVPkw58D7Vr/8cbLhKBa9/2oUOzS5WRHH3vMsCLJcq2hU9vqXtHVi99rcN6m
         0uy1BSeQp9vLj/132r0JxrS41Ac3IqM0e2rEjpf10ODKjpwKf1+v+6UyN/06Q9Vltc9t
         6nYA1G85GjIm+xj1cP4WowK8FICjlQC3rH22wYqAehBSsjmNLvP4hOIqOJr4fdkEwl1Z
         cMWhD5r3qca3EXE7cYwVupWNdQpe/rPRiROtKvU0gBSly1H7ANO4wfvmypUt2fZi6Ev+
         edxw==
X-Gm-Message-State: APjAAAXhler9f/oprlFpfVk4rHcx/xn16d13GE0n4Y+Ma+eDDe5QsUve
        MTxfyLGSgbwdQyL9nlWv3ICCTg==
X-Google-Smtp-Source: APXvYqy0QhLu6JDQzc9nFlGDfRyyfrFGNERzC9xwev8GK3TIqS+uVM3sJQPZM01Xa3zlwa2JAbqyQQ==
X-Received: by 2002:a63:7552:: with SMTP id f18mr19889095pgn.234.1557586294462;
        Sat, 11 May 2019 07:51:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k131sm2240385pfc.107.2019.05.11.07.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 May 2019 07:51:33 -0700 (PDT)
Date:   Sat, 11 May 2019 07:51:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kselftest@vger.kernel.org
Cc:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org
Subject: Re: next-20190510 kselftest results
Message-ID: <201905110746.D6C85E86F6@keescook>
References: <359070592.29.1557569697898.JavaMail.jenkins@db10df53eddc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359070592.29.1557569697898.JavaMail.jenkins@db10df53eddc>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 11, 2019 at 10:14:57AM +0000, ci_notify@linaro.org wrote:
> Summary
> ------------------------------------------------------------------------
> kernel: 5.1.0
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> git branch: master
> git commit: a802303934b3bd4df6e2fc8bf2e4ebced1c37556
> git describe: next-20190510
> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190510
> 
> Regressions (compared to build next-20190509)
> ------------------------------------------------------------------------
> No regressions                                                                                                          
>                                                                                                                        
> Fixes (compared to build next-20190509)                                                                   
> ------------------------------------------------------------------------                                               
> No fixes
> 
> In total:
> ------------------------------------------------------------------------
> Ran 12 total tests in the following environments and test suites.
> pass 11
> fail 1
> xfail 0
> skip 0
> 
> Environments
> --------------
> - dragonboard-410c - arm64
> - hi6220-hikey - arm64
> - i386
> - juno-r2 - arm64
> - qemu_arm
> - qemu_arm64
> - qemu_i386
> - qemu_x86_64
> - x15 - arm
> - x86_64
> 
> Test Suites
> -----------
> * boot-lkft-kselftests-master-519

What counts as a "pass" for this? I looked at the x86_64 log, and there are lots of kselftest failures, but the dashboard counts it as a "pass"?

$ wget https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190510/testrun/716064/log
$ grep '^ok ' log | wc -l
60
$ grep '^not ok' log | grep -iv '# SKIP' | wc -l
30
$ grep -i '^not ok.*# SKIP' log | wc -l
18

60 pass, 30 fail, 18 skip

-- 
Kees Cook
