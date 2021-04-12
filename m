Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1992F35B9AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Apr 2021 06:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhDLE6C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 00:58:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhDLE6C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 00:58:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13C4dsAv033001;
        Mon, 12 Apr 2021 00:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=syKGsuPJ93IyVS/UYx0+bfEX0FvV7tTwm+T8vWXAWZA=;
 b=fmqZsxE+98lwqWDtP6yjJRAF3YaBZ8K53FeKzvj+T80C1PL9EsRrdlvL29cLMLUjvQWD
 SLNjwBy1NtPvPQibtLvN46yN4y8uIs7UgluGLYN72PiOrxMISnPw5dVUogiZhTTuEuON
 HRE07LQtb19oama7ewJ0rMylXojSujQkqQNfYFe58Qs3Tz0FjoRozTlhHbtnmJvXTIYA
 p9GJtRyKc9oaP5XBxzpppH+eZDubEGPCkDcBCmDMPAnSx7OUUDjn0BbmAAEg6vtBGBFQ
 U2qPJ8rmO9CGUlQJbi2R0FXnW95TugVTb2lSKecdFEjwoqgYPFD/FJ+eA4sk99XOGV/z ug== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37us2um1uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 00:57:32 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13C4vUNh016008;
        Mon, 12 Apr 2021 04:57:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 37u3n88s2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 04:57:29 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13C4vR6842795464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 04:57:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BF7F11C05E;
        Mon, 12 Apr 2021 04:57:27 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9DF411C04A;
        Mon, 12 Apr 2021 04:57:25 +0000 (GMT)
Received: from [9.199.37.145] (unknown [9.199.37.145])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 04:57:25 +0000 (GMT)
Subject: Re: [PATCH v2 1/4] powerpc/selftests/ptrace-hwbreak: Add testcases
 for 2nd DAWR
To:     Daniel Axtens <dja@axtens.net>, mpe@ellerman.id.au
Cc:     mikey@neuling.org, shuah@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20210407054938.312857-1-ravi.bangoria@linux.ibm.com>
 <20210407054938.312857-2-ravi.bangoria@linux.ibm.com>
 <87mtu8eyqz.fsf@linkitivity.dja.id.au>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <6a3b2779-ccf5-bd42-f30a-a4ae9d04dac2@linux.ibm.com>
Date:   Mon, 12 Apr 2021 10:27:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87mtu8eyqz.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IiEpbKhoS_S94yfdoUR6JaoamXhEpu3D
X-Proofpoint-GUID: IiEpbKhoS_S94yfdoUR6JaoamXhEpu3D
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_03:2021-04-09,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120028
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/9/21 12:22 PM, Daniel Axtens wrote:
> Hi Ravi,
> 
>> Add selftests to test multiple active DAWRs with ptrace interface.
> 
> It would be good if somewhere (maybe in the cover letter) you explain
> what DAWR stands for and where to find more information about it. I
> found the Power ISA v3.1 Book 3 Chapter 9 very helpful.

Sure. Will add the details in v2 cover letter.

> Apart from that, I don't have any specific comments about this patch. It
> looks good to me, it seems to do what it says, and there are no comments
> from checkpatch. It is a bit sparse in terms of comments but it is
> consistent with the rest of the file so I can't really complain there :)
> 
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Thanks
Ravi
