Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73699CFF06
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfJHQgC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 12:36:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39534 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfJHQgC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 12:36:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98GMvVh190489;
        Tue, 8 Oct 2019 16:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Puu5n4LBMeDNBQfA5BPcqEnb9wP+vdaNX34cNRkeyXA=;
 b=pK/ZMJiOAHMDMPT2LPsXLXspU/Mi5OHI/0QP3aa2Q8IDBRBKCr5pT+DLxkX4WXfn1csQ
 akau0nlqHVqse1djx46pd+iyfdZf88y2RQ9/hcl2sR6OAZoPhaCFBevPCdaI/SY4/6vP
 kDt9pqEEBZMKpXNuhsOJawWuq/Fc8XeOl/npfMwPnVQ3jQm8FdhSpi2yh7inx83RCGk6
 UzGtZXnQCRTO2Mo6SsThZaXDZwjS63af2dSGQ4ObijAtYCUTqGUQd/FyRpz7CnCMKMuD
 UbjLr78w0aiZGLLAs4im2bSTOBVHUILcPnx5HXNiZNSzXyHhsRW89c75cvE0JXZb1Ubz 2g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vejkuehgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 16:35:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98GCflv158111;
        Tue, 8 Oct 2019 16:35:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vg1yw8n1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 16:35:55 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98GZrQ6012370;
        Tue, 8 Oct 2019 16:35:53 GMT
Received: from [10.152.35.77] (/10.152.35.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 09:35:52 -0700
Subject: Re: syzkaller reproducers
To:     Dmitry Vyukov <dvyukov@google.com>, Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>
Cc:     syzkaller <syzkaller@googlegroups.com>
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <e903c0b0-70cb-6545-fbbf-9c06107b1ad7@oracle.com>
Date:   Tue, 8 Oct 2019 12:35:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=852
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=927 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080138
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/8/2019 8:16 AM, Dmitry Vyukov wrote:
> On Tue, Oct 8, 2019 at 1:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>> Hi Shuah,
>>
>> We discussed collecting and uploading all syzkaller reproducers
>> somewhere. You wanted to see how they look. I've uploaded all current
>> reproducers here:
>> https://github.com/dvyukov/syzkaller-repros
>> Minimalistic build/run scripts are included.
>> +some testing mailing lists too as this can be used as a test suite
>> If you have any potential uses for this, you are welcome to use it.
>> But then we probably need to find some more official and shared place
>> for them than my private github.
>> The test programs can also be bulk updated if necessary, because all
>> of this is auto-generated.

Thank you for putting this together Dmitry,

George

>>
>> Thanks
> +more people who expressed interest in the test suite before

