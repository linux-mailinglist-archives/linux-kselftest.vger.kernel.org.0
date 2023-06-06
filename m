Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB7723AFE
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 10:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjFFIIS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 04:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjFFIIP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 04:08:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C18FB1;
        Tue,  6 Jun 2023 01:08:13 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95AC16606EAC;
        Tue,  6 Jun 2023 09:08:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686038892;
        bh=EkjjYZ7jfzu2WSv/aPnVTWSTppGe3lpNyYhIxcgQdVI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=L0LJVR0qO5bwuA+yY+355SF2SaU+MUGOAd1F6KpYcgz/clnmP2sx2u/Lp5qLGLV5a
         GlK73uITcCT2M5VaJmJbEs2w1jNEYgIi8nDW3gzc4iujWHwjsIdmSg/IKFFErypY/I
         qzCq8wIsUuti6tOMVupwrjbaJ3wTVPglWreS+2ZuuOFoI0NxcqeP8R7lAvsuNxQ+b5
         BGn4mhrm41TIyMgf0Gmpom/L52JnilRu1WFJ1TEh67rYODqpmhGnfrT5vs112hHObC
         nIA0qVIZ/cYCT9C2GIwiO+bWXa30SFeKr8Xn+XMdzKmZncAZFANc8GES8tmi3mek09
         iy5QEhVixk2qQ==
Message-ID: <399f442d-14f4-e99c-f9ce-342581984796@collabora.com>
Date:   Tue, 6 Jun 2023 13:08:05 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Dana Elfassy <delfassy@redhat.com>,
        linux-input@vger.kernel.org, phuttere@redhat.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] selftests/input: Introduce basic tests for evdev
 ioctls
