Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB62DAEF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 15:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgLOO2Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 09:28:24 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:11302 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729471AbgLOO2R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 09:28:17 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFENqAT028531;
        Tue, 15 Dec 2020 08:26:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=n346iSyEamQWA/gBzJXauy4oQqN9IxZ/zPmo49LvrpM=;
 b=bDnjEP+CTe7XIbUOOnAlXe82KY/+zUkVGcH+lD1sQsLhqHIo1IERgfZ6nUwztpTDf+V1
 5low3CG/f5de+zJldwwZrZoIcCMVUD9lyRCO4vjwGB8Gwi2XX95+EkdwVwsbI4NP012/
 NWVkC7yn7M5IoJFKg/QISwItuXduXP3bm7u2l0Q4PAfgnal0wbfjHuQk0faCTdYi0cEI
 kJNy9VfpnvzOJsgb8S2FpK+Wdb8Ruuy1lcxx4nrYs+RkSqwUWaBWCK/nGSQdbYzTipLp
 7Grb40ZiS33xGBKLFNcBCQG41V76NOtDCqmu3DtqDv8ozcum3f7y6Ed44jLPfpg0ur+G +g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35cu5rusw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Dec 2020 08:26:55 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 15 Dec
 2020 14:26:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 15 Dec 2020 14:26:54 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.236])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EF3352AB;
        Tue, 15 Dec 2020 14:26:53 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] lib: test_scanf: Add tests for sscanf number
 conversion
To:     Petr Mladek <pmladek@suse.com>
CC:     <rostedt@goodmis.org>, <sergey.senozhatsky@gmail.com>,
        <shuah@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20201130145800.19960-1-rf@opensource.cirrus.com>
 <20201130145800.19960-2-rf@opensource.cirrus.com> <X9DcEL54k0qRayr+@alley>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <f3e97a68-71fe-c077-5add-a6c0fb397032@opensource.cirrus.com>
Date:   Tue, 15 Dec 2020 14:26:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X9DcEL54k0qRayr+@alley>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=921 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150103
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 09/12/2020 14:15, Petr Mladek wrote:
> On Mon 2020-11-30 14:57:58, Richard Fitzgerald wrote:
>> Adds test_sscanf to test various number conversion cases, as
>> number conversion was previously broken.
>>
>> This also tests the simple_strtoxxx() functions exported from
>> vsprintf.c.
> 
> It is impressive.
> 
> Honestly, I do not feel to be expert on testing and mathematics.
> I am not sure how comprehensive the test is. Also I am not
> sure what experts would say about the tricks with random
> numbers.
> 
> Anyway, this is much more than what I have expected. And it checks
> great number of variants and corner cases.
> 
> I suggest only one small change, see below.
> 
>> --- /dev/null
>> +++ b/lib/test_scanf.c
>> @@ -0,0 +1,747 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Test cases for sscanf facility.
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/overflow.h>
>> +#include <linux/printk.h>
>> +#include <linux/random.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +
>> +#include "../tools/testing/selftests/kselftest_module.h"
>> +
>> +#define BUF_SIZE 1024
>> +
>> +static unsigned total_tests __initdata;
>> +static unsigned failed_tests __initdata;
>> +static char *test_buffer __initdata;
>> +static char *fmt_buffer __initdata;
>> +static struct rnd_state rnd_state __initdata;
>> +
>> +typedef int (*check_fn)(const void *check_data, const char *string,
>> +			const char *fmt, int n_args, va_list ap);
>> +
>> +static void __scanf(4, 6) __init
>> +_test(check_fn fn, const void *check_data, const char *string, const char *fmt,
>> +	int n_args, ...)
>> +{
>> +	va_list ap, ap_copy;
>> +	int ret;
>> +
>> +	total_tests++;
>> +
>> +	va_start(ap, n_args);
>> +	va_copy(ap_copy, ap);
>> +	ret = vsscanf(string, fmt, ap_copy);
>> +	va_end(ap_copy);
>> +
>> +	if (ret != n_args) {
>> +		pr_warn("vsscanf(\"%s\", \"%s\", ...) returned %d expected %d\n",
>> +			string, fmt, ret, n_args);
>> +		goto fail;
>> +	}
>> +
>> +	ret = (*fn)(check_data, string, fmt, n_args, ap);
>> +	if (ret)
>> +		goto fail;
>> +
>> +	va_end(ap);
>> +
>> +	return;
>> +
>> +fail:
>> +	failed_tests++;
>> +	va_end(ap);
>> +}
>> +
>> +#define test_one_number(T, gen_fmt, scan_fmt, val, fn)			\
>> +do {									\
>> +	const T expect_val = (T)(val);					\
>> +	T result = ~expect_val; /* should be overwritten */		\
> 
> If I get it correctly, this is supposed to initialize the temporary
> variable with a value that is different from the expected value.
> It will cause test failure when it is not updated by vsscanf().
> 
> It does not work for zero value. A better solution might be to add

That's a ~, not a -
~0 = 0xFFFFFFFF
~-1 = 0

> a constant, for example:
> 
> 	T result = expect_val + 3; /* do not match when not overwritten */ \
> 
> I did not use "+ 1" intentionally because it might hide some overflow
> issues.
> 
>> +									\
>> +	snprintf(test_buffer, BUF_SIZE, gen_fmt, expect_val);		\
>> +	_test(fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);	\
>> +} while (0)
> 
> Otherwise, it looks good to me.
> 
> Best Regards,
> Petr
> 
