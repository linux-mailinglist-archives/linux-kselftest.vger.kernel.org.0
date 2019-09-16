Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2352B44C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 01:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfIPX5k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 19:57:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43754 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbfIPX5j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 19:57:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GNnx84096081;
        Mon, 16 Sep 2019 23:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=IuSLh0fb/BvGl8pVix7sy0MqWGyNSfMj/T9waRFCoi8=;
 b=Tl3ojxBSLNTUyPlp46F0uqZ9+/J9tk6YWvuggRkE92WBOn3WxBpiam3c9Z1CvBLiV1pt
 r4GLLmcvDbTKOvsl9CphukxDVJCHsFkY0V8F7IkXWmAS0joTBNXJWCPwH07xRCRqgvU+
 9ac1clwPeFGamvbU1FKqYV8dPEArhoQuD9z9HST34oU4i6COHUwmF2fEfJMxbwv/ujid
 bW5jXOXoTaI6wLbG1Vr3UwqZd3GUxWMdhxeBDBicSYxqhekT1N3XkXuvwhyFHNDsSpnU
 Vev/1ep5bPue2h9jdCJ7Y06i/J/ZHcp1GDtGAxemTiAOJE/SGtHj/jENTVkorZWGQ1KH /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v0r5pamr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 23:57:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GNrlI0014393;
        Mon, 16 Sep 2019 23:57:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2v0p8vakx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 23:57:07 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8GNv6Cb025921;
        Mon, 16 Sep 2019 23:57:06 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 16:57:06 -0700
Subject: Re: [PATCH v4 6/9] hugetlb: disable region_add file_region coalescing
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
References: <20190910233146.206080-1-almasrymina@google.com>
 <20190910233146.206080-7-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <abe11781-7267-e54e-0b81-46dc4ea6d5a4@oracle.com>
Date:   Mon, 16 Sep 2019 16:57:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190910233146.206080-7-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160227
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160227
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/10/19 4:31 PM, Mina Almasry wrote:
> A follow up patch in this series adds hugetlb cgroup uncharge info the
> file_region entries in resv->regions. The cgroup uncharge info may
> differ for different regions, so they can no longer be coalesced at
> region_add time. So, disable region coalescing in region_add in this
> patch.
> 
> Behavior change:
> 
> Say a resv_map exists like this [0->1], [2->3], and [5->6].
> 
> Then a region_chg/add call comes in region_chg/add(f=0, t=5).
> 
> Old code would generate resv->regions: [0->5], [5->6].
> New code would generate resv->regions: [0->1], [1->2], [2->3], [3->5],
> [5->6].
> 
> Special care needs to be taken to handle the resv->adds_in_progress
> variable correctly. In the past, only 1 region would be added for every
> region_chg and region_add call. But now, each call may add multiple
> regions, so we can no longer increment adds_in_progress by 1 in region_chg,
> or decrement adds_in_progress by 1 after region_add or region_abort. Instead,
> region_chg calls add_reservation_in_range() to count the number of regions
> needed and allocates those, and that info is passed to region_add and
> region_abort to decrement adds_in_progress correctly.

Hate to throw more theoretical examples at you but ...

Consider an existing reserv_map like [3-10]
Then a region_chg/add call comes in region_chg/add(f=0, t=10).
The region_chg is going to return 3 (additional reservations needed), and
also out_regions_needed = 1 as it would want to create a region [0-3].
Correct?
But, there is nothing to prevent another thread from doing a region_del [5-7]
after the region_chg and before region_add.  Correct?
If so, it seems the region_add would need to create two regions, but there
is only one in the cache and we would BUG in get_file_region_entry_from_cache.
Am I reading the code correctly?

The existing code wants to make sure region_add called after region_chg will
never return error.  This is why all needed allocations were done in the
region_chg call, and it was relatively easy to do in existing code when
region_chg would only need one additional region at most.

I'm thinking that we may have to make region_chg allocate the worst case
number of regions (t - f)/2, OR change to the code such that region_add
could return an error.
-- 
Mike Kravetz
