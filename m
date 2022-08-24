Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C049D59FECA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 17:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiHXPvE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 11:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbiHXPvD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 11:51:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F0A56B82;
        Wed, 24 Aug 2022 08:51:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q2so20485509edb.6;
        Wed, 24 Aug 2022 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=XSXhfnDUfbBy7Q1IY7kNQQfLX8S9OYrluEFXHaozl2U=;
        b=auLtMCwTrnX2Us0+PsMajvVrOlaOivz3mzZZSDGc+MQmLsNIj9nmXwnYM6QLaRIipM
         V9TV0fi7tQBLwkPWoTH2FTSTVWrtncVHdYCmlqc1JMGn2xBLcdQhKuuBtZlYNVGu8N46
         LOGi/Jawvm8CGl1iQlCIQsMwPrkhAI8vVCf9Jq8rcQ/U+xb/4Vw/KTfGYFjpRFWDzB+E
         I7XNOiFC1xtkkqE0FK61W4nX8SzgTn5DIw+q6tAdsNDYnn6mk8CO/NhF6zia0SdpX6rd
         LzZ6hhzX0y2z923tJOjh81SPgcx8XVF2Lu2w4YeFje00Rm8lYD+A+m5XiiFhQNRem6AX
         fobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=XSXhfnDUfbBy7Q1IY7kNQQfLX8S9OYrluEFXHaozl2U=;
        b=kgKWA/XrUCBITPkgFXfi+U0OZrixpSQgietGTI1dH93zCtR++LUk4q8/IJQAKVcla+
         pzMMpZzbb/op+MVxAjq0hnx5TVlAdgvG6c1pGRbRN2V0Ra0nOcFMee8REFkJhH6e3mZk
         eJu/oVKg0VzNfueOJ+uUmy3R0t97pCaLxaz+M/8dMB5gUMjnG6bhqQ6K73J5QbeHH2fu
         KVqZwNln8DyUIfP4k3QE7NJBWtsxLgXBFmsVEGO4ZenjqR9X7//puELmre2YDzEoArse
         6mtN+/sMV6FMlT7zDd9JG7BHLXiN/W/qv0Orc16lOoKQv/D+DUBDz1dFPa7xmcvXomze
         tjkw==
X-Gm-Message-State: ACgBeo12jkYiDUJf8C04aMeAJSWVIeGWHkAtkeW8jtv0ksxN/GcHXqnF
        ykmhIBrkiKXdwWOq18RZf1bVHa71mW4AHU8mVZw=
X-Google-Smtp-Source: AA6agR6m7eS6OsAU6tFZb4s+iVDazP1DiUS4m3cG7gh3fqkQMNOOTF8pJRt6Cv1D1ju4QRmyORUba5xy6UyF0dZjWI8=
X-Received: by 2002:a05:6402:298c:b0:446:a97:1800 with SMTP id
 eq12-20020a056402298c00b004460a971800mr8227547edb.421.1661356260610; Wed, 24
 Aug 2022 08:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <a46dffe36f2570ec91761b1d604ac52fa0a10efb.1661348961.git.mqaio@linux.alibaba.com>
 <9BE5800D-DA65-485A-8E5E-5B84F59F70BD@fb.com>
In-Reply-To: <9BE5800D-DA65-485A-8E5E-5B84F59F70BD@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 Aug 2022 08:50:49 -0700
Message-ID: <CAADnVQLF6SjASpwS1i0YP2NT16Ctvn0s3jeCudKimNXQdi9Ebw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix incorrect fcntl call
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     Qiao Ma <mqaio@linux.alibaba.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 24, 2022 at 8:13 AM Mykola Lysenko <mykolal@fb.com> wrote:
>
> Hi Qiao,
>
> > On Aug 24, 2022, at 7:01 AM, Qiao Ma <mqaio@linux.alibaba.com> wrote:
> >
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> >
> > |-------------------------------------------------------------------!
> >
> > To set socket noblock, we need to use
> >> fcntl(fd, F_SETFL, O_NONBLOCK);
> > rather than:
> >> fcntl(fd, O_NONBLOCK);
>
> Can you please add more description on what is it fixing?
>
> Additionally, add file name to the title to make it easier to identify th=
e commit from oneline git log.

file name in commit log? I think it's overkill.
The file names can be seen with git log --stat
Let's not put duplicate info into subjects.

> Something like =E2=80=9Cselftests/bpf: fix incorrect fcntl call (test_soc=
kmap.c)=E2=80=9D.
