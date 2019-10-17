Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8ECDA296
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 02:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfJQAKb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 20:10:31 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34435 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfJQAKb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 20:10:31 -0400
Received: by mail-il1-f195.google.com with SMTP id c12so291403ilm.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 17:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=if3Znejo9rQAoId7/S4UP3LDpeW2iiN7Zw1qG6w8YHk=;
        b=HyMxLXJTfRAgva8+etBTxYoULQ2WCOP1LQzHcCV6OvngSuCEw4961lAl3dJXiBxWzK
         43RPXUFsTZU24ZOJM+QpPqlOlvrfbxMx1AeMHbauVpz22K78ztsCAVLV+C8Gk8IK/K2p
         ahMYN0dFckK7xfv2mptket+BBZqvMFkgeu3l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=if3Znejo9rQAoId7/S4UP3LDpeW2iiN7Zw1qG6w8YHk=;
        b=XZaAunPJfE/5P52EgIDBVG2l3PzOzeXevrkskmZblsLTAg5ykVQ01wxGbeuBVVkX9P
         zVb32q9b60A1Jma1Kf/hUzvgHlJUmdyOspqOovVfbjeYZvHt9hM5V5SQwJNSLDjxpoV5
         5sEdpnkjoPgzo4Rnvxu3Ob6TcVfL2Srg7OAkW1CzspOO/agx4av1LT5kb8omnRzFnQyT
         BQ0JSM/fqkderwcRJLevc7UR1FJxWENSFCskMB1i94U+8SCXAlfK7RENFQDXAsxLRJVP
         P146P2x85mdc87vGMca/D8Og761/3X/Jpj24KecAXcfrOsFZA8PVnBctDObcYiId9c6S
         Et8A==
X-Gm-Message-State: APjAAAUTGVdVLJ23UsUQwbWKczVrkkDxjvYEgDCCogsILDMDpoo+OsG2
        X9oU+nM/wkj0tJ5ASsTE8M4ZZA==
X-Google-Smtp-Source: APXvYqx3Rfp+R+zFX0ooH9wisWr/r1bLRayTfXwjfYMoUAxeI6liwppV18C3nDquZGzPwJguuics3Q==
X-Received: by 2002:a92:a308:: with SMTP id a8mr630494ili.65.1571271029789;
        Wed, 16 Oct 2019 17:10:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t16sm138715iol.12.2019.10.16.17.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 17:10:29 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v5] ext4: add kunit test for decoding
 extended timestamps
To:     Iurii Zaikin <yzaikin@google.com>, linux-kselftest@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Tim.Bird@sony.com
Cc:     kunit-dev@googlegroups.com, brendanhiggins@google.com,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20191016212935.215310-1-yzaikin@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f87c91bd-5ebb-d259-ff80-385e2db342b1@linuxfoundation.org>
Date:   Wed, 16 Oct 2019 18:10:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016212935.215310-1-yzaikin@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Lurii,

On 10/16/19 3:29 PM, Iurii Zaikin wrote:
> KUnit tests for decoding extended 64 bit timestamps
> that verify the seconds part of [a/c/m]
> timestamps in ext4 inode structs are decoded correctly.

Add a blank line here. Also can you make these close 75 char long.
It will be easier to read the commit log.


> KUnit tests, which run on boot and output

  run during boot?

