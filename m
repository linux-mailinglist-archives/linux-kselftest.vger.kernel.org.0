Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B56EDB2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 07:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjDYF2p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 01:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYF2o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 01:28:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931AA5FF3;
        Mon, 24 Apr 2023 22:28:43 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P5R6xv010807;
        Tue, 25 Apr 2023 05:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=0hViQHH/4MsPGsHuWIXp0SGYVzHMq4LYsDI7u76Jy04=;
 b=c1jv+N8a/m4q90g1RRTdOHTAAW0YP+43EMY41tWNLtp6LnSMSUcuRK2wpR2Ppq/glwsL
 TzECfAU1ChblkbsNunHvMl5aE5C9IOUEBrhGc0v4qxJA1qkBxovjfdD8NXER7sJJjosw
 Cp/eLMG+mMtYyGZ6jENlj4tcbeNd3AGA8HpNNw+366IbpXqPxPkBb8KfdscC89Jf2Cls
 13vcnZVlELfOdo+na8XSZ440rVJBBuOaNREVQb4yNSqyQ3YlD3AzAV6KG51nmBxNzAcu
 rnB3y84IWOsNTJc3nxP9FeGYbg3+7n5Bp3aYWZ+C6gidLC/bkTnAZIJ+Otqa/fXYagUC VQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q63vbgcen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 05:28:36 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33P4dAZJ021378;
        Tue, 25 Apr 2023 05:28:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3q4776s8fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 05:28:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33P5SW0O21234290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 05:28:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D90B20043;
        Tue, 25 Apr 2023 05:28:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F317F20040;
        Tue, 25 Apr 2023 05:28:31 +0000 (GMT)
Received: from localhost (unknown [9.43.8.91])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Apr 2023 05:28:31 +0000 (GMT)
Date:   Tue, 25 Apr 2023 10:58:30 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] selftests/ftrace: Add new test case which checks
 for optimized probes
To:     Akanksha J N <akanksha@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
        shuah@kernel.org
References: <20230418095557.19061-1-akanksha@linux.ibm.com>
        <20230418095557.19061-3-akanksha@linux.ibm.com>
        <20230425091039.9fd523dfdf7be5e800bac4fe@kernel.org>
In-Reply-To: <20230425091039.9fd523dfdf7be5e800bac4fe@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1682400251.pez54ergiy.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y_7jfsOHM_jR4lNPmyvvoiFdhy7vAPho
X-Proofpoint-GUID: Y_7jfsOHM_jR4lNPmyvvoiFdhy7vAPho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Masami Hiramatsu wrote:
> On Tue, 18 Apr 2023 15:25:57 +0530
> Akanksha J N <akanksha@linux.ibm.com> wrote:
>=20
>> Add new test case kprobe_opt_types.tc which enables and checks
>> if each probe has been optimized in order to test potential issues with
>> optimized probes.
>> The '|| continue' is added with the echo statement to ignore errors that
>> are caused by trying to add kprobes to non probeable lines and continue
>> with the test.
>> Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
>> ---
>>  .../ftrace/test.d/kprobe/kprobe_opt_types.tc  | 34 +++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_=
opt_types.tc
>>=20
>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_typ=
es.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
>> new file mode 100644
>> index 000000000000..54e4800b8a13
>> --- /dev/null
>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
>> @@ -0,0 +1,34 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (C) 2023 Akanksha J N, IBM corporation
>> +# description: Register/unregister optimized probe
>> +# requires: kprobe_events
>> +
>> +case `uname -m` in
>> +x86_64)
>> +;;
>> +arm*)
>> +;;
>> +ppc*)
>> +;;
>> +*)
>> +  echo "Please implement other architecture here"
>> +  exit_unsupported
>> +esac
>> +
>> +DEFAULT=3D$(cat /proc/sys/debug/kprobes-optimization)
>> +echo 1 > /proc/sys/debug/kprobes-optimization
>> +for i in `seq 0 255`; do
>> +        echo  "p:testprobe $FUNCTION_FORK+${i}" > kprobe_events || cont=
inue
>> +        echo 1 > events/kprobes/enable || continue
>> +        (echo "forked")
>> +        PROBE_TYPE=3D$(cat /sys/kernel/debug/kprobes/list | grep $FUNCT=
ION_FORK | awk '{print $4}' | awk '{print substr($0,2,length($0)-2)}')
>=20
> I think we can make it simply;
>=20
> PROBE=3D$(grep $FUNCTION_FORK /sys/kernel/debug/kprobes/list)
>=20
>> +        echo 0 > events/kprobes/enable
>> +        echo > kprobe_events
>> +        if [ $PROBE_TYPE =3D "OPTIMIZED" ]; then
>=20
> and
>=20
> if echo $PROBE | grep -q OPTIMIZED; then
>=20
>> +                echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
>> +                exit_pass
>> +        fi
>> +done
>> +echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
>> +echo "Done"
>=20
> Hmm, this test does NOT return any error. It always returns success.

Good catch!

> I understand that optimization may not be possible within 256 bytes
> from the beginning of the function.

Is that true in practice? Looking at x86 and ppc64le, it looks like we=20
will almost always be able to optimize at least one of the instructions=20
within the first 256 bytes of kernel_clone(). That's one of the primary=20
purposes of this test.

Are there valid reasons why we may not be able to optimize instructions?

> In that case, you can return
> "unresolved", and not echoing "Done" but the reason why it is
> unresolved.


- Naveen

