Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4925B22ACF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 12:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgGWKtF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 06:49:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727996AbgGWKtE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 06:49:04 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NAYWW1043310;
        Thu, 23 Jul 2020 06:48:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ecpbg4wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:48:48 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NAel08062237;
        Thu, 23 Jul 2020 06:48:48 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ecpbg4w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:48:48 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NAjRBI001639;
        Thu, 23 Jul 2020 10:48:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 32brq7p2u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 10:48:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NAmfY161407296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 10:48:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C7E64C050;
        Thu, 23 Jul 2020 10:48:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 302964C044;
        Thu, 23 Jul 2020 10:48:38 +0000 (GMT)
Received: from [9.199.40.160] (unknown [9.199.40.160])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 10:48:37 +0000 (GMT)
Subject: Re: [PATCH 0/7] powerpc/watchpoint: 2nd DAWR kvm enablement +
 selftests
To:     mpe@ellerman.id.au, paulus@samba.org
Cc:     mikey@neuling.org, npiggin@gmail.com, pbonzini@redhat.com,
        christophe.leroy@c-s.fr, jniethe5@gmail.com, pedromfc@br.ibm.com,
        rogealve@br.ibm.com, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <a50f2a17-ccd0-6772-6c55-82a37561bf76@linux.ibm.com>
Date:   Thu, 23 Jul 2020 16:18:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=942 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230076
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 7/23/20 3:50 PM, Ravi Bangoria wrote:
> Patch #1, #2 and #3 enables p10 2nd DAWR feature for Book3S kvm guest. DAWR
> is a hypervisor resource and thus H_SET_MODE hcall is used to set/unset it.
> A new case H_SET_MODE_RESOURCE_SET_DAWR1 is introduced in H_SET_MODE hcall
> for setting/unsetting 2nd DAWR. Also, new capability KVM_CAP_PPC_DAWR1 has
> been added to query 2nd DAWR support via kvm ioctl.
> 
> This feature also needs to be enabled in Qemu to really use it. I'll reply
> link to qemu patches once I post them in qemu-devel mailing list.

Qemu patches: https://lore.kernel.org/kvm/20200723104220.314671-1-ravi.bangoria@linux.ibm.com
