Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18688422
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfHIUjI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 16:39:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35304 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfHIUjI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 16:39:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79KT8Z7033406;
        Fri, 9 Aug 2019 20:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=LYD1snKMlHvkWp294kI8LRCWSYWhhgJkoYcRSNCNcg8=;
 b=ezsCfB0ccRtKFM/FVNeNmizjTfDVi2F19OS3Pcd+azyflbwiFFJPY/w9RB71ws8Q4Bym
 5B0h67PGJ00hMzT1ZTbRWfis+fZ5Gi73ESPzQxqmuB8Ue7yd1woRPma7sgswrDd3HCYJ
 k5Q6XN7jr9Avwqjey9vnsER2Jl1jqW/PigjRLpnoCrkm1Q5EGr7HBphDkp+T6eMKFbna
 SFqJ18sx2NF52Im6q9ueeJYJnYCTSQP/FWjcn2F7bB5DBOuhfiUuTbpmVgEXUskqrPTi
 lqB1Pur98Db77Nrwb65JmqZtFWv2PtZ0fAMZLe9hf/EpKW/FKm/+oZCzhBG0yVw9ZTo0 VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LYD1snKMlHvkWp294kI8LRCWSYWhhgJkoYcRSNCNcg8=;
 b=c9WzmLm8sd1JvJz89wNy75Btc6RYbJaGXeYI2l5NW4Bbk4gpxP2gx4i15t0OilFAbUjc
 6dA4vvinjOdft22mr9TBrukqtIgD2NE11HFTkc9+Md3xBB5hv4mwBKisT3nMKdZCy4lS
 9CAjTPRW/xhARtkzlaNCA7p797JFvfqsy8puQDc9w1daOmfOFMAQylUpJkVfwyjnP9yq
 Qb1eDDFmtg1Nfi8ningW6fEmvshpeXiCfY/LFI11v9DJihBj4Mx05mxNccPRsqdPXgef
 NWCzAGiba68jlgVuxyclXfBvD9ynmexYTMnSxil0vbvc9lc+q1mR1b1sc/tSdcvlCJxp Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u8hgpa0yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 20:39:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79KT3NW113900;
        Fri, 9 Aug 2019 20:38:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2u8x9fw136-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 20:38:59 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x79KcucC005635;
        Fri, 9 Aug 2019 20:38:57 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Aug 2019 13:38:56 -0700
Subject: Re: [RFC PATCH] hugetlbfs: Add hugetlb_cgroup reservation limits
To:     Mina Almasry <almasrymina@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190808194002.226688-1-almasrymina@google.com>
 <20190809112738.GB13061@blackbody.suse.cz>
 <CAHS8izNM3jYFWHY5UJ7cmJ402f-RKXzQ=JFHpD7EkvpAdC2_SA@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fc420531-f0fe-8df5-57fe-71a686bf2a71@oracle.com>
Date:   Fri, 9 Aug 2019 13:38:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izNM3jYFWHY5UJ7cmJ402f-RKXzQ=JFHpD7EkvpAdC2_SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9344 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=743
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908090201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9344 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=780 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908090201
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/9/19 11:05 AM, Mina Almasry wrote:
> On Fri, Aug 9, 2019 at 4:27 AM Michal Koutný <mkoutny@suse.com> wrote:
>>> Alternatives considered:
>>> [...]
>> (I did not try that but) have you considered:
>> 3) MAP_POPULATE while you're making the reservation,
> 
> I have tried this, and the behaviour is not great. Basically if
> userspace mmaps more memory than its cgroup limit allows with
> MAP_POPULATE, the kernel will reserve the total amount requested by
> the userspace, it will fault in up to the cgroup limit, and then it
> will SIGBUS the task when it tries to access the rest of its
> 'reserved' memory.
> 
> So for example:
> - if /proc/sys/vm/nr_hugepages == 10, and
> - your cgroup limit is 5 pages, and
> - you mmap(MAP_POPULATE) 7 pages.
> 
> Then the kernel will reserve 7 pages, and will fault in 5 of those 7
> pages, and will SIGBUS you when you try to access the remaining 2
> pages. So the problem persists. Folks would still like to know they
> are crossing the limits on mmap time.

If you got the failure at mmap time in the MAP_POPULATE case would this
be useful?

Just thinking that would be a relatively simple change.
-- 
Mike Kravetz
