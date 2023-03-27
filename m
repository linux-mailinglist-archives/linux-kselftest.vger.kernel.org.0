Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C606CA255
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 13:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjC0L1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 07:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjC0L1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 07:27:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1296E4688;
        Mon, 27 Mar 2023 04:27:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j11so10916250lfg.13;
        Mon, 27 Mar 2023 04:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679916436;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFLJEgCl54wr/QmrfFJiXPoYKH/Rd8UENEA61fP+EVg=;
        b=RgBfPL64dOtZGruVj1H0JyFVSRkAseN0I0O/jWsuyBMEKxaAdePXkjbi6rjI/Yjpwf
         jqm+62I3X9JLijxNmt0lASUotSephz8dxWqmpHlPPytw66zVlFW1OWIs4np5dAG2qLEY
         A6CRHHj2qQMhWVETihHy7EoXX6MM+fLfqY5rwGuFMaJj0T4gNWfXL+7QiRB7ry+vtFIG
         mgbwFgIXhfI9aQc+k1+2kdzq7AehnJq1lop8E1VMgH9Ej1Rukd6ymxZFKQxwraMl0kjP
         zo/VLFhgOjUp8VZLgQ+48PdfqDCchjHl/1TPq+RTNF/Efv48eIp5ufMuOxiA8adcY7Iz
         3ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679916436;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFLJEgCl54wr/QmrfFJiXPoYKH/Rd8UENEA61fP+EVg=;
        b=lIwXQufKfhBnfILrLUm/n9Id5p30NW5LL+exOK6FRrU03Dy2+/bHJtePZjyjuEP8/q
         hqp3euugoVobkAzMbPKTiLMJ0gI0/YeKucudXH1AXWmj7QkfhKJ2Z3s3OrdsbqjT4fEs
         Ig97dYEehKySJ2prO8Y9Wge+WswpnA1+Bh8HKAs9CSHOnee5o/vgJFln0a4Ru95cEd2I
         hUbAxCHnt7ftZr147HvN23IiyLWpDEajpIEaR7rnB8HMVqg7ViUhQSFslUX4RUZEO85U
         T3uRzJd0N8ACLCc2vlvTPaUm+5+TCJyS1XdE3toywmYxkJDucZikAEn17k+2ajFlJ6up
         YpkQ==
X-Gm-Message-State: AAQBX9dtzFgAwVU3Vbumep2Nfd/B5nj8RhhTtWHlWMLsUJ4WoXK+oq81
        YrQ9Elk2YzONqNj1HeUSpxs=
X-Google-Smtp-Source: AKy350Zk/DCJPM3xC0BJB6geCrNy1D1OgpQmqMcN6vEr8/Tf8cglzUQetrY6LxI1xxB9oufcoiayXQ==
X-Received: by 2002:ac2:5304:0:b0:4eb:edf:fb5e with SMTP id c4-20020ac25304000000b004eb0edffb5emr1082069lfh.44.1679916436011;
        Mon, 27 Mar 2023 04:27:16 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id v2-20020ac25922000000b004eb09081d77sm1149868lfi.91.2023.03.27.04.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:27:15 -0700 (PDT)
Date:   Mon, 27 Mar 2023 14:27:07 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Zhigang Shi <Zhigang.Shi@liteon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 0/7] Support ROHM BU27034 ALS sensor
Message-ID: <cover.1679915278.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oNazCVh1vZi66Agu"
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--oNazCVh1vZi66Agu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BU27034 ALS sensor

This series adds support for ROHM BU27034 Ambient Light Sensor.

The BU27034 has configurable gain and measurement (integration) time
settings. Both of these have inversely proportional relation to the
sensor's intensity channel scale.

Many users only set the scale, which means that many drivers attempt to
'guess' the best gain+time combination to meet the scale. Usually this
is the biggest integration time which allows setting the requested
scale. Typically, increasing the integration time has better accuracy
than increasing the gain, which often amplifies the noise as well as the
real signal.

However, there may be cases where more responsive sensors are needed.
So, in some cases the longest integration times may not be what the user
prefers. The driver has no way of knowing this.

Hence, the approach taken by this series is to allow user to set both
the scale and the integration time with following logic:

