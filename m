Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EF1D7705
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 15:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfJONER (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 09:04:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44174 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbfJONER (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 09:04:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FCxFp8017107;
        Tue, 15 Oct 2019 13:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=B+OJC8Ug/Ek7xA9g9VxKoa781wb0U8WVw+Q3swW2fgQ=;
 b=ENmNQgfSc+2bbdt2kVAY+UzDI68fL+6pDk3VCouynQ5ACoq4n3wiBvTsgzUKOc+CBkfC
 Y4WdcoJen49p8VFbl+U9k57ynNfTN2245VS41Chn3ITeCsXHgB9SZ0a45ib6mS8FaYqn
 nKY3n5rcp6dPLEqviQ3bftvG06Gdu+Ygz4sPHk6x1SOmFUFi5+wbi1GXM5M5vscK7mR9
 2s06KHjGl94CnHhj32S9JrdYy0HHkgb6NL+zFQy0qhXJqCRa65cK1W90hEsT/MlOvF3y
 En1qdxcS6a/62vTFNYLHgm5GS4c6Du6F6nm8gbOYNmYeM9dpf1aozmbyLMl4tqvrS6hx 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vk68uftvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 13:04:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FD3rCm190545;
        Tue, 15 Oct 2019 13:04:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vn8en1av3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 13:04:07 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9FD458J016523;
        Tue, 15 Oct 2019 13:04:05 GMT
Received: from [10.152.35.77] (/10.152.35.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 13:04:05 +0000
Subject: Re: [Automated-testing] syzkaller reproducers
To:     Dmitry Vyukov <dvyukov@google.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
 <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org>
 <226099bc-9763-3a73-e26a-b292f601494c@kernel.org>
 <20191011180248.GA24089@rei.lan>
 <b715f3d7-547f-9a43-dc41-2e46ec3bfd51@kernel.org>
 <20191014085414.GB31760@rei.lan>
 <CACT4Y+aKbgT=i8C5aZvp8ZV52PamGm=GdnR6kQecczLQOQSGqA@mail.gmail.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <62903a33-8ffc-56b6-de1a-539f10b5de2a@oracle.com>
Date:   Tue, 15 Oct 2019 09:04:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aKbgT=i8C5aZvp8ZV52PamGm=GdnR6kQecczLQOQSGqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1031
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150119
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/14/2019 7:19 AM, Dmitry Vyukov wrote:
> On Mon, Oct 14, 2019 at 10:54 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>> Hi!
>>>> You are suposed to run the run.sh script in the bin directory.
>>> Yeah that does work.
>>>
>>> Would be helpful to have usage instructions instead of failing. :)
>> I do not think that these scripts are ever supposed to be the used in
>> production testing, you need much more than this to produce results
>> reliably. I would expect that they are supposed to be a form of very
>> minimal documentation.
> Yes, I just added them as quick hints: some repros are 32-bits; each
> needs a new dir; some external timeout is needed for each test.
Thank you again for the collection of repro C programs!

Hitting a lot more crashes with the collection of repro C programs than 
in all the hours of running Syzkaller. Wonder why? Any idea? This is 
with the same kernel and VM that Syzkaller is run on.

George


