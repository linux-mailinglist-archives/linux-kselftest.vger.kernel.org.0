Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44B715535
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjE3F46 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjE3F45 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5D5BF
        for <linux-kselftest@vger.kernel.org>; Mon, 29 May 2023 22:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685426171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5xAIk+tyO5Co6CVvnP54e7CcztqWX9GwwzQC+Rna6Q=;
        b=eHUQc6VATbFbf50RIZshU9TPK5Y9u9u7h8rexpnMc+OHQUt+rrhxTei7QJPOQgBfvS3Ecw
        h3vxFOsS6zkaCvyRq3dGD/qGKLyMXOsXeGYQBEfHb7YOa8NlDUihwvcEKHl5lMNDXOjxiK
        lnzmsRdlGGorXwQzf1DpmFKrgyCrNRw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649--OqLglbQMjmIb_WVgtk6uQ-1; Tue, 30 May 2023 01:56:10 -0400
X-MC-Unique: -OqLglbQMjmIb_WVgtk6uQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b020864ae2so36104345ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 May 2023 22:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685426169; x=1688018169;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5xAIk+tyO5Co6CVvnP54e7CcztqWX9GwwzQC+Rna6Q=;
        b=ZgcnbK0uEov19iKX9hXy2htipJyoELYGSiePZJsuBf51XDi6gmdMJYv9lIkhGtPSeS
         pZQABhYKiGp3odxDrXZKLQsGIZp7Kh8aFm8ZxN0WBYzsjWuqyt7pzV7w/IjJqiNxx7mh
         YpJeRlZdl5fbDCSCcH3qEndcafR4TCgDDZdS4aJet7BHIsD/L3XaWNP5P9LIaCeF2g8j
         sne4tzPUA007+p8qDb6oauv9U+lMzcnb/Q6p1RIHzJm4YdIiy2zIcKavZjXdvr5U8nLG
         ZQm95wMTMYa4ku4fThhegNxJ4ouyCu794SXCPaT+xy+eybhVcLAeA+f1EaJm8INiyxLG
         7/og==
X-Gm-Message-State: AC+VfDzwaYQYudXtGpc91XDQhndxNlQEqBZK0XmO6tWAqAV5j1aLgvcT
        NJ5QzCptPbB++QWYKxYG1cRX66iPM30i3DgGicyyQPF36d3NyU1Tu9y4d+Dhe+RdyEHDteyOWnF
        cERKw3gbtHS4LdGLfnZsXkg/2Brm/
X-Received: by 2002:a17:902:c948:b0:1af:e2f2:1cce with SMTP id i8-20020a170902c94800b001afe2f21ccemr1747470pla.38.1685426169375;
        Mon, 29 May 2023 22:56:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FVbMU34Matg8cSgp0qbaukoDaBW11LQDHwlME8PPH/D0AreqR7CFAVPxmaSTUZUdmRcFjJA==
X-Received: by 2002:a17:902:c948:b0:1af:e2f2:1cce with SMTP id i8-20020a170902c94800b001afe2f21ccemr1747454pla.38.1685426169066;
        Mon, 29 May 2023 22:56:09 -0700 (PDT)
Received: from [192.168.1.240] (117-20-69-139.751445.bne.nbn.aussiebb.net. [117.20.69.139])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b001b03c225c0asm3815592plh.221.2023.05.29.22.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 22:56:08 -0700 (PDT)
Message-ID: <8f4a440e-855c-76d0-62fe-82d35c002fc5@redhat.com>
Date:   Tue, 30 May 2023 15:56:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     eballetbo@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Dana Elfassy <delfassy@redhat.com>,
        linux-input@vger.kernel.org, phuttere@redhat.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <20230526082205.6297-1-eballetbo@kernel.org>
From:   Peter Hutterer <peter.hutterer@redhat.com>
Subject: Re: [PATCH] selftests/input: Introduce basic tests for evdev ioctls
In-Reply-To: <20230526082205.6297-1-eballetbo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Enric,

On 26/5/23 18:22, eballetbo@kernel.org wrote:
> From: Enric Balletbo i Serra <eballetbo@kernel.org>
> 
> This provides a basic infrastructure for the creation of tests for the evdev
> interface. Most of this is code is adapted from the libevdev wrapper
> library. While most of evdev ioctls are covered and tested using
> libevdev tests there are some evdev ioctls that aren't because are not
> supported (and will not be supported) by libevdev. So, adding, at least
> those tests, would make sense.

for the archives: libevdev doesn't support setting EV_REP because it's 
inherently racy - one libevdev context to set those values via the ioctl 
would cause all other libevdev contexts on the same device to be out of 
sync. Since we do not get notifications when the values changed, 
libevdev's buffered values for EV_REP will remain whatever they were 
initially.

The only way around that would be setting it via udev on plug, but that 
udev doesnt need/want the libevdev dependency.

plus, afaik most or all libevdev's users ignore kernel key repeats anyway :)

