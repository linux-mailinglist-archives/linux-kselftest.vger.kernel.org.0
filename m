Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6266B918
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 09:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjAPIcY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 03:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjAPIcX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 03:32:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1144B9;
        Mon, 16 Jan 2023 00:32:22 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G5phDE024176;
        Mon, 16 Jan 2023 08:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cNQBmWTp5okDMaJ+iwK67PR7Z6647nKho7OPtuocnEg=;
 b=rmQkgq4FopF4FF9X9XY43KAufTXiSsg6BcS4/VBr/h/xTFJjfI4QjIJ6f2M34zpWok/P
 TCdz5o1B3EpqHq10c5z9LG7JWjk2I0d7YDNsk21zS1+C0er0f6V4wm4nQ/aJsoMBzILn
 43kHBSzzcosoiR/l9wW9vUq+DXU5CNu6y1zCy8H0+4F0dKwTJC8s9UlZ+k0WkCuyDrSx
 CHd00JZ6YWl+LCmm04jCnJtXsOYA/DDWe23kiKtcxMYCmzMAHYC3+16LgAwzf7Bbjvm8
 j+kodc26zEHDYqRQPYAMqIB3xinkxhEFvbLj4nscIy9OA/c94F/kSZTnxQJO7b5wa4ev KA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4fqpt8hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 08:32:11 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30FJjHvE007302;
        Mon, 16 Jan 2023 08:32:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n3m16hhwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 08:32:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30G8W6Ml30278002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 08:32:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 174A520043;
        Mon, 16 Jan 2023 08:32:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD57520040;
        Mon, 16 Jan 2023 08:32:05 +0000 (GMT)
Received: from localhost (unknown [9.124.31.239])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jan 2023 08:32:05 +0000 (GMT)
Date:   Mon, 16 Jan 2023 14:02:04 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: Extend multiple_kprobes.tc to add
 multiple consecutive probes in a function
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Akanksha J N <akanksha@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
        shuah@kernel.org
References: <20230112095600.37665-1-akanksha@linux.ibm.com>
        <1673529279.3c5f8oes3z.naveen@linux.ibm.com>
        <20230113005153.c6ca2f75b9d12627eb63308a@kernel.org>
        <1673601511.tq30r5phea.naveen@linux.ibm.com>
        <20230114002126.a37640f815b74e9e78259a9f@kernel.org>
In-Reply-To: <20230114002126.a37640f815b74e9e78259a9f@kernel.org>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1673856229.a7tekgas75.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JnwrrQiQIEf4CwyE70Xus10rYvdQdGN8
X-Proofpoint-GUID: JnwrrQiQIEf4CwyE70Xus10rYvdQdGN8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_06,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 mlxlogscore=958
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Masami Hiramatsu wrote:
> Hi Naveen,
>=20
> On Fri, 13 Jan 2023 14:59:51 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Masami Hiramatsu wrote:
>> > On Thu, 12 Jan 2023 18:51:14 +0530
>> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> >=20
>> >> Akanksha J N wrote:
>> >> > Commit 97f88a3d723162 ("powerpc/kprobes: Fix null pointer reference=
 in
>> >> > arch_prepare_kprobe()") fixed a recent kernel oops that was caused =
as
>> >> > ftrace-based kprobe does not generate kprobe::ainsn::insn and it ge=
ts
>> >> > set to NULL.
>> >> > Extend multiple kprobes test to add kprobes on first 256 bytes with=
in a
>> >> > function, to be able to test potential issues with kprobes on
>> >> > successive instructions.
>> >=20
>> > What is the purpose of that test? If you intended to add a kprobe even=
ts
>> > with some offset so that it becomes ftrace-based kprobe, it should be
>> > a different test case, because
>>=20
>> This is a follow up to:
>> http://lore.kernel.org/1664530538.ke6dp49pwh.naveen@linux.ibm.com
>>=20
>> The intent is to add consecutive probes covering KPROBES_ON_FTRACE,=20
>> vanilla trap-based kprobes as well as optprobes to ensure all of those=20
>> and their interactions are good.
>=20
> Hmm, that should be implemented for each architecture with specific
> knowledge instead of random offset, so that we can ensure the kprobe
> is on ftrace/optimized or using trap. Also, it should check the
> debugfs/kprobes/list file.

...

>=20
>>=20
>> >=20
>> >  - This is a test case for checking multiple (at least 256) kprobe eve=
nts
>> >   can be defined and enabled.
>> >=20
>> >  - If you want to check the ftrace-based kprobe, it should be near the
>> >    function entry, maybe within 16 bytes or so.
>> >=20
>> >  - Also, you don't need to enable it at once (and should not for this =
case).
>> >=20
>> >> > The '|| true' is added with the echo statement to ignore errors tha=
t are
>> >> > caused by trying to add kprobes to non probeable lines and continue=
 with
>> >> > the test.
>> >=20
>> > Can you add another test case for that? (and send it to the MLs which =
Cc'd
>> > to this mail)
>> > e.g.=20
>> >=20
>> >    for i in `seq 0 16`; do
>> >      echo p:testprobe $FUNCTION_FORK+${i} >> kprobe_events || continue
>> >      echo 1 > events/kprobes/testprobe/enable
>> >      ( echo "forked" )
>> >      echo 0 > events/kprobes/testprobe/enable
>> >      echo > kprobe_events
>> >    done
>>=20
>> The current test to add multiple kprobes within a function also falls=20
>> under the purview of multiple_kprobes.tc, but it can be split into a=20
>> separate multiple_kprobes_func.tc if you think that will be better.
>>=20
>=20
> Yes, please make it separate, this test case is for checking whether
> the ftrace can define/enable/disable multiple kprobe events. Not for
> checking kprobe with different types, nor checking interactions among
> different types of kprobes.
>=20
> (BTW, if you want to test optprobe on x86, you can not put the probes
>  within the jump instruction (+5 bytes). It will unoptimize existing
>  optimized kprobe in that case)

Ok, I can see why we won't be able to optimize any of the probes on x86=20
with this approach. But, we should be able to do so on powerpc and arm,=20
the only other architectures supporting OPTPROBES at this time. For x86,=20
we may have to extend the test to check kprobes/list.

Crucially, I think trying to place a probe at each byte can still=20
exercize interactions across KPROBES_ON_FTRACE and normal kprobes, so=20
this test is still a good start. In addition, we get to ensure that=20
kprobes infrastructure is rejecting placing probes at non-instruction=20
boundaries.

>=20
> And do you really need to run "multiple" kprobes at once?
> I think what you need is 'kprobe_opt_types.tc'.

Yes, enabling those probes is a good stress test to ensure we are only=20
accepting valid probe locations.

multiple_kprobe_types.tc ? :)


Thanks,
Naveen

