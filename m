Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147164F74B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Apr 2022 06:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiDGEdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 00:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbiDGEdD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 00:33:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828991B72E2;
        Wed,  6 Apr 2022 21:31:02 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2371xqbG001195;
        Thu, 7 Apr 2022 04:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=+8gXMvVjK0KxksGPAS5jiBbbQX+sYZYTJj+FXkYiBS0=;
 b=h3ZVhvTymZlsIpXeUFJjihXCSQydEAtN6ZTjnk0j8Z/b7lJoSOardNVedPqJcfP07N/7
 JLcvsh4GVpljFNVY/a2foAqJDt7BBnK4kigit5MqDVzymRBUNVdibs0CqUXmtibL7wzI
 BkXrQZXifWiEjNXelDiJV/ni6ECSdjgEe7qKcyrON7z31N8zn0jDQgY8vF/0HC9uxVgs
 kY6RS5LGG55QmAPDs/+yCT7/ZcwCrwzUp5bIZH1Cb+2HYZVyJ6kCLSX8ByfYMLl7A8mW
 ig2AGsboaNkYSAccQWdujlm9o33WyL9gm0xLraYw2z1AMGfpOd8T4ymk5eZKRbi16Qs3 Vg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f983mcf1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 04:30:49 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2374RDKj010858;
        Thu, 7 Apr 2022 04:30:47 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3f6drhqdrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 04:30:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2374UjPO38207798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Apr 2022 04:30:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0522CA405C;
        Thu,  7 Apr 2022 04:30:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 926AFA405B;
        Thu,  7 Apr 2022 04:30:39 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.112.159])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Apr 2022 04:30:39 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] testing/selftests/mqueue: Fix mq_perf_tests to free the
 allocated cpu set
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ad0648a9-0252-2d1f-cc48-7e14846fc0af@linuxfoundation.org>
Date:   Thu, 7 Apr 2022 10:00:35 +0530
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        disgoel@linux.vnet.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maddy@linux.vnet.ibm.com, kajoljain <kjain@linux.ibm.com>,
        srikar@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F30C53D1-F01A-44C2-A2FB-E024FF2CAEC8@linux.vnet.ibm.com>
References: <20220406175715.87937-1-atrajeev@linux.vnet.ibm.com>
 <ad0648a9-0252-2d1f-cc48-7e14846fc0af@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1_AH7w4lqQDUG9LvXf8wy8LWNlMtczef
X-Proofpoint-GUID: 1_AH7w4lqQDUG9LvXf8wy8LWNlMtczef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_13,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070021
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 07-Apr-2022, at 1:35 AM, Shuah Khan <skhan@linuxfoundation.org> =
wrote:
>=20
> On 4/6/22 11:57 AM, Athira Rajeev wrote:
>> The selftest "mqueue/mq_perf_tests.c" use CPU_ALLOC to allocate
>> CPU set. This cpu set is used further in pthread_attr_setaffinity_np
>> and by pthread_create in the code. But in current code, allocated
>> cpu set is not freed. Fix this by adding CPU_FREE after its usage
>> is done.
>=20
> Good find.
>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>>  tools/testing/selftests/mqueue/mq_perf_tests.c | 1 +
>>  1 file changed, 1 insertion(+)
>> diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c =
b/tools/testing/selftests/mqueue/mq_perf_tests.c
>> index b019e0b8221c..17c41f216bef 100644
>> --- a/tools/testing/selftests/mqueue/mq_perf_tests.c
>> +++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
>> @@ -732,6 +732,7 @@ int main(int argc, char *argv[])
>>  		pthread_attr_destroy(&thread_attr);
>>  	}
>>  +	CPU_FREE(cpu_set);
>>  	if (!continuous_mode) {
>>  		pthread_join(cpu_threads[0], &retval);
>>  		shutdown((long)retval, "perf_test_thread()", __LINE__);
>=20
> CPU_ALLOC() is called very early on in main() and there are a
> few error paths that exit without calling CPU_FREE. This change
> doesn't fully fix the problem.
>=20
> Review the other exit paths where CPU_FREE is needed.
Sure, Thanks for the review.
I will check and post a V2

thanks
Athira
>=20
> thanks,
> -- Shuah

