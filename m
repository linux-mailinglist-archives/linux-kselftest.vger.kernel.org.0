Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF11C7E60E2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 00:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjKHXM7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 18:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHXM6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 18:12:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBF2259F
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 15:12:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66911C43397
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 23:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699485176;
        bh=XVBBiYvFcflt3RBN3rGd9qpfbzxVloqDfLv4DULg6ok=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GhEUATI6mZs1fF6smM1OF1+SECjnJXs8PTbY8lZlXnwUzfrIaMjVcZrna4tyfEssS
         MvGlJnycjYJACcUMvu25sl5LhY0BU6ev9+T2BDMC2URKAOJMBfb7nsl3dq4dFrDqaY
         X/HaXRuMCbaH4+k6CzGCidmqxStSSbTkgY54qUJ9GS/aq4bQe50tzUSp/SzQ2govLx
         pDgv0xsqdjqqQkJ4t9vx7+31QS9SI3mT6XwaztXOr2IJCO/29AvnjwYogapTP0s0Nq
         Ok2g9gBp2XnLp3GlK5mFynSBAbjX0JkPLH6IwcRVIfujHgnpbPDDnEbFsm3ibR4FJU
         hnJJ39niADs1w==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2801d7f46f9so173559a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Nov 2023 15:12:56 -0800 (PST)
X-Gm-Message-State: AOJu0Yzso1wOKbcwInkclX5eBsv9hJPRlo1MQfN3oXSjVtwMIfAj18fo
        0fiLlA1WJmwQxgsBkVb0IisWlvV2pdGdi2iWoIwErg==
X-Google-Smtp-Source: AGHT+IG7AbhTVdHwxHa1Gbw/9I7xiut+l21ol4va4G64SojHtO9SqVeRdBniOkqWY5kzkdi8uhNp/WPljLmSit11Y9w=
X-Received: by 2002:a17:90b:350b:b0:27d:20ca:1156 with SMTP id
 ls11-20020a17090b350b00b0027d20ca1156mr2355pjb.34.1699485175679; Wed, 08 Nov
 2023 15:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
 <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com>
In-Reply-To: <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Wed, 8 Nov 2023 15:12:44 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com>
Message-ID: <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] workload-specific and memory pressure-driven zswap writeback
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org,
        roman.gushchin@linux.dev, Shakeel Butt <shakeelb@google.com>,
        muchun.song@linux.dev, linux-mm <linux-mm@kvack.org>,
        kernel-team@meta.com, LKML <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Nhat,

On Wed, Nov 8, 2023 at 1:15=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Ah that was meant to be a fixlet - so that on top of the original
> "zswap: make shrinking memcg-aware" patch. The intention was
> to eventually squash it...
>
> But this is getting a bit annoyingly confusing, I admit. I just rebased t=
o
> mm-unstable + squashed it all again, then sent one single replacement
> patch:
>
> [PATCH v5 3/6 REPLACE] zswap: make shrinking memcg-aware

Thank you for the quick response.

Yes, I am able to download your replacement version of patch 3.
Just FYI, I am using "git mailsplit" to split up the mbox into 6
separate patch files.
On mm-unstable, I am able to apply your replacement patch 3 cleanly.
I also need some help on the patch 0005, it does not apply cleanly either.

$ git mailsplit -ozswap-pool-lru
v5_20231106_nphamcs_workload_specific_and_memory_pressure_driven_zswap_writ=
eback.mbx
$ git am patches/zswap-pool-lru/0001
Applying: list_lru: allows explicit memcg and NUMA node selection
$ git am patches/zswap-pool-lru/0002
Applying: memcontrol: allows mem_cgroup_iter() to check for onlineness
$ git am patches/zswap-pool-lru/3.replace
Applying: zswap: make shrinking memcg-aware
$ git am patches/zswap-pool-lru/0004
Applying: mm: memcg: add per-memcg zswap writeback stat
$ git am patches/zswap-pool-lru/0005
Applying: selftests: cgroup: update per-memcg zswap writeback selftest
error: patch failed: tools/testing/selftests/cgroup/test_zswap.c:50
error: tools/testing/selftests/cgroup/test_zswap.c: patch does not apply
Patch failed at 0001 selftests: cgroup: update per-memcg zswap
writeback selftest
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

>
> Let me know if this still fails to apply. If not, I'll send the whole thi=
ng
> again as v6! My sincerest apologies for the troubles and confusion :(

No problem at all. Thanks for your help on patch 3.

Chris
