Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF8EAECA
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 12:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfJaLXZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 07:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbfJaLXY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 07:23:24 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C0D32083E;
        Thu, 31 Oct 2019 11:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572521003;
        bh=kZbrgBnyMA8h0x5/kgHd+8yWSc9Lj4f8QhgW8XZFIfI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SZ7Jf8FWwJbE2qBGs+l4rv4L1DUngP8mFgYn8YuBl29kN9NXPefisT3ZiCVcYXUMV
         4TxW9q8Gga7NnaicGFeGFcxwuztcK+i8IynFbb0hdoghCgP12FTSzIRb7HwRxd4jhb
         WSHYQZWqu7KiDMKhlaJP3gszuNGyTPw5nYmG1cmE=
Date:   Thu, 31 Oct 2019 20:23:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Emilio =?UTF-8?B?TMOzcGV6?= <emilio.lopez@collabora.co.uk>
Subject: Re: [BUGFIX PATCH v3 0/5] selftests: Fixes for 32bit arch
Message-Id: <20191031202317.d264b984c4749af7abd43a84@kernel.org>
In-Reply-To: <157180665007.17298.907392422924029261.stgit@devnote2>
References: <157180665007.17298.907392422924029261.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Would anyone is OK for this fix?

I also found a typo on arm64 build... will send soon.

Thanks,

On Wed, 23 Oct 2019 13:57:30 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here are the 3rd version of kselftest fixes some on 32bit arch
> (e.g. arm)
> 
> In this version, I updated [1/5] to make va_max 1MB unconditionally
> according to Alexey's comment.
> 
> When I built the ksefltest on arm, I hit some 32bit related warnings.
> Here are the patches to fix those issues.
> 
> 
>  - [1/5] va_max was set 2^32 even on 32bit arch. This can make
>         va_max == 0 and always fail. Make it 1GB unconditionally.
>  - [2/5] Some VM tests requires 64bit user space, which should
>         not run on 32bit arch.
>  - [3/5] For counting the size of large file, we should use
>         size_t instead of unsinged long.
>  - [4/5] Gcc warns printf format for size_t and int64_t on
>         32bit arch. Use %llu and cast it.
>  - [5/5] Gcc warns __u64 and pointer type castings. It should
>         once translated to unsigned long.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (5):
>       selftests: proc: Make va_max 1MB
>       selftests: vm: Build/Run 64bit tests only on 64bit arch
>       selftests: net: Use size_t and ssize_t for counting file size
>       selftests: net: Fix printf format warnings on arm
>       selftests: sync: Fix cast warnings on arm
> 
> 
>  tools/testing/selftests/net/so_txtime.c            |    4 ++--
>  tools/testing/selftests/net/tcp_mmap.c             |    8 ++++----
>  tools/testing/selftests/net/udpgso.c               |    3 ++-
>  tools/testing/selftests/net/udpgso_bench_tx.c      |    3 ++-
>  .../selftests/proc/proc-self-map-files-002.c       |    6 +++++-
>  tools/testing/selftests/sync/sync.c                |    6 +++---
>  tools/testing/selftests/vm/Makefile                |    5 +++++
>  tools/testing/selftests/vm/run_vmtests             |   10 ++++++++++
>  8 files changed, 33 insertions(+), 12 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
