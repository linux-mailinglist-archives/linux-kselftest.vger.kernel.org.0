Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A3A614C4E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiKAOMo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAOMn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:12:43 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D51AF2B;
        Tue,  1 Nov 2022 07:12:42 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oprkf-000Ezv-35; Tue, 01 Nov 2022 14:56:25 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oprke-000H9q-I3; Tue, 01 Nov 2022 14:56:24 +0100
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
To:     Rong Tao <rtoax@foxmail.com>, david.laight@aculab.com
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
References: <70ddf02157bc418cbc38230c87a7b228@AcuMS.aculab.com>
 <tencent_ED443B037FA1D72CB4CB38958E57F2D12007@qq.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fc8634e8-6efd-9911-cab4-07ad6ba4ad33@iogearbox.net>
Date:   Tue, 1 Nov 2022 14:56:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <tencent_ED443B037FA1D72CB4CB38958E57F2D12007@qq.com>
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

On 11/1/22 1:21 PM, Rong Tao wrote:
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

BPF CI now throws a new warning after your patch:

https://github.com/kernel-patches/bpf/actions/runs/3369416153/jobs/5589052613

   [...]
   xsk.c:536:2: error: call to undeclared function 'libbpf_strlcpy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           libbpf_strlcpy(ifr.ifr_name, ctx->ifname, IFNAMSIZ);
           ^
   xsk.c:755:2: error: call to undeclared function 'libbpf_strlcpy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           libbpf_strlcpy(ctx->ifname, ifname, IFNAMSIZ);
           ^
   xsk.c:942:2: error: call to undeclared function 'libbpf_strlcpy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           libbpf_strlcpy(ctx->ifname, ifname, IFNAMSIZ);
           ^
   3 errors generated.
   make: *** [Makefile:166: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/xsk.o] Error 1
   make: *** Waiting for unfinished jobs....
