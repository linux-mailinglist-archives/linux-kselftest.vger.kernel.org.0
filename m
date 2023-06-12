Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B9272C64B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjFLNqu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 09:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjFLNqp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 09:46:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB61612C;
        Mon, 12 Jun 2023 06:46:41 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CDeVcI001168;
        Mon, 12 Jun 2023 13:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=x8SqpugqvWhELVcIPbpCYTMm5Xh5tqMI1QEXk4MkfrE=;
 b=MUjdFPhRt/kp4SB3uEBeXte0JUdX3wmEvX4w21JXNiS1EN5e8LsBBZREB0B7H4VbRZct
 SW8Rxz38U/cHjCEDmdVfknG4Nwfaob3F2Ca8tBi1JkmqUX8QBOOuUhTk89Z/yYmJyYMA
 1S4QcV8n2N0JC4X8cAB28egnLQk6T9Q5L/BZgf8JCPaqXGbXt4axzh1yzdTJNCusQgBO
 loyFYGZVkYdYxuzCO75i3XpDeYv9l3y71ryaW25wmlodIy4BYuTFWgEzDae3mIvg6KlW
 CT2V8/Xm+YqOl0oQ2qTQrga0vdSDRsYCsyal2tvV+SyCANdQ+9uR7JmaBNeEwzbDHDy1 Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r643u0paf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 13:46:15 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35CDjGRZ016604;
        Mon, 12 Jun 2023 13:46:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r643u0p94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 13:46:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35C5KiQI031654;
        Mon, 12 Jun 2023 13:46:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt51h27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 13:46:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CDkARP6029924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 13:46:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34AC420043;
        Mon, 12 Jun 2023 13:46:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B897320040;
        Mon, 12 Jun 2023 13:46:09 +0000 (GMT)
Received: from [9.155.209.184] (unknown [9.155.209.184])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 13:46:09 +0000 (GMT)
Message-ID: <ef33f004f1f20c7a4cc7c963eea628df7bec0c53.camel@linux.ibm.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add a test for subprogram
 extables
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Krister Johansen <kjlx@templeofstupid.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Date:   Mon, 12 Jun 2023 15:46:09 +0200
In-Reply-To: <CAADnVQKAmbb2mTNem+3wvCSS44mvmydDCjWj-4V9VZd93vgksQ@mail.gmail.com>
References: <cover.1686268304.git.kjlx@templeofstupid.com>
         <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
         <CAADnVQKAmbb2mTNem+3wvCSS44mvmydDCjWj-4V9VZd93vgksQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tPpUquuLNk1qCKHVYy8_bCYMKHFHwaEk
X-Proofpoint-GUID: II0r5JYD2ZkE8AvQBJFKpuoR2P_quAD5
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2023-06-09 at 11:15 -0700, Alexei Starovoitov wrote:
> On Thu, Jun 8, 2023 at 5:11=E2=80=AFPM Krister Johansen
> <kjlx@templeofstupid.com> wrote:
> >=20
> > In certain situations a program with subprograms may have a NULL
> > extable entry.=C2=A0 This should not happen, and when it does, it turns
> > a
> > single trap into multiple.=C2=A0 Add a test case for further debugging
> > and to
> > prevent regressions.=C2=A0 N.b: without any other patches this can panic
> > or
> > oops a kernel.
> >=20
> > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > ---
> > =C2=A0.../bpf/prog_tests/subprogs_extable.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 31 +++++++++++++
> > =C2=A0.../bpf/progs/test_subprogs_extable.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 46
> > +++++++++++++++++++
> > =C2=A02 files changed, 77 insertions(+)
> > =C2=A0create mode 100644
> > tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > =C2=A0create mode 100644
> > tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> >=20
> > diff --git
> > a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > new file mode 100644
> > index 000000000000..2201988274a4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include "test_subprogs_extable.skel.h"
> > +
> > +void test_subprogs_extable(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const int READ_SZ =3D 456;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct test_subprogs_extable *ske=
l;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skel =3D test_subprogs_extable__o=
pen();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ASSERT_OK_PTR(skel, "skel_op=
en"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D test_subprogs_extable__lo=
ad(skel);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ASSERT_OK(err, "skel_load"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto cleanup;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D test_subprogs_extable__at=
tach(skel);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ASSERT_OK(err, "skel_attach"=
))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto cleanup;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* trigger tracepoint */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT_OK(trigger_module_test_rea=
d(READ_SZ),
> > "trigger_read");
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_subprogs_extable__detach(ske=
l);
> > +
> > +cleanup:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_subprogs_extable__destroy(sk=
el);
> > +}
> > diff --git
> > a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > new file mode 100644
> > index 000000000000..c3ff66bf4cbe
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > @@ -0,0 +1,46 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +struct {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __uint(type, BPF_MAP_TYPE_ARRAY);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __uint(max_entries, 8);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __type(key, __u32);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __type(value, __u64);
> > +} test_array SEC(".maps");
> > +
> > +static __u64 test_cb(struct bpf_map *map, __u32 *key, __u64 *val,
> > void *data)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
> > +}
> > +
> > +SEC("fexit/bpf_testmod_return_ptr")
> > +int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(volatile long *)ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(volatile int *)&ret->f_mode;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_for_each_map_elem(&test_array=
, test_cb, NULL, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +SEC("fexit/bpf_testmod_return_ptr")
> > +int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file
> > *ret)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(volatile long *)ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(volatile int *)&ret->f_mode;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_for_each_map_elem(&test_array=
, test_cb, NULL, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +SEC("fexit/bpf_testmod_return_ptr")
> > +int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file
> > *ret)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(volatile long *)ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(volatile int *)&ret->f_mode;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_for_each_map_elem(&test_array=
, test_cb, NULL, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
>=20
> What is the point of attaching 3 the same progs to the same hook?
> One would be enough to test it, no?
>=20
> In other news...
> Looks like this test is triggering a bug on s390.
>=20
> Ilya,
> please take a look:
> https://github.com/kernel-patches/bpf/actions/runs/5216942096/jobs/941640=
4780
>=20
> bpf_prog_78c0d4c618ed2df7_handle_fexit_ret_subprogs3
> is crashing the kernel.
> A bug in extable logic on s390?

I think we also need this:

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17664,6 +17664,7 @@ static int jit_subprogs(struct bpf_verifier_env
*env)
        prog->bpf_func =3D func[0]->bpf_func;
        prog->jited_len =3D func[0]->jited_len;
        prog->aux->extable =3D func[0]->aux->extable;
+       prog->aux->num_exentries =3D func[0]->aux->num_exentries;
        prog->aux->func =3D func;
        prog->aux->func_cnt =3D env->subprog_cnt;
        bpf_prog_jit_attempt_done(prog);

The reason is that s390 JIT doubles the number of extable entries due
to how the hardware works (some exceptions point to the failing insn,
some point to the next one).

With that:

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

for the v4 series.
