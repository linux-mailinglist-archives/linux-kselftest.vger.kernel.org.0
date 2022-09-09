Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477845B3C34
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiIIPkl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiIIPkE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 11:40:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572432F3BB;
        Fri,  9 Sep 2022 08:39:41 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289Fbpdf008725;
        Fri, 9 Sep 2022 15:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3ePY4hKVSpb2F1EadTkRiHblB/mT0M9rNddWhkrVcE4=;
 b=KKQLsF6jphe/3BC/q+XjZZrP2AEugxCnPogOpe/rhi7MHGvJ3SYUlx6c5btgPdiUlXtI
 tXXJQuFFZ7/neUuF3U9yIFK/FBhI7XCEeBAcmYrggXtEjkxsL8wkY0BwGgiPHbNKDtU/
 F3wBA8UDQ0fd2d1tH7WPgiJI0fz9fRytHv9zOYXKcctfSyp+acXCPkEnTpkdFCMUpD7m
 i7CEw4PFSu7uw9YALMOawNfyXZ2aBcmJlpPjEmnlQWNdGMh0TXGioPy55B36kxVBMfyU
 Q0ffvnbk3fVhZr0Up+30UGeC2WYskQoL9SuuF8Wu0V11dMYsTwIMXjV2I/HVOS8Lh7+x aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg7xw0r7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 15:39:37 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 289FcDti012462;
        Fri, 9 Sep 2022 15:39:37 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg7xw0r71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 15:39:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 289FKI4w007158;
        Fri, 9 Sep 2022 15:39:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3jbx6hr6hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 15:39:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 289FdWvJ33292550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Sep 2022 15:39:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D05A4AE051;
        Fri,  9 Sep 2022 15:39:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B78B8AE045;
        Fri,  9 Sep 2022 15:39:30 +0000 (GMT)
Received: from [9.43.45.94] (unknown [9.43.45.94])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Sep 2022 15:39:30 +0000 (GMT)
Message-ID: <ca93a532-0a68-0c4f-8920-33b76603dd69@linux.ibm.com>
Date:   Fri, 9 Sep 2022 21:09:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] selftests: tpm2: Implement class desstructor to close
 file descriptor
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>, jarkko@kernel.org,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220909152056.1335261-1-stefanb@linux.vnet.ibm.com>
From:   R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20220909152056.1335261-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yE2a_QAvRvwUn-5eNn7uJeM5paH6dRCz
X-Proofpoint-GUID: qhDHhchaightWAAC-cxYiEFpaip7NJW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 spamscore=0 mlxlogscore=698
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090054
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 09/09/22 8:50 pm, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Implement a class destructor to close the open TPM file descriptor
> and avoid the following error message:
> 
>   test_flush_context (tpm2_tests.SpaceTest) ... \
>     /usr/lib64/python3.6/unittest/case.py:605: ResourceWarning: \
>     unclosed file <_io.FileIO name='/dev/tpmrm0' mode='rb+' closefd=True>
> 
> Fixes: 6ea3dfe1e0732 ("selftests: add TPM 2.0 tests")
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

> 
> ---
>   tools/testing/selftests/tpm2/tpm2.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
> index 057a4f49c79d..c7363c6764fc 100644
> --- a/tools/testing/selftests/tpm2/tpm2.py
> +++ b/tools/testing/selftests/tpm2/tpm2.py
> @@ -371,6 +371,10 @@ class Client:
>               fcntl.fcntl(self.tpm, fcntl.F_SETFL, flags)
>               self.tpm_poll = select.poll()
>   
> +    def __del__(self):
> +        if self.tpm:
> +            self.tpm.close()
> +
>       def close(self):
>           self.tpm.close()
>   

-- 
Thanks and Regards
R.Nageswara Sastry
