Return-Path: <linux-kselftest+bounces-13698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3AE9301B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 23:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4AA1C22A52
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 21:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587C29D1C;
	Fri, 12 Jul 2024 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L3+kuG56"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235548CFC
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720820704; cv=none; b=SgJklG1feFtqGgPgf7SfTj1fOjsiC4x6cv9LuqKa6Me1i47m88NjDSQMWqzrWlcmPvSxsR3+7gi4R9wd3HTLUnioXm8jpVQQSuW9ZBO7Oq8ZXiXOe3BpV7RAi3jrIhLrKEuzIkhxV677rjzLVrMqBYo5fmgmicQrCKmpT+V/tU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720820704; c=relaxed/simple;
	bh=HrpbA+Nh/9HXkgiYd6LjRrLuadOhUMjI6rPQOim6SyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwCOUEVOiqRZo+KrZe6Pny6JB1NNouBchPxQEFcQK3rHqHuLi5smTWpYgDFnQmMvpP3ZZvh8tpBgTJR8ZyoqEfpTUkeSzIN+50uTei2OXBvhmuc8nagw+zVhRXiyMAHQeAwDqktlNtKtySnV31fpkQfnvTv/tCJXUBCRSqynoj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L3+kuG56; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64e81cd12cdso21537547b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 14:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720820702; x=1721425502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Kmr0D+B+H7qE4FCqmrG4LnL6SKbCOr3RFTLgldPz/U=;
        b=L3+kuG56BXOB/DRUENOgFCMMJMUqNuWJAs6pEdS9mbr91AaKaO+CNxzJWcxHd1y62/
         u8scL3qtjfH4SVKnufc3I1AGz/T53hR5gQrCokKLa46CQuNkFT/WZ0yeSRKM30LV9ygE
         j0UHKqPgBRYB3AVw+yb0rEeNliTFk01JjgMvyL5Xecze8JsH1st275sUGX0U3GfGMlHn
         0AN9LCsbN7KlZqLN0J4byvJl7OJJAhaeLYzEPVVpTcYIjzJP4YL/x8v5+/la67ICMBHD
         vTZgtlHwBbn+O3DC7in2x9N685F4UnISA6aO585TLKYwFVD/eiJCy1unRp/2ErL7YSlv
         LeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720820702; x=1721425502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Kmr0D+B+H7qE4FCqmrG4LnL6SKbCOr3RFTLgldPz/U=;
        b=XZ+ZnBwJqdc0MOwktFDHDMCF/3pv4DQI019AvmOtAIGWSQe4C7888cuwca3stNKAO2
         PZ9kJEiyruxmMiafoStDP7y6eEgBT+W6uSjwcGraEKTPLVxMOseRoN5GmY0Yv3lJdh1A
         2GGwuyZphmb9SLbho/YPfTrXdkTtGghcY858K6XWz8ixS/Qqiomc4i2gwSAYBbunVssV
         c9miXBruvAr6m4rKwYu2wMe7iEWmY1LBSnsswX0kTM1jWUWj+CHNA+LqC74XMrYLuVkB
         yxQ37n3r9p6GMlA+3edCLPFrpBB+P3dHhipw7plKUSG9M6t4llja+lx+ndsZ1NOn3avg
         gZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRBQTYTM92FtcCXq8TvBHCJ0tBlZL+dGZ3LlWYoWe5FLlvVKqiLvhDquLZcEvlHx9aQxHHAPIONw8SMkj024x1lGq3FX11tN7Ukq6f/PRs
X-Gm-Message-State: AOJu0YxmMtGMEP3739gwl45PHrYhTx6BjeVa/wc0Pk6cLg9lTIgzoyvP
	Dlo/3cYuxR9eVVgJ7jp7wyhZupqPjsgg7trfjATT/B7FGYrxc/1x5VoX5B47HcZrNEzj/VfVzWV
	mspL9KL5PhN44buB2yf4RUEOI4ZNzxHe90NUs
X-Google-Smtp-Source: AGHT+IEaqUkUcoofoiCgBx7/38mr/KpB2c3RLOwpHoSCCsqoepBZ3LTzVff/c70jSsidDaLrUQzyB2KbjQRclo3oiSw=
X-Received: by 2002:a05:690c:6d0a:b0:64b:1eb2:3dd4 with SMTP id
 00721157ae682-65dfd09005fmr37587657b3.8.1720820702076; Fri, 12 Jul 2024
 14:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Jul 2024 17:44:50 -0400
Message-ID: <CAHC9VhRohF+36PQbbEUiiiXjnmx-ZCphjOiAV5VTQwCejuejMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] Add return value range check for BPF LSM
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, 
	selinux@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 7:13=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> LSM BPF prog returning a positive number attached to the hook
