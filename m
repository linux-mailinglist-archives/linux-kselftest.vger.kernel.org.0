Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68D048DD6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jan 2022 19:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbiAMSEM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jan 2022 13:04:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237440AbiAMSEL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jan 2022 13:04:11 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DHqsod027852;
        Thu, 13 Jan 2022 18:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=h7PGYmYGOaS7whOzz2krlo4qhHm2j2+iN2wg1u9LGzo=;
 b=IugUQjNZbqI3tZpwi2Y5jTuSZwFgqmdjxbunCKZCJYFV56Gmj8Js7Ztgs2mCqhZ9DoV7
 ZmZfPRMgjpb3S6SJNopcGbp2WdHvyt73Vp705LYD60xXZ9ShaeAKXWPpCR9uzywhd/qo
 +ojjK6Ce0skaNzRPmJnVDG/jFFjE6UF/kXOLEMa74PJgaieNk44xZPM6oBgDztH4jVhf
 CYLZRwjyU6KkaI6LjC8THxoaHUsVp33k+Oc9ME4dIh7b9y4vSTJrkrOWdp/kNFAyIhf7
 kPHVXXSr64tLFiP08Vf7zo8uxA2heOpVbz4Y7jRa/wrCI1X0QZ+DTiKPMBzpKlLDS7mO gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djrv98716-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 18:04:07 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DHu1qC009802;
        Thu, 13 Jan 2022 18:04:07 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djrv9870x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 18:04:07 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DI3qek007408;
        Thu, 13 Jan 2022 18:04:05 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 3df28bya1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 18:04:05 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DI447v27066710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:04:04 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F7F32806A;
        Thu, 13 Jan 2022 18:04:04 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3544A28064;
        Thu, 13 Jan 2022 18:04:04 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 18:04:04 +0000 (GMT)
Message-ID: <1e3b1e6f-6600-d77f-843b-f3d60e062192@linux.ibm.com>
Date:   Thu, 13 Jan 2022 13:04:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 1/2] selftests: tpm2: Determine available PCR bank
Content-Language: en-US
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
 <20211128041052.1395504-2-stefanb@linux.vnet.ibm.com>
 <YaVkw5dnCewnFybR@iki.fi>
 <eaad369c-f02e-8d83-94b1-fdac7ae84388@linux.ibm.com>
In-Reply-To: <eaad369c-f02e-8d83-94b1-fdac7ae84388@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VhrntTOZ2fUnC6cHeX1xOWCtbKldnM9b
X-Proofpoint-ORIG-GUID: eYe9VVJM1UlquiHJWHJU8lBVaQ_VmqMM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_08,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 mlxlogscore=822
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130112
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Jarkko,

   can you take this patch 1/2?

  https://lore.kernel.org/lkml/20211128041052.1395504-1-stefanb@linux.vnet.ibm.com/T/#m21209a978c237368499ce5f082f3c0fc03bcbbeb

   Stefan


On 12/23/21 20:12, Stefan Berger wrote:
> Shuah,
>
>   are you going to take this fix here - only 1/2 ?
>
> https://lore.kernel.org/lkml/20211128041052.1395504-1-stefanb@linux.vnet.ibm.com/T/#m21209a978c237368499ce5f082f3c0fc03bcbbeb 
>
>
>   Stefan
>
> On 11/29/21 18:39, Jarkko Sakkinen wrote:
>> On Sat, Nov 27, 2021 at 11:10:51PM -0500, Stefan Berger wrote:
>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>
>>> Determine an available PCR bank to be used by a test case by 
>>> querying the
>>> capability TPM2_GET_CAP. The TPM2 returns TPML_PCR_SELECTIONS that
>>> contains an array of TPMS_PCR_SELECTIONs indicating available PCR banks
>>> and the bitmasks that show which PCRs are enabled in each bank. Collect
>>> the data in a dictionary. From the dictionary determine the PCR bank 
>>> that
>>> has the PCRs enabled that the test needs. This avoids test failures 
>>> with
>>> TPM2's that either to not have a SHA-1 bank or whose SHA-1 bank is
>>> disabled.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> /Jarkko
