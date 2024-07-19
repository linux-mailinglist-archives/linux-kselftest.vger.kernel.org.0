Return-Path: <linux-kselftest+bounces-13922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B889372DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 05:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299E21C209BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 03:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10222F03;
	Fri, 19 Jul 2024 03:55:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB861CA9C;
	Fri, 19 Jul 2024 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721361317; cv=none; b=RYYOhjYqHKGtV20udwWbdr4RRuO/SWeUS6a8/Db58ClbIfVuBSPHOH302HSW7LItkdCxm2uOngagMrn/oqThe1wgldrK6MQPHAcR18476tIr9kzW/LwxvezFY5SulYtxT5NY7TrGU1htjiZmRegj1TwizyrOyw3/U/J3MqGbpJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721361317; c=relaxed/simple;
	bh=fW8/WzUf0yz2wtXEazJsmpLA4rjJNjXElI6NFimQILg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJksrsm7/zMmiP1WdkSq//x2I9prryzWzfePaCdS7fz3AA9uRi+7lKbqh5ka53FIjdNHXJVO+ljM6G516+EFS9dmXI7NgGr6I30NkMkXmcBLTq6Zr4Vath4imnvEUR1IxlUWv/C9j8HayhvtlEfb9IbV8cdFdOoRESzDb/utzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WQG5t096Jz4f3jXK;
	Fri, 19 Jul 2024 11:54:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2597E1A016E;
	Fri, 19 Jul 2024 11:55:10 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgAXdg2c45lmTyMoAg--.18262S2;
	Fri, 19 Jul 2024 11:55:09 +0800 (CST)
Message-ID: <1e38e8dc-16fe-497a-bdc3-33fdc1ffa1a7@huaweicloud.com>
Date: Fri, 19 Jul 2024 11:55:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 00/20] Add return value range check for BPF
 LSM
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
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
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
 <CAHC9VhRohF+36PQbbEUiiiXjnmx-ZCphjOiAV5VTQwCejuejMA@mail.gmail.com>
 <CAHC9VhQ-NAfLahQ-eomBrjBUT9t3s6OSzzE4nRLy=fj2AmJVqA@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAHC9VhQ-NAfLahQ-eomBrjBUT9t3s6OSzzE4nRLy=fj2AmJVqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXdg2c45lmTyMoAg--.18262S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw1rCryxtFWfWr43ArW3Awb_yoWxXrWDpF
	45JFy8Kr4kXr1UJr1xtF1DJry2yr93AF1UXryvqr95A3Wfurn8Jw1rtrW2grnxJw4rAr17
	tFZ0qanYyF98JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 7/19/2024 10:13 AM, Paul Moore wrote:
