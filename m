Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA391E8591
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgE2Rq0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 13:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Rq0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 13:46:26 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0548C03E969
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 10:46:25 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id g39so1532007ybe.7
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T28CgoTvLzM8tz16a8eh0RZF1ywEtcGMeBF0Z28L8bI=;
        b=RCjbk41G+1YjTo3SenWTH6akCvneSVzaA7gWDTZlrVbdlg7/9ok6vdHFxJ/rq5g6tQ
         vqjmTING87wl7zjSyEsnON/65b2zeEcVBwjhg5CdANgEkQToI/0f5uC5ucvOEPQNfNvr
         bge8yBsCN6xwDtSMzb3UUCLhc4mf873+VPySRD14/30apaYoHGUadVL2SJ28hlC7S807
         ezUPy8CamLilbILTWxYBTaGSHdhez7KLfsPO4ofoX56D+n2pYcrc0xosGrM8+kWbk4Sf
         AUwPLad4UzeA284yhr4OcEnRB7Ldx6aYq9vZYX96VUhHCgM99vRvogwc0JL9Wi2HRm4R
         oDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T28CgoTvLzM8tz16a8eh0RZF1ywEtcGMeBF0Z28L8bI=;
        b=Ku+7lBWCMgw+zeJwFMGcXLADwwsBxo0Gto2ogIDjrmDK8bgIiEHPpq5IxmPZHAwb3i
         tDlLe5srt5pvICbuFNIOvSz/VJdorN2MyI3dbqYnsFXzwNZ3kMOfYw2j91DrYPL/Bf5A
         wxwCCJuMy4bQACBYxSLMCU3p8rolvjbhxQD5zY+cQzjxV+7ZlY469Cnt15DDnRMq781H
         kMyg788sIwmhIJmHH+vW7HdKKb6MtElVYIfVTxbVV39+eJ5gHZEHRxICjT7uAszs7Tow
         i4pSEu7aWDRpawnMBPdXg7crSFA5hAOUxda0yUpBIN2K0gP9Sm1/AGB06wgyKCq0G6+3
         hOIA==
X-Gm-Message-State: AOAM531qOaPLO6b+6uKdc2IyoWQPwotDsdOf05W1XamglbivXhXGzOfi
        uL+OkvpWOAfLG8auRsDtP0fhyM4qaBmMpo/qFjmcHkQyxK4=
X-Google-Smtp-Source: ABdhPJzyiVpFfT+IpUlTWmIFceOxHre5znwF48nwQ4mneDd657/RkCRNpHtsXubu/XwvVBM8lVwXU/LTwR5jdbO+4Qw=
X-Received: by 2002:a25:bb08:: with SMTP id z8mr15518222ybg.129.1590774385194;
 Fri, 29 May 2020 10:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200527003420.34790-1-vitor@massaru.org> <9b12d44c-938e-b57f-d3ed-509b8e1b07bc@linuxfoundation.org>
In-Reply-To: <9b12d44c-938e-b57f-d3ed-509b8e1b07bc@linuxfoundation.org>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Fri, 29 May 2020 14:45:49 -0300
Message-ID: <CADQ6JjXsSA7YQujOWWthGFSRwwVxs1noo_Ok1LF7YVqGY+=16A@mail.gmail.com>
Subject: Re: [fixup v2] kunit: use --build_dir=.kunit as default
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 2:28 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/26/20 6:34 PM, Vitor Massaru Iha wrote:
> > To make KUnit easier to use, and to avoid overwriting object and
> > .config files, the default KUnit build directory is set to .kunit
> >
> > Fixed up minor merge conflicts - Shuah Khan <skhan@linuxfoundation.org>
> >
> > Fixed this identation error exchanging spaces for tabs between lines
> > 248 and 252:
> >
> > tools/testing/kunit/kunit.py run --defconfig
> >
> >    File "tools/testing/kunit/kunit.py", line 254
> >      if not linux:
> >                  ^
> > TabError: inconsistent use of tabs and spaces in indentation
> >
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=205221
>
> Vitor,
>
> This patch doesn't apply. Can you change to subject to be unique
> Fix TabError and do the patch on top of linux-kselftest kunit
>
> I think you did this, but I can't apply this on top:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit
>

Sure, I'll do that.

> thanks,
> -- Shuah
