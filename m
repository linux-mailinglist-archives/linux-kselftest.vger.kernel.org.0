Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BED30FD66
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 20:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbhBDTyl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 14:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbhBDTxK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 14:53:10 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C88C06178B
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 11:52:30 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j11so2310907plt.11
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Feb 2021 11:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQqkRy6HT3Ec6uFrxpBIRxn1t4I6UJT6bne6q4G1RE8=;
        b=Jwh1SNmM09W0b2lds4FNFXFt5l4+5CqpnnDLabPHZxK3YUOmPyGtxewOfBhDc8kcBx
         lnEzfARtiB14vojJlUbJZe8EvC4dLUE9k9+qDL0veVMMKqCoBD+GOlU5cQD9GgeWrp+0
         ZODGaVweUBY6zBbz9TRqY8UqgpIDNyg6+hgUd9ebvT3Vz30SN4ILrRAJjTMuXefE9hmS
         Z9RqU1MuyjMn4K46RHKHaSfivRFsWRWLCsZP0+psO2vwLhAUpIu39eW6NTgRshG0LW3g
         4tVnCpl9CV5gKdQkX6o01H13DBjwUCRRcwUQlOmKruYeIRSbVcMGQNq7UetJwNlhNWDj
         L3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQqkRy6HT3Ec6uFrxpBIRxn1t4I6UJT6bne6q4G1RE8=;
        b=glH61EUtkWLaXlAaIJX9PVZx+bPS7yBDWHym6XRmLzXcBYt8E9oKqt9wLieNhwfn0n
         xRTrktPreIwIbLQ97sLbfE+2vJ2dXV13VHIpcSMDA9qtPRsbgHt4zXhzXnHpPjM0rd7C
         4AcIGKel8R33C6FtBbXjF1TrCtbZn2xYOTNdA3NXjbpRuLDVGsIv2/s7rBw3BIzZKi37
         NIUYOxQ8TdUJwqhI/pjWGPQrn+puNnWHtu3wdqwwNCGjJMvOQMQRsKJIQQF0anI40zd2
         +26unmdFDaWm34E5TNwEmV2tPG3JjuTNIiFTiduMaQm7O27oL7uRlSE/AN7Be/M0TM9X
         3sfA==
X-Gm-Message-State: AOAM533t50H6fOnQHfgDFnUfbyejif8j9KpQY7oApnKDIAD+mBTZ2Q5c
        WlFSXVsFQmhU3DGuygzp4lNkL6QCdAGGcqQIipPfBA==
X-Google-Smtp-Source: ABdhPJzYryyBhRGca3kF7/ZyU1lZUDnM7/BBQI448couvJ8cVAd6yWx5PgeudBZTaDbyKeGcPE7pLW30JMFaqBL2kso=
X-Received: by 2002:a17:902:f686:b029:de:18c7:41f8 with SMTP id
 l6-20020a170902f686b02900de18c741f8mr891572plg.65.1612468349675; Thu, 04 Feb
 2021 11:52:29 -0800 (PST)
MIME-Version: 1.0
References: <20210204173045.1138504-1-dlatypov@google.com> <20210204173045.1138504-4-dlatypov@google.com>
In-Reply-To: <20210204173045.1138504-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 4 Feb 2021 11:52:18 -0800
Message-ID: <CAFd5g47VmNtGv6=GS94QHY0+GW8yLFRLnS4F+ieo2Sh3suB-sQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: tool: fix unintentional statefulness in run_kernel()
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 4, 2021 at 9:31 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This is a bug that has been present since the first version of this
> code.
> Using [] as a default parameter is dangerous, since it's mutable.
>
> Example using the REPL:
> >>> def bad(param = []):
> ...     param.append(len(param))
> ...     print(param)
> ...
> >>> bad()
> [0]
> >>> bad()
> [0, 1]
>
> This wasn't a concern in the past since it would just keep appending the
> same values to it.
>
> E.g. before, `args` would just grow in size like:
>   [mem=1G', 'console=tty']
>   [mem=1G', 'console=tty', mem=1G', 'console=tty']
>
> But with now filter_glob, this is more dangerous, e.g.
>   run_kernel(filter_glob='my-test*') # default modified here
>   run_kernel()                       # filter_glob still applies here!
> That earlier `filter_glob` will affect all subsequent calls that don't
> specify `args`.
>
> Note: currently the kunit tool only calls run_kernel() at most once, so
> it's not possible to trigger any negative side-effects right now.
>
> Fixes: 6ebf5866f2e8 ("kunit: tool: add Python wrappers for running KUnit tests")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Whoah, nice catch! I didn't even know that was a thing!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
