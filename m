Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F316DD1084
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 15:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfJINsE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 09:48:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44570 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbfJINsD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 09:48:03 -0400
Received: by mail-io1-f65.google.com with SMTP id w12so5004299iol.11
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2019 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mSn2+23DA3dvXibL8cPD2hacODId04tGVSl14+36G0M=;
        b=f4t2WfBwSf0jLgHGNe7U1kPAffY7ZsGh6FcYh9bkmepgDSasA6orIgr3iNx3Vvxen0
         lVwcEfeOdtQMBR3ANQe1udoxHnlRkNwgYvtaHlAx3/Fbnw3SG99zRiRtDM19KYkPPmHa
         Os+V32rqsuiw8Ll8tllM9Vw7EHLMTaKp7E/Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSn2+23DA3dvXibL8cPD2hacODId04tGVSl14+36G0M=;
        b=sGiHlNZfUhL+puypboRCl8oDIUBwkUqGCqtQZOdMOwnI4X4PGDtkElCNr9A8aY66dv
         1erqZmactXPYIiRVDUnh75Hj2InZR+GllEDds0HNKESGhrD7ISVIhcyC+YwgZ1EYQ60B
         H6LB9+aGQKuN9fBL8cWOIcoYE5m80Nl17uTLjWrvNFAKjB4c5UWJTYCVHR8MkpTElmuG
         fCahHWbZqcG82/TVp/aaOaPXesJ04cqyCTII+EDiOlCvNbgPU98KJHVhnJNwj5AXRXQC
         +PAyhYtQNZ14273xYPFYY0gYDsRQFJAVdEp0GgnF5+77pIU6GT6UDmRf/d+eiSJAGrkh
         PNHw==
X-Gm-Message-State: APjAAAVqMfYHRrh1dP81qncAfBhSEH3KIShy/GROZ5v0rntni1qQAdUt
        +sRurJN7jhRMAVVc2saa4FWwkw==
X-Google-Smtp-Source: APXvYqwJpI9LiJgzwPQq+Q9lfmxOWVS6eOIfFeQvJQZXWTQgAmcdA043NEA+HNTVg2O2QdXXobHxYA==
X-Received: by 2002:a02:8188:: with SMTP id n8mr3032515jag.71.1570628882235;
        Wed, 09 Oct 2019 06:48:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f8sm881926ioo.27.2019.10.09.06.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 06:48:01 -0700 (PDT)
Subject: Re: [PATCH v1] fs/ext4/inode-test: KUnit test for ext4 inode.
To:     Iurii Zaikin <yzaikin@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca
Cc:     kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CAAXuY3rcz78vxvXbvg+wjFBFonmOx9dfweo3od6U6TaT8JVHsQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a21cb4ad-bbb8-7763-e73b-829c3d575673@linuxfoundation.org>
Date:   Wed, 9 Oct 2019 07:48:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAXuY3rcz78vxvXbvg+wjFBFonmOx9dfweo3od6U6TaT8JVHsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Iurii,

Thanks for the patch.

On 10/8/19 8:42 PM, Iurii Zaikin wrote:
> Note: this patch is intended to be applied against kselftest/test branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test
> 


This doesn't belong here. You can add it to commit header

[PATCH linux-kselftest/test] also you don't need v1 in there.

> KUnit tests for decoding extended 64 bit timestamps.

Please give more details on what these tests do. More information
on range of timestamps would be helpful. I see you have 2038 test
and it would be great to call out the ranges and conditions it is
resting.

