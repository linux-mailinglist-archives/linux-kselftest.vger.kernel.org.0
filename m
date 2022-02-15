Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0334B6777
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 10:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiBOJXc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 04:23:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiBOJXb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 04:23:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90AC3DA69;
        Tue, 15 Feb 2022 01:23:21 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21F8BD2T020405;
        Tue, 15 Feb 2022 09:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=v61IXX80zQXs7K1gQg/jhLYIWkOL7EzOxuh7BknpY7Y=;
 b=YH6k4xpAB3LMka1wTzvRNSLSxcYqYj5qTfPb1Pv8J64XfK13t09/n1H/36HHEyM2tj8a
 l5Kb7m9gb3M7AAEt+vXAjyAZBLPHqvTNGwU/nz1mlKuihSEWhZZACfHeowG+KE6bqrOl
 zzC8SgSgpChPnH3zu84VHZGEt8gl9TEsAMoGu7nZQbDAa58ERDp+elg8k/RbdxhnHj+j
 3MzHNy0tWx5QJjmiMKlysZ6E2DnWx6eQJPTWBRHAiZAoPxp/j4n9AtAuezkrD4EIDBqn
 CIKLDPFxmy5M0twrKB4Nbm3MGM6dnV5Vuzmo4ninDbu6pOQ1Z/1Mlg9hzDQ7jlCdbbPf CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e85tew2tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 09:23:21 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21F8vnHI027976;
        Tue, 15 Feb 2022 09:23:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e85tew2sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 09:23:20 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21F9MJMP014903;
        Tue, 15 Feb 2022 09:23:18 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64h9vvru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 09:23:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21F9NFP148169380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 09:23:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17188A405F;
        Tue, 15 Feb 2022 09:23:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B1BDA4060;
        Tue, 15 Feb 2022 09:23:14 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.2.54])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 09:23:14 +0000 (GMT)
Date:   Tue, 15 Feb 2022 10:23:12 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kvm: Check whether SIDA memop fails for
 normal guests
Message-ID: <20220215102312.330e8220@p-imbrenda>
In-Reply-To: <20220215074824.188440-1-thuth@redhat.com>
References: <20220215074824.188440-1-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y0PgVOt7ge_HS87ivnQe0eDdrDGmI1vI
X-Proofpoint-ORIG-GUID: d5EjyeNEubM4HY1w4HRueE3z17T4SNH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_03,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 15 Feb 2022 08:48:24 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Commit 2c212e1baedc ("KVM: s390: Return error on SIDA memop on normal
> guest") fixed the behavior of the SIDA memops for normal guests. It
> would be nice to have a way to test whether the current kernel has
> the fix applied or not. Thus add a check to the KVM selftests for
> these two memops.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

looks rather straightforward

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 9f49ead380ab..d19c3ffdea3f 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -160,6 +160,21 @@ int main(int argc, char *argv[])
>  	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
>  	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
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
>  	kvm_vm_free(vm);
>  
>  	return 0;

