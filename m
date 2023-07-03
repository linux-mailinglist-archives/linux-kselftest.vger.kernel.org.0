Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41D074658B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 00:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGCWAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGCWAp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 18:00:45 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ECD187;
        Mon,  3 Jul 2023 15:00:44 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38c35975545so3834414b6e.1;
        Mon, 03 Jul 2023 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688421644; x=1691013644;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfN37eTUROOnwTliaBcxh7QT0xk1tHGByby5/rveQKI=;
        b=CNeOtC3LUafYyE4A4AvSN/GHSZjIHoRV5RFKPK691UWNweoM7BIR2TvQX/TqeIgBPD
         S19C+Sf9VHEFu/z7j9788jhNFxez+j1RzAE5uLyM6Vkn7vM2o7U3Zx8PcAoeIV6w5LWb
         CPUlJfri9bMEyAVv2u5VoYM+1IKY2xfCOG0CDcYtqdtas1w+9DjH/Jt56igJcTdkmfKo
         w2I3YAZuSnLWai1kfLzMTbFJXTQZywblJRhJJJBGR12UakssOaGnF9uxKiy2OUuXEEhA
         9QSS4Cj3P3QgB5jSvrC5aOVLZ53em5u2sJOoa3DxbuIdEZgUAKbjfhWd8d79oQ9XFUbd
         ak5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688421644; x=1691013644;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KfN37eTUROOnwTliaBcxh7QT0xk1tHGByby5/rveQKI=;
        b=MAhv08d1D/EyGzGrr7+5OzOhQPEmG7KgULOede0leR7E+37fr60IacF8Zrp2okYc2N
         kxMxTLnNHJjW65CGamNdj4fBhLuU7kY44mwssKaow6ahXne4kQWlKKe8/WWwbN9ANqF6
         XuFv0LeJMfDGelqe9c2AOuGX12Jp1QuuiGZDQTJ08kY2g1hblgidTMYZWzTbcnb8sCgK
         GD0EaqBXfd1LCrcpMXtAVkNKqnnNr7SZYUjw2ItGMsFVVJu4Zu+E7XBSAfxAZkHjAvca
         j0wDv9W89W5yT3N8333uJ4ClOBrSihkK4VQE0aGSYOH+PlscRyU8HaVnB2044X2mbPzy
         fFbg==
X-Gm-Message-State: AC+VfDyhvmVGcHivcq7xw2THJ+3NPkFxMQgXi6lf1n9bgNJfGr4ILecW
        avUsNEIc27Ia5PjWyUB2YZihNQPjgTvZSg==
X-Google-Smtp-Source: ACHHUZ4rcMvHTKcJUPN+Dj33PZkYDKJVv2HyXJD//9LdedOwVkOwa8FXCt5iPmyRqUurMHzqrPYjuQ==
X-Received: by 2002:a54:4599:0:b0:3a1:ecdf:5f74 with SMTP id z25-20020a544599000000b003a1ecdf5f74mr11611473oib.43.1688421643686;
        Mon, 03 Jul 2023 15:00:43 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id j10-20020aa78d0a000000b00682936d049fsm1956047pfe.174.2023.07.03.15.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 15:00:43 -0700 (PDT)
Date:   Mon, 03 Jul 2023 15:00:42 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>, shuah@kernel.org,
        tglx@linutronix.de, x86@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     ast@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
Message-ID: <64a3450a2a062_65205208a9@john.notmuch>
In-Reply-To: <20230703105745.1314475-3-tero.kristo@linux.intel.com>
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
 <20230703105745.1314475-3-tero.kristo@linux.intel.com>
Subject: RE: [PATCH 2/2] selftests/bpf: Add test for bpf_rdtsc
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
> Add selftest for bpf_rdtsc() which reads the TSC (Time Stamp Counter) on
> x86_64 architectures. The test reads the TSC from both userspace and the
> BPF program, and verifies the TSC values are in incremental order as
> expected. The test is automatically skipped on architectures that do not
> support the feature.
> 
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  .../selftests/bpf/prog_tests/test_rdtsc.c     | 67 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_rdtsc.c  | 21 ++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_rdtsc.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c b/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
> new file mode 100644
> index 000000000000..2b26deb5b35a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2023 Intel Corporation */
> +
> +#include "test_progs.h"
> +#include "test_rdtsc.skel.h"
> +
> +#ifdef __x86_64__
> +
> +static inline u64 _rdtsc(void)
> +{
> +	u32 low, high;
> +
> +	__asm__ __volatile__("rdtscp" : "=a" (low), "=d" (high));

I think its ok but note this could fail if user doesn't have
access to rdtscp and iirc that can be restricted?

> +	return ((u64)high << 32) | low;
> +}
