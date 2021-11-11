Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7B44CFD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Nov 2021 03:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhKKCOL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 21:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhKKCOL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 21:14:11 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA28C061766
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Nov 2021 18:11:20 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i12so4389810ila.12
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Nov 2021 18:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V86pGsGH3+4tLng+NULFNp41vGIclgvzZTeIDe7nl2I=;
        b=bbnDDEHFzBWE9ANBajzzV4yf5f8tNmM41EwG8Vgn2XUd1lQ7MhLC4DJb6GFVQWGyMM
         bIRlqJEOgdh7VTQaJnlioX5XMK3OigplZiMHM90UtHs6GRjOrUZv1Kwjps0UjjUb1p04
         gTHp+r284ehAWlhVnnveojRagTB+Mil52QeK00Dq//jMlHWpqMyXpO2ClnHTp3V+CvSl
         qlVzeuuMxmvjDYxDF42qXjnV+AZQHI3WCGahpHZUszkXLvluJQy0pWQWfDOyjdBfsa0l
         MQW/5Hq1jIsdS/38L9q4MIblqQL3JI1l+0PJH5vkEmoqin4cGPg9Gak0IicAKEyEeqNT
         HU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V86pGsGH3+4tLng+NULFNp41vGIclgvzZTeIDe7nl2I=;
        b=sV0TGlZtfG2gjYFwrgbvgg3/Qlk6tZ+MYUqM2WkpnOrx+dO9PbK+qzsU0+Nw0yye1f
         fT47J1mFcomFgfaCTUWOd7z3HE1NlUCRGDm/5E62tB99KZmqBGPJa70dRoGhoFbfAsvj
         pMpXVNSTSP/S2Y5vxYgbPbtkygvFHfYW5il5QKJkUdfneE3wl/SslqpFaVEPlaCiXbLp
         ebKdA+qjuy77Z0c4DpgKa4URi2QE1P6sRXG2eCkIcwQTFLVoX9qwgJHIEayMoQVMN1qr
         WR+vqv5KpvyjeNWIHEYplmhm8TUPW8U1t18mjbFcYom5N0o5ZViTBEKW4CAOMsYlB+lh
         b17g==
X-Gm-Message-State: AOAM531YF5t/gWWeOuRv1EqIdzS7uipJwN56rC1jbPfmPDQ6Mdp+o1Qv
        49J2OXF1MIwKxjHhxFHfU+YQvX9HVRwZi/xUJKWGbA==
X-Google-Smtp-Source: ABdhPJxpCON6+Jj2TXx6JRUkOx2BvgRWselFtPZrFTxOc9xO5us7X8/7hP/yPIE2lDKKg4FKcaVje/rC1AJ0+jQxmM0=
X-Received: by 2002:a92:de4d:: with SMTP id e13mr2132793ilr.283.1636596679682;
 Wed, 10 Nov 2021 18:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20211111003453.209115-1-andrealmeid@collabora.com> <20211111003453.209115-2-andrealmeid@collabora.com>
In-Reply-To: <20211111003453.209115-2-andrealmeid@collabora.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 10 Nov 2021 18:11:08 -0800
Message-ID: <CAGS_qxq0rNHsWmvjhRGrKcD5gXcFCRL_fcC+OMdi6jOfFz-=nw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] drm: selftest: convert drm_damage_helper selftest
 to KUnit
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@fooishbar.org, igt-dev@lists.freedesktop.org,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        ~lkcamp/discussion@lists.sr.ht, isabbasso@riseup.net,
        maira.canal@usp.br, arthur.grillo@usp.br,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 10, 2021 at 4:35 PM Andr=C3=A9 Almeida <andrealmeid@collabora.c=
om> wrote:
>
> From: Ma=C3=ADra Canal <maira.canal@usp.br>
>
> Considering the current adoption of the KUnit framework, convert the
> DRM damage helper selftest to the KUnit API.

Overall, this looks promising.

I have 2 small suggestions below about the test assertions.

Another suggestion: should we add a drivers/gpu/drm/.kunitconfig file?

See https://www.kernel.org/doc/html/latest/dev-tools/kunit/running_tips.htm=
l#defining-a-set-of-tests
That gives the example of
$ ./tools/testing/kunit/kunit.py run --kunitconfig=3Dlib/kunit
That works by picking up the lib/kunit/.kunitconfig file.