> 
> The test creates an uinput device (and an evdev device) so you can
> call the wanted ioctl from userspace. So, to run those tests you need
> to have support for uinput and evdev as well.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@kernel.org>
> ---
>   tools/testing/selftests/Makefile           |   1 +
>   tools/testing/selftests/input/.gitignore   |   2 +
>   tools/testing/selftests/input/Makefile     |   5 +
>   tools/testing/selftests/input/config       |   3 +
>   tools/testing/selftests/input/evioc-test.c | 282 +++++++++++++++++++++
>   5 files changed, 293 insertions(+)
>   create mode 100644 tools/testing/selftests/input/.gitignore
>   create mode 100644 tools/testing/selftests/input/Makefile
>   create mode 100644 tools/testing/selftests/input/config
>   create mode 100644 tools/testing/selftests/input/evioc-test.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 90a62cf75008..29fc77168aa7 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -28,6 +28,7 @@ TARGETS += futex
>   TARGETS += gpio
>   TARGETS += hid
>   TARGETS += intel_pstate
> +TARGETS += input
>   TARGETS += iommu
>   TARGETS += ipc
>   TARGETS += ir
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
> index 000000000000..4c0c8ebed378
> --- /dev/null
> +++ b/tools/testing/selftests/input/evioc-test.c
> @@ -0,0 +1,282 @@
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
> +static int is_input_device(const struct dirent *dent)
> +{
> +	return strncmp("input", dent->d_name, 5) == 0;
> +}
> +
> +/*
> + * Device node is guessed based on the sysfs path, the sysfs path contains a
> + * eventN file, that corresponds to our /dev/input/eventN number.
> + */
> +static int fetch_syspath_and_devnode(struct selftest_uinput *uidev)
> +{
> +#define SYS_INPUT_DIR "/sys/devices/virtual/input/"
> +	struct dirent **namelist;
> +	int ndev, i;
> +	int rc;
> +	char buf[sizeof(SYS_INPUT_DIR) + 64] = SYS_INPUT_DIR;
> +
> +	rc = ioctl(uidev->uinput_fd,
> +		   UI_GET_SYSNAME(sizeof(buf) - strlen(SYS_INPUT_DIR)),
> +		   &buf[strlen(SYS_INPUT_DIR)]);
> +	if (rc != -1) {
> +		uidev->syspath = strdup(buf);
> +		uidev->devnode = fetch_device_node(buf);
> +		return 0;
> +	}

It's not obvious in the the code, but the above is pretty much all you 
need. UI_GET_SYSNAME has been around 3.15 and if that fails you might as 
well bail out in this case. All the code below is the fallback that 
pre-dates that ioctl.

> +
> +	ndev = scandir(SYS_INPUT_DIR, &namelist, is_input_device, alphasort);
> +	if (ndev <= 0)
> +		return -1;
> +
> +	for (i = 0; i < ndev; i++) {
> +		int fd, len;
> +
> +		rc = snprintf(buf, sizeof(buf), "%s%s/name", SYS_INPUT_DIR,
> +			      namelist[i]->d_name);
> +		if (rc < 0 || (size_t)rc >= sizeof(buf))
> +			continue;
> +
> +		/* created within time frame */
> +		fd = open(buf, O_RDONLY);
> +		if (fd < 0)
> +			continue;
> +
> +		len = read(fd, buf, sizeof(buf));
> +		close(fd);
> +		if (len <= 0)
> +			continue;
> +
> +		buf[len - 1] = '\0'; /* file contains \n */
> +		if (strcmp(buf, uidev->name) == 0) {
> +			if (uidev->syspath) {
> +				fprintf(stderr,
> +					"multiple identical devices found. syspath is unreliable\n");
> +				break;
> +			}
> +
> +			rc = snprintf(buf, sizeof(buf), "%s%s", SYS_INPUT_DIR,
> +				      namelist[i]->d_name);
> +
> +			if (rc < 0 || (size_t)rc >= sizeof(buf)) {
> +				fprintf(stderr,
> +					"Invalid syspath, syspath is unreliable\n");
> +				break;
> +			}
> +
> +			uidev->syspath = strdup(buf);
> +			uidev->devnode = fetch_device_node(buf);
> +		}
> +	}
> +
> +	for (i = 0; i < ndev; i++)
> +		free(namelist[i]);
> +	free(namelist);
> +
> +	return uidev->devnode ? 0 : -1;
> +#undef SYS_INPUT_DIR
> +}
> +
> +void selftest_uinput_destroy(struct selftest_uinput *uidev)
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
> +int selftest_uinput_create_device(struct selftest_uinput **uidev, ...)
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
> +const char *selftest_uinput_get_devnode(struct selftest_uinput *uidev)
> +{
> +	return uidev->devnode;
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
> +	rc = ioctl(uidev->evdev_fd, EVIOCSREP, rep_values);

EVIOCSREP *sets* the repeat values


> +	/* should fail because EV_REP is not set */
> +	ASSERT_EQ(-1, rc);
> +
> +	selftest_uinput_destroy(uidev);
> +
> +	rc = selftest_uinput_create_device(&uidev, EV_REP);
This needs a -1 terminator, otherwise you're va-argsing into oblivion.


> +	ASSERT_EQ(0, rc);
> +	ASSERT_NE(NULL, uidev);
> +
> +	/* ioctl to get the repeat rates values */
> +	rc = ioctl(uidev->evdev_fd, EVIOCGREP, rep_values);
> +	ASSERT_EQ(0, rc);
> +	/* should get the default delay an period values set by the kernel */

typo -> "and"

> +	ASSERT_EQ(rep_values[0], 250);
> +	ASSERT_EQ(rep_values[1], 33);

So, interestingly enough you don't actually test setting the value here. 
The EV_REP bit is set during device creation and you check the default 
values but you don't call EVIOCSREP to change the values - which AFAIU 
was the initial intention of these tests?

Cheers,
   PEter

> +
> +	selftest_uinput_destroy(uidev);
> +}
> +
> +TEST_HARNESS_MAIN

