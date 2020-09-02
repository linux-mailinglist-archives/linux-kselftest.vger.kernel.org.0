Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B525A4D1
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 07:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIBFKE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 01:10:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgIBFKC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 01:10:02 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08251Z5s156666;
        Wed, 2 Sep 2020 01:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=va4X/XnVOGn7MM6uvsEvIRgl5Wa0iCBRzbiQS5tv7ZM=;
 b=H3V9cbGz7dyNrXXTdHRRMlkcH7x9WlsId7IMCHCdHEbCDxDL6EYTtkqPpHEpm86jW1we
 j0vE8ficPd1OlQItK1kPbTtV9hLOk162xVBPJvNNkUtfRscrQ/34g+AnAIDKw9B1zdfp
 VIMKOpPVYeGE2Gyp8TVPhWAqPNa8KP4unZBGQHJOywg0leDPUrKZPLLs3hN513PgPV3C
 t9f2CFd5tF/Z3AaqosKD5/JFUCe84x2Tb+SkosMKM2EgrTn5U+qjc83sIqnnqhp722rp
 iluRm4T7+4BOKwLsR+UQNCWZzhv2CopRGrQpO5LBnbkSECmNBuedYjR+PdtOTgvuzhhV dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a4c48un1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 01:09:53 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08254vH9166033;
        Wed, 2 Sep 2020 01:09:53 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a4c48um9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 01:09:53 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08251opN022321;
        Wed, 2 Sep 2020 05:09:50 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 337en849ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 05:09:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08259lPr62325026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 05:09:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFF86A405F;
        Wed,  2 Sep 2020 05:09:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91C7AA4054;
        Wed,  2 Sep 2020 05:09:43 +0000 (GMT)
Received: from [9.199.37.120] (unknown [9.199.37.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 05:09:43 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 1/7] powerpc/watchpoint/kvm: Rename current DAWR macros
 and variables
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
 <20200723102058.312282-2-ravi.bangoria@linux.ibm.com>
 <20200902014908.GA272502@thinks.paulus.ozlabs.org>
Message-ID: <174036fb-1ee9-0e33-64a0-b021f53ac301@linux.ibm.com>
Date:   Wed, 2 Sep 2020 10:39:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902014908.GA272502@thinks.paulus.ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_02:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 bulkscore=0 clxscore=1015 mlxlogscore=942
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020042
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paul,

On 9/2/20 7:19 AM, Paul Mackerras wrote:
> On Thu, Jul 23, 2020 at 03:50:52PM +0530, Ravi Bangoria wrote:
>> Power10 is introducing second DAWR. Use real register names (with
>> suffix 0) from ISA for current macros and variables used by kvm.
> 
> Most of this looks fine, but I think we should not change the existing
> names in arch/powerpc/include/uapi/asm/kvm.h (and therefore also
> Documentation/virt/kvm/api.rst).

Missed that I'm changing uapi. I'll rename only those macros/variables
which are not uapi.

Thanks,
Ravi
