Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6104C47EA1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Dec 2021 02:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhLXBMd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Dec 2021 20:12:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229995AbhLXBMd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Dec 2021 20:12:33 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BO175Xw018647;
        Fri, 24 Dec 2021 01:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NcT3ysjtJESuIVVpCtisdKBE1Dd2aThqk8vQduNnOpA=;
 b=QShAs9+1a8eNTcuItKQaEIKesHAbL8beH9Gn77oPlPW+jW+6RoWAR2zhw3CephuGIRZ/
 EfPYPamTUBaykFtvR2hVvx6otkXmVLD/1nxKOmHNktxe6VqEGCBry2hr690x1c6svVP2
 w+RVIXVRdDmMDMTypUgv6+ikWjMSHGc4k0tJPhOs0sauKj3yRBrwhnkQDguXPPes1aT4
 liULvGDFODaXsAJmYZdzGDGdeybrfAxFEdO6IjyKge5j1//qDRMkQ8xLUXaJfyh3slUr
 yxsZRbbZGZG/Ic7QoHEY4W/cQBqV3lvVK8F2Bu7a0TDph7QbwMMVPSGYxNbPJa+srkNL 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d53er8nbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Dec 2021 01:12:25 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BO1COLx016349;
        Fri, 24 Dec 2021 01:12:24 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d53er8nb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Dec 2021 01:12:24 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BO18Oc8017357;
        Fri, 24 Dec 2021 01:12:23 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 3d179cjftt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Dec 2021 01:12:23 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BO1CMSQ32899514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Dec 2021 01:12:22 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 857DE136055;
        Fri, 24 Dec 2021 01:12:22 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18B81136051;
        Fri, 24 Dec 2021 01:12:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 24 Dec 2021 01:12:21 +0000 (GMT)
Message-ID: <eaad369c-f02e-8d83-94b1-fdac7ae84388@linux.ibm.com>
Date:   Thu, 23 Dec 2021 20:12:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 1/2] selftests: tpm2: Determine available PCR bank
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
 <20211128041052.1395504-2-stefanb@linux.vnet.ibm.com>
 <YaVkw5dnCewnFybR@iki.fi>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <YaVkw5dnCewnFybR@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xyxYc-MQo0TGsoyoLjdFQZLRiKq0NiLA
X-Proofpoint-GUID: 0dFsPYYrfZ2EI2Db5bbTYP74_AHKPmQg
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_04,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=826 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112240003
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah,

   are you going to take this fix here - only 1/2 ?

https://lore.kernel.org/lkml/20211128041052.1395504-1-stefanb@linux.vnet.ibm.com/T/#m21209a978c237368499ce5f082f3c0fc03bcbbeb

   Stefan

On 11/29/21 18:39, Jarkko Sakkinen wrote:
> On Sat, Nov 27, 2021 at 11:10:51PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Determine an available PCR bank to be used by a test case by querying the
>> capability TPM2_GET_CAP. The TPM2 returns TPML_PCR_SELECTIONS that
>> contains an array of TPMS_PCR_SELECTIONs indicating available PCR banks
>> and the bitmasks that show which PCRs are enabled in each bank. Collect
>> the data in a dictionary. From the dictionary determine the PCR bank that
>> has the PCRs enabled that the test needs. This avoids test failures with
>> TPM2's that either to not have a SHA-1 bank or whose SHA-1 bank is
>> disabled.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> /Jarkko
