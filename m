Return-Path: <linux-kselftest+bounces-13952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BB0938040
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C615A1C209E8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B975B68F;
	Sat, 20 Jul 2024 09:28:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D69449;
	Sat, 20 Jul 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467736; cv=none; b=Dsq9ZEc5X3ui5cackJM8UW8OC0Hm49yTpOtEmtlnAX9B5IwzTOY4+qrz34/Bulm1LiZDz+HNo4XW+KmdfIfPbW6S9S+HA9DbkhEGIMHf346DOyUEIZ1PLQRZNGAwNruk7HmWg84TK0CuLTA3x01RFvAYO7wM4jMQ02D1PPorKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467736; c=relaxed/simple;
	bh=FnBzLKmOE+ztnz/BjsMCfhtl0lB30jdhr9nlAhm/VLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egQKlE6N2AdI2RonEB7LtUQBFVKlXwOOVWpccXvTxAQ3D5m2ALT/QePiUvvR9kPe6dYTWm6DyJNgUHVCWDsSF6EuHZuODzOueSw8KvMBqeU7Vl31Ac0qP5qyeavZ1CIkmmC+gfpUHyVVRbUyP2vR1HRqcVTBryZiZcTQ1Cr7dnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WR1SM15f0z4f3kvh;
	Sat, 20 Jul 2024 17:28:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 79E461A08B3;
	Sat, 20 Jul 2024 17:28:48 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgCHc3VOg5tmPCSIAg--.40166S2;
	Sat, 20 Jul 2024 17:28:46 +0800 (CST)
Message-ID: <e70541cb-d239-4b54-a08b-9cf88e43b364@huaweicloud.com>
Date: Sat, 20 Jul 2024 17:28:46 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/20] lsm: Refactor return value of LSM hook
 inode_getsecurity
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Xu Kuohai <xukuohai@huaweicloud.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
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
References: <20240711111908.3817636-4-xukuohai@huaweicloud.com>
 <bae9304f6fd9ac9536f709a990085119@paul-moore.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <bae9304f6fd9ac9536f709a990085119@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHc3VOg5tmPCSIAg--.40166S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1kJF47Jw1DCF4Uuw13CFg_yoW5XFykpF
	4fKF4Y9r10qF93urn3ZF17u3WagaySkr4UGrW5Kr1FyFnIyrn2gr1jkr409rn8ury8CF10
	va12van8CryDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7sREfHUDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/19/2024 10:08 AM, Paul Moore wrote:
> On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> To be consistent with most LSM hooks, convert the return value of
>> hook inode_getsecurity to 0 or a negative error code.
>>
>> Before:
>> - Hook inode_getsecurity returns size of buffer on success or a
>>    negative error code on failure.
>>
>> After:
>> - Hook inode_getsecurity returns 0 on success or a negative error
>>    code on failure. An output parameter @len is introduced to hold
>>    the buffer size on success.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   fs/xattr.c                    | 19 ++++++++++---------
>>   include/linux/lsm_hook_defs.h |  3 ++-
>>   include/linux/security.h      | 12 ++++++------
>>   security/commoncap.c          |  9 ++++++---
>>   security/security.c           | 11 ++++++-----
>>   security/selinux/hooks.c      | 16 ++++++----------
>>   security/smack/smack_lsm.c    | 14 +++++++-------
>>   7 files changed, 43 insertions(+), 41 deletions(-)
> 
> Aside from Simon's concern over variable types, I saw a few other issues
> when looking at this patch (below).
> 
>> diff --git a/security/commoncap.c b/security/commoncap.c
>> index 17d6188d22cf..ff82e2ab6f8f 100644
>> --- a/security/commoncap.c
>> +++ b/security/commoncap.c
>> @@ -485,7 +485,10 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
>>   	}
>>   out_free:
>>   	kfree(tmpbuf);
>> -	return size;
>> +	if (size < 0)
>> +		return size;
>> +	*len = size;
>> +	return 0;
>>   }
> 
> We should do a better job converting cap_inode_getsecurity(), create a
> new local variable, e.g. 'int error', and use it to store and return the
> error code instead of reusing @size.  I understand that what you've done
> is easier, but I'd prefer to see it done properly.
>

Got it

>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 9cd5a8f1f6a3..70792bba24d9 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -3407,7 +3407,7 @@ static int selinux_path_notify(const struct path *path, u64 mask,
>>    */
>>   static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
>>   				     struct inode *inode, const char *name,
>> -				     void **buffer, bool alloc)
>> +				     bool alloc, void **buffer, u32 *len)
>>   {
>>   	u32 size;
>>   	int error;
>> @@ -3440,14 +3440,14 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
>>   						&context, &size);
>>   	if (error)
>>   		return error;
>> -	error = size;
>> +	*len = size;
> 
> Depending on how you choose to resolve the variable type issue, you may
> be able to pass @len directly to security_sid_to_context().
>

Sounds great

>>   	if (alloc) {
>>   		*buffer = context;
>>   		goto out_nofree;
>>   	}
>>   	kfree(context);
>>   out_nofree:
>> -	return error;
>> +	return 0;
>>   }
> 
> 
> --
> paul-moore.com
> 
> 


