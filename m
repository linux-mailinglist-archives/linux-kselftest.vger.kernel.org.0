Return-Path: <linux-kselftest+bounces-13957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59775938068
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9B31C20383
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 09:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103D7641D;
	Sat, 20 Jul 2024 09:31:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7391B86FD;
	Sat, 20 Jul 2024 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467867; cv=none; b=eGZrusAESe7NSK3LgKE8nquDWAjrhURGgDKO7m87vbmM8XV18S11Bir31Y0kjRcVMOG/yh9yxtoA7kjpk96gkXpO6oAFBncUsf4PRsdeKGNhfewoNNczjX3IgQ8cslogZXm1jc1yFdXZfcM6GBh8/wBlKVcndycd8GANvkrg1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467867; c=relaxed/simple;
	bh=7611vFhlawYpy65LXTDZC518pJ/fg//nn4sbUfN5gTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzFUq9iGz1oRnN1v/MwZy1TFYawCbCaORhPNUfQNYMhhDFBWRylur+XpPu8HQnCCGD1GhwVABGzBsb/b6qFoG00J5kZ4QUGP974zJbCwKA2wk3zFbRYz2nkmlHwSqkKcpE1jE7O75I8OxGSkHKf4Oe2um8ehV8fhHFiTIowrBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WR1W20vGGz4f3jkJ;
	Sat, 20 Jul 2024 17:30:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 384CF1A0572;
	Sat, 20 Jul 2024 17:31:02 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgBHdzW5g5tmfxqfAg--.54511S3;
	Sat, 20 Jul 2024 17:31:01 +0800 (CST)
Message-ID: <7711bdba-9fbd-406c-8b81-adf91074d0b7@huaweicloud.com>
Date: Sat, 20 Jul 2024 17:31:01 +0800
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
References: <20240711111908.3817636-10-xukuohai@huaweicloud.com>
 <94a3b82a1e3e1fec77d676fa382105d4@paul-moore.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <94a3b82a1e3e1fec77d676fa382105d4@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHdzW5g5tmfxqfAg--.54511S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtw17AF13uFWUCr18Jw17GFg_yoW7ZFyxpF
	45KF4YyrWkJFy3urn7Z3W3Gaya939Ygr17G39xGF1YkF90vr1jgryjkr4jkry5ArW8Jr10
	yw47ZF43Cr1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
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
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0t5
	r7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/19/2024 10:08 AM, Paul Moore wrote:
