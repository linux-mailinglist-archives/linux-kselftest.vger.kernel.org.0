Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC48A2F103B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jan 2021 11:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbhAKKjO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jan 2021 05:39:14 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:35152 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729262AbhAKKjO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jan 2021 05:39:14 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10BAaTSV021215;
        Mon, 11 Jan 2021 04:38:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=/H9/v8UvB/8fENNOUd3b/AVD3Pd1y0ND28qEFt38ZwE=;
 b=diKBApuyNKhKj+H9XpIcbLARP4LKaWYIALkT75WsYAW0SxU5t/RaO81BEH8hk2I23yOm
 CVxDbjhqsaJyRRNKjHYgysyexQml2oTFAZXFPVCOHKawsLpdCVkr1jihK25alsAASErA
 xZkbFFrnC66XPkpC6icXORwkqoJl9/2CL9jy27oiLbx7nG4EkPytpX2H/v5K6UQg54Fr
 xmVcCM0Bvd+l7/W/1CzKXySK+lExe/osqLMkJ2Ugd0iNq2ZcFWSl1BQ20CA9rCHw2y1E
 lKWhiVPl6qDF4xuq8XP+VGYjI7z7qYH6tyWpr5uyEXuQp3UYc1mwsZHCNjv/2nmgG5xF mw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 35yas722bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 04:38:00 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 11 Jan
 2021 10:37:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 11 Jan 2021 10:37:58 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.3])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C225C45;
        Mon, 11 Jan 2021 10:37:57 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] lib: vsprintf: scanf: Negative number must have
 field width > 1
To:     Petr Mladek <pmladek@suse.com>
CC:     <rostedt@goodmis.org>, <sergey.senozhatsky@gmail.com>,
        <shuah@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20201217180057.23786-1-rf@opensource.cirrus.com>
 <X/wnoJLEt0zQskDU@alley>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <6e390f96-b813-fcf8-f159-c22595b563a3@opensource.cirrus.com>
Date:   Mon, 11 Jan 2021 10:37:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/wnoJLEt0zQskDU@alley>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=694 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110063
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/01/2021 10:25, Petr Mladek wrote:
> Sigh, I have just realized that Andy and Rasmus, the other
> vsprintf maintainers and reviewers, were not in CC.

Sorry, probably my fault. I sent to the maintainers and lists reported
by get_maintainers.sh. I guess I missed that "reviewers" should also
be directly mailed.

> I am sorry for not noticing this earlier.
> 
> The patchset is ready for 5.12 from my POV.
> 
> Best Regards,
> Petr
> 
> On Thu 2020-12-17 18:00:54, Richard Fitzgerald wrote:
>> If a signed number field starts with a '-' the field width must be > 1,
>> or unlimited, to allow at least one digit after the '-'.
>>
>> This patch adds a check for this. If a signed field starts with '-'
>> and field_width == 1 the scanf will quit.
>>
>> It is ok for a signed number field to have a field width of 1 if it
>> starts with a digit. In that case the single digit can be converted.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   lib/vsprintf.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>> index 14c9a6af1b23..8954ff94a53c 100644
>> --- a/lib/vsprintf.c
>> +++ b/lib/vsprintf.c
>> @@ -3433,8 +3433,12 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>>   		str = skip_spaces(str);
>>   
>>   		digit = *str;
>> -		if (is_sign && digit == '-')
>> +		if (is_sign && digit == '-') {
>> +			if (field_width == 1)
>> +				break;
>> +
>>   			digit = *(str + 1);
>> +		}
>>   
>>   		if (!digit
>>   		    || (base == 16 && !isxdigit(digit))
>> -- 
>> 2.20.1
