Return-Path: <linux-kselftest+bounces-13680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D67E92FE0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 18:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926481F23BBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D61175548;
	Fri, 12 Jul 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZFErMHLS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597A1DFE3
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800023; cv=none; b=JkAfpqhy5R5IHMUkvlrodDZvxakCk/4OzejwACSLQ7AVXkYuYYeopL4FFu7dX1YJXYsd/0JylBkxnawE1yRK9U/Btsf/bcA6KwkJT7syR2FbB77Rtbg+gDh3xDi3HCOksAnp8bgxev3y6Vkp3+mn5qIdCPOfkYQSKq5y7WJwVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800023; c=relaxed/simple;
	bh=teFvllSrR8u1LwxNwtWBUZZZcgHd4yYz/LxZF9Uqdjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryaDkfVBTCd5y58Z01YfDRfgpBTBPc50SLWVLtlL1CLcbJ/t+0Q3Q07zj8o+iU6q1fxgNjCP5Fzd0BBUiMzp+GOQoMExH7QCiP+CIn/6ll3hR2bCgsLYrrHX1x6WGgW88OFqDgMWhjJA/OxEsUJdCocjvyKB6aYV4E8qH3dA+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZFErMHLS; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-64f4c11d2c9so19538457b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720800021; x=1721404821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnIdY8cOUw38JAafq5wFUGBK6m5NkxtUKb6vV5qaE/U=;
        b=ZFErMHLSikYIgxanXwqGiwZRjRVlpbnQAX64KyOTNLdtzCUOV0hLtWwSFcieCHVpZc
         t+T8vtu+QQFNDfV1Yn/iQ49R182Vj6A9H4e+dDzEvETq/joXfGYaxI1T3Nkw29UABlX0
         ZUMU+CVKj93W7RlsaBOrnqq3K2m01EEa1mpREqm+V7r1RuGOQFFJlXTtZA6i/Cer33O/
         LBLsYctVhG+kFlqkC2PCmPwscKk/I2Qw0FT1oRjEmn7M27Zho6YKMXLd4GX6D2kHmFh/
         PgvCAKQaBNXBml+KWcuL7MEm9If1C6ZH1UgK81OMOegNBMBjsWuyNVmMBN0HhnkJWuay
         eDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800021; x=1721404821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnIdY8cOUw38JAafq5wFUGBK6m5NkxtUKb6vV5qaE/U=;
        b=BH4UvOZMKYvnOFPIK6isTV4GyhbdiVtkcxfSAsLpLqOKpGMfVbzh4aYUzM49GnonvZ
         AY6VuBwxiLRneCp5xJZm8viu84Fnga55Swpm0jGhNOH0cxDAGuDyBvPxF2Sq6RdZUZFy
         7W+MwbtLYxq5jTFeryOV+G66fBjCIiqQ8/oy7ju14r09khSyCRBAj7tYdy02y5gdJWbs
         7SpbOcfzSshWvrKKavb1tq1iyN8TcbfK+jSVxMmIXGPMqCGNbpXPJec+q64jUzg/+qr+
         94mYnEkEwDHa1QGdEczNS91qwYRmlsu2DIkShEQT3XvJLNIvtaP8XXGslo+crrGQzdp1
         gW/A==
X-Forwarded-Encrypted: i=1; AJvYcCUxFGbOKLkt5xc7wH8yGaBEQXbwB3ChFsGifgalvD/pDx3flPzSmfk3oWlLLNd7CQtV5Try2QYLt4FXrRxPvOzuyapvury7FkZEqxF8rfFM
X-Gm-Message-State: AOJu0YyrZ5QsOf/9m6IauNjCTPYVoQvcfjaX/81NTJEwX4ptxq1bMMhQ
	XVHpOkSn/7JHT1MJ84LyNItHZGfrggqBa70w/LAaOItMaQOK+hVZmg9SZazdI0OWWiToJSyk9A+
	+mjYqd0KbtSZaze2OYiGlzhmwyJjifGMSLH6T
X-Google-Smtp-Source: AGHT+IHMT0du6hnJIItX/6mTkJFxNvw+z/Qex7BmduSDlDVCO3FlfK9m+2jlZrQudmjY8vONYjC0fSXRiUdwhit5XPg=
X-Received: by 2002:a0d:eec6:0:b0:646:fe8e:f03b with SMTP id
 00721157ae682-658ee791211mr112675977b3.2.1720800021231; Fri, 12 Jul 2024
 09:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com> <CAHC9VhSBg7qf81O+mC1EDSUhZ4xR57jfY4h0P6Vy1PO++JqMBw@mail.gmail.com>
In-Reply-To: <CAHC9VhSBg7qf81O+mC1EDSUhZ4xR57jfY4h0P6Vy1PO++JqMBw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Jul 2024 12:00:09 -0400
Message-ID: <CAHC9VhQ9tevCE5MDXxqmErSayHe12XKd=VEVGyPKL0TMxwLC8w@mail.gmail.com>
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

On Fri, Jul 12, 2024 at 11:56=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Thu, Jul 11, 2024 at 7:13=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.c=
om> wrote:
> >
> > From: Xu Kuohai <xukuohai@huawei.com>
> >
> > LSM BPF prog returning a positive number attached to the hook
> > file_alloc_security makes kernel panic.
>
> ...
>
> > Xu Kuohai (20):
> >   lsm: Refactor return value of LSM hook vm_enough_memory
> >   lsm: Refactor return value of LSM hook inode_need_killpriv
> >   lsm: Refactor return value of LSM hook inode_getsecurity
> >   lsm: Refactor return value of LSM hook inode_listsecurity
> >   lsm: Refactor return value of LSM hook inode_copy_up_xattr
> >   lsm: Refactor return value of LSM hook getselfattr
> >   lsm: Refactor return value of LSM hook setprocattr
> >   lsm: Refactor return value of LSM hook getprocattr
> >   lsm: Refactor return value of LSM hook key_getsecurity
> >   lsm: Refactor return value of LSM hook audit_rule_match
> >   bpf, lsm: Add disabled BPF LSM hook list
> >   bpf, lsm: Enable BPF LSM prog to read/write return value parameters
> >   bpf, lsm: Add check for BPF LSM return value
> >   bpf: Prevent tail call between progs attached to different hooks
> >   bpf: Fix compare error in function retval_range_within
> >   bpf: Add a special case for bitwise AND on range [-1, 0]
> >   selftests/bpf: Avoid load failure for token_lsm.c
> >   selftests/bpf: Add return value checks for failed tests
> >   selftests/bpf: Add test for lsm tail call
> >   selftests/bpf: Add verifier tests for bpf lsm
>
> I'm not quite sure what happened, but it looks like patches 13/20
> through 20/20 did not hit the mailing lists, see lore link below; did
> you have any mail failures when sending the patchset?  Regardless, can
> you sort this out and resend the patchset?
>
> https://lore.kernel.org/all/20240711111908.3817636-1-xukuohai@huaweicloud=
.com

Oh wait, it looks like the patchset was split in lore somehow,
nevermind.  The "missing" patches are here:

https://lore.kernel.org/all/20240711113828.3818398-1-xukuohai@huaweicloud.c=
om

--=20
paul-moore.com

