Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3357E6165
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 01:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjKIA2P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 19:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKIA2P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 19:28:15 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0E4268E;
        Wed,  8 Nov 2023 16:28:12 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a67f447bf0so10396139f.2;
        Wed, 08 Nov 2023 16:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699489692; x=1700094492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lYLDbRd2D1qfONnTpMi6lcuDQ3NJHG1hPpWbdhsIpk=;
        b=ITe3CEo/FEC7YdO6arrUjlDvolPQIvprpS4qTZIB4eUChrvaYEl56tX0sn6u2R7wlk
         tWdTT3DecXBFA8EXu2ZcTRKLgOix4mpozRgjBPhfVs/JPa6ODH39Ki0kJDg65YF8WsxJ
         gAQgn/wldsRJwlb41yejXMar0sNCz9i2BxxQfNH1dF5ZhM84twx3DXz9QlP7Ud9vapP+
         N9trNXsNyMcOtyCHttKswxUZ3HTT12qIvo8C3jW88UfFVblcdFSuhwTM7oq1yaRXF05T
         9k8CUhDW/d/RQcwqgO6i4h3h4LZO9gitiiJOTuFfC9x9VAgEXrBPbflYSKWVddrIZUkg
         CePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489692; x=1700094492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lYLDbRd2D1qfONnTpMi6lcuDQ3NJHG1hPpWbdhsIpk=;
        b=DWdqN8AKZbzPwtO0WxoVdl4yf0Z2Va2psJRPAdY347KnjsSD/JX4TFIPKqAPqjAlW6
         RIPvpPeyD9eavQ3fxS4sHEAstJ/+HWPbPyloel6c6659YND0SjPE3wUt2JLheibEX5hJ
         DSWJW2Zr7fRMf9DIht4A7jK+FE13TWWMGXwwBiogqzYhkfUc/uldxsA7HBT1REZS15aq
         eTg3uC8TTMrwssTR0c7w7QyAeFA7PZKlWdTO7glkdtZtM9uhKScD2o+pWp3X5eMjwAAp
         qAqAnDB9xfIoNUXRMbpgZfb7vVFxl7qT1jSP3u+/VcIp9mZepJ8ySMwUetw5XlefTV3J
         0DvA==
X-Gm-Message-State: AOJu0YzcD9FGmryq9BKYsFfvTx4w8vq73MIXxIKINKGmIESDWOhbivAd
        ipaAxf4HmvApxo5DjNSEeD8kp8hKReyi7HwwmZ0=
X-Google-Smtp-Source: AGHT+IHkMvqxlBqvnjgkl6EzwG4igTKbhMs/Lw+LnDTYIcihAvDofeJz++IVExJAeWN+iW/MV/pGOOhM8CeXk06wwi4=
X-Received: by 2002:a5e:8c16:0:b0:794:eaef:f43e with SMTP id
 n22-20020a5e8c16000000b00794eaeff43emr188592ioj.1.1699489692185; Wed, 08 Nov
 2023 16:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
 <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com> <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com>
In-Reply-To: <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 8 Nov 2023 16:28:00 -0800
Message-ID: <CAKEwX=OpQZhDmCr-a+O0=c8LfPoO0r8y=abpQoKXWcOP+V6yYg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] workload-specific and memory pressure-driven zswap writeback
To:     Chris Li <chrisl@kernel.org>
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

On Wed, Nov 8, 2023 at 3:12=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Nhat,
>
> On Wed, Nov 8, 2023 at 1:15=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > Ah that was meant to be a fixlet - so that on top of the original
> > "zswap: make shrinking memcg-aware" patch. The intention was
> > to eventually squash it...
> >
> > But this is getting a bit annoyingly confusing, I admit. I just rebased=
 to
> > mm-unstable + squashed it all again, then sent one single replacement
> > patch:
> >
> > [PATCH v5 3/6 REPLACE] zswap: make shrinking memcg-aware
>
> Thank you for the quick response.
>
> Yes, I am able to download your replacement version of patch 3.
> Just FYI, I am using "git mailsplit" to split up the mbox into 6
> separate patch files.
> On mm-unstable, I am able to apply your replacement patch 3 cleanly.
> I also need some help on the patch 0005, it does not apply cleanly either=
.
>
> $ git mailsplit -ozswap-pool-lru
> v5_20231106_nphamcs_workload_specific_and_memory_pressure_driven_zswap_wr=
iteback.mbx
> $ git am patches/zswap-pool-lru/0001
> Applying: list_lru: allows explicit memcg and NUMA node selection
> $ git am patches/zswap-pool-lru/0002
> Applying: memcontrol: allows mem_cgroup_iter() to check for onlineness
> $ git am patches/zswap-pool-lru/3.replace
> Applying: zswap: make shrinking memcg-aware
> $ git am patches/zswap-pool-lru/0004
> Applying: mm: memcg: add per-memcg zswap writeback stat
> $ git am patches/zswap-pool-lru/0005
> Applying: selftests: cgroup: update per-memcg zswap writeback selftest
> error: patch failed: tools/testing/selftests/cgroup/test_zswap.c:50
> error: tools/testing/selftests/cgroup/test_zswap.c: patch does not apply
> Patch failed at 0001 selftests: cgroup: update per-memcg zswap
> writeback selftest
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> >
> > Let me know if this still fails to apply. If not, I'll send the whole t=
hing
> > again as v6! My sincerest apologies for the troubles and confusion :(
>
> No problem at all. Thanks for your help on patch 3.
>
> Chris

Hmm my guess is that I probably sent this out based on an outdated
mm-unstable. There has since been a new zswap selftest merged
to mm-unstable (written by no other than myself - oh the irony), so
maybe it does not apply cleanly anymore with git am.

I was, however, able to apply the patch with the -3 argument, i.e:

git am -3 ../mbox/0005

This will fall back to the 3-way merge if direct application fails.
And, FWIW, the kselftest still seems to build.

I think you'll have to do the same with the 6th patch as well. My
guess is that on my latest rebase attempt, this was done silent and
automatically, so I did not notice this.

Let me know if this works. Worst case scenario, I can still rebase 'n
resend the patch series :)
