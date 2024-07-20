Return-Path: <linux-kselftest+bounces-13953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38039938046
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAC8281DF1
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 09:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A7B5B68F;
	Sat, 20 Jul 2024 09:29:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C391B86FD;
	Sat, 20 Jul 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467756; cv=none; b=Sjl/ja+1OQhKwqcKna1SwHzFQ2BeqgTXJP5NScDsQOWwKRElDHwaUu0Rji/44jTvzMuhcDL0p125FqW9kyr4JPBLIqZ2lh4PqHhSHbJglX/ncRaRx+rLxPY/oqShD9G7w3WBa6M0pxlZ+ffMcfkHiVrutVRTaeDRCI9S15LnyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467756; c=relaxed/simple;
	bh=ak9ER4pnPZjMjYJKTIPruZ+eUruZuIcIlSv775hklQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5IilOYyeh7Q66C5ADzgZ7nXrssXPYXe5+4EcwGj3fyqkbpyM4nhUDkU53Clv4p+5lkRapt4CQDq4Ex+fql7ZO2r6RWM91+teUsmtnahkZnnOuxPCgucaBDwdHbsQDmyW7Mh3pojI2G765hcVvSbs68wYnMNcmtloCfbx8CGTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WR1St6SsHz4f3jks;
	Sat, 20 Jul 2024 17:29:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 034891A018B;
	Sat, 20 Jul 2024 17:29:11 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgCHc3VOg5tmPCSIAg--.40166S3;
	Sat, 20 Jul 2024 17:29:10 +0800 (CST)
Message-ID: <c6ece90a-a9bd-4a77-960a-a9c8e44dd564@huaweicloud.com>
Date: Sat, 20 Jul 2024 17:29:10 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/20] lsm: Refactor return value of LSM hook
 inode_listsecurity
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
References: <20240711111908.3817636-5-xukuohai@huaweicloud.com>
 <4334eeb3a58ec81c5148d47db5c83765@paul-moore.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <4334eeb3a58ec81c5148d47db5c83765@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHc3VOg5tmPCSIAg--.40166S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1rGrW5Kw4xAw1UWw17Jrb_yoW3GF4rpF
	45tF45JFn5tFyxWr1xtFnxu3WS9a95Wr1UGrW3G3W3AFn8Arn2qF10kryY9FyrAr18Cr1v
	qanrursxCw4qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Wr
	v_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0Q4
	S7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/19/2024 10:08 AM, Paul Moore wrote:
