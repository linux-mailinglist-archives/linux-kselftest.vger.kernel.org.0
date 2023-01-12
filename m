Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F825667310
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 14:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjALNV2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 08:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjALNV0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 08:21:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574D134D63;
        Thu, 12 Jan 2023 05:21:25 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CCLflV032465;
        Thu, 12 Jan 2023 13:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=K40yMyX1ANOmsef0yTBp2kOq+kQYFQ5LqJLXfoJ/PSg=;
 b=Ng7PsHt84l+iwpe6tPXGDXH1qa10G6vWnpNpQJ0SY7xRHABP1EhaLfHKXmi8zGLXq6Xm
 aeHV33qQN4zJdpogtLO1A/BimSmIjPe4EvkyAXrUq7YK9HDAjIauz/wcF9fd+5aDOu+P
 OopiQuXjcU4ZSlUU2kt7HSRG60obDjoX4NVQrTunItwsIAam6PBYyMcxw9FEgPK7kFtS
 3HWwtJZ5Rodu1DmQFsw2FYh/ihyZZO7rhQmqEAVVYpsSZoySMBys87JbvPAjvoTTYa3m
 RnH3t0boLtMVu2xZnW5KX0l3qCMVeycRZ5vZ7ScyoYkMhfsVPEewM3dSROPKvfOl/5AL jw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2j54s73e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 13:21:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30C3RLE3004503;
        Thu, 12 Jan 2023 13:21:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n1kkytgun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 13:21:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CDLGav43712912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 13:21:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78D1020043;
        Thu, 12 Jan 2023 13:21:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 059CF2004B;
        Thu, 12 Jan 2023 13:21:16 +0000 (GMT)
Received: from localhost (unknown [9.43.40.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 13:21:15 +0000 (GMT)
Date:   Thu, 12 Jan 2023 18:51:14 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: Extend multiple_kprobes.tc to add
 multiple consecutive probes in a function
To:     Akanksha J N <akanksha@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org
References: <20230112095600.37665-1-akanksha@linux.ibm.com>
In-Reply-To: <20230112095600.37665-1-akanksha@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1673529279.3c5f8oes3z.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yEPNKWwEZrt2YvFuhPkrkL6Wgw5aZrLl
X-Proofpoint-ORIG-GUID: yEPNKWwEZrt2YvFuhPkrkL6Wgw5aZrLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=781 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120093
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Akanksha J N wrote:
> Commit 97f88a3d723162 ("powerpc/kprobes: Fix null pointer reference in
> arch_prepare_kprobe()") fixed a recent kernel oops that was caused as
> ftrace-based kprobe does not generate kprobe::ainsn::insn and it gets
> set to NULL.
> Extend multiple kprobes test to add kprobes on first 256 bytes within a
> function, to be able to test potential issues with kprobes on
> successive instructions.
> The '|| true' is added with the echo statement to ignore errors that are
> caused by trying to add kprobes to non probeable lines and continue with
> the test.
>=20
> Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
> ---
>  .../selftests/ftrace/test.d/kprobe/multiple_kprobes.tc        | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks for adding this test!

>=20
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobe=
s.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> index be754f5bcf79..f005c2542baa 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> @@ -25,6 +25,10 @@ if [ $L -ne 256 ]; then
>    exit_fail
>  fi
>=20
> +for i in `seq 0 255`; do
> +  echo p $FUNCTION_FORK+${i} >> kprobe_events || true
> +done
> +
>  cat kprobe_events >> $testlog
>=20
>  echo 1 > events/kprobes/enable

Thinking about this more, I wonder if we should add an explicit fork=20
after enabling the events, similar to kprobe_args.tc:
	( echo "forked" )

That will ensure we hit all the probes we added. With that change:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen
