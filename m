Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448985ED171
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 02:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiI1ANA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 20:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiI1AM6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 20:12:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF588E6A27;
        Tue, 27 Sep 2022 17:12:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m3so15218292eda.12;
        Tue, 27 Sep 2022 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1Jtjq3PMPX0CIHFz0zhoXaOuw+IpQxj3g5XM4aru3yY=;
        b=CJLjv+2W5bThdba4CMUjkGbJjCa8qyeiM7hTon9h5lbbCp5SSc+t7rfef+xTs/EqEd
         +5/XhNxQuVqBLReNLGHP7GlAvyIUtQrWicx8nJuAoaOXtB0p/exotrgE8HWhQUteuwXA
         tWuUiXalbllJmNschDifFW2VcmVYrb1SXRe4EstYaey87wYQv5pg01YHu0rdFg74dj3z
         xHi12tkbwqftR7By/qdKjPPrEzgjrW4uQPDVwWdANPgBkRmOJDPOmO8pxHf65ARxry+x
         lwtbjIzDWt73q0drZM8NnH1TP4FV3aLCr5wRI+xhJ8U0ftrPB9XI4Yd0KtBBFX8TBY7i
         gwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1Jtjq3PMPX0CIHFz0zhoXaOuw+IpQxj3g5XM4aru3yY=;
        b=ZLCmruhtpgXnZzbfe+7SKDW1mKLC171/nYc9qn2RMKsTz/DOHowdZB3vanunyD4XmE
         ICUnb5DQj/SixIKYs6Me4oa/mDcP/ENLcLNLtVmXLrBymsn+HTbpNDQ7nyr7t5pUd0oV
         I0BnSEL0TOLJY5VgEyZCvqLsmbr73xm2305UthfjMMH0EXYQ1Q2GcS13Qe2KVjIzE/1S
         mfgXlG8WBC0P/eXAQEWOiHKAmCh3gq4ia2Fu68+oItNWMIeFNR+126OeZdjdZHAMHPw4
         Mtek2vyr6np9J4FbMubs48Aly/PLUUS8oAel/SDh4jmv1n6Q2/6G5UIEN/fFs9h1WJja
         FVgg==
X-Gm-Message-State: ACrzQf1nbLNkqwEoLkmcIvVsLUAOR5tksd3sh8AziPwK4b41/foMvJcQ
        dha3m+pVM7rn7m+KT9RAxmO7dWbUCd4Er9Cp6bo=
X-Google-Smtp-Source: AMsMyM4PdANFhysY3PhaCnw5W75C8FGr9n2Q7cAz3kPK53pNrt876wOv464T5B1TFaSTGjaINDWby6KPgqtmsslNpx4=
X-Received: by 2002:a50:d79a:0:b0:457:d209:c09c with SMTP id
 w26-20020a50d79a000000b00457d209c09cmr3251088edi.14.1664323974164; Tue, 27
 Sep 2022 17:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220906195656.33021-1-flaniel@linux.microsoft.com>
In-Reply-To: <20220906195656.33021-1-flaniel@linux.microsoft.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Sep 2022 17:12:41 -0700
Message-ID: <CAEf4BzaE8HiVsA3fFeHfg4dd2AFWM2Aq+H0_mQN3FfmGQOt8=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Make BPF ring buffer overwritable
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Geliang Tang <geliang.tang@suse.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 6, 2022 at 12:58 PM Francis Laniel
<flaniel@linux.microsoft.com> wrote:
>
> Hi.
>
>
> First, I hope you are fine and the same for your relatives.
>
> Normally, when BPF ring buffer are full, producers cannot write anymore and
> need to wait for consumer to get some data.
> As a consequence, calling bpf_ringbuf_reserve() from eBPF code returns NULL.
>
> This contribution adds a new flag to make BPF ring buffer overwritable.
> Perf ring buffers already implement an option to be overwritable. In order to
> avoid data corruption, the data is written backward, see

No, you are not avoiding data corruption. This patch set doesn't apply
cleanly, so I can't try this locally, but try the following example:

1. Allocate very small ringbuf (4KB).
2. Write BPF program that does multiple reservations within single
run. Enough reservations to overfill entire ringbuf and wrap over. For
each reserved sample fill it completely with garbage.
3. Try to submit all (successful) reservations. My theory is you'll
observe a crash.

