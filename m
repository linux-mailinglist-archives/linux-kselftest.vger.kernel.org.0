Return-Path: <linux-kselftest+bounces-14058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAB4939B5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DAEBB2187E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E257D14A617;
	Tue, 23 Jul 2024 07:04:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BDE13B5A6;
	Tue, 23 Jul 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718289; cv=none; b=NZfDBNNmXhi2UJwUGVAexlBZII9wGed5QYkqRhRZP/f0a4jgi/xs5hzLVPyS+aHqueC+30z8KU1zu7p5LnK368tpehzK0mLpWXug+aazlw5G9aDOsdliiKSGwCNyDIkSmQQQ20P6OvkDS3QmQaDCN0f1h10XgqVOD+bwkyCoh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718289; c=relaxed/simple;
	bh=OS7/D2fswcHFX0KJp9WVoT9m3o1j5i+tbBQzNvC5FiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PM26A4M3wpbhyQpyIZYEmXww1iJ6K1AoSDryHLMCfyH5//D3rDaUXndVfh4FyEjY5qrx7j2iWhV0golj10BBRX903ZgCIzkCDc7+MLCLWcxJSxsf1rtsCDT65K8L3/T1vo9xKy0CIkOZ5BxV1FxZizPeLVUpwM175nV5csvcdDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WSp6h0vm8z4f3l19;
	Tue, 23 Jul 2024 15:04:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 97B481A0CA0;
	Tue, 23 Jul 2024 15:04:41 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgBndE8HVp9mDXyOAw--.51101S2;
	Tue, 23 Jul 2024 15:04:41 +0800 (CST)
Message-ID: <b1ba86f7-f943-4913-8265-2a94f3951a88@huaweicloud.com>
Date: Tue, 23 Jul 2024 15:04:39 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/20] lsm: Refactor return value of LSM hook
 key_getsecurity
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
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
References: <20240711111908.3817636-10-xukuohai@huaweicloud.com>
 <94a3b82a1e3e1fec77d676fa382105d4@paul-moore.com>
 <7711bdba-9fbd-406c-8b81-adf91074d0b7@huaweicloud.com>
 <CAHC9VhSsCuJzJ3ReUTyTXfWqRd+_TfShJBnRugZtX6OrMYJkOQ@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAHC9VhSsCuJzJ3ReUTyTXfWqRd+_TfShJBnRugZtX6OrMYJkOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBndE8HVp9mDXyOAw--.51101S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZryfGF1fXrW8KFWUZry8AFb_yoWrWryxpr
	W5Ka1Yyr4kJFy3ur1Iv3W7uF4Sya93GF1UWrZ3Gw1UZr1qvr17Wr1jkr1j9ryrCr1fJr10
	vw47ZFZxCr1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j6a0PUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/23/2024 5:35 AM, Paul Moore wrote:
> On Sat, Jul 20, 2024 at 5:31 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>> On 7/19/2024 10:08 AM, Paul Moore wrote:
>>> On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>>
>>>> To be consistent with most LSM hooks, convert the return value of
>>>> hook key_getsecurity to 0 or a negative error code.
>>>>
>>>> Before:
>>>> - Hook key_getsecurity returns length of value on success or a
>>>>     negative error code on failure.
>>>>
>>>> After:
>>>> - Hook key_getsecurity returns 0 on success or a negative error
>>>>     code on failure. An output parameter @len is introduced to hold
>>>>     the length of value on success.
>>>>
>>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>>> ---
>>>>    include/linux/lsm_hook_defs.h |  3 ++-
>>>>    include/linux/security.h      |  6 ++++--
>>>>    security/keys/keyctl.c        | 11 ++++++++---
>>>>    security/security.c           | 26 +++++++++++++++++++++-----
>>>>    security/selinux/hooks.c      | 11 +++++------
>>>>    security/smack/smack_lsm.c    | 21 +++++++++++----------
>>>>    6 files changed, 51 insertions(+), 27 deletions(-)
> 
> ...
> 
>>>> diff --git a/security/security.c b/security/security.c
>>>> index 9dd2ae6cf763..2c161101074d 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -5338,19 +5338,35 @@ int security_key_permission(key_ref_t key_ref, const struct cred *cred,
>>>>     * security_key_getsecurity() - Get the key's security label
>>>>     * @key: key
>>>>     * @buffer: security label buffer
>>>> + * @len: the length of @buffer (including terminating NULL) on success
>>>>     *
>>>>     * Get a textual representation of the security context attached to a key for
>>>>     * the purposes of honouring KEYCTL_GETSECURITY.  This function allocates the
>>>>     * storage for the NUL-terminated string and the caller should free it.
>>>>     *
>>>> - * Return: Returns the length of @buffer (including terminating NUL) or -ve if
>>>> - *         an error occurs.  May also return 0 (and a NULL buffer pointer) if
>>>> - *         there is no security label assigned to the key.
>>>> + * Return: Returns 0 on success or -ve if an error occurs. May also return 0
>>>> + *         (and a NULL buffer pointer) if there is no security label assigned
>>>> + *         to the key.
>>>>     */
>>>> -int security_key_getsecurity(struct key *key, char **buffer)
>>>> +int security_key_getsecurity(struct key *key, char **buffer, size_t *len)
>>>>    {
>>>> +    int rc;
>>>> +    size_t n = 0;
>>>> +    struct security_hook_list *hp;
>>>> +
>>>>       *buffer = NULL;
>>>> -    return call_int_hook(key_getsecurity, key, buffer);
>>>> +
>>>> +    hlist_for_each_entry(hp, &security_hook_heads.key_getsecurity, list) {
>>>> +            rc = hp->hook.key_getsecurity(key, buffer, &n);
>>>> +            if (rc < 0)
>>>> +                    return rc;
>>>> +            if (n)
>>>> +                    break;
>>>> +    }
>>>> +
>>>> +    *len = n;
>>>> +
>>>> +    return 0;
>>>>    }
>>>
>>> Help me understand why we can't continue to use the call_int_hook()
>>> macro here?
>>>
>>
>> Before this patch, the hook may return +ve, 0, or -ve, and call_int_hook
>> breaks the loop when the hook return value is not 0.
>>
>> After this patch, the +ve is stored in @n, so @n and return value should
>> both be checked to determine whether to break the loop. This is not
>> feasible with call_int_hook.
> 
> Yes, gotcha.  I was focused on the error condition and wasn't thinking
> about the length getting zero'd out by a trailing callback.
> Unfortunately, we *really* want to stick with the
> call_{int,void}_hook() macros so I think we either need to find a way
> to work within that constraint for existing macro callers, or we have
> to leave this hook as-is for the moment.
> 

Let's leave it as is. So we ultimately have four hooks that can be
converted, two of which require adding additional output parameter to
hold odd return values. These output parameters require extra work
on the BPF verifier, and it doesn't seem worthwhile just for two
hooks. So I prefer to keep only the two patches that handle
conversion without adding output parameters (patch 1 and 5).


