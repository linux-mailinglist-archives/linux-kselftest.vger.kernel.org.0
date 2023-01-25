Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9E967AAB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 08:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjAYHJx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 02:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjAYHJw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 02:09:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AE5260;
        Tue, 24 Jan 2023 23:09:50 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P4PWSj012719;
        Wed, 25 Jan 2023 07:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=dk4L0nxHFgeoextqDDpHvgs+Wvi0a7VUuGjWYKu97xI=;
 b=QbDliG0OgojK9f3uvIfzJgtCvWBtR2K2fAJHFF9iyNKdDWgVfldsiAh7E9C9A5ucq/M0
 dXDTnSEpMQW/lMLXAV5knUUHhFAdBL7X/jOv8K+EZqIzqftpA6JsVWZs0cZjVU/ie+3g
 luOTK0sYT+2FnONBv2PrxGC6/KNViQDZQfvX1yNFiXZvoPI930ZFzH3p5saxe5vF7Y9P
 LjBN4BHFJ+6T/V2083nyRL4EJZ5KIsuBI8SbG+XAyQmwQ8kr68xjHRN4oh1MqxlYbg4t
 JwyuXPvlENbUY+DKh5dqfj/CLSzhvMwP4+4G3AtRTzZQj2V0jYbm8zk3PTCz/+yDla3t +Q== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9hvga4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:09:44 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30OFtTQP015313;
        Wed, 25 Jan 2023 07:09:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6bd58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:09:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30P79dpd50135534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 07:09:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08F6E20043;
        Wed, 25 Jan 2023 07:09:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7280120040;
        Wed, 25 Jan 2023 07:09:38 +0000 (GMT)
Received: from localhost (unknown [9.43.44.248])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 07:09:38 +0000 (GMT)
Date:   Wed, 25 Jan 2023 12:39:36 +0530
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
        <1673856229.a7tekgas75.naveen@linux.ibm.com>
        <20230120085554.ab4dc1b72990a4957c4c88e2@kernel.org>
In-Reply-To: <20230120085554.ab4dc1b72990a4957c4c88e2@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1674629944.vwzovyd4lk.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pf6msvON4-I-YzcNZ0QklmHr5QuubfMT
X-Proofpoint-GUID: pf6msvON4-I-YzcNZ0QklmHr5QuubfMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_02,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=922 priorityscore=1501 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Masami,

Masami Hiramatsu wrote:
>> >=20
>> > Yes, please make it separate, this test case is for checking whether
>> > the ftrace can define/enable/disable multiple kprobe events. Not for
>> > checking kprobe with different types, nor checking interactions among
>> > different types of kprobes.
>> >=20
>> > (BTW, if you want to test optprobe on x86, you can not put the probes
>> >  within the jump instruction (+5 bytes). It will unoptimize existing
>> >  optimized kprobe in that case)
>>=20
>> Ok, I can see why we won't be able to optimize any of the probes on x86=20
>> with this approach. But, we should be able to do so on powerpc and arm,=20
>> the only other architectures supporting OPTPROBES at this time. For x86,=
=20
>> we may have to extend the test to check kprobes/list.
>=20
> Are there any instruction type specific limitation on those arch for
> using optprobe? I guess the 'call' (branch with link register) will not
> able to be optimized because it leaves the trampoline address on the
> stack.

Yes, at least on powerpc, we only optimize ALU instructions and do not=20
optimize load/store instructions, among many others. This is the reason=20
we try to put a probe uptil 256 offset into a function in the proposed=20
test, which will almost certainly catch an instruction that can be=20
optimized.

>=20
>>=20
>> Crucially, I think trying to place a probe at each byte can still=20
>> exercize interactions across KPROBES_ON_FTRACE and normal kprobes, so=20
>> this test is still a good start. In addition, we get to ensure that=20
>> kprobes infrastructure is rejecting placing probes at non-instruction=20
>> boundaries.
>=20
> The interfere between probes can be happen between kprobes and optprobe
> (*only on x86*), but not with KPORBES_ON_FTRACE. The ftrace replaced NOP
> will be handled as one instruction.=20

Yes.

>=20
>> > And do you really need to run "multiple" kprobes at once?
>> > I think what you need is 'kprobe_opt_types.tc'.
>>=20
>> Yes, enabling those probes is a good stress test to ensure we are only=20
>> accepting valid probe locations.
>>=20
>> multiple_kprobe_types.tc ? :)
>=20
> Please don't mixed it with the concept of 'multiple' probe test.
> It is different that
>  - kprobes can put probes on each instruction boundary.
>  - kprobes can allocate and enable multiple probes at the same time.
>=20
> What the multiple_kprobes.tc tests is the latter one.
> (This is the reason why it chooses different functions so as not to
>  interfere with each other.)

Ok, I was coming from the point of view that both tests end up=20
installing "multiple" kprobes, but I do see your point.

How about adding two new tests:
1. The same test as has been proposed in this thread: trying to add a=20
kprobe at every byte within $FUNCTION_FORK upto an offset of 256 bytes.=20
We can probably call it kprobe_insn_boundary.tc
2. A new test to ensure we can add different kprobe types=20
(kprobe_opt_types.tc). This test will need to enable and check if each=20
probe has been optimized or not and needs arch-specific knowledge so=20
that we can take care of x86.

Would that be ok?


Thanks,
Naveen