> file_alloc_security makes kernel panic.
>
> Here is a panic log:
>
> [  441.235774] BUG: kernel NULL pointer dereference, address: 00000000000=
009
> [  441.236748] #PF: supervisor write access in kernel mode
> [  441.237429] #PF: error_code(0x0002) - not-present page
> [  441.238119] PGD 800000000b02f067 P4D 800000000b02f067 PUD b031067 PMD =
0
> [  441.238990] Oops: 0002 [#1] PREEMPT SMP PTI
> [  441.239546] CPU: 0 PID: 347 Comm: loader Not tainted 6.8.0-rc6-gafe0cb=
f23373 #22
> [  441.240496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.15.0-0-g2dd4b4
> [  441.241933] RIP: 0010:alloc_file+0x4b/0x190
> [  441.242485] Code: 8b 04 25 c0 3c 1f 00 48 8b b0 30 0c 00 00 e8 9c fe f=
f ff 48 3d 00 f0 ff fb
> [  441.244820] RSP: 0018:ffffc90000c67c40 EFLAGS: 00010203
> [  441.245484] RAX: ffff888006a891a0 RBX: ffffffff8223bd00 RCX: 000000003=
5b08000
> [  441.246391] RDX: ffff88800b95f7b0 RSI: 00000000001fc110 RDI: f089cd0b8=
088ffff
> [  441.247294] RBP: ffffc90000c67c58 R08: 0000000000000001 R09: 000000000=
0000001
> [  441.248209] R10: 0000000000000001 R11: 0000000000000001 R12: 000000000=
0000001
> [  441.249108] R13: ffffc90000c67c78 R14: ffffffff8223bd00 R15: fffffffff=
ffffff4
> [  441.250007] FS:  00000000005f3300(0000) GS:ffff88803ec00000(0000) knlG=
S:0000000000000000
> [  441.251053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  441.251788] CR2: 00000000000001a9 CR3: 000000000bdc4003 CR4: 000000000=
0170ef0
> [  441.252688] Call Trace:
> [  441.253011]  <TASK>
> [  441.253296]  ? __die+0x24/0x70
> [  441.253702]  ? page_fault_oops+0x15b/0x480
> [  441.254236]  ? fixup_exception+0x26/0x330
> [  441.254750]  ? exc_page_fault+0x6d/0x1c0
> [  441.255257]  ? asm_exc_page_fault+0x26/0x30
> [  441.255792]  ? alloc_file+0x4b/0x190
> [  441.256257]  alloc_file_pseudo+0x9f/0xf0
> [  441.256760]  __anon_inode_getfile+0x87/0x190
> [  441.257311]  ? lock_release+0x14e/0x3f0
> [  441.257808]  bpf_link_prime+0xe8/0x1d0
> [  441.258315]  bpf_tracing_prog_attach+0x311/0x570
> [  441.258916]  ? __pfx_bpf_lsm_file_alloc_security+0x10/0x10
> [  441.259605]  __sys_bpf+0x1bb7/0x2dc0
> [  441.260070]  __x64_sys_bpf+0x20/0x30
> [  441.260533]  do_syscall_64+0x72/0x140
> [  441.261004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [  441.261643] RIP: 0033:0x4b0349
> [  441.262045] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 4=
8 89 f8 48 89 f7 48 88
> [  441.264355] RSP: 002b:00007fff74daee38 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000141
> [  441.265293] RAX: ffffffffffffffda RBX: 00007fff74daef30 RCX: 000000000=
04b0349
> [  441.266187] RDX: 0000000000000040 RSI: 00007fff74daee50 RDI: 000000000=
000001c
> [  441.267114] RBP: 000000000000001b R08: 00000000005ef820 R09: 000000000=
0000000
> [  441.268018] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000004
> [  441.268907] R13: 0000000000000004 R14: 00000000005ef018 R15: 000000000=
04004e8
>
> This is because the filesystem uses IS_ERR to check if the return value
> is an error code. If it is not, the filesystem takes the return value
> as a file pointer. Since the positive number returned by the BPF prog
> is not a real file pointer, this misinterpretation causes a panic.
>
> Since other LSM modules always return either a negative error code
> or a valid pointer, this specific issue only exists in BPF LSM. The
> proposed solution is to reject LSM BPF progs returning unexpected
> values in the verifier. This patch set adds return value check to
> ensure only BPF progs returning expected values are accepted.
>
> Since each LSM hook has different excepted return values, we need to
> know the expected return values for each individual hook to do the
> check. Earlier versions of the patch set used LSM hook annotations
> to specify the return value range for each hook. Based on Paul's
> suggestion, current version gets rid of such annotations and instead
> converts hook return values to a common pattern: return 0 on success
> and negative error code on failure.
>
> Basically, LSM hooks are divided into two types: hooks that return a
> negative error code and zero or other values, and hooks that do not
> return a negative error code. This patch set converts all hooks of the
> first type and part of the second type to return 0 on success and a
> negative error code on failure (see patches 1-10). For certain hooks,
> like ismaclabel and inode_xattr_skipcap, the hook name already imply
> that returning 0 or 1 is the best choice, so they are not converted.
> There are four unconverted hooks. Except for ismaclabel, which is not
> used by BPF LSM, the other three are specified with a BTF ID list to
> only return 0 or 1.

Thank you for following up on your initial work with this patchset, Xu
Kuohai.  It doesn't look like I'm going to be able to finish my review
by the end of the day today, so expect that a bit later, but so far I
think most of the changes look good and provide a nice improvement :)

--=20
paul-moore.com

