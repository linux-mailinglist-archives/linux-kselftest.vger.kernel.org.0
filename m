Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90362D2F52
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfJJRLo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 13:11:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38581 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfJJRLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 13:11:43 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so15408500iom.5
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2019 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TPg/L4c8Uvgw29Zd+7UAJnKTcWYr9oJBx1w/OaevLjA=;
        b=GlbFOwwmneuybNGd5arIwRw5l4iiNFjNTddTdrmmIo6iVlapczMMALokM9O8npHnca
         VoBy4vG2HpsyQDFAdxMRXfzOKytcwot3CU7Kx5x3aIHr5f4lLRXOIo3JBbFjSCIftmAS
         KCei+m3PH/OkSKpkpgii/Sw4UkHsAUfBapCKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TPg/L4c8Uvgw29Zd+7UAJnKTcWYr9oJBx1w/OaevLjA=;
        b=ue8WseTgdgqDN+DQmRDFD4rKVWWj7gFF/Itj95AT/1x8Z8NP4uuNpNY4kPGRlOjvia
         8SlaNdAmsNo0datGOEs57DvUz/vPfKKyx7RXQn6pEFhGMrfStEXLqsd/gxFg4wlLhIiK
         YcuV6WjVPG9tS/pKuVWagpzQAu2NT+6u6pCCC+A9G8scFKsdr2VowWVm5vbvHnH0hXVt
         Fx58LH/OLOvt5N6+cIs1mNfBP5XKfbSLf7/CepaMwBwxGaNL5LpYMF2oe0xhlrGxY2mK
         BCqdOuKzveznUTHXDoUNFYefBvu33rMlcPDUae6yVC6SUNO09MoEbLWn0BlewQxlZowK
         cr2Q==
X-Gm-Message-State: APjAAAV/1phPh5qYtdf2RVPL3kX2clAzn2hp2hysuYLDUyzd/KHPHiW/
        SB6ZYyjP+5Pf/n+E/I2vhCuhVA==
X-Google-Smtp-Source: APXvYqxcFiDsFwYxJ4X+7hPa4aNBI2n0ezxGTwZmwB5kTo55GoYcpEps0rBilcfHSMTtglr1JeogxA==
X-Received: by 2002:a5d:9856:: with SMTP id p22mr11560565ios.29.1570727502608;
        Thu, 10 Oct 2019 10:11:42 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h4sm3748372iom.17.2019.10.10.10.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:11:42 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Iurii Zaikin <yzaikin@google.com>, linux-kselftest@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     kunit-dev@googlegroups.com, brendanhiggins@google.com,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20191010023931.230475-1-yzaikin@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
Date:   Thu, 10 Oct 2019 11:11:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010023931.230475-1-yzaikin@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/9/19 8:39 PM, Iurii Zaikin wrote:
> KUnit tests for decoding extended 64 bit timestamps.
> 
"Added the link to the ext4 docs from which the tests were derived."

Document reference is great. I would still like to see summary
in the commit log.

As you said below:

"This builds the ext4 inode sysctl unit test, which runs on boot."

Also include what should user expect to see when one of these fails.


> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> ---
>   fs/ext4/Kconfig      |  12 +++
>   fs/ext4/Makefile     |   1 +
>   fs/ext4/inode-test.c | 221 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 234 insertions(+)
>   create mode 100644 fs/ext4/inode-test.c
> 
> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index cbb5ca830e57..cb0b52753674 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -106,3 +106,15 @@ config EXT4_DEBUG
>   	  If you select Y here, then you will be able to turn on debugging
>   	  with a command such as:
>   		echo 1 > /sys/module/ext4/parameters/mballoc_debug
> +
> +config EXT4_KUNIT_TESTS
> +	bool "KUnit test for ext4 inode"
> +	depends on EXT4_FS
> +	depends on KUNIT
> +	help
> +	  This builds the ext4 inode sysctl unit test, which runs on boot.
> +	  Tests the encoding correctness of ext4 inode.
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.

Please add Documentation/filesystems/ext4/inodes.rst Inode Timestamps
here as well.

Yeah. Especially after looking at the document, summary of what these
test(s) is definitely helpful. You can't expect users to read the
document before enabling it. Please write a summary of tests and what
they do and add it here and then in the commit log. Also include what
user should expect when they pass and when one of them fails.