> On Fri, Jul 12, 2024 at 5:44 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Jul 11, 2024 at 7:13 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> LSM BPF prog returning a positive number attached to the hook
>>> file_alloc_security makes kernel panic.
>>>
>>> Here is a panic log:
>>>
>>> [  441.235774] BUG: kernel NULL pointer dereference, address: 00000000000009
>>> [  441.236748] #PF: supervisor write access in kernel mode
>>> [  441.237429] #PF: error_code(0x0002) - not-present page
>>> [  441.238119] PGD 800000000b02f067 P4D 800000000b02f067 PUD b031067 PMD 0
>>> [  441.238990] Oops: 0002 [#1] PREEMPT SMP PTI
>>> [  441.239546] CPU: 0 PID: 347 Comm: loader Not tainted 6.8.0-rc6-gafe0cbf23373 #22
>>> [  441.240496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b4
>>> [  441.241933] RIP: 0010:alloc_file+0x4b/0x190
>>> [  441.242485] Code: 8b 04 25 c0 3c 1f 00 48 8b b0 30 0c 00 00 e8 9c fe ff ff 48 3d 00 f0 ff fb
>>> [  441.244820] RSP: 0018:ffffc90000c67c40 EFLAGS: 00010203
>>> [  441.245484] RAX: ffff888006a891a0 RBX: ffffffff8223bd00 RCX: 0000000035b08000
>>> [  441.246391] RDX: ffff88800b95f7b0 RSI: 00000000001fc110 RDI: f089cd0b8088ffff
>>> [  441.247294] RBP: ffffc90000c67c58 R08: 0000000000000001 R09: 0000000000000001
>>> [  441.248209] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
>>> [  441.249108] R13: ffffc90000c67c78 R14: ffffffff8223bd00 R15: fffffffffffffff4
>>> [  441.250007] FS:  00000000005f3300(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
>>> [  441.251053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  441.251788] CR2: 00000000000001a9 CR3: 000000000bdc4003 CR4: 0000000000170ef0
>>> [  441.252688] Call Trace:
>>> [  441.253011]  <TASK>
>>> [  441.253296]  ? __die+0x24/0x70
>>> [  441.253702]  ? page_fault_oops+0x15b/0x480
>>> [  441.254236]  ? fixup_exception+0x26/0x330
>>> [  441.254750]  ? exc_page_fault+0x6d/0x1c0
>>> [  441.255257]  ? asm_exc_page_fault+0x26/0x30
>>> [  441.255792]  ? alloc_file+0x4b/0x190
>>> [  441.256257]  alloc_file_pseudo+0x9f/0xf0
>>> [  441.256760]  __anon_inode_getfile+0x87/0x190
>>> [  441.257311]  ? lock_release+0x14e/0x3f0
>>> [  441.257808]  bpf_link_prime+0xe8/0x1d0
>>> [  441.258315]  bpf_tracing_prog_attach+0x311/0x570
>>> [  441.258916]  ? __pfx_bpf_lsm_file_alloc_security+0x10/0x10
>>> [  441.259605]  __sys_bpf+0x1bb7/0x2dc0
>>> [  441.260070]  __x64_sys_bpf+0x20/0x30
>>> [  441.260533]  do_syscall_64+0x72/0x140
>>> [  441.261004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>>> [  441.261643] RIP: 0033:0x4b0349
>>> [  441.262045] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 88
>>> [  441.264355] RSP: 002b:00007fff74daee38 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>>> [  441.265293] RAX: ffffffffffffffda RBX: 00007fff74daef30 RCX: 00000000004b0349
>>> [  441.266187] RDX: 0000000000000040 RSI: 00007fff74daee50 RDI: 000000000000001c
>>> [  441.267114] RBP: 000000000000001b R08: 00000000005ef820 R09: 0000000000000000
>>> [  441.268018] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
>>> [  441.268907] R13: 0000000000000004 R14: 00000000005ef018 R15: 00000000004004e8
>>>
>>> This is because the filesystem uses IS_ERR to check if the return value
>>> is an error code. If it is not, the filesystem takes the return value
>>> as a file pointer. Since the positive number returned by the BPF prog
>>> is not a real file pointer, this misinterpretation causes a panic.
>>>
>>> Since other LSM modules always return either a negative error code
>>> or a valid pointer, this specific issue only exists in BPF LSM. The
>>> proposed solution is to reject LSM BPF progs returning unexpected
>>> values in the verifier. This patch set adds return value check to
>>> ensure only BPF progs returning expected values are accepted.
>>>
>>> Since each LSM hook has different excepted return values, we need to
>>> know the expected return values for each individual hook to do the
>>> check. Earlier versions of the patch set used LSM hook annotations
>>> to specify the return value range for each hook. Based on Paul's
>>> suggestion, current version gets rid of such annotations and instead
>>> converts hook return values to a common pattern: return 0 on success
>>> and negative error code on failure.
>>>
>>> Basically, LSM hooks are divided into two types: hooks that return a
>>> negative error code and zero or other values, and hooks that do not
>>> return a negative error code. This patch set converts all hooks of the
>>> first type and part of the second type to return 0 on success and a
>>> negative error code on failure (see patches 1-10). For certain hooks,
>>> like ismaclabel and inode_xattr_skipcap, the hook name already imply
>>> that returning 0 or 1 is the best choice, so they are not converted.
>>> There are four unconverted hooks. Except for ismaclabel, which is not
>>> used by BPF LSM, the other three are specified with a BTF ID list to
>>> only return 0 or 1.
>>
>> Thank you for following up on your initial work with this patchset, Xu
>> Kuohai.  It doesn't look like I'm going to be able to finish my review
>> by the end of the day today, so expect that a bit later, but so far I
>> think most of the changes look good and provide a nice improvement :)
> 
> You should have my feedback now, let me know if you have any questions.
> 
> One additional comment I might make is that you may either want to
> wait until after v6.11-rc1 is released and I've had a chance to rebase
> the lsm/{dev,next} branches and merge the patchsets which are
> currently queued; there are a few patches queued up which will have an
> impact on this work.  While it's an unstable branch, you can take a
> peek at those queues patches in the lsm/dev-staging branch.
> 
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> 

Got it, thanks for your valuable time and feedback! The individual
comment will be replied once I'm sure I understand it or confirmed
the next step.

Additionally, for the next update, I'll split the series into two,
as the refactoring patches and the BPF patches are not closely
related.


