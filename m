Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853337CA7E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPMTi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 08:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjJPMTh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 08:19:37 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2998E;
        Mon, 16 Oct 2023 05:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=lDfRRZ9rooLhp2i64X1QjX0M0UaOFPuIcMueyOyPbWc=; b=RQz7U5vhUtWp1YS4tElE5UIbdk
        Ve4kHO5tvGNm7ysaBdvdA0mz853Hhi/kmFHlmGARab9PxDY3QrgUVDe4UWFRNhqbGzoeT/S47uyYc
        DX/pKqvyydpjfjQb1xe2shb6StCFta+ypBUxvILvXn7XtnQpCTDRJn7wiSr8Bw0pk5uKuukfaqPr/
        Of3DY/5f5X8eIV1/4nRjrJDig8XmZdqoogykuM0gRYnYkYQz8KcO7rt6HbvChEG1+25ZQIWyOGXgq
        8JmHjV+mCbA9WJODhOT6Z9YsNym6byRUnjcc9Dj9+wfBAOZMkFnBFVMeUY9lwWz9b2WmlLx4FmltB
        9N8hVG+A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qsMZ7-000C6W-Qf; Mon, 16 Oct 2023 14:19:21 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qsMZ7-000Pqr-7S; Mon, 16 Oct 2023 14:19:21 +0200
Subject: Re: [PATCH v2] selftests/bpf: Use pkg-config to determine ld flags
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
References: <20231016115438.21451-1-akihiko.odaki@daynix.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f2af3626-deb5-2830-9e41-4f6b7537baa6@iogearbox.net>
Date:   Mon, 16 Oct 2023 14:19:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20231016115438.21451-1-akihiko.odaki@daynix.com>
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

On 10/16/23 1:54 PM, Akihiko Odaki wrote:
> When linking statically, libraries may require other dependencies to be
> included to ld flags. In particular, libelf may require libzstd. Use
> pkg-config to determine such dependencies.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.

This still does not work with BPF CI, BPF selftest build fails again :

https://github.com/kernel-patches/bpf/actions/runs/6524480596/job/17716169959 :

[...]
   make: pkg-config: Command not found
     BINARY   xdping
     HOSTLD  /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/resolve_btfids/fixdep-in.o
   /usr/bin/x86_64-linux-gnu-ld: /usr/bin/x86_64-linux-gnu-ld: DWARF error: invalid or unhandled FORM value: 0x25
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o): in function `bpf_object_open':
   libbpf.c:(.text+0x2871): undefined reference to `elf_version'
   /usr/bin/x86_64-linux-gnu-ld: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o): in function `bpf_object__elf_finish':
   libbpf.c:(.text+0x4ccf): undefined reference to `elf_end'
   /usr/bin/x86_64-linux-gnu-ld: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o): in function `elf_find_func_offset_from_archive':
   libbpf.c:(.text+0xb419): undefined reference to `elf_memory'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0xb447): undefined reference to `elf_errmsg'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0xb4e2): undefined reference to `elf_end'
   /usr/bin/x86_64-linux-gnu-ld: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o): in function `bpf_object__elf_init':
   libbpf.c:(.text+0x10b02): undefined reference to `elf_memory'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10bae): undefined reference to `elf_begin'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10bdd): undefined reference to `elf_errmsg'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10c1b): undefined reference to `elf_kind'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10c54): undefined reference to `gelf_getclass'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10c8d): undefined reference to `elf64_getehdr'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10cd1): undefined reference to `elf_errmsg'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10d0f): undefined reference to `elf_getshdrstrndx'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10d38): undefined reference to `elf_errmsg'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10d72): undefined reference to `elf_getscn'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10d7e): undefined reference to `elf_rawdata'
   /usr/bin/x86_64-linux-gnu-ld: libbpf.c:(.text+0x10da8): undefined reference to `elf_errmsg'
   /usr/bin/x86_64-linux-gnu-ld: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o): in function `bpf_object__elf_collect':
   libbpf.c:(.text+0x10f17): undefined reference to `elf_getshdrnum'
