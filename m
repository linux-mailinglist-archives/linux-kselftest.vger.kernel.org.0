Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51506359478
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 07:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhDIFYA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Apr 2021 01:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhDIFYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Apr 2021 01:24:00 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A44C061760
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Apr 2021 22:23:47 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x12so905157ilm.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Apr 2021 22:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDvYE3lo6mdtPyL38hcLZsUZ7A2Go0Bp2cFLK0Yzql8=;
        b=dTP+Zg0XNWCGh0/GeznXbP4zFivhq7Gf7UKRwBny6Ks7gGOxEJUkjX/tAK1GHpF/lD
         BVJjrx35Dm4dp9fhkx6HX+2lviAu6doNehUEW5O979DMX+LYSk8z87+Y5uuAlWgfEHyX
         FxuThKDDRnfO2+kgZpC1HF+Qm52L8DCzqf+hxPGjGc6329itw4PCSYYvp7M3iA/sFQbo
         UvEJ5TxV9/+hAjN00n8LtzmGh6NWepMFCk+3VQ5cA0LVjM85fa5C00Jy9wLFEo75vIJU
         sFP/HxH9ninIjQM203jbk0HfjhfVHnwJcrOPQT5RRkLj+iVQpz1uaJ4AOa0ybUuGSp5R
         MyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDvYE3lo6mdtPyL38hcLZsUZ7A2Go0Bp2cFLK0Yzql8=;
        b=XJ3Hc/3fF8vjzVkwHVqXek7VC34GSYDPez/5PN8VqGLqkLul2fEwK6hOvjjC+w77qf
         CmYqoEsJBfTrBWgfp0ehlcbMWqZPyIhLGgzdfu8neiegK4BflmALk02F0KBcGNbe6Kvt
         qcezoWP0jDO3Ky1fFwN8VCbcZg7Jg2dCvvym/8goioCXfi0tf70MM1Vmv/klACLkim6I
         GQv9HenLav/1rKdhXMXrzpUijJClcmYzsBQGsYBwqs5VBEuAuT8fz0hwe/W0IKIZnO1C
         arYYX5HsL/lkRxQIIXTChNmh9hkeuSWEkrLEefsFl588pq50FnTMCZOELMVkHpDa9uu/
         +S4A==
X-Gm-Message-State: AOAM531CXDnaZSH1BfZYyoHA8bMR4CcmV37+g6/y5So7Kut51Cmg7TmL
        iPlCjrM5NhK4EYeMX5owids98mAyh/FJ3OLOeuHO1w==
X-Google-Smtp-Source: ABdhPJxTEr4WZEbUEtGTg0cnowxse6HWF8plMi3jVnhxNxBtxKg4fnIIej4/QL1DqlM5Z1owCB2Mz98wp+nr9un5HFs=
X-Received: by 2002:a05:6e02:1a81:: with SMTP id k1mr41418ilv.18.1617945826941;
 Thu, 08 Apr 2021 22:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210404083354.23060-1-psampat@linux.ibm.com>
In-Reply-To: <20210404083354.23060-1-psampat@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 8 Apr 2021 22:23:38 -0700
Message-ID: <CAAYoRsWaAmyuJU4FCb7gtK0y-ZprdDVvp0vMpy=ZohzoC7YX1Q@mail.gmail.com>
Subject: Re: [RFC v3 0/2] CPU-Idle latency selftest framework
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Pratik,

I tried V3 on a Intel i5-10600K processor with 6 cores and 12 CPUs.
The core to cpu mappings are:
core 0 has cpus 0 and 6
core 1 has cpus 1 and 7
core 2 has cpus 2 and 8
core 3 has cpus 3 and 9
core 4 has cpus 4 and 10
core 5 has cpus 5 and 11

By default, it will test CPUs 0,2,4,6,10 on cores 0,2,4,0,2,4.
wouldn't it make more sense to test each core once?
With the source CPU always 0, I think the results from the results
from the destination CPUs 0 and 6, on core 0 bias the results, at
least in the deeper idle states. They don't make much difference in
the shallow states. Myself, I wouldn't include them in the results.
Example, where I used the -v option for all CPUs:

--IPI Latency Test---
--Baseline IPI Latency measurement: CPU Busy--
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            0          101
0            1          790
0            2          609
0            3          595
0            4          737
0            5          759
0            6          780
0            7          741
0            8          574
0            9          681
0           10          527
0           11          552
Baseline Avg IPI latency(ns): 620  <<<< suggest 656 here
---Enabling state: 0---
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            0           76
0            1          471
0            2          420
0            3          462
0            4          454
0            5          468
0            6          453
0            7          473
0            8          380
0            9          483
0           10          492
0           11          454
Expected IPI latency(ns): 0
Observed Avg IPI latency(ns) - State 0: 423 <<<<< suggest 456 here
---Enabling state: 1---
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            0          112
0            1          866
0            2          663
0            3          851
0            4         1090
0            5         1314
0            6         1941
0            7         1458
0            8          687
0            9          802
0           10         1041
0           11         1284
Expected IPI latency(ns): 1000
Observed Avg IPI latency(ns) - State 1: 1009 <<<< suggest 1006 here
---Enabling state: 2---
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            0           75
0            1        16362
0            2        16785
0            3        19650
0            4        17356
0            5        17606
0            6         2217
0            7        17958
0            8        17332
0            9        16615
0           10        17382
0           11        17423
Expected IPI latency(ns): 120000
Observed Avg IPI latency(ns) - State 2: 14730 <<<< suggest 17447 here
---Enabling state: 3---
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            0          103
0            1        17416
0            2        17961
0            3        16651
0            4        17867
0            5        17726
0            6         2178
0            7        16620
0            8        20951
0            9        16567
0           10        17131
0           11        17563
Expected IPI latency(ns): 1034000
Observed Avg IPI latency(ns) - State 3: 14894 <<<< suggest 17645 here

Hope this helps.

... Doug