> On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> To be consistent with most LSM hooks, convert the return value of
>> hook inode_listsecurity to 0 or a negative error code.
>>
>> Before:
>> - Hook inode_listsecurity returns number of bytes used/required on
>>    success or a negative error code on failure.
>>
>> After:
>> - Hook inode_listsecurity returns 0 on success or a negative error
>>    code on failure. An output parameter @bytes is introduced to hold
>>    the number of bytes used/required on success.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   fs/nfs/nfs4proc.c             |  5 ++++-
>>   fs/xattr.c                    |  5 ++++-
>>   include/linux/lsm_hook_defs.h |  2 +-
>>   include/linux/security.h      |  7 ++++---
>>   net/socket.c                  |  9 +++++----
>>   security/security.c           | 29 +++++++++++++++++++++++++----
>>   security/selinux/hooks.c      |  8 +++++---
>>   security/smack/smack_lsm.c    |  6 ++++--
>>   8 files changed, 52 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index a691fa10b3e9..6d75758ba3d5 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -7848,10 +7848,13 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
>>   static ssize_t
>>   nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
>>   {
>> +	size_t bytes;
>>   	int len = 0;
>>   
>>   	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
>> -		len = security_inode_listsecurity(inode, list, list_len);
>> +		len = security_inode_listsecurity(inode, list, list_len, &bytes);
>> +		if (!len)
>> +			len = bytes;
>>   		if (len >= 0 && list_len && len > list_len)
>>   			return -ERANGE;
>>   	}
> 
> See my comments below.
> 
>> diff --git a/fs/xattr.c b/fs/xattr.c
>> index f4e3bedf7272..ab7d7123a016 100644
>> --- a/fs/xattr.c
>> +++ b/fs/xattr.c
>> @@ -485,6 +485,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
>>   {
>>   	struct inode *inode = d_inode(dentry);
>>   	ssize_t error;
>> +	size_t bytes;
>>   
>>   	error = security_inode_listxattr(dentry);
>>   	if (error)
>> @@ -493,7 +494,9 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
>>   	if (inode->i_op->listxattr) {
>>   		error = inode->i_op->listxattr(dentry, list, size);
>>   	} else {
>> -		error = security_inode_listsecurity(inode, list, size);
>> +		error = security_inode_listsecurity(inode, list, size, &bytes);
>> +		if (!error)
>> +			error = bytes;
>>   		if (size && error > size)
>>   			error = -ERANGE;
> 
> More on this below, but since the buffer length is fixed we are
> already going to have to do a length comparison in the LSMs, why not
> do the check and return -ERANGE there?
>

Sounds great, thanks

>> diff --git a/net/socket.c b/net/socket.c
>> index e416920e9399..43f0e3c9a6e0 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -571,12 +571,13 @@ static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
>>   static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
>>   				size_t size)
>>   {
>> -	ssize_t len;
>> +	int err;
>> +	size_t len;
>>   	ssize_t used = 0;
>>   
>> -	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
>> -	if (len < 0)
>> -		return len;
>> +	err = security_inode_listsecurity(d_inode(dentry), buffer, size, &len);
>> +	if (err < 0)
>> +		return err;
>>   	used += len;
>>   	if (buffer) {
>>   		if (size < used)
> 
> It doesn't show in the patch/diff, but if the LSM hook handles the length
> comparison we can simplify the -ERANGE code in sockfs_listxattr().
>

Will do

>> diff --git a/security/security.c b/security/security.c
>> index 614f14cbfff7..26eea8f4cd74 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2597,20 +2597,41 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
>>    * @inode: inode
>>    * @buffer: buffer
>>    * @buffer_size: size of buffer
>> + * @bytes: number of bytes used/required
>>    *
>>    * Copy the extended attribute names for the security labels associated with
>>    * @inode into @buffer.  The maximum size of @buffer is specified by
>>    * @buffer_size.  @buffer may be NULL to request the size of the buffer
>>    * required.
>>    *
>> - * Return: Returns number of bytes used/required on success.
>> + * Return: Returns 0 on success or a negative error code on failure.
>>    */
>>   int security_inode_listsecurity(struct inode *inode,
>> -				char *buffer, size_t buffer_size)
>> +				char *buffer, size_t buffer_size,
>> +				size_t *bytes)
>>   {
>> +	int rc;
>> +	size_t used;
>> +	struct security_hook_list *hp;
>> +
>>   	if (unlikely(IS_PRIVATE(inode)))
>> -		return 0;
>> -	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
>> +		return *bytes = 0;
>> +
>> +	used = 0;
>> +	hlist_for_each_entry(hp, &security_hook_heads.inode_listsecurity,
>> +			     list) {
>> +		rc = hp->hook.inode_listsecurity(inode, buffer, buffer_size,
>> +						 &used);
>> +		if (rc < 0)
>> +			return rc;
>> +		if (used != 0)
>> +			break;
>> +	}
>> +
>> +	*bytes = used;
>> +
>> +	return 0;
>> +
>>   }
>>   EXPORT_SYMBOL(security_inode_listsecurity);
> 
> For reasons associated with the static_call work, we really need to
> limit ourselves to the call_{int,void}_hook() macros on any new code.
> The good news is that I think we can do that here as the existing
> code isn't multi-LSM friendly.
>

Thanks for pointing that out. Good to know the current code is acceptable.

>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 70792bba24d9..5dedd3917d57 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -3481,16 +3481,18 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>>   	return 0;
>>   }
>>   
>> -static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
>> +static int selinux_inode_listsecurity(struct inode *inode, char *buffer,
>> +				      size_t buffer_size, size_t *bytes)
>>   {
>>   	const int len = sizeof(XATTR_NAME_SELINUX);
>>   
>>   	if (!selinux_initialized())
>> -		return 0;
>> +		return *bytes = 0;
>>   
>>   	if (buffer && len <= buffer_size)
>>   		memcpy(buffer, XATTR_NAME_SELINUX, len);
>> -	return len;
>> +	*bytes = len;
>> +	return 0;
>>   }
> 
> Let's do something like below so we can catch -ERANGE in the LSMs
> themselves.
> 
>    if (!selinux_initialized())
>      return *bytes = 0;
> 
>    *bytes = sizeof(XATTR_NAME_SELINUX);
>    if (len > buffer_size);
>      return -ERANGE;
>    if (buffer)
>      memcpy(buffer, XATTR_NAME_SELINUX, *bytes);
>    
>    return 0;
>

Will do

>>   static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index e7a5f6fd9a2d..6f73906bf7ea 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -1611,16 +1611,18 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
>>    * @inode: the object
>>    * @buffer: where they go
>>    * @buffer_size: size of buffer
>> + * @bytes: number of data bytes in buffer
>>    */
>>   static int smack_inode_listsecurity(struct inode *inode, char *buffer,
>> -				    size_t buffer_size)
>> +				    size_t buffer_size, size_t *bytes)
>>   {
>>   	int len = sizeof(XATTR_NAME_SMACK);
>>   
>>   	if (buffer != NULL && len <= buffer_size)
>>   		memcpy(buffer, XATTR_NAME_SMACK, len);
>>   
>> -	return len;
>> +	*bytes = len;
>> +	return 0;
>>   }
> 
> A similar approach could be used here.
>

Will do

> --
> paul-moore.com
> 


