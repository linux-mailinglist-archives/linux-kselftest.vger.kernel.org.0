Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCB34D518
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Mar 2021 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhC2Q2P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Mar 2021 12:28:15 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:14180 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229971AbhC2Q2J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Mar 2021 12:28:09 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TGQFPH017583;
        Mon, 29 Mar 2021 11:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=AdVhi5zI0A8mUb25pw92WLCOarln3osVIJknETgELSY=;
 b=X65t7pUi4Dz+3H13PPZqNANgn0Ngm9Nb8dKaRXN88Uw84pdQWe7Z9AiFhw2OSnL0bapq
 rbGerTvvfrBvH7HIYeLkJ+Sz1o8R9cO1TlvBPmbKnku5Aaap2vbY8SaWUeXqrwaU80yH
 MX+DdZdrpKe4NV6YyVLf0HbJ5G01dHxmmlzlrb29Q5IFxZTgsgyTn0vm7ZkoTaJK6bo8
 yuNhtSBFB5ta/CiJhUwUeiUX61yBfcnRphv0gWXoWisGOlU9fSU68p+oUdkp/MBuAD63
 l7M8LmIja+ko8cAjeL/zXZE22NZiek2EdgQ4lE1cHdpvJXE3teJkZVmoObgg9gFA5JL/ sQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 37kh7ur49v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 11:27:34 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 29 Mar
 2021 17:27:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 29 Mar 2021 17:27:32 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 689C911D6;
        Mon, 29 Mar 2021 16:27:32 +0000 (UTC)
Subject: Re: [PATCH v7 2/4] lib: vsprintf: Fix handling of number field widths
 in vsscanf
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>, <linux@rasmusvillemoes.dk>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20210329120824.3006-1-rf@opensource.cirrus.com>
 <20210329120824.3006-2-rf@opensource.cirrus.com>
 <YGHX73vumna0AfwD@smile.fi.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <9741fc05-52e2-378a-a7ce-9a3fff7c1340@opensource.cirrus.com>
Date:   Mon, 29 Mar 2021 17:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YGHX73vumna0AfwD@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ts7BBk4-U6MdmNSu1uAJtD316inzdGbf
X-Proofpoint-GUID: ts7BBk4-U6MdmNSu1uAJtD316inzdGbf
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290121
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 29/03/2021 14:36, Andy Shevchenko wrote:
> On Mon, Mar 29, 2021 at 01:08:22PM +0100, Richard Fitzgerald wrote:
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
>>
>> Note that where a very large number is used to mean "unlimited", the value
>> INT_MAX is used for consistency with the behaviour of vsnprintf().
> 
> ...
> 
>>   unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
>>   {
>> -	return simple_strtoull(cp, endp, base);
>> +	return simple_strntoull(cp, INT_MAX, endp, base);
> 
> Why do you need this change?
> 

I agree it's not necessary. I changed it between V1 and V2 but I can't
remember what the reason was.

