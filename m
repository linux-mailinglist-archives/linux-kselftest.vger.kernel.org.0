Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED4D9ABC
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 22:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfJPUDM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 16:03:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37071 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfJPUDM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 16:03:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id u20so11781950plq.4
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JX36bcoVDvGPpKT56L/IQCmfHofuMF7ewkrGUc48K60=;
        b=S3OzJHvQ/jbpxi+w4ta2h9fuet9pvzKeCJL/BynoxfdCTszapvphYqKUAxEJt4Cd5P
         77hBJAdR88NJF9AO6qHNN6jh7/++8jN4UsdbfxPRjTWpyMZi5iyAS7rWev1SQw2d7yYI
         kuG3OrjiHzpESxZQ/iPDl081NMpXfB3a6wsSaNu5kzRRJMJe75IdPD4S1MqQFxRHmNvo
         BWoNTGhf2QuZcTi1dIT6tYHVaJJYgmVU1v2rz8bHTY8KNM8+S/Tws2j4g11lCIqy53Ks
         G5aLCHdQCvYR6Ty6V9+QIsfWa6h/vdf7QPEkXLR/8KncVAvV/62MTbqVzeiJTbLWCjYQ
         3hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JX36bcoVDvGPpKT56L/IQCmfHofuMF7ewkrGUc48K60=;
        b=EZ9syRCp1ZGY+f/c2JSglJbnNZplqpAaLqT/aaEIJgiyXaGFNy5tLGuAjrZlH7TKi+
         U67zqpVt++7oS5WLl2dYbKwQzjuBbtnbGIE+Pu6rG+wYJaCQilW0j/NFgUOMHZOLVyn6
         qQYHjXqz7dzVJgIInzudmfZtyANushO121Fur6YHWQFxJnc2B2gm7Jmbc+zPc0gw2zhS
         QCwGb6SPOQCq33UlMexmd3do/liUUhAM1Fm9LClPvY/2lPcsWCxqpXqqXh6ltOlxcEtW
         8APhTqUpayNXTqOxcaIbog1nfr68+Ndv6G0LKagZqRurGEmeAIKYkxNCqnQc/qUrvVoE
         Lx9Q==
X-Gm-Message-State: APjAAAUyKbFWGB8vEqCafMt7pLONVH0hP+WQF9Fg1shG5VoEsnhdJKLr
        bflY9YbCFsoBbU57VPJiymlB+uZbfLuxvg==
X-Google-Smtp-Source: APXvYqwzim77PSt3IxfBaBfc7aTaUod4a/+aKNQfcA6ooJ2eV6CEcz5FOdV2/3P065W6TYl7blQqDA==
X-Received: by 2002:a17:902:a581:: with SMTP id az1mr42046269plb.311.1571256190227;
        Wed, 16 Oct 2019 13:03:10 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id y144sm29943397pfb.188.2019.10.16.13.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:03:08 -0700 (PDT)
Date:   Wed, 16 Oct 2019 13:03:04 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kselftest@vger.kernel.org, linux-ext4@vger.kernel.org,
        skhan@linuxfoundation.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Tim.Bird@sony.com, kunit-dev@googlegroups.com
Subject: Re: [PATCH linux-kselftest/test v4] ext4: add kunit test for
 decoding extended timestamps
Message-ID: <20191016200304.GA49718@google.com>
References: <20191012023757.172770-1-yzaikin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012023757.172770-1-yzaikin@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 11, 2019 at 07:37:57PM -0700, Iurii Zaikin wrote:
> KUnit tests for decoding extended 64 bit timestamps
> that verify the seconds part of [a/c/m]
> timestamps in ext4 inode structs are decoded correctly.
> KUnit tests, which run on boot and output
> the results to the debug log in TAP format (http://testanything.org/).
> are only useful for kernel devs running KUnit test harness. Not for
> inclusion into a production build.
> Test data is derive from the table under
nit:                ^
Should be:     derived from ...

> Documentation/filesystems/ext4/inodes.rst Inode Timestamps.
> 
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  fs/ext4/Kconfig      |  14 +++
>  fs/ext4/Makefile     |   1 +
>  fs/ext4/inode-test.c | 239 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 fs/ext4/inode-test.c
>
[...]
> diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> new file mode 100644
> index 000000000000..3b3a453ff382
> --- /dev/null
> +++ b/fs/ext4/inode-test.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test of ext4 inode that verify the seconds part of [a/c/m]
> + * timestamps in ext4 inode structs are decoded correctly.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/kernel.h>
> +#include <linux/time64.h>
> +
> +#include "ext4.h"
> +
> +/* binary: 00000000 00000000 00000000 00000000 */
> +#define LOWER_MSB_0 0L
> +/* binary: 01111111 11111111 11111111 11111111 */
> +#define UPPER_MSB_0 0x7fffffffL
> +/* binary: 10000000 00000000 00000000 00000000 */
> +#define LOWER_MSB_1 (-0x80000000L)
> +/* binary: 11111111 11111111 11111111 11111111 */
> +#define UPPER_MSB_1 (-1L)
> +/* binary: 00111111 11111111 11111111 11111111 */
> +#define MAX_NANOSECONDS ((1L << 30) - 1)
> +
> +#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x extra_bits: %x"
> +
> +struct timestamp_expectation {
> +	const char *test_case_name;
> +	struct timespec64 expected;
> +	u32 extra_bits;
> +	bool msb_set;
> +	bool lower_bound;
> +};
> +
> +static time64_t get_32bit_time(const struct timestamp_expectation * const test)
> +{
> +	if (test->msb_set) {
> +		if (test->lower_bound)
> +			return LOWER_MSB_1;
> +
> +		return UPPER_MSB_1;
> +	}
> +
> +	if (test->lower_bound)
> +		return LOWER_MSB_0;
> +	return UPPER_MSB_0;
> +}
> +
> +
> +/*
> + * These tests are derived from the table under
> + * Documentation/filesystems/ext4/inodes.rst Inode Timestamps
> + */
> +static void inode_test_xtimestamp_decoding(struct kunit *test)
> +{
> +	const struct timestamp_expectation test_data[] = {
> +		{
> +			.test_case_name =
> +		"1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits.",

nit: Maybe drop the period at the end (here and elsewhere)? Otherwise if
the test fails you have a period right next to a colon and it looks a
bit off.

> +			.msb_set = true,
> +			.lower_bound = true,
> +			.extra_bits = 0,
> +			.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> +		},

Feel free to ignore my nits if you don't need to send another version.
Also note that Ted has given a Reviewed-by on an earlier revision.

Thanks!
