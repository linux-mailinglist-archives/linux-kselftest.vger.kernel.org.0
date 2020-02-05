Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8215E153BD6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 00:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgBEX1I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 18:27:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49618 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEX1H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 18:27:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015NNExA010837;
        Wed, 5 Feb 2020 23:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vkChhDkW7adf/zI5HvGJVWc4OuaOabIDTSkYpTnwmPw=;
 b=eYIjGVGUVqV5tGfbL96DvEfbYv3qu0IIayzbrpUiOrBcqQUUuX5aGJuzTwR8F45cagPc
 K9PdXE713rljBTOIT3YXqyu+jjgQuPcsCpJShzg32/wD4tmugHCtG3iRVoxaXTFUL58Y
 g7P2ZZvbhac9rQXJ6GyPSZk8m7XEyvbrLliWbeuGBTWYVFvht2fPs8DJdMhX40bHzR3C
 N4yhSOJhTvzoJSI4RxzXEwXNVHTc/NhbyYfDoSQCRhkaGAqoQMMPZAkuVat13q+tP0SL
 /RM1TmaQxg5lx9y0Erht6ykSN9oG+/nWkJMocgOkMyDRr7VN0sBlPx7J5tOmfTFT7edN eQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=vkChhDkW7adf/zI5HvGJVWc4OuaOabIDTSkYpTnwmPw=;
 b=ejok573A3qg8/03hB2x1meAni0sWpbmssJEut1MKvXKKRgGmOMqlQzCyEbGIw1rr5wPu
 MglGDJ0NxdPBMqQg/y1AKhOpHKFOMAOGFzqj5xZOMie8GqdYV45ACAAYWm0+v15l3STA
 ezg4yajpIRLxDHoG5tMQTv6W6m+aFORDLpzGitaOgMqBtrZ8IUvpGK0Qm9afwRz59XIQ
 mcQA1bdAT6lGv3q0Zi72XXBAKHdcF1QmHWq3xFfDbTNHaCQnnGB2K4Jo64QECF5xKlW3
 sxPYi4Y3sPyZIyz4FMT6pVTo9c20xyan6YmFsiJxo2ar86C6lPF/acPKzpmLivYNaWvq kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xykbp6bct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 23:27:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015NOOk2058451;
        Wed, 5 Feb 2020 23:27:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xykc99syn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 23:27:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015NQv9D014738;
        Wed, 5 Feb 2020 23:26:57 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 15:26:57 -0800
Subject: Re: [PATCH v11 3/9] hugetlb_cgroup: add reservation accounting for
 private mappings
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-3-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5480f0ea-0e5f-30c2-7635-43b8cbbb3a73@oracle.com>
Date:   Wed, 5 Feb 2020 15:26:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203232248.104733-3-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050181
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/20 3:22 PM, Mina Almasry wrote:
> Normally the pointer to the cgroup to uncharge hangs off the struct
> page, and gets queried when it's time to free the page. With
> hugetlb_cgroup reservations, this is not possible. Because it's possible
> for a page to be reserved by one task and actually faulted in by another
> task.
> 
> The best place to put the hugetlb_cgroup pointer to uncharge for
> reservations is in the resv_map. But, because the resv_map has different
> semantics for private and shared mappings, the code patch to
> charge/uncharge shared and private mappings is different. This patch
> implements charging and uncharging for private mappings.
> 
> For private mappings, the counter to uncharge is in
> resv_map->reservation_counter. On initializing the resv_map this is set
> to NULL. On reservation of a region in private mapping, the tasks
> hugetlb_cgroup is charged and the hugetlb_cgroup is placed is
> resv_map->reservation_counter.
> 
> On hugetlb_vm_op_close, we uncharge resv_map->reservation_counter.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: David Rientjes <rientjes@google.com>
> 
> ---
> 
> Changes in v11:
> - Refactored hugetlb_cgroup_uncharge_conuter a bit to eliminate
> unnecessary #ifdefs.
> - Added resv_map_set_hugetlb_cgroup_uncharge_info() to eliminate #ifdefs
> in the middle of hugetlb logic.

Thanks.
Code looks better without the #ifdefs.
You can keep my Reviewed-by:

-- 
Mike Kravetz
