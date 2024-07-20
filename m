Return-Path: <linux-kselftest+bounces-13954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C0938051
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C4F1F221ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403995C5F3;
	Sat, 20 Jul 2024 09:29:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAEE347C2;
	Sat, 20 Jul 2024 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467781; cv=none; b=INZEjYGDeYtACZbTM4wNEvzVNIahIC6vGFuBxK57QbTgX4jhkG9U+s7mvaltr6LrKBZu7AW9tsiWprTatREzH1P6V9iJUjz+zV68LXlE/QrLqEjKl81Z5t3FJ7O2IiQ+U8eV2qMlHKVwATgTWV12Jm0mU01ij8/i1de4k5SYfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467781; c=relaxed/simple;
	bh=ImJu2kr6Sa+AFoKakrryDbwu4/ESuESy/ttRqviesqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STWjeB5BqYpHmoAgEPUFdx0OfODpqOb4Gn2980icJQn1CJ/5yT8qDtkexqOtHZvc+WYQxyZFYzMkxYTR1rTd9yTRDWItaH8plO8/n2w29b8hxYk5IsFIexMMoqjAW3Lif9NFqcKrTVmwGGq7ygHAW/W5mWLCGf6b7lr+HC4mtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WR1TJ1M7hz4f3jdl;
	Sat, 20 Jul 2024 17:29:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 614E01A058E;
	Sat, 20 Jul 2024 17:29:36 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgCHc3VOg5tmPCSIAg--.40166S4;
	Sat, 20 Jul 2024 17:29:35 +0800 (CST)
Message-ID: <b371cb67-6fa4-499d-b572-496c6938d86d@huaweicloud.com>
Date: Sat, 20 Jul 2024 17:29:35 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/20] lsm: Refactor return value of LSM hook
 inode_copy_up_xattr
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
References: <20240711111908.3817636-6-xukuohai@huaweicloud.com>
 <3a8d55e0d41a35a1a3c5d3590240d16b@paul-moore.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <3a8d55e0d41a35a1a3c5d3590240d16b@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHc3VOg5tmPCSIAg--.40166S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXF15Wr1ftF1kGF4xKF15Arb_yoW5XF4rpF
	4UKa10qrn5tFyUZryxXF17Wws29ayfGFy5G39Ivw13Aa95ZF1fKryayr1IgF45WryxJF4v
	qanF93ZxC3Z0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Wr
	v_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0dO
	z3UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/19/2024 10:08 AM, Paul Moore wrote:
> On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> To be consistent with most LSM hooks, convert the return value of
>> hook inode_copy_up_xattr to 0 or a negative error code.
>>
>> Before:
>> - Hook inode_copy_up_xattr returns 0 when accepting xattr, 1 when
>>    discarding xattr, -EOPNOTSUPP if it does not know xattr, or any
>>    other negative error code otherwise.
>>
>> After:
>> - Hook inode_copy_up_xattr returns 0 when accepting xattr, *-ECANCELED*
>>    when discarding xattr, -EOPNOTSUPP if it does not know xattr, or
>>    any other negative error code otherwise.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   fs/overlayfs/copy_up.c            |  6 +++---
>>   security/integrity/evm/evm_main.c |  2 +-
>>   security/security.c               | 12 ++++++------
>>   security/selinux/hooks.c          |  4 ++--
>>   security/smack/smack_lsm.c        |  6 +++---
>>   5 files changed, 15 insertions(+), 15 deletions(-)
> 
> ...
> 
>> diff --git a/security/security.c b/security/security.c
>> index 26eea8f4cd74..12215ca286af 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2675,18 +2675,18 @@ EXPORT_SYMBOL(security_inode_copy_up);
>>    * lower layer to the union/overlay layer.   The caller is responsible for
>>    * reading and writing the xattrs, this hook is merely a filter.
>>    *
>> - * Return: Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP
>> - *         if the security module does not know about attribute, or a negative
>> - *         error code to abort the copy up.
>> + * Return: Returns 0 to accept the xattr, -ECANCELED to discard the xattr,
>> + *         -EOPNOTSUPP if the security module does not know about attribute,
>> + *         or a negative error code to abort the copy up.
>>    */
>>   int security_inode_copy_up_xattr(struct dentry *src, const char *name)
>>   {
>>   	int rc;
>>   
>>   	/*
>> -	 * The implementation can return 0 (accept the xattr), 1 (discard the
>> -	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
>> -	 * any other error code in case of an error.
>> +	 * The implementation can return 0 (accept the xattr), -ECANCELED
>> +	 * (discard the xattr), -EOPNOTSUPP if it does not know anything
>> +	 *  about the xattr or any other error code in case of an error.
>>   	 */
> 
> Updating the comment here is good, but considering that we also discuss
> the return value in the function header comment, I think it might be
> better to just remove this comment entirely and leave the function header
> comment as the single source.  Duplicated comments/docs tend to fall out
> of sync and create confusion.
>

OK, will do

>>   	rc = call_int_hook(inode_copy_up_xattr, src, name);
>>   	if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
> 
> 
> --
> paul-moore.com
> 


