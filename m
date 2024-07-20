Return-Path: <linux-kselftest+bounces-13951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F73C93803C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E131F21841
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 09:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E27E4F20E;
	Sat, 20 Jul 2024 09:28:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558840847;
	Sat, 20 Jul 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467693; cv=none; b=efgww0Pxf8fquwkfXAiD6qiB/MnJ0y7DVmYkXTWp6kLAJcOzfQaWhwcNfxv5xtGf+VK25nyX80mDWCJ9G/TIl1H0WLqxFH5fJXNwBEX9YMJ5WWyAaYvHBk6FreG6aQ6EkbcU15MC8JweNXNT+6cq+dVE543Wmi8pvb8EfHu/SKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467693; c=relaxed/simple;
	bh=l+nqa5nuwOmzj5kBnQDOncKPCh024WoBxcbNeqzzTjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twz4/xmAU12ZdnTFoldrNBkTM2bvknQ7zDvUOmgC4I72/QHGO85DapyCUAtoKnYhDkWTGKgEHMPa6DiVmOJTU2LHuNhK9CnJmhWpNBrLrj5TH6JF1E9jU2OFPwVEO/aFu5Fl306SjmBrSZOnY5aOhdX6+5RukTi4fxn87JnhQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WR1RS0TNWz4f3jdT;
	Sat, 20 Jul 2024 17:27:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3EEB71A0820;
	Sat, 20 Jul 2024 17:28:00 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBnxg0cg5tmdeOcAg--.53823S2;
	Sat, 20 Jul 2024 17:27:57 +0800 (CST)
Message-ID: <b78ced92-78a4-41d2-8d2b-248f8bb43abb@huaweicloud.com>
Date: Sat, 20 Jul 2024 17:27:56 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/20] lsm: Refactor return value of LSM hook
 inode_need_killpriv
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
References: <20240711111908.3817636-3-xukuohai@huaweicloud.com>
 <1cc57fedd0b012874a031dc3d3d4a0fd@paul-moore.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <1cc57fedd0b012874a031dc3d3d4a0fd@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnxg0cg5tmdeOcAg--.53823S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryDtr13XFy7Jw47Xw1kKrg_yoW8ZFW7pr
	WYkF4Y9w1DAFyxur9aqF17uw4Fy3yfGr47ta9akryUZFn8Ar1Ikr4Syw429r18Xr10vryY
	vws2v3WrCF1UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1U
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVZ
	2-UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/19/2024 10:08 AM, Paul Moore wrote:
> On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> To be consistent with most LSM hooks, convert the return value of
>> hook inode_need_killpriv to 0 or a negative error code.
>>
>> Before:
>> - Both hook inode_need_killpriv and func security_inode_need_killpriv
>>    return > 0 if security_inode_killpriv is required, 0 if not, and < 0
>>    to abort the operation.
>>
>> After:
>> - Both hook inode_need_killpriv and func security_inode_need_killpriv
>>    return 0 on success and a negative error code on failure.
>>    On success, hook inode_need_killpriv sets output param @need to true
>>    if security_inode_killpriv is required, and false if not. When @need
>>    is true, func security_inode_need_killpriv sets ATTR_KILL_PRIV flag
>>    in @attr; when false, it clears the flag.
>>    On failure, @need and @attr remains unchanged.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   fs/attr.c                     |  5 ++---
>>   fs/inode.c                    |  4 +---
>>   include/linux/lsm_hook_defs.h |  2 +-
>>   include/linux/security.h      | 20 ++++++++++++++++----
>>   security/commoncap.c          | 12 ++++++++----
>>   security/security.c           | 29 ++++++++++++++++++++++++-----
>>   6 files changed, 52 insertions(+), 20 deletions(-)
> 
> In general I think a lot of these changes are a good improvement, thank
> you very much for the time and effort you've spent on this.  However,
> I'm not in favor of passing the new hook parameter as a way of reducing
> the number of states represented by the security_inode_killpriv() return
> value.  This particular hook may need to remain as one of the odd special
> cases.
> 

I learned from previous discussions [1] to use a new output parameter to store
odd return values. Actually, I am not in favor of this method either, especially
since it requires extra work to enable BPF to access the output parameter. I
think we could just keep it as-is.

[1] https://lore.kernel.org/bpf/CAHC9VhQ_sTmoXwQ_AVfjTYQe4KR-uTnksPVfsei5JZ+VDJBQkA@mail.gmail.com/