Adding one for this test would make it easier for others to run these
tests, e.g. via

$ cat drivers/gpu/drm/.kunitconfig
CONFIG_KUNIT=3Dy
CONFIG_DRM=3Dy
CONFIG_DRM_DAMAGE_HELPER_KUNIT_TEST=3Dy

$ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm --arch=
=3Dx86_64
...
Testing complete. 21 tests run. 0 failed. 0 crashed. 0 skipped.

>
> Co-developed-by: Arthur Grillo <arthur.grillo@usp.br>
> Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
> ---
>  drivers/gpu/drm/Kconfig                       |  13 ++
>  drivers/gpu/drm/Makefile                      |   2 +-
>  drivers/gpu/drm/selftests/Makefile            |   5 +-
>  .../gpu/drm/selftests/drm_modeset_selftests.h |  21 --
>  .../drm/selftests/test-drm_damage_helper.c    | 215 +++++++++---------
>  5 files changed, 127 insertions(+), 129 deletions(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index cea777ae7fb9..56f6ca74ebb6 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -79,6 +79,19 @@ config DRM_DEBUG_SELFTEST
>
>           If in doubt, say "N".
>
> +config DRM_DAMAGE_HELPER_KUNIT_TEST
> +       tristate "KUnit tests for DRM damage helper"
> +       depends on DRM && KUNIT
> +       select DRM_KMS_HELPER
> +       default KUNIT_ALL_TESTS
> +       help
> +         This option provides a KUnit module that can be used to run
> +         an unit test on the DRM damage helper API. This option is not
> +         useful for distributions or general kernels, but only for kerne=
l
> +         developers working on DRM and associated drivers.
> +
> +         If in doubt, say "N".
> +
>  config DRM_KMS_HELPER
>         tristate
>         depends on DRM
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index ad1112154898..e632c43c9b7d 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -58,7 +58,7 @@ drm_kms_helper-$(CONFIG_DRM_DP_AUX_CHARDEV) +=3D drm_dp=
_aux_dev.o
>  drm_kms_helper-$(CONFIG_DRM_DP_CEC) +=3D drm_dp_cec.o
>
>  obj-$(CONFIG_DRM_KMS_HELPER) +=3D drm_kms_helper.o
> -obj-$(CONFIG_DRM_DEBUG_SELFTEST) +=3D selftests/
> +obj-y +=3D selftests/
>
>  obj-$(CONFIG_DRM)      +=3D drm.o
>  obj-$(CONFIG_DRM_MIPI_DBI) +=3D drm_mipi_dbi.o
> diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftes=
ts/Makefile
> index 0856e4b12f70..311f6af2caf1 100644
> --- a/drivers/gpu/drm/selftests/Makefile
> +++ b/drivers/gpu/drm/selftests/Makefile
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  test-drm_modeset-y :=3D test-drm_modeset_common.o test-drm_plane_helper.=
o \
>                        test-drm_format.o test-drm_framebuffer.o \
> -                     test-drm_damage_helper.o test-drm_dp_mst_helper.o \
> -                     test-drm_rect.o
> +                     test-drm_dp_mst_helper.o test-drm_rect.o
>
>  obj-$(CONFIG_DRM_DEBUG_SELFTEST) +=3D test-drm_mm.o test-drm_modeset.o t=
est-drm_cmdline_parser.o
> +
> +obj-$(CONFIG_DRM_DAMAGE_HELPER_KUNIT_TEST) +=3D test-drm_damage_helper.o
> diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/=
gpu/drm/selftests/drm_modeset_selftests.h
> index 782e285ca383..4787b3b70709 100644
> --- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> +++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> @@ -15,26 +15,5 @@ selftest(check_drm_format_block_width, igt_check_drm_f=
ormat_block_width)
>  selftest(check_drm_format_block_height, igt_check_drm_format_block_heigh=
t)
>  selftest(check_drm_format_min_pitch, igt_check_drm_format_min_pitch)
>  selftest(check_drm_framebuffer_create, igt_check_drm_framebuffer_create)
> -selftest(damage_iter_no_damage, igt_damage_iter_no_damage)
> -selftest(damage_iter_no_damage_fractional_src, igt_damage_iter_no_damage=
_fractional_src)
> -selftest(damage_iter_no_damage_src_moved, igt_damage_iter_no_damage_src_=
moved)
> -selftest(damage_iter_no_damage_fractional_src_moved, igt_damage_iter_no_=
damage_fractional_src_moved)
> -selftest(damage_iter_no_damage_not_visible, igt_damage_iter_no_damage_no=
t_visible)
> -selftest(damage_iter_no_damage_no_crtc, igt_damage_iter_no_damage_no_crt=
c)
> -selftest(damage_iter_no_damage_no_fb, igt_damage_iter_no_damage_no_fb)
> -selftest(damage_iter_simple_damage, igt_damage_iter_simple_damage)
> -selftest(damage_iter_single_damage, igt_damage_iter_single_damage)
> -selftest(damage_iter_single_damage_intersect_src, igt_damage_iter_single=
_damage_intersect_src)
> -selftest(damage_iter_single_damage_outside_src, igt_damage_iter_single_d=
amage_outside_src)
> -selftest(damage_iter_single_damage_fractional_src, igt_damage_iter_singl=
e_damage_fractional_src)
> -selftest(damage_iter_single_damage_intersect_fractional_src, igt_damage_=
iter_single_damage_intersect_fractional_src)
> -selftest(damage_iter_single_damage_outside_fractional_src, igt_damage_it=
er_single_damage_outside_fractional_src)
> -selftest(damage_iter_single_damage_src_moved, igt_damage_iter_single_dam=
age_src_moved)
> -selftest(damage_iter_single_damage_fractional_src_moved, igt_damage_iter=
_single_damage_fractional_src_moved)
> -selftest(damage_iter_damage, igt_damage_iter_damage)
> -selftest(damage_iter_damage_one_intersect, igt_damage_iter_damage_one_in=
tersect)
> -selftest(damage_iter_damage_one_outside, igt_damage_iter_damage_one_outs=
ide)
> -selftest(damage_iter_damage_src_moved, igt_damage_iter_damage_src_moved)
> -selftest(damage_iter_damage_not_visible, igt_damage_iter_damage_not_visi=
ble)
>  selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
>  selftest(dp_mst_sideband_msg_req_decode, igt_dp_mst_sideband_msg_req_dec=
ode)
> diff --git a/drivers/gpu/drm/selftests/test-drm_damage_helper.c b/drivers=
/gpu/drm/selftests/test-drm_damage_helper.c
> index 1c19a5d3eefb..83905661d41e 100644
> --- a/drivers/gpu/drm/selftests/test-drm_damage_helper.c
> +++ b/drivers/gpu/drm/selftests/test-drm_damage_helper.c
> @@ -3,14 +3,11 @@
>   * Test case for drm_damage_helper functions
>   */
>
> -#define pr_fmt(fmt) "drm_damage_helper: " fmt
> -
> +#include <kunit/test.h>
>  #include <drm/drm_damage_helper.h>
>  #include <drm/drm_plane.h>
>  #include <drm/drm_drv.h>
>
> -#include "test-drm_modeset_common.h"
> -
>  struct drm_driver mock_driver;
>  static struct drm_device mock_device;
>  static struct drm_object_properties mock_obj_props;
> @@ -114,7 +111,7 @@ const struct drm_framebuffer fb =3D {
>         mock_setup(&old_state); \
>         mock_setup(&state);
>
> -int igt_damage_iter_no_damage(void *ignored)
> +static void igt_damage_iter_no_damage(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_rect clip;
> @@ -129,13 +126,12 @@ int igt_damage_iter_no_damage(void *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return plane src as damage.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 0, 0, 2048, 2048));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);

optional:
KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return...")

can be used to make the error message more similar to the original.

The same applies to the other instances below


> +       KUNIT_EXPECT_TRUE(test,
> +                       check_damage_clip(&state, &clip, 0, 0, 2048, 2048=
));

optional:

check_damage_clip(test, &state, &clip, 0, 0, 2048, 2048);

and then change check_damage_clip like so:

static void check_damage_clip(struct kunit *test, struct drm_plane_state *s=
tate,
                              struct drm_rect *r, int x1, int y1, int x2,
                              int y2)
{
        /*
         * Round down x1/y1 and round up x2/y2. This is because damage is n=
ot in
         * 16.16 fixed point so to catch all pixels.
         */
        int src_x1 =3D state->src.x1 >> 16;
        int src_y1 =3D state->src.y1 >> 16;
        int src_x2 =3D (state->src.x2 >> 16) + !!(state->src.x2 & 0xFFFF);
        int src_y2 =3D (state->src.y2 >> 16) + !!(state->src.y2 & 0xFFFF);

        if (x1 >=3D x2 || y1 >=3D y2) {
                KUNIT_FAIL(test, "Cannot have damage clip with no dimension=
.");
        } else if (x1 < src_x1 || y1 < src_y1 || x2 > src_x2 || y2 > src_y2=
) {
                KUNIT_FAIL(test, "Damage cannot be outside rounded plane sr=
c.");
        } else if (r->x1 !=3D x1 || r->y1 !=3D y1 || r->x2 !=3D x2 || r->y2=
 !=3D y2) {
                KUNIT_FAIL(test, "Damage =3D %d %d %d %d", r->x1, r->y1, r-=
>x2,
                           r->y2);
}

I'd actually recommend enhancing the original error messages a bit, e.g.:
KUNIT_FAIL(test, "Damage =3D %d %d %d %d, want =3D %d %d %d %d",
           r->x1, r->y1, r->x2, r->y2,
           x1, y1, x2, y2)

Then if I deliberately mess up one of the calls to this func, I get:

[18:08:02]     # igt_damage_iter_no_damage_src_moved: EXPECTATION
FAILED at drivers/gpu/drm/selftests/test-drm_damage_helper.c:87
[18:08:02] Damage =3D 10 10 1034 778, want =3D 11 10 1034 778
[18:08:02]     not ok 3 - igt_damage_iter_no_damage_src_moved

        }
}


>  }
>
> -int igt_damage_iter_no_damage_fractional_src(void *ignored)
> +static void igt_damage_iter_no_damage_fractional_src(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_rect clip;
> @@ -152,13 +148,12 @@ int igt_damage_iter_no_damage_fractional_src(void *=
ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return rounded off plane src as dam=
age.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 3, 3, 1028, 772));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test,
> +                       check_damage_clip(&state, &clip, 3, 3, 1028, 772)=
);
>  }
>
> -int igt_damage_iter_no_damage_src_moved(void *ignored)
> +static void igt_damage_iter_no_damage_src_moved(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_rect clip;
> @@ -174,13 +169,12 @@ int igt_damage_iter_no_damage_src_moved(void *ignor=
ed)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return plane src as damage.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 1034, 778));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test,
> +                       check_damage_clip(&state, &clip, 10, 10, 1034, 77=
8));
>  }
>
> -int igt_damage_iter_no_damage_fractional_src_moved(void *ignored)
> +static void igt_damage_iter_no_damage_fractional_src_moved(struct kunit =
*test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_rect clip;
> @@ -197,13 +191,11 @@ int igt_damage_iter_no_damage_fractional_src_moved(=
void *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return plane src as damage.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test, check_damage_clip(&state, &clip, 4, 4, 10=
29, 773));
>  }
>
> -int igt_damage_iter_no_damage_not_visible(void *ignored)
> +static void igt_damage_iter_no_damage_not_visible(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_rect clip;
> @@ -221,12 +213,10 @@ int igt_damage_iter_no_damage_not_visible(void *ign=
ored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 0, "Should have no damage.");
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 0);
>  }
>
> -int igt_damage_iter_no_damage_no_crtc(void *ignored)
> +static void igt_damage_iter_no_damage_no_crtc(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_rect clip;
> @@ -242,12 +232,10 @@ int igt_damage_iter_no_damage_no_crtc(void *ignored=
)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 0, "Should have no damage.");
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 0);
>  }
>
> -int igt_damage_iter_no_damage_no_fb(void *ignored)
> +static void igt_damage_iter_no_damage_no_fb(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_plane_state old_state;
> @@ -267,12 +255,10 @@ int igt_damage_iter_no_damage_no_fb(void *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 0, "Should have no damage.");
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 0);
>  }
>
> -int igt_damage_iter_simple_damage(void *ignored)
> +static void igt_damage_iter_simple_damage(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -292,13 +278,11 @@ int igt_damage_iter_simple_damage(void *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return damage when set.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 0, 0, 1024, 768));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test, check_damage_clip(&state, &clip, 0, 0, 10=
24, 768));
>  }
>
> -int igt_damage_iter_single_damage(void *ignored)
> +static void igt_damage_iter_single_damage(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -317,13 +301,12 @@ int igt_damage_iter_single_damage(void *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return damage when set.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 256, 192, 768, 576));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test,
> +                       check_damage_clip(&state, &clip, 256, 192, 768, 5=
76));
>  }
>
> -int igt_damage_iter_single_damage_intersect_src(void *ignored)
> +static void igt_damage_iter_single_damage_intersect_src(struct kunit *te=
st)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -343,13 +326,12 @@ int igt_damage_iter_single_damage_intersect_src(voi=
d *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return damage clipped to src.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 256, 192, 1024, 768));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test,
> +                       check_damage_clip(&state, &clip, 256, 192, 1024, =
768));
>  }
>
> -int igt_damage_iter_single_damage_outside_src(void *ignored)
> +static void igt_damage_iter_single_damage_outside_src(struct kunit *test=
)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -369,12 +351,10 @@ int igt_damage_iter_single_damage_outside_src(void =
*ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 0, "Should have no damage.");
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 0);
>  }
>
> -int igt_damage_iter_single_damage_fractional_src(void *ignored)
> +static void igt_damage_iter_single_damage_fractional_src(struct kunit *t=
est)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -396,13 +376,13 @@ int igt_damage_iter_single_damage_fractional_src(vo=
id *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return damage when set.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 256, 330));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test,
> +                       check_damage_clip(&state, &clip, 10, 10, 256, 330=
));
>  }
>
> -int igt_damage_iter_single_damage_intersect_fractional_src(void *ignored=
)
> +static void igt_damage_iter_single_damage_intersect_fractional_src(
> +               struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -425,13 +405,13 @@ int igt_damage_iter_single_damage_intersect_fractio=
nal_src(void *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return damage clipped to rounded of=
f src.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 10, 4, 1029, 330));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test,
> +                       check_damage_clip(&state, &clip, 10, 4, 1029, 330=
));
>  }
>
> -int igt_damage_iter_single_damage_outside_fractional_src(void *ignored)
> +static void igt_damage_iter_single_damage_outside_fractional_src(
> +               struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -454,12 +434,10 @@ int igt_damage_iter_single_damage_outside_fractiona=
l_src(void *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 0, "Should have no damage.");
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 0);
>  }
>
> -int igt_damage_iter_single_damage_src_moved(void *ignored)
> +static void igt_damage_iter_single_damage_src_moved(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -480,13 +458,13 @@ int igt_damage_iter_single_damage_src_moved(void *i=
gnored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return plane src as damage.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 1034, 778));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test,
> +                       check_damage_clip(&state, &clip, 10, 10, 1034, 77=
8));
>  }
>
> -int igt_damage_iter_single_damage_fractional_src_moved(void *ignored)
> +static void igt_damage_iter_single_damage_fractional_src_moved(
> +               struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -509,13 +487,11 @@ int igt_damage_iter_single_damage_fractional_src_mo=
ved(void *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return rounded off plane src as dam=
age.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test, check_damage_clip(&state, &clip, 4, 4, 10=
29, 773));
>  }
>
> -int igt_damage_iter_damage(void *ignored)
> +static void igt_damage_iter_damage(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -535,18 +511,18 @@ int igt_damage_iter_damage(void *ignored)
>         drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
>         drm_atomic_for_each_plane_damage(&iter, &clip) {
>                 if (num_hits =3D=3D 0)
> -                       FAIL_ON(!check_damage_clip(&state, &clip, 20, 30,=
 200, 180));
> +                       KUNIT_EXPECT_TRUE(test,
> +                                       check_damage_clip(&state, &clip, =
20, 30, 200, 180));
>                 if (num_hits =3D=3D 1)
> -                       FAIL_ON(!check_damage_clip(&state, &clip, 240, 20=
0, 280, 250));
> +                       KUNIT_EXPECT_TRUE(test,
> +                                       check_damage_clip(&state, &clip, =
240, 200, 280, 250));
>                 num_hits++;
>         }
>
> -       FAIL(num_hits !=3D 2, "Should return damage when set.");
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 2);
>  }
>
> -int igt_damage_iter_damage_one_intersect(void *ignored)
> +static void igt_damage_iter_damage_one_intersect(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -568,18 +544,18 @@ int igt_damage_iter_damage_one_intersect(void *igno=
red)
>         drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
>         drm_atomic_for_each_plane_damage(&iter, &clip) {
>                 if (num_hits =3D=3D 0)
> -                       FAIL_ON(!check_damage_clip(&state, &clip, 20, 30,=
 200, 180));
> +                       KUNIT_EXPECT_TRUE(test,
> +                                       check_damage_clip(&state, &clip, =
20, 30, 200, 180));
>                 if (num_hits =3D=3D 1)
> -                       FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1=
029, 773));
> +                       KUNIT_EXPECT_TRUE(test,
> +                                       check_damage_clip(&state, &clip, =
4, 4, 1029, 773));
>                 num_hits++;
>         }
>
> -       FAIL(num_hits !=3D 2, "Should return damage when set.");
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 2);
>  }
>
> -int igt_damage_iter_damage_one_outside(void *ignored)
> +static void igt_damage_iter_damage_one_outside(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -600,13 +576,12 @@ int igt_damage_iter_damage_one_outside(void *ignore=
d)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return damage when set.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 240, 200, 280, 250));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test,
> +                       check_damage_clip(&state, &clip, 240, 200, 280, 2=
50));
>  }
>
> -int igt_damage_iter_damage_src_moved(void *ignored)
> +static void igt_damage_iter_damage_src_moved(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -629,13 +604,11 @@ int igt_damage_iter_damage_src_moved(void *ignored)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 1, "Should return round off plane src as damag=
e.");
> -       FAIL_ON(!check_damage_clip(&state, &clip, 3, 3, 1028, 772));
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 1);
> +       KUNIT_EXPECT_TRUE(test, check_damage_clip(&state, &clip, 3, 3, 10=
28, 772));
>  }
>
> -int igt_damage_iter_damage_not_visible(void *ignored)
> +static void igt_damage_iter_damage_not_visible(struct kunit *test)
>  {
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_property_blob damage_blob;
> @@ -660,7 +633,39 @@ int igt_damage_iter_damage_not_visible(void *ignored=
)
>         drm_atomic_for_each_plane_damage(&iter, &clip)
>                 num_hits++;
>
> -       FAIL(num_hits !=3D 0, "Should not return any damage.");
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, num_hits, 0);
>  }
> +
> +static struct kunit_case drm_damage_helper_tests[] =3D {
> +       KUNIT_CASE(igt_damage_iter_no_damage),
> +       KUNIT_CASE(igt_damage_iter_no_damage_fractional_src),
> +       KUNIT_CASE(igt_damage_iter_no_damage_src_moved),
> +       KUNIT_CASE(igt_damage_iter_no_damage_fractional_src_moved),
> +       KUNIT_CASE(igt_damage_iter_no_damage_not_visible),
> +       KUNIT_CASE(igt_damage_iter_no_damage_no_crtc),
> +       KUNIT_CASE(igt_damage_iter_no_damage_no_fb),
> +       KUNIT_CASE(igt_damage_iter_simple_damage),
> +       KUNIT_CASE(igt_damage_iter_single_damage),
> +       KUNIT_CASE(igt_damage_iter_single_damage_intersect_src),
> +       KUNIT_CASE(igt_damage_iter_single_damage_outside_src),
> +       KUNIT_CASE(igt_damage_iter_single_damage_fractional_src),
> +       KUNIT_CASE(igt_damage_iter_single_damage_intersect_fractional_src=
),
> +       KUNIT_CASE(igt_damage_iter_single_damage_outside_fractional_src),
> +       KUNIT_CASE(igt_damage_iter_single_damage_src_moved),
> +       KUNIT_CASE(igt_damage_iter_single_damage_fractional_src_moved),
> +       KUNIT_CASE(igt_damage_iter_damage),
> +       KUNIT_CASE(igt_damage_iter_damage_one_intersect),
> +       KUNIT_CASE(igt_damage_iter_damage_one_outside),
> +       KUNIT_CASE(igt_damage_iter_damage_src_moved),
> +       KUNIT_CASE(igt_damage_iter_damage_not_visible),
> +       { }
> +};
> +
> +static struct kunit_suite drm_damage_helper_test_suite =3D {
> +       .name =3D "drm_damage_helper_tests",
> +       .test_cases =3D drm_damage_helper_tests,
> +};
> +
> +kunit_test_suite(drm_damage_helper_test_suite);
> +
> +MODULE_LICENSE("GPL");
> --
> 2.33.1
>
