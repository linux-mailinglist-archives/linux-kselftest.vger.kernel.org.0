Return-Path: <linux-kselftest+bounces-13706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5C930471
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 10:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4A1B21C5E
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBB3210EE;
	Sat, 13 Jul 2024 08:07:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985628370;
	Sat, 13 Jul 2024 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720858034; cv=none; b=MfG8WkecSMidPvm3UBsCkt1Nq5SKKoMcTWeM916yNvt9EXblX2hEj1DlHzKRn56Q03jLlGCiQmxFQt48TcbsydObtPWzIk4vM73/rCJLWF27ZwaYuqrwCYkBvBBeRldV+Sz/YUijV148ueHmtxis4NTMcE/q7B/jTmdQMGrsMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720858034; c=relaxed/simple;
	bh=iAETAaKYSnikmgwmBFLVgRXqBhoCeHf62VduM6i8Zb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=so4N65Nw8LwxcQp7/yaI8sJXHX7v4C41ngM2Uz1Q4Xxj+wvfxBRGld74R81YR42/fguKJiqVbU78JsLjTGlem2pBHwOXv0kxGftCm7XRwYDamTE1y79HSpGNcIBFvd/2soGpw10HgDHvwRC0Bgjfi/88BretAJwuLQEj7YDLsQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WLgzF56GCz4f3jcj;
	Sat, 13 Jul 2024 16:06:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 78E751A0568;
	Sat, 13 Jul 2024 16:07:01 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgAnNF6jNZJmxmuLBw--.4019S2;
	Sat, 13 Jul 2024 16:07:00 +0800 (CST)
Message-ID: <4165f531-9d8a-4378-812f-41baa5665097@huaweicloud.com>
Date: Sat, 13 Jul 2024 16:06:59 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 02/20] lsm: Refactor return value of LSM hook
 inode_need_killpriv
To: Serge Hallyn <serge@hallyn.com>, Xu Kuohai <xukuohai@huaweicloud.com>
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
 James Morris <jmorris@namei.org>, Khadija Kamran
 <kamrankhadijadj@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>,
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
 <20240711111908.3817636-3-xukuohai@huaweicloud.com>
 <3b4cc9c0-2645-4654-aa48-7944d91ee3f4@hallyn.com>
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <3b4cc9c0-2645-4654-aa48-7944d91ee3f4@hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnNF6jNZJmxmuLBw--.4019S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1rtF1rJryUWFyxCF45ZFb_yoW8Gw18pF
	yakayY9w1kC34kua97KF17X3yvyrW3GrW5tFnYyrWjvF9xAr10kr4Sy3y7Kr1xWr109w1Y
	vr1vv3WfC3WUX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoj
	jgUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/11/2024 10:15 PM, Serge Hallyn wrote:
> Jul 11, 2024 06:14:09 Xu Kuohai <xukuohai@huaweicloud.com>:
> 
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> To be consistent with most LSM hooks, convert the return value of
>> hook inode_need_killpriv to 0 or a negative error code.
>>
>> Before:
>> - Both hook inode_need_killpriv and func security_inode_need_killpriv
>>    return > 0 if security_inode_killpriv is required, 0 if not, and < 0
>>    to abort the operation.
>>
>> After:
>> - Both hook inode_need_killpriv and func security_inode_need_killpriv
>>    return 0 on success and a negative error code on failure.
>>    On success, hook inode_need_killpriv sets output param @need to true
>>    if security_inode_killpriv is required, and false if not. When @need
>>    is true, func security_inode_need_killpriv sets ATTR_KILL_PRIV flag
>>    in @attr; when false, it clears the flag.
>>    On failure, @need and @attr remains unchanged.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> It looks ok - though unnecessary (I'm assuming a later patch works better with this) - , but I'd be more comfortable if it was documented that any callers of the need_killpriv hook must set need to false before calling. Or if the hooks set need to false at start.
> 
>

I believe this is the only patch in the set that modifies 'inode_need_killpriv'.
I'll add an explanation for the initial value of '@need'.
Thanks.


