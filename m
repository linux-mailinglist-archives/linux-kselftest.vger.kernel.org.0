Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE6153C2D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 00:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBEX51 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 18:57:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBEX50 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 18:57:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015NsSBe031541;
        Wed, 5 Feb 2020 23:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=20EhFCbhIcHFyvZXL9v1kH+4dXx2cB7lh5BIdcgVgYg=;
 b=tV5i05UsAm74oB5wBtMplQ9bRCxAZGrWG9RDTuDn/v7ZDA56FfuTZPt1nzVC+W18NAoD
 d8QGNv+GAwz7HdMQS2puNqa2vkiC00xCoJuYDtwBCaGuDqAlIwDPsxxPr00vI/Ymai1G
 XWH74yaId+jPw7TBCdy9bzGFG5ybNne8mDO5jD6stEmmG9QaSXXfxvmQm0/VqXU9Epc6
 GJMJN4jcnCEgaHUsT6cFyOdEc7n4iiL5wvr9HVEu6td4GSZJeCuuLYpYeIuWkK1mcAL+
 C0tNdnEaLahhU1I0zldtydPf6O9gY/xpkVHCNCxjdy1ZIPMf0DIbDHtuwxrQ1J+wyq56 5Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=20EhFCbhIcHFyvZXL9v1kH+4dXx2cB7lh5BIdcgVgYg=;
 b=IXYlQMtjrp26qQLcJhlH1+yPliIpbXYSmzlrQLyf+Y4E+Y2a32Lg/DuXn94gYJzSqx6K
 7duY2xsG5wBA8nbBVvOmMx3jrTMsMZDhz8gGWm3CaVJ3x6pKlqiwu68dK+f9f4k7HliW
 Mk0+FsiTFqEw9plVng2ySqPMtim53P+4k6sN3AkQZHV70TFOTfcIDPJe+oZxzKQebUL1
 UoaEIbHXFBCAjV4o+alZvyRLVB/MLFN6RLZeqd/4Sc0otpeTkDFe5GeO8B0KI+HbIF7h
 yBt4wyijrfeg7y+i3ypR8qwpLkfqPSgy8wT68LEIPLb9XI6OK5/B8c+Lsbtl5k5WAhdC YA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xykbp6er8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 23:57:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015NnRvR029003;
        Wed, 5 Feb 2020 23:57:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xykbt4c00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 23:57:19 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015NvIxZ003008;
        Wed, 5 Feb 2020 23:57:19 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 15:57:18 -0800
Subject: Re: [PATCH v11 4/9] hugetlb: disable region_add file_region
 coalescing
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-4-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <cd457f80-2624-f524-36ce-f11b56b30f8a@oracle.com>
Date:   Wed, 5 Feb 2020 15:57:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203232248.104733-4-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=904
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=937 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050185
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/20 3:22 PM, Mina Almasry wrote:
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
> 
> We've also modified the assumption that region_add after region_chg
> never fails. region_chg now pre-allocates at least 1 region for
> region_add. If region_add needs more regions than region_chg has
> allocated for it, then it may fail.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

This is the same as the previous version.  My late comment was that we
need to rethink the disabling of region coalescing.  This is especially
important for private mappings where there will be one region for huge
page.  I know that you are working on this issue.  Please remove my
Reviewed-by: when sending out the next version.

Thanks,
-- 
Mike Kravetz
