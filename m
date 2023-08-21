Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E547822D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 06:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjHUEex (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 00:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjHUEet (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 00:34:49 -0400
Received: from out-54.mta0.migadu.com (out-54.mta0.migadu.com [IPv6:2001:41d0:1004:224b::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C3A9B
        for <linux-kselftest@vger.kernel.org>; Sun, 20 Aug 2023 21:34:48 -0700 (PDT)
Message-ID: <c2f564a3-f942-d275-3ecb-b679aa0810ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692592485; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQ3+8fFgZPBnKHzt/pbHvIk2a6srPidqNvlwyrLGsa0=;
        b=iYEcXNNTWGHp/TS4M1UGtGRa/KMZvi79XLGBInTQ4C3EeglmOSzWImmpy43QjX1FhrdulZ
        IgBCYoOml7Sy7F179Y463RKOj0f2e9TBd9f2eXJ52nN85AstH/wwhf+0flSBd0radljLWr
        xb5PZWfrV/GhR1k5hlfsZKGqPboGUVw=
Date:   Sun, 20 Aug 2023 21:34:37 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v5] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, olsajiri@gmail.com, rongtao@cestc.cn,
        sdf@google.com, shuah@kernel.org, song@kernel.org
References: <817af9ec-0ba3-fab0-6d8a-4529ede337b5@linux.dev>
 <tencent_ADC403037821ABAC8ECB6F15C6D7A3510507@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_ADC403037821ABAC8ECB6F15C6D7A3510507@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/20/23 7:03 PM, Rong Tao wrote:
> Sorry Song, I did not state clear.
> 
> libbpf_ensure_mem() is declared in libbpf_internal.h, we want to use
> libbpf_ensure_mem() in trace_helpers.c, Unforturnately, we could only include
> the headers 'install_headers:' defined in tools/lib/bpf/Makefile, the
> 'install_headers:' target does not include libbpf_internal.h, like:
> 
> 	tools/testing/selftests/bpf/trace_helpers.c:17:10:
> 	fatal error: libbpf_internal.h: No such file or directory
> 	   17 | #include "libbpf_internal.h"
> 	      |          ^~~~~~~~~~~~~~~~~~~
> 
> 	tools/testing/selftests/bpf/trace_helpers.c:17:10:
> 	fatal error: bpf/libbpf_internal.h: No such file or directory
> 	   17 | #include "bpf/libbpf_internal.h"
> 	      |           ^~~~~~~~~~~~~~~~~~~~~~~


It works fine for me. On top of your patch, the following works fine:

diff --git a/tools/testing/selftests/bpf/trace_helpers.c 
b/tools/testing/selftests/bpf/trace_helpers.c
index 0053ba22f0cb..087383c5dc3a 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -14,6 +14,7 @@
  #include <linux/limits.h>
  #include <libelf.h>
  #include <gelf.h>
+#include "bpf/libbpf_internal.h"

  #define TRACEFS_PIPE   "/sys/kernel/tracing/trace_pipe"
  #define DEBUGFS_PIPE   "/sys/kernel/debug/tracing/trace_pipe"

With V=1 when building selftests, the following is the compilation
command line:
clang --target=x86_64-linux-gnu -fintegrated-as -g -O0 -rdynamic -Wall 
-Werror   -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf 
-I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include 
-I/home/yhs/work/bpf-next/include/generated 
-I/home/yhs/work/bpf-next/tools/lib 
-I/home/yhs/work/bpf-next/tools/include 
-I/home/yhs/work/bpf-next/tools/include/uapi 
-I/home/yhs/work/bpf-next/tools/testing/selftests/bpf 
-Wno-unused-command-line-argument  -c trace_helpers.c -lelf -lz -lrt 
-lpthread -o 
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/trace_helpers.o

This include path
   /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
will make including 'bpf/libbpf_internal.h' work.

> 
> How about
> 
> 1. dup-declare libbpf_ensure_mem() in trace_helpers.c
> 2. move libbpf_ensure_mem() declare into libbpf_common.h
> 
> Which one do you like best.
> 
> Best wishes,
> Rong Tao
> 
> 
