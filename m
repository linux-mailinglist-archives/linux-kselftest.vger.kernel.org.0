Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B58914148A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 23:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAQW6K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 17:58:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39726 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgAQW6K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 17:58:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HMhrnr174540;
        Fri, 17 Jan 2020 22:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=dENVIhtYjj5QMBF4ot0Yq+caEuhMLKWT5Dd/N2rM48Q=;
 b=gfQ9AU6+gFr7y+gwnYkF8lpRjg5PLqyA3gj5zD9hId1KspjMU2Vx8gwUJ1p3n6HAEN3N
 mJrQsow7Q/z1eMRpRsi8yi2K4Rx1DTHIuyOCOZFYuz6xQIeS/CtKH+rWkZt0Ap+ZyipQ
 92sVO1yRWntXwMduKdKil5ZR/e9p0XUrEjaeMbOqw65mJjnFZm2/2OL+89ozjumAI0g6
 D2AauVFhe5N44zxIJhOcMBBnF4csmL4QQHVgbD7NRnpUjL+5gVAV/NGYsjJyS2jua0il
 bKVUKko9VCpxkUBGLORM/tQ3p6W1L47IOY/Yw4ql/4cPy1y9A7CetvIWKNyuDEvUur87 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf7403bxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 22:58:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HMi0P9072595;
        Fri, 17 Jan 2020 22:58:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xjxm9r6tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 22:58:02 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00HMw1rL030830;
        Fri, 17 Jan 2020 22:58:01 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 14:58:01 -0800
Subject: Re: [PATCH v10 3/8] hugetlb_cgroup: add reservation accounting for
 private mappings
To:     Mina Almasry <almasrymina@google.com>, rientjes@google.com,
        shakeelb@google.com
Cc:     shuah@kernel.org, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-3-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <49e5872e-eecb-4279-bc79-bbc1e132ab5d@oracle.com>
Date:   Fri, 17 Jan 2020 14:57:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115012651.228058-3-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170175
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/14/20 5:26 PM, Mina Almasry wrote:
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

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
