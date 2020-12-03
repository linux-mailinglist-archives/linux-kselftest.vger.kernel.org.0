Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33192CCAE2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 01:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgLCAKN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 19:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgLCAKM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 19:10:12 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8207AC0613D6;
        Wed,  2 Dec 2020 16:09:32 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id t33so404677ybd.0;
        Wed, 02 Dec 2020 16:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSRqCAaRcLkYZRDe9sPMRhw1kun96YZxy3quOQXiOAQ=;
        b=LUORY49lPowRTgPYt1NxWrHyARt8746VL7B3nhNSZThE6VKOQRF76ynrD4Q70C7Nkm
         nOzaKfv1d3PeddAHFU4j7CWhkvZl0Zc+jwbcLmKvbTWznv7OEryoT9j/4dFE+DK+Thfp
         UUOxrzF9gm28kxkpRaUz73IhdakmSUyXIq5TpvKMLya4d8bgs+oWd32pTLj+/wOVbhdp
         VkLbhr+AUXpUTFbfUs3ga0PrBaigLw/07IH9TzgrPZExHJCza6jjfdi9mvcJCrztlNlx
         zDmOCz2umU0KqTMp/79Q/FEheRTvya39OsCpLiSp8E6gHNSa/kTAPd2ft5l1VBipwgGd
         uZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSRqCAaRcLkYZRDe9sPMRhw1kun96YZxy3quOQXiOAQ=;
        b=XnDqxLpzcEn3VhhjKmkkkqTxxjjl65NqekrJRKoi448pQrfYDZn7ESzTbKK0/HuBRA
         Kf78fMDKxuvlzY3CP8jjGlghtkTbUYUDNwmGdM1HJWFxr/L0QPy+ORnN44NAxoNFEszT
         Mf98KkXEH8hcBWV5MaNA9iAsUbyns84NkbR+fOIbwZvcOjbLEBGsHWBVwhZaZ0pTjewU
         /ILphXoPEjEH8oZYH7OnQ9BkWSOCcn8J8hfHbCJvSc7XSp0RHmFt2NIHAl68qbnVoeVt
         u+MkA4eiZ2gk6tIQjcYLsE3jgf3PhQqq3jzolP21qGvraldKyzxgeDVox43r6unT+TPY
         kf8w==
X-Gm-Message-State: AOAM5309fc6FVU2jcWIgXEXUNBS67muQm/MV2D3YfjcMAb3rLYVhSgE2
        /MvDms/jLlNDIjdJt/xSEyRcQRYymV+/zdcHtuzIIS+e//k=
X-Google-Smtp-Source: ABdhPJxNkt8kYFRs3YnyhfEeYuT7VIi4ogyNWtrIxFKQvYTSbTDqy2IH5tiazkQwSxRtcCT0I1iWiaCGm6Ny327r+mg=
X-Received: by 2002:a25:2e0d:: with SMTP id u13mr880062ybu.247.1606954171857;
 Wed, 02 Dec 2020 16:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20201202211542.1121189-1-axelrasmussen@google.com>
 <20201202230954.GB108496@xz-x1> <CAJHvVch2LJa57-Si2prKa-S3VUPpu3jYxW+3-+tcLMgSXkB69w@mail.gmail.com>
In-Reply-To: <CAJHvVch2LJa57-Si2prKa-S3VUPpu3jYxW+3-+tcLMgSXkB69w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Dec 2020 01:09:11 +0100
Message-ID: <CANiq72no05JF9Ah__BAcL+Csn5K3_MWYo7Y4TfDmgL+8fvc74Q@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: selftests: make __{s,u}64 format specifiers portable
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Alan Gilbert <dgilbert@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 3, 2020 at 12:55 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> This is what clang-format yields. Are you thinking it would be better
> to line everything up with the ( in uffd_error( ?

Yeah, sometimes clang-format cannot do a good job with the 80 column
limit + 8 tabs.

You are definitely not forced to follow clang-format output by any
means. Subsystem maintainers decide what style they prefer anyway,
which could range from a manual approach to following clang-format
strictly. Clang-format implements the general kernel style as closely
as we could get it so far (it will improve more in the future when we
raise the minimum clang-format version required). See
Doc/process/clang-format.rst.

> Or, perhaps this case is a good reason to make uffd_error() a variadic
> macro so we can insert "-EEXIST" || "error" with a "%s".

...and indeed, sometimes it is a hint that simplifying things could help :-)

Cheers,
Miguel
