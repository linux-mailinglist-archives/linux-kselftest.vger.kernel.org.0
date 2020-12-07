Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278B22D14AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 16:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgLGP1e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 10:27:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725822AbgLGP1e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 10:27:34 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B7FLQC8028135;
        Mon, 7 Dec 2020 10:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uE/fTD5XUIZm+Vg8iFqdAfcQFi/vyUa08FAYOW28jHE=;
 b=flnpl0EZdVZP+6cYSlqwZn6/MWPX5zFsrb7x+aG457dbisNpdCIA53pXlDPvYjGH2VLp
 C7RpqCunP+n4eoJueFDO/LXeQcgkIAo6MHOoGSe2bjv2SYBlKTJcl9Xp0TlY0fK3WYGq
 2rBQRNZdH07vhBZ4tlCzjMUxZUWnzr/O1pZWLrUqzb1QDIUT/lV+Uloeuj7FtLuAKUi7
 t+Du0/6j3PPQICMajssKBiJnSYM9tvwLvooDeJux22C4/v1zhzL7Bxm4QC6wcB2qeRcp
 /x6Ji/V+MgKNSqopfDm6EJx+9Hd3rrMDWbeZOqBrYAzZP3O+KGMFJa76y3HFeYs0EesE +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 359pybr61n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 10:26:53 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B7FMad4032389;
        Mon, 7 Dec 2020 10:26:52 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 359pybr61d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 10:26:52 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B7FBsP2028972;
        Mon, 7 Dec 2020 15:26:52 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 3581u9cnhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 15:26:52 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B7FQorv20251020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 15:26:50 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 555EB7805C;
        Mon,  7 Dec 2020 15:26:50 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 429087805E;
        Mon,  7 Dec 2020 15:26:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.71])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  7 Dec 2020 15:26:49 +0000 (GMT)
Subject: Re: [PATCH v3] self_tests/kvm: sync_regs test for diag318
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     david@redhat.com, thuth@redhat.com, cohuck@redhat.com,
        pbonzini@redhat.com, imbrenda@linux.ibm.com
References: <20201203215212.243145-1-walling@linux.ibm.com>
 <39f22c09-788c-4ba7-9cf8-018f86b10803@linux.ibm.com>
 <06853772-8c12-b5e9-761f-9743ce01e270@de.ibm.com>
From:   Collin Walling <walling@linux.ibm.com>
Message-ID: <5da42ff4-fdc4-ef84-94f6-07fe9a54c9f9@linux.ibm.com>
Date:   Mon, 7 Dec 2020 10:26:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <06853772-8c12-b5e9-761f-9743ce01e270@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_11:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070094
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/7/20 3:19 AM, Christian Borntraeger wrote:
> 
> 
> On 07.12.20 09:16, Janosch Frank wrote:
>> On 12/3/20 10:52 PM, Collin Walling wrote:
>>> The DIAGNOSE 0x0318 instruction, unique to s390x, is a privileged call
>>
>> s/call/instruction/
>>
>>> that must be intercepted via SIE, handled in userspace, and the
>>> information set by the instruction is communicated back to KVM.
>>>
>>> To test the instruction interception, an ad-hoc handler is defined which
>>> simply has a VM execute the instruction and then userspace will extract
>>> the necessary info. The handler is defined such that the instruction
>>> invocation occurs only once. It is up to the caller to determine how the
>>> info returned by this handler should be used.
>>>
>>> The diag318 info is communicated from userspace to KVM via a sync_regs
>>> call. This is tested during a sync_regs test, where the diag318 info is
>>> requested via the handler, then the info is stored in the appropriate
>>> register in KVM via a sync registers call.
>>>
>>> If KVM does not support diag318, then the tests will print a message
>>> stating that diag318 was skipped, and the asserts will simply test
>>> against a value of 0.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>
>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>>
>> Some nits below.
> 
> Collin, can you have a look at the nits and resubmit soon? Then I can pick this
> for 5.11.
> 

Will do.

[...[


-- 
Regards,
Collin

Stay safe and stay healthy
