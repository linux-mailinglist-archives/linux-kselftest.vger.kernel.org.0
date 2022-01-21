Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7353549574A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 01:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348118AbiAUAUe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 19:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348093AbiAUAUe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 19:20:34 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECB1C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 16:20:33 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r10so4746767edt.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 16:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jKMNUnGm3jiq4ndAsWPtdfAYx+BnQklqii9F9WO4kEc=;
        b=R0kMCvEpODC0J0yU+NL6LG2SLRqqEKDnsRlqSsyl3KNWXRipBWZ1DLoeP+X0XTqR47
         fON+w0MKCvcBkXpjVUBszSfFROi8RqogCYHrGQZpHh4oUeUt/Eo5k2QGjk+EZczgulRi
         oXL46J5j04tqVt8ClNoMXXzXJ4iZhK2w20r3uMrvWedB9zK7kSpBDubObVlUETucDTKR
         vStY1kcFtmozoufpvQRri83zW0hQPY3eZWoH7xKZNth/S/j4JACOMY1DzNbwxRWcCtsG
         At0UuRDgEzbq33UfobecdOJlT9y5ReOv9pg3xZRERw5MnjcaxWr/E0m0OnyRRJ4bCW57
         Dl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jKMNUnGm3jiq4ndAsWPtdfAYx+BnQklqii9F9WO4kEc=;
        b=wU9j5h1+5zwRlIoWQh4+LSWc9A+e75TctQeBP/M7WrP4RzL8eVbiBgV9TELupioDNo
         KLQF1F6EQIhEr2cu4HkDQxY1VpESPxLxYMmGRkRdDlITG/zXJN6xdoKIErsleqU5lSbd
         HgoI63a7VIbgwWlxnO70d31VBpinsE1vQZ8B4rlvQWq8r2meONJhh/o2/2bOIacBNNFT
         jDOOOsaY2UdLiwruzRYLvs9d5oDhR5YVC4kdydUvVh5JnzXh1pjf3RHaujVWYOUuxAC1
         ggA/X0eF6hlS8quByKBQSJS9Ngpisnk6eggR040HU5yT+7ABlnvvziKrkA7zTmHxEsMz
         4OJA==
X-Gm-Message-State: AOAM532qgWRT5kBBZSvY1i8W1vbID/HYrOVjg3OPYfFqUTQFwR42C6bt
        tzke3IkyQgTshZcKCcwKYHorEJN+sMuK2mCetnu0Ow==
X-Google-Smtp-Source: ABdhPJxtv7SQDg6jork6yI55vr20/xMyOXR/+2OeGD+fT4VVFn3o1idt0D/0ebPHJXASQhqkV/+6QeCr10aHajv/8oI=
X-Received: by 2002:a05:6402:13c6:: with SMTP id a6mr1709132edx.222.1642724432084;
 Thu, 20 Jan 2022 16:20:32 -0800 (PST)
MIME-Version: 1.0
References: <20220117232259.180459-1-michal.winiarski@intel.com>
 <CAGS_qxrL8Ey8sq3Mk586dBQtdkAMK9WbeTKC3OGL6r09uEwEKA@mail.gmail.com> <d27cf495-c88f-d5f5-e68c-3dc03eff7a73@intel.com>
In-Reply-To: <d27cf495-c88f-d5f5-e68c-3dc03eff7a73@intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 20 Jan 2022 16:20:20 -0800
Message-ID: <CAGS_qxqjb+biom-Xk9rn9PnnZpTDsm5ctb=RigVwKLYpux3VwA@mail.gmail.com>
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

On Thu, Jan 20, 2022 at 2:21 PM Micha=C5=82 Winiarski
<michal.winiarski@intel.com> wrote:
> > So I'm a bit doubtful about this particular statement, but if you have
> > tried it out and it works well, then that's good too.
> >
> > I just think the primary benefit of UML is faster compilation and it
> > being somewhat lighter than bringing up a VM.
>
> It was good enough to debug any problems that I accidentally introduced
> during the conversion, but perhaps that was simple enough usecase to not
> encounter SIGSEGVs.

Ah, that's good to know.

>
> I don't thing that would work. IIUC, currently the runner is operating
> on taint - there's a subset of taints that it considers "fatal"
> (including TAINT_WARN).
>
> If we have tests that WARN, perhaps we could introduce extra flag to the
> test state on per-test or per-testsuite level, to mark that the test
> wants to fail-on-warn?
> Then we would only fail if the test opted in (or other way around? if
> opt-out makes more sense and we have more tests that actually don't WARN
> as part of their normal test logic).

Yeah, I think this would work.
I chatted with Brendan and David about this and suggested this approach.

This definitely seems useful, so I definitely think we should keep it
in mind, even if we don't get an implementation done in the near
future.

>
> It's applied on top of DRM subsystem integration tree (drm-tip):
> https://cgit.freedesktop.org/drm-tip
> At that time it was already based on v5.16.

Ack, thanks!

I might take another stab at applying the patches locally, but based
on my brief skim over them, everything seemed fine from a KUnit point
of view. It's quite clear you've read over KUnit pretty thoroughly
(e.g. figured out how to create new managed resources, etc.). So I
probably won't have any feedback to give.

>
> Most of that 17-18s is taken by two subtest of drm_mm_tests:
>
> [22:17:19] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [22:17:19] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D drm_mm_tes=
ts (1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [22:17:27] [PASSED] test_insert
> [22:17:27] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED=
] drm_mm_tests =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [22:17:27] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [22:17:27] Testing complete. Passed: 1, Failed: 0, Crashed: 0, Skipped:
> 0, Errors: 0
> [22:17:27] Elapsed time: 10.400s total, 0.001s configuring, 2.419s
> building, 7.947s running
>
> [22:17:42] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [22:17:42] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D drm_mm_tes=
ts (1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [22:17:50] [PASSED] test_replace
> [22:17:50] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED=
] drm_mm_tests =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [22:17:50] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [22:17:50] Testing complete. Passed: 1, Failed: 0, Crashed: 0, Skipped:
> 0, Errors: 0
> [22:17:50] Elapsed time: 10.272s total, 0.001s configuring, 2.492s
> building, 7.776s running
>
> Their runtime can be controlled with max_prime and max_iterations
> modparams - I left the default values intact, but we can tweak them to
> speed things up if needed.

Ah, I was not concerned about test runtime at all.
I was just suggesting that real-time output would be useful if you
didn't have it already.
