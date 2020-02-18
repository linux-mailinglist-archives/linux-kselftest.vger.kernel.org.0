Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB47F16353E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2020 22:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgBRVlZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Feb 2020 16:41:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44824 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgBRVlW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Feb 2020 16:41:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01ILVIOI077875;
        Tue, 18 Feb 2020 21:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Z6ygooUUXhz1hWqQYcQAJibC6Prp+WjFAbn5QtklRpQ=;
 b=a/6pOGctOeiz0VWq1GZU7ZfLtgCuJcMaDVZaLjz+RqXCYbfveMvQeSyaMINDAT0EHEaU
 qhrR4bD4f7fE98UGs8SMdYP+36Yl+GhQzcVLZF+2iztpbFQi9U1+VRfYcIkRM3SZlEQq
 A5EuTuKmO/+DbUB+MntQ6fkD/YzkGkZ/jotVM4qmIQnfBxkUMWb31KVAcvsWC4x2eSeV
 LFLMkV2t6YRMBivdQxuvhLFEcboKbCR2EhQ+KWjCVm5WmC3PXgdZq+U8Q9+UwYL6bCjo
 gde8v2a4reLHvUF9WkMOwpJpnZhhR12QJBPp4ZJXa98UEuPJn6RZxK3w0WIaKjRDUqB7 Jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2y8e1hmk1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 21:41:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01ILbbnv078918;
        Tue, 18 Feb 2020 21:41:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2y6tc34s2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 21:41:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01ILfD76013208;
        Tue, 18 Feb 2020 21:41:13 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 13:41:12 -0800
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
To:     Mina Almasry <almasrymina@google.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
 <1582035660.7365.90.camel@lca.pw>
 <CAHS8izO5=vKs-v9v=Di3hQXBD41+_YpYarXn1yZu9YE6SR-i6Q@mail.gmail.com>
 <d498012a-ec87-ca48-ed78-5fcdaf372888@oracle.com>
 <CAHS8izPbMizJMNB-y9y2OViXYLStA6VT-HkWRd2hCS-5JSMwSA@mail.gmail.com>
 <CAHS8izODfKaLqWAehhR_XuN=FRgmWBE7+eCJMD2HGig8s+zvwg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9d6690e9-0dd4-f779-89b2-e02ff9a517e4@oracle.com>
Date:   Tue, 18 Feb 2020 13:41:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHS8izODfKaLqWAehhR_XuN=FRgmWBE7+eCJMD2HGig8s+zvwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 suspectscore=27 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=27 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180140
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/20 1:36 PM, Mina Almasry wrote:
> On Tue, Feb 18, 2020 at 11:25 AM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Tue, Feb 18, 2020 at 11:14 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> On 2/18/20 10:35 AM, Mina Almasry wrote:
>>>> On Tue, Feb 18, 2020 at 6:21 AM Qian Cai <cai@lca.pw> wrote:
>>>>>
>>>>> On Tue, 2020-02-11 at 15:19 -0800, Andrew Morton wrote:
>>>>>> On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
>>>>>>
>>>>> [ 7933.806377][T14355] ------------[ cut here ]------------
>>>>> [ 7933.806541][T14355] kernel BUG at mm/hugetlb.c:490!
>>>>> VM_BUG_ON(t - f <= 1);
>>>>> [ 7933.806562][T14355] Oops: Exception in kernel mode, sig: 5 [#1]
>>> <snip>
>>>> Hi Qian,
>>>>
>>>> Yes this VM_BUG_ON was added by a patch in the series ("hugetlb:
>>>> disable region_add file_region coalescing") so it's definitely related
>>>> to the series. I'm taking a look at why this VM_BUG_ON fires. Can you
>>>> confirm you reproduce this by running hugemmap06 from the ltp on a
>>>> powerpc machine? Can I maybe have your config?
>>>>
>>>> Thanks!
>>>
>>> Hi Mina,
>>>
>>> Looking at the region_chg code again, we do a
>>>
>>>         resv->adds_in_progress += *out_regions_needed;
>>>
>>> and then potentially drop the lock to allocate the needed entries.  Could
>>> anopther thread (only adding reservation for a single page) then come in
>>> and notice that there are not enough entries in the cache and hit the
>>> VM_BUG_ON()?
>>
>> Maybe. Also I'm thinking the code thinks actual_regions_needed >=
>> in_regions_needed, but that doesn't seem like a guarantee. I think
>> this call sequence with the same t->f range would violate that:
>>
>> region_chg (regions_needed=1)
>> region_chg (regions_needed=1)
>> region_add (fills in the range)
>> region_add (in_regions_needed = 1, actual_regions_needed = 0, so
>> assumptions in the code break).
>>
>> Luckily it seems the ltp readily reproduces this, so I'm working on
>> reproducing it. I should have a fix soon, at least if I can reproduce
>> it as well.
> 
> I had a bit of trouble reproducing this but I got it just now.
> 
> Makes sense I've never run into this even though others can readily
> reproduce it. I happen to run my kernels on a pretty beefy 36 core
> machine and in that setup things seem to execute fast and there is
> never a queue of pending file_region inserts into the resv_map. Once I
> limited qemu to only use 2 cores I ran into the issue right away.
> Looking into a fix now.

This may not be optimal, but it resolves the issue for me.  I just put it
together to test the theory that the region_chg code was at fault.
-- 
Mike Kravetz

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 45219cb58ac7..f750f95ed37a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -549,6 +549,7 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	struct file_region *trg = NULL, *rg = NULL;
 	long chg = 0, i = 0, to_allocate = 0;
 	struct list_head allocated_regions;
+	long calc_adds_in_progress = 0;
 
 	INIT_LIST_HEAD(&allocated_regions);
 
@@ -561,14 +562,14 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	if (*out_regions_needed == 0)
 		*out_regions_needed = 1;
 
-	resv->adds_in_progress += *out_regions_needed;
+	calc_adds_in_progress = resv->adds_in_progress + *out_regions_needed;
 
 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
 	 * the number of in progress add operations.
 	 */
-	while (resv->region_cache_count < resv->adds_in_progress) {
-		to_allocate = resv->adds_in_progress - resv->region_cache_count;
+	while (resv->region_cache_count < calc_adds_in_progress) {
+		to_allocate = calc_adds_in_progress - resv->region_cache_count;
 
 		/* Must drop lock to allocate a new descriptor. Note that even
 		 * though we drop the lock here, we do not make another call to
@@ -593,8 +594,20 @@ static long region_chg(struct resv_map *resv, long f, long t,
 			list_add(&rg->link, &resv->region_cache);
 			resv->region_cache_count++;
 		}
+
+		chg = add_reservation_in_range(resv, f, t, NULL, NULL,
+				       out_regions_needed, true);
+
+		if (*out_regions_needed == 0)
+			*out_regions_needed = 1;
+
+		calc_adds_in_progress = resv->adds_in_progress +
+					*out_regions_needed;
+
 	}
 
+	resv->adds_in_progress += *out_regions_needed;
+
 	spin_unlock(&resv->lock);
 	return chg;
