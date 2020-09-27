Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31911279D5E
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Sep 2020 03:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgI0Bxr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Sep 2020 21:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgI0Bxr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Sep 2020 21:53:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE87EC0613CE;
        Sat, 26 Sep 2020 18:53:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d13so5399421pgl.6;
        Sat, 26 Sep 2020 18:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=63gTB/opngvWQpxsqyyVmbz485xcMBG552lLah4TntY=;
        b=nf+wkl5yx8wpRiM7+3p7Kvxjbp54f85aDPU7nfrglXIbeitshFVNeHQn4xeNO1LMOI
         Xh19u6fShKUbL+djFQzBpBoNfjpOVtX0DuufNvHnvpgFJzGWR9Wle+bp1V78e6gJeEWT
         iHfXHXbL2UyVFNe+RnFxvt16HL76igfk+2LJdJ1OcYMcUsotWc3bXGOSd+Qy78lmegaK
         y7MXNWdQRGf5lPeANQ70zqcaECDpdZhf5C08GZsiMC5Be+WlwTIX1daRFLAMplUiNYJ2
         4qPmw+Una7M6l+rVovJW6eLWnr5Gi33N17okqMFHVMGBtdy2dlPvRWxJdPZePcPlLb/z
         xsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=63gTB/opngvWQpxsqyyVmbz485xcMBG552lLah4TntY=;
        b=JzNE7T7Rl5U3YfXHyy2Dzrg8uHe3Pt4I7Pj35uxoszjY6JET/ESdyXNHlyNyUzpNXL
         DwdRHOzxcELZmb2pmmTYQzfVj8R5x23AMcl0gwn4rr6HMcr73g7tqf2aHZvrk7g8wdud
         7wD+8mNDSirPSULvFgIR7QX1veHgu6+D2PBwlEwK3ZsaW6yLltZFsh7S0Hd8Hg6I/za2
         Zu7FFMWOrY16KjrNBGKuMHhec07Jq8B7EReADHA+QwUXhamsmZIXrJFQsHLyPZNEnGE6
         U88PqJgkenM6z3xFq2XWbes357EFwL2ig4RFSco80Xyomfkv5753gYxbRikSJkbfHLX1
         H5rw==
X-Gm-Message-State: AOAM533yQi5e0AJlXaGWAropgVGqZvqNCnoX/Rx4swW4TE9cu1H4DOgD
        hbqCeBuICagbDqFcN2suQfg=
X-Google-Smtp-Source: ABdhPJzeGzXSb8Xqr+qYPObX4r2M6kOGPtBlgo4hIZrbnCIeD1OGQBR8N9BX/MTdkDzxguPs2FfNGg==
X-Received: by 2002:aa7:9850:0:b029:142:2501:34f0 with SMTP id n16-20020aa798500000b0290142250134f0mr5425247pfq.73.1601171626422;
        Sat, 26 Sep 2020 18:53:46 -0700 (PDT)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b11sm6609285pfo.15.2020.09.26.18.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 18:53:45 -0700 (PDT)
Date:   Sun, 27 Sep 2020 09:53:34 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-doc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, Tim.Bird@sony.com,
        lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCHv5 kselftest next] selftests/run_kselftest.sh: make each
 test individually selectable
Message-ID: <20200927015334.GC2531@dhcp-12-153.nay.redhat.com>
References: <20200914021758.420874-1-liuhangbin@gmail.com/>
 <20200914022227.437143-1-liuhangbin@gmail.com>
 <CA+G9fYvT6Mw2BamoiVyw=wLUqD-3LB2oaDqcuabOyWfFxEN1qg@mail.gmail.com>
 <202009251414.15274C0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009251414.15274C0@keescook>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 25, 2020 at 02:16:14PM -0700, Kees Cook wrote:
> On Fri, Sep 25, 2020 at 01:51:53PM +0530, Naresh Kamboju wrote:
> > On Mon, 14 Sep 2020 at 07:53, Hangbin Liu <liuhangbin@gmail.com> wrote:
> > >
> > > Currently, after generating run_kselftest.sh, there is no way to choose
> > > which test we could run. All the tests are listed together and we have
> > > to run all every time. This patch enhanced the run_kselftest.sh to make
> > > the tests individually selectable. e.g.
> > >
> > >   $ ./run_kselftest.sh -t "bpf size timers"
> > 
> > My test run break on linux next
> > 
> > ./run_kselftest.sh: line 1331: syntax error near unexpected token `)'
> > ./run_kselftest.sh: line 1331: `-e -s | --summary )
> > logfile=$BASE_DIR/output.log; cat /dev/null > $logfile; shift ;;'
> 
> Yes, please revert this patch. The resulting script is completely
> trashed:
> 
> BASE_DIR=$(realpath $(dirname $0))
> . ./kselftest/runner.sh
> TESTS="seccomp"
> 
> run_seccomp()
> {
> -e      [ -w /dev/kmsg ] && echo "kselftest: Running tests in seccomp" >> /dev/kmsg
> -e      cd seccomp
> -en     run_many
>         \
> -ne             "seccomp_bpf"
>         \
> -ne             "seccomp_benchmark"
> 
> -e      cd $ROOT
> }

I'm really sorry to make this trouble. And I'm OK to revert the patch.
I just a little wondering how do you generate this script.
I tested with 'make -C tools/testing/selftests gen_tar FORMAT=.xz' before
post the patch and all looks good to me.

```

run_seccomp()
{
        [ -w /dev/kmsg ] && echo "kselftest: Running tests in seccomp" >> /dev/kmsg
        cd seccomp
        run_many        \
                "seccomp_bpf"   \
                "seccomp_benchmark"
        cd $ROOT
}

```

Thanks
Hangbin
