Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA83614F2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 17:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKAQ14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKAQ1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 12:27:55 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF511CFC9;
        Tue,  1 Nov 2022 09:27:52 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1optT4-0009B8-27; Tue, 01 Nov 2022 16:46:22 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1optT3-000TRb-I0; Tue, 01 Nov 2022 16:46:21 +0100
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, david.laight@aculab.com, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, rongtao@cestc.cn,
        sdf@google.com, shuah@kernel.org, song@kernel.org, yhs@fb.com
References: <fc8634e8-6efd-9911-cab4-07ad6ba4ad33@iogearbox.net>
 <tencent_630BF3724BC5EA157B341EB1C7604EE83705@qq.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fe0e300f-a857-dc42-f9f8-c524be6b212f@iogearbox.net>
Date:   Tue, 1 Nov 2022 16:46:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <tencent_630BF3724BC5EA157B341EB1C7604EE83705@qq.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26706/Tue Nov  1 08:52:34 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/1/22 3:23 PM, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> move libbpf_strlcpy() to bpf_util.h, and replace strncpy() with
> libbpf_strlcpy(), fix compile warning.
> 
> Compile samples/bpf, warning:
> $ cd samples/bpf
> $ make
> ...
> cgroup_helpers.c: In function ‘__enable_controllers’:
> cgroup_helpers.c:80:17: warning: ‘strncpy’ specified bound 4097 equals destination size [-Wstringop-truncation]
>     80 |                 strncpy(enable, controllers, sizeof(enable));
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Nope, BPF CI fails once again with:

https://github.com/kernel-patches/bpf/actions/runs/3370230622/jobs/5590876906

   [...]
     TEST-OBJ [test_progs-no_alu32] connect_ping.test.o
     TEST-OBJ [test_progs-no_alu32] map_kptr.test.o
   In file included from /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/perf_branches.c:7:
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/libbpf_internal.h:200:20: error: redefinition of 'libbpf_strlcpy'
   static inline void libbpf_strlcpy(char *dst, const char *src, size_t sz)
                      ^
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/bpf_util.h:29:20: note: previous definition is here
   static inline void libbpf_strlcpy(char *dst, const char *src, size_t sz)
                      ^
   1 error generated.
     TEST-OBJ [test_progs-no_alu32] hash_large_key.test.o
   make: *** [Makefile:539: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/no_alu32/perf_branches.test.o] Error 1
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

Please do not send broken stuff that was not even compile tested.

Here's a small howto for running BPF selftests:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/README.rst#n48
