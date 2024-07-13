Return-Path: <linux-kselftest+bounces-13708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D0930479
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 10:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A1A1F242B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA13D4085D;
	Sat, 13 Jul 2024 08:11:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE301DFE3;
	Sat, 13 Jul 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720858274; cv=none; b=KeHgHRKnW3bnIw/H+nk7QcqCKJNVL1DRBsHrzIE1umJIwDslOLNIwY9QjRFWjuRUwW1nxBu+EE32P3mcqFcmom2RfqN3wPxp0mVIy2nWsCbtXKjxiZepfrrtwbpZJpCX8bu7Rh2i5qlNd0meVvYPYWmNttCLZjASCTLAEnjlBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720858274; c=relaxed/simple;
	bh=v6WEaM18t7QWAOiNkCtdqwMsvabTvhmPFPEIsnakkHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjHCar3ogmEoV/JeueFAWSTXPiXXkdH9ijtyLSMksKkS5k/Sj+MY/h1Jvx8wcyF9VcFkUMkqx1tfL4nPAhmx4qsMryFMkHa84NURXsBr930KIM7ZYjV48CbPWiy7llEFSwzxsUPB6fetyrih9yvQf4dKdfll9j53xXiA/c6qEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WLh452CFQz4f3jM1;
	Sat, 13 Jul 2024 16:11:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 130DE1A0185;
	Sat, 13 Jul 2024 16:11:09 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgAnLfacNpJmR8bRBw--.46904S2;
	Sat, 13 Jul 2024 16:11:08 +0800 (CST)
Message-ID: <92b895d4-8831-404b-98f3-3f42edbc5331@huaweicloud.com>
Date: Sat, 13 Jul 2024 16:11:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 11/20] bpf, lsm: Add disabled BPF LSM hook
 list
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <20240711111908.3817636-12-xukuohai@huaweicloud.com>
 <qjrf5c6f24b6ef5tpvpz75uxp6ro6mhos34ovssinv4yxjwyz3@nvs75o5sywgx>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <qjrf5c6f24b6ef5tpvpz75uxp6ro6mhos34ovssinv4yxjwyz3@nvs75o5sywgx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAnLfacNpJmR8bRBw--.46904S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyDtrWxuF1rKw4kXFWDJwb_yoW3GFb_ur
	yjv3srtw1ftwn3AF4F9F42gFWUuw4vgFy5W345Wr98XryfZF95Za1kGrs5AFWUJFWvvFy2
	9F1fJanFgw42qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/13/2024 1:56 AM, Alexei Starovoitov wrote:
> On Thu, Jul 11, 2024 at 07:18:59PM +0800, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> Add a disabled hooks list for BPF LSM. progs being attached to the
>> listed hooks will be rejected by the verifier.
>>
>> Suggested-by: KP Singh <kpsingh@kernel.org>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> Xu,
> 
> The patches 11 and higher are mostly independent from lsm refactoring.
> Please send them as a separate patchset for bpf-next.
> While lsm cleanups are being reviewed this lsm_disabled list can be
> a bit larger temporarily.
> 

It's great to separate patches unrelated to bpf by temporarily extending
the lsm disabled list. I'll post an update. Thanks!


