Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3CBEBA201
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2019 13:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfIVL0B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Sep 2019 07:26:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55940 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfIVL0B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Sep 2019 07:26:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so6759126wma.5;
        Sun, 22 Sep 2019 04:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hI/6ZrFUtuVVe3JujYBRlhWLKvB3/VNdoJv8xZNq3C4=;
        b=TTG6ArSidhY9sojTMa+qjmlEeVu87EXujKjiwnOmrgvzD+7nBcnhwwxpp5FfApw0M5
         N46BFiYQvtsuMvkBXfgdHipDwHWY094rLvsmGguaakMjJbFhGp3F8p50ClTXc/862mUs
         AnWfYOqcR3cnNaqwJ1CjPgd22I3Qs996rewSnmmfsiSQz51J8Kht/XOVyJmhMBF1cqL9
         r7k9oFa8GY60WcII1iry1Dj+fC55l/JrWkJsLZhrl9nGUlKkzi/FnPsB59ntQ74Zayzh
         S99O1tg74qFHte/ovCdG7nY1jlaCLu4QikUwyQ0PGMR2YQEuTxDLemsvrXxrDQ1YWo4p
         cBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hI/6ZrFUtuVVe3JujYBRlhWLKvB3/VNdoJv8xZNq3C4=;
        b=b8wLuDL3aSeNk8wXAErbmScaPPYSsH7qzJJTogWFhzsIOElssewbXWjPtWJxCuFYLr
         LxVosvp7UUTWV2RdQ4Rpl/xv2uvu4BCcq07hzwN6ND4Petk0y3qlWOpsHPLQNBV0OYjX
         F0c/iyV4NAyDKpQKHpvoeTu8G7ZKdeeztcvt4igRCc6wm3kQn/+Y3faCIkK+IQ7ppbLg
         AFEJ/c6O9HK011M2xmxHIGOFCcXl3jykHBIgL7TpfCT+cSHWG1an2zshXvzYTEriQcio
         n/KndodrG21gQFCBU1EVlnwVGg9qAEtKKbQq7Ly+HhFoShiGWZq2gYvdaQM/Zbpf6EVC
         3YvA==
X-Gm-Message-State: APjAAAUlNlp4CBlCWPhCUohmIYgv7kpMwlImtcAOT3bi5fXA93UzNS8b
        3YigftSiDeMLsnn8LKPV8fw=
X-Google-Smtp-Source: APXvYqyMadmk+dV8RSERKdngK+3FjCtdstHO9wmgik253xpK8MW+SlzWmId6qbFUEqjLwD2d0nkG7g==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr10722850wmi.39.1569151558485;
        Sun, 22 Sep 2019 04:25:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f143sm10169316wme.40.2019.09.22.04.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 04:25:57 -0700 (PDT)
Date:   Sun, 22 Sep 2019 13:25:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
Message-ID: <20190922112555.GB122003@gmail.com>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Sorry about that. I am surprised that none of the other reviewers
> > brought this up.
> 
> I think I'm "special".
> 
> There was some other similar change a few years ago, which I
> absolutely hated because of how it broke autocomplete for me. Very few
> other people seemed to react to it.

FWIW, I am obsessively sensitive to autocomplete and overall source code 
file hieararchy and nomenclature details as well, so it's not just you.

Beyond the muscle memory aspect, nonsensical naming and inanely flat file 
hierarchies annoy kernel developers and makes it harder for newbies to 
understand the kernel source as well.

The less clutter, the more organization, the better - and there's very 
few valid technical reasons to add any new files or directories to the 
top level directory - we should probably *remove* quite a few.

For example 'firmware/' was recently moved to drivers/firmware/, and in a 
similar fashion about a third of the remaining 22 directories should 
probably be moved too:

  drwxr-xr-x    arch
  drwxr-xr-x    block
  drwxr-xr-x    certs           # move to build/certs/ dir
  drwxr-xr-x    crypto          # move to kernel/crypto/ or security/crypto/
  drwxr-xr-x    Documentation
  drwxr-xr-x    drivers
  drwxr-xr-x    fs
  drwxr-xr-x    include
  drwxr-xr-x    init
  drwxr-xr-x    ipc             # move to kernel/ipc/
  drwxr-xr-x    kernel
  drwxr-xr-x    lib
  drwxr-xr-x    LICENSES
  drwxr-xr-x    mm
  drwxr-xr-x    net
  drwxr-xr-x    samples         # move to Documentation/samples/
  drwxr-xr-x    scripts         # move to build/scripts/
  drwxr-xr-x    security
  drwxr-xr-x    sound           # move to drivers/sound/
  drwxr-xr-x    tools
  drwxr-xr-x    usr             # move to build/usr/
  drwxr-xr-x    virt            # move to the already existing drivers/virt/

  -rw-r--r--    COPYING
  -rw-r--r--    CREDITS
  -rw-r--r--    Kbuild
  -rw-r--r--    Kconfig
  -rw-r--r--    MAINTAINERS
  -rw-r--r--    Makefile
  -rw-r--r--    README

There's a few borderline ones:

 - 'block' could in principle move to drivers/block/core/ but it's fine 
   at the top level too I think.

 - 'init' could in principle be moved to kernel/init/ - but it's not 
   wrong at the top level either.

The remaining top level hierarchy would look pretty sweet and short:

  drwxr-xr-x    arch
  drwxr-xr-x    block
  drwxr-xr-x    build             # new
  drwxr-xr-x    Documentation
  drwxr-xr-x    drivers
  drwxr-xr-x    fs
  drwxr-xr-x    include
  drwxr-xr-x    init
  drwxr-xr-x    kernel
  drwxr-xr-x    lib
  drwxr-xr-x    LICENSES
  drwxr-xr-x    mm
  drwxr-xr-x    net
  drwxr-xr-x    security
  drwxr-xr-x    tools

  -rw-r--r--    COPYING
  -rw-r--r--    CREDITS
  -rw-r--r--    Kbuild
  -rw-r--r--    Kconfig
  -rw-r--r--    MAINTAINERS
  -rw-r--r--    Makefile
  -rw-r--r--    README

I'm volunteering to do this (in a scripted, repeatable, reviewable, 
tweakable and "easy to execute in a quiet moment" fashion), although
I also expect you to balk at the churn. :-)

Thanks,

	Ingo
