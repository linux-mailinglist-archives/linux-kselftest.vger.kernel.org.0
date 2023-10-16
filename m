Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64AD7CA6D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjJPLje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPLjd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 07:39:33 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27ED9;
        Mon, 16 Oct 2023 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=bLRjSaTNxASi2vnd9kebAHW0J8Zi0doTPzM3PPWKcUA=; b=hrsHmG9l9+tuguvGe7kXHgcKd+
        KEVcwmsQ9tFrWloNsn3o479BRLEKrf/xOosWmsevId+SurWrXwtaSJzI/q94n+uOG6eKFS/C2K5od
        UWWteRy07F9MoVHskjKqAeeRW2SIkdCDTvYvaHImzPZ4u0iwLKygcxRBZuBllUUMoMDbSLafc5TwU
        I3Y5KlsaKOQGtYQXhcQ0K+Z0rmWfdK2xA60amoej/PqoVgaIal0irfrc4pLvSNsMi58ERW/aBh4y1
        5QYcTT8UyTJ2RmYzNuI6Dafyd7YQD1dAySuZTCQvGSEaHVtEUBj/o0dme11e/+Rw0Hp8lQdxNgTs/
        E+4ySm1A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qsLwI-0007YE-JA; Mon, 16 Oct 2023 13:39:14 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qsLwI-00084x-08; Mon, 16 Oct 2023 13:39:14 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: Use pkg-config to determine ld
 flags
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231015133916.257197-1-akihiko.odaki@daynix.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <062d9a75-caa0-d05d-14db-cd59dafab8b9@iogearbox.net>
Date:   Mon, 16 Oct 2023 13:39:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20231015133916.257197-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27063/Mon Oct 16 10:02:17 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/15/23 3:39 PM, Akihiko Odaki wrote:
> When linking statically, libraries may require other dependencies to be
> included to ld flags. In particular, libelf may require libzstd. Use
> pkg-config to determine such dependencies.

Is this not covered via -lz or is it that the name differs?

Anyway, this change breaks selftest build for BPF CI (see below), could this
either be made optional or detected differently?

https://github.com/kernel-patches/bpf/actions/runs/6524480596/job/17716170021

[...]
   make: pkg-config: Command not found
     CC       bench.o
   make: pkg-config: Command not found
   make: pkg-config: Command not found
     CC       bench_count.o
   make: pkg-config: Command not found
     BINARY   xdp_redirect_multi
     HOSTLD  /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/fixdep-in.o
     LINK    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/fixdep
     CC       veristat.o
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd//include/subcmd/exec-cmd.h
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd/exec-cmd.o
   make: pkg-config: Command not found
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd//include/subcmd/help.h
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd/help.o
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd//include/subcmd/pager.h
   make: pkg-config: Command not found
     BINARY   test_verifier
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd/pager.o
     BINARY   test_tag
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd/parse-options.o
   make: pkg-config: Command not found
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd/run-command.o
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd//include/subcmd/parse-options.h
   make: pkg-config: Command not found
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd//include/subcmd/run-command.h
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd/sigchain.o
     BINARY   flow_dissector_load
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd/subcmd-config.o
   make: pkg-config: Command not found
     BINARY   test_lirc_mode2_user
     INSTALL libsubcmd_headers
     BINARY   xdping
   make: pkg-config: Command not found

>   tools/testing/selftests/bpf/Makefile   | 3 ++-
>   tools/testing/selftests/bpf/README.rst | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index caede9b574cb..833134aa2eda 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
>   include ../../../scripts/Makefile.include
>   
>   CXX ?= $(CROSS_COMPILE)g++
> +PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
>   
>   CURDIR := $(abspath .)
>   TOOLSDIR := $(abspath ../../..)
> @@ -31,7 +32,7 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
>   	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
>   	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>   LDFLAGS += $(SAN_LDFLAGS)
> -LDLIBS += -lelf -lz -lrt -lpthread
> +LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib) -lrt -lpthread
>   
>   ifneq ($(LLVM),)
>   # Silence some warnings when compiled with clang
> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> index cb9b95702ac6..9af79c7a9b58 100644
> --- a/tools/testing/selftests/bpf/README.rst
> +++ b/tools/testing/selftests/bpf/README.rst
> @@ -77,7 +77,7 @@ In case of linker errors when running selftests, try using static linking:
>   
>   .. code-block:: console
>   
> -  $ LDLIBS=-static vmtest.sh
> +  $ LDLIBS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
>   
>   .. note:: Some distros may not support static linking.
>   
> 

