Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5EB40271F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Sep 2021 12:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhIGK2U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Sep 2021 06:28:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232704AbhIGK2T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Sep 2021 06:28:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187A3m2L185757;
        Tue, 7 Sep 2021 06:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hYpyRO2QO5ja5Cllzf8va+62OtNtrJ0wjhk/TKUrqBU=;
 b=lqljPIH9KkHLCT5Gy9MA1vnTJpL77bCWCQMx6vCmsf6B9Zk2GP3CAD2sfsVFVssDJz9M
 fFXgGV2micqcmDP/3sFKttO6SYNQkIDnWmAsBXdOF9RUKeXMf4v7sCKgcEW3IkoU3uW2
 IcI88dFyGHRbBX0jOnxMvryELM2RfSqs1FX9Hvc/Axe3MemXMVm2vg5xoc/i52Uhuiwa
 SgN/CJLnKwG+KyAfwSCs168JlmIbw7dmUai13Zj1+BYDCb94tlkwic0YdhOENeA0aFYW
 uE9hIQ08mBAJs6rpr9CuyuATEN0EUv7yOSjzHrqS8Zpd8BBQIJlzFVO2yG6w4hvpXoWP 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ax46mkead-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 06:26:57 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 187AOmS5107878;
        Tue, 7 Sep 2021 06:26:57 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ax46mke9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 06:26:57 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 187AEAd8029636;
        Tue, 7 Sep 2021 10:26:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3av02jcp1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 10:26:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 187AMaxK58458602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 10:22:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03CBB11C04C;
        Tue,  7 Sep 2021 10:26:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A7A711C052;
        Tue,  7 Sep 2021 10:26:51 +0000 (GMT)
Received: from sig-9-145-45-184.uk.ibm.com (unknown [9.145.45.184])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Sep 2021 10:26:51 +0000 (GMT)
Message-ID: <bdfabd343bdec7e27ff92bc0145d813011227f8f.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix build of task_pt_regs
 test for arm64
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 07 Sep 2021 12:26:51 +0200
In-Reply-To: <20210906163635.302307-1-jean-philippe@linaro.org>
References: <20210906163635.302307-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NdwkWpoL10Iv5cFaVpCDIFWyiMRxnxyd
X-Proofpoint-ORIG-GUID: Xelaojuf83pH6u9f-0x7i0Bnu_kwGOQ0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_03:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109070067
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2021-09-06 at 17:36 +0100, Jean-Philippe Brucker wrote:
> struct pt_regs is not exported to userspace on all archs. arm64 and
> s390
> export "user_pt_regs" instead, which causes build failure at the
> moment:
> 
>   progs/test_task_pt_regs.c:8:16: error: variable has incomplete type
> 'struct pt_regs'
>   struct pt_regs current_regs = {};
> 
> Instead of using pt_regs from ptrace.h, use the larger kernel struct
> from vmlinux.h directly. Since the test runner task_pt_regs.c does not
> have access to the kernel struct definition, copy it into a char array.
> 
> Fixes: 576d47bb1a92 ("bpf: selftests: Add bpf_task_pt_regs() selftest")
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2: Work on struct pt_regs from vmlinux.h
> v1:
> https://lore.kernel.org/bpf/20210902090925.2010528-1-jean-philippe@linaro.org/
> ---
>  .../selftests/bpf/prog_tests/task_pt_regs.c   |  1 -
>  .../selftests/bpf/progs/test_task_pt_regs.c   | 19 +++++++++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> index 53f0e0fa1a53..37c20b5ffa70 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #define _GNU_SOURCE
>  #include <test_progs.h>
> -#include <linux/ptrace.h>
>  #include "test_task_pt_regs.skel.h"
>  
>  void test_task_pt_regs(void)
> diff --git a/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
> b/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
> index 6c059f1cfa1b..e6cb09259408 100644
> --- a/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
> +++ b/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
> @@ -1,12 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <linux/ptrace.h>
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  
> -struct pt_regs current_regs = {};
> -struct pt_regs ctx_regs = {};
> +#define PT_REGS_SIZE sizeof(struct pt_regs)
> +
> +/*
> + * The kernel struct pt_regs isn't exported in its entirety to
> userspace.
> + * Pass it as an array to task_pt_regs.c
> + */
> +char current_regs[PT_REGS_SIZE] = {};
> +char ctx_regs[PT_REGS_SIZE] = {};
>  int uprobe_res = 0;
>  
>  SEC("uprobe/trigger_func")
> @@ -17,8 +22,10 @@ int handle_uprobe(struct pt_regs *ctx)
>  
>         current = bpf_get_current_task_btf();
>         regs = (struct pt_regs *) bpf_task_pt_regs(current);
> -       __builtin_memcpy(&current_regs, regs, sizeof(*regs));
> -       __builtin_memcpy(&ctx_regs, ctx, sizeof(*ctx));
> +       if (bpf_probe_read_kernel(current_regs, PT_REGS_SIZE, regs))
> +               return 0;
> +       if (bpf_probe_read_kernel(ctx_regs, PT_REGS_SIZE, ctx))
> +               return 0;
>  
>         /* Prove that uprobe was run */
>         uprobe_res = 1;

I've tested this patch on s390 and it does indeed fix the build issue.
Thanks!

Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

