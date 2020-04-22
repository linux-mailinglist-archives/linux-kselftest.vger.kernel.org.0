Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EC61B4D6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 21:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgDVTf1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 15:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726496AbgDVTf0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 15:35:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C91C03C1A9
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Apr 2020 12:35:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np7so1432125pjb.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Apr 2020 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XuD/ymlDAdY/vC6za/Lkm0V+RpPXcEmYHcLLMeL5WYM=;
        b=EoF9qkrREtgDvQsWraC9r76+dPLeZESi5INITQFE/cvW1utStfWtm2QDGu1Zt/8wqr
         NgZST5MDpVwH5qSh1VAQqzHZo5g94q+CkyDh/Ie84elMx5pnJMVrqNKYqTM6z9Dwn1OE
         d3ufsvhGbp4zXXK2+dTJ9Xf0J+zgjAZpckn2c4/1bdT7cj1E7voL6J1w72QWkn5vCPEp
         oZ+vLMLpiE56edaSaqMcSYRNks/mTBBCi0WB/b1FbuvFKTNTkPQmLgiR7vknxbz9DDex
         geioj1m8tuoMq7Z1j42KzW6A2FVWdzHsbT2GnkdtMyPzO5/Rv/txinSK8r/X+/HnnQdz
         MNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XuD/ymlDAdY/vC6za/Lkm0V+RpPXcEmYHcLLMeL5WYM=;
        b=Pw3/4ix62v65o0tGH1m4Buoxuk8VHBPSUYabmuUceXAKRBtaLnu/fAsKBOaHtTSysl
         fQmWAxsqqiDpKBd/ajmZApQ8wLmAE+VcH4ZrXs9I5ZUOdA4l7RuV3jVSEKQUyVRQfcjS
         47DBC+Zd18fiKw7DeOCk5SJ58AlnnsOJuZSXW+3bvVEV+OWcmQUYOPLCYXZsYWBqGktM
         JH80AApyauqEs0+rBMW9VIjAF/NEkLjK9K2tCiwarbc+JSV195zCWm/yWrYY7i3hoDe2
         kjpebKS4DMD1OXJIdLO/a2kFwJ0m6FL00Xq9XIMKxE7vaoH2bccRTNCHKZ4KOZEqvgor
         LMSw==
X-Gm-Message-State: AGi0Puaqiy9UHPyVZqpmLhofxiWJPFv+9MHzMC/vQAoBz/qOvgMaG4Y1
        Ktxp7ft9QtL9ScWpKjIaww9z4Eu+QQJcqLNBd4qwyg==
X-Google-Smtp-Source: APiQypJq8+0Y3QtnLZ9pGqBA7cDbR3eGwp0cBiLurpefu/lk53YrHEhQZ+6lvTR3STNKSZD4iWyiSm5XTPgfDdWqxKs=
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr372005pjs.18.1587584124023;
 Wed, 22 Apr 2020 12:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200416114256.226329-1-elver@google.com>
In-Reply-To: <20200416114256.226329-1-elver@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 22 Apr 2020 12:35:12 -0700
Message-ID: <CAFd5g46tezcWT7z6DFWBW=7604=_hNopuvkazE80sLOmJvcQbg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add missing newline in summary message
To:     Marco Elver <elver@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 16, 2020 at 4:43 AM Marco Elver <elver@google.com> wrote:
>
> Add missing newline, as otherwise flushing of the final summary message
> to the console log can be delayed.
>
> Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
