Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62905DD15B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 23:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505685AbfJRVp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 17:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:32836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503048AbfJRVp6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 17:45:58 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3792064A;
        Fri, 18 Oct 2019 21:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571435158;
        bh=R2v0iTUTRGy/xSMyd1LRwnBvByLQ2gffs95hkX5obAU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V8tJKla2n10j/rFRjNQtXZlc7kpTY5ev2ywnn05zTY1GMyZ7DKI3jot+GqZlpRuXJ
         bbUrBFR++9O9FOhMJZ1J5rtRfSxmCq4F8HBiKuJ6iYB+tmzYuik3GJJ3ZZWJJFMKTl
         HpjYev19cGZLcmUzd33Xbs9M3HjdJo6EW+OIzUqk=
Subject: Re: [BUGFIX PATCH 0/5] selftests: Fixes for 32bit arch
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, shuah <shuah@kernel.org>
References: <157046101671.20724.9561877942986463668.stgit@devnote2>
From:   shuah <shuah@kernel.org>
Message-ID: <ebd87597-9a1e-7d16-2dfb-5bd421383816@kernel.org>
Date:   Fri, 18 Oct 2019 15:45:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157046101671.20724.9561877942986463668.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/7/19 9:10 AM, Masami Hiramatsu wrote:
> Hi,
> 
> Here are some patches to fix some warnings/issues on 32bit arch
> (e.g. arm).
> 
> When I built the ksefltest on arm, I hit some 32bit related warnings.
> Here are the patches to fix those issues.
> 
> 
>   - [1/5] va_max was set 2^32 even on 32bit arch. This can make
>          va_max == 0 and always fail. Make it 3GB on 32bit.
>   - [2/5] Some VM tests requires 64bit user space, which should
>          not run on 32bit arch.
>   - [3/5] For counting the size of large file, we should use
>          size_t instead of unsinged long.
>   - [4/5] Gcc warns printf format for size_t and int64_t on
>          32bit arch. Use %llu and cast it.
>   - [5/5] Gcc warns __u64 and pointer type castings. It should
>          once translated to unsigned long.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (5):
>        selftests: proc: Make va_max 3GB on 32bit arch
>        selftests: vm: Build/Run 64bit tests only on 64bit arch
>        selftests: net: Use size_t and ssize_t for counting file size
>        selftests: net: Fix printf format warnings on arm
>        selftests: sync: Fix cast warnings on arm
> 
> 
>   tools/testing/selftests/net/so_txtime.c            |    4 ++--
>   tools/testing/selftests/net/tcp_mmap.c             |    8 ++++----
>   tools/testing/selftests/net/udpgso.c               |    3 ++-
>   tools/testing/selftests/net/udpgso_bench_tx.c      |    3 ++-
>   .../selftests/proc/proc-self-map-files-002.c       |   11 ++++++++++-
>   tools/testing/selftests/sync/sync.c                |    6 +++---
>   tools/testing/selftests/vm/Makefile                |    5 +++++
>   tools/testing/selftests/vm/run_vmtests             |   10 ++++++++++
>   8 files changed, 38 insertions(+), 12 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 

Hi Masami,

I would love to pull these in. But looks like these are spread out
across several sub-systems.

There are some comments on vm patch. Do you mind sending them again
cc'ing everybody on the cover-letter. Looks like these are getting
lost in the noise.

thanks,
-- Shuah