Make sure that sample size isn't an exact multiple of ringbuf size so
that you don't have a nice neat overlap.

Look at bpf_ringbuf_restore_from_rec(). Each successful reservation
contains a very delicate and precise offset that allows
bpf_ringbuf_commit() to find the BPF ringbuf map in memory. By
allowing to overwrite active not-yet-submitted reservation you allow
to corrupt this information in the record header. This will make
kernel code to dereference garbage addresses.

This whole backwards approach won't work with BPF ringbuf. It works
with BPF perfbuf only under some non-enforceable assumptions, from
what I understand. We need something else for an overwritable ringbuf.


> commit 9ecda41acb97 ("perf/core: Add ::write_backward attribute to perf event").
> This patch series re-uses the same idea from perf ring buffers but in BPF ring
> buffers.
> So, calling bpf_ringbuf_reserve() on an overwritable BPF ring buffer never
> returns NULL.
> As a consequence, oldest data will be overwritten by the newest so consumer will
> loose data.
>
> Overwritable ring buffers are useful in BPF programs that are permanently
> enabled but rarely read, only on-demand, for example in case of a user request
> to investigate problems. We would like to use this in the Traceloop project [1].
>
> The self test added in this series was tested and validated in a VM:
> you@vm# ./share/linux/tools/testing/selftests/bpf/test_progs -t ringbuf_over
> Can't find bpf_testmod.ko kernel module: -2
> WARNING! Selftests relying on bpf_testmod.ko will be skipped.
> #135     ringbuf_over_writable:OK
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> You can also test the libbpf implementation by using the last patch of this
> series which should be applied to iovisor/bcc:
> you@home$ cd /path/to/iovisor/bcc
> you@home$ git am -3 v2-0005-for-test-purpose-only-Add-toy-to-play-with-BPF-ri.patch
> you@home$ cd /path/to/linux/tools/lib/bpf
> you@home$ make -j$(nproc)
> you@home$ cp libbpf.a /path/to/iovisor/bcc/libbpf-tools/.output
> you@home$ cd /path/to/iovisor/bcc/libbpf-tools/
> you@home$ make -j toy
> # Start your VM and copy toy executable inside it.
> root@vm-amd64:~# ./share/toy &
> [1] 287
> root@vm-amd64:~# for i in {1..16}; do ls > /dev/null; done
> 16
> 15
> 14
> 13
> 12
> 11
> 10
> 9
> root@vm-amd64:~# ls > /dev/null && ls > /dev/null
> 18
> 17
>
> As you can see, the first eight events are overwritten.
>
> If you see any way to improve this contribution, feel free to share.
>
> Changes since:
>  v1:
>   * Made producers write backward like perf ring buffer, so it permits avoiding
>   memory corruption.
>   * Added libbpf implementation to consume all events available.
>   * Added selftest.
>   * Added documentation.
>
> Francis Laniel (5):
>   bpf: Make ring buffer overwritable.
>   selftests: Add BPF overwritable ring buffer self tests.
>   docs/bpf: Add documentation for overwritable ring buffer.
>   libbpf: Add implementation to consume overwritable BPF ring buffer.
>   for test purpose only: Add toy to play with BPF ring.
>
>  ...-only-Add-toy-to-play-with-BPF-ring-.patch | 147 ++++++++++++++++
>  Documentation/bpf/ringbuf.rst                 |  18 +-
>  include/uapi/linux/bpf.h                      |   3 +
>  kernel/bpf/ringbuf.c                          |  43 +++--
>  tools/include/uapi/linux/bpf.h                |   3 +
>  tools/lib/bpf/ringbuf.c                       | 106 ++++++++++++
>  tools/testing/selftests/bpf/Makefile          |   5 +-
>  .../bpf/prog_tests/ringbuf_overwritable.c     | 158 ++++++++++++++++++
>  .../bpf/progs/test_ringbuf_overwritable.c     |  61 +++++++
>  9 files changed, 531 insertions(+), 13 deletions(-)
>  create mode 100644 0001-for-test-purpose-only-Add-toy-to-play-with-BPF-ring-.patch
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/ringbuf_overwritable.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwritable.c
>
>
> Best regards and thank you in advance.
> ---
> [1] https://github.com/kinvolk/traceloop
> Traceloop was presented at LPC 2020 (https://lpc.events/event/7/contributions/667/)
> --
> 2.25.1
>
