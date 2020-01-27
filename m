Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0AC414A5E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2020 15:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgA0OUH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 09:20:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgA0OUG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 09:20:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00REIigd127130;
        Mon, 27 Jan 2020 14:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=LMNEteF1mFMJN8KLVSylpclFG8eaewxyxCO/yV9Gbf8=;
 b=awk54MxGNx68+7uwwNRk17aFWxje71kIHc3IX6PVAIQK6Na9m37UHS5S99D+0Khutxv2
 d0K5XlOKAKrbxxYXxroXbBKLuGvwV8XPDoRwfphcWPLF9AAf93XJ1zniZY8XqGjKZHFm
 4ps+qY0Og4/QU107JmuFEjvRcRqmyeRtmijtq8//1//mVWPzaIUGV6pTikSsDnFeJNV8
 WgRs8yqK30Z5S2LSsH7xtPYd1xVmuUuZFQM7eexrgfB1mYOYSgQcbS6ErtQ4NaP5rm0M
 kiSqLfM2Q4IkmXPgNsurHox+iZyF9UxMwNDgNKTBrcQZKa/hZOz3QQU4Bfd0CSnpLql2 Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xreaqyf7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 14:19:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00REJIHB151822;
        Mon, 27 Jan 2020 14:19:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xryu9g7tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 14:19:56 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00REJrh2000949;
        Mon, 27 Jan 2020 14:19:54 GMT
Received: from [10.152.35.77] (/10.152.35.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 06:19:53 -0800
Subject: Re: [Automated-testing] syzkaller reproducers
From:   George Kennedy <george.kennedy@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     shuah <shuah@kernel.org>,
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
Organization: Oracle Corporation
Message-ID: <e8b11b09-37ac-6ae2-0908-b803b4160f7c@oracle.com>
Date:   Mon, 27 Jan 2020 09:19:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <86bde120-e5fe-4bb1-9b93-769a444500f9@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1031
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270122
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dmitry,

Re-sending this request.

Also, how do you track the Upstream branches with Syzkaller? Do you have 
a version of Syzkaller for each (i.e. 4.14, 4.19, etc)?

Thank you,
George

On 12/6/2019 3:06 PM, George Kennedy wrote:
> Hello Dmitry,
>
> Could we get another drop of the Syzkaller C reproducers?
>
> Wonder if we could get the drop periodically (i.e. a drop/quarter or a 
> drop to match a major linux release)?
>
> Thank you,
> George

