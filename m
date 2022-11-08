Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5BE6210C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 13:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiKHMbt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 07:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiKHMbr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 07:31:47 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE44120A8
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 04:31:46 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-333a4a5d495so132084227b3.10
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Nov 2022 04:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kkp3BTBdGKr/zxpTwv+t+pQaYjah9GJQ+Ok1Ti6KajU=;
        b=AiljhK2ByEsKMVnFOYJmDo6qXk8Sq6qn54NKVFSGRcTKmNN6G1cm1KxmwEt7Grgt+3
         YzK6aGYgTSR+3mC3bjmARy1w9NpDi0+bUcQabUNunGrDmtzGCPO85NrLi/8brNA4gi+Q
         qp8WOe3L6CMi/hNwdg66hfX9dWTOAs3vPQiZ3gpX7L/yiTWD+lF9qYyNrKtkTmjZpzkx
         VQVfBb66ccDTthWFSdNPMI8lG9jCoWWvYuwtrBhZALoxVoYauLklOHnAnSDIvq57YZc1
         3Etj2Lx88IDSS0acbUCZg05Xi6DGW5cRXzyodPQ6pRKkXEHNFlDTG5YfQidGFZ2qvtjz
         Ff7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kkp3BTBdGKr/zxpTwv+t+pQaYjah9GJQ+Ok1Ti6KajU=;
        b=W8aY2vuO3in+ilgRbgEvTAlHYFaa8NQ9YFSbvAiAL6fNeKJRQuNwt/QaKCCF4uZHux
         DfVlkuH7sl6WeIyriFyn/5B/c1DmYCRVJ2OxNJKE3fFxT7BA6cQw+nswa2mSUblsxwSX
         fSzdWqbczXw2ynmQ52FzQ42oXF8kFOVMTg5HZgRLmbz379bR5Oq6oEQiGuXhK1hiANhR
         jvc9eKMv7UOoZfBm0ErhfaEmCvMYeSPLrSEW9F7rIGJyn6EcLNyPZVPBFAuzQvhoK3F6
         Hwh3QYBU4m+myyWqGDW2+vVH94ElFwFvolvxjgShk7BD4Rm/AQ2eFFRGysqLBFXdn9j5
         iGmQ==
X-Gm-Message-State: ACrzQf304Zcv+OfPxUz/s8QKZDMRwCSYL5ssWKasjIRpviNVzcaS7dIw
        WgmadQQ7Xs3EHy/0N+PJbiKw7mR7Ochdr6ydsp103A==
X-Google-Smtp-Source: AMsMyM5NH9N1uVGSsgSL8uqeieYyCquEJJSPIV2IksigqI3T9+uJChODv+F8Pux4dZxJGFSmtH3drdP2uJaKSN2BIn4=
X-Received: by 2002:a81:ab4f:0:b0:36f:d141:f9af with SMTP id
 d15-20020a81ab4f000000b0036fd141f9afmr51153372ywk.311.1667910705512; Tue, 08
 Nov 2022 04:31:45 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtLoBo31wRD=+Q8DfO36OGBACp2GY6xvyj8CmUk37rbuA@mail.gmail.com>
 <20221108112811.56mhfrguuscrh2ow@wittgenstein>
In-Reply-To: <20221108112811.56mhfrguuscrh2ow@wittgenstein>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Nov 2022 18:01:33 +0530
Message-ID: <CA+G9fYsVnDSwudT=go0p__2Jas-JuT-8Y+9Jk1xPtA1h4Nmreg@mail.gmail.com>
Subject: Re: selftests: clone3: clone3_cap_checkpoint_restore fails - Could
 not set CAP_CHECKPOINT_RESTORE
To:     Christian Brauner <brauner@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Florian Weimer <fweimer@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 8 Nov 2022 at 16:58, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Nov 08, 2022 at 03:59:56PM +0530, Naresh Kamboju wrote:
> > selftests clone3 cap_checkpoint_restore fails on all devices.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > [   97.198602] audit: type=1701 audit(1651167820.383:12):
> > auid=4294967295 uid=0 gid=0 ses=4294967295 pid=1732
> > comm=\"clone3_cap_chec\"
> > exe=\"/opt/kselftests/default-in-kernel/clone3/clone3_cap_checkpoint_restore\"
> > sig=6 res=1
> >
> > # selftests: clone3: clone3_cap_checkpoint_restore
> > # TAP version 13
> > # 1..1
> > # # Starting 1 tests from 1 test cases.
> > # #  RUN           global.clone3_cap_checkpoint_restore ...
> > # # clone3_cap_checkpoint_restore.c:155:clone3_cap_checkpoint_restore:Child
> > has PID 1733
> > # # clone3() syscall supported
> > # cap_set_proc: Operation not permitted
> > # # clone3_cap_checkpoint_restore.c:164:clone3_cap_checkpoint_restore:Expected
> > set_capability() (-1) == 0 (0)
> > # # clone3_cap_checkpoint_restore.c:165:clone3_cap_checkpoint_restore:Could
> > not set CAP_CHECKPOINT_RESTORE
> > # # clone3_cap_checkpoint_restore: Test terminated by assertion
> > # #          FAIL  global.clone3_cap_checkpoint_restore
> > # not ok 1 global.clone3_cap_checkpoint_restore
> > # # FAILED: 0 / 1 tests passed.
> > # # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> > not ok 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=1
> >
> > Test details links,
> > https://lkft.validation.linaro.org/scheduler/job/5812724#L2074
> >
> > Test results comparison link,
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/tests/
> >
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_cap_checkpoint_restore/history/
> >
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_cap_checkpoint_restore/details/
>
> Similar question to the other report. Is this something that has
> happened before or are we starting to see this failures just now?

These failures have been happening for a long time.

FYI,
LKFT email is configured to send out email to Linux next mailing list with
daily kselftest results / regressions / pass / fail / xfails / skips.

Please refer this link for our reports,
https://lore.kernel.org/linux-next/?q=lkft+kselftest+for+

We are improving our process to report failures and regressions on
mailing lists.

- Naresh
