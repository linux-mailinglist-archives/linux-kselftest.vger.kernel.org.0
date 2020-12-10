Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC642D5C09
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 14:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbgLJNhU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 08:37:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38045 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389422AbgLJNhR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 08:37:17 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1knM7X-0005R8-VY
        for linux-kselftest@vger.kernel.org; Thu, 10 Dec 2020 13:36:36 +0000
Received: by mail-io1-f69.google.com with SMTP id a2so3900504iod.13
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 05:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mwzWNqwukiO9666dcy5UFimaTAhAAx9w5jcf7BvZNzs=;
        b=lJoBMWZnCblNJiA7mhT23tenBIjMFV9OssV1p7Fd+nYuvPf4W87czmnRyAaXrBphpm
         rzUpjf/wiramoHkYcccrvdHMZQpY/6OBdqAFIhpuFXRd1jpQyrMT8thVzt3I3f9q4Ja/
         eWrQ8KyWv8WGk38FF5xuyRnxXgtpmmo3QPVosN5RM/+hd4CW1ZQDpWgIKFmM5TfQUOUV
         I3OYSjtYT8vuloWn32j2BRVJzMB6rtI5C1tIT0xTOUfuqAYDc5MKasVeT+QL8nh2Kc/z
         QsmTkVGHwMOTT05NazyNIv0MCa2iInrfYb1lphzYuiWBjANfNbm+zegH6/nAchmQsVkc
         AgxQ==
X-Gm-Message-State: AOAM532QBy47Y/qPV33fR3wfgtptaUdZuQkjehwBTK99xJSVhFj15T5Q
        6WgVR4+vd97w7zBNwdMXii5Qp3hMCTYrTNBnyClbmnQ7Osl1j/iCSv1XHEUgu/s88N+kfGjxARW
        ZsW7ajA0f23/Zky4WVL1edCVkZa0E4TDJzmlx1OwXYns3lg==
X-Received: by 2002:a05:6638:2a5:: with SMTP id d5mr8717991jaq.92.1607607394872;
        Thu, 10 Dec 2020 05:36:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDAlRH9nDs2/sDKF2FW7RjAYQtS5kLIoWftt3jEkBIPJZ2Ls4/PB9s1dnWAzZ7dDe7Fi0g6A==
X-Received: by 2002:a05:6638:2a5:: with SMTP id d5mr8717977jaq.92.1607607394700;
        Thu, 10 Dec 2020 05:36:34 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:5f:df71:1517:60e9])
        by smtp.gmail.com with ESMTPSA id y14sm3240284ilb.66.2020.12.10.05.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 05:36:34 -0800 (PST)
Date:   Thu, 10 Dec 2020 07:36:33 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: BPF selftests build failure in 5.10-rc
Message-ID: <X9IkYa6D9QrjooOd@ubuntu-x1>
References: <X9FOSImMbu0/SV5B@ubuntu-x1>
 <CAEf4BzYAptUF+AxmkVk7BjJWRE6UaLkPowKM+pWbFuOV9Z4GGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYAptUF+AxmkVk7BjJWRE6UaLkPowKM+pWbFuOV9Z4GGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 09, 2020 at 04:15:35PM -0800, Andrii Nakryiko wrote:
> On Wed, Dec 9, 2020 at 2:24 PM Seth Forshee <seth.forshee@canonical.com> wrote:
> >
> > Building the BPF selftests with clang 11, I'm getting the following
> > error:
> >
> >    CLNG-LLC [test_maps] profiler1.o
> >  In file included from progs/profiler1.c:6:
> >  progs/profiler.inc.h:260:17: error: use of unknown builtin '__builtin_preserve_enum_value' [-Wimplicit-function-declaration]
> >                  int cgrp_id = bpf_core_enum_value(enum cgroup_subsys_id___local,
> >                                ^
> >  /home/ubuntu/unstable/tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:179:2: note: expanded from macro 'bpf_core_enum_value'
> >          __builtin_preserve_enum_value(*(typeof(enum_type) *)enum_value, BPF_ENUMVAL_VALUE)
> >          ^
> >  1 error generated.
> >  llc: error: llc: <stdin>:1:1: error: expected top-level entity
> >  BPF obj compilation failed
> 
> Addressed by fb3558127cb6 ("bpf: Fix selftest compilation on clang 11")

Great, thanks!

> 
> >
> > I see that test_core_reloc_enumval.c takes precautions around the use of
> > __builtin_preserve_enum_value as it is currently only available in clang
> > 12 nightlies. Is it possible to do something similar here? Though I see
> > that the use of the builtin is not nearly so neatly localized as it is
> > in test_core_reloc_enumval.c.
> >
> > Thanks,
> > Seth