Content-Language: en-US
To:     Enric Balletbo i Serra <eballetbo@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230530102627.87284-1-eballetbo@kernel.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230530102627.87284-1-eballetbo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/30/23 3:26 PM, Enric Balletbo i Serra wrote:
> This provides a basic infrastructure for the creation of tests for the evdev
> interface. Most of this code is adapted from the libevdev wrapper library. While
> most of evdev ioctls are covered and tested using libevdev tests there are some
> evdev ioctls that aren't because are not supported (and will not be supported)
> by libevdev [1]. So, adding, at least those tests, would make sense.
> 
> The test creates an uinput device (and an evdev device) so you can
> call the wanted ioctl from userspace. So, to run those tests you need
> to have support for uinput and evdev as well.
> 
> [1] For example, libevdev doesn't support setting EV_REP because it's inherently
> racy - one libevdev context to set those values via the ioctl would cause all
> other libevdev contexts on the same device to be out of sync. Since we do not
> get notifications when the values changed, libevdev's buffered values for EV_REP
> will remain whatever they were initially.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@kernel.org>
Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> Test output:
> 
> 	TAP version 13
> 	1..3
> 	# Starting 3 tests from 1 test cases.
> 	#  RUN           global.eviocgname_get_device_name ...
> 	#            OK  global.eviocgname_get_device_name
> 	ok 1 global.eviocgname_get_device_name
> 	#  RUN           global.eviocgrep_get_repeat_settings ...
> 	#            OK  global.eviocgrep_get_repeat_settings
> 	ok 2 global.eviocgrep_get_repeat_settings
> 	#  RUN           global.eviocsrep_set_repeat_settings ...
> 	#            OK  global.eviocsrep_set_repeat_settings
> 	ok 3 global.eviocsrep_set_repeat_settings
> 	# PASSED: 3 / 3 tests passed.
> 	# Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
>  tools/testing/selftests/Makefile           |   1 +
>  tools/testing/selftests/input/.gitignore   |   2 +
>  tools/testing/selftests/input/Makefile     |   5 +
>  tools/testing/selftests/input/config       |   3 +
>  tools/testing/selftests/input/evioc-test.c | 259 +++++++++++++++++++++
>  5 files changed, 270 insertions(+)
>  create mode 100644 tools/testing/selftests/input/.gitignore
>  create mode 100644 tools/testing/selftests/input/Makefile
>  create mode 100644 tools/testing/selftests/input/config
>  create mode 100644 tools/testing/selftests/input/evioc-test.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 90a62cf75008..29fc77168aa7 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -28,6 +28,7 @@ TARGETS += futex
>  TARGETS += gpio
>  TARGETS += hid
>  TARGETS += intel_pstate
> +TARGETS += input
>  TARGETS += iommu
>  TARGETS += ipc
>  TARGETS += ir
> diff --git a/tools/testing/selftests/input/.gitignore b/tools/testing/selftests/input/.gitignore
> new file mode 100644
> index 000000000000..37f5dff3255b
> --- /dev/null
> +++ b/tools/testing/selftests/input/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +evioc-test
> diff --git a/tools/testing/selftests/input/Makefile b/tools/testing/selftests/input/Makefile
> new file mode 100644
> index 000000000000..031729be0628
> --- /dev/null
> +++ b/tools/testing/selftests/input/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS +=  -D_GNU_SOURCE -std=gnu99 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
> +
> +TEST_GEN_PROGS := evioc-test
> +include ../lib.mk
> diff --git a/tools/testing/selftests/input/config b/tools/testing/selftests/input/config
> new file mode 100644
> index 000000000000..b7512f3e6d8d
> --- /dev/null
> +++ b/tools/testing/selftests/input/config
> @@ -0,0 +1,3 @@
> +CONFIG_INPUT=y
> +CONFIG_INPUT_EVDEV=y
> +CONFIG_INPUT_UINPUT=m
> diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
> new file mode 100644
> index 000000000000..1b951d41ee47
> --- /dev/null
> +++ b/tools/testing/selftests/input/evioc-test.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2023 Red Hat, Inc.
> + *
> + * Part of the code in this file is inspired and copied from the libevdev wrapper library
> + * for evdev devices written by Peter Hutterer.
> + */
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/uinput.h>
> +#include <poll.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +#include "../kselftest_harness.h"
> +
> +#define TEST_DEVICE_NAME "selftest input device"
> +
> +struct selftest_uinput {
> +	int uinput_fd; /** file descriptor to uinput */
> +	int evdev_fd; /** file descriptor to evdev */
> +	char *name; /** device name */
> +	char *syspath; /** /sys path */
> +	char *devnode; /** device node */
> +};
> +
> +static int is_event_device(const struct dirent *dent)
> +{
> +	return strncmp("event", dent->d_name, 5) == 0;
> +}
> +
> +static char *fetch_device_node(const char *path)
> +{
> +	struct dirent **namelist;
> +	char *devnode = NULL;
> +	int ndev, i;
> +
> +	ndev = scandir(path, &namelist, is_event_device, alphasort);
> +	if (ndev <= 0)
> +		return NULL;
> +
> +	/* ndev should only ever be 1 */
> +
> +	for (i = 0; i < ndev; i++) {
> +		if (!devnode && asprintf(&devnode, "/dev/input/%s",
> +					 namelist[i]->d_name) == -1)
> +			devnode = NULL;
> +		free(namelist[i]);
> +	}
> +
> +	free(namelist);
> +
> +	return devnode;
> +}
> +
> +static int fetch_syspath_and_devnode(struct selftest_uinput *uidev)
> +{
> +#define SYS_INPUT_DIR "/sys/devices/virtual/input/"
> +	char buf[sizeof(SYS_INPUT_DIR) + 64] = SYS_INPUT_DIR;
> +	int rc;
> +
> +	rc = ioctl(uidev->uinput_fd,
> +		   UI_GET_SYSNAME(sizeof(buf) - strlen(SYS_INPUT_DIR)),
> +		   &buf[strlen(SYS_INPUT_DIR)]);
> +	if (rc == -1) {
> +		fprintf(stderr, "cannot get the sysfs name of the uinput device (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	uidev->syspath = strdup(buf);
> +	uidev->devnode = fetch_device_node(buf);
> +
> +	return uidev->devnode ? 0 : -1;
> +#undef SYS_INPUT_DIR
> +}
> +
> +static void selftest_uinput_destroy(struct selftest_uinput *uidev)
> +{
> +	if (!uidev)
> +		return;
> +
> +	if (uidev->uinput_fd >= 0)
> +		ioctl(uidev->uinput_fd, UI_DEV_DESTROY, NULL);
> +
> +	close(uidev->evdev_fd);
> +	close(uidev->uinput_fd);
> +
> +	free(uidev->syspath);
> +	free(uidev->devnode);
> +	free(uidev->name);
> +	free(uidev);
> +}
> +
> +static int selftest_uinput_create_device(struct selftest_uinput **uidev, ...)
> +{
> +	struct selftest_uinput *new_device;
> +	struct uinput_setup setup;
> +	va_list args;
> +	int rc, fd;
> +	int type;
> +
> +	new_device = calloc(1, sizeof(struct selftest_uinput));
> +	if (!new_device)
> +		return -ENOMEM;
> +
> +	memset(&setup, 0, sizeof(setup));
> +	strncpy(setup.name, TEST_DEVICE_NAME, UINPUT_MAX_NAME_SIZE - 1);
> +	setup.id.vendor = 0x1234; /* sample vendor */
> +	setup.id.product = 0x5678; /* sample product */
> +	setup.id.bustype = BUS_USB;
> +
> +	fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> +	if (fd < 0) {
> +		fprintf(stderr, "cannot open uinput (%d): %m\n", errno);
> +		goto error;
> +	}
> +
> +	va_start(args, uidev);
> +	rc = 0;
> +	do {
> +		type = va_arg(args, int);
> +		if (type == -1)
> +			break;
> +		rc = ioctl(fd, UI_SET_EVBIT, type);
> +	} while (rc == 0);
> +	va_end(args);
> +
> +	rc = ioctl(fd, UI_DEV_SETUP, &setup);
> +	if (rc == -1)
> +		goto error;
> +
> +	rc = ioctl(fd, UI_DEV_CREATE, NULL);
> +	if (rc == -1)
> +		goto error;
> +
> +	new_device->name = strdup(TEST_DEVICE_NAME);
> +	new_device->uinput_fd = fd;
> +
> +	if (fetch_syspath_and_devnode(new_device) == -1) {
> +		fprintf(stderr, "unable to fetch syspath or device node.\n");
> +		errno = ENODEV;
> +		goto error;
> +	}
> +
> +	fd = open(new_device->devnode, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "cannot open uinput (%d): %m\n", errno);
> +		goto error;
> +	}
> +	new_device->evdev_fd = fd;
> +
> +	*uidev = new_device;
> +
> +	return 0;
> +
> +error:
> +	rc = -errno;
> +	selftest_uinput_destroy(new_device);
> +	return rc;
> +}
> +
> +TEST(eviocgname_get_device_name)
> +{
> +	struct selftest_uinput *uidev;
> +	char buf[256];
> +	int rc;
> +
> +	rc = selftest_uinput_create_device(&uidev);
> +	ASSERT_EQ(0, rc);
> +	ASSERT_NE(NULL, uidev);
> +
> +	memset(buf, 0, sizeof(buf));
> +	/* ioctl to get the name */
> +	rc = ioctl(uidev->evdev_fd, EVIOCGNAME(sizeof(buf) - 1), buf);
> +	ASSERT_GE(rc, 0);
> +	ASSERT_STREQ(TEST_DEVICE_NAME, buf);
> +
> +	selftest_uinput_destroy(uidev);
> +}
> +
> +TEST(eviocgrep_get_repeat_settings)
> +{
> +	struct selftest_uinput *uidev;
> +	int rep_values[2];
> +	int rc;
> +
> +	memset(rep_values, 0, sizeof(rep_values));
> +
> +	rc = selftest_uinput_create_device(&uidev);
> +	ASSERT_EQ(0, rc);
> +	ASSERT_NE(NULL, uidev);
> +
> +	/* ioctl to get the repeat rates values */
> +	rc = ioctl(uidev->evdev_fd, EVIOCGREP, rep_values);
> +	/* should fail because EV_REP is not set */
> +	ASSERT_EQ(-1, rc);
> +
> +	selftest_uinput_destroy(uidev);
> +
> +	rc = selftest_uinput_create_device(&uidev, EV_REP, -1);
> +	ASSERT_EQ(0, rc);
> +	ASSERT_NE(NULL, uidev);
> +
> +	/* ioctl to get the repeat rates values */
> +	rc = ioctl(uidev->evdev_fd, EVIOCGREP, rep_values);
> +	ASSERT_EQ(0, rc);
> +	/* should get the default delay and period values set by the kernel */
> +	ASSERT_EQ(rep_values[0], 250);
> +	ASSERT_EQ(rep_values[1], 33);
> +
> +	selftest_uinput_destroy(uidev);
> +}
> +
> +TEST(eviocsrep_set_repeat_settings)
> +{
> +	struct selftest_uinput *uidev;
> +	int rep_values[2];
> +	int rc;
> +
> +	memset(rep_values, 0, sizeof(rep_values));
> +
> +	rc = selftest_uinput_create_device(&uidev);
> +	ASSERT_EQ(0, rc);
> +	ASSERT_NE(NULL, uidev);
> +
> +	/* ioctl to set the repeat rates values */
> +	rc = ioctl(uidev->evdev_fd, EVIOCSREP, rep_values);
> +	/* should fail because EV_REP is not set */
> +	ASSERT_EQ(-1, rc);
> +
> +	selftest_uinput_destroy(uidev);
> +
> +	rc = selftest_uinput_create_device(&uidev, EV_REP, -1);
> +	ASSERT_EQ(0, rc);
> +	ASSERT_NE(NULL, uidev);
> +
> +	/* ioctl to set the repeat rates values */
> +	rep_values[0] = 500;
> +	rep_values[1] = 200;
> +	rc = ioctl(uidev->evdev_fd, EVIOCSREP, rep_values);
> +	ASSERT_EQ(0, rc);
> +
> +	/* ioctl to get the repeat rates values */
> +	rc = ioctl(uidev->evdev_fd, EVIOCGREP, rep_values);
> +	ASSERT_EQ(0, rc);
> +	/* should get the delay and period values set previously */
> +	ASSERT_EQ(rep_values[0], 500);
> +	ASSERT_EQ(rep_values[1], 200);
> +
> +	selftest_uinput_destroy(uidev);
> +}
> +
> +TEST_HARNESS_MAIN

-- 
BR,
Muhammad Usama Anjum
