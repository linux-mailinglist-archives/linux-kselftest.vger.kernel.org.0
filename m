Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D01166215
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 17:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgBTQQ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 11:16:26 -0500
Received: from mail.efficios.com ([167.114.26.124]:47186 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTQQ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 11:16:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D613D256811;
        Thu, 20 Feb 2020 11:16:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qE7irgTtY9Be; Thu, 20 Feb 2020 11:16:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E3ACB256810;
        Thu, 20 Feb 2020 11:16:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E3ACB256810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1582215383;
        bh=ve1qzJqPP8JQO3uOepENYiNneIeqiKsiO6UMBcZnahs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=BbrebXmLUrmmcEPVztepRWqyDPkj1/Ko0U0oUMfxd2uHNjFX/G5gqNzuUwDnCbYiE
         UvVdv/ezjgymxe4b5Htgl//PsYr3uL/jVQVX3a+w1iyPZq86D2qBjbl8N0ksZNXfSB
         UC74+kUV10Do7kXE91SbbhQwQZ/zMgTkgntMAEXjHpl+820q8xz8+TS6WXxGPyrMsC
         6vC3mg4Mk1D5UYewIRdDsp63wlaYwJyY0XPJ6h7E4x80zWoek/cjlAQOJRCjC3uZ5d
         ZnHBhT7ZKXbdD94VcF/YhdwqmMtY3ULy7C66UYlKYVf51/NFRkzxFWO5qQJjwGTRyD
         e3G6bIlM0+Omg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BZ8ebMMwK7sP; Thu, 20 Feb 2020 11:16:23 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D58CE2562EF;
        Thu, 20 Feb 2020 11:16:23 -0500 (EST)
Date:   Thu, 20 Feb 2020 11:16:23 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Message-ID: <763647628.2256.1582215383750.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200220113748.15990-1-mpe@ellerman.id.au>
References: <20200220113748.15990-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/rseq: Fix out-of-tree compilation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: selftests/rseq: Fix out-of-tree compilation
Thread-Index: /MnXhITZ60jvWnXx1SK35yo2OOEX/A==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Feb 20, 2020, at 6:37 AM, Michael Ellerman mpe@ellerman.id.au wrote:

> Currently if you build with O=... the rseq tests don't build:
> 
>  $ make O=$PWD/output -C tools/testing/selftests/ TARGETS=rseq
>  make: Entering directory '/linux/tools/testing/selftests'
>  ...
>  make[1]: Entering directory '/linux/tools/testing/selftests/rseq'
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./  -shared
>  -fPIC rseq.c -lpthread -o /linux/output/rseq/librseq.so
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
>  basic_test.c -lpthread -lrseq -o /linux/output/rseq/basic_test
>  /usr/bin/ld: cannot find -lrseq
>  collect2: error: ld returned 1 exit status
> 
> This is because the library search path points to the source
> directory, not the output.
> 
> We can fix it by changing the library search path to $(OUTPUT).

Good catch!

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Shuah, can you pick this up please ?

Thanks,

Mathieu

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> 
> This works in all cases.
> 
> With O= set:
> 
>  $ make O=$PWD/output -C tools/testing/selftests/ TARGETS=rseq
>  ...
>  make[1]: Entering directory '/linux/tools/testing/selftests/rseq'
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/output/rseq
>  -Wl,-rpath=./  basic_test.c -lpthread -lrseq -o /linux/output/rseq/basic_test
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/output/rseq
>  -Wl,-rpath=./  basic_percpu_ops_test.c -lpthread -lrseq -o
>  /linux/output/rseq/basic_percpu_ops_test
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/output/rseq
>  -Wl,-rpath=./  param_test.c -lpthread -lrseq -o /linux/output/rseq/param_test
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/output/rseq
>  -Wl,-rpath=./  -DBENCHMARK param_test.c -lpthread -lrseq -o
>  /linux/output/rseq/param_test_benchmark
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/output/rseq
>  -Wl,-rpath=./  -DRSEQ_COMPARE_TWICE param_test.c -lpthread -lrseq -o
>  /linux/output/rseq/param_test_compare_twice
>  make[1]: Leaving directory '/linux/tools/testing/selftests/rseq'
>  make: Leaving directory '/linux/tools/testing/selftests'
> 
> And also without, in which case the selftest makefiles set OUTPUT to
> the full path of the source directory:
> 
>  $ make -C tools/testing/selftests/ TARGETS=rseq
>  ...
>  make[1]: Entering directory '/linux/tools/testing/selftests/rseq'
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -shared -fPIC rseq.c
>  -lpthread -o /linux/tools/testing/selftests/rseq/librseq.so
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  basic_test.c -lpthread
>  -lrseq -o /linux/tools/testing/selftests/rseq/basic_test
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  basic_percpu_ops_test.c
>  -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/basic_percpu_ops_test
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  param_test.c -lpthread
>  -lrseq -o /linux/tools/testing/selftests/rseq/param_test
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -DBENCHMARK param_test.c
>  -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/param_test_benchmark
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -DRSEQ_COMPARE_TWICE
>  param_test.c -lpthread -lrseq -o
>  /linux/tools/testing/selftests/rseq/param_test_compare_twice
>  make[1]: Leaving directory '/linux/tools/testing/selftests/rseq'
>  make: Leaving directory '/linux/tools/testing/selftests'
> 
> And finally, it also works if you build directly in the rseq
> directory, eg:
> 
>  $ cd tools/testing/selftests/rseq
>  $ make
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -shared -fPIC rseq.c
>  -lpthread -o /linux/tools/testing/selftests/rseq/librseq.so
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  basic_test.c -lpthread
>  -lrseq -o /linux/tools/testing/selftests/rseq/basic_test
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  basic_percpu_ops_test.c
>  -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/basic_percpu_ops_test
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  param_test.c -lpthread
>  -lrseq -o /linux/tools/testing/selftests/rseq/param_test
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -DBENCHMARK param_test.c
>  -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/param_test_benchmark
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/
>  -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -DRSEQ_COMPARE_TWICE
>  param_test.c -lpthread -lrseq -o
>  /linux/tools/testing/selftests/rseq/param_test_compare_twice
> ---
> tools/testing/selftests/rseq/Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rseq/Makefile
> b/tools/testing/selftests/rseq/Makefile
> index d6469535630a..708c1b345245 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -4,7 +4,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> CLANG_FLAGS += -no-integrated-as
> endif
> 
> -CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ \
> +CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L$(OUTPUT)
> -Wl,-rpath=./ \
> 	  $(CLANG_FLAGS)
> LDLIBS += -lpthread
> 
> 
> base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
> --
> 2.21.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
