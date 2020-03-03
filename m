Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8083E1777A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 14:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgCCNqi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 08:46:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgCCNqi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 08:46:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023DhsGh130026;
        Tue, 3 Mar 2020 13:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=q/dO+I3s/05qSjtTDi1OQBuQj6Qqwpf1k5JIv+SV55I=;
 b=fw5vxiifYYpyUy8sTrfk8dh5Zv+ZbixJHqWISicmB70PK/nrpzMp0vUd0yuSUyZB6nNe
 Bfn5yjZJ1JIL6q/q76AYH8Nna/v4EiGdDGbH+aGkqxgtdv/hJ3xNpaEh6eELiPlhLXSC
 bNAdpoux4X7zX/FfEw6kT/VOdzpA1HXeaubQF0sowJj3h3/LNGXd9fNO0exoh1RQAEhE
 PyB9cHX6VAvE7XoIU2LjZF91/gZLHTRWYCd9dEOvPIs8D3iOuurlMUpwJ2E/TRxZWgyc
 ViU0PCFoNxdEW6NfayeqZML6xozyJFaRv51OB/ZuLKrhxViIE0EWVm969PRMBUpg1/sS 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2yffcufcd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 13:46:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023Dh7sU026166;
        Tue, 3 Mar 2020 13:46:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2yg1gxfxs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 13:46:29 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 023DkQQc032227;
        Tue, 3 Mar 2020 13:46:27 GMT
Received: from [10.152.34.22] (/10.152.34.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 05:46:25 -0800
Subject: Re: [Automated-testing] syzkaller reproducers
To:     Dmitry Vyukov <dvyukov@google.com>, shuah <shuah@kernel.org>
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
 <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org>
 <226099bc-9763-3a73-e26a-b292f601494c@kernel.org>
 <20191011180248.GA24089@rei.lan>
 <b715f3d7-547f-9a43-dc41-2e46ec3bfd51@kernel.org>
 <20191014085414.GB31760@rei.lan>
 <CACT4Y+aKbgT=i8C5aZvp8ZV52PamGm=GdnR6kQecczLQOQSGqA@mail.gmail.com>
 <62903a33-8ffc-56b6-de1a-539f10b5de2a@oracle.com>
 <86bde120-e5fe-4bb1-9b93-769a444500f9@oracle.com>
 <e8b11b09-37ac-6ae2-0908-b803b4160f7c@oracle.com>
 <CACT4Y+bShy-3vO3ifNKVcGGNf3X9XA7zL-Ja9-T+gZv5=QNe4w@mail.gmail.com>
 <8a4dbbb1-f8ba-00ba-41d2-d82a35fc0f81@oracle.com>
 <CACT4Y+aZ=rBZXdnrU0D-21QqSK0G3vqHU+iD=k0PhGgo3TL6rA@mail.gmail.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <2d593685-b50e-ea2c-a724-818f6b149731@oracle.com>
Date:   Tue, 3 Mar 2020 08:46:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aZ=rBZXdnrU0D-21QqSK0G3vqHU+iD=k0PhGgo3TL6rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1031
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030105
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/3/2020 3:45 AM, Dmitry Vyukov wrote:
> Shauh,
>
> We've added more reproducers to:
> https://github.com/dvyukov/syzkaller-repros/tree/master/linux
>
> It makes sense to pull in them to the kernel-arts repo. Not sure
> what's the most convenient way for you since it's not exactly a
> traditional "patch"? Perhaps you just copy linux/*.c files and commit?
>
> George, another throw in of 446 repros ;)

Thank you Dmitry!
George

>
>
>
> On Mon, Jan 27, 2020 at 6:08 PM George Kennedy
> <george.kennedy@oracle.com> wrote:
>>> Hi George,
>>>
>>> This was still starred in my inbox, but I never got to actually do
>>> anything with it. Thanks for pinging me. I thought that the script to
>>> extract the repros won't work for some reason and that I will need to
>>> fix it first. But turns out it's still working as-is (I wanted to
>>> submit some changes that would break it, but I never go to that as
>>> well. Good! :)).
>>>
>>> So here is a new drop in with 692 repros:
>>> https://github.com/dvyukov/syzkaller-repros/commit/6a06992209c328a3115c89c020f45b844b103573
>>> Enjoy!
>>>
>>> Yes, we have separate managers for each version, the entries in the
>>> Instances table correspond to syz-manager one-to-one:
>>> https://syzkaller.appspot.com/upstream
>>> https://syzkaller.appspot.com/linux-4.19
>>> https://syzkaller.appspot.com/android-54
>> Thank you Dmitry!
>> George
>>>
>>>
>>> On Mon, Jan 27, 2020 at 3:20 PM George Kennedy
>>> <george.kennedy@oracle.com> wrote:
>>>> Hi Dmitry,
>>>>
>>>> Re-sending this request.
>>>>
>>>> Also, how do you track the Upstream branches with Syzkaller? Do you have
>>>> a version of Syzkaller for each (i.e. 4.14, 4.19, etc)?
>>>>
>>>> Thank you,
>>>> George
>>>>
>>>> On 12/6/2019 3:06 PM, George Kennedy wrote:
>>>>> Hello Dmitry,
>>>>>
>>>>> Could we get another drop of the Syzkaller C reproducers?
>>>>>
>>>>> Wonder if we could get the drop periodically (i.e. a drop/quarter or a
>>>>> drop to match a major linux release)?
>>>>>
>>>>> Thank you,
>>>>> George

