Return-Path: <linux-kselftest+bounces-11512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFCE90174D
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 19:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADB41C208FC
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EBA482FF;
	Sun,  9 Jun 2024 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PP7l5vun"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7358481CD
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Jun 2024 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717954765; cv=none; b=GIOu16G35NibTe39Z9D7xhvok5oaEUDtkrf2X8YgDQXfrMnkEJrEtWpSxIvrQS/altjL+9ekZlBu2y8NVOTxtvWpmRjj4bI9rQ+C6XUit7sdsNTlgZ0jxfStnLN3gyNZ2AA4meIvDMkAnUQjA2mcVVc4GVy/lxDXFB6qvjSvY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717954765; c=relaxed/simple;
	bh=WtcOlU3lT7T0UfV56WLWVPOL0HZ6Hndj14wJ+gAc1Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRoG01PdBxusH32h+p9lVavGjwx+r55k8niFPO/PfgXnykKQisGoHd5F8YSeVzRILeyeWkbomuMTII4xz3HDYcn/Avu1SS2oScP89I4GCaVMzf/6ahe8R9j+CQnz+a8ynzJbb07ypmVoEBBbGAPDR/VvgzWf7Wd66prxovR6Wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PP7l5vun; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717954756; bh=ppUCW70evrkwRUKJY2kF8Vr2jyP3snB9PtrR8i8bOAI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PP7l5vunx08P/H27ZY2yIxQ4EEvIrH5N4isMIkwHb26FDvbMIb/MwWOWMK+lW6lMxHNdS4o/m0p/GbmjY53jFmR9Ic6MqSnZAnnyzfdOfrYyOoNqu5p1ujd8L3M/Lln861Vq7yU1j1iW3TgMSCF1vwS2+znOAkvM51O1EYWstZgNgI3WpCBnhqnMYFWq9vkkhvhiQuBqcLp5Ry6fUScyzQdm3TPSrqPgwUfV2icsl0ZfHVDjfhZAnQQnXREcSbMaTQeU+rXpbLDqzmLCKJ2CS9m0P3xXEx7nbCPAI4ZVxIuXWX5BJ1ti+0K71gRmSPXIehOxfvldtPYaWBoEr6CDNg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717954756; bh=glxSNiUD9PY6qqQScAb1/JtuMYdiPJCUWXKOQk+hq2j=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=P9e2UGgl5n920oBiZspe6NUYYfBxR1v7FVswknSkeNtx6rWKamMm+rOyCLIQz3NB+id13Ll05fGJFh5GWdxempMIHRCLZ2foIqu2KWEEB1YscNpqYjZMyc7QuuByrG6Idblv2aOBaQdlIKbnq9Plt/aure5hikX9c09U8ck5tZ/ulzxSNKc4lghp48FMzQaO/6sblZJKrWunlP8qCTfc6uCtC06pqDcCka1VJfrwTcexi5Hi9kKEnyIgkfBlx/tgbo6QQ7ZWbzyiP0nZaDPNdzb1+9xj2/Lo3VJTZf/PLyXf48q4/k4yujp2PMEoBCczAUvVl8DMFUYmKXzaYpoeEQ==