> 
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> ---
>   fs/ext4/Kconfig      |  12 +++
>   fs/ext4/Makefile     |   1 +
>   fs/ext4/inode-test.c | 217 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 230 insertions(+)
>   create mode 100644 fs/ext4/inode-test.c
> 
> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index cbb5ca830e57..72c26abbce4c 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -106,3 +106,15 @@ config EXT4_DEBUG
>     If you select Y here, then you will be able to turn on debugging
>     with a command such as:
>    echo 1 > /sys/module/ext4/parameters/mballoc_debug
> +
> +config EXT4_INODE_KUNIT_TEST
> + bool "KUnit test for ext4 inode"
> + depends on EXT4_FS
> + depends on KUNIT
> + help
> +  This builds the ext4 inode sysctl unit test, which runs on boot.
> +  Tests the encoding correctness of ext4 inode.
> +  For more information on KUnit and unit tests in general please refer
> +  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +  If unsure, say N.
> diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> index b17ddc229ac5..1eeb8b449255 100644
> --- a/fs/ext4/Makefile
> +++ b/fs/ext4/Makefile
> @@ -13,4 +13,5 @@ ext4-y := balloc.o bitmap.o block_validity.o dir.o
> ext4_jbd2.o extents.o \
> 
>   ext4-$(CONFIG_EXT4_FS_POSIX_ACL) += acl.o
>   ext4-$(CONFIG_EXT4_FS_SECURITY) += xattr_security.o
> +ext4-$(CONFIG_EXT4_INODE_KUNIT_TEST) += inode-test.o
>   ext4-$(CONFIG_FS_VERITY) += verity.o
> diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> new file mode 100644
> index 000000000000..0ecb8dd5e0c5
> --- /dev/null
> +++ b/fs/ext4/inode-test.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0

Follow the commenting style recommended in the coding-style doc.
/* ---- */

