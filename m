Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A00313BBA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 18:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhBHR4M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 12:56:12 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:19734 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235003AbhBHRyw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 12:54:52 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118HlEZT030177;
        Mon, 8 Feb 2021 11:53:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=Z1wCX52pPOBYgyZ35b58ckzQUQVq2ROG0qk4Mg5MZNo=;
 b=lCXeD630BD/WGTElhtH/Fniki7RTJIf0hRiRPEQU80PhVZuqDNDhyo6q2AR8TCpy2v9H
 u9DvdKoBwszdJWiuoMOYXqiR/VTouYQG+wGfs1mQ/moYIgszO6NY11DC8g+J/uxQGfZz
 KIDQ1fz89gjNd3q1Qb/ZwUXfhsC9Gdq6wjFOnxez/Ner6BcB1QSmmgRfVcozHbrJTIwQ
 QTzBKgCDD1ZqOf3L7NxE+p6qzfpfL6Quof13sgk1JdKEci/3htgeEVI2aV/90d80zu/y
 NL4Uc/svjQ6sYqcQBt5w3wwYoHgmjIgVNok074xtaLBqSN4OiEs6TLckv2qhp57u4nvS IA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36hrv2atsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 11:53:34 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 8 Feb 2021
 17:38:30 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 8 Feb 2021 17:38:30 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.240])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A484311CA;
        Mon,  8 Feb 2021 17:38:29 +0000 (UTC)
Subject: Re: [PATCH v5 2/4] lib: vsprintf: Fix handling of number field widths
 in vsscanf
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>, <linux@rasmusvillemoes.dk>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20210208140154.10964-1-rf@opensource.cirrus.com>
 <20210208140154.10964-2-rf@opensource.cirrus.com>
 <YCFWRp8a0sw3mUSI@smile.fi.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <2f9f57a3-f0d6-1e07-36f9-682d65b481ad@opensource.cirrus.com>
Date:   Mon, 8 Feb 2021 17:38:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCFWRp8a0sw3mUSI@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080111
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/02/2021 15:18, Andy Shevchenko wrote:
> On Mon, Feb 08, 2021 at 02:01:52PM +0000, Richard Fitzgerald wrote:
>> The existing code attempted to handle numbers by doing a strto[u]l(),
>> ignoring the field width, and then repeatedly dividing to extract the
>> field out of the full converted value. If the string contains a run of
>> valid digits longer than will fit in a long or long long, this would
>> overflow and no amount of dividing can recover the correct value.
>>
>> This patch fixes vsscanf() to obey number field widths when parsing
>> the number.
>>
>> A new _parse_integer_limit() is added that takes a limit for the number
>> of characters to parse. The number field conversion in vsscanf is changed
>> to use this new function.
>>
>> If a number starts with a radix prefix, the field width  must be long
>> enough for at last one digit after the prefix. If not, it will be handled
>> like this:
>>
>>   sscanf("0x4", "%1i", &i): i=0, scanning continues with the 'x'
>>   sscanf("0x4", "%2i", &i): i=0, scanning continues with the '4'
>>
>> This is consistent with the observed behaviour of userland sscanf.
>>
>> Note that this patch does NOT fix the problem of a single field value
>> overflowing the target type. So for example:
>>
>>    sscanf("123456789abcdef", "%x", &i);
>>
>> Will not produce the correct result because the value obviously overflows
>> INT_MAX. But sscanf will report a successful conversion.
> 
> 
> I have a few nit-picks, but it's up to you and maintainers how to proceed.
> 
> ...
> 
>> -unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
>> +static unsigned long long simple_strntoull(const char *startp, size_t max_chars,
>> +					   char **endp, unsigned int base)
>>   {
>> -	unsigned long long result;
>> +	const char *cp;
>> +	unsigned long long result = 0ULL;
>>   	unsigned int rv;
>>   
>> -	cp = _parse_integer_fixup_radix(cp, &base);
>> -	rv = _parse_integer(cp, base, &result);
>> +	cp = _parse_integer_fixup_radix(startp, &base);
>> +	if ((cp - startp) >= max_chars) {
>> +		cp = startp + max_chars;
>> +		goto out;
>> +	}
>> +
>> +	max_chars -= (cp - startp);
>> +	rv = _parse_integer_limit(cp, base, &result, max_chars);
>>   	/* FIXME */
>>   	cp += (rv & ~KSTRTOX_OVERFLOW);
>>   
>> +out:
>>   	if (endp)
>>   		*endp = (char *)cp;
>>   
>>   	return result;
>>   }
> 
> A nit-pick: What if we rewrite above as
> 
> static unsigned long long simple_strntoull(const char *cp, size_t max_chars,
> 					   char **endp, unsigned int base)
> {
> 	unsigned long long result = 0ULL;
> 	const char *startp = cp;
> 	unsigned int rv;
> 	size_t chars;
> 
> 	cp = _parse_integer_fixup_radix(cp, &base);
> 	chars = cp - startp;
> 	if (chars >= max_chars) {
> 		/* We hit the limit */
> 		cp = startp + max_chars;
> 	} else {
> 		rv = _parse_integer_limit(cp, base, &result, max_chars - chars);
> 		/* FIXME */
> 		cp += (rv & ~KSTRTOX_OVERFLOW);
> 	}
> 
> 	if (endp)
> 		*endp = (char *)cp;
> 
> 	return result;
> }
> 
> ...


I don't mind rewriting that code if you prefer that way.
I am used to working on other kernel subsytems where the preference is
to bail out on the error case so that the "normal" case flows without
nesting.

> 
>> +static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
>> +				 unsigned int base)
>> +{
>> +	/*
>> +	 * simple_strntoull safely handles receiving max_chars==0 in the
>> +	 * case we start with max_chars==1 and find a '-' prefix.
> 
> A nit-pick: Spaces surrounding '=='? simple_strntoull -> simple_strntoull()?
> 
>> +	 */
> 
> Above misses to add something like:
> 
> "Otherwise we hit the '-' as an illegal number in the following
> simple_strntoull() call."
> 
>> +	if (*cp == '-' && max_chars > 0)
>> +		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
>> +
>> +	return simple_strntoull(cp, max_chars, endp, base);
> 
> 
>> +}
> 
> ...
> 
>> +			val.s = simple_strntoll(str,
>> +						field_width > 0 ? field_width : SIZE_MAX,
>> +						&next, base);
> 
> A nit-pick: Wouldn't be negative field_width "big enough" to just being used as

field_width is s16 so really should be sign-extended to make it "very
big". I think this would be less readable what the intention is and what
assumptions it is based on. There's a risk someone would look at

(size_t)(long)field_width

and think the (long) is redundant.
Perhaps change field_width to int? There I ask myself "if it can be an
int, why is it declared s16?" and worry there is something subtle in the
code.

My personal preference is to avoid using tricks in code that isn't time
critical.

 > is? Also, is field_width == 0 should be treated as "parse to the MAX"?
 >
 > ...

Earlier code terminates scanning if the width parsed from the format
string is <= 0. So field_width can only be -1 or > 0 here. But now you
point it out, that test would be better as field_width >= 0 ... so
it deals with 0 if it ever happened to sneak through to here somehow.

> 
>> +			val.u = simple_strntoull(str,
>> +						 field_width > 0 ? field_width : SIZE_MAX,
>> +						 &next, base);
> 
> Ditto.
> 
