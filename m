Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C2C5BE6CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiITNPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiITNPJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 09:15:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346CADFC1;
        Tue, 20 Sep 2022 06:15:08 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KCv4DR030618;
        Tue, 20 Sep 2022 13:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Fu48Iu5NZOSMbIsP/71F9Oo1u/l7GC3lQUvjx3+9/DU=;
 b=qfY3ES7Q8geDtPSLunWm72PVNfuaKMb3pLROe/l1dZg2hpyFgu4s48KUITkum9h1gTPl
 PWukBCco2c62L8qAFbrFYsPsW/lxBhlukgWEhtN0wQY8gU7YrMGS1IP/p5F2eOQdB72Y
 YjgQPL4Y+eU3YZzqo0Swe7Rz2ahkQWPTQYxFhLVMQp3aCIkPd6wz5Rv3kQeoszZPoPOX
 NeoNzT9nWpCiXD89yWq2UJB9/a06r4vtkdWvoP734ho0kTlQeHaZhXaaI2AwpUZGJw9d
 F/Un8/qhIOrsGTIgh4XkTb9vRjnTLr2TamlNOB3NazJWo6Ac8yWNqw4DgGApZpU442xm /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqdyq0syj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 13:14:58 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KCwVNt006513;
        Tue, 20 Sep 2022 13:14:58 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqdyq0sxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 13:14:58 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KD68AP016844;
        Tue, 20 Sep 2022 13:14:57 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 3jn5v9ru6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 13:14:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com ([9.208.128.117])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KDEtFe57016738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 13:14:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E3C458061;
        Tue, 20 Sep 2022 13:14:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D25F25805D;
        Tue, 20 Sep 2022 13:14:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 20 Sep 2022 13:14:54 +0000 (GMT)
Message-ID: <e6882322-c4c3-97c2-2419-a85ac4caf80d@linux.ibm.com>
Date:   Tue, 20 Sep 2022 09:14:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] selftests: tpm2: Implement class desstructor to close
 file descriptor
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Shuah Khan <shuah@kernel.org>
References: <20220909152056.1335261-1-stefanb@linux.vnet.ibm.com>
 <YylCPAGbn7MgICau@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <YylCPAGbn7MgICau@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fu9k58Bi8l807cSLdaQMrgsrDeHR4Hos
X-Proofpoint-GUID: h1TUp8ni_kFmzX9Pu3biyaVQnUr_RTpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_04,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=460
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200077
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/20/22 00:31, Jarkko Sakkinen wrote:

>>
>>   test_flush_context (tpm2_tests.SpaceTest) ... \
>>     /usr/lib64/python3.6/unittest/case.py:605: ResourceWarning: \
>>     unclosed file <_io.FileIO name='/dev/tpmrm0' mode='rb+' closefd=True>
> 
> I don't recall seeing this. Does this happen on every test case?

No, only on that one test case.

    Stefan
