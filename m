Return-Path: <linux-kselftest+bounces-13958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B4938070
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE540B218C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9416B824AD;
	Sat, 20 Jul 2024 09:31:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2177F0B;
	Sat, 20 Jul 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467880; cv=none; b=DOL405mnuzMCQ7CQqLyo+BTp1nbDppQ1keEblUTdO/klC36Y0GRT0zBfebgfe2bFlvuD0DhhccJ/LkvjX7IADNlvQsR2TETGr4+XZY06iYQEXPO/teuI2qHfTxjgCbtP6MHs7Dpkw4Au6UxlZ1GeTzLItnEALvyQuzxPb9EoTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467880; c=relaxed/simple;
	bh=7PWEQTYxhogM6IgP3ksdy2Z/KztokESB0EPMoigzjhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8GV31UB1GLODmk02+gHx1nuQ9oI12tvS+NB3Yz1Zm0INrE3HuNGlekgo5ufdRXS4us7G1TDo/rZhBZG9OktfhGURg82nDwYtaKUeekB0HY4Vtr+rBGeNrVnEBe7BiFfgaazNAZoPJ+f4gLvxW0B8S/QIQCBS3yGxF04OhGJo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WR1WC3Jk5z4f3jrg;
	Sat, 20 Jul 2024 17:31:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A2A8E1A0184;
	Sat, 20 Jul 2024 17:31:15 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgBHdzW5g5tmfxqfAg--.54511S4;
	Sat, 20 Jul 2024 17:31:15 +0800 (CST)
Message-ID: <6a47ad68-2c14-4061-92ae-a68b26a9e7bd@huaweicloud.com>
Date: Sat, 20 Jul 2024 17:31:14 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/20] lsm: Refactor return value of LSM hook
 audit_rule_match
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
 apparmor@lists.ubuntu.com, selinux@vger.kernel.org
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
References: <20240711111908.3817636-11-xukuohai@huaweicloud.com>
 <36836e7b94465fd11d3425166ade3f54@paul-moore.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <36836e7b94465fd11d3425166ade3f54@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHdzW5g5tmfxqfAg--.54511S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tryDKw13uF18Wry5Zw4DXFb_yoW8Zr1fpF
	sxKana9rykCFyfurn3Z34293yYkr4fWF15Jry3Kr10kryFyF1UGr1DGw109rWDurWfAw4U
	tr47Xrn5GryDZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
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
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0Ki
	iDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/19/2024 10:08 AM, Paul Moore wrote:
> On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> To be consistent with most LSM hooks, convert the return value of
>> hook audit_rule_match to 0 or a negative error code.
>>
>> Before:
>> - Hook audit_rule_match returns 1 if the rule matches, 0 if it not,
>>    and negative error code otherwise.
>>
>> After:
>> - Hook audit_rule_match returns 0 on success or a negative error
>>    code on failure. An output parameter @match is introduced to hold
>>    the match result on success.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   include/linux/lsm_hook_defs.h     |  3 +-
>>   security/apparmor/audit.c         | 22 ++++++-------
>>   security/apparmor/include/audit.h |  2 +-
>>   security/security.c               | 15 ++++++++-
>>   security/selinux/include/audit.h  |  8 +++--
>>   security/selinux/ss/services.c    | 54 +++++++++++++++++--------------
>>   security/smack/smack_lsm.c        | 19 +++++++----
>>   7 files changed, 75 insertions(+), 48 deletions(-)
> 
> This is another odd hook, and similar to some of the others in this
> patchset, I'm not sure how applicable this would be to a BPF-based
> LSM.  I suspect you could safely block this from a BPF LSM and no one
> would notice or be upset.
> 
> However, if we did want to keep this hook for a BPF LSM, I think it
> might be better to encode the "match" results in the return value, just
> sticking with a more conventional 0/errno approach.  What do you think
> about 0:found/ok, -ENOENT:missing/ok, -ERRNO:other/error?  Yes, some
> of the existing LSM audit_match code uses -ENOENT but looking quickly
> at those error conditions it seems that we could consider them
> equivalent to a "missing" or "failed match" result and use -ENOENT for
> both.  If you're really not happy with that overloading, we could use
> something like -ENOMSG:missing/ok instead.
> 
> Thoughts?
>

I think we could just block it and see what happens.

> --
> paul-moore.com
> 


