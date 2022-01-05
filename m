Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71BB48567C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 17:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbiAEQJ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 11:09:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241838AbiAEQJ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 11:09:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205F175a019294;
        Wed, 5 Jan 2022 16:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rd9wmIkq+S7vABNjYzU/I+AniDbecT1eW9IJXbVFL7k=;
 b=dkBNp1Fh28RSX1bxRdDYjhx39xi7HiOgk07+eigx3E3NmSAXGj4Gwcx/74wrT100GIvD
 PBlH01HWhDt4PPcOm91Dcgq4g9gvXIRoL20eE1oXuO6Kvon7i5FSMc3Wh20gLYWR4fod
 5ckdgv8msG1RYVvn9xh+TVeE13LvVXAgUUchenOKPfTR/2dpy/q9tKdgzgy+VHmCJHda
 i4xb9P/E+hBLul2nUCjfqr1kU2laaNHQf2NQXP5Haik4syNXM1039xYesLikDVBScd+N
 2w0IzGN9NqbaITBW17GsiWYFC15xEzz3VwbDr5vWocuutPsCs/FV7x2RkPZDwv+cp7wC Pg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dcpka1txe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 16:09:48 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 205G8j0H019268;
        Wed, 5 Jan 2022 16:09:47 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3daekbgw02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 16:09:47 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 205G9j1g9044690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jan 2022 16:09:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8861B205F;
        Wed,  5 Jan 2022 16:09:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7850B206A;
        Wed,  5 Jan 2022 16:09:43 +0000 (GMT)
Received: from [9.211.129.18] (unknown [9.211.129.18])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jan 2022 16:09:43 +0000 (GMT)
Message-ID: <cade9459-919d-cae9-a7a4-c4ce01ba8098@linux.vnet.ibm.com>
Date:   Wed, 5 Jan 2022 11:09:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] selftests/kexec: Enable secureboot tests for PowerPC
Content-Language: en-US
To:     Nageswara R Sastry <rnsastry@linux.ibm.com>, zohar@linux.ibm.com,
        linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        mpe@ellerman.id.au, shuah@kernel.org
Cc:     nayna@linux.ibm.com, dja@axtens.net, gcwilson@linux.ibm.com
References: <20211124070802.1765-1-rnsastry@linux.ibm.com>
 <20211124070802.1765-2-rnsastry@linux.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20211124070802.1765-2-rnsastry@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1eeeELXo-vPOfYQgC9kmmumlTvbm7PwA
X-Proofpoint-ORIG-GUID: 1eeeELXo-vPOfYQgC9kmmumlTvbm7PwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_04,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050108
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/24/21 02:08, Nageswara R Sastry wrote:
> Existing test cases determine secureboot state using efi variable, which is
> available only on x86 architecture.
> Add support for determining secureboot state using device tree property on
> PowerPC architecture.

Please replace 'PowerPC' with 'PowerNV'.

Rest looks good.

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

Tested-by: Nayna Jain <nayna@linux.ibm.com>

Thanks & Regards,

      - Nayna

