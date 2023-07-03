Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1074652C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 23:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGCV4B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 17:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGCV4A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 17:56:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E79E4E;
        Mon,  3 Jul 2023 14:55:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b80b3431d2so24714675ad.1;
        Mon, 03 Jul 2023 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688421359; x=1691013359;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRjuvE88F3EPznFkhmy2UB9WzYR0yxSHLtPMmEjtXPI=;
        b=XEeyPmiTSPpJYBxqjQgWTcMezV028+PTGYq+Sdd94F8Il0cp9yQ//ajy94+zQUdnJ4
         3T9XHu9zk0TIOBWPdC4suWm1m0dH5B/ipXZaYvDe3Kz/fay2s1Z3YVdXT/Sv7oWYunwb
         sQTiLtqdMO/dWP4Vz1GZwBhleeSaBDXMJzVWeQ4OVPT5N96gXQjHyuw+755cxe32W6kG
         JC/gUcOZndX/7AkqgEY2RM4H+bZ7rA0zsPn/o04DPlds12A+NfXpiOnlBObvl0i6DBWy
         IFlsuTZ0DSkxSRrCnm/Hv0E4ehpudjtCV6eeQwAtD0TbcZm3jmV3HeZSR6ioPESxulc8
         GpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688421359; x=1691013359;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gRjuvE88F3EPznFkhmy2UB9WzYR0yxSHLtPMmEjtXPI=;
        b=ghwZnKqmVz7QxCVjxk7VXqViaA5K4mlkVZLi4tnKUs8XioCPcPiMMjwH0ZZhjRL8yk
         SLogq52opTpuVZa/ndk8X3O4VMEVn9bj8+rA4G3ndYij0XfLJ68eNMwslSfxO/5fFao3
         JjeKDon/NZlZTaN49NJrRVesZ64VpfZGO6fjMK1vc+fDpBMfjvQehN67pyPrqcHhnzXr
         msEYkgdKB0fLtb5S2ZAABxfY7Rr7ZZvDPvF9J7CDl1b1c86yKvNKpQoDte9eRUEKSxrA
         nDweRlwpQndHJoqQlFI6ypOeeaUpd/LaEJqFMpz7T4Uzf/5IlfEHRUwWpIgiDHcvLN/4
         5ruw==
X-Gm-Message-State: ABy/qLbNEdQdIL5npXPlvxM088m5jig3eHV9GvLkPMqqL436To/fKRzM
        NpaeopLTmrKsleY2J1owb4c=
X-Google-Smtp-Source: APBJJlHkasVvIRzKsYpQEqN5IGljnJ00ivKw+4iplgD8pnq4LtVlsmAFPrbXhBxhV+PhoeGwehRjpg==
X-Received: by 2002:a17:902:aa8f:b0:1b7:f546:44d7 with SMTP id d15-20020a170902aa8f00b001b7f54644d7mr7776913plr.17.1688421358853;
        Mon, 03 Jul 2023 14:55:58 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001b7ebb6a2d4sm15023805plz.163.2023.07.03.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:55:58 -0700 (PDT)
Date:   Mon, 03 Jul 2023 14:55:57 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>, shuah@kernel.org,
        tglx@linutronix.de, x86@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     ast@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
Message-ID: <64a343ed28ccc_6520520836@john.notmuch>
In-Reply-To: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
Subject: RE: [PATCH 0/2] x86/BPF: Add new BPF helper call bpf_rdtsc
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
> Hello,
> 
> This patch series adds a new x86 arch specific BPF helper, bpf_rdtsc()
> which can be used for reading the hardware time stamp counter (TSC.)
> Currently the same counter is directly accessible from userspace
> (using RDTSC instruction), and kernel space using various rdtsc_*()
> APIs, however eBPF lacks the support.
> 
> The main usage for the TSC counter is for various profiling and timing
> purposes, getting accurate cycle counter values. The counter can be
> currently read from BPF programs by using the existing perf subsystem
> services (bpf_perf_event_read()), however its usage is cumbersome at
> best. Additionally, the perf subsystem provides relative value only
> for the counter, but absolute values are desired by some use cases
> like Wult [1]. The absolute value of TSC can be read with BPF programs
> currently via some kprobe / bpf_core_read() magic (see [2], [3], [4] for
> example), but this relies on accessing kernel internals and is not
> stable API, and is pretty cumbersome. Thus, this patch proposes a new
> arch x86 specific BPF helper to avoid the above issues.
> 
> -Tero
> 
> [1] https://github.com/intel/wult
> [2] https://github.com/intel/wult/blob/c92237c95b898498faf41e6644983102d1fe5156/helpers/wult-tdt-helper/tdt-bpf.c#L102
> [3] https://github.com/intel/wult/blob/c92237c95b898498faf41e6644983102d1fe5156/helpers/wult-tdt-helper/tdt-bpf.c#L133
> [4] https://github.com/intel/wult/blob/c92237c95b898498faf41e6644983102d1fe5156/helpers/wult-tdt-helper/tdt-bpf.c#L488
> 
> 
> 

Makes a lot of sense to me.

Acked-by: John Fastabend <john.fastabend@gmail.com>