X-YMail-OSG: 8XR4DKYVM1kYAOIv9N_h5U97TZsAlx1NG2pQDQFk2LbW8L5zoQWVGMefyV3y_cJ
 JRPv1h1vDnfglUB9O6WtBFLPb.p158JWZdu.X6gYD0I6OhOn57gQJVdUVnqI3zCZDZDrRHlMLSbq
 GZY0UXRPoCF5fLlk.A4H_lf73LFs1Hg2uYhYu0So5ckWLkWvE2lx1eSQc.nog6TXogjcKakuA0oN
 gWikG8_rF_UR5RdtOL6AmHhfc60v.6BU9Aq6Rwr18rIlojRSFHqZCw8.WMPx0yPP8GYbNByRrX_3
 42loFwnjGOWd1iMmkN9TGLxrprQ4rEeIddLF4I8VnT80op7J8qu0Vk3tDyt.dRvCgGlDswSYlxSe
 lX7zzDBDwpi2K6fidKDKcCBoQfZJ1reynae0PLxco6MjbARSMCQ0ww9YyMwS5AyVg7qMBbNz4cM_
 bS1NgKAIkWyS30Ga1zEslS11NjIKQ3Fu4uCKqNeb0TSDhOjhBp7ZY28jtEyTXFDQehyTbie4RUZN
 yFUNCSvF.aFnz3.3G_cCNp0lhNg..lGD26jEp17DSdD3AQdcp2Zr5CurNtifd5ePZg.4nH6Nzv39
 jMA2Y.JVbJYlbggu2OKgZ44f3hT2b0fp9pD1cJ6N31zQhp9qNclJ7VgRY48sRl4.a9NLGmvRAhFS
 SsOnsjFWVRMT7kS3rqXLc3OtozWmMIsOBunhznKo3t_2f870fSNqVvsHY9DwnyLjwOBr30_M0X7H
 UvYg377FeCqIajknjtBVGnqm3FK1DgzocYZ_ZWrwKzpWIrQYJz0WgEVng2Hq7tLat.PZzAfRWuwR
 dCOBnO6JlxTMgXMU1tVE.kp_zx1olON8bbMHZeb7PGc1jG8f0pSdRQqFzcr916PW58p0jcToJQB7
 a1CYd5JTTnEPXmE4awNsQPwCspTLUm3tHEQ9eaWpzyBT4u8BPvNr0UEI.1hfFKqJjIOA8tb_Obg8
 Zr4yCrGgqihLAgn6BMhf2W7ANPV2YmaCvmLvEPJA0VYkoFWY2VaIpiTR0MhaYek8M7O636Kq3Hva
 AAqSNWW1yZ27HqfqpwTQdXuytVHwg_Z9L_OngFhnLqsOJDZUkCfOAurVY5VgaaYMEVI4lLC4y00A
 vBlR5k8M9_OeDU.ia_9Gl38xT34Bj8uBbyBDLXw7EqtanyXsn4ItRiHVdbLIqxceP55rNpmJj5Oj
 duo59VtBo8mrLVq1qo0Afz0QN10ZGQfJFdDEyFKTGVqQnWOJoqnHc30SJPuKjL9u4bVaTfTXvd2W
 uHsJnriEsWEuVAQXCGKqJowBlx88HHI_T7F3BhXvKg6sFL5LOFgnNWuFUT.FvJi2L0vIkAzLzgCu
 LH66XC43Kf.XY6zDEQ0MOnjTkEbsRHE8ZIemkjar_OIG6REBswOJvOyfKPC5J8W8aQ4QOFAluumC
 0D8buQlc5Cqibz0gzOZb1q4HyIoJiAcGKFE7uthmTJxRPXRNGvwC0.y3_8hTyVBSbG5Tn_kv0TeY
 uwx9WhhgLypXbyOGR68u9WUYTxN3mMKIxY0NJQ3cBnsNmpyyPGECmA81baNfnuCNAf6XBINIyY1H
 MFUQbU_2REfRariLwSmZJZKJpwKutIHm8H7yFo7tERHzwVTrizIJHUvrq5eif9bKjUStkmY17.MP
 hnTO35vNXvzd.ev5lY2vGy9dGSioRfktD2JcfRKY3X6zZa8EcF3pyjku4hbcQD7cDAmjV_s5m6oJ
 5D_IQCC_1C29JUtxiNPWvQEcbxsqmY2wD9biwg9ix_3kUlhvMIvWb1qKNFvdMMg_DqboaIezPi7q
 _VtmJI.ZKYMbhVKxTxW9GWxBhCaEpiZQOrqMTCq6VDjt0LY0AcpwYu18957q_vUj9gagwu6kHkRJ
 trMgjO.a62jv1PKKkpHvCesRLeAKXjEuJhatW1_bwuizpqdzfV.06.uEeWawm8099EzW.4l4jSmh
 myunShdUSpT.iEKEyhUPxHG8BcAuF6sNrAsMMtDUcjckWIaCDdS2qWZaMBBKEcvxgBKBOVn8thZc
 6Zi8G0Pzs40FWPSjH8ZK9ZBCCr7KnDeR_waUU1b37w24ZCiqQPhn1aHBs0EwwpW2BGVQGP5JxK4g
 qNpUX8BCywoTjs2Emb3qB.uVcEaoUfs3TtGaleA_lvlS8WXQjlBzGwdt9SqsWuWjhajCmiJhqXM.
 4vAtiLPkT9AVzL.z8lVWtz8v1.6XEa55VvqtcloY1V_rvPcOPgNK68NQS03ueNqBfnLGqFsXbhCC
 xb4eUR1_Uvc5myJqqJ3JyIzYlX_jNLR77BflinbMv6kysgYAdgIVaRr3_.xXASDo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 12d0376b-fd35-4153-ae54-1396c68eaff7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sun, 9 Jun 2024 17:39:16 +0000
Received: by hermes--production-gq1-59c575df44-xmm9l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9ea7126d3e636458f12b466243e622fa;
          Sun, 09 Jun 2024 17:39:11 +0000 (UTC)
Message-ID: <571e5244-367e-45a0-8147-1acbd5a1de6f@schaufler-ca.com>
Date: Sun, 9 Jun 2024 10:39:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 01/11] bpf, lsm: Annotate lsm hook return
 value range
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
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
 Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-2-xukuohai@huaweicloud.com>
 <CAHC9VhRipBNd+G=RMPVeVOiYCx6FZwHSn0JNKv=+jYZtd5SdYg@mail.gmail.com>
 <b4484882-0de5-4515-8c40-41891ac4b21e@huaweicloud.com>
 <CAADnVQJfU-qMYHGSggfPwmpSy+QrCvQHPrxmei=UU6zzR2R+Sw@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAADnVQJfU-qMYHGSggfPwmpSy+QrCvQHPrxmei=UU6zzR2R+Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/8/2024 6:54 AM, Alexei Starovoitov wrote:
