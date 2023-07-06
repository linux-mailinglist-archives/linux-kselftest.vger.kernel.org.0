Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFA67494CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 06:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGFE5v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 00:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGFE5u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 00:57:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F54E70;
        Wed,  5 Jul 2023 21:57:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89e10d356so777415ad.3;
        Wed, 05 Jul 2023 21:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688619468; x=1691211468;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PffpYhO66g6RXIDBBiQYXYb6x5BedqVmxNHpoGpWUD8=;
        b=ioDkucAEMlYCMC8dIMAEqAAkt4Td9vNex+vULu0/6v1jyIuvlkw0e4oMdoUyjRmIRN
         y86Q6bG8KrLKnyVPG4KJ0t6ay6+y8j98BkAyvJewPQBTU94lmJ7D3HnNNc26K1ZYTXoa
         pyF+VVFiMfQjsQXccssAYQ/Hi+IMSNHLcOjo5DoKU/DFZw62gVK8yzCeLGz3WUBwCJCK
         pgSHSBRn80iKQcKSS+3C0ChA32wmFndxHU7WYFZga4xLsKJyKq2bQ26w3KxbwvLWNkgo
         sipSpE2P37xoPzm5QPY34id/48KE5KGwLk6yyAAqzV/FKu2VAHlSn/9P498nxaVti40y
         Qj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688619468; x=1691211468;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PffpYhO66g6RXIDBBiQYXYb6x5BedqVmxNHpoGpWUD8=;
        b=M2plWDOZTf/1azOq50CuugwX4OGTKSTqy04fEV19VNL3ozjMYG5AP8Gh/NhJDAq2c6
         3xqjSQof2dhJKZ4d/Sh8dYT+9QdR2yrGj5C1dCAK8+W28yWCM4/LoKOeQ2s3YmpP8ywZ
         Ag1PZzaeT8BJhei5bUG0YE6ODUCN8Vca7XAVmDr9w0O+mp0kSqdZwPDYiuPXz1xspf0O
         AJ8QcYKA814uOvAKCicDnU63ayiLZySVlRMhMAFIbgYX0w+5RNodKn62GpbtITiTCoB7
         h3Xci6GezTnvCb2cZDrz3WizNxGDNVDZB+645g6qPvrM7UkY9OYWiUIagDHEcM9gdlgH
         i3Pw==
X-Gm-Message-State: ABy/qLbbUSpI5VB5IzTB0gkK3eBdweIryngxx/sVdbgFRKN+UsmCdQQ/
        WEFjmceKeU/hGLsdnqfmE+c=
X-Google-Smtp-Source: APBJJlE9CW5i8KWVJEOk2KFdPpIpsBbe1W0CQHb3nw38eJrECxe4aWhUBjBjdh5KBteUsmV5Ry3iPg==
X-Received: by 2002:a17:903:428d:b0:1b7:c166:f197 with SMTP id ju13-20020a170903428d00b001b7c166f197mr715773plb.29.1688619468557;
        Wed, 05 Jul 2023 21:57:48 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902b28100b001b8903d6773sm350879plr.85.2023.07.05.21.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:57:47 -0700 (PDT)
Date:   Wed, 05 Jul 2023 21:57:46 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>,
        John Fastabend <john.fastabend@gmail.com>, shuah@kernel.org,
        tglx@linutronix.de, x86@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     ast@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
Message-ID: <64a649cab3dba_b20ce2081c@john.notmuch>
In-Reply-To: <2901d37a-6b5a-9076-1423-0db95b4c12d3@linux.intel.com>
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
 <20230703105745.1314475-3-tero.kristo@linux.intel.com>
 <64a3450a2a062_65205208a9@john.notmuch>
 <2901d37a-6b5a-9076-1423-0db95b4c12d3@linux.intel.com>
Subject: Re: [PATCH 2/2] selftests/bpf: Add test for bpf_rdtsc
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tero Kristo wrote:
> 
> On 04/07/2023 01:00, John Fastabend wrote:
> > Tero Kristo wrote:
> >> Add selftest for bpf_rdtsc() which reads the TSC (Time Stamp Counter) on
> >> x86_64 architectures. The test reads the TSC from both userspace and the
> >> BPF program, and verifies the TSC values are in incremental order as
> >> expected. The test is automatically skipped on architectures that do not
> >> support the feature.
> >>
> >> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> >> ---
> >>   .../selftests/bpf/prog_tests/test_rdtsc.c     | 67 +++++++++++++++++++
> >>   .../testing/selftests/bpf/progs/test_rdtsc.c  | 21 ++++++
> >>   2 files changed, 88 insertions(+)
> >>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
> >>   create mode 100644 tools/testing/selftests/bpf/progs/test_rdtsc.c
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c b/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
> >> new file mode 100644
> >> index 000000000000..2b26deb5b35a
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
> >> @@ -0,0 +1,67 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright(c) 2023 Intel Corporation */
> >> +
> >> +#include "test_progs.h"
> >> +#include "test_rdtsc.skel.h"
> >> +
> >> +#ifdef __x86_64__
> >> +
> >> +static inline u64 _rdtsc(void)
> >> +{
> >> +	u32 low, high;
> >> +
> >> +	__asm__ __volatile__("rdtscp" : "=a" (low), "=d" (high));
> > I think its ok but note this could fail if user doesn't have
> > access to rdtscp and iirc that can be restricted?
> 
> It is possible to restrict RDTSC access from userspace by enabling the 
> TSD bit in CR4 register, and it will cause the userspace process to trap 
> with general protection fault.
> 
> However, the usage of RDTSC appears to be built-in to C standard 
> libraries (probably some timer routines) and enabling the CR4 TSD makes 
> the system near unusable. Things like sshd + systemd also start 
> generating the same general protection faults if RDTSC is blocked. Also, 
> attempting to run anything at all with the BPF selftest suite causes the 
> same general protection fault; not only the rdtsc test.
> 
> I tried this with couple of setups, one system running a minimalistic 
> buildroot and another one running a fedora37 installation and the 
> results were similar.

Thanks. Good enough for me.

> 
> -Tero
