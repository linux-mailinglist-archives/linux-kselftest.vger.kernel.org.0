Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19F310A4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 12:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhBELb4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 06:31:56 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:32626 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230027AbhBEL3q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 06:29:46 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115BSFq2004235;
        Fri, 5 Feb 2021 05:28:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=P/nKtm70jcfgEK5FVGoDF6sOOwQmjlSIa5dj9WrOzeM=;
 b=XdummJo6S2uaRhgAZxDmlULeFqtdAnO2ayU86UEZuo7NuHUvyu7b4CNtmb/eSvM9jcom
 a1WxET+BdTDFyNOmAxHtwvRY9Vt+dPNR65rkdIu54h/hTjT+DbkDFOz2n3ZCWu7LFZAf
 /eedl/o9+IitLmaTl7iRyKBqoACsbOnZmyoA9Fql9Eds/ZsRyUz/seNcQt3FQnQAO2Ec
 dADfyjaiVou0coKwSVGiF/Ns0UtS8zrtdij2cdq7Kips36Hs2Pdw6Es9ebsV+hgauF7w
 pXeHdzgVEX5Q1gFZ5spypYjyg1L+RnyY1LOq4MMrlDqg/o0y3uVFnxVH1qpSSCJUNBwd SQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36d4rtr9pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Feb 2021 05:28:18 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 5 Feb 2021
 11:28:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 5 Feb 2021 11:28:16 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.178])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 414392AB;
        Fri,  5 Feb 2021 11:28:16 +0000 (UTC)
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
Message-ID: <5bfefab6-7a1b-6f5f-319c-8897dbb79a5b@opensource.cirrus.com>
Date:   Fri, 5 Feb 2021 11:28:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBwiQ+l6yqs+g+rr@alley>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050075
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

I originally had UINT_MAX and changed on Petr's request to be
consistent with other code. (Sorry Andy - my mistake not including
you on the earlier review versions).

But 0 < INT_MAX < UINT_MAX, so ok to pass to an unsigned. And as Petr
said on his original review, INT_MAX is "big enough".

I don't mind either way.

> An alternative is to fix all the other locations. We would need to
> check if it is really safe. Well, I do not want to force Richard
> to fix this historical mess. He already put a lot lot of effort
> into fixing this long term issue.
> 
> ...
> 
>>> -	unsigned long long result;
>>> +	const char *cp;
>>> +	unsigned long long result = 0ULL;
>>>   	unsigned int rv;
>>>   
>>> -	cp = _parse_integer_fixup_radix(cp, &base);
>>> -	rv = _parse_integer(cp, base, &result);
>>
>>> +	if (max_chars == 0) {
>>> +		cp = startp;
>>> +		goto out;
>>> +	}
>>
>> It's redundant if I'm not mistaken.
> 
> Also this is more obvious and less error prone from my POV.
> But I agree that it is redundant. I am not sure if this
> function is used in some fast paths.
> 
> Again I am fine with both variants.
> 
>>> +	cp = _parse_integer_fixup_radix(startp, &base);
>>> +	if ((cp - startp) >= max_chars) {
>>> +		cp = startp + max_chars;
>>> +		goto out;
>>> +	}
>>
>> This will be exactly the same, no?
> 
> Best Regards,
> Petr
> 
