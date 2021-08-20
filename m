Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5953F3221
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 19:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhHTRUj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 13:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhHTRUi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 13:20:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C85C061756
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 10:20:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e21so5704473ejz.12
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VG5fvfC7Y3KRpzRAEA18KK6WLNMl8L5Q75OcNDfJ9CE=;
        b=ikO/PAfJFQUJKrFFQ/NFHitlqiVnSUoUDXWSXtMkcNNf3CTyeoUUBonwMIloJflLz+
         huCrEfJaHgg3yivM5K/LSRVwBXVVx8Cqt5AscZBDAgGk4vznRFQKdUYPARAZm0U6CIzp
         SAe2uTox4gKHqT+v9zOqVvPi1dVz1FzM89vkyWsaTpW0nfihPX1We9/zCONW6DGd14iu
         wzeMLiPOy6tH2FaUAFOcbMTg/3hdjjIdNB5IDiB+ptLssyR1OgWBCcm1laO5aK7wKbHy
         ftSiDq5k4ONSQlNKbgwXWoKTMviBV+PrjJsNVKoHhjGkil6MpnoXMiN17NtXMjOotIQ8
         870A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VG5fvfC7Y3KRpzRAEA18KK6WLNMl8L5Q75OcNDfJ9CE=;
        b=cra2DPEae/PWyL4UmoQgpTBqv44YvQ/Xedi0NZafH1bnORV3qC/FY0QQKtYU9RNgo/
         NsVufwHKkh+oXvSjKnCrIeZUkA2ZQC5qET0egcItERS3BjRW22Rq2SZ6fWUYGB0ZzbVZ
         YoIhaeSv0Y/2oJ+W/JPCSHS84NQBiIuZnv/dQw3pQCwwtDQ1fQ6bx962G/vqRoVQyP7c
         GNcuVbEoIUSSKgJVEe+N+iLJFS01QmhLpkvtiFgzJqxaCbreGTjTrxP5Tdlt0oUzGoOm
         iNZmpuCg+m4nOIBTeoI3sa+lC4aPq2w5KidpDvU1YCRBGKPE7qqKS93JPm5QxFndoehr
         lmLA==
X-Gm-Message-State: AOAM532rpYae/iWDg+Tn6wewELO4H2fvmz/N2leF6gM15Y9UEfm8qUjb
        v79fgGWW1b5VDo4K/TL9MiHpsimehJwxgerY95aumA==
X-Google-Smtp-Source: ABdhPJzZ44FgY6pUApX5hPDqNCIo2OwFIw6hYut4MVzZrKycVCcmV2eZ4QHyQbe2adBLdBie0AsK7xzwIaZvqRqovFg=
X-Received: by 2002:a17:906:d20a:: with SMTP id w10mr23610197ejz.426.1629479999204;
 Fri, 20 Aug 2021 10:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629386192.git.zhansayabagdaulet@gmail.com>
 <318b946ac80cc9205c89d0962048378f7ce0705b.1629386192.git.zhansayabagdaulet@gmail.com>
 <20210819162953.GN5469@sequoia>
In-Reply-To: <20210819162953.GN5469@sequoia>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 20 Aug 2021 13:19:23 -0400
Message-ID: <CA+CK2bCfqGsZKr5Fh3pRC6NcyJExxjrg7C6NxQWvZbVa_PeK=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selftests: vm: add KSM merging time test
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 19, 2021 at 12:29 PM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> On 2021-08-19 21:33:41, Zhansaya Bagdauletkyzy wrote:
> > Add ksm_merge_time() function to determine speed and time needed for
> > merging. The total spent time is shown in seconds while speed is
> > in MiB/s. User must specify the size of duplicated memory area (in MiB)
> > before running the test.
> >
> > The test is run as follows: ./ksm_tests -P -s 100
> > The output:
> >       Total size:    100 MiB
> >       Total time:    0.201106786 s
> >       Average speed:  497.248 MiB/s
> >
> > Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> > ---
> > v2 -> v3:
> >  - no changes
>
> There were no changes to this patch since v2 so my previous review still
> stands:
>
>  Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Thank you for addressing my comments in v2.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
