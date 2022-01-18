Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6C49317E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jan 2022 00:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbiARX64 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 18:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbiARX64 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 18:58:56 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865B6C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 15:58:55 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u21so2782672edd.5
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 15:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5f1ekx32GWBGNlV6ybwLRE+uizOl0cg+1caeiV69PeY=;
        b=ovHB0TvGd1pVYqqOh0TxwkqGL4ShREhvUg2/MQsJ2CY6hcvk5bYletb8ZgCGFhv5Dz
         5YxbjUsLWYbkHiIi9Vn2l942jvQZNqe6TB0/Nq8qL09KEYYAcBd1aMM07ugOKweS1m4P
         L6YUh+gESDqZqydGmvrUNqo3Y13IAckHuR67e4EZlT2QdBrVI5s+7KpH3EPePgX+Quyv
         Of49Hlz5M2dbpyLQFByLkkZmZhmpoW+doGOYTdESe1E6sMcu0aMkQfmrDyacviSxhDel
         7Tp0B6JnuOisAo8HSSCGVudduPoZfRniJZqVh577xAdcO0JARzA0ysGOSwDUMVZ7SBf7
         ExDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5f1ekx32GWBGNlV6ybwLRE+uizOl0cg+1caeiV69PeY=;
        b=d0R1chv9Jiy8Lf5nCE5d+OIJPGIWsxg+N0VRucwcKGH3nuvY8s5eSs9mvWzDBchTol
         VzUb0wx5q0fVfgsWn0LMsnqN/d8HMci400IKURmnv5l/f+YkS4avufFsK9YCMi7+7dmO
         retUBVEZUP2CR4e49TPARFgo0mQ9TLS8zUXdO/azR99MMqLVUTy63wc6f2n7fxnGTFuR
         CHXGiaPDogUx3GuPrNHTNArt3a7kfMd+RWKMUJ0jZ6iOV9+iou1Fp9preNR6mucnVh3f
         7cpnDhP5mYt6ZxNQ7iNpqzt3ApxlIA989H5rrvXZ0viBTrIxHrrhu73aJWOQr2IkpoJ3
         04Vw==
X-Gm-Message-State: AOAM531E/FRh8tDopHSZgrZansL8oAiruPnKNeJxUz8Eboqc+Qho1kKN
        Yg8fyDj1cqKYuLvPQb0Vf06XcdPmoQ5WUpDs1J6MgA==
X-Google-Smtp-Source: ABdhPJwtJHei5wgJ05UkDl5MUHlrNFHCoSJEnJXPA/7TO2IB2GMZSMMQDiD+Cwo93X/Kl7rHykwfNHyKBo8URvdopTw=
X-Received: by 2002:a17:907:6da4:: with SMTP id sb36mr21779591ejc.542.1642550333765;
 Tue, 18 Jan 2022 15:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20220117232259.180459-1-michal.winiarski@intel.com>
In-Reply-To: <20220117232259.180459-1-michal.winiarski@intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 18 Jan 2022 15:58:41 -0800
Message-ID: <CAGS_qxrL8Ey8sq3Mk586dBQtdkAMK9WbeTKC3OGL6r09uEwEKA@mail.gmail.com>
Subject: Re: [RFC 00/10] drm: selftests: Convert to KUnit
To:     =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petri Latvala <petri.latvala@intel.com>,
        Arkadiusz Hiler <arek@hiler.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 change
On Mon, Jan 17, 2022 at 3:24 PM Micha=C5=82 Winiarski
<michal.winiarski@intel.com> wrote:
>
> KUnit unifies the test structure and provides helper tools that simplify
> the development. Basic use case allows running tests as regular processes=
,
> leveraging User Mode Linux.
> For example, to execute all DRM unit tests:
> ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm
> (the tool also allows using QEMU instead of UML by adding e.g. --arch=3Dx=
86_64)
>
> For developers - it means that it's easier to run unit tests on the devel=
opment
> machine, tightening the feedback loop. When using UML, it also simplifies=
 using

Nice, it's neat to see --kunitconfig being useful for having
one-liners for running tests.

> gdb for debug (since the kernel is just a regular process).

Anecdotally, I hear from davidgow@google.com that using gdb and UML
together isn't the nicest experience because of all the SIGSEGV flying
around when emulating paging.
So I'm a bit doubtful about this particular statement, but if you have
tried it out and it works well, then that's good too.

I just think the primary benefit of UML is faster compilation and it
being somewhat lighter than bringing up a VM.

