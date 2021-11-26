Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B2F45F636
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 22:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241936AbhKZVUz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 16:20:55 -0500
Received: from www62.your-server.de ([213.133.104.62]:34098 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbhKZVSz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 16:18:55 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mqiZC-0000Wj-Dz; Fri, 26 Nov 2021 22:15:34 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mqiZC-000SZt-2A; Fri, 26 Nov 2021 22:15:34 +0100
Subject: Re: [PATCH bpf-next 0/6] tools/bpf: Enable cross-building with clang
To:     Quentin Monnet <quentin@isovalent.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shuah Khan <shuah@kernel.org>, nathan@kernel.org,
        ndesaulniers@google.com, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, llvm@lists.linux.dev
References: <20211122192019.1277299-1-jean-philippe@linaro.org>
 <CACdoK4JWJRH0VuStA2N+xziTsC5d_ewuWpQEO2aHhVbsWuAq0g@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2fc51beb-cf28-2896-8377-2f2442b4712b@iogearbox.net>
Date:   Fri, 26 Nov 2021 22:15:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACdoK4JWJRH0VuStA2N+xziTsC5d_ewuWpQEO2aHhVbsWuAq0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26365/Fri Nov 26 10:23:49 2021)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/26/21 9:36 PM, Quentin Monnet wrote:
> On Mon, 22 Nov 2021 at 19:23, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
>>
>> Add support for cross-building BPF tools and selftests with clang, by
>> passing LLVM=1 or CC=clang to make, as well as CROSS_COMPILE. A single
>> clang toolchain can generate binaries for multiple architectures, so
>> instead of having prefixes such as aarch64-linux-gnu-gcc, clang uses the
>> -target parameter: `clang -target aarch64-linux-gnu'.
>>
>> Patch 1 adds the parameter in Makefile.include so tools can easily
>> support this. Patch 2 prepares for the libbpf change from patch 3 (keep
>> building resolve_btfids's libbpf in the host arch, when cross-building
>> the kernel with clang). Patches 3-6 enable cross-building BPF tools with
>> clang.
> 
> The set looks good to me. I checked that the tools are still building
> (without cross-compiling). I currently have issues building the
> selftests on my setup, but they don't appear to be related to this
> patchset.
> 
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> 
> Note that on bpf-next, patch 5 (runqslower) has a conflict with
> be79505caf3f ("tools/runqslower: Install libbpf headers when
> building").

Jean-Philippe, please do one rebase spin for addressing the above.

Thanks,
Daniel
