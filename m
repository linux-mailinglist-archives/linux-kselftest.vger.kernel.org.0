Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049EE5AF54C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 22:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiIFUE3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 16:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiIFUD7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 16:03:59 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C0FD13E20;
        Tue,  6 Sep 2022 12:59:39 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-72.rev.numericable.fr [85.170.34.72])
        by linux.microsoft.com (Postfix) with ESMTPSA id 75B6B2049BAE;
        Tue,  6 Sep 2022 12:58:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 75B6B2049BAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662494291;
        bh=Lgwyo8Ll4+9QdK81IgZHqZgwpIfKReyUkVrwZ38RZ/g=;
        h=From:To:Cc:Subject:Date:From;
        b=nGUfhT1FwKDLYsJ/h/Ti7q5o0kYXfbMN+89/95xvNzhZ/rtKBNnt3IX/eX+TvuKDt
         31GSY8fFtsRsRLw1O4nL6lTrYFhJKOq8uQqo5l8ERPFEWN4QJFddO7Xsc5xcCB9RS6
         3pAVIUm6K/+SrNUm3X4yNIjGkP7YE5WAq+A4E9eQ=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
Subject: [RFC PATCH v2 0/5] Make BPF ring buffer overwritable
Date:   Tue,  6 Sep 2022 21:56:41 +0200
Message-Id: <20220906195656.33021-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi.


First, I hope you are fine and the same for your relatives.

Normally, when BPF ring buffer are full, producers cannot write anymore and
need to wait for consumer to get some data.
As a consequence, calling bpf_ringbuf_reserve() from eBPF code returns NULL.

This contribution adds a new flag to make BPF ring buffer overwritable.
Perf ring buffers already implement an option to be overwritable. In order to
avoid data corruption, the data is written backward, see
commit 9ecda41acb97 ("perf/core: Add ::write_backward attribute to perf event").
This patch series re-uses the same idea from perf ring buffers but in BPF ring
buffers.
So, calling bpf_ringbuf_reserve() on an overwritable BPF ring buffer never
returns NULL.
As a consequence, oldest data will be overwritten by the newest so consumer will
loose data.

Overwritable ring buffers are useful in BPF programs that are permanently
enabled but rarely read, only on-demand, for example in case of a user request
to investigate problems. We would like to use this in the Traceloop project [1].

The self test added in this series was tested and validated in a VM:
you@vm# ./share/linux/tools/testing/selftests/bpf/test_progs -t ringbuf_over
Can't find bpf_testmod.ko kernel module: -2
WARNING! Selftests relying on bpf_testmod.ko will be skipped.
#135     ringbuf_over_writable:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

You can also test the libbpf implementation by using the last patch of this
series which should be applied to iovisor/bcc:
you@home$ cd /path/to/iovisor/bcc
you@home$ git am -3 v2-0005-for-test-purpose-only-Add-toy-to-play-with-BPF-ri.patch
you@home$ cd /path/to/linux/tools/lib/bpf
you@home$ make -j$(nproc)
you@home$ cp libbpf.a /path/to/iovisor/bcc/libbpf-tools/.output
you@home$ cd /path/to/iovisor/bcc/libbpf-tools/
you@home$ make -j toy
# Start your VM and copy toy executable inside it.
root@vm-amd64:~# ./share/toy &
[1] 287
root@vm-amd64:~# for i in {1..16}; do ls > /dev/null; done
16
15
14
13
12
11
10
9
root@vm-amd64:~# ls > /dev/null && ls > /dev/null
18
17

As you can see, the first eight events are overwritten.

If you see any way to improve this contribution, feel free to share.

Changes since:
 v1:
  * Made producers write backward like perf ring buffer, so it permits avoiding
  memory corruption.
  * Added libbpf implementation to consume all events available.
  * Added selftest.
  * Added documentation.

Francis Laniel (5):
  bpf: Make ring buffer overwritable.
  selftests: Add BPF overwritable ring buffer self tests.
  docs/bpf: Add documentation for overwritable ring buffer.
  libbpf: Add implementation to consume overwritable BPF ring buffer.
  for test purpose only: Add toy to play with BPF ring.

 ...-only-Add-toy-to-play-with-BPF-ring-.patch | 147 ++++++++++++++++
 Documentation/bpf/ringbuf.rst                 |  18 +-
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/ringbuf.c                          |  43 +++--
 tools/include/uapi/linux/bpf.h                |   3 +
 tools/lib/bpf/ringbuf.c                       | 106 ++++++++++++
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../bpf/prog_tests/ringbuf_overwritable.c     | 158 ++++++++++++++++++
 .../bpf/progs/test_ringbuf_overwritable.c     |  61 +++++++
 9 files changed, 531 insertions(+), 13 deletions(-)
 create mode 100644 0001-for-test-purpose-only-Add-toy-to-play-with-BPF-ring-.patch
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ringbuf_overwritable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwritable.c


Best regards and thank you in advance.
---
[1] https://github.com/kinvolk/traceloop
Traceloop was presented at LPC 2020 (https://lpc.events/event/7/contributions/667/)
--
2.25.1

