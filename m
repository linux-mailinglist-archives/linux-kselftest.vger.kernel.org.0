Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F002F1054
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jan 2021 11:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbhAKKpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jan 2021 05:45:23 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:7008 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726734AbhAKKpW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jan 2021 05:45:22 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10BAhIJT028734;
        Mon, 11 Jan 2021 04:43:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=R2NyNxmDNBn2BvOFOrA6muYWwv5pqAnTc69UGv/oRpw=;
 b=qVviJ/Ezp9ybVKOpyfkQwDiJHkONuotJt+dXmRNiUz0KpTNKCg294SqiqwDt8HGM7jLh
 jVAzH2KvNcyD3Ux/WwhlHz7dhZGJCWycMkSQ/nMGfPYned0H6Bj4tKJlrwvjSW6ezwIs
 9DlfcIyiPcyGd6uaRRpPlYxV+Jw2W76pT4PYmrcefbFLeKNbk0bycvcZFG1egRExDZpX
 iwolPh8L3t77kBMZI0rLaeyVGFsIajQ8ls2k7j6Le9jjaQGOrjnuxjgfnc4gyzL0LCXz
 ks9Z95lm83ldYj9e0IGLO3FNLI2D6NfugmURsPt+VAdCANNmXZgubSrelG7hoo/vbzOs dw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 35yas722fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 04:43:18 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 11 Jan
 2021 10:43:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 11 Jan 2021 10:43:16 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.3])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B0C8245;
        Mon, 11 Jan 2021 10:43:15 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] lib: vsprintf: scanf: Negative number must have
 field width > 1
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Petr Mladek <pmladek@suse.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>, <patches@opensource.cirrus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20201217180057.23786-1-rf@opensource.cirrus.com>
 <X/wnoJLEt0zQskDU@alley>
 <CAHp75VfeccM8D=DT-j4ApPAbDhDgV_M_FKOyXEMP8YBJZMed=g@mail.gmail.com>
 <f9aa8622-0c64-072b-dc44-e550460cf57f@opensource.cirrus.com>
Message-ID: <395b37b8-d9b2-1825-8e57-9e1b74aa7502@opensource.cirrus.com>
Date:   Mon, 11 Jan 2021 10:43:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f9aa8622-0c64-072b-dc44-e550460cf57f@opensource.cirrus.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=630 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110064
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/01/2021 10:39, Richard Fitzgerald wrote:
> On 11/01/2021 10:36, Andy Shevchenko wrote:
>> On Mon, Jan 11, 2021 at 12:28 PM Petr Mladek <pmladek@suse.com> wrote:
>>>
>>> Sigh, I have just realized that Andy and Rasmus, the other
>>> vsprintf maintainers and reviewers, were not in CC.
>>> I am sorry for not noticing this earlier.
>>>
>>> The patchset is ready for 5.12 from my POV.
>>
>> Thanks, Petr!
>>
>> I have one question, do we have a test case for that? If not, I prefer
>> defer until a test case will be provided.
>>
> 
> See patch 3, numbers_prefix_overflow()

Sorry, I missed you off the original mailing so you won't have
seen the other patches.
Patch 3 with the test cases is here:
https://lore.kernel.org/lkml/X%2FwnoJLEt0zQskDU@alley/T/#mf2ffba20126e438bea7af171bc78fdbebdb40027
