Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3096759C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjATQVI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 11:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjATQVH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 11:21:07 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60C44B483;
        Fri, 20 Jan 2023 08:20:40 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so8869646lfv.2;
        Fri, 20 Jan 2023 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PIyD0F5Y9Z3DpMXzhOW/VfaSYPRIBHl6F02SOb8HbsU=;
        b=HciAGZ4tVEY9GjcwAvtBl/e6tp2r0tPckvrJyjobHizCob8HpFH8a7NoL43/wANiOh
         pVsp/Qjc9ZVA2RnTBAjiNzwDezratqNU3WJAxmB/BxDKWb9jD4Le/uYhZ1b45pi1sa5a
         aE0CKhURBnbHaW23T0vg/VDQbMUN5mqHrI3t+Zt2AU0r8BLSUQriq0w89QoavBvU3HIa
         QPJU8G2fkLXuBDPQU+her73SxZ9tZ7Qu4B0PW7ANDy/1y1EXI92ETk+AEkwfhl9v3TN3
         eEWHT1XuEjhv1w5bwvfnq2rJQ3vW/6KkWmQjII1/QDgIPN6cjSmXxfaUWiJOQtIuNMCa
         yAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIyD0F5Y9Z3DpMXzhOW/VfaSYPRIBHl6F02SOb8HbsU=;
        b=cjAKBqNoDGw7W0ID5lCfkrAl/oJr7c4VHn4LipZzDrRfCHzxaFyZb6O6WwFdpfCeoY
         HTv5s0RmtcAPz1g0jgt5lH7sdSmJUULH3YhgXUTO5uoDoszAtibUyHfCmkuE/NgyztYA
         IWbFmbNj3LXggVweQD2ml7b2Z4yt6XUk7lCDiCjoPXyS0qitdFPxpVOa7aaTzQrkTC5H
         aoWZ2qWzltcc9foWREAlkTaLbI0g10xIRkMeR0m8Rw43zUSHgKlNqEVJzDMY6zIxlCDr
         9yi9kgCUc5WXhtJ3gImc+lRBmRauSOFpSH63XIFZ5Bk749Wf1rOt1faE9Eb1VLHfMirr
         HKHg==
X-Gm-Message-State: AFqh2kpdqYy8SQ904ZJLxp1tG6CVw5ixZXQt0mDTA5lwbfjfCXgCGzHi
        vzkdsEpxT3yn0G5CTZEMXzeFcuATO+s03cGO5p8=
X-Google-Smtp-Source: AMrXdXvxyAbJ/Kt/Wt6XKbtre4dYgzO2D0CHmJSOcGbGowbfv2Df5ZxmABPtWktJGYFR7INpFmUsJRRur+zphKlst1k=
X-Received: by 2002:ac2:55bb:0:b0:4cc:73ff:6d3f with SMTP id
 y27-20020ac255bb000000b004cc73ff6d3fmr1247500lfg.35.1674231638576; Fri, 20
 Jan 2023 08:20:38 -0800 (PST)
MIME-Version: 1.0
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net> <Y8pcIjGsikDeGqoU@amd.com>
 <CA+icZUWP_uYr5B6d_xms5gpCRmNCx46KwukmZyuuTdEPawKUyA@mail.gmail.com> <0a1ae8e9-ab0e-038a-084f-240f73489010@linuxfoundation.org>
In-Reply-To: <0a1ae8e9-ab0e-038a-084f-240f73489010@linuxfoundation.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 20 Jan 2023 17:20:01 +0100
Message-ID: <CA+icZUVgt422h2nOfhjyahMF2yX_Eon613Ep7=gJ5XRWDAMkmw@mail.gmail.com>
Subject: Re: [PATCH] selftests: amd-pstate: Don't delete source files via Makefile
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Huang Rui <ray.huang@amd.com>, Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 20, 2023 at 5:15 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 1/20/23 09:11, Sedat Dilek wrote:
> > On Fri, Jan 20, 2023 at 10:17 AM Huang Rui <ray.huang@amd.com> wrote:
> >>
> >> On Fri, Jan 20, 2023 at 01:54:01PM +0800, Doug Smythies wrote:
> >>> Revert the portion of a recent Makefile change that incorrectly
> >>> deletes source files when doing "make clean".
>
> Ooo. That is bad.
>
> >>>
> >>> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
> >>> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> >>> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> >>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> >>
> >> (+ Shuah and linux-kselftest mailing list)
> >>
> >> Thanks for fix!
> >>
> >> Acked-by: Huang Rui <ray.huang@amd.com>
> >>
> >
> > [ I already replied - but with these important CCs ]
> >
> > Hi Doug,
> >
> > Thanks for the patch!
> >
> > Small nit, I saw this with:
>
> What did you see and should that be fixed as well.
>
> >
> > $ make -C tools/ clean
> >
> > Otherwise:
> >
> > Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> >
>
> Send me the revised patch with all the right CCs and I will pull
> this right away.
>

Hi Shuah,

that was my original posting...

Subject: [6.2-rc4] tools: {amd,intel}_pstate_tracer: make -C tools/ clean
https://lore.kernel.org/all/CA+icZUUOckm1kwOEZhSw8zsaL5z7r8uczwiKeKGEVioZ=GeFNg@mail.gmail.com/

...and should contain all CCs I got with scripts/get_maintainer.pl.

Is that OK?

BR,
-Sedat-
