Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42D6A720B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2019 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfICR6b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Sep 2019 13:58:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfICR6b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Sep 2019 13:58:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83HsfZH111420;
        Tue, 3 Sep 2019 17:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=2CQvjcjn8S5qepJOVui7TagmqoVkFQxOyG/LeHJ4jns=;
 b=VIsu3iuVv3V2Rp/MY04+TEmNsQFl9ZZIxerTVvvOODw0AwKdlACPaGmAriaj5jWMBm7l
 cmsiNjxTyXAmhw9W9qJPqdALaf9wz6lloMeD3NcSoMsTiwv+A/tkftb5CE8iRbG1LC0u
 rCQny2Pp3b9WmLoct6jngYegMfAgh+Th8mu8lpUhb174FHU8QHqTUyaF1zZL0gh2++C0
 +Z+OZvxhLZVp0XwqvakZrbD+eTfuGDHQqXqBjpcMZAxGr/M/lCFpIsbVD13Ez+TbrmFI
 AWtSYUqk2UhJbQzyDWHlwyl78ImjmPY+z0FQ0RnjHlNd9FaaAaT47S+fe7Q3+14n7HtZ dA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2usvvu82gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 17:58:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83Hw9Ni128598;
        Tue, 3 Sep 2019 17:58:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2usu50v2q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 17:58:13 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83Hvfix000347;
        Tue, 3 Sep 2019 17:57:41 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 10:57:41 -0700
Subject: Re: [PATCH v3 0/6] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
To:     Michal Hocko <mhocko@kernel.org>,
        Mina Almasry <almasrymina@google.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
References: <20190826233240.11524-1-almasrymina@google.com>
 <20190828112340.GB7466@dhcp22.suse.cz>
 <CAHS8izPPhPoqh-J9LJ40NJUCbgTFS60oZNuDSHmgtMQiYw72RA@mail.gmail.com>
 <20190829071807.GR28313@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <cb7ebcce-05c5-3384-5632-2bbac9995c15@oracle.com>
Date:   Tue, 3 Sep 2019 10:57:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190829071807.GR28313@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030180
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/29/19 12:18 AM, Michal Hocko wrote:
> [Cc cgroups maintainers]
> 
> On Wed 28-08-19 10:58:00, Mina Almasry wrote:
>> On Wed, Aug 28, 2019 at 4:23 AM Michal Hocko <mhocko@kernel.org> wrote:
>>>
>>> On Mon 26-08-19 16:32:34, Mina Almasry wrote:
>>>>  mm/hugetlb.c                                  | 493 ++++++++++++------
>>>>  mm/hugetlb_cgroup.c                           | 187 +++++--
>>>
>>> This is a lot of changes to an already subtle code which hugetlb
>>> reservations undoubly are.
>>
>> For what it's worth, I think this patch series is a net decrease in
>> the complexity of the reservation code, especially the region_*
>> functions, which is where a lot of the complexity lies. I removed the
>> race between region_del and region_{add|chg}, refactored the main
>> logic into smaller code, moved common code to helpers and deleted the
>> duplicates, and finally added lots of comments to the hard to
>> understand pieces. I hope that when folks review the changes they will
>> see that! :)
> 
> Post those improvements as standalone patches and sell them as
> improvements. We can talk about the net additional complexity of the
> controller much easier then.

All such changes appear to be in patch 4 of this series.  The commit message
says "region_add() and region_chg() are heavily refactored to in this commit
to make the code easier to understand and remove duplication.".  However, the
modifications were also added to accommodate the new cgroup reservation
accounting.  I think it would be helpful to explain why the existing code does
not work with the new accounting.  For example, one change is because
"existing code coalesces resv_map entries for shared mappings.  new cgroup
accounting requires that resv_map entries be kept separate for proper
uncharging."

I am starting to review the changes, but it would help if there was a high
level description.  I also like Michal's idea of calling out the region_*
changes separately.  If not a standalone patch, at least the first patch of
the series.  This new code will be exercised even if cgroup reservation
accounting not enabled, so it is very important than no subtle regressions
be introduced.

-- 
Mike Kravetz
