Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52AAB159BAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 22:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgBKVvn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 16:51:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgBKVvn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 16:51:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BLh2m5065691;
        Tue, 11 Feb 2020 21:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=q9CJH8blGd3JpsYmKV23Sgj8OEPJrRzAG9QrB6xaUUE=;
 b=gTnVVwFTBUdHJ9eyfYo5Hmcz5SmP6JFCX2FdoK9AAaKAy4pE/nPnVjvP2xA7yiAfSd51
 SV13Y+41lw/40Kz8+mkudhl4f25TKjG6pcLy27qm48RMTaC31bmONVIJdhxVoo6f3goM
 C+YrHyyim7kYOG4Zw1kkJb0PCJVT/QrAg1sN1TutWMj6YwjBqqkHVBWAJyf4LfxJN06C
 rH742UiXRU9FP7n9X6y6xBK/4QFovcvcwQZfpxznZUnsuJN0op3wgzcN8edxuaS1tjHD
 KQQdbyS8QaaV1L8dDKyhbmpWXBuTF6xK/4sVabr5eeelDDl4MbC9owbEyJZZZAUOOpXF vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y2p3se9s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 21:51:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BLgcbM108989;
        Tue, 11 Feb 2020 21:51:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2y26q21sym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 21:51:35 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01BLpYhE024620;
        Tue, 11 Feb 2020 21:51:34 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Feb 2020 13:51:34 -0800
Subject: Re: [PATCH v11 6/9] hugetlb_cgroup: support noreserve mappings
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-6-almasrymina@google.com>
 <6cc406e7-757f-4922-ffc0-681df3ee0d18@oracle.com>
 <CAHS8izMGreJgOhG8ivE2OH9bq98BmvxAqtBc=M9waTqOKv3eeQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6b097a9d-3b2c-94cb-21a8-7e7a55a8f635@oracle.com>
Date:   Tue, 11 Feb 2020 13:51:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHS8izMGreJgOhG8ivE2OH9bq98BmvxAqtBc=M9waTqOKv3eeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 suspectscore=2 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=2 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110141
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/11/20 1:35 PM, Mina Almasry wrote:
> On Thu, Feb 6, 2020 at 2:31 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>> On 2/3/20 3:22 PM, Mina Almasry wrote:
>>> +++ b/mm/hugetlb.c
>>> @@ -1339,6 +1339,9 @@ static void __free_huge_page(struct page *page)
>>>       clear_page_huge_active(page);
>>>       hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
>>>                                    page, false);
>>> +     hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
>>> +                                  page, true);
>>> +
>>
>> When looking at the code without change markings, the two above lines
>> look so similar my first thought is there must be a mistake.
>>
>> A suggestion for better code readability:
>> - hugetlb_cgroup_uncharge_page could just take "struct hstate *h" and
>>   get both hstate_index(h) and pages_per_huge_page(h).
>> - Perhaps make hugetlb_cgroup_uncharge_page and
>>   hugetlb_cgroup_uncharge_page_rsvd be wrappers around a common routine.
>>   Then the above would look like:
>>
>>   hugetlb_cgroup_uncharge_page(h, page);
>>   hugetlb_cgroup_uncharge_page_rsvd(h, page);
>>
> 
> I did modify the interfaces to this, as it's much better for
> readability indeed. Unfortunately the patch the adds interfaces
> probably needs a re-review now as it's changed quite a bit, I did not
> carry your or David's Reviewed-by.

No worries.  Happy to review again.

-- 
Mike Kravetz