> the results to the debug log in TAP format (http://testanything.org/).

Break this sentence here.

> are only useful for kernel devs running KUnit test harness. Not for
> inclusion into a production build.

I like the way you state clearly that these aren't for production
build. Thanks for this detail.

> Test data is derived from the table under
> Documentation/filesystems/ext4/inodes.rst Inode Timestamps.

Reads a bit funny. Please rephrase.


Test data is derived from the Inode Timestamps table under
Documentation/filesystems/ext4/inodes.rst

> 
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   fs/ext4/Kconfig      |  14 +++
>   fs/ext4/Makefile     |   1 +
>   fs/ext4/inode-test.c | 239 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 254 insertions(+)
>   create mode 100644 fs/ext4/inode-test.c
> 
> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index cbb5ca830e57..f13dde8ed92b 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -106,3 +106,17 @@ config EXT4_DEBUG
>   	  If you select Y here, then you will be able to turn on debugging
>   	  with a command such as:
>   		echo 1 > /sys/module/ext4/parameters/mballoc_debug
> +
> +config EXT4_KUNIT_TESTS
> +	bool "KUnit tests for ext4"
> +	select EXT4_FS
> +	depends on KUNIT
> +	help
> +	  This builds the ext4 KUnit tests, which run on boot and output
> +	  the results to the debug log in TAP format (http://testanything.org/).
> +	  Only useful for kernel devs running KUnit test harness. Not for
> +	  inclusion into a production build.

Please apply the same changes you made to commit log here.

> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> index b17ddc229ac5..840b91d040f1 100644
> --- a/fs/ext4/Makefile
> +++ b/fs/ext4/Makefile
> @@ -13,4 +13,5 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
> 
>   ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
>   ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
> +ext4-$(CONFIG_EXT4_KUNIT_TESTS)		+= inode-test.o
>   ext4-$(CONFIG_FS_VERITY)		+= verity.o
> diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> new file mode 100644
> index 000000000000..1f2c486bc1c2
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

Please add a comment to say what these defines are for.

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

Rephrase this please. Reads a bit funny.

> + */
> +static void inode_test_xtimestamp_decoding(struct kunit *test)
> +{
> +	const struct timestamp_expectation test_data[] = {
> +		{
> +			.test_case_name =
> +		"1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits",

Please make these defines and use name here. Makes it easier to read
and you can also avoid this weird lining up with {


> +			.msb_set = true,
> +			.lower_bound = true,
> +			.extra_bits = 0,
> +			.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +		"1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits",

Same here.

> +			.msb_set = true,
> +			.lower_bound = false,
> +			.extra_bits = 0,
> +			.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +		"1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits",

Same here.

> +			.msb_set = false,
> +			.lower_bound = true,
> +			.extra_bits = 0,
> +			.expected = {0LL, 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +		"2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits",

Same here and all the strings below.

> +			.msb_set = false,
> +			.lower_bound = false,
> +			.extra_bits = 0,
> +			.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +	"2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on",
> +			.msb_set = true,
> +			.lower_bound = true,
> +			.extra_bits = 1,
> +			.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +	"2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on",
> +			.msb_set = true,
> +			.lower_bound = false,
> +			.extra_bits = 1,
> +			.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +	  "2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on",
> +			.msb_set = false,
> +			.lower_bound = true,
> +			.extra_bits = 1,
> +			.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +	  "2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on",
> +			.msb_set = false,
> +			.lower_bound = false,
> +			.extra_bits = 1,
> +			.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +	  "2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on",
> +			.msb_set = true,
> +			.lower_bound = true,
> +			.extra_bits =  2,
> +			.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +	  "2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on",
> +			.msb_set = true,
> +			.lower_bound = false,
> +			.extra_bits = 2,
> +			.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +	"2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on",
> +			.msb_set = false,
> +			.lower_bound = true,
> +			.extra_bits = 2,
> +			.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +	  "2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on",
> +			.msb_set = false,
> +			.lower_bound = false,
> +			.extra_bits = 2,
> +			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +"2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns bit 1",
> +			.msb_set = false,
> +			.lower_bound = false,
> +			.extra_bits = 6,
> +			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
> +		},
> +
> +		{
> +			.test_case_name =
> +"2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. ns bits 1",
> +			.msb_set = false,
> +			.lower_bound = true,
> +			.extra_bits = 0xFFFFFFFF,
> +			.expected = {.tv_sec = 0x300000000LL,
> +				     .tv_nsec = MAX_NANOSECONDS},
> +		},
> +
> +		{
> +			.test_case_name =
> +	 "2378-04-22 Lower bound of 32bit >= timestamp. All extra sec bits on",
> +			.msb_set = false,
> +			.lower_bound = true,
> +			.extra_bits = 3,
> +			.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name =
> +	"2446-05-10 Upper bound of 32bit >= timestamp. All extra sec bits on",
> +			.msb_set = false,
> +			.lower_bound = false,
> +			.extra_bits = 3,
> +			.expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
> +		}
> +	};
> +
> +	struct timespec64 timestamp;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
> +		timestamp.tv_sec = get_32bit_time(&test_data[i]);
> +		ext4_decode_extra_time(&timestamp,
> +				       cpu_to_le32(test_data[i].extra_bits));
> +
> +		KUNIT_EXPECT_EQ_MSG(test,
> +				    test_data[i].expected.tv_sec,
> +				    timestamp.tv_sec,
> +				    CASE_NAME_FORMAT,
> +				    test_data[i].test_case_name,
> +				    test_data[i].msb_set,
> +				    test_data[i].lower_bound,
> +				    test_data[i].extra_bits);
> +		KUNIT_EXPECT_EQ_MSG(test,
> +				    test_data[i].expected.tv_nsec,
> +				    timestamp.tv_nsec,
> +				    CASE_NAME_FORMAT,
> +				    test_data[i].test_case_name,
> +				    test_data[i].msb_set,
> +				    test_data[i].lower_bound,
> +				    test_data[i].extra_bits);
> +	}
> +}
> +
> +static struct kunit_case ext4_inode_test_cases[] = {
> +	KUNIT_CASE(inode_test_xtimestamp_decoding),
> +	{}
> +};
> +
> +static struct kunit_suite ext4_inode_test_suite = {
> +	.name = "ext4_inode_test",
> +	.test_cases = ext4_inode_test_cases,
> +};
> +
> +kunit_test_suite(ext4_inode_test_suite);
> --
> 2.23.0.866.gb869b98d4c-goog
> 

thanks,
-- Shuah
