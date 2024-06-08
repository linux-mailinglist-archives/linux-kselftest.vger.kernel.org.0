Return-Path: <linux-kselftest+bounces-11467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA96E901012
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419271F22343
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C74915CD74;
	Sat,  8 Jun 2024 08:04:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4824ACA40;
	Sat,  8 Jun 2024 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717833875; cv=none; b=tzRRYUN6sY2/WzKvaE42C/H8LOssuOkeEWIjHEY6QyKvg0pxxuP5vfss2AztXOVgwJgpLoLn+0+0MrlniFRG9TR6NVZca8ODZqjF6Ww2jO1VxUcjmnO92vMckHdhxhsHg660Tk5Lj3McHU6adsjAnt61YHAAuNf2DD294QG5FTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717833875; c=relaxed/simple;
	bh=Wrgs+ZE7cmrZBquFV5k8uyVqzNDWOPnRTG9hcmXBzsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IL/xbzbsuA88yT4XisyIYN95RFTd94BTBnydXfgjVlA77v4yp0gCaU8VkzK40BLG++qN27aHYGmREqAiWqHNj9Th/5k3THZrCgpxKddSI22FVQFSkmigXh1TykDMzrXrm7mNyznRBUpb2n3qj8Ut3Y7E/fnteEtc2q16gNExypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vx9ZT5SdMz4f3jsq;
	Sat,  8 Jun 2024 16:04:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8F4FF1A016E;
	Sat,  8 Jun 2024 16:04:27 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDH4AmJEGRmD5OVOw--.47038S2;
	Sat, 08 Jun 2024 16:04:27 +0800 (CST)
Message-ID: <b4484882-0de5-4515-8c40-41891ac4b21e@huaweicloud.com>
Date: Sat, 8 Jun 2024 16:04:25 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 01/11] bpf, lsm: Annotate lsm hook return
 value range
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-2-xukuohai@huaweicloud.com>
 <CAHC9VhRipBNd+G=RMPVeVOiYCx6FZwHSn0JNKv=+jYZtd5SdYg@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAHC9VhRipBNd+G=RMPVeVOiYCx6FZwHSn0JNKv=+jYZtd5SdYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDH4AmJEGRmD5OVOw--.47038S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWry8ur1xZr43Gr4rGr4Durg_yoWrAF43pF
	sYka43KFWvyFWa9rn2yan8ZayakrWfCr47tr17KwnFy3WSqrnFva17tw4Y9FWrCry8K34j
	9F4j93yrCw4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/7/2024 5:53 AM, Paul Moore wrote:
> On Thu, Apr 11, 2024 at 8:24 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> Add macro LSM_RET_INT to annotate lsm hook return integer type and the
>> default return value, and the expected return range.
>>
>> The LSM_RET_INT is declared as:
>>
>> LSM_RET_INT(defval, min, max)
>>
>> where
>>
>> - defval is the default return value
>>
>> - min and max indicate the expected return range is [min, max]
>>
>> The return value range for each lsm hook is taken from the description
>> in security/security.c.
>>
>> The expanded result of LSM_RET_INT is not changed, and the compiled
>> product is not changed.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   include/linux/lsm_hook_defs.h | 591 +++++++++++++++++-----------------
>>   include/linux/lsm_hooks.h     |   6 -
>>   kernel/bpf/bpf_lsm.c          |  10 +
>>   security/security.c           |   1 +
>>   4 files changed, 313 insertions(+), 295 deletions(-)
> 
> ...
> 
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 334e00efbde4..708f515ffbf3 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -18,435 +18,448 @@
>>    * The macro LSM_HOOK is used to define the data structures required by
>>    * the LSM framework using the pattern:
>>    *
>> - *     LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
>> + *     LSM_HOOK(<return_type>, <return_description>, <hook_name>, args...)
>>    *
>>    * struct security_hook_heads {
>> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
>> + *   #define LSM_HOOK(RET, RETVAL_DESC, NAME, ...) struct hlist_head NAME;
>>    *   #include <linux/lsm_hook_defs.h>
>>    *   #undef LSM_HOOK
>>    * };
>>    */
>> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
>> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_set_context_mgr, const struct cred *mgr)
>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transaction, const struct cred *from,
>>           const struct cred *to)
>> -LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_binder, const struct cred *from,
>>           const struct cred *to)
>> -LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_file, const struct cred *from,
>>           const struct cred *to, const struct file *file)
> 
> I'm not overly excited about injecting these additional return value
> range annotations into the LSM hook definitions, especially since the
> vast majority of the hooks "returns 0 on success, negative values on
> error".  I'd rather see some effort put into looking at the
> feasibility of converting some (all?) of the LSM hook return value
> exceptions into the more conventional 0/-ERRNO format.  Unfortunately,
> I haven't had the time to look into that myself, but if you wanted to
> do that I think it would be a good thing.
> 

I agree that keeping all hooks return a consistent range of 0/-ERRNO
is more elegant than adding return value range annotations. However, there
are two issues that might need to be addressed first:

1. Compatibility

For instance, security_vm_enough_memory_mm() determines whether to
set cap_sys_admin by checking if the hook vm_enough_memory returns
a positive number. If we were to change the hook vm_enough_memory
to return 0 to indicate the need for cap_sys_admin, then for the
LSM BPF program currently returning 0, the interpretation of its
return value would be reversed after the modification.

2. Expressing multiple non-error states using 0/-ERRNO

IIUC, although 0/-ERRNO can be used to express different errors,
only 0 can be used for non-error state. If there are multiple
non-error states, they cannot be distinguished. For example,
security_inode_need_killpriv() returns < 0 on error, 0 if
security_inode_killpriv() doesn't need to be called, and > 0
if security_inode_killpriv() does need to be called.


