Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1687F4FA568
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Apr 2022 08:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiDIG33 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 9 Apr 2022 02:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiDIG32 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 9 Apr 2022 02:29:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F322DB8;
        Fri,  8 Apr 2022 23:27:23 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2391w3ba025898;
        Sat, 9 Apr 2022 06:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=nYfBhDx5KHSviKmstdKzW4aGEpU3WaJk1veF4iMWIYQ=;
 b=lZAT0Jq4ePVPHjzHWWjB/o3Q7pG2Y+j55Ob4S6hcGssB4c4DGDL3Ocis7aaMFms834EL
 qNvd8ev4GvfzpWdZbTlpYZgHyaVov/Z4hTdNKio36DHg0dPmcdLW4BSow8PJZCDo7oKL
 cJ1G2+duxuot+Q0jhrEBU96LZ0QRGs9hfTmtyOYO2PfmqJNZveV61+PhHOrmH8uqPwrF
 VgOOvFdj0LX9Psu5+EcoH8rAT2Cdlt5o2pM1G/ZhGiAkOeFSsIGxvupCBcunMzm0IQdk
 eWOlzA2jSnT6mgAKwpEmO8j4UHLUJfKha+bQdWAAEFa9Bhodh1jmupksovQ/9SDwDGY5 OQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fb0xs2r47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Apr 2022 06:27:08 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2396OB1g017901;
        Sat, 9 Apr 2022 06:27:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3fb1s8r5kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Apr 2022 06:27:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2396RBrd39911928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Apr 2022 06:27:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C9A2AE051;
        Sat,  9 Apr 2022 06:27:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75477AE04D;
        Sat,  9 Apr 2022 06:26:57 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.90.23])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  9 Apr 2022 06:26:57 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V3] testing/selftests/mqueue: Fix mq_perf_tests to free
 the allocated cpu set
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <1a1d119a-e68e-a590-a518-cfb3c78ed888@linuxfoundation.org>
Date:   Sat, 9 Apr 2022 11:56:53 +0530
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        disgoel@linux.vnet.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maddy@linux.vnet.ibm.com, kajoljain <kjain@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Transfer-Encoding: 7bit
Message-Id: <4973403A-8E1A-4863-B5B1-C56BC2707B4A@linux.vnet.ibm.com>
References: <20220408072431.94947-1-atrajeev@linux.vnet.ibm.com>
 <1a1d119a-e68e-a590-a518-cfb3c78ed888@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SQpAvJspqU78G8kAEF2mu5h6fMw24oIl
X-Proofpoint-GUID: SQpAvJspqU78G8kAEF2mu5h6fMw24oIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_09,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204090037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 09-Apr-2022, at 12:00 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
> On 4/8/22 1:24 AM, Athira Rajeev wrote:
>> The selftest "mqueue/mq_perf_tests.c" use CPU_ALLOC to allocate
>> CPU set. This cpu set is used further in pthread_attr_setaffinity_np
>> and by pthread_create in the code. But in current code, allocated
>> cpu set is not freed.
>> Fix this issue by adding CPU_FREE in the "shutdown" function which
>> is called in most of the error/exit path for the cleanup. There are
>> few error paths which exit without using shutdown. Add a common goto
>> error path with CPU_FREE for these cases.
>> Fixes: 7820b0715b6f ("tools/selftests: add mq_perf_tests")
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> Changelog:
>>  From v2 -> v3:
>>   Addressed review comment from Shuah Khan to add
>>   common "goto" error path with CPU_FREE for few exit
>>   cases.
>>  From v1 -> v2:
>>   Addressed review comment from Shuah Khan to add
>>   CPU_FREE in other exit paths where it is needed
> 
> Thank you. I will queue this up for Linux 5.18-rc3

Thanks Shuah

Athira
> 
> thanks,
> -- Shuah

