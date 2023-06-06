Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB7D723695
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 07:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjFFFEm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 01:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFFFEl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 01:04:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454F6196;
        Mon,  5 Jun 2023 22:04:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 26F2B3200A93;
        Tue,  6 Jun 2023 01:04:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 01:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1686027878; x=1686114278; bh=WP
        3yKSXu55VaU9s/qiTySC2G3aZBpjBEicEtRyfVroM=; b=R2JYD0ZHbVmfBBIKFN
        RBlHtlXT3VutVokCtWVUOHhNkBrqk8JufwnmB8D3dpvKOVE2hXg95sXRLPF369am
        TL/eCHMfsSd53jpz7zbYjZe/uSzPybJMm9u8sTNxf+dT+h3ffWAI/gvEScZfIM+G
        RGfD8u8kPyQCFhIG4daSBQnyV7ug5a1xVDe/mijGPR6/FCLPGsY3rNmTbhjlDQ1V
        bRxLeyY/mkCi6L1wREyjLA4PRuNEOKNvvNFf0qioM50T5MlQJcpGinpWUBX1Dbtk
        Mv9mzWu2oEYTB0hBXpA8dUl/5n45ZdWTBFT7If4s1rq5NDmYmuCMyBIToYfuzQW+
        kVQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686027878; x=1686114278; bh=WP3yKSXu55VaU
        9s/qiTySC2G3aZBpjBEicEtRyfVroM=; b=YLpyzhIdzUf9Gc39Njz/Lnyf4Ezbm
        MOkqio4XC34ZwDF6AXj1PFUjLZpEhDQSRGdZKOCTr4M6+s2q8engIw3/cdI693aT
        o+gq08KkEPBi0nm2VnZd8yVUloGzj1m6UD66Iz+WMITerOYuOWe/0OqyYzKiVvee
        SVoc1hy1Y3vUy4P6r8MjrUcAcffKfJr0lJqyHOK7eFs8IBuKhC5e17QvclCWoxQE
        jofxPaFrItDZOe/IVm7akvT/LvO7oP3iwqgRREekvtrOxJdGPCKNJmITgn67Hjlb
        aJXGb1Cf8ci/sLMVgLFRiRKjAM/eEP2ZTpRMBdU9xgKAT2gJUmtmzSZSw==
X-ME-Sender: <xms:Zr5-ZIpvRqMcynQqaXbPnDytAE4bWHhiAuWFZTjB_i-o08IIhnZaLw>
    <xme:Zr5-ZOqVYZTmUq0k9l7fzT2VL3GvJATnYlIfzFJmbr4rTbqo7mRIRLCBErKD0dHiI
    vgrXnqdduQzpjGbUyA>
X-ME-Received: <xmr:Zr5-ZNNoVfGcpoAor35pBytvOjcGDwASD29xZyzE0cmuY-sywQ3CQWpx2AKVQVY935M-aN8Q-ex-AcYo0MV1HJKua8mUPioshoOX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeekvdekgeehfeejgfdvudffhfevheejffevgfeigfek
    hfduieefudfgtedugfetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:Zr5-ZP6f8l4EYgNnJG_hd3-aBqbXrQPP8oKDDwaDAofR3S2IF59NnA>
    <xmx:Zr5-ZH4XeGfdXfH7aBvediKrKISKfUG1Kt2nmi4SYH1XdGLUtpAIXg>
    <xmx:Zr5-ZPjQS2C8gRRDSqy6Mi_9k-V9W5JyNDdeB7KeyGcXHJDC_F8omg>
    <xmx:Zr5-ZBsszMhPYYAdDH8Zs9Ar5rSmkLhNbCXvvNsokELd_MH-M3kVbQ>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 01:04:34 -0400 (EDT)
Date:   Tue, 6 Jun 2023 15:04:31 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Enric Balletbo i Serra <eballetbo@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Dana Elfassy <delfassy@redhat.com>,
        linux-input@vger.kernel.org, phuttere@redhat.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] selftests/input: Introduce basic tests for evdev
 ioctls
Message-ID: <20230606050431.GA3789903@quokka>
References: <20230530102627.87284-1-eballetbo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530102627.87284-1-eballetbo@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 30, 2023 at 12:26:27PM +0200, Enric Balletbo i Serra wrote:
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

thanks, this mostly LGTM but there's still a bug left in the vararg
handling.

[...]

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

nitpick: none of name, syspath, devnode are used in the tests and it's
likely they'll never need to be so there's no reason to strdup them
here. You could change fetch_syspath_and_devnode() to open_devnode() and
return the opened fd, meaning you can reduce the code even more.

[...]

> +
> +TEST(eviocgname_get_device_name)
> +{
> +	struct selftest_uinput *uidev;
> +	char buf[256];
> +	int rc;
> +
> +	rc = selftest_uinput_create_device(&uidev);

this one and the others without extra arguments need to be:

	rc = selftest_uinput_create_device(&uidev, -1);

otherwise the vararg loop is going to keep the room warm for no reason.

Cheers,
  Peter

 