> +/*
> + * KUnit test of ext4 inode.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/kernel.h>
> +#include <linux/time64.h>
> +
> +#include "ext4.h"
> +
> +// binary: 00000000 00000000 00000000 00000000
> +#define LOWER_MSB_0 0L
> +// binary: 01111111 11111111 11111111 11111111
> +#define UPPER_MSB_0 0x7fffffffL
> +// binary: 10000000 00000000 00000000 00000000
> +#define LOWER_MSB_1 (-0x80000000L)
> +// binary: 11111111 11111111 11111111 11111111
> +#define UPPER_MSB_1 (-1L)
> +
> +#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x extra_bits: %x"
> +
> +struct timestamp_expectation {
> + const char *test_case_name;
> + struct timespec64 expected;
> + u32 extra_bits;
> + bool msb_set;
> + bool lower_bound;
> +};
> +
> +static time64_t get_32bit_time(const struct timestamp_expectation * const test)
> +{
> + if (test->msb_set) {
> + if (test->lower_bound)
> + return LOWER_MSB_1;
> +
> + return UPPER_MSB_1;
> + }

Can you add information on what you are trying to test.
Please do the same for all tests.

> +
> + if (test->lower_bound)
> + return LOWER_MSB_0;
> + return UPPER_MSB_0;
> +}
> +
> +
> +static void inode_test_xtimestamp_decoding(struct kunit *test)
> +{
> + const struct timestamp_expectation test_data[] = {
> + {
> + .test_case_name = "1901-12-13",
> + .msb_set = true,
> + .lower_bound = true,
> + .extra_bits = 0,
> + .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> + },
> +

I see that you use the same tv_nsec for all tests. Is there
a reason for that? Would it be helpful to vary it?

> + {
> + .test_case_name = "1969-12-31",
> + .msb_set = true,
> + .lower_bound = false,
> + .extra_bits = 0,
> + .expected = {.tv_sec = -1LL, .tv_nsec = 0L},
> + },
> +
> + {
> + .test_case_name = "1970-01-01",
> + .msb_set = false,
> + .lower_bound = true,
> + .extra_bits = 0,
> + .expected = {0LL, 0L},
> + },
> +
> + {
> + .test_case_name = "2038-01-19",
> + .msb_set = false,
> + .lower_bound = false,
> + .extra_bits = 0,
> + .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
> + },
> +
> + {
> + .test_case_name = "2038-01-19",
> + .msb_set = true,
> + .lower_bound = true,
> + .extra_bits = 1,
> + .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> + },
> +
> + {
> + .test_case_name = "2106-02-07",
> + .msb_set = true,
> + .lower_bound = false,
> + .extra_bits = 1,
> + .expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
> + },
> +
> + {
> + .test_case_name = "2106-02-07",
> + .msb_set = false,
> + .lower_bound = true,
> + .extra_bits = 1,
> + .expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0LL},
> + },
> +
> + {
> + .test_case_name = "2174-02-25",
> + .msb_set = false,
> + .lower_bound = false,
> + .extra_bits = 1,
> + .expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
> + },
> +
> + {
> + .test_case_name = "2174-02-25",
> + .msb_set = true,
> + .lower_bound = true,
> + .extra_bits =  2,
> + .expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
> + },
> +
> + {
> + .test_case_name = "2242-03-16",
> + .msb_set = true,
> + .lower_bound = false,
> + .extra_bits = 2,
> + .expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
> + },
> +
> + {
> + .test_case_name = "2242-03-16",
> + .msb_set = false,
> + .lower_bound = true,
> + .extra_bits = 2,
> + .expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
> + },
> +
> + {
> + .test_case_name = " 2310-04-04",
> + .msb_set = false,
> + .lower_bound = false,
> + .extra_bits = 2,
> + .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
> + },
> +

Get rid of this. Add it when you can add it later. I don't
like to see these TODOs with blocks of code commented out.

> + /* TODO: enable when legacy encoding in ext4.h is disabled.
> + *{
> + * .test_case_name = "2310-04-04",
> + * .msb_set = true,
> + * .lower_bound = true,
> + * .extra_bits = 3,
> + * .expected = {.tv_sec = 0x280000000LL, .tv_nsec = 0L},
> + *},
> + *
> + *{
> + * .test_case_name = "2378-04-22",
> + * .msb_set = true,
> + * .lower_bound = false,
> + * .extra_bits = 3,
> + * .expected = {.tv_sec = 0x2ffffffffLL, .tv_nsec = 0L},
> + * },
> + */
> +
> + {
> + .test_case_name = "2378-04-22",
> + .msb_set = false,
> + .lower_bound = true,
> + .extra_bits = 3,
> + .expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
> + },
> +
> + {
> + .test_case_name = "2446-05-10",
> + .msb_set = false,
> + .lower_bound = false,
> + .extra_bits = 3,
> + .expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
> + }
> + };
> +
> + struct timespec64 timestamp;
> + int i;
> +
> + for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
> + timestamp.tv_sec = get_32bit_time(&test_data[i]);
> + ext4_decode_extra_time(&timestamp,
> +       cpu_to_le32(test_data[i].extra_bits));
> +
> + KUNIT_EXPECT_EQ_MSG(test,
> +    test_data[i].expected.tv_sec,
> +    timestamp.tv_sec,
> +    CASE_NAME_FORMAT,
> +    test_data[i].test_case_name,
> +    test_data[i].msb_set,
> +    test_data[i].lower_bound,
> +    test_data[i].extra_bits);
> + KUNIT_EXPECT_EQ_MSG(test,
> +    test_data[i].expected.tv_nsec,
> +    timestamp.tv_nsec,
> +    CASE_NAME_FORMAT,
> +    test_data[i].test_case_name,
> +    test_data[i].msb_set,
> +    test_data[i].lower_bound,
> +    test_data[i].extra_bits);
> + }
> +}
> +
> +static struct kunit_case ext4_inode_test_cases[] = {
> + KUNIT_CASE(inode_test_xtimestamp_decoding),
> + {}
> +};
> +
> +static struct kunit_suite ext4_inode_test_suite = {
> + .name = "ext4_inode_test",
> + .test_cases = ext4_inode_test_cases,
> +};
> +
> +kunit_test_suite(ext4_inode_test_suite);
> --
> 2.23.0.700.g56cf767bdb-goog
> 

thanks,
-- Shuah