1. When scale is set, the existing integration time is tried to be
   maintained as a first priority.
   1a) If the requested scale can't be met by current time, then also
       other time + gain combinations are searched. If scale can be met
       by some other integration time, then the new time may be applied.
       If the time setting is common for all channels, then also other
       channels must be able to maintain their scale with this new time
       (by changing their gain). The new times are scanned in the order
       of preference (typically the longest times first).
   1b) If the requested scale can be met using current time, then only
       the gain for the channel is changed.

2. When the integration time change - scale is tried to be maintained.
   When integration time change is requested also gain for all impacted
   channels is adjusted so that the scale is not changed, or is chaned
   as little as possible. This is different from the RFCv1 where the
   request was rejected if suitable gain couldn't be found for some
   channel(s).

This logic is simple. When total gain (either caused by time or hw-gain)
is doubled, the scale gets halved. Also, the supported times are given a
'multiplier' value which tells how much they increase the total gain.

However, when I wrote this logic in bu27034 driver, I made quite a few
errors on the way - and driver got pretty big. As I am writing drivers
for two other sensors (RGB C/IR + flicker BU27010 and RGB C/IR BU27008)
with similar gain-time-scale logic I thought that adding common helpers
for these computations might be wise. I hope this way all the bugs will
be concentrated in one place and not in every individual driver ;)

Hence, this series also intriduces IIO gain-time-scale helpers
(abbreviated as gts-helpers) + a couple of KUnit tests for the most
hairy parts.

Speaking of which - testing the devm interfaces requires a 'dummy
device'. I've learned that there has been at least two ways of handling
this kind of a dependecy.

1) Using a root_device_[un]register() functions (with or without a
wrapper)

2) Using dummy platform_device.

Way 2) is seen as abusing platform_devices to something they should not
be used.

Way 1) is also seen sub-optimal - and after a discussion a 'kunit dummy
device' is being worked on by David Gow:
https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidgow@g=
oogle.com/T/#mf797239a8bce11630875fdf60aab9ed627add1f0

David's work relies on not yet in-tree kunit deferring API. Schedule for
this work is - as always in case of upstream development - unkonwn. In
order to be self-contained while still easily 'fixable when David's work
is completed' this series introduces warappers named similar to what was
suggested by david - and which are intended to have similar behaviour
(automatic clean-up upon test completion). These wrappers do still use
root-device APIs underneath but this should be fixed by David's work.

Finally, these added helpers do provide some value also for drivers
which only:
 a) allow gain change
  or
 b) allow changing both the time and gain while trying to maintain the
    scale.

For a) we provide the gain - selector (register value) table format +
selector to gain look-ups, gain <-> scale conversions and the available
scales helpers.

For latter case we also provide the time-tables, and actually all the
APIs should be usable by setting the time multiplier to 1. (not testeted
thoroughly though).

The patch 1/7 introduces the helpers for creating/dropping a test device
for devm-tests. It can be applied alone.

The patch 4/7 (IIO GTS tests) also depends on the patch 1/7 (and also
other patches in the series).

Rest of the series should be Ok to be applied with/without the patches
1/7 and 4/7 - although the 4/7 (which depends on 1/7) would be "nice to
have" together with the rest of the series for the testability reasons.

Revision history:
v5 =3D> v6:
- Just a minor fixes in iio-gts-helpers and bu27034 driver.
- Kunit device helper for a test device creation.
- IIO GTS tests use kunit device helper.

v4 =3D> v5: Mostly fixes to review comments from Andy and Jonathan.
- more accurate change-log in individual patches
- copy code from DRM test helper instead of moving it to simplify
  merging
- document all exported GTS helpers.
- inline a few GTS helpers
- use again Milli lux for the bu27034 with RAW IIO_LIGHT channel and scale
- Fix bug from added in v4 bu27034 time setting.

v3 =3D> v4: (Still mostly fixes to review comments from Andy and Jonathan)
- more accurate change-log in individual patches
- dt-binding and maintainer patches unchanged.
- dropped unused helpers and converted ones currently used only internally
  to static.
- extracted "dummy device" creation helpers from DRM tests.
- added tests for devm APIs
- dropped scale for PROCESSED channel in BU27034 and converted mLux
  values to luxes
- dropped channel 2 GAIN setting which can't be done due to HW
  limitations.

v2 =3D> v3: (Mostly fixes to review comments from Andy and Jonathan)
- dt-binding and maintainer patches unchanged.
- iio-gts-helper tests: Use namespaces
- iio-gts-helpers + bu27034 plenty of changes. See more comprehensive
  changelog in individual patches.