> +
> +	  If unsure, say N.
> diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> index b17ddc229ac5..a0588fd2eea6 100644
> --- a/fs/ext4/Makefile
> +++ b/fs/ext4/Makefile
> @@ -13,4 +13,5 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
> 
>   ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
>   ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
> +ext4-$(CONFIG_EXT4_KUNIT_TESTS)	+= inode-test.o
>   ext4-$(CONFIG_FS_VERITY)		+= verity.o
> diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> new file mode 100644
> index 000000000000..43bc6cb547cd
> --- /dev/null
> +++ b/fs/ext4/inode-test.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test of ext4 inode that verify the seconds part of [a/c/m]
> + * timestamps in ext4 inode structs are decoded correctly.
> + * These tests are derived from the table under
> + * Documentation/filesystems/ext4/inodes.rst Inode Timestamps

Yeah. Especially after looking at the document, summary of what these
test(s) is definitely helpful. You can't expect users to read the
document before enabling the tests.

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
> +/* binary: 00111111   11111111 11111111 11111111 */
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
> +static void inode_test_xtimestamp_decoding(struct kunit *test)
> +{
> +	const struct timestamp_expectation test_data[] = {
> +		{
> +			.test_case_name = "1901-12-13",
> +			.msb_set = true,
> +			.lower_bound = true,
> +			.extra_bits = 0,
> +			.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = "1969-12-31",
> +			.msb_set = true,
> +			.lower_bound = false,
> +			.extra_bits = 0,
> +			.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = "1970-01-01",
> +			.msb_set = false,
> +			.lower_bound = true,
> +			.extra_bits = 0,
> +			.expected = {0LL, 0L},
> +		},
> +
> +		{
> +			.test_case_name = "2038-01-19",
> +			.msb_set = false,
> +			.lower_bound = false,
> +			.extra_bits = 0,
> +			.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = "2038-01-19",
> +			.msb_set = true,
> +			.lower_bound = true,
> +			.extra_bits = 1,
> +			.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = "2106-02-07",
> +			.msb_set = true,
> +			.lower_bound = false,
> +			.extra_bits = 1,
> +			.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = "2106-02-07",
> +			.msb_set = false,
> +			.lower_bound = true,
> +			.extra_bits = 1,
> +			.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = "2174-02-25",
> +			.msb_set = false,
> +			.lower_bound = false,
> +			.extra_bits = 1,
> +			.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = "2174-02-25",
> +			.msb_set = true,
> +			.lower_bound = true,
> +			.extra_bits =  2,
> +			.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = "2242-03-16",
> +			.msb_set = true,
> +			.lower_bound = false,
> +			.extra_bits = 2,
> +			.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = "2242-03-16",
> +			.msb_set = false,
> +			.lower_bound = true,
> +			.extra_bits = 2,
> +			.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = " 2310-04-04",
> +			.msb_set = false,
> +			.lower_bound = false,
> +			.extra_bits = 2,
> +			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = " 2310-04-04 00:00:00.1",
> +			.msb_set = false,
> +			.lower_bound = false,
> +			.extra_bits = 6,
> +			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
> +		},
> +
> +		{
> +			.test_case_name = "2378-04-22 00:00:00.MAX_NSEC",
> +			.msb_set = false,
> +			.lower_bound = true,
> +			.extra_bits = 0xFFFFFFFF,
> +			.expected = {.tv_sec = 0x300000000LL,
> +				     .tv_nsec = MAX_NANOSECONDS},
> +		},
> +
> +		{
> +			.test_case_name = "2378-04-22",
> +			.msb_set = false,
> +			.lower_bound = true,
> +			.extra_bits = 3,
> +			.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
> +		},
> +
> +		{
> +			.test_case_name = "2446-05-10",
> +			.msb_set = false,
> +			.lower_bound = false,
> +			.extra_bits = 3,
> +			.expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
> +		}
> +	};
> +

Is there a way to make the test data dynamic. Can you read from a data
file? It will be easier to if the data

Maybe this is question to Brendan?

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
> 2.23.0.700.g56cf767bdb-goog
> 

thanks,
-- Shuah
