Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70869D146F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 18:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfJIQsr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 12:48:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbfJIQsq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 12:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PTVfxx8EQAcrTIKh+dAlVulDSONKVB5OmVKMC19J9Zg=; b=K5dKpcsK58Vm6EWR7+66039xk
        7Mm5NrsAKRCTyQOYQGL9SjiA3kSkzZemZUzC6qZLEsAJLQVuV2tjrK9BWzvEd8NGAw6zxjDsM9Ofr
        uSyDwv+OWvYx5kCIxhuwflVw3NmXEXP/rKlpfGASwOkBgKl1WaMbXGLTS8ZvkQX7iN9F4ll7vnbdR
        jrsYQWa4a3LrzqzZSniIaibVoYY6NF8XUWuvm59SoeQAITdfHTf4Ca8B/wySqiVbAcTu7rouyFQnC
        FFmLCTYOs87WsiVjIL6PCQJ+o8c8LiyD/T/IT3rFgX2KVePvi4d4iPoH0bXLV3FQyYBvYl9kPqILU
        qHsC9BNAA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIF8h-0003WU-A3; Wed, 09 Oct 2019 16:48:39 +0000
Subject: Re: [PATCH v1] fs/ext4/inode-test: KUnit test for ext4 inode.
To:     Iurii Zaikin <yzaikin@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        skhan@linuxfoundation.org, Theodore Ts'o <tytso@mit.edu>,
        adilger.kernel@dilger.ca
Cc:     kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>
References: <CAAXuY3rcz78vxvXbvg+wjFBFonmOx9dfweo3od6U6TaT8JVHsQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <12a4da55-24a5-919d-2def-e3bbe340136e@infradead.org>
Date:   Wed, 9 Oct 2019 09:48:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAAXuY3rcz78vxvXbvg+wjFBFonmOx9dfweo3od6U6TaT8JVHsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/8/19 7:42 PM, Iurii Zaikin wrote:
> Note: this patch is intended to be applied against kselftest/test branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test
> 
> KUnit tests for decoding extended 64 bit timestamps.
> 
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>

Whitespace in this patch (ok, I'm assuming that there was some whitespace)
is severely damaged.  I.e., gone.

> ---
>  fs/ext4/Kconfig      |  12 +++
>  fs/ext4/Makefile     |   1 +
>  fs/ext4/inode-test.c | 217 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 fs/ext4/inode-test.c
> 
> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index cbb5ca830e57..72c26abbce4c 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -106,3 +106,15 @@ config EXT4_DEBUG
>    If you select Y here, then you will be able to turn on debugging
>    with a command such as:
>   echo 1 > /sys/module/ext4/parameters/mballoc_debug
> +
> +config EXT4_INODE_KUNIT_TEST
> + bool "KUnit test for ext4 inode"
> + depends on EXT4_FS
> + depends on KUNIT
> + help

The 4 lines above should begin with a tab, not a space.

> +  This builds the ext4 inode sysctl unit test, which runs on boot.
> +  Tests the encoding correctness of ext4 inode.
> +  For more information on KUnit and unit tests in general please refer
> +  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +  If unsure, say N.

The C source file is also missing lots of tabs (indentation).


> new file mode 100644
> index 000000000000..0ecb8dd5e0c5
> --- /dev/null
> +++ b/fs/ext4/inode-test.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +
> + if (test->lower_bound)
> + return LOWER_MSB_0;
> + return UPPER_MSB_0;
> +}


-- 
~Randy
