Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68937E6201
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 03:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjKICKg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 21:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjKICKg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 21:10:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247D26A3
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 18:10:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44F2C433A9
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 02:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699495833;
        bh=DVLFCWJnRMkoGOLTyBqnffpxgwHE8qbUIAAHGI0JehY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SpSoYgaM5E+9cJ+iHccgbzzkJnoR2D5inpMNYNNxkh/BLckbV0HDb8BEAKYzbD5Pk
         Po9vE/CCJSFHTwEWx7CHoK7iHjCpwFM4IJ4QQdtDCGIPRiZOzWo5SUuAO2ewkhC2bD
         moYBglhUR6t+09zvHQIysPuVDuoAfveaT1s0jFWii69A/ozvYeR4VG/ul8ntZOIzoC
         lTr+h8pF76bybG3aDjpbUkuC2bFw45HSCUv1GxQrtJNq4c+xG3E+TXazdBWrW2ZQEk
         WDsTz0jr4RIJXL8W7Q84grfYu2DC4tsfLacS6Gdqiixn9MvcWEu6iRHUjVD0Ux8+/V
         7bsaT97YIO9Kw==
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so302087a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Nov 2023 18:10:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxjfbE1HqCOEpXSbyN+uNYIyORUlS0VuqJaVJSffjfuVXN1eoje
        SrPvBvf8cZpdDD9/jCZbQGG5JbfPVs0sLxHp7fzE0A==
X-Google-Smtp-Source: AGHT+IHmtrIrCFhVDA+PNOLAhehjYlT2Z8PZ6VwoYo9Eyy9bpMSAL2olQgBXd3JCuPc/0Iot3GRqgIvgqwJu+XvWJ2w=
X-Received: by 2002:a17:90a:4f41:b0:27d:12e1:7e20 with SMTP id
 w1-20020a17090a4f4100b0027d12e17e20mr371864pjl.12.1699495832818; Wed, 08 Nov
 2023 18:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
 <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com>
 <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com> <CAKEwX=OpQZhDmCr-a+O0=c8LfPoO0r8y=abpQoKXWcOP+V6yYg@mail.gmail.com>
In-Reply-To: <CAKEwX=OpQZhDmCr-a+O0=c8LfPoO0r8y=abpQoKXWcOP+V6yYg@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Wed, 8 Nov 2023 18:10:21 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNnM_0jDCaAueseiNA1264-MtA0QiQtfjEN1E6aY56MKQ@mail.gmail.com>
Message-ID: <CAF8kJuNnM_0jDCaAueseiNA1264-MtA0QiQtfjEN1E6aY56MKQ@mail.gmail.com>
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

On Wed, Nov 8, 2023 at 4:28=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Hmm my guess is that I probably sent this out based on an outdated
> mm-unstable. There has since been a new zswap selftest merged
> to mm-unstable (written by no other than myself - oh the irony), so
> maybe it does not apply cleanly anymore with git am.

$ git am -3 patches/zswap-pool-lru/0005
Applying: selftests: cgroup: update per-memcg zswap writeback selftest
Using index info to reconstruct a base tree...
M       tools/testing/selftests/cgroup/test_zswap.c
Falling back to patching base and 3-way merge...
Auto-merging tools/testing/selftests/cgroup/test_zswap.c
$ git am -3 patches/zswap-pool-lru/0006
Applying: zswap: shrinks zswap pool based on memory pressure
error: sha1 information is lacking or useless (mm/zswap.c).
error: could not build fake ancestor
Patch failed at 0001 zswap: shrinks zswap pool based on memory pressure
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

I was able to resolve the conflict on patch 6 by hand though. So I am good =
now.

Thanks

Chris
