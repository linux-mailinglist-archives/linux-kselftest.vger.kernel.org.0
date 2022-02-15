Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AEF4B6BC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 13:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiBOMLn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 07:11:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiBOMLm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 07:11:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EC9E21;
        Tue, 15 Feb 2022 04:11:32 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FAfpHq034767;
        Tue, 15 Feb 2022 12:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j84/b69VoUjlDGJRNxuQ+ZKxk+cIXx3qKqZEV0i/gNk=;
 b=l7PQNlKM8o3fbALwB4gSOUCm7f5uZIqUVnyb4CYZUTbQgFh/ekwfNWAyjIBbkP+g41du
 ZV2ev6+a5Dia72WxQQk06QV4VPxQfbY3QWL3bui++M6Y3KjmodBzG+uOJ3e5OFP9TQgi
 vLA5tmGXN/3fwpy7MQIuDR0bVlStrUw469f3bnAS73jW7wFtSrzPzgyfF4O5eMSn79O6
 i8mPPdLCaQJBVtDa513wyXmzkEHwB+q9hcXfuqP9exnzSmia0PCjxaHBcKNPIjqxmllN
 m2/Q3IL++eNnKIVJwkeCwPdUctzrNV+XzmTVIVFE0GnoXo4NRxpottkvsfLmDG4KQdMz vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8an6252a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 12:11:31 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21FBtYvf015581;
        Tue, 15 Feb 2022 12:11:31 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8an6251t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 12:11:31 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21FC22as026744;
        Tue, 15 Feb 2022 12:11:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3e64h9dj5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 12:11:28 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FCBPdC48496898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 12:11:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9119E11C050;
        Tue, 15 Feb 2022 12:11:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32AAE11C064;
        Tue, 15 Feb 2022 12:11:25 +0000 (GMT)
Received: from [9.171.51.217] (unknown [9.171.51.217])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 12:11:25 +0000 (GMT)
Message-ID: <ad017c67-51cb-f8e0-6116-5316120f0d1a@linux.ibm.com>
Date:   Tue, 15 Feb 2022 13:11:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] selftests: kvm: Check whether SIDA memop fails for normal
 guests
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220215074824.188440-1-thuth@redhat.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220215074824.188440-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qe2zkOyYkPI3-jvGP_etTMNMp8nyk27X
X-Proofpoint-GUID: MLevF05Xxm8xOBv8JVJe4lQLVtPbOsL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1011
 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am 15.02.22 um 08:48 schrieb Thomas Huth:
> Commit 2c212e1baedc ("KVM: s390: Return error on SIDA memop on normal
> guest") fixed the behavior of the SIDA memops for normal guests. It
> would be nice to have a way to test whether the current kernel has
> the fix applied or not. Thus add a check to the KVM selftests for
> these two memops.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied.
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 9f49ead380ab..d19c3ffdea3f 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -160,6 +160,21 @@ int main(int argc, char *argv[])
>   	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
>   	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
>   
> +	/* Check that the SIDA calls are rejected for non-protected guests */
> +	ksmo.gaddr = 0;
> +	ksmo.flags = 0;
> +	ksmo.size = 8;
> +	ksmo.op = KVM_S390_MEMOP_SIDA_READ;
> +	ksmo.buf = (uintptr_t)mem1;
> +	ksmo.sida_offset = 0x1c0;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == EINVAL,
> +		    "ioctl does not reject SIDA_READ in non-protected mode");
> +	ksmo.op = KVM_S390_MEMOP_SIDA_WRITE;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == EINVAL,
> +		    "ioctl does not reject SIDA_WRITE in non-protected mode");
> +
>   	kvm_vm_free(vm);
>   
>   	return 0;
