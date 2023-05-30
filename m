Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202CE715B24
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 12:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjE3KMB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 06:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjE3KLm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 06:11:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBF9FF;
        Tue, 30 May 2023 03:11:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso6236992a12.3;
        Tue, 30 May 2023 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685441485; x=1688033485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At7A/+qj2Bfzjswr5nBXvoTf62Nljj8OgfPhKoSwaJM=;
        b=JOtohSkABPTgI8VFUJ8Ml95c47LlY2BM0s9+S0/ICInjHcBYKRs59pXeWyBxMqL6oX
         zHtEAz4wkOvDNsml5Ksxe3HGzcovlobuhfwvzyMNz2I98vPyWcQzMdbhmFJyBl77u7Y4
         o3aSPoA+7kW831GTc8nXYAc/2R/XpiYqRPNu/ij0DyvOL+Ou2NG541J9EEzTTIZvTJWu
         kWJhANd5ykwuQF7eUFl2xNnPL8/pyQYxqmHvgI0YHPD45JUE1KAXtgf6AXBGAgkNmBH+
         o97vq/ixCQoGAPa64eNE2fGC4TI/Wsv6Yw5oFpzzIH2pqeGHh56HNolE7yC/YGWuLFyQ
         /2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685441485; x=1688033485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At7A/+qj2Bfzjswr5nBXvoTf62Nljj8OgfPhKoSwaJM=;
        b=Uwr4Lv7QwRdug5aTjFMfNcbIASdhFPZDoWcsp1aCYL3Ordu0rQlWcNksZ8MbHz5aSS
         wSvguNOLgxIppxvxJGs4nM9yzcxtaT5adrvFwNt9y4BEyBZdCleutTEzEqvQLu7x35s+
         T/t+rd2ZLIK+1ZH45LY9QFoMfMkHckcmgAURAfbYJqDjGNI4suIdPJbtQTHv/NvJoSB4
         GJX16wMpjmhy27SEMUhkcdC6ZKZ0ZCtqlG+YMVYXfuR7K85/+N+nQNhBXCqAfvxDoRKi
         chdo6aPE07WXb9657jw0uDRdLRekCqrgYsxrO/5MTuTwS04Y98jmKrBoQJ8Ovup0AD8w
         /QBg==
X-Gm-Message-State: AC+VfDwxIuNAcuJNVFX4RLDDYkhqpVUH3zrVwJ9nItm/Z3uUEgI7UAWT
        qSM6xT3zygrnqBm5pkJOg5kpuJu/DuwkBiIEgy+TVHHYgXDuOw==
X-Google-Smtp-Source: ACHHUZ7sjSb+aWgUHe//H3jmHofe4dp3U2ph3ZtabQR/quAorQ25/IZFGTce8LgVvM9IaPaoJD3za7QB711fO9oE4NM=
X-Received: by 2002:a50:ef13:0:b0:50b:f929:c6d3 with SMTP id
 m19-20020a50ef13000000b0050bf929c6d3mr1425933eds.1.1685441484741; Tue, 30 May
 2023 03:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230526082205.6297-1-eballetbo@kernel.org> <8f4a440e-855c-76d0-62fe-82d35c002fc5@redhat.com>
 <CAFqH_52L+fq_hZaN1xuBFWecNADWG7_TWbebKxmU8hsO9fJe1Q@mail.gmail.com>
In-Reply-To: <CAFqH_52L+fq_hZaN1xuBFWecNADWG7_TWbebKxmU8hsO9fJe1Q@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 30 May 2023 12:11:12 +0200
Message-ID: <CAFqH_50BUoGUAxZWCoYvPYPkeKA2_dkHYi_1JcE8ktUbyJ9Cgw@mail.gmail.com>
Subject: Re: [PATCH] selftests/input: Introduce basic tests for evdev ioctls
To:     Peter Hutterer <peter.hutterer@redhat.com>
Cc:     eballetbo@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Dana Elfassy <delfassy@redhat.com>,
        linux-input@vger.kernel.org, phuttere@redhat.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Again, without html format. Sorry for the noise.

Hi Peter,

Many thanks for taking a look at this and for the review comments.

> Missatge de Peter Hutterer <peter.hutterer@redhat.com> del dia dt., 30 de=
 maig 2023 a les 7:56:
