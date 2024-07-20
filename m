Return-Path: <linux-kselftest+bounces-13955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50435938055
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF80282B22
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 09:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B174079;
	Sat, 20 Jul 2024 09:30:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B462E62B;
	Sat, 20 Jul 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467814; cv=none; b=I9X383AqR3JnSA7NfHYUXF7GPlaWlq77bh/U8K6W8QoNsPXfMWaDjk7bbzlZ8htjTd7MhUtmUXANwgghMi23WX1NCEFYWID1zF33fHY7uCsjG1Zy9kE7/bvVm6gLo0d2c8tDGrm8amnuEDiQ16laru0Fp8WFhKhG6a3FF+KugPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467814; c=relaxed/simple;
	bh=vaPk98FKiT6+DjJv2mYeSusUwjvOO5yghYlf6m+IbaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F6VxEHl7Qj/Zu9r6BZhlhL5O3JB95uo2/jf6XO659OEU5zcPlAhraVU7SIOHeSW615eykUre0AXroiyTp1WlL7kJ7tCGukkoHlOZyzavv7y0df2M20NwINrKvEZDyCfgN383NEP2qgkWwfVe0OmoV4833E2koLQFkvKB5bTXWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WR1S52DBzzdjX4;
	Sat, 20 Jul 2024 17:28:21 +0800 (CST)
Received: from kwepemd100012.china.huawei.com (unknown [7.221.188.214])
	by mail.maildlp.com (Postfix) with ESMTPS id 7244014037E;
	Sat, 20 Jul 2024 17:30:06 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemd100012.china.huawei.com (7.221.188.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 20 Jul 2024 17:30:05 +0800
Message-ID: <fdc0c2f0-a16d-4534-90d9-696000871044@huawei.com>
Date: Sat, 20 Jul 2024 17:30:04 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/20] lsm: Refactor return value of LSM hook
 getselfattr
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Xu Kuohai <xukuohai@huaweicloud.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
	<selinux@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>, Brendan Jackman
	<jackmanb@chromium.org>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, Casey
 Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>, John Johansen
	<john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu
	<shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Trond
 Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
	<anna@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Stephen Smalley
	<stephen.smalley.work@gmail.com>
References: <20240711111908.3817636-7-xukuohai@huaweicloud.com>
 <6e79c031aa6c223df552726ac6537d44@paul-moore.com>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <6e79c031aa6c223df552726ac6537d44@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100012.china.huawei.com (7.221.188.214)

On 7/19/2024 10:08 AM, Paul Moore wrote:
> On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> To be consistent with most LSM hooks, convert the return value of
>> hook getselfattr to 0 or a negative error code.
>>
>> Before:
>> - Hook getselfattr returns number of attributes found on success
>>    or a negative error code on failure.
>>
>> After:
>> - Hook getselfattr returns 0 on success or a negative error code
>>    on failure. An output parameter @nattr is introduced to hold
>>    the number of attributes found on success.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   include/linux/lsm_hook_defs.h |  2 +-
>>   include/linux/security.h      |  5 +++--
>>   security/apparmor/lsm.c       |  5 +++--
>>   security/lsm_syscalls.c       |  6 +++++-
>>   security/security.c           | 18 +++++++++++-------
>>   security/selinux/hooks.c      | 13 +++++++++----
>>   security/smack/smack_lsm.c    | 13 +++++++++----
>>   7 files changed, 41 insertions(+), 21 deletions(-)
> 
> The getselfattr hook is different from the majority of the other LSM
> hooks as getselfattr is used as part of lsm_get_self_attr(2) syscall and
> not by other subsystems within the kernel.  Let's leave it as-is for now
> as it is sufficiently special case that a deviation is okay.
>

Got it, thanks

> --
> paul-moore.com
> 
> 


