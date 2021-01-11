Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA182F1041
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jan 2021 11:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbhAKKlM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jan 2021 05:41:12 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:10406 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbhAKKlL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jan 2021 05:41:11 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10BAaMBm007129;
        Mon, 11 Jan 2021 04:39:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=d75rPZz6XfMRGET+XeZnq7haDjcGG9W0zaixbxQsXDo=;
 b=LQeQSL+GVTnq8hrA7FJamx64yiJNaDzZSgLSmSX0CDrj/NUCdYkmk5WSmXPdHiHbRFsH
 1/5UkdYJLDIcHUfhYjySI/rEAP4TDeRQlzQMvsEeQeEDnsHL7nJnvpnKvYThDQiC6pB7
 WM2uIn4dxrjk2iYH8pnvbHqQVcI0wnR5Ot9jKDa2cDVPExyUbSUrZ4x2kpVfNxf43OxV
 28ZZ5XrWfl6wbQMyr73/uhNoLNzVLcbDbo+IHM9cS1Er6W8Lr556/xm2yerTcGepPTne
 QOOPlw5qzKkSc84Yc73c/64n5k78gKyXWmCoeY2vhq2IElzUY2oNR3kereWY2I2SWEsv zA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35y9srsyd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 04:39:56 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 11 Jan
 2021 10:39:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 11 Jan 2021 10:39:54 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.3])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 79BE845;
        Mon, 11 Jan 2021 10:39:54 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] lib: vsprintf: scanf: Negative number must have
 field width > 1
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
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <f9aa8622-0c64-072b-dc44-e550460cf57f@opensource.cirrus.com>
Date:   Mon, 11 Jan 2021 10:39:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfeccM8D=DT-j4ApPAbDhDgV_M_FKOyXEMP8YBJZMed=g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=687 impostorscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110063
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/01/2021 10:36, Andy Shevchenko wrote:
> On Mon, Jan 11, 2021 at 12:28 PM Petr Mladek <pmladek@suse.com> wrote:
>>
>> Sigh, I have just realized that Andy and Rasmus, the other
>> vsprintf maintainers and reviewers, were not in CC.
>> I am sorry for not noticing this earlier.
>>
>> The patchset is ready for 5.12 from my POV.
> 
> Thanks, Petr!
> 
> I have one question, do we have a test case for that? If not, I prefer
> defer until a test case will be provided.
> 

See patch 3, numbers_prefix_overflow()
