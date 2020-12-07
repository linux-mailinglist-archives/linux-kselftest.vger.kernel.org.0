Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0272D1502
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 16:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgLGPn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 10:43:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726182AbgLGPn7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 10:43:59 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B7FXqbY173504;
        Mon, 7 Dec 2020 10:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jryC5GXE1RaEt8i2AwMsMZAJ0ckjA/Vb5TXsH+O/5Jg=;
 b=ZjSw7y/fbn7v3hQGPpPdkcDn9LS/yDOQgBDcddIc2ya9+dPuI22UNqBnWL7ek3GxvJmg
 z1ajBznPmDBeaBB7B52TGUBNrZ+PmiGkpCNfe4PIet4EeKZBBEckMYdje2noFzh2PFLR
 v1c+SMikje8A/myFCWnPSAgYsrbJLUDeKD8M/HBdOfS2qz39EM62muX4FLpzIRgYMdZx
 dsyKNs1jNjNVi3vbsUPEvXvdGnkW30Zf9BnoEws4jy8U3uHDGqL0WEEWPfkLnvyaAn73
 XNSIjZjlaNup26vZZHZep/o/IYAtBh4YBjkPPQZtCxJTn/KLlUFEw1a1zvKw/ouO775k DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359d5nxv5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 10:43:18 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B7FYPDV174725;
        Mon, 7 Dec 2020 10:43:17 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359d5nxv4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 10:43:17 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B7FVsVu023275;
        Mon, 7 Dec 2020 15:43:14 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3581u9csrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 15:43:14 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B7FhD5a24576442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 15:43:13 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 508677805C;
        Mon,  7 Dec 2020 15:43:13 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC6177805E;
        Mon,  7 Dec 2020 15:43:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.71])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  7 Dec 2020 15:43:12 +0000 (GMT)
Subject: Re: [PATCH v4] self_tests/kvm: sync_regs test for diag318
From:   Collin Walling <walling@linux.ibm.com>
To:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
        imbrenda@linux.ibm.com
References: <20201207154125.10322-1-walling@linux.ibm.com>
Message-ID: <d315f431-869a-891b-c18c-7e97a824ee56@linux.ibm.com>
Date:   Mon, 7 Dec 2020 10:43:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201207154125.10322-1-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_11:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=8 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070100
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/7/20 10:41 AM, Collin Walling wrote:
> The DIAGNOSE 0x0318 instruction, unique to s390x, is a privileged call
> that must be intercepted via SIE, handled in userspace, and the
> information set by the instruction is communicated back to KVM.
> 
> To test the instruction interception, an ad-hoc handler is defined which
> simply has a VM execute the instruction and then userspace will extract
> the necessary info. The handler is defined such that the instruction
> invocation occurs only once. It is up to the caller to determine how the
> info returned by this handler should be used.
> 
> The diag318 info is communicated from userspace to KVM via a sync_regs
> call. This is tested During a sync_regs test, where the diag318 info is
> requested via the handler, then the info is stored in the appropriate
> register in KVM via a sync registers call.
> 
> If KVM does not support diag318, then the tests will print a message
> stating that diag318 was skipped, and the asserts will simply test
> against a value of 0.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Please add

Acked-by: Janosch Frank <frankja@linux.ibm.com>

[...]

-- 
Regards,
Collin

Stay safe and stay healthy
