Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61B162F90
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2020 20:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgBRTOe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Feb 2020 14:14:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50842 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgBRTOe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Feb 2020 14:14:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IJDwQt186783;
        Tue, 18 Feb 2020 19:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=klYs7sANTDBUGahPUju9sGWKYr/tKylftyYSkWKVd7M=;
 b=evNMlimVu3xmXlI/jjEVBPaZZEWMkPu5+xRAILOSZ2HHqMNX69dd4vUwzjS8x59DrKdd
 5nxBXGA3OxMdQin9eVnqgx0UqW+1nEMf8x/kDSi86SYett7WmGvjQZ3xU2lv8WtntjVE
 tPrSIL2BuuBGNJmoTMORRAExFtSh/hQyPT9m1wMTtokQ4/aR5VKRxcCbDqmEOcRMPnXu
 D6rahYOQtdo0znPDwFlsWuDUii+txSF/XOSXmCiu9lHDxNqfPTnOMaN78+EcuVzTeHaS
 2/rVylv79hPpyksaAUnl6ZKWAAQuolmrGuWMalYnfocc3uXd3cNr1f8QnOOGdNhGAkqN Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y699rr9v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 19:14:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IJDkEC050650;
        Tue, 18 Feb 2020 19:14:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y6tc2wunw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 19:14:24 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01IJEM8r000976;
        Tue, 18 Feb 2020 19:14:23 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 11:14:22 -0800
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
To:     Mina Almasry <almasrymina@google.com>, Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
 <1582035660.7365.90.camel@lca.pw>
 <CAHS8izO5=vKs-v9v=Di3hQXBD41+_YpYarXn1yZu9YE6SR-i6Q@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d498012a-ec87-ca48-ed78-5fcdaf372888@oracle.com>
Date:   Tue, 18 Feb 2020 11:14:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHS8izO5=vKs-v9v=Di3hQXBD41+_YpYarXn1yZu9YE6SR-i6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 suspectscore=27 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=986 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=27
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180129
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/20 10:35 AM, Mina Almasry wrote:
> On Tue, Feb 18, 2020 at 6:21 AM Qian Cai <cai@lca.pw> wrote:
>>
>> On Tue, 2020-02-11 at 15:19 -0800, Andrew Morton wrote:
>>> On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
>>>
>> [ 7933.806377][T14355] ------------[ cut here ]------------
>> [ 7933.806541][T14355] kernel BUG at mm/hugetlb.c:490!
>> VM_BUG_ON(t - f <= 1);
>> [ 7933.806562][T14355] Oops: Exception in kernel mode, sig: 5 [#1]
<snip>
> Hi Qian,
> 
> Yes this VM_BUG_ON was added by a patch in the series ("hugetlb:
> disable region_add file_region coalescing") so it's definitely related
> to the series. I'm taking a look at why this VM_BUG_ON fires. Can you
> confirm you reproduce this by running hugemmap06 from the ltp on a
> powerpc machine? Can I maybe have your config?
> 
> Thanks!

Hi Mina,

Looking at the region_chg code again, we do a

	resv->adds_in_progress += *out_regions_needed;

and then potentially drop the lock to allocate the needed entries.  Could
anopther thread (only adding reservation for a single page) then come in
and notice that there are not enough entries in the cache and hit the
VM_BUG_ON()?

-- 
Mike Kravetz
