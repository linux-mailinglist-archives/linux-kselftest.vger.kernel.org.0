Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1614F8F97
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 09:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiDHH21 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiDHH2P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 03:28:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E5824BD4E;
        Fri,  8 Apr 2022 00:26:09 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2385R2GY012011;
        Fri, 8 Apr 2022 07:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=iucbixVGgvNKncTrN9r2EzWUCoseJpaiWsweIa8blg8=;
 b=HmxUC2RqOZPDYsnqmuZ+EEukjuHv/FT68sa9FX0g1Kvla6WyJ7I0eRx4WnLJrJkiqXbx
 kTNBqBh3TmWDGPlCX8Gc/m0elFpNnZXEOljMxEcmgwQ1Rlv+6Ewa6eqzOt5lDQvV5M77
 5nrhDsOSWWZ7727wTq3MRSSESYhe4BfSHsm0AN2bl+zxmsnskK+v+gBQ7BSag+kYTHFD
 yzpIn3AfXsUGEeuvugSVeGSdoVu7kx6wPtQDqy4b45h6rDDc9K/rqwPsiFwH/ui+xG6v
 EMF01lIQVy0bIxsq0K60rmnjobPHuJBqn4IL54x+qwhWCGVsLxNfRBnA2UILogiY+bYx uw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3faewhsy8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 07:26:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2387Ct8N024454;
        Fri, 8 Apr 2022 07:25:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3f6e493974-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 07:25:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2387Pu6a40304998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 07:25:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A7C75204F;
        Fri,  8 Apr 2022 07:25:56 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.146.176])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id CDEDC52052;
        Fri,  8 Apr 2022 07:25:50 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V2] testing/selftests/mqueue: Fix mq_perf_tests to free
 the allocated cpu set
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <e9c8a8c7-9a0d-09be-343d-038b7f791b98@linuxfoundation.org>
Date:   Fri, 8 Apr 2022 12:55:46 +0530
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        disgoel@linux.vnet.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maddy@linux.vnet.ibm.com, kajoljain <kjain@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03A2A043-D434-49F2-B5D0-0886493B6627@linux.vnet.ibm.com>
References: <20220407184008.93879-1-atrajeev@linux.vnet.ibm.com>
 <e9c8a8c7-9a0d-09be-343d-038b7f791b98@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CgqWc5Pe_JWR8dyOqjNncH6J5mzPkgmv
X-Proofpoint-GUID: CgqWc5Pe_JWR8dyOqjNncH6J5mzPkgmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_02,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 08-Apr-2022, at 12:31 AM, Shuah Khan <skhan@linuxfoundation.org> =
wrote:
>=20
> On 4/7/22 12:40 PM, Athira Rajeev wrote:
>> The selftest "mqueue/mq_perf_tests.c" use CPU_ALLOC to allocate
>> CPU set. This cpu set is used further in pthread_attr_setaffinity_np
>> and by pthread_create in the code. But in current code, allocated
>> cpu set is not freed.
>> Fix this issue by adding CPU_FREE in the "shutdown" function which
>> is called in most of the error/exit path for the cleanup. Also add
>> CPU_FREE in some of the error paths where shutdown is not called.
>> Fixes: 7820b0715b6f ("tools/selftests: add mq_perf_tests")
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> Changelog:
>> =46rom v1 -> v2:
>>  Addressed review comment from Shuah Khan to add
>>  CPU_FREE in other exit paths where it is needed
>=20
> Thank you. I have a couple of comments on making the error
> paths simpler. Please see below.
>=20
>>  tools/testing/selftests/mqueue/mq_perf_tests.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c =
b/tools/testing/selftests/mqueue/mq_perf_tests.c
>> index b019e0b8221c..182434c7898d 100644
>> --- a/tools/testing/selftests/mqueue/mq_perf_tests.c
>> +++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
>> @@ -180,6 +180,9 @@ void shutdown(int exit_val, char *err_cause, int =
line_no)
>>  	if (in_shutdown++)
>>  		return;
>>  +	/* Free the cpu_set allocated using CPU_ALLOC in main function =
*/
>> +	CPU_FREE(cpu_set);
>> +
>>  	for (i =3D 0; i < num_cpus_to_pin; i++)
>>  		if (cpu_threads[i]) {
>>  			pthread_kill(cpu_threads[i], SIGUSR1);
>> @@ -589,6 +592,7 @@ int main(int argc, char *argv[])
>>  						cpu_set)) {
>>  					fprintf(stderr, "Any given CPU =
may "
>>  						"only be given =
once.\n");
>> +					CPU_FREE(cpu_set);
>=20
> This could be done in a common error path handling.
>=20
>>  					exit(1);
>>  				} else
>>  					CPU_SET_S(cpus_to_pin[cpu],
>> @@ -607,6 +611,7 @@ int main(int argc, char *argv[])
>>  				queue_path =3D malloc(strlen(option) + =
2);
>>  				if (!queue_path) {
>>  					perror("malloc()");
>> +					CPU_FREE(cpu_set);
>=20
> This could be done in a common error path handling.
>=20
>>  					exit(1);
>>  				}
>>  				queue_path[0] =3D '/';
>> @@ -619,6 +624,7 @@ int main(int argc, char *argv[])
>>  	}
>>    	if (continuous_mode && num_cpus_to_pin =3D=3D 0) {
>> +		CPU_FREE(cpu_set);
>=20
> This could be done in a common error path handling.
>=20
>>  		fprintf(stderr, "Must pass at least one CPU to =
continuous "
>>  			"mode.\n");
>>  		poptPrintUsage(popt_context, stderr, 0);
>> @@ -628,10 +634,12 @@ int main(int argc, char *argv[])
>>  		cpus_to_pin[0] =3D cpus_online - 1;
>>  	}
>>  -	if (getuid() !=3D 0)
>> +	if (getuid() !=3D 0) {
>> +		CPU_FREE(cpu_set);
>>  		ksft_exit_skip("Not running as root, but almost all =
tests "
>>  			"require root in order to modify\nsystem =
settings.  "
>>  			"Exiting.\n");
>> +	}
>> =20
>=20
> Why not move this check before CPU_ALLOC and make this the very first
> check in main()?
>=20
> With this change the other places where CPU_FREE is added right before
> exit(1). Something like this:
>=20
> err_code:
> 	CPU_FREE(cpu_set);
> 	exit(code)
Hi Shuah

Thanks for the comments. Addressed these in V3

Athira
>=20
>>  	max_msgs =3D fopen(MAX_MSGS, "r+");
>>  	max_msgsize =3D fopen(MAX_MSGSIZE, "r+");
>=20
> thanks,
> -- Shuah

