Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73D1A1885
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 01:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDGXTG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 19:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDGXTG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 19:19:06 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 881E720678;
        Tue,  7 Apr 2020 23:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586301545;
        bh=esnOlBQUNAip9DDpTR1+DfUPZ+TmrYUp8v+D8D9v8tA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1TFWy9I5TIiw3c28mE4UrqtkukSnxJWFIHBOllc3WJjbJ/zbh1xK+M5G0b+fvZP5a
         vui3UXvo1Tvo6xr6UGuvqme0m93+DH6LOd+CaV0mQEDmWFaPriZmIGCa/88jkYchBk
         jbrl2RTmEj7QxvJ3ZkQPsLJ2ahuPbVW4ca4slgWU=
Subject: Re: [PATCH] selftests: add 'show_targets' make target
To:     tbird20d@gmail.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, shuah <shuah@kernel.org>
References: <1584138204-12238-1-git-send-email-tim.bird@sony.com>
From:   shuah <shuah@kernel.org>
Message-ID: <03793337-65b3-7b7a-3822-ee32f7d6943f@kernel.org>
Date:   Tue, 7 Apr 2020 17:19:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1584138204-12238-1-git-send-email-tim.bird@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/13/20 4:23 PM, tbird20d@gmail.com wrote:
> From: Tim Bird <tim.bird@sony.com>
> 
> It is useful for CI systems to be able to query the list
> of targets provided by kselftest by default, so that they
> can construct their own loop over the targets if desired.
> 
> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
>   tools/testing/selftests/Makefile | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 63430e2..9955e71 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -246,4 +246,7 @@ clean:
>   		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
>   	done;
>   
> +show_targets:
> +	@echo $(TARGETS)
> +
>   .PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
> 

Hi Tim,

It is useful addition. Output is hard to read though. It would
be helpful to improve the printing targets.

make -C tools/testing/selftests/ show_targets
make: Entering directory '/lkml/linux_5.7/tools/testing/selftests'
android arm64 bpf breakpoints capabilities cgroup clone3 cpufreq 
cpu-hotplug drivers/dma-buf efivarfs exec filesystems 
filesystems/binderfs filesystems/epoll firmware ftrace futex gpio 
intel_pstate ipc ir kcmp kexec kvm lib livepatch lkdtm membarrier memfd 
memory-hotplug mount mqueue net net/forwarding net/mptcp netfilter nsfs 
pidfd pid_namespace powerpc proc pstore ptrace openat2 rseq rtc seccomp 
sigaltstack size sparc64 splice static_keys sync sysctl timens timers 
tmpfs tpm2 user vm x86 zram

thanks,
-- Shuah