> On Sat, Jun 8, 2024 at 1:04 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>> On 6/7/2024 5:53 AM, Paul Moore wrote:
>>> On Thu, Apr 11, 2024 at 8:24 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>
>>>> Add macro LSM_RET_INT to annotate lsm hook return integer type and the
>>>> default return value, and the expected return range.
>>>>
>>>> The LSM_RET_INT is declared as:
>>>>
>>>> LSM_RET_INT(defval, min, max)
>>>>
>>>> where
>>>>
>>>> - defval is the default return value
>>>>
>>>> - min and max indicate the expected return range is [min, max]
>>>>
>>>> The return value range for each lsm hook is taken from the description
>>>> in security/security.c.
>>>>
>>>> The expanded result of LSM_RET_INT is not changed, and the compiled
>>>> product is not changed.
>>>>
>>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>>> ---
>>>>   include/linux/lsm_hook_defs.h | 591 +++++++++++++++++-----------------
>>>>   include/linux/lsm_hooks.h     |   6 -
>>>>   kernel/bpf/bpf_lsm.c          |  10 +
>>>>   security/security.c           |   1 +
>>>>   4 files changed, 313 insertions(+), 295 deletions(-)
>>> ...
>>>
>>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>>>> index 334e00efbde4..708f515ffbf3 100644
>>>> --- a/include/linux/lsm_hook_defs.h
>>>> +++ b/include/linux/lsm_hook_defs.h
>>>> @@ -18,435 +18,448 @@
>>>>    * The macro LSM_HOOK is used to define the data structures required by
>>>>    * the LSM framework using the pattern:
>>>>    *
>>>> - *     LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
>>>> + *     LSM_HOOK(<return_type>, <return_description>, <hook_name>, args...)
>>>>    *
>>>>    * struct security_hook_heads {
>>>> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
>>>> + *   #define LSM_HOOK(RET, RETVAL_DESC, NAME, ...) struct hlist_head NAME;
>>>>    *   #include <linux/lsm_hook_defs.h>
>>>>    *   #undef LSM_HOOK
>>>>    * };
>>>>    */
>>>> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
>>>> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
>>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_set_context_mgr, const struct cred *mgr)
>>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transaction, const struct cred *from,
>>>>           const struct cred *to)
>>>> -LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
>>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_binder, const struct cred *from,
>>>>           const struct cred *to)
>>>> -LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
>>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_file, const struct cred *from,
>>>>           const struct cred *to, const struct file *file)
>>> I'm not overly excited about injecting these additional return value
>>> range annotations into the LSM hook definitions, especially since the
>>> vast majority of the hooks "returns 0 on success, negative values on
>>> error".  I'd rather see some effort put into looking at the
>>> feasibility of converting some (all?) of the LSM hook return value
>>> exceptions into the more conventional 0/-ERRNO format.  Unfortunately,
>>> I haven't had the time to look into that myself, but if you wanted to
>>> do that I think it would be a good thing.
>>>
>> I agree that keeping all hooks return a consistent range of 0/-ERRNO
>> is more elegant than adding return value range annotations. However, there
>> are two issues that might need to be addressed first:
>>
>> 1. Compatibility
>>
>> For instance, security_vm_enough_memory_mm() determines whether to
>> set cap_sys_admin by checking if the hook vm_enough_memory returns
>> a positive number. If we were to change the hook vm_enough_memory
>> to return 0 to indicate the need for cap_sys_admin, then for the
>> LSM BPF program currently returning 0, the interpretation of its
>> return value would be reversed after the modification.
> This is not an issue. bpf lsm progs are no different from other lsm-s.
> If the meaning of return value or arguments to lsm hook change
> all lsm-s need to adjust as well. Regardless of whether they are
> written as in-kernel lsm-s, bpf-lsm, or out-of-tree lsm-s.
>
>> 2. Expressing multiple non-error states using 0/-ERRNO
>>
>> IIUC, although 0/-ERRNO can be used to express different errors,
>> only 0 can be used for non-error state. If there are multiple
>> non-error states, they cannot be distinguished. For example,
>> security_inode_need_killpriv() returns < 0 on error, 0 if
>> security_inode_killpriv() doesn't need to be called, and > 0
>> if security_inode_killpriv() does need to be called.
> This looks like a problem indeed.

Hang on. There aren't really three states here. security_inode_killpriv()
is called only on the security_inode_need_killpriv() > 0 case. I'm not
looking at the code this instant, but adjusting the return to something
like -ENOSYS (OK, maybe not a great choice, but you get the idea) instead
of 0 in the don't call case and switching the positive value to 0 should
work just fine.

We're working on getting the LSM interfaces to be more consistent. This
particular pair of hooks is an example of why we need to do that. 

>  Converting all hooks to 0/-errno
> doesn't look practical.
>

