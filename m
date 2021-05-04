Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC4D372FD2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 May 2021 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhEDShI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 May 2021 14:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhEDShI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 May 2021 14:37:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425AEC061574
        for <linux-kselftest@vger.kernel.org>; Tue,  4 May 2021 11:36:13 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t22so8287371pgu.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 May 2021 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=55w7T2sV+Xo6jhtEWO67o8KmaHssUdC9yij/eIhn6tA=;
        b=g0u5lhzRmf0TZmK+1IUsZ5/8UR/NFxlZrXEvH8JFYy7gW2sztuzlW75oDTAOP0Oros
         6wTQkctB6aAzWHj9OdFvmEnJLUwWZ1NoDYKt6Kv6THJaIZAEdUaEkflW3Fj8+oGdlZ1L
         uhLbMq2caPKeHUTbE+djFuMSGaE/xqGtnMXUMqENji1OQZscX2hmf6hZXpnW8y+pOMpZ
         kpitSrBzdlvGKwMhs4NLYAFQFE9th8J4DtgWG5kwRHDUuC9eL8nork7OL75I3iDUaYdy
         BS34Fnt7hhLa2X02GswRs+RM4NrSXF4BD74gj8wUbiQbDcjo9TJs0X23Zzc+YVMI4dNy
         N+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=55w7T2sV+Xo6jhtEWO67o8KmaHssUdC9yij/eIhn6tA=;
        b=AWtI34q68mU0lh9J4XtI1F15VvtJpwWaJpAXY6Wi1si3IaJMtfNqCGEyz0Qr6STTWp
         ioZHGXQesN7Va1wx3Vd1dgNGn0uzvpShCuf6XIyNKT5+MeqBRV52GxtUlAH0cmviLiiW
         dfmgR03WfXfkHsW6bOdy/9vE1jZFT0uwD+5v+zQCQ+CCDXwb0YgZWLK6fhpNWKV47plY
         FJu7IhrcQrbKKAJ5o0wle3uC5qgPN7r5ooZdar/jIbDaHkuN3uzLC4YuOZ4Zbck8s9KW
         vMgWCYOYYwGL73rvxNYr22nGxj+5LYRT/J95DqE0NwM0x7jf2zB9nmd45n6FTbJCFIk3
         tKOw==
X-Gm-Message-State: AOAM531mJqBD1Lry6lAuTT6kidcXLyxD4R+E9w69/ohEYJzQzAltWV/N
        4kfZkr3gkB8Z9pRchjj/kePn5A==
X-Google-Smtp-Source: ABdhPJx3EcGkWkmq55Pl22QZhAf8HwIgf11UYrBlNWLWKIjbaiYFtSPhk+vfwlUm5CfNdTP1kqUsuw==
X-Received: by 2002:a17:90a:280d:: with SMTP id e13mr6943359pjd.191.1620153372638;
        Tue, 04 May 2021 11:36:12 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:201:10d7:bc55:1441:1248])
        by smtp.gmail.com with ESMTPSA id g4sm4170933pgu.46.2021.05.04.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 11:36:12 -0700 (PDT)
Date:   Tue, 4 May 2021 11:36:06 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     David Gow <davidgow@google.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, shuah@kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] fat: Add KUnit tests for checksums and timestamps
Message-ID: <YJGUFrc8PJ0LAKiF@google.com>
References: <20210416065623.882364-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416065623.882364-1-davidgow@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 15, 2021 at 11:56:23PM -0700, David Gow wrote:
> Add some basic sanity-check tests for the fat_checksum() function and
> the fat_time_unix2fat() and fat_time_fat2unix() functions. These unit
> tests verify these functions return correct output for a number of test
> inputs.
> 
> These tests were inspored by -- and serve a similar purpose to -- the
                   ^^^^^^^^
        I am guessing this is supposed to be "inspired".

> timestamp parsing KUnit tests in ext4[1].
> 
> Note that, unlike fat_time_unix2fat, fat_time_fat2unix wasn't previously
> exported, so this patch exports it as well. This is required for the
> case where we're building the fat and fat_test as modules.
> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/inode-test.c
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Aside from the nit above, and the *potential* nit and question below.
Everything here looks good to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
> 
> It's been a while, but this hopefully is a final version of the FAT KUnit
> patchset. It has a number of changes to keep it up-to-date with current
> KUnit standards, notably the use of parameterised tests and the addition
> of a '.kunitconfig' file to allow for easy testing. It also fixes an
> endianness tagging issue picked up by the kernel test robot under sparse
> on pa-risc.
> 
> Cheers,
> -- David

[...]

> diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
> new file mode 100644
> index 000000000000..febd25f57d4b
> --- /dev/null
> +++ b/fs/fat/fat_test.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for FAT filesystems.
> + *
> + * Copyright (C) 2020 Google LLC.

Nit: I know you wrote this last year, but I have had other maintainers
tell me the Copyright date should be set to when the final version of
the patch is sent out.

I personally don't care, and I don't think you should resend this patch
just for that, but figured I would mention.

> + * Author: David Gow <davidgow@google.com>
> + */
> +
> +#include <kunit/test.h>
> +
> +#include "fat.h"
> +
> +static void fat_checksum_test(struct kunit *test)
> +{
> +	/* With no extension. */
> +	KUNIT_EXPECT_EQ(test, fat_checksum("VMLINUX    "), (u8)44);
> +	/* With 3-letter extension. */
> +	KUNIT_EXPECT_EQ(test, fat_checksum("README  TXT"), (u8)115);
> +	/* With short (1-letter) extension. */
> +	KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), (u8)98);

How do you get the magic values? Or is this just supposed to be a
regression test?

Not going to pretend I understand FAT, but everything else in this test
makes sense from a logical/testing/readability point of view.

Cheers!

[...]
