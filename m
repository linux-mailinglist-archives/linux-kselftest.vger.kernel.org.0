Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1998B633896
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 10:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiKVJeQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 04:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiKVJeP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 04:34:15 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92C6644C;
        Tue, 22 Nov 2022 01:34:14 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AM8d916028851;
        Tue, 22 Nov 2022 09:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=waIgJpgjNqSFfMmI93mxxF++m/jo6IpqkSlWNClHgSI=;
 b=J5AwhQNsQb2eid9FLXbarvCI7GIrmGZVFvU1tm6IHAGMYdHTIxBRjLH7SrfyWf2lvBi4
 V/N4Wula+o25rreYd+AKYmaBzKVBHcTT7UnaQK7S20DG6IA2IwoR83n9t65zhIkaez7n
 BHe9QKynsxh9NTZI/3TKA1QTfVIJzHVOvM7URNkfic+TL2j0VgH1uxU1+OAVi+Yw/nQ+
 XDnG00DZM6avfhCoDSqVjSpr9qm0YEQdP9MgqoaX4Kd7DTq1ubmDQ5AZjQ0QolhWQBPP
 Oe20NfXNWCbIFK8nVX8h+Mc6quao+WF7dlW54WMP0eYHdRJj0oTgkQ3P/BfOe+FTqhMf rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0rhdcwem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 09:34:09 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AM7mVF9009259;
        Tue, 22 Nov 2022 09:34:09 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0rhdcwdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 09:34:08 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AM9LU7R031077;
        Tue, 22 Nov 2022 09:34:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3kxps92vuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 09:34:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AM9Y3tq6423140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 09:34:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BE30A4059;
        Tue, 22 Nov 2022 09:34:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C97D3A4051;
        Tue, 22 Nov 2022 09:34:02 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.44.213])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Nov 2022 09:34:02 +0000 (GMT)
Message-ID: <71d10db8151c3b78d84a252a688e2892448eaa95.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/9] KVM: s390: selftest: memop: Move testlist into
 main
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Date:   Tue, 22 Nov 2022 10:34:02 +0100
In-Reply-To: <c801611e-61db-73d2-2ff1-cd06350215b2@redhat.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
         <20221117221758.66326-6-scgl@linux.ibm.com>
         <c801611e-61db-73d2-2ff1-cd06350215b2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TE8dwqfOiCUvqpW2CEZMTngHlClnv3fj
X-Proofpoint-GUID: ZUply-oT0HlAwhb8_mCmPxmc8BeHrB4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_04,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-11-22 at 08:52 +0100, Thomas Huth wrote:
> On 17/11/2022 23.17, Janis Schoetterl-Glausch wrote:
> > This allows checking if the necessary requirements for a test case are
> > met via an arbitrary expression. In particular, it is easy to check if
> > certain bits are set in the memop extension capability.
> > 
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> >   tools/testing/selftests/kvm/s390x/memop.c | 132 +++++++++++-----------
> >   1 file changed, 66 insertions(+), 66 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> > index 286185a59238..10f34c629cac 100644
> > --- a/tools/testing/selftests/kvm/s390x/memop.c
> > +++ b/tools/testing/selftests/kvm/s390x/memop.c
> > @@ -690,87 +690,87 @@ static void test_errors(void)
> >   	kvm_vm_free(t.kvm_vm);
> >   }
> >   
[...]
> > 
> > +	} testlist[] = {
> > +		{
> > +			.name = "simple copy",
> > +			.test = test_copy,
> > +			.requirements_met = true,
> > +		},
> > +		{
> > +			.name = "generic error checks",
> > +			.test = test_errors,
> > +			.requirements_met = true,
> > +		},
> > +		{
> > +			.name = "copy with storage keys",
> > +			.test = test_copy_key,
> > +			.requirements_met = extension_cap > 0,
> > +		},
> > +		{
> > +			.name = "copy with key storage protection override",
> > +			.test = test_copy_key_storage_prot_override,
> > +			.requirements_met = extension_cap > 0,
> > +		},
> > +		{
> > +			.name = "copy with key fetch protection",
> > +			.test = test_copy_key_fetch_prot,
> > +			.requirements_met = extension_cap > 0,
> > +		},
> > +		{
> > +			.name = "copy with key fetch protection override",
> > +			.test = test_copy_key_fetch_prot_override,
> > +			.requirements_met = extension_cap > 0,
> > +		},
> > +		{
> > +			.name = "error checks with key",
> > +			.test = test_errors_key,
> > +			.requirements_met = extension_cap > 0,
> > +		},
> > +		{
> > +			.name = "termination",
> > +			.test = test_termination,
> > +			.requirements_met = extension_cap > 0,
> > +		},
> > +		{
> > +			.name = "error checks with key storage protection override",
> > +			.test = test_errors_key_storage_prot_override,
> > +			.requirements_met = extension_cap > 0,
> > +		},
> > +		{
> > +			.name = "error checks without key fetch prot override",
> > +			.test = test_errors_key_fetch_prot_override_not_enabled,
> > +			.requirements_met = extension_cap > 0,
> > +		},
> > +		{
> > +			.name = "error checks with key fetch prot override",
> > +			.test = test_errors_key_fetch_prot_override_enabled,
> > +			.requirements_met = extension_cap > 0,
> 
> I wonder whether it would rather make sense to check for "extension_cap & 1" 
> instead of "extension_cap > 0" ?

The cap should always have been a bitmap, but unfortunately I didn't initially
define it as one, the storage key extension must be supported if the cap > 0.
So the test reflects that and may catch an error in the future.
> 
> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
Thanks!