> >
> > Hi Enric,
> >
> > On 26/5/23 18:22, eballetbo@kernel.org wrote:
> > > From: Enric Balletbo i Serra <eballetbo@kernel.org>
> > >
> > > This provides a basic infrastructure for the creation of tests for th=
e evdev
> > > interface. Most of this is code is adapted from the libevdev wrapper
> > > library. While most of evdev ioctls are covered and tested using
> > > libevdev tests there are some evdev ioctls that aren't because are no=
t
> > > supported (and will not be supported) by libevdev. So, adding, at lea=
st
> > > those tests, would make sense.
> >
> > for the archives: libevdev doesn't support setting EV_REP because it's
> > inherently racy - one libevdev context to set those values via the ioct=
l
> > would cause all other libevdev contexts on the same device to be out of
> > sync. Since we do not get notifications when the values changed,
> > libevdev's buffered values for EV_REP will remain whatever they were
> > initially.
> >
> > The only way around that would be setting it via udev on plug, but that
> > udev doesnt need/want the libevdev dependency.
> >
> > plus, afaik most or all libevdev's users ignore kernel key repeats anyw=
ay :)
> >
> > >
> > > The test creates an uinput device (and an evdev device) so you can
> > > call the wanted ioctl from userspace. So, to run those tests you need
> > > to have support for uinput and evdev as well.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <eballetbo@kernel.org>
> > > ---
> > >   tools/testing/selftests/Makefile           |   1 +
> > >   tools/testing/selftests/input/.gitignore   |   2 +
> > >   tools/testing/selftests/input/Makefile     |   5 +
> > >   tools/testing/selftests/input/config       |   3 +
> > >   tools/testing/selftests/input/evioc-test.c | 282 ++++++++++++++++++=
+++
> > >   5 files changed, 293 insertions(+)
> > >   create mode 100644 tools/testing/selftests/input/.gitignore
> > >   create mode 100644 tools/testing/selftests/input/Makefile
> > >   create mode 100644 tools/testing/selftests/input/config
> > >   create mode 100644 tools/testing/selftests/input/evioc-test.c
> > >
> > > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftes=
ts/Makefile
> > > index 90a62cf75008..29fc77168aa7 100644
> > > --- a/tools/testing/selftests/Makefile
> > > +++ b/tools/testing/selftests/Makefile
> > > @@ -28,6 +28,7 @@ TARGETS +=3D futex
> > >   TARGETS +=3D gpio
> > >   TARGETS +=3D hid
> > >   TARGETS +=3D intel_pstate
> > > +TARGETS +=3D input
> > >   TARGETS +=3D iommu
> > >   TARGETS +=3D ipc
> > >   TARGETS +=3D ir
> > > diff --git a/tools/testing/selftests/input/.gitignore b/tools/testing=
/selftests/input/.gitignore
> > > new file mode 100644
> > > index 000000000000..37f5dff3255b
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/input/.gitignore
> > > @@ -0,0 +1,2 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +evioc-test
> > > diff --git a/tools/testing/selftests/input/Makefile b/tools/testing/s=
elftests/input/Makefile
> > > new file mode 100644
> > > index 000000000000..031729be0628
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/input/Makefile
> > > @@ -0,0 +1,5 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +CFLAGS +=3D  -D_GNU_SOURCE -std=3Dgnu99 -Wl,-no-as-needed -Wall $(KH=
DR_INCLUDES)
> > > +
> > > +TEST_GEN_PROGS :=3D evioc-test
> > > +include ../lib.mk
> > > diff --git a/tools/testing/selftests/input/config b/tools/testing/sel=
ftests/input/config
> > > new file mode 100644
> > > index 000000000000..b7512f3e6d8d
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/input/config
> > > @@ -0,0 +1,3 @@
> > > +CONFIG_INPUT=3Dy
> > > +CONFIG_INPUT_EVDEV=3Dy
> > > +CONFIG_INPUT_UINPUT=3Dm
> > > diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testi=
ng/selftests/input/evioc-test.c
> > > new file mode 100644
> > > index 000000000000..4c0c8ebed378
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/input/evioc-test.c
> > > @@ -0,0 +1,282 @@
> > > +// SPDX-License-Identifier: MIT
> > > +/*
> > > + * Copyright =C2=A9 2023 Red Hat, Inc.
> > > + *
> > > + * Part of the code in this file is inspired and copied from the lib=
evdev wrapper library
> > > + * for evdev devices written by Peter Hutterer.
> > > + */
> > > +
> > > +#include <dirent.h>
> > > +#include <errno.h>
> > > +#include <fcntl.h>
> > > +#include <linux/uinput.h>
> > > +#include <poll.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <sys/stat.h>
> > > +#include <time.h>
> > > +#include <unistd.h>
> > > +
> > > +#include "../kselftest_harness.h"
> > > +
> > > +#define TEST_DEVICE_NAME "selftest input device"
> > > +
> > > +struct selftest_uinput {
> > > +     int uinput_fd; /** file descriptor to uinput */
> > > +     int evdev_fd; /** file descriptor to evdev */
> > > +     char *name; /** device name */
> > > +     char *syspath; /** /sys path */
> > > +     char *devnode; /** device node */
> > > +};
> > > +
> > > +static int is_event_device(const struct dirent *dent)
> > > +{
> > > +     return strncmp("event", dent->d_name, 5) =3D=3D 0;
> > > +}
> > > +
> > > +static char *fetch_device_node(const char *path)
> > > +{
> > > +     struct dirent **namelist;
> > > +     char *devnode =3D NULL;
> > > +     int ndev, i;
> > > +
> > > +     ndev =3D scandir(path, &namelist, is_event_device, alphasort);
> > > +     if (ndev <=3D 0)
> > > +             return NULL;
> > > +
> > > +     /* ndev should only ever be 1 */
> > > +
> > > +     for (i =3D 0; i < ndev; i++) {
> > > +             if (!devnode && asprintf(&devnode, "/dev/input/%s",
> > > +                                      namelist[i]->d_name) =3D=3D -1=
)
> > > +                     devnode =3D NULL;
> > > +             free(namelist[i]);
> > > +     }
> > > +
> > > +     free(namelist);
> > > +
> > > +     return devnode;
> > > +}
> > > +
> > > +static int is_input_device(const struct dirent *dent)
> > > +{
> > > +     return strncmp("input", dent->d_name, 5) =3D=3D 0;
> > > +}
> > > +
> > > +/*
> > > + * Device node is guessed based on the sysfs path, the sysfs path co=
ntains a
> > > + * eventN file, that corresponds to our /dev/input/eventN number.
> > > + */
> > > +static int fetch_syspath_and_devnode(struct selftest_uinput *uidev)
> > > +{
> > > +#define SYS_INPUT_DIR "/sys/devices/virtual/input/"
> > > +     struct dirent **namelist;
> > > +     int ndev, i;
> > > +     int rc;
> > > +     char buf[sizeof(SYS_INPUT_DIR) + 64] =3D SYS_INPUT_DIR;
> > > +
> > > +     rc =3D ioctl(uidev->uinput_fd,
> > > +                UI_GET_SYSNAME(sizeof(buf) - strlen(SYS_INPUT_DIR)),
> > > +                &buf[strlen(SYS_INPUT_DIR)]);
> > > +     if (rc !=3D -1) {
> > > +             uidev->syspath =3D strdup(buf);
> > > +             uidev->devnode =3D fetch_device_node(buf);
> > > +             return 0;
> > > +     }
> >
> > It's not obvious in the the code, but the above is pretty much all you
> > need. UI_GET_SYSNAME has been around 3.15 and if that fails you might a=
s
> > well bail out in this case. All the code below is the fallback that
> > pre-dates that ioctl.
> >

I see now, thanks. So I think we can simplify all this and make the
assumption that a recent kernel version will be used, so we can remove
the fallback code.

> > > +
> > > +     ndev =3D scandir(SYS_INPUT_DIR, &namelist, is_input_device, alp=
hasort);
> > > +     if (ndev <=3D 0)
> > > +             return -1;
> > > +
> > > +     for (i =3D 0; i < ndev; i++) {
> > > +             int fd, len;
> > > +
> > > +             rc =3D snprintf(buf, sizeof(buf), "%s%s/name", SYS_INPU=
T_DIR,
> > > +                           namelist[i]->d_name);
> > > +             if (rc < 0 || (size_t)rc >=3D sizeof(buf))
> > > +                     continue;
> > > +
> > > +             /* created within time frame */
> > > +             fd =3D open(buf, O_RDONLY);
> > > +             if (fd < 0)
> > > +                     continue;
> > > +
> > > +             len =3D read(fd, buf, sizeof(buf));
> > > +             close(fd);
> > > +             if (len <=3D 0)
> > > +                     continue;
> > > +
> > > +             buf[len - 1] =3D '\0'; /* file contains \n */
> > > +             if (strcmp(buf, uidev->name) =3D=3D 0) {
> > > +                     if (uidev->syspath) {
> > > +                             fprintf(stderr,
> > > +                                     "multiple identical devices fou=
nd. syspath is unreliable\n");
> > > +                             break;
> > > +                     }
> > > +
> > > +                     rc =3D snprintf(buf, sizeof(buf), "%s%s", SYS_I=
NPUT_DIR,
> > > +                                   namelist[i]->d_name);
> > > +
> > > +                     if (rc < 0 || (size_t)rc >=3D sizeof(buf)) {
> > > +                             fprintf(stderr,
> > > +                                     "Invalid syspath, syspath is un=
reliable\n");
> > > +                             break;
> > > +                     }
> > > +
> > > +                     uidev->syspath =3D strdup(buf);
> > > +                     uidev->devnode =3D fetch_device_node(buf);
> > > +             }
> > > +     }
> > > +
> > > +     for (i =3D 0; i < ndev; i++)
> > > +             free(namelist[i]);
> > > +     free(namelist);
> > > +
> > > +     return uidev->devnode ? 0 : -1;
> > > +#undef SYS_INPUT_DIR
> > > +}
> > > +
> > > +void selftest_uinput_destroy(struct selftest_uinput *uidev)
> > > +{
> > > +     if (!uidev)
> > > +             return;
> > > +
> > > +     if (uidev->uinput_fd >=3D 0)
> > > +             ioctl(uidev->uinput_fd, UI_DEV_DESTROY, NULL);
> > > +
> > > +     close(uidev->evdev_fd);
> > > +     close(uidev->uinput_fd);
> > > +
> > > +     free(uidev->syspath);
> > > +     free(uidev->devnode);
> > > +     free(uidev->name);
> > > +     free(uidev);
> > > +}
> > > +
> > > +int selftest_uinput_create_device(struct selftest_uinput **uidev, ..=
.)
> > > +{
> > > +     struct selftest_uinput *new_device;
> > > +     struct uinput_setup setup;
> > > +     va_list args;
> > > +     int rc, fd;
> > > +     int type;
> > > +
> > > +     new_device =3D calloc(1, sizeof(struct selftest_uinput));
> > > +     if (!new_device)
> > > +             return -ENOMEM;
> > > +
> > > +     memset(&setup, 0, sizeof(setup));
> > > +     strncpy(setup.name, TEST_DEVICE_NAME, UINPUT_MAX_NAME_SIZE - 1)=
;
> > > +     setup.id.vendor =3D 0x1234; /* sample vendor */
> > > +     setup.id.product =3D 0x5678; /* sample product */
> > > +     setup.id.bustype =3D BUS_USB;
> > > +
> > > +     fd =3D open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> > > +     if (fd < 0) {
> > > +             fprintf(stderr, "cannot open uinput (%d): %m\n", errno)=
;
> > > +             goto error;
> > > +     }
> > > +
> > > +     va_start(args, uidev);
> > > +     rc =3D 0;
> > > +     do {
> > > +             type =3D va_arg(args, int);
> > > +             if (type =3D=3D -1)
> > > +                     break;
> > > +             rc =3D ioctl(fd, UI_SET_EVBIT, type);
> > > +     } while (rc =3D=3D 0);
> > > +     va_end(args);
> > > +
> > > +     rc =3D ioctl(fd, UI_DEV_SETUP, &setup);
> > > +     if (rc =3D=3D -1)
> > > +             goto error;
> > > +
> > > +     rc =3D ioctl(fd, UI_DEV_CREATE, NULL);
> > > +     if (rc =3D=3D -1)
> > > +             goto error;
> > > +
> > > +     new_device->name =3D strdup(TEST_DEVICE_NAME);
> > > +     new_device->uinput_fd =3D fd;
> > > +
> > > +     if (fetch_syspath_and_devnode(new_device) =3D=3D -1) {
> > > +             fprintf(stderr, "unable to fetch syspath or device node=
.\n");
> > > +             errno =3D ENODEV;
> > > +             goto error;
> > > +     }
> > > +
> > > +     fd =3D open(new_device->devnode, O_RDONLY);
> > > +     if (fd < 0) {
> > > +             fprintf(stderr, "cannot open uinput (%d): %m\n", errno)=
;
> > > +             goto error;
> > > +     }
> > > +     new_device->evdev_fd =3D fd;
> > > +
> > > +     *uidev =3D new_device;
> > > +
> > > +     return 0;
> > > +
> > > +error:
> > > +     rc =3D -errno;
> > > +     selftest_uinput_destroy(new_device);
> > > +     return rc;
> > > +}
> > > +
> > > +const char *selftest_uinput_get_devnode(struct selftest_uinput *uide=
v)
> > > +{
> > > +     return uidev->devnode;
> > > +}
> > > +
> > > +TEST(eviocgname_get_device_name)
> > > +{
> > > +     struct selftest_uinput *uidev;
> > > +     char buf[256];
> > > +     int rc;
> > > +
> > > +     rc =3D selftest_uinput_create_device(&uidev);
> > > +     ASSERT_EQ(0, rc);
> > > +     ASSERT_NE(NULL, uidev);
> > > +
> > > +     memset(buf, 0, sizeof(buf));
> > > +     /* ioctl to get the name */
> > > +     rc =3D ioctl(uidev->evdev_fd, EVIOCGNAME(sizeof(buf) - 1), buf)=
;
> > > +     ASSERT_GE(rc, 0);
> > > +     ASSERT_STREQ(TEST_DEVICE_NAME, buf);
> > > +
> > > +     selftest_uinput_destroy(uidev);
> > > +}
> > > +
> > > +TEST(eviocgrep_get_repeat_settings)
> > > +{
> > > +     struct selftest_uinput *uidev;
> > > +     int rep_values[2];
> > > +     int rc;
> > > +
> > > +     memset(rep_values, 0, sizeof(rep_values));
> > > +
> > > +     rc =3D selftest_uinput_create_device(&uidev);
> > > +     ASSERT_EQ(0, rc);
> > > +     ASSERT_NE(NULL, uidev);
> > > +
> > > +     /* ioctl to get the repeat rates values */
> > > +     rc =3D ioctl(uidev->evdev_fd, EVIOCSREP, rep_values);
> >
> > EVIOCSREP *sets* the repeat values

My intention was to use EVIOCGREP here instead of 'S', so instead of
fixing the comment I'd fix the ioctl. Thanks.

> >
> >
> > > +     /* should fail because EV_REP is not set */
> > > +     ASSERT_EQ(-1, rc);
> > > +
> > > +     selftest_uinput_destroy(uidev);
> > > +
> > > +     rc =3D selftest_uinput_create_device(&uidev, EV_REP);
> > This needs a -1 terminator, otherwise you're va-argsing into oblivion.
> >

Right, I'd add in the next version.

> >
> > > +     ASSERT_EQ(0, rc);
> > > +     ASSERT_NE(NULL, uidev);
> > > +
> > > +     /* ioctl to get the repeat rates values */
> > > +     rc =3D ioctl(uidev->evdev_fd, EVIOCGREP, rep_values);
> > > +     ASSERT_EQ(0, rc);
> > > +     /* should get the default delay an period values set by the ker=
nel */
> >
> > typo -> "and"
> >

Fixed in the next version.

> > > +     ASSERT_EQ(rep_values[0], 250);
> > > +     ASSERT_EQ(rep_values[1], 33);
> >
> > So, interestingly enough you don't actually test setting the value here=
.
> > The EV_REP bit is set during device creation and you check the default
> > values but you don't call EVIOCSREP to change the values - which AFAIU
> > was the initial intention of these tests?
> >
>

Yes, one of the main purposes is to test EVIOC**S**REP, but I skipped
and sent a first version only testing the EVIOC**G**REP test to catch
feedback from the mailing list.  In the next version I'll include both
tests, for getting and setting the repeat values (I think it makes
sense).

Cheers,
   Enric
>
> > Cheers,
> >    PEter
> >
> > > +
> > > +     selftest_uinput_destroy(uidev);
> > > +}
> > > +
> > > +TEST_HARNESS_MAIN
