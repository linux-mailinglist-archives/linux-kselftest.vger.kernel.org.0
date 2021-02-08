Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBAE313166
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 12:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhBHLve (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 06:51:34 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:55938 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233520AbhBHLsf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 06:48:35 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118Bkug3001347;
        Mon, 8 Feb 2021 05:47:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=wMueiZd7LSNAZyTxU0yN7RmQI4fUtqDmom2M6VNmWzo=;
 b=CjiURHl2LwIWcGa2btPxarIRbYZblzjdQr+F6OFctnYi3gTg20N3v/RB0vzgrysJs+HC
 oSPjqvuIzLbWA8KbAP9O2C2zUE6tIw+ml/2jw02WSO8FP4tfMHOiDcyoBwxk3JXlHUgl
 jOSwn9URToPAgIldo0RAYqZI3VeAAldhZdcDG3Eg//ZzK4nffd6kjI8hDbWTJPG+AYAs
 K7tlH2CS8/FH7LutmVlW+Q9QkgcseQlUlZrWrF9qnfn/g0910XzPN//cDJI/7PPx7aXx
 mNjsriwT4z2LC6niCoh5NCTqXO5tu9G0BF3DhQPjeFNcrQUFuh21GYjK1AYiNWRmQ0ix Hg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36jdac94qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 05:47:20 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 8 Feb 2021
 11:47:18 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 8 Feb 2021 11:47:18 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.240])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CF3FB45;
        Mon,  8 Feb 2021 11:47:17 +0000 (UTC)
Subject: Re: [PATCH v4 2/4] lib: vsprintf: Fix handling of number field widths
 in vsscanf
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <rostedt@goodmis.org>, <sergey.senozhatsky@gmail.com>,
        <linux@rasmusvillemoes.dk>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20210203165009.6299-1-rf@opensource.cirrus.com>
 <20210203165009.6299-2-rf@opensource.cirrus.com>
 <YBr9c44Dvq1ZNrEa@smile.fi.intel.com> <YBwiQ+l6yqs+g+rr@alley>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <6023974a-a2ba-8bfe-a8b8-125c45e13e01@opensource.cirrus.com>
Date:   Mon, 8 Feb 2021 11:47:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBwiQ+l6yqs+g+rr@alley>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080081
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/02/2021 16:35, Petr Mladek wrote:
> On Wed 2021-02-03 21:45:55, Andy Shevchenko wrote:
>> On Wed, Feb 03, 2021 at 04:50:07PM +0000, Richard Fitzgerald wrote:
>>> The existing code attempted to handle numbers by doing a strto[u]l(),
>>> ignoring the field width, and then repeatedly dividing to extract the
>>> field out of the full converted value. If the string contains a run of
>>> valid digits longer than will fit in a long or long long, this would
>>> overflow and no amount of dividing can recover the correct value.
> 
>> ...
>>
>>> +	for (; max_chars > 0; max_chars--) {
>>
>> Less fragile is to write
>>
>> 	while (max_chars--)
> 
> Except that the original was more obvious at least for me.
> I always prefer more readable code when the compiler might do
> the optimization easily. But this is my personal taste.
> I am fine with both variants.
> 
>>
>> This allows max_char to be an unsigned type.
>>
>> Moreover...
>>
>>> +	return _parse_integer_limit(s, base, p, INT_MAX);
>>
>> You have inconsistency with INT_MAX vs, size_t above.
> 
> Ah, this was on my request. INT_MAX is already used on many other
> locations in vsnprintf() for this purpose.
> 

Strictly speaking this should be SIZE_MAX because the argument is a
size_t.
