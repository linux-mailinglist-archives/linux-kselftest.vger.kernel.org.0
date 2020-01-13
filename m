Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F8F139C2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 23:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMWIT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 17:08:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43574 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgAMWIS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 17:08:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DM4GG2156350;
        Mon, 13 Jan 2020 22:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=bteqaIm33REwMocLQp5eXrWHmlZN7JbTCADnuM17JQ4=;
 b=icmnkw9K8LowJlmjZNZAJ6hy/yKzAOGnl8G9HV9FpnWaw2/+Bm5o5JI56Xh4scExmOoa
 NNlxoshBc8UPFAhtmxbKgCjuVUbmH8zCmeRKMJhZGc/4fA0ya7gzeGCUh/KrZ2Bj7Oqe
 2gjgUJKpPtK4j9nxCOYE5XqjAVAAvjJJayqkONUpL0g6AY37Fx5l76/0/oGD1QQjrMmo
 6vHutDBl9TXXQ6aW1c01hSYasayexIyrDVdUJ21bitn5OUUlcDv2VGGgnMQpqpExbi6W
 iBMFGPiuXGPxe2R78DLEw0UTI+QL7zeVbvvTs6jHSJEjM/8eFi4+ke2ZixsQ5S7D5v8A Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf73y9vy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:08:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DM58nh180288;
        Mon, 13 Jan 2020 22:06:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xfqu596n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:06:03 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00DM600g032689;
        Mon, 13 Jan 2020 22:06:00 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 14:06:00 -0800
Subject: Re: [PATCH v9 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
References: <20191217231615.164161-1-almasrymina@google.com>
 <817e2c4b-4c72-09f9-22ea-bbaf97584161@oracle.com>
 <CAHS8izNs24KOaRuQkVUuZZUh42rvkyBXJEJYrHNf9bLFnZEXCg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a78595a8-448c-14bb-a54b-9be685f36388@oracle.com>
Date:   Mon, 13 Jan 2020 14:05:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHS8izNs24KOaRuQkVUuZZUh42rvkyBXJEJYrHNf9bLFnZEXCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130179
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130179
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/13/20 1:03 PM, Mina Almasry wrote:
> On Mon, Jan 13, 2020 at 10:44 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 12/17/19 3:16 PM, Mina Almasry wrote:
>>> - While usage_in_bytes tracks all *faulted* hugetlb memory,
>>> reservation_usage_in_bytes tracks all *reserved* hugetlb memory and
>>> hugetlb memory faulted in without a prior reservation.
>>
>> To me, this implies that 'faults without reservations' could cause
>> reservation usage to exceed reservation limit?  Or, does the faulting
>> process get a SIGBUS because of the reservation limit even though it
>> is not using reservations?
>>
>> We shall see in subsequent patches.
>>
> 
> The design we went with based on previous discussions is as follows:
> hugetlb pages faulted without a prior reservation get accounted at
> fault time, rather than reservation time, and if the fault causes the
> counter to cross the limit, the charge fails, hence the fault fails,
> hence the process gets sigbus'd.

Ok, sorry I did not recall the design discussion.

> This means that one counter I'm adding here can cover both use cases:
> if the userspace uses MAP_NORESERVE, then their memory is accounted at
> fault time and they may get sigbus'd.

Let's make sure this is clearly documented.  Someone could be surprised
if their application not using reserves gets a SIGBUS because there is a
reserve limit.
-- 
Mike Kravetz
