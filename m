Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00533125950
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2019 02:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfLSBiA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Dec 2019 20:38:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55424 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSBh7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Dec 2019 20:37:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ1TBZk188547;
        Thu, 19 Dec 2019 01:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=TESIcPkdV4iqOIUQl0IYI/d2iDoSjKThzSi7PjRQeX4=;
 b=opXrPL1VX9xpx2kpCFKgaXvY5VlJZGU/WOowBs9R9TNvFsZ9dkmHgMCf1W79ij6cjtkq
 BJjiBSRf7VF5bHt5QUpGtfnaQwlwxXy63R8Gjj/gUJ9kCnPg/Fk8NqAhaRlBwwGq2ros
 Axc8lqgv8uZoy6Bt+uuOMN3PawaN2yTgKmkzHOlpiXRXg0cOtd0exrPfYuT9uPhe5vZP
 2SXP+1IpjmI1+h/WPUPoR7zItwpthJIvnOlFfMVDeG5xZ6TCPFUpAaaNJWUww4kmL8Pc
 dKcFVYvb+1SoWn9Ft0BFg5F0abH1kAL5cRl3CeVt84xfRbHlm/JB1C09KYOXuuJOWswJ Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wvrcrh1fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 01:37:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ1Xx7o016034;
        Thu, 19 Dec 2019 01:37:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wyut4hr4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 01:37:41 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJ1bdtD032332;
        Thu, 19 Dec 2019 01:37:40 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Dec 2019 17:37:39 -0800
Subject: Re: [PATCH v9 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com, Hillf Danton <hdanton@sina.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tejun Heo <tj@kernel.org>
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191218171254.79664a964c0c61e6054dff64@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4d11fb25-5036-6c78-5328-10a0c14e8edc@oracle.com>
Date:   Wed, 18 Dec 2019 17:37:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218171254.79664a964c0c61e6054dff64@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190010
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/18/19 5:12 PM, Andrew Morton wrote:
> On Tue, 17 Dec 2019 15:16:08 -0800 Mina Almasry <almasrymina@google.com> wrote:
<snip>
>> This proposal is implemented in this patch series, with tests to verify
>> functionality and show the usage. We also added cgroup-v2 support to
>> hugetlb_cgroup so that the new use cases can be extended to v2.
> 
> This would make
> http://lkml.kernel.org/r/20191216193831.540953-1-gscrivan@redhat.com
> obsolete?

I haven't started looking at this series yet.  However, since Mina was
involved in the discussion of that patch (hugetlb controller for cgroups v2)
my assumption is that this patch would simply build on that v2 support?
Seems like the above patch would be a prereq for this series.

Mina, are those assumptions correct and perhaps this is an old/obsolete
comment?  Does this series apply 'on top' of the above patch?  That patch
is already in Andrew's tree.
-- 
Mike Kravetz
