Return-Path: <linux-kselftest+bounces-13707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD533930473
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DB71F242C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874503E47B;
	Sat, 13 Jul 2024 08:07:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C901C28E;
	Sat, 13 Jul 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720858052; cv=none; b=QxdeTPonrPKYHCQd0te7VzYaW9K3BPtTOKmkApOmwz+HzC2zhaMt6QwyFOXQa3ibmswONVtR0IHz5UDo3dUlxBHgo6TjVrMD8fWE7cuW1MCC/gh0txPs3J+F7htnVj/10C+uwlHOQy6YD4tILghamIrViV07G/VDpXNaggVSJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720858052; c=relaxed/simple;
	bh=dBcPhqDVndHZ64wsguqvZ9x4KkqokQ2jSWiRoVQGZrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNiLoVGvkaFjNOq3N2JOncI6Qd8YekGAEKbGiv1Z3TN0uPOxG4LZqyt4UWxAGRLOLh8w7b+rxxwEOtjnYm7EzUWgRbnir66mHNRYeHICiwN+Svz/X6I+YGVIYnsepGK2OyPsKucJ9y0FYFb0ZeXQltLyJYLLTcw8y1oJuPCQu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WLgzl1XX1z4f3jcn;
	Sat, 13 Jul 2024 16:07:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 013891A0199;
	Sat, 13 Jul 2024 16:07:27 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgAnNF6jNZJmxmuLBw--.4019S3;
	Sat, 13 Jul 2024 16:07:26 +0800 (CST)
Message-ID: <7154a541-d78c-4560-a6de-90340ce23555@huaweicloud.com>
Date: Sat, 13 Jul 2024 16:07:26 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 03/20] lsm: Refactor return value of LSM hook
 inode_getsecurity
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com,
 selinux@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Brendan Jackman <jackmanb@chromium.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
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
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
 <20240711111908.3817636-4-xukuohai@huaweicloud.com>
 <20240712133141.GB120802@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20240712133141.GB120802@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAnNF6jNZJmxmuLBw--.4019S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF48tr4xZFWrArW3JrW7CFg_yoW5JF4kpF
	Z3Kan8ur48ZFyfWrn2qF13u3WFva93Kr15GrZIqF1YyF1DZr1Sgry2kr109r97Cry8G34I
	qF17uFs3Cw1UAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAHUDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/12/2024 9:31 PM, Simon Horman wrote:
> On Thu, Jul 11, 2024 at 07:18:51PM +0800, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
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
>>
>> diff --git a/fs/xattr.c b/fs/xattr.c
>> index f8b643f91a98..f4e3bedf7272 100644
>> --- a/fs/xattr.c
>> +++ b/fs/xattr.c
>> @@ -339,27 +339,28 @@ xattr_getsecurity(struct mnt_idmap *idmap, struct inode *inode,
>>   		  const char *name, void *value, size_t size)
>>   {
>>   	void *buffer = NULL;
>> -	ssize_t len;
>> +	int error;
>> +	u32 len;
>>   
>>   	if (!value || !size) {
>> -		len = security_inode_getsecurity(idmap, inode, name,
>> -						 &buffer, false);
>> +		error = security_inode_getsecurity(idmap, inode, name,
>> +						   false, &buffer, &len);
>>   		goto out_noalloc;
>>   	}
>>   
>> -	len = security_inode_getsecurity(idmap, inode, name, &buffer,
>> -					 true);
>> -	if (len < 0)
>> -		return len;
>> +	error = security_inode_getsecurity(idmap, inode, name, true,
>> +					   &buffer, &len);
>> +	if (error)
>> +		return error;
>>   	if (size < len) {
>> -		len = -ERANGE;
>> +		error = -ERANGE;
>>   		goto out;
>>   	}
>>   	memcpy(value, buffer, len);
>>   out:
>>   	kfree(buffer);
>>   out_noalloc:
>> -	return len;
>> +	return error < 0 ? error : len;
> 
> Hi Xu Kuohai,
> 
> len is an unsigned 32-bit entity, but the return type of this function
> is an unsigned value (ssize_t). So in theory, if len is very large,
> a negative error value error will be returned.
> 
>>   }
> 
> Similarly for the handling of nattr in lsm_get_self_attr in
> lsm_syscalls.c in a subsequent patch.
> 
> Flagged by Smatch.
> 
> ...
> 
>

OK, indeed there is no standardization that says ssize_t must be wider than u32.
I'll look into adding overflow checks. Thanks.


