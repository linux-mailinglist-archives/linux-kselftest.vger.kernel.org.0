Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14B24153CE5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 03:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBFCMh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 21:12:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51850 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBFCMh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 21:12:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016298no128278;
        Thu, 6 Feb 2020 02:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=t+D4j4G5Deohl2w/m6COIz7G6YZYqDMg9nUp9Tlbhvo=;
 b=GLUbw063qNnTe9MNJSAoROwPcPqU6HAKh1orO+BWPpD6eIjsQVck6D7zqlONFOiaYyJE
 GGmjrQn6hiROcgd5AVy9/B9cAoXN1QxpDOq0zrNVZtT0KHFJFxGtQpyeg/HIqWWslr/e
 MGXl42mjqO45bJ1ZQpR7iJTbcAmW31wRzB0dBl4PW9RdE+ZtgNJC0kzANN14hTOVDk1k
 QFnNcCnsFt2x4P2TJNg8scJJ8HAtY8fI3REREadJbO/ZIMu6N75GbD308ygqNRVT+iKL
 lGBoxImEM33KnYFAOUkdVrKNA/pZtBKOaDglf68XgTKUoHkU736sxUSQs3V0HZcr3G4y uQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=t+D4j4G5Deohl2w/m6COIz7G6YZYqDMg9nUp9Tlbhvo=;
 b=QWViX+zU3VnIerffikL7Bw22mgLz3+lBkq0VCDR/evI0ySEGyX0af/XeRFXR8OWiPjdf
 wn4zgpnfzygikGHBfLJxUH5HAXI/9ufXjNDqYjRt2lAglB4DMEZOwlfxL6LmSRNwOCuA
 qjSjGJt6yG0dcZyHotsOJTYrhni1aCECpSsTt4RFuBc2boNwfMDPaE1wOqU4hIvFliGd
 oQq4BXEvcRFsY1jwdHL8AOky7umgGkeqVkXsYc/VQ33BaIQJ+ZEPjMisc7IWfxocIOLj
 n2qWMOOIc00aZdDNLeppyXlixlsijIFHip49coLxOrB8TBZcC5Ui0av0y3vIaMuAAnI3 uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xykbpeu55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 02:12:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 01629208102400;
        Thu, 6 Feb 2020 02:12:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xymuu75gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 02:12:29 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0162CSpf016896;
        Thu, 6 Feb 2020 02:12:28 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 18:12:27 -0800
Subject: Re: [PATCH v11 4/9] hugetlb: disable region_add file_region
 coalescing
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-4-almasrymina@google.com>
 <cd457f80-2624-f524-36ce-f11b56b30f8a@oracle.com>
 <CAHS8izONQEGMHJVR3cpgbn+LbYZ9eYa4jNkOwkCYwpGBHXHm8Q@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <dd097d06-6ac8-08b6-d484-b6bfc5922a70@oracle.com>
Date:   Wed, 5 Feb 2020 18:12:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHS8izONQEGMHJVR3cpgbn+LbYZ9eYa4jNkOwkCYwpGBHXHm8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060013
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/5/20 5:43 PM, Mina Almasry wrote:
> On Wed, Feb 5, 2020 at 3:57 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 2/3/20 3:22 PM, Mina Almasry wrote:
>>> A follow up patch in this series adds hugetlb cgroup uncharge info the
>>> file_region entries in resv->regions. The cgroup uncharge info may
>>> differ for different regions, so they can no longer be coalesced at
>>> region_add time. So, disable region coalescing in region_add in this
>>> patch.
>>>
>>> Behavior change:
>>>
>>> Say a resv_map exists like this [0->1], [2->3], and [5->6].
>>>
>>> Then a region_chg/add call comes in region_chg/add(f=0, t=5).
>>>
>>> Old code would generate resv->regions: [0->5], [5->6].
>>> New code would generate resv->regions: [0->1], [1->2], [2->3], [3->5],
>>> [5->6].
>>>
>>> Special care needs to be taken to handle the resv->adds_in_progress
>>> variable correctly. In the past, only 1 region would be added for every
>>> region_chg and region_add call. But now, each call may add multiple
>>> regions, so we can no longer increment adds_in_progress by 1 in region_chg,
>>> or decrement adds_in_progress by 1 after region_add or region_abort. Instead,
>>> region_chg calls add_reservation_in_range() to count the number of regions
>>> needed and allocates those, and that info is passed to region_add and
>>> region_abort to decrement adds_in_progress correctly.
>>>
>>> We've also modified the assumption that region_add after region_chg
>>> never fails. region_chg now pre-allocates at least 1 region for
>>> region_add. If region_add needs more regions than region_chg has
>>> allocated for it, then it may fail.
>>>
>>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>
>> This is the same as the previous version.  My late comment was that we
>> need to rethink the disabling of region coalescing.  This is especially
>> important for private mappings where there will be one region for huge
>> page.  I know that you are working on this issue.  Please remove my
>> Reviewed-by: when sending out the next version.
>>
> 
> Yes to address that there is a new patch in the series, which
> re-enables the coalescing when the hugetlb cgroup uncharge info is the
> same. I guess it could be squashed with this one but I thought it was
> better to implement that patch on top of the patch that enabled shared
> accounting, because that is the patch that sets hugetlb cgroup info on
> the file region entries.
> 
> Let me know what you think.

Thanks, I saw there was an additional patch but I did not get to it yet.
I'll take a look and see how involved the changes are.

-- 
Mike Kravetz
