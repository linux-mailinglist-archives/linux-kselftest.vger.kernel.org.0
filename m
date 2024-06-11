Return-Path: <linux-kselftest+bounces-11634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF0902E4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C665E1C2128D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FC15A87A;
	Tue, 11 Jun 2024 02:25:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480F159917;
	Tue, 11 Jun 2024 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072709; cv=none; b=AwdY0pJwjzgAktSnHKm/zfW9ZN0pds5MN2T54Ozzd5559sdgFtuDYU8mNoxq3OvQTyhpGF4WFrMf7+2eD2vhVQKGQ+R1UWxI7xw4W9zmtTgCH0/kafTrVB9zR0X/pL/B/V5rttS2JciKSWEpBoLgemLVT3uKyuIa9iWF0qF5CRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072709; c=relaxed/simple;
	bh=GfjNm/ci4r3MXpxjHkAJnioZR0HjcTwermokN5o2m/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvrJVoyAaCPdusEuMvZ+UujcS1dPPB5Zw48RcgvWPW4p/02oHqq0GCPjKnSHvf/B5KKwJ3xPi+xiIY/lSEHCbMSLSHxIjH/qPTshDXGvG4rxZNMGHM8PdD8FpTPG3ZoXzFDq6/4LdP/WIFxR3nNoiL1OTHdIsR4ZIlwjbG3CJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VysvQ13Z7z4f3jtj;
	Tue, 11 Jun 2024 10:24:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A4A021A0C0D;
	Tue, 11 Jun 2024 10:24:56 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgBngAl3tWdmB8WZPA--.32049S2;
	Tue, 11 Jun 2024 10:24:56 +0800 (CST)
Message-ID: <61e96101-caf7-456d-a125-13dfe33ca080@huaweicloud.com>
Date: Tue, 11 Jun 2024 10:24:54 +0800
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
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
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
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-2-xukuohai@huaweicloud.com>
 <CAHC9VhRipBNd+G=RMPVeVOiYCx6FZwHSn0JNKv=+jYZtd5SdYg@mail.gmail.com>
 <b4484882-0de5-4515-8c40-41891ac4b21e@huaweicloud.com>
 <CAADnVQJfU-qMYHGSggfPwmpSy+QrCvQHPrxmei=UU6zzR2R+Sw@mail.gmail.com>
 <571e5244-367e-45a0-8147-1acbd5a1de6f@schaufler-ca.com>
 <CAHC9VhQ_sTmoXwQ_AVfjTYQe4KR-uTnksPVfsei5JZ+VDJBQkA@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAHC9VhQ_sTmoXwQ_AVfjTYQe4KR-uTnksPVfsei5JZ+VDJBQkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBngAl3tWdmB8WZPA--.32049S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1xKFy3ZrWfuFW8tw13Jwb_yoW3XryrpF
	s8Ca43KF4vyFy3Arn2ya15XaySyrW3Jr42qr1Utw1jy3ZYqrn2qF43tr4Y9FWrCry8t34j
	vF4jvayfuwn8Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 6/10/2024 2:17 AM, Paul Moore wrote:
> On Sun, Jun 9, 2024 at 1:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 6/8/2024 6:54 AM, Alexei Starovoitov wrote:
>>> On Sat, Jun 8, 2024 at 1:04 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>> On 6/7/2024 5:53 AM, Paul Moore wrote:
>>>>> On Thu, Apr 11, 2024 at 8:24 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>>>
>>>>>> Add macro LSM_RET_INT to annotate lsm hook return integer type and the
>>>>>> default return value, and the expected return range.
>>>>>>
>>>>>> The LSM_RET_INT is declared as:
>>>>>>
>>>>>> LSM_RET_INT(defval, min, max)
>>>>>>
>>>>>> where
>>>>>>
>>>>>> - defval is the default return value
>>>>>>
>>>>>> - min and max indicate the expected return range is [min, max]
>>>>>>
>>>>>> The return value range for each lsm hook is taken from the description
>>>>>> in security/security.c.
>>>>>>
>>>>>> The expanded result of LSM_RET_INT is not changed, and the compiled
>>>>>> product is not changed.
>>>>>>
>>>>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>>>>> ---
>>>>>>    include/linux/lsm_hook_defs.h | 591 +++++++++++++++++-----------------
>>>>>>    include/linux/lsm_hooks.h     |   6 -
>>>>>>    kernel/bpf/bpf_lsm.c          |  10 +
>>>>>>    security/security.c           |   1 +
>>>>>>    4 files changed, 313 insertions(+), 295 deletions(-)
>>>>> ...
>>>>>
>>>>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>>>>>> index 334e00efbde4..708f515ffbf3 100644
>>>>>> --- a/include/linux/lsm_hook_defs.h
>>>>>> +++ b/include/linux/lsm_hook_defs.h
>>>>>> @@ -18,435 +18,448 @@
>>>>>>     * The macro LSM_HOOK is used to define the data structures required by
>>>>>>     * the LSM framework using the pattern:
>>>>>>     *
>>>>>> - *     LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
>>>>>> + *     LSM_HOOK(<return_type>, <return_description>, <hook_name>, args...)
>>>>>>     *
>>>>>>     * struct security_hook_heads {
>>>>>> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
>>>>>> + *   #define LSM_HOOK(RET, RETVAL_DESC, NAME, ...) struct hlist_head NAME;
>>>>>>     *   #include <linux/lsm_hook_defs.h>
>>>>>>     *   #undef LSM_HOOK
>>>>>>     * };
>>>>>>     */
>>>>>> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
>>>>>> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
>>>>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_set_context_mgr, const struct cred *mgr)
>>>>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transaction, const struct cred *from,
>>>>>>            const struct cred *to)
>>>>>> -LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
>>>>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_binder, const struct cred *from,
>>>>>>            const struct cred *to)
>>>>>> -LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
>>>>>> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_file, const struct cred *from,
>>>>>>            const struct cred *to, const struct file *file)
>>>>> I'm not overly excited about injecting these additional return value
>>>>> range annotations into the LSM hook definitions, especially since the
>>>>> vast majority of the hooks "returns 0 on success, negative values on
>>>>> error".  I'd rather see some effort put into looking at the
>>>>> feasibility of converting some (all?) of the LSM hook return value
>>>>> exceptions into the more conventional 0/-ERRNO format.  Unfortunately,
>>>>> I haven't had the time to look into that myself, but if you wanted to
>>>>> do that I think it would be a good thing.
>>>>>
>>>> I agree that keeping all hooks return a consistent range of 0/-ERRNO
>>>> is more elegant than adding return value range annotations. However, there
>>>> are two issues that might need to be addressed first:
>>>>
>>>> 1. Compatibility
>>>>
>>>> For instance, security_vm_enough_memory_mm() determines whether to
>>>> set cap_sys_admin by checking if the hook vm_enough_memory returns
>>>> a positive number. If we were to change the hook vm_enough_memory
>>>> to return 0 to indicate the need for cap_sys_admin, then for the
>>>> LSM BPF program currently returning 0, the interpretation of its
>>>> return value would be reversed after the modification.
>>>
>>> This is not an issue. bpf lsm progs are no different from other lsm-s.
>>> If the meaning of return value or arguments to lsm hook change
>>> all lsm-s need to adjust as well. Regardless of whether they are
>>> written as in-kernel lsm-s, bpf-lsm, or out-of-tree lsm-s.
> 
> Yes, the are no guarantees around compatibility in kernel/LSM
> interface from one kernel release to the next.  If we need to change a
> LSM hook, we can change a LSM hook; the important part is that when we
> change the LSM hook we must make sure to update all of the in-tree
> LSMs which make use of that hook.
>

Great, so there are no compatibility restrictions on both LSM and BPF
sides.

>>>> 2. Expressing multiple non-error states using 0/-ERRNO
>>>>
>>>> IIUC, although 0/-ERRNO can be used to express different errors,
>>>> only 0 can be used for non-error state. If there are multiple
>>>> non-error states, they cannot be distinguished. For example,
>>>> security_inode_need_killpriv() returns < 0 on error, 0 if
>>>> security_inode_killpriv() doesn't need to be called, and > 0
>>>> if security_inode_killpriv() does need to be called.
>>> This looks like a problem indeed.
>>
>> Hang on. There aren't really three states here. security_inode_killpriv()
>> is called only on the security_inode_need_killpriv() > 0 case. I'm not
>> looking at the code this instant, but adjusting the return to something
>> like -ENOSYS (OK, maybe not a great choice, but you get the idea) instead
>> of 0 in the don't call case and switching the positive value to 0 should
>> work just fine.
>>
>> We're working on getting the LSM interfaces to be more consistent. This
>> particular pair of hooks is an example of why we need to do that.
> 
> Yes, exactly.  Aside from the issues with BPF verification, we've seen
> problems in the past with LSM hooks that differ from the usual "0 on
> success, negative values on failure" pattern.  I'm not saying it is
> possible to convert all of the hooks to fit this model, but even if we
> can only adjust one or two I think that is still a win.
> 
> As far as security_inode_need_killpriv()/security_inode_killpriv() is
> concerned, one possibility would be to shift the ATTR_KILL_PRIV
> set/mask operation into the LSM hook, something like this:
> 
> [WARNING: completely untested, likely broken, yadda yadda]
> 
> /**
>   * ...
>   * Returns: Return 0 on success, negative values on failure.  @attrs
> may be updated
>   *          on success.
>   */
> int security_inode_need_killpriv(*dentry, attrs)
> {
>    int rc;
>    rc = call_int_hook(inode_killpriv, dentry);
>    if (rc < 0)
>      return rc;
>    if (rc > 0)
>      attrs |= ATTR_KILL_PRIV;
>    else if (rc == 0)
>      attrs &= ~ATTR_KILL_PRIV;
>    return 0;
> }
> 
> Yes, that doesn't fix the problem for the individual LSMs, but it does
> make the hook a bit more consistent from the rest of the kernel.
>

Alright, I'll give it a try. Perhaps in the end, there will be a few
hooks that cannot be converted. If that's the case, it seems we can
just provide exceptions for the return value explanations for these
not unconverted hooks, maybe on the BPF side only, thus avoiding the
need to annotate return values for all LSM hooks.


