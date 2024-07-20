Return-Path: <linux-kselftest+bounces-13959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057BA938079
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FC7283D96
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 09:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70817824B1;
	Sat, 20 Jul 2024 09:31:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9C7829C;
	Sat, 20 Jul 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467910; cv=none; b=RDQZdLOLwnEpvmLew8lngF935gCRAKEhnC1Zidn/BuvdMAXrX77ajFuJkL6qSaKXKR1mgKr5FhwU7+0lYao/38cSjKvvC8qlzOj8o9TDhxI1I0ol+4ZL3mvYnerNJJQ+Pd/kO8mCcDq34zqW4g/hIc+70whAur990+En+wjzUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467910; c=relaxed/simple;
	bh=2l6tmWT9koYokJ/U+bvELmWCsy+MWH156hsZGwlidAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYrWMIQAHeY/wn3bv2FZMLuI4kdEWP5/FKz+ySEAiCndHxtyxIg1zdJHhtL9rhL8XJ64yb9bpiTV3qA7hIoW62/a0krN+gSCZpLLz8hxQFuwqogTTOY/QgSFvY+29FiS/mkqQeHB/XO7KeYbSFwutO/Jlu9BIFO15hSqMoVsdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WR1Ws4Xv7z4f3jkM;
	Sat, 20 Jul 2024 17:31:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B91DD1A0809;
	Sat, 20 Jul 2024 17:31:45 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgBHdzW5g5tmfxqfAg--.54511S5;
	Sat, 20 Jul 2024 17:31:45 +0800 (CST)
Message-ID: <dc54d44a-465a-472c-8636-5de786ad0264@huaweicloud.com>
Date: Sat, 20 Jul 2024 17:31:44 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/20] lsm: Refactor return value of LSM hook
 setprocattr
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
References: <20240711111908.3817636-8-xukuohai@huaweicloud.com>
 <9f26368cc7aeccba460c9bce0a13f301@paul-moore.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <9f26368cc7aeccba460c9bce0a13f301@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHdzW5g5tmfxqfAg--.54511S5
X-Coremail-Antispam: 1UD129KBjvJXoW7trWUJw4kCFWUXr48WryDJrb_yoW8Xry8pF
	s5KFn09ryktF93urs3ZF13ua15Aw4rGr45JrW3Kw1jyF98Jr1xWry7Gr12krW7G3W8uwn5
	tF42qrsxuryDArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Wr
	v_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0uM
	KtUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/19/2024 10:08 AM, Paul Moore wrote:
> On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> To be consistent with most LSM hooks, convert the return value of
>> hook setprocattr to 0 or a negative error code.
>>
>> Before:
>> - Hook setprocattr returns the number of bytes written on success
>>    or a negative error code on failure.
>>
>> After:
>> - Hook setprocattr returns 0 on success or a negative error code
>>    on failure. An output parameter @wbytes is introduced to hold
>>    the number of bytes written on success.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   fs/proc/base.c                |  5 +++--
>>   include/linux/lsm_hook_defs.h |  3 ++-
>>   include/linux/security.h      |  5 +++--
>>   security/apparmor/lsm.c       | 10 +++++++---
>>   security/security.c           |  8 +++++---
>>   security/selinux/hooks.c      | 11 ++++++++---
>>   security/smack/smack_lsm.c    | 14 ++++++++++----
>>   7 files changed, 38 insertions(+), 18 deletions(-)
> 
> The security_setprocattr() hook is another odd case that we probably
> just want to leave alone for two reasons:
> 
> 1. With the move to LSM syscalls for getting/setting a task's LSM
> attributes we are "freezing" the procfs API and not adding any new
> entries to it.
> 
> 2. The BPF LSM doesn't currently register any procfs entries.
> 
> I'd suggest leaving security_setprocattr() as-is and blocking it in
> the BPF verifier, I can't see any reason why a BPF LSM would need
> this hook.
> 
OK, I'll drop this patch in the next version.


