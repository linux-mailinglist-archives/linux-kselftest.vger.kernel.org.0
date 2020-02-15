Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2715FC06
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2020 02:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBOB1t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Feb 2020 20:27:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51476 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgBOB1t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Feb 2020 20:27:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01F1NFfC033261;
        Sat, 15 Feb 2020 01:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=c25DV/PWTqDQtmzKwshNZ8aSa23KEScWw4d7ve/5NJo=;
 b=OKBBBUD9klBKnQJPAy1l96os99u0TJPrIDcVjhk4lbLvt3KprfUhWhgGr+FS9n6/JAxg
 2mieSPv7cApr2dOfIAt57zcjnFDpyiqXZaBS45Ina3pMnzwMh6e1MbKzTlRP/x5Tmr7Y
 XMPZ78oB/138uxSXwoWAwogpCMLCw1FYzKO1VbhLrE6NL28kbfH09iSPr4WqXJgJFQz3
 yEjcXLzp+8IRl+BT22PoFC+PGHpdLpvRJpZfKzp4D6cPfnx+P7CEFFy2Ez+BJHl2ZrnT
 M2/Hjfz7iMDQKP0+3dpqhVgFI005GmvQUV/fi0iLDojmp5bMogQ2qdhLe90oWmSX570V tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y2jx6vkf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Feb 2020 01:27:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01F1ReMH006504;
        Sat, 15 Feb 2020 01:27:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y4k3fm7yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Feb 2020 01:27:43 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01F1Rgq5008495;
        Sat, 15 Feb 2020 01:27:42 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Feb 2020 17:27:42 -0800
Subject: Re: [PATCH v12 4/9] hugetlb: disable region_add file_region
 coalescing
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211213128.73302-4-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <21db60be-221d-339c-412a-6bb2509c4262@oracle.com>
Date:   Fri, 14 Feb 2020 17:27:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211213128.73302-4-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=872 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002150008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=905 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002150008
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/11/20 1:31 PM, Mina Almasry wrote:
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
> 

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

My reason for previously asking my Reviewed-by be removed is because I did
not realize the suboptimal behavior for private mappings would be addressed
in a subsequent patch.  That should be OK as nobody should be using just
part of this series.  If we need to respin, it might be worth noting this in
the commit message.  Something like:
With file_region coalescing disabled, private mappings will have one
file_region for each page in the mapping.  This suboptimal behavior will
be addressed in a later patch in this series.

> ---
> 
> Changes in v12:
> - Removed Mike's Reviewed-by until coalescing is reviewed per his
> request.
> - Added VM_BUG_ON that was mistakingly in a follow up patch.
