Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBFB9144375
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2020 18:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAURlL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jan 2020 12:41:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgAURlK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jan 2020 12:41:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LHdHPq127968;
        Tue, 21 Jan 2020 17:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=KuXXyrwg/MgtdCcSYgFFofBQXbFXA1rvjP1SoYziw7k=;
 b=Bdz6tW1EYBuC02kKgnN7rpfsrjzIsiS2nhohEHMhWCfM+lTz5JvMdA9Ph3gch71+y1dx
 3fDrtKYDk9e/2EdqRw+pJcO8NW65p46yV07nP+EAhvWHXEVdWo8jk6WbO6QQdQTiTkjp
 Y9hDefprzobo/7O0gH4aMpZYxAst6wH6Abt2rlqbwZfJ01PrIBHc4yq28DFK9p0Ts84W
 WemR0Kxy5oYlTBBDVQWxdnNNrhV2A1ZygMe2sr8O/izeG9D14pQgZrHmi4pboQfOM5lc
 7zQrb+mSN4MiXT6VuAXCMbeyorN7Vu9HLXYAfPvwG47PjALqi3NTRztbj2cc7BaM6+Ty eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xksyq6ma1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 17:41:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LHdBwT156402;
        Tue, 21 Jan 2020 17:40:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xnsa92x11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 17:40:59 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00LHewMa006709;
        Tue, 21 Jan 2020 17:40:58 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jan 2020 09:40:58 -0800
Subject: Re: [PATCH v9 4/8] hugetlb: disable region_add file_region coalescing
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191217231615.164161-4-almasrymina@google.com>
 <2afb05c1-8d85-a0cf-aad1-041054aad529@oracle.com>
Message-ID: <7fb223ea-3e99-550b-d19c-1352de0d296d@oracle.com>
Date:   Tue, 21 Jan 2020 09:40:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2afb05c1-8d85-a0cf-aad1-041054aad529@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9507 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=929
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9507 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=974 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210136
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/21/20 9:38 AM, Mike Kravetz wrote:
> On 12/17/19 3:16 PM, Mina Almasry wrote:
>> A follow up patch in this series adds hugetlb cgroup uncharge info the
> 
> *nit*
> A follow up patch in this series adds hugetlb cgroup uncharge info to the
> 
>> file_region entries in resv->regions. The cgroup uncharge info may
>> differ for different regions, so they can no longer be coalesced at
>> region_add time. So, disable region coalescing in region_add in this
>> patch.
>>
>> Behavior change:
>>
>> Say a resv_map exists like this [0->1], [2->3], and [5->6].
>>
>> Then a region_chg/add call comes in region_chg/add(f=0, t=5).
>>
>> Old code would generate resv->regions: [0->5], [5->6].
>> New code would generate resv->regions: [0->1], [1->2], [2->3], [3->5],
>> [5->6].
>>
>> Special care needs to be taken to handle the resv->adds_in_progress
>> variable correctly. In the past, only 1 region would be added for every
>> region_chg and region_add call. But now, each call may add multiple
>> regions, so we can no longer increment adds_in_progress by 1 in region_chg,
>> or decrement adds_in_progress by 1 after region_add or region_abort. Instead,
>> region_chg calls add_reservation_in_range() to count the number of regions
>> needed and allocates those, and that info is passed to region_add and
>> region_abort to decrement adds_in_progress correctly.
>>
>> We've also modified the assumption that region_add after region_chg
>> never fails. region_chg now pre-allocates at least 1 region for
>> region_add. If region_add needs more regions than region_chg has
>> allocated for it, then it may fail.
>>
>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Thanks for the updated comments.  Still,
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>


Sorry, that comment was directed at V10 of the patch.

-- 
Mike Kravetz
