Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE8F77893E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 10:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjHKIw6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 04:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjHKIw5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 04:52:57 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A922712;
        Fri, 11 Aug 2023 01:52:57 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56ddf189fa0so223200eaf.1;
        Fri, 11 Aug 2023 01:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691743977; x=1692348777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY1lB638PqnQ1Gj4LXDU5aM2F6L9q84K/WHnvLK5Anw=;
        b=TzmWlHV/NdHTTViuag5zM1MgBeILELVlxDWFfU6orwnNBJEk1ctUX1OVYyu3b2Q8wB
         zGAJzZ0XGIJ1NitAprVZqi9cQwhrEWH+NKkQyeCXoN1DjVW/k0f92XUgOMUE0ErGwe5r
         ziFel3PVSqozCF0NZj1htjZ6RJuBFXNmirc9yKYC8eusNfZCPmsnjimaETDZLCcN9s4s
         JbLH/aWdOEt04Ub0VAupXcVDQSo4xBAONC7f++a4NKbhBOvbwhlzCABG5Wpy6NtW4l/M
         fxt6yTCG5ud+Z1LgxICtX6uW5wZ/Xctk1yJUhz31CN25mjofdNr8vPIT6jE9jecARx6y
         GtLA==
X-Gm-Message-State: AOJu0Yx+ec+ZW7rW0L1b/6LS8bUjhi+/zi5nYqL7Ke/s7l5MehOjk3CE
        JNv26EK/i3zciVgvBPaUYyhGALkN1xvDAs+dCwM=
X-Google-Smtp-Source: AGHT+IFNQWU6A1bg9nxCeoRgf8cQevz7hf6MuTqgGHO9kLpP4cYKyQkAwxtePwuw/rDeOGUJmGA1G5V8ynuiooQKd28=
X-Received: by 2002:a05:6820:1687:b0:566:951e:140c with SMTP id
 bc7-20020a056820168700b00566951e140cmr1022767oob.1.1691743976685; Fri, 11 Aug
 2023 01:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230803014354.3304825-1-li.meng@amd.com> <20230811061733.mvqlir3nbnzdp6tx@vireshk-i7>
In-Reply-To: <20230811061733.mvqlir3nbnzdp6tx@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 10:52:45 +0200
Message-ID: <CAJZ5v0ho8msfa08MkvYSm8BhfVu3Y+f2thHV+s7raFdshhbenA@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: amd-pstate-ut: Modify the function to get the
 highest_perf value
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 11, 2023 at 8:17 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-08-23, 09:43, Meng Li wrote:
> > The previous function amd_get_highest_perf() will be deprecated.
> > It can only return 166 or 255 by cpuinfo. For platforms that
> > support preferred core, the value of highest perf can be between
> > 166 and 255. Therefore, it will cause amd-pstate-ut to fail when
> > run amd_pstate_ut_check_perf().
> >
> > Signed-off-by: Meng Li <li.meng@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate-ut.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Applied. Thanks.

So may I leave all of the amd-pstate patches to you?

I would gladly do that. :-)
