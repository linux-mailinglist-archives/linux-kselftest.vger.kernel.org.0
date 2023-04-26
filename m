Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D856EF301
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbjDZLCR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240298AbjDZLCD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 07:02:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6791646B0;
        Wed, 26 Apr 2023 04:02:02 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QAS7vm029033;
        Wed, 26 Apr 2023 11:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=Cj5dmTnSPTrZAX4b3OtVEk8PfXVs6RQPPe+ehz2mU/g=;
 b=da2Mm4AgypG8nkTeVa6E0nW1q7QdfNVqk3mjwHcCVV7RGgF1DQpkg699eFIHkU4qKuJe
 qhbI5JkZk18S+79lBHdbHU0V5nELtqCqvcXi2LjGJU/LCpA1lmcevSrQ3bcjmeDsVIz9
 6PgdqFNNmkuYARDJm4W44hejSFYFUY5+0yoQPXVVNsyF3EbilF4ED8tjTx052KLDcM9n
 Rf0NVXYrUM7gFaZfzDEBtMkvAxatZPVwtQwObPAbqSpHb5Sm+xHtDjBIVopvYDVCGlYk
 hpXYq4U8b19BGsuGV6rrkVnyD9ZmiEkPpRV4ehBd/XLvM+ofG3i5p1AgafqgS8N6mkN/ Sg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7239949b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 11:01:54 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33PMaXEX020522;
        Wed, 26 Apr 2023 11:01:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3q477729x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 11:01:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QB1nU34784846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 11:01:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF3A720043;
        Wed, 26 Apr 2023 11:01:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61CA620040;
        Wed, 26 Apr 2023 11:01:48 +0000 (GMT)
Received: from localhost (unknown [9.43.0.247])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 11:01:48 +0000 (GMT)
Date:   Wed, 26 Apr 2023 16:31:46 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] selftests/ftrace: Add new test case which checks
 for optimized probes
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Akanksha J N <akanksha@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
        shuah@kernel.org
References: <20230418095557.19061-1-akanksha@linux.ibm.com>
        <20230418095557.19061-3-akanksha@linux.ibm.com>
        <20230425091039.9fd523dfdf7be5e800bac4fe@kernel.org>
        <1682400251.pez54ergiy.naveen@linux.ibm.com>
        <20230425234125.51455711c4388481c13be5ad@kernel.org>
In-Reply-To: <20230425234125.51455711c4388481c13be5ad@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1682506809.uus6y0ir3i.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2Bss5NlDYwGOPQ0U9MGooBNKyXxErO6n
X-Proofpoint-GUID: 2Bss5NlDYwGOPQ0U9MGooBNKyXxErO6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_04,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=891 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Masami Hiramatsu wrote:
> On Tue, 25 Apr 2023 10:58:30 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.ibm.com> wrote:
>=20
>> Masami Hiramatsu wrote:
>> > On Tue, 18 Apr 2023 15:25:57 +0530
>> > Akanksha J N <akanksha@linux.ibm.com> wrote:
>> >=20
>> >> Add new test case kprobe_opt_types.tc which enables and checks
>> >> if each probe has been optimized in order to test potential issues wi=
th
>> >> optimized probes.
>> >> The '|| continue' is added with the echo statement to ignore errors t=
hat
>> >> are caused by trying to add kprobes to non probeable lines and contin=
ue
>> >> with the test.
>> >> Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
>> >> ---
>> >>  .../ftrace/test.d/kprobe/kprobe_opt_types.tc  | 34 +++++++++++++++++=
++
>> >>  1 file changed, 34 insertions(+)
>> >>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kpro=
be_opt_types.tc
>> >>=20
>> >> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_=
types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
>> >> new file mode 100644
>> >> index 000000000000..54e4800b8a13
>> >> --- /dev/null
>> >> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.t=
c
>> >> @@ -0,0 +1,34 @@
>> >> +#!/bin/sh
>> >> +# SPDX-License-Identifier: GPL-2.0-or-later
>> >> +# Copyright (C) 2023 Akanksha J N, IBM corporation
>> >> +# description: Register/unregister optimized probe
>> >> +# requires: kprobe_events
>> >> +
>> >> +case `uname -m` in
>> >> +x86_64)
>> >> +;;
>> >> +arm*)
>> >> +;;
>> >> +ppc*)
>> >> +;;
>> >> +*)
>> >> +  echo "Please implement other architecture here"
>> >> +  exit_unsupported
>> >> +esac
>> >> +
>> >> +DEFAULT=3D$(cat /proc/sys/debug/kprobes-optimization)
>> >> +echo 1 > /proc/sys/debug/kprobes-optimization
>> >> +for i in `seq 0 255`; do
>> >> +        echo  "p:testprobe $FUNCTION_FORK+${i}" > kprobe_events || c=
ontinue
>> >> +        echo 1 > events/kprobes/enable || continue
>> >> +        (echo "forked")
>> >> +        PROBE_TYPE=3D$(cat /sys/kernel/debug/kprobes/list | grep $FU=
NCTION_FORK | awk '{print $4}' | awk '{print substr($0,2,length($0)-2)}')
>> >=20
>> > I think we can make it simply;
>> >=20
>> > PROBE=3D$(grep $FUNCTION_FORK /sys/kernel/debug/kprobes/list)
>> >=20
>> >> +        echo 0 > events/kprobes/enable
>> >> +        echo > kprobe_events
>> >> +        if [ $PROBE_TYPE =3D "OPTIMIZED" ]; then
>> >=20
>> > and
>> >=20
>> > if echo $PROBE | grep -q OPTIMIZED; then
>> >=20
>> >> +                echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimizat=
ion
>> >> +                exit_pass
>> >> +        fi
>> >> +done
>> >> +echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
>> >> +echo "Done"
>> >=20
>> > Hmm, this test does NOT return any error. It always returns success.
>>=20
>> Good catch!
>>=20
>> > I understand that optimization may not be possible within 256 bytes
>> > from the beginning of the function.
>>=20
>> Is that true in practice? Looking at x86 and ppc64le, it looks like we=20
>> will almost always be able to optimize at least one of the instructions=20
>> within the first 256 bytes of kernel_clone(). That's one of the primary=20
>> purposes of this test.
>=20
> Yeah, usually it should not happen. But since we don't disassemble it,
> we can not ensure that. So this depends on the compiler at last.

Ok.

>=20
>>=20
>> Are there valid reasons why we may not be able to optimize instructions?
>=20
> For example, if the compiler starts inserting some checker instruction
> on each instruction boundary for security, it may prevent optimizing
> kprobes. Usually it should not happen (because it bloat up the kernel siz=
e)
> but we cannot deny the possibility of such new feature as an option
> in the future.
>=20
>>=20
>> > In that case, you can return
>> > "unresolved", and not echoing "Done" but the reason why it is
>> > unresolved.
>=20
> Even in that case, it can notify such case as "unresolved", then we
> can notice it. (something like WARN_ON)

Sure, exiting as "Unresolved" should help point out a potential issue=20
with optimizing probes, rather than labeling this as a failure.


Thanks,
Naveen

