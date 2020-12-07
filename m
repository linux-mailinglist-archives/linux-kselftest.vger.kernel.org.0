Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7AA2D1929
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 20:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgLGTJ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 14:09:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbgLGTJ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 14:09:59 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B7J6pPi029384;
        Mon, 7 Dec 2020 14:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rZCcftZ797n+Em3es+TpYX3wz/johhfSx7hdYdEo3Xk=;
 b=C2TdJPpXJM/nUpAbYAi3v1mvSKC+NWYthPlL96uSH7CC7tYGmk4SIVvvhTAcckVucgWK
 XjAihxx546H2h8PwXzsds+1TicLYmVP96/HOxEdt0Un1EdONKtadCN4N8PPfIXdgZo1h
 80RSwaXoKxC9JITc6lwNosdU+4GHsxqn8GNjQi3WfgFHae3A8TTvV3YXBmqnZQ72yLVY
 AFqbJf7pYNGbczUW8V0JEwbZR+f1ecuKnHHk3fD7UX7XwoP1iR4XrM1oTqORjArKdYzA
 4z239wYqZ7QG4Jv+K7rET+COkIxlRsDbyRSaa7hF2bQWnmsII0kr/zvQRBwQtfQ0ksDl /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359p7x9b7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 14:09:18 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B7J76MB030796;
        Mon, 7 Dec 2020 14:09:18 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359p7x9b6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 14:09:18 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B7J6uev025380;
        Mon, 7 Dec 2020 19:09:17 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 3581u96kye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 19:09:17 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B7J9Fsm22872376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 19:09:15 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 867157805E;
        Mon,  7 Dec 2020 19:09:15 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAF6178060;
        Mon,  7 Dec 2020 19:09:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.71])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  7 Dec 2020 19:09:14 +0000 (GMT)
Subject: Re: [PATCH v4] self_tests/kvm: sync_regs test for diag318
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        borntraeger@de.ibm.com, pbonzini@redhat.com, imbrenda@linux.ibm.com
References: <20201207154125.10322-1-walling@linux.ibm.com>
 <20201207175557.674236b3.cohuck@redhat.com>
From:   Collin Walling <walling@linux.ibm.com>
Message-ID: <dcb5cfd1-ed40-21fb-0216-d0e0b8ea2cd3@linux.ibm.com>
Date:   Mon, 7 Dec 2020 14:09:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201207175557.674236b3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_16:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070121
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/7/20 11:55 AM, Cornelia Huck wrote:
> On Mon,  7 Dec 2020 10:41:25 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> The DIAGNOSE 0x0318 instruction, unique to s390x, is a privileged call
>> that must be intercepted via SIE, handled in userspace, and the
>> information set by the instruction is communicated back to KVM.
>>
>> To test the instruction interception, an ad-hoc handler is defined which
>> simply has a VM execute the instruction and then userspace will extract
>> the necessary info. The handler is defined such that the instruction
>> invocation occurs only once. It is up to the caller to determine how the
>> info returned by this handler should be used.
>>
>> The diag318 info is communicated from userspace to KVM via a sync_regs
>> call. This is tested During a sync_regs test, where the diag318 info is
> 
> s/During/during/
> 
>> requested via the handler, then the info is stored in the appropriate
>> register in KVM via a sync registers call.
>>
>> If KVM does not support diag318, then the tests will print a message
>> stating that diag318 was skipped, and the asserts will simply test
>> against a value of 0.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |  2 +-
>>  .../kvm/include/s390x/diag318_test_handler.h  | 13 +++
>>  .../kvm/lib/s390x/diag318_test_handler.c      | 82 +++++++++++++++++++
>>  .../selftests/kvm/s390x/sync_regs_test.c      | 16 +++-
>>  4 files changed, 111 insertions(+), 2 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/include/s390x/diag318_test_handler.h
>>  create mode 100644 tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
> 
> Looks reasonable to me.
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks. I'll resubmit the entire patch as a reply to the top-most email
with the proposed commit message changes.

-- 
Regards,
Collin

Stay safe and stay healthy
