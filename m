Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A69681588
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 16:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjA3PuJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 10:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbjA3Ptp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 10:49:45 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C061816D;
        Mon, 30 Jan 2023 07:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1675093778;
        bh=ZpNvNQjqDJWSVYLNAt/JE5nTHOBGVZ5rNMJzdhWDBvI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YudiXcAUwBLHWeHQdmYHAwKb/PV+eIfah6AtkbuLFKMSbyI5VTiLJ2Vv09FzdbT50
         0Dat4rR0fgpQWH9dxjK+1RnNVUPgGZD0J50ajPZpmshMP4kHVPThGbE9xdqVvPTTIb
         p2uAJ/s0Yy4DADm94/g/AvFItVa5XcyLFAqexQbv4Kqm26H3efxSjhJxF6SXW0UlBj
         wDTsWoiiyDa3e0Bw5pG/h5jo6hREj3Rt2UylpEpqH/A9UIJ0Zgpufr1UaOphQh/l6S
         vLl1hgJ8I4QnPownZJ3U6XAua/hm/zRALUJwerJuQo9tiAoUEP+U0MaI0uFBsAnwKn
         ImorP2qQKdiHA==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P5CKt449Jzj0p;
        Mon, 30 Jan 2023 10:49:38 -0500 (EST)
Message-ID: <946da82b-4792-fd0b-9b01-d64bacb17578@efficios.com>
Date:   Mon, 30 Jan 2023 10:50:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH -next] KVM: selftests: Fix build error
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, pbonzini@redhat.com,
        shuah@kernel.org, gshan@redhat.com, peterz@infradead.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230130124445.3476-1-yuehaibing@huawei.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230130124445.3476-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-01-30 07:44, YueHaibing wrote:
> kvm selftests build fails with below info:
> 
> rseq_test.c:48:13: error: conflicting types for ‘sys_getcpu’; have ‘void(unsigned int *)’
>     48 | static void sys_getcpu(unsigned *cpu)
>        |             ^~~~~~~~~~
> In file included from rseq_test.c:23:
> ../rseq/rseq.c:82:12: note: previous definition of ‘sys_getcpu’ with type ‘int(unsigned int *, unsigned int *)’
>     82 | static int sys_getcpu(unsigned *cpu, unsigned *node)
>        |            ^~~~~~~~~~
> 
> commit 66d42ac73fc6 ("KVM: selftests: Make rseq compatible with glibc-2.35")
> has include "../rseq/rseq.c", and commit 99babd04b250 ("selftests/rseq: Implement rseq numa node id field selftest")
> add sys_getcpu() implement, so use sys_getcpu in rseq/rseq.c to fix this.
> 
> Fixes: 99babd04b250 ("selftests/rseq: Implement rseq numa node id field selftest")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Hi,

This patch replicates an already existing patch:

https://lore.kernel.org/all/20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org/

The original patch should be routed through the tip tree by Peter Zijlstra shortly.

Thanks,

Mathieu

> ---
>   tools/testing/selftests/kvm/rseq_test.c | 19 ++++++-------------
>   1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 3045fdf9bdf5..69ff39aa2991 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -41,18 +41,6 @@ static void guest_code(void)
>   		GUEST_SYNC(0);
>   }
>   
> -/*
> - * We have to perform direct system call for getcpu() because it's
> - * not available until glic 2.29.
> - */
> -static void sys_getcpu(unsigned *cpu)
> -{
> -	int r;
> -
> -	r = syscall(__NR_getcpu, cpu, NULL, NULL);
> -	TEST_ASSERT(!r, "getcpu failed, errno = %d (%s)", errno, strerror(errno));
> -}
> -
>   static int next_cpu(int cpu)
>   {
>   	/*
> @@ -249,7 +237,12 @@ int main(int argc, char *argv[])
>   			 * across the seq_cnt reads.
>   			 */
>   			smp_rmb();
> -			sys_getcpu(&cpu);
> +			/*
> +			 * We have to perform direct system call for getcpu() because it's
> +			 * not available until glic 2.29.
> +			 */
> +			r = sys_getcpu(&cpu, NULL);
> +			TEST_ASSERT(!r, "getcpu failed, errno = %d (%s)", errno, strerror(errno));
>   			rseq_cpu = rseq_current_cpu_raw();
>   			smp_rmb();
>   		} while (snapshot != atomic_read(&seq_cnt));

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

