Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EAA25A4E4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 07:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBFNz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 01:13:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbgIBFNx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 01:13:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0824Wo1Q129282;
        Wed, 2 Sep 2020 01:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bcFjTM9prI7H/cWTGkaxNjaQRb2P7oXYF4edeXsqgw0=;
 b=px5rCbOH6Y3t3FkN6B+xOpxyoMI1sMjzEda43gR0g2PQfP8qDg8IIwv+GGLco5Ix+wD7
 sJdjSd/35XRC1E7AY03EF6mvtdecgaiVBSLkkl99oM7jqtzZStFk/x+UzFLlS5MYj3TU
 lrC54lY9MkhFCPDx3yxGkkHWBnwNq+D9z5Voil5lJAwUZVlwbyUZXlWrq7eShLkwfsyt
 JY7i/wh/Y8LJtWjL+GX0ri2y1tpS/LxWHgJgNrMGZFPflE33iM8AO8N0wQPahKh4zyUs
 dRh1WF+NnBQ10H+doBUwwJnpF6A0CeXZ+bB6ejTtUAMQgKupRDpPjBwrWujGT2g9NbGO Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a462h7va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 01:13:44 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 082514j8045612;
        Wed, 2 Sep 2020 01:13:44 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a462h7uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 01:13:43 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0825DG0p014118;
        Wed, 2 Sep 2020 05:13:41 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 337e9gva6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 05:13:41 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0825Dbie30867902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 05:13:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A16DA405F;
        Wed,  2 Sep 2020 05:13:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C056A4054;
        Wed,  2 Sep 2020 05:13:34 +0000 (GMT)
Received: from [9.199.37.120] (unknown [9.199.37.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 05:13:33 +0000 (GMT)
Subject: Re: [PATCH 0/7] powerpc/watchpoint: 2nd DAWR kvm enablement +
 selftests
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
 <20200902023259.GC272502@thinks.paulus.ozlabs.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <38177cfb-3abf-2629-174a-cdd958286be2@linux.ibm.com>
Date:   Wed, 2 Sep 2020 10:43:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902023259.GC272502@thinks.paulus.ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_02:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009020042
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paul,

On 9/2/20 8:02 AM, Paul Mackerras wrote:
> On Thu, Jul 23, 2020 at 03:50:51PM +0530, Ravi Bangoria wrote:
>> Patch #1, #2 and #3 enables p10 2nd DAWR feature for Book3S kvm guest. DAWR
>> is a hypervisor resource and thus H_SET_MODE hcall is used to set/unset it.
>> A new case H_SET_MODE_RESOURCE_SET_DAWR1 is introduced in H_SET_MODE hcall
>> for setting/unsetting 2nd DAWR. Also, new capability KVM_CAP_PPC_DAWR1 has
>> been added to query 2nd DAWR support via kvm ioctl.
>>
>> This feature also needs to be enabled in Qemu to really use it. I'll reply
>> link to qemu patches once I post them in qemu-devel mailing list.
>>
>> Patch #4, #5, #6 and #7 adds selftests to test 2nd DAWR.
> 
> If/when you resubmit these patches, please split the KVM patches into
> a separate series, since the KVM patches would go via my tree whereas
> I expect the selftests/powerpc patches would go through Michael
> Ellerman's tree.

Sure. Will split it.

Thanks,
Ravi
