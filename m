Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9903F3223
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhHTRVU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhHTRVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 13:21:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC5C061575
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 10:20:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lo4so21553386ejb.7
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSRFa71O1Abz3CtsCgtEjDNe3nuYOG3QUi11RU5JHrg=;
        b=aQy1+sd63YYpCZOrulJQMkLK2awdFz2FpqFEiZc3cIQG36r1DGK8GKykRKWbpi+OdG
         9l73NdbHKb1W0J4nM8drPm0iwly+paS/Yhe/D4tQbjN8DZlNGW41FCX9QGZPmnqwz187
         cFzmvZTmFfffU8nrlZILZIBcZtKBFAvbhWbzwsByCf/p0b4upgcpSDcnjOq75gZv5n5Y
         gqQkEeF/qhGwT2zsb69Qaz0+xFoTqocWJTUpSbxTAYuSpaaiWERnMwPuEMEJm5Bp45w8
         7hP1aRMzD1pnkK8UDQP4pQ+4KxbAaIVAEVHe8FMU6Y7ft2zouKpCemINyHSe3Qsqa8fA
         FsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSRFa71O1Abz3CtsCgtEjDNe3nuYOG3QUi11RU5JHrg=;
        b=R8teOe+um4dsYuHwFLGynsJPsYQkBdC6p0PNSpKrgNbVxFloClu0F5K7Tb+mbdlvPa
         xdvOQDFFiVkiW8EvfsDVneMtnnLQVhe8W9zCcUzzbizuGjWDz70NOgeuZwFUYdRxgz1b
         MnO9Cs8ZyutRq6X5WjNLiFz9o01rYxcId0c8a2mumVBQ4rUGpoBgAdUXUv3CqqYx3sbr
         YtEAKhMwnM5fd4XtrF+IZrrZli9jwnykmLuHxY+FvbyL3I9A7PUCZLxwQ75Bba9OE1yh
         JV03UwdOFKiOkVuZS0H+QpnDrzok0l8w0NnR2DbscU79g4RSTOUgrzBVOzZMEcluLPCd
         pq3w==
X-Gm-Message-State: AOAM531jny+IGoDscoIlf4cGwA7WBOANwV9HLp1pdrGEOGu7Che461yW
        AAkaYrlu4PrM4ct1Cb8/bKhOeokiDCLEmrZTO9mHPw==
X-Google-Smtp-Source: ABdhPJyvZorW7EcurksXyiF19X7N66fLf9JK5b88Zy4/UR6KRUufyUQzC7h0X45htFcDrhic1PId5LzO7MPkT7mVDJA=
X-Received: by 2002:a17:907:f95:: with SMTP id kb21mr22991486ejc.541.1629480040739;
 Fri, 20 Aug 2021 10:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629386192.git.zhansayabagdaulet@gmail.com>
 <1d03ee0d1b341959d4b61672c6401d498bff5652.1629386192.git.zhansayabagdaulet@gmail.com>
 <20210819163117.GO5469@sequoia>
In-Reply-To: <20210819163117.GO5469@sequoia>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 20 Aug 2021 13:20:04 -0400
Message-ID: <CA+CK2bB5kC=wVO0g4mC0VVFHhJyuoL_Kd7zqiHrmXC7jwejcWQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests: vm: add COW time test for KSM pages
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 19, 2021 at 12:31 PM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> On 2021-08-19 21:33:43, Zhansaya Bagdauletkyzy wrote:
> > Since merged pages are copied every time they need to be modified,
> > the write access time is different between shared and non-shared pages.
> > Add ksm_cow_time() function which evaluates latency of these COW
> > breaks. First, 4000 pages are allocated and the time, required to modify
> > 1 byte in every other page, is measured. After this, the pages are
> > merged into 2000 pairs and in each pair, 1 page is modified (i.e. they
> > are decoupled) to detect COW breaks. The time needed to break COW of
> > merged pages is then compared with performance of non-shared pages.
> >
> > The test is run as follows: ./ksm_tests -C
> > The output:
> >       Total size:    15 MiB
> >
> >       Not merged pages:
> >       Total time:     0.002185489 s
> >       Average speed:  3202.945 MiB/s
> >
> >       Merged pages:
> >       Total time:     0.004386872 s
> >       Average speed:  1595.670 MiB/s
> >
> > Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> > ---
> > v2 -> v3:
> >  - address Tyler's feedback
>
> Thanks for incorporating my suggestions! I can confirm that my feedback
> was completely addressed.
>
>  Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>
> Tyler

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