> For CI systems - DRM tests can be moved from being executed on device und=
er
> test (that's also running IGTs and so on) to being executed on buildsyste=
m
> during build (just like checkpatch.pl).
>
> All tests were renamed - IGT prefix is no longer used.
>
> Compared to selftests executed by CI using IGT, there's one functional
> regression - KUnit test runner is not catching WARNs.
> To solve this, we could either go in the similar direction that UBSAN wen=
t in:
> 1195505 ("kunit: ubsan integration")

Is the suggestion that all WARN's fail the current KUnit test?
I don't think we can do that.

Some KUnit tests will explicitly want to trigger error paths, so we
could have a lot of false positives.

An alternative is that we can apply the 1195505 to the code paths
we're interested in, e.g.

#include <kunit/test-bug.h>
if (bad_thing()) {
  kunit_fail_current_test("bad_thing happened");
}


I don't have the context to know how cumbersome this would be for the
DRM tests though.
If the answer is we want to catch any and all warnings, then we'd
perhaps want to add something to the tests themselves. And maybe we
should implement that as a KUnit library helper function so that other
tests can use it as well.

> Or we could expand the test runner to catch WARN signature in dmesg.

Ditto from the above, I think we'd wrongly mark some tests as failed
for intentional warnings.

>
> Pastebin to preview the output and execution times:
> https://gitlab.freedesktop.org/-/snippets/4139

I see these take 17-18s to exec the tests in the example snippets.
FYI, if you're not already trying this on top of 5.16, there's recent
changes to make the parsed output more fully realtime as well.
So hopefully that should increase the usability of these tests a bit furthe=
r.

I only mention that since I wasn't able to apply this series without
conflicts on top of v5.16.

>
> -Micha=C5=82
>
> Micha=C5=82 Winiarski (10):
>   drm: test-drm_cmdline_parser: Convert to KUnit
>   drm: test-drm_plane_helper: Convert to KUnit
>   drm: test-drm_format: Convert to KUnit
>   drm: test-drm_framebuffer: Convert to KUnit
>   drm: test-drm_damage_helper: Convert to KUnit
>   drm: test-drm_dp_mst_helper: Convert to KUnit
>   drm: test-drm_rect: Convert to KUnit
>   drm: test-drm_mm: Convert to KUnit
>   drm: selftests: Convert to KUnit
>   drm: test: Simplify testing on UML with kunit.py
>
>  drivers/gpu/drm/.kunitconfig                  |    3 +
>  drivers/gpu/drm/Kconfig                       |   22 +-
>  drivers/gpu/drm/Makefile                      |    2 +-
>  drivers/gpu/drm/i915/Kconfig.debug            |    1 -
>  drivers/gpu/drm/selftests/Makefile            |    7 -
>  .../gpu/drm/selftests/drm_cmdline_selftests.h |   68 -
>  drivers/gpu/drm/selftests/drm_mm_selftests.h  |   28 -
>  .../gpu/drm/selftests/drm_modeset_selftests.h |   40 -
>  drivers/gpu/drm/selftests/drm_selftest.c      |  109 -
>  drivers/gpu/drm/selftests/drm_selftest.h      |   41 -
>  .../drm/selftests/test-drm_cmdline_parser.c   | 1141 --------
>  .../drm/selftests/test-drm_damage_helper.c    |  667 -----
>  .../drm/selftests/test-drm_dp_mst_helper.c    |  273 --
>  drivers/gpu/drm/selftests/test-drm_format.c   |  280 --
>  drivers/gpu/drm/selftests/test-drm_mm.c       | 2487 -----------------
>  .../drm/selftests/test-drm_modeset_common.c   |   32 -
>  .../drm/selftests/test-drm_modeset_common.h   |   52 -
>  .../gpu/drm/selftests/test-drm_plane_helper.c |  223 --
>  drivers/gpu/drm/selftests/test-drm_rect.c     |  223 --
>  drivers/gpu/drm/test/Makefile                 |    7 +
>  .../gpu/drm/test/test-drm_cmdline_parser.c    | 1027 +++++++
>  drivers/gpu/drm/test/test-drm_damage_helper.c |  667 +++++
>  drivers/gpu/drm/test/test-drm_dp_mst_helper.c |  429 +++
>  drivers/gpu/drm/test/test-drm_format.c        |  356 +++
>  .../test-drm_framebuffer.c                    |  109 +-
>  drivers/gpu/drm/test/test-drm_mm.c            | 2426 ++++++++++++++++
>  drivers/gpu/drm/test/test-drm_plane_helper.c  |  312 +++
>  drivers/gpu/drm/test/test-drm_rect.c          |  249 ++
>  drivers/video/Kconfig                         |    4 +
>  29 files changed, 5558 insertions(+), 5727 deletions(-)
>  create mode 100644 drivers/gpu/drm/.kunitconfig
>  delete mode 100644 drivers/gpu/drm/selftests/Makefile
>  delete mode 100644 drivers/gpu/drm/selftests/drm_cmdline_selftests.h
>  delete mode 100644 drivers/gpu/drm/selftests/drm_mm_selftests.h
>  delete mode 100644 drivers/gpu/drm/selftests/drm_modeset_selftests.h
>  delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.c
>  delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.h
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_damage_helper.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_format.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_mm.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.h
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_plane_helper.c
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_rect.c
>  create mode 100644 drivers/gpu/drm/test/Makefile
>  create mode 100644 drivers/gpu/drm/test/test-drm_cmdline_parser.c
>  create mode 100644 drivers/gpu/drm/test/test-drm_damage_helper.c
>  create mode 100644 drivers/gpu/drm/test/test-drm_dp_mst_helper.c
>  create mode 100644 drivers/gpu/drm/test/test-drm_format.c
>  rename drivers/gpu/drm/{selftests =3D> test}/test-drm_framebuffer.c (91%=
)
>  create mode 100644 drivers/gpu/drm/test/test-drm_mm.c
>  create mode 100644 drivers/gpu/drm/test/test-drm_plane_helper.c
>  create mode 100644 drivers/gpu/drm/test/test-drm_rect.c
>
> --
> 2.34.1
>
