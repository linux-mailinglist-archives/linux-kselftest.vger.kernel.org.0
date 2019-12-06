Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676FC11581C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2019 21:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLFUGo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Dec 2019 15:06:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53020 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFUGn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Dec 2019 15:06:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6K4wRV122200;
        Fri, 6 Dec 2019 20:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=b9aojGdFky3zb1MS/fHct5vVed1KVFS9yptd2Wfm1NM=;
 b=iLhIWg4CFu99HbkHiZNDQST8Rq95ifer0HHO1q/u7/xJtDuiuIq5pR2j6rMBOquGSLkc
 3q8JsW1aMYPbei19QieSPJL/6EhSJywcNK0GeW3vjOTleH9YqyYEuPMkBIndB/LRAkeX
 CKMtLZ4erFjxEzdnCKPWyiAP0AnBDmkTUqpWZFBlKu/ylTuR4VEHI5ri1KZnRAWq4rYY
 AHxbW5Gl+7mQ5wAnWATqpXqRb9Jh2cczLl5FeB0p/mLqkbpAZmqaZ0Kibrq1AMlNWEkV
 u0maQmfRZHQG7yF1U5jwuh7GpVZtkqw6aI9e9u9f9/7RngpunCX4gMet84v93e1leVLD Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wkfuuxaqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 20:06:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6K3n92031400;
        Fri, 6 Dec 2019 20:06:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wqcbcrt2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 20:06:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB6K6VPU026627;
        Fri, 6 Dec 2019 20:06:31 GMT
Received: from [10.39.221.15] (/10.39.221.15)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Dec 2019 12:06:31 -0800
Subject: Re: [Automated-testing] syzkaller reproducers
From:   George Kennedy <george.kennedy@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        Dhaval Giani <dhaval.giani@gmail.com>,
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
 <62903a33-8ffc-56b6-de1a-539f10b5de2a@oracle.com>
Organization: Oracle Corporation
Message-ID: <86bde120-e5fe-4bb1-9b93-769a444500f9@oracle.com>
Date:   Fri, 6 Dec 2019 15:06:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <62903a33-8ffc-56b6-de1a-539f10b5de2a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9463 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=857
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912060160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9463 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1031
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=925 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912060160
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Dmitry,

Could we get another drop of the Syzkaller C reproducers?

Wonder if we could get the drop periodically (i.e. a drop/quarter or a 
drop to match a major linux release)?

Thank you,
George
