Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D019D66931B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jan 2023 10:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbjAMJk7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Jan 2023 04:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbjAMJkW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Jan 2023 04:40:22 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4517DE10;
        Fri, 13 Jan 2023 01:30:11 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D9JtIP022415;
        Fri, 13 Jan 2023 09:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WZTvblmpY68TQjitm8U4NNK91LqEDuZldw28DW+QwOc=;
 b=EtG8i/f8k+8jBzuKi7OufnqvPV+suXX+eplGVu4PJDidlwhbGnXAuw31vbvm+X64j/CG
 GcHCs7lZBhoHEW7OaivXGfVqgAfWFe27t9+j6nuuDzVdo0QsfQTJRaEdJEv1PqJV4tZE
 B/069rndBP4yl4uHTzIt5Y7Ifn6tZb72AGdfzKjdC1jZRRsg5gdIEhe0BimsJv8scyXk
 xsyj+vEJ0rpdzaAkMAbqNW5A9LCoPhsQCuK4JaLx/rIzIDJD14xyhXIQpSJJYjnuClVV
 7YdAdH4G7vHCbawLVx6XxtySFXGzCTy6gysNyLrAbguqhIWVexL7VPcpPL2PmAk8qo/H 2g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n34jw06b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 09:29:58 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30D8YEFg022429;
        Fri, 13 Jan 2023 09:29:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n1k5uaqgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 09:29:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30D9Tsfd38863168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 09:29:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4EE620043;
        Fri, 13 Jan 2023 09:29:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 234F020040;
        Fri, 13 Jan 2023 09:29:53 +0000 (GMT)
Received: from localhost (unknown [9.43.72.151])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jan 2023 09:29:53 +0000 (GMT)
Date:   Fri, 13 Jan 2023 14:59:51 +0530
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
In-Reply-To: <20230113005153.c6ca2f75b9d12627eb63308a@kernel.org>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1673601511.tq30r5phea.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TZwW9EIXUVaSyJHyMDBIzyEdXqpHOqc4
X-Proofpoint-ORIG-GUID: TZwW9EIXUVaSyJHyMDBIzyEdXqpHOqc4
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_04,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Masami Hiramatsu wrote:
> On Thu, 12 Jan 2023 18:51:14 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Akanksha J N wrote:
>> > Commit 97f88a3d723162 ("powerpc/kprobes: Fix null pointer reference in
>> > arch_prepare_kprobe()") fixed a recent kernel oops that was caused as
>> > ftrace-based kprobe does not generate kprobe::ainsn::insn and it gets
>> > set to NULL.
>> > Extend multiple kprobes test to add kprobes on first 256 bytes within a
>> > function, to be able to test potential issues with kprobes on
>> > successive instructions.
>=20
> What is the purpose of that test? If you intended to add a kprobe events
> with some offset so that it becomes ftrace-based kprobe, it should be
> a different test case, because

This is a follow up to:
http://lore.kernel.org/1664530538.ke6dp49pwh.naveen@linux.ibm.com

The intent is to add consecutive probes covering KPROBES_ON_FTRACE,=20
vanilla trap-based kprobes as well as optprobes to ensure all of those=20
and their interactions are good.

>=20
>  - This is a test case for checking multiple (at least 256) kprobe events
>   can be defined and enabled.
>=20
>  - If you want to check the ftrace-based kprobe, it should be near the
>    function entry, maybe within 16 bytes or so.
>=20
>  - Also, you don't need to enable it at once (and should not for this cas=
e).
>=20
>> > The '|| true' is added with the echo statement to ignore errors that a=
re
>> > caused by trying to add kprobes to non probeable lines and continue wi=
th
>> > the test.
>=20
> Can you add another test case for that? (and send it to the MLs which Cc'd
> to this mail)
> e.g.=20
>=20
>    for i in `seq 0 16`; do
>      echo p:testprobe $FUNCTION_FORK+${i} >> kprobe_events || continue
>      echo 1 > events/kprobes/testprobe/enable
>      ( echo "forked" )
>      echo 0 > events/kprobes/testprobe/enable
>      echo > kprobe_events
>    done

The current test to add multiple kprobes within a function also falls=20
under the purview of multiple_kprobes.tc, but it can be split into a=20
separate multiple_kprobes_func.tc if you think that will be better.

>=20
>=20
> BTW, after we introduce the fprobe event (https://lore.kernel.org/linux-t=
race-kernel/166792255429.919356.14116090269057513181.stgit@devnote3/) that =
test case may be
> update to check fprobe events.

Indeed, I suppose that can be a separate test.


Thanks,
Naveen

>=20
> Thank you,
>=20
>> >=20
>> > Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
>> > ---
>> >  .../selftests/ftrace/test.d/kprobe/multiple_kprobes.tc        | 4 ++++
>> >  1 file changed, 4 insertions(+)
>>=20
>> Thanks for adding this test!
>>=20
>> >=20
>> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kpr=
obes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
>> > index be754f5bcf79..f005c2542baa 100644
>> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
>> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
>> > @@ -25,6 +25,10 @@ if [ $L -ne 256 ]; then
>> >    exit_fail
>> >  fi
>> >=20
>> > +for i in `seq 0 255`; do
>> > +  echo p $FUNCTION_FORK+${i} >> kprobe_events || true
>> > +done
>> > +
>> >  cat kprobe_events >> $testlog
>> >=20
>> >  echo 1 > events/kprobes/enable
>>=20
>> Thinking about this more, I wonder if we should add an explicit fork=20
>> after enabling the events, similar to kprobe_args.tc:
>> 	( echo "forked" )
>>=20
>> That will ensure we hit all the probes we added. With that change:
>> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>=20
>>=20
>> - Naveen
>=20
>=20
> --=20
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
