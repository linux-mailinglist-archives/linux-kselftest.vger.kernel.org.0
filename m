Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0F31952F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Mar 2020 09:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgC0Idw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Mar 2020 04:33:52 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33094 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0Idw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Mar 2020 04:33:52 -0400
Received: by mail-qv1-f68.google.com with SMTP id p19so4501669qve.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Mar 2020 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAYVGJNIimAyG00gFMc1jxfAVQANq/okPzu47LrIvdk=;
        b=aSLLT2aiCiyT3qNnTz/nl0SvyNz3QnnYJ8suTwEx3GnNhhp4vsumG51eT8w9cgpho2
         7hqJznfoLhTQHiLfhU9I3htfbM5E02qcqCEFRZLZOiDtumaL/T/awkMTdkC4CInsbsNf
         GQrYJfVue/nZTypSbkcATS84xvPV3RDaFcn+UKq/qg3BQd+PntbpfZgKy1J2OROdbl9y
         jyo1Q4g/q/ovSZbk6vQGfDzocimrFE/BMEQajmgzCfz9NLCJIlgGNgq5yJGtSLqq7zFo
         dkVBPMpoMEO1ol1OL56cHlqqDPLz97XCpxOKkbbwSj7OG1ATDe7T4wVSeKbbN6Rn0+rn
         ADYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAYVGJNIimAyG00gFMc1jxfAVQANq/okPzu47LrIvdk=;
        b=VnDfYTP9QL+coGVwkToP31Pq/foQNbJYY/SQ4JEmalaED471LXs6U3Xrh9eL9NXirr
         RLJdA/3K4geqTZkkRWLKh6plKr7KUjuRcUQ+OAJ8E28LWKtY+UsRk2GSv3Yau3FvmzwZ
         eb3qDRmuGasvm3s5pIWqbtjRsoPP0jKJOcPC3zA2wu9dSjCpnjTK4um6owacbFYJtjPe
         Sj8GcKbJUGHz4KGzsFiX+e9/xIc4ONSI5mzX5Umk/F54VkjR+aJF13evySSlqHbyHVHE
         85N8PVHXlUumzQZWu35lekRV5KUsEN5aTR8dooZYRc+7UJ+aC+rBa+FjdEkDCVsvGzmj
         HLWQ==
X-Gm-Message-State: ANhLgQ1Zt9RIaCVaw3IX47tLDMXbhM3q8Vfoh2O+cUM5OaU6TWcuVoFn
        gnPiAXdWrD5udPa7vS32DZOXYDWxQZ+mIkKM5Pfw4g==
X-Google-Smtp-Source: ADFU+vvE52CTVRilfTa8ea9ItaixmNf/QhWnMRWAXsNH420m4FxufAIGwjr2bNvFMvlmlHHao5HjBqH7Yg39QgQKITg=
X-Received: by 2002:ad4:5429:: with SMTP id g9mr12159726qvt.134.1585298031096;
 Fri, 27 Mar 2020 01:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-e1457171-db30-49be-9e98-298f4d1453ed@palmerdabbelt-glaptop1> <490218026.13345.1585239426829.JavaMail.zimbra@efficios.com>
In-Reply-To: <490218026.13345.1585239426829.JavaMail.zimbra@efficios.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Fri, 27 Mar 2020 16:33:40 +0800
Message-ID: <CABvJ_xiGzFY6mUAx7xZDUuk=bUWt3SDsDyzFFODmtuXA28NQzg@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] rseq/selftests: Add support for riscv
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 27, 2020 at 12:17 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Mar 26, 2020, at 11:49 AM, Palmer Dabbelt palmer@dabbelt.com wrote:
>
> > On Sun, 08 Mar 2020 22:59:52 PDT (-0700), vincent.chen@sifive.com wrote:
> >> Add support for risc-v in the rseq selftests, which covers both
> >> 64-bit and 32-bit ISA with little endian mode.
> >>
> >> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> >> ---
> >>  tools/testing/selftests/rseq/param_test.c |  23 ++
> >>  tools/testing/selftests/rseq/rseq-riscv.h | 622 ++++++++++++++++++++++++++++++
> >>  tools/testing/selftests/rseq/rseq.h       |   2 +
> >>  3 files changed, 647 insertions(+)
> >>  create mode 100644 tools/testing/selftests/rseq/rseq-riscv.h
> >
> > There are a ton of checkpatch errors in here.
>
> Is it just my mail client or the main issue is:
>
> ERROR: DOS line endings
>
> ?
I am not sure, but I did not run into this error in my environment.

>
> As far as other issues are concerned, I know there are a few checkpatch
> false-positives that trigger for my rseq-{$ARCH}.h header, from which rseq-riscv.h
> is derived, because it has issues with extensive use of inline assembly.
>
> Thanks,
>
> Mathieu
>
Thank Mathieu for your explanation.

The errors reported by checkpatch.pl can be categorized into two
cases. The first one is "need consistent spacing around %". such as
ERROR: need consistent spacing around '%' (ctx:WxV)
#628: FILE: tools/testing/selftests/rseq/rseq-riscv.h:572:
+       RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
where RSEQ_ASM_DEFINE_EXIT_POINT is defined as below
#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip) \
    ".pushsection __rseq_exit_point_array, \"aw\"\n"        \
    ".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n"  \
    ".popsection\n"

These errors were mainly found in the rseq-riscv.h. As Mathieu
mentioned, the RSEQ_ASM_DEFINE_EXIT_POINT macro is used in the inline
assembly, which the second argument %l[error2] indicates the error2 is
a label and it locates outside of the inline assembly. To obey the
syntax, I cannot add a space after % to fix this bug.

The second kind of error is "Macros with complex values should be
enclosed in parentheses" such as
ERROR: Macros with complex values should be enclosed in parentheses
#27: FILE: tools/testing/selftests/rseq/param_test.c:210:
+#define RSEQ_INJECT_INPUT \
+       , [loop_cnt_1]"m"(loop_cnt[1]) \
+       , [loop_cnt_2]"m"(loop_cnt[2]) \
+       , [loop_cnt_3]"m"(loop_cnt[3]) \
+       , [loop_cnt_4]"m"(loop_cnt[4]) \
+       , [loop_cnt_5]"m"(loop_cnt[5]) \
+       , [loop_cnt_6]"m"(loop_cnt[6])
In this case, it was a input operand list of inline assembly, so I
could not add parentheses to enclose them. Except for these two kinds
of error, there are two erros could be solved by adding parentheses. I
also checked it and I think it would be safe. So, I mimic the
implementations of other architecture without using parenthese. If
needed, I think can add the parenthese to solve these two errors.
Thanks