> On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> To be consistent with most LSM hooks, convert the return value of
>> hook key_getsecurity to 0 or a negative error code.
>>
>> Before:
>> - Hook key_getsecurity returns length of value on success or a
>>    negative error code on failure.
>>
>> After:
>> - Hook key_getsecurity returns 0 on success or a negative error
>>    code on failure. An output parameter @len is introduced to hold
>>    the length of value on success.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   include/linux/lsm_hook_defs.h |  3 ++-
>>   include/linux/security.h      |  6 ++++--
>>   security/keys/keyctl.c        | 11 ++++++++---
>>   security/security.c           | 26 +++++++++++++++++++++-----
>>   security/selinux/hooks.c      | 11 +++++------
>>   security/smack/smack_lsm.c    | 21 +++++++++++----------
>>   6 files changed, 51 insertions(+), 27 deletions(-)
> 
> ...
> 
>> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
>> index 4bc3e9398ee3..e9f857620f28 100644
>> --- a/security/keys/keyctl.c
>> +++ b/security/keys/keyctl.c
>> @@ -1565,6 +1565,7 @@ long keyctl_get_security(key_serial_t keyid,
>>   	struct key *key, *instkey;
>>   	key_ref_t key_ref;
>>   	char *context;
>> +	size_t len;
>>   	long ret;
>>   
>>   	key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, KEY_NEED_VIEW);
>> @@ -1586,15 +1587,18 @@ long keyctl_get_security(key_serial_t keyid,
>>   	}
>>   
>>   	key = key_ref_to_ptr(key_ref);
>> -	ret = security_key_getsecurity(key, &context);
>> -	if (ret == 0) {
>> +	ret = security_key_getsecurity(key, &context, &len);
>> +	if (ret < 0)
>> +		goto error;
> 
> Since there is already an if-else pattern here you might as well stick
> with that, for example:
> 
>    if (ret == 0) {
>      ...
>    } else if (ret > 0) {
>      ...
>    }
> 
> ... you should probably add a comment that @ret is -ERRNO on failure,
> but it doesn't look like you need an explicit test here since the error
> case will normally fall through to the 'error' label (which you shouldn't
> need anymore either).
>

Got it, thanks for pointing that out.

>> +	if (len == 0) {
>>   		/* if no information was returned, give userspace an empty
>>   		 * string */
>>   		ret = 1;
>>   		if (buffer && buflen > 0 &&
>>   		    copy_to_user(buffer, "", 1) != 0)
>>   			ret = -EFAULT;
>> -	} else if (ret > 0) {
>> +	} else {
>> +		ret = len;
>>   		/* return as much data as there's room for */
>>   		if (buffer && buflen > 0) {
>>   			if (buflen > ret)
>> @@ -1607,6 +1611,7 @@ long keyctl_get_security(key_serial_t keyid,
>>   		kfree(context);
>>   	}
>>   
>> +error:
>>   	key_ref_put(key_ref);
>>   	return ret;
>>   }
>> diff --git a/security/security.c b/security/security.c
>> index 9dd2ae6cf763..2c161101074d 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -5338,19 +5338,35 @@ int security_key_permission(key_ref_t key_ref, const struct cred *cred,
>>    * security_key_getsecurity() - Get the key's security label
>>    * @key: key
>>    * @buffer: security label buffer
>> + * @len: the length of @buffer (including terminating NULL) on success
>>    *
>>    * Get a textual representation of the security context attached to a key for
>>    * the purposes of honouring KEYCTL_GETSECURITY.  This function allocates the
>>    * storage for the NUL-terminated string and the caller should free it.
>>    *
>> - * Return: Returns the length of @buffer (including terminating NUL) or -ve if
>> - *         an error occurs.  May also return 0 (and a NULL buffer pointer) if
>> - *         there is no security label assigned to the key.
>> + * Return: Returns 0 on success or -ve if an error occurs. May also return 0
>> + *         (and a NULL buffer pointer) if there is no security label assigned
>> + *         to the key.
>>    */
>> -int security_key_getsecurity(struct key *key, char **buffer)
>> +int security_key_getsecurity(struct key *key, char **buffer, size_t *len)
>>   {
>> +	int rc;
>> +	size_t n = 0;
>> +	struct security_hook_list *hp;
>> +
>>   	*buffer = NULL;
>> -	return call_int_hook(key_getsecurity, key, buffer);
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.key_getsecurity, list) {
>> +		rc = hp->hook.key_getsecurity(key, buffer, &n);
>> +		if (rc < 0)
>> +			return rc;
>> +		if (n)
>> +			break;
>> +	}
>> +
>> +	*len = n;
>> +
>> +	return 0;
>>   }
> 
> Help me understand why we can't continue to use the call_int_hook()
> macro here?
>

Before this patch, the hook may return +ve, 0, or -ve, and call_int_hook
breaks the loop when the hook return value is not 0.

After this patch, the +ve is stored in @n, so @n and return value should
both be checked to determine whether to break the loop. This is not
feasible with call_int_hook.

>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 16cd336aab3d..747ec602dec0 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6737,18 +6737,17 @@ static int selinux_key_permission(key_ref_t key_ref,
>>   	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
>>   }
>>   
>> -static int selinux_key_getsecurity(struct key *key, char **_buffer)
>> +static int selinux_key_getsecurity(struct key *key, char **_buffer,
>> +				   size_t *_len)
>>   {
>>   	struct key_security_struct *ksec = key->security;
>>   	char *context = NULL;
>> -	unsigned len;
>> +	u32 context_len;
> 
> Since @len doesn't collide with the parameter, you might as well just
> stick with @len as the local variable name.
>

Got it

>>   	int rc;
>>   
>> -	rc = security_sid_to_context(ksec->sid,
>> -				     &context, &len);
>> -	if (!rc)
>> -		rc = len;
>> +	rc = security_sid_to_context(ksec->sid, &context, &context_len);
>>   	*_buffer = context;
>> +	*_len = context_len;
>>   	return rc;
>>   }
> 
> --
> paul-moore.com
> 


