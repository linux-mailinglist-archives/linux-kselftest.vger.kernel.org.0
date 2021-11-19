Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3C457262
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 17:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbhKSQK4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 11:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbhKSQKz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 11:10:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FF4C061748
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 08:07:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l25so28213569eda.11
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6J5BffBBnPWzW6VDKn7rj5am2GbMmTLCLYv70xXQS+8=;
        b=PjiU6zXPWE7V6Wkz+pySnqmQ+kWNo8w9Gx69VPCRIpjWDYl3LdRp4ye+HQf6hXYjkN
         a+wElY99oQX1pZtwRtzh5/3NAgNa3ET+uNNK+af6QD/DJD22kS8VgfJtSdu01jWxXH1o
         K1Mr6tYm0X8j3f9UOWHwH+d+XlDo4yDCuHigQvPYPvF8AIR3pPCaBxO4df4a8cLicnBB
         UCmgJafyNamln+rU+9453jJyf8tNixhuM/96MA/RfneM/GovkIEHqwxqSDslbHZuF5wB
         Zr/p8uaQpezsTspNNGBdAbyNrMqOK4A1JeU/4JhYdig9QUoM0lFUnQkdnEbryaApE7vz
         S1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6J5BffBBnPWzW6VDKn7rj5am2GbMmTLCLYv70xXQS+8=;
        b=uqVK48o3gzcBSmr+qnefir8km9bWd6R2fdKiOx6sSF0HPbV8t/hhndBQ+vOTq/O7uf
         uLIkjfIjHzhefnF3nVlEuuM3nNKfRTbPi45TeALJKVE/XsLkL3Ko7TnH3lxx/ntbvQXw
         F85RlVNoMmMVlFUQanPqsHqzhybjRspR/g+z+ho2Atsg3KvHbcJd0LH17q20nb0bA2DK
         GCWIVSYuV3RIx61KrTG8fK3cF5PdSSCXNUU2bB78k0YS+y/WWH11We/X9mM1+lhfJTUW
         /BD9iIIfFTMNBcLDKuQD2FHtuWcUR3GNG/JoBo1vGsdkiuXFFLp/QgDnsmCtdQKNfpBh
         EXNQ==
X-Gm-Message-State: AOAM532W+20M+mkJQdNkPeLkG3EtOlFhg9ovRZqjlP4yEwtzHN+BgwKi
        mKH5J+DMSZq09kkOxqvACsHIay62Qa1MY8IJ/cbmKA==
X-Google-Smtp-Source: ABdhPJzJ384uxRx8dMOneSKbUIyyuHtV/LDITFeoDAhCDkLIH6C/hXGFNoQoAiwwXorLi/jUgg6El4F1jXThPtbLifc=
X-Received: by 2002:a05:6402:1a58:: with SMTP id bf24mr25933106edb.16.1637338072069;
 Fri, 19 Nov 2021 08:07:52 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook> <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org> <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
 <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
 <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
 <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
 <202111171728.D85A4E2571@keescook> <875ysp1m39.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <875ysp1m39.fsf@email.froward.int.ebiederm.org>
From:   Kyle Huey <me@kylehuey.com>
Date:   Fri, 19 Nov 2021 08:07:36 -0800
Message-ID: <CAP045Aq06LV_jbXVc85bYU62h5EoVQ=rD9pDn+nGaUJ+iWe62w@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 8:12 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Kyle thank you for your explanation of what breaks.  For future kernels
> I do need to do some work in this area and I will copy on the patches
> going forward.  In particular I strongly suspect that changing the
> sigaction and blocked state of the signal for these synchronous signals
> is the wrong thing to do, especially if the process is not killed.  I
> want to find another solution that does not break things but that also
> does not change the program state behind the programs back so things
> work differently under the debugger.

The heads up in the future is appreciated, thanks.

- Kyle