RFCv1 =3D> v2:
  dt-bindings:
	- Fix binding file name and id by using comma instead of a hyphen to
	  separate the vendor and part names.
  gts-helpers:
	- fix include guardian
	- Improve kernel doc for iio_init_iio_gts.
	- Add iio_gts_scale_to_total_gain
	- Add iio_gts_total_gain_to_scale
	- Fix review comments from Jonathan
	  - add documentation to few functions
	  - replace 0xffffffffffffffffLLU by U64_MAX
	  - some styling fixes
	  - drop unnecessary NULL checks
	  - order function arguments by  in / out purpose
	  - drop GAIN_SCALE_ITIME_MS()
	- Add helpers for available scales and times
	- Rename to iio-gts-helpers
  gts-tests:
	- add tests for available scales/times helpers
	- adapt to renamed iio-gts-helpers.h header
  bu27034-driver:
	- (really) protect read-only registers
	- fix get and set gain
	- buffered mode
	- Protect the whole sequences including meas_en/meas_dis to avoid messing
	  up the enable / disable order
	- typofixes / doc improvements
	- change dropped GAIN_SCALE_ITIME_MS() to GAIN_SCALE_ITIME_US()
	- use more accurate scale for lux channel (milli lux)
	- provide available scales / integration times (using helpers).
	- adapt to renamed iio-gts-helpers.h file
	- bu27034 - longer lines in Kconfig
	- Drop bu27034_meas_en and bu27034_meas_dis wrappers.
	- Change device-name from bu27034-als to bu27034
  MAINTAINERS:
	- Add iio-list

---

Matti Vaittinen (7):
  dt-bindings: iio: light: Support ROHM BU27034
  iio: light: Add gain-time-scale helpers
  kunit: Add kunit wrappers for (root) device creation
  iio: test: test gain-time-scale helpers
  MAINTAINERS: Add IIO gain-time-scale helpers
  iio: light: ROHM BU27034 Ambient Light Sensor
  MAINTAINERS: Add ROHM BU27034

 .../bindings/iio/light/rohm,bu27034.yaml      |   46 +
 MAINTAINERS                                   |   14 +
 drivers/iio/Kconfig                           |    3 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/industrialio-gts-helper.c         | 1057 ++++++++++++
 drivers/iio/light/Kconfig                     |   14 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/rohm-bu27034.c              | 1496 +++++++++++++++++
 drivers/iio/test/Kconfig                      |   14 +
 drivers/iio/test/Makefile                     |    1 +
 drivers/iio/test/iio-test-gts.c               |  517 ++++++
 include/kunit/device.h                        |   18 +
 include/linux/iio/iio-gts-helper.h            |  206 +++
 lib/kunit/Makefile                            |    3 +-
 lib/kunit/device.c                            |   36 +
 15 files changed, 3426 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2703=
4.yaml
 create mode 100644 drivers/iio/industrialio-gts-helper.c
 create mode 100644 drivers/iio/light/rohm-bu27034.c
 create mode 100644 drivers/iio/test/iio-test-gts.c
 create mode 100644 include/kunit/device.h
 create mode 100644 include/linux/iio/iio-gts-helper.h
 create mode 100644 lib/kunit/device.c


base-commit: eeac8ede17557680855031c6f305ece2378af326
--=20
2.39.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--oNazCVh1vZi66Agu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQhfYYACgkQeFA3/03a
ocVZswf/eZz9CgMQt5WC+Yd1Goh1kxd1TGeUl13zNiVrxDPnHlne9JtyK+ATQLwz
PzZyeD0w0uXLXbJdVeHXuCVRLhmf7kNM8MaNv9WaRYv2TXqp/cROYJ88P7UIuqTa
w2DhV/I7WD1GBNvmKoeJZmdtK01KHPeY5yVW16TIGkLR//T+aYoX5TFDLW7MI5+K
ALMkjEKbfdQXgRaqaR+KVPIjm9ytyexoZfG9RN5NZQbVtV9YfDcF6UT3BIeY5pVc
qpDHUlxEPE+kFH2NKFa69BawxS3FWGKG8ufP1zJ5XSYh+/MHRSUrrARGzEUXE+t3
zZiAWNQJTl1rUlxWFvD2InGPBXweFA==
=HnIN
-----END PGP SIGNATURE-----

--oNazCVh1vZi66Agu--
