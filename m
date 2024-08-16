Return-Path: <linux-kselftest+bounces-15547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E861B954F90
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CEE4B20D28
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1FA1C0DF2;
	Fri, 16 Aug 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4VDPmqe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A261BF33D
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828132; cv=none; b=JW3vwwMJQ9sAwwkpPBsI8sE9LDXiEXrkIot1EtLesL4JkT4pCFB33/5cjnfI2xmesqB7dSkmB40Ut1rKBsmrBEc9tfQOdK3KMPNOP2rqYFn9YSGo7OUbFkSxYrqzcNtz6fQgx3QSjUJOPL2T6AD+qDeARJgqp36cVRFhoETJzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828132; c=relaxed/simple;
	bh=n/Tr/WmPHlvI68zrU+eeiglLIedVxZY63IbqtDBKrio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Enx55kAkBW8dGMRFa3rhr8ncCM7BFQZfedKKFnidSBQ6Y0znIijgy+iVJ/j34pdydrzRAoSnKIH57XjixyxewV/Q3vLno39Uv8LzE9Aewyhpgra36oS65NdWzaQdIxcCB0FrofIP1/MobalDT0jX3HyK/d/AV81qtBt7iiaY+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4VDPmqe; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bebb241fddso241a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723828129; x=1724432929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uErb4GlpeJI3Tx9w9GTv9h0fP96iz7mSRe0kxWFAxc0=;
        b=R4VDPmqen+195TGwb1EaZEDtzqpPk9gbyvwfn3SxMyoz1HWQVKUGWnIubipygxbVF9
         VeotB88o8RToHH2WvVUEO5DxLyu18Swzk7UEoMR9rdoPApnWFL/LJmneAvJ+3lmE9GmI
         B9B2261ZjQNhXqPU2JCgtukRsDBZJmoGrez/a6XHhW0G1BJ8qhrnFjqMQpAQrIQjeeXF
         ocfMX2CKGWhs7Iblwhz6LVUdkkI2KMF5xuAaW8OP+wqTMBoqTAWL4TKRqcZMduLgzbGn
         ltHsW5rZjwVJ7wcnUZ6BT7fE0PuwphHg4vUNG9Vd5jBYYgm3qwC5SEmi7GQ8qVUeqoBj
         1x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723828129; x=1724432929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uErb4GlpeJI3Tx9w9GTv9h0fP96iz7mSRe0kxWFAxc0=;
        b=D9qFPta8G5rBUcXXjEEAY5H2aGj+eWR9KHAVcOxKz8LBF2f2laWoyLvTJo8tanZOXN
         QIXshhPZNXIdhuQTwBaiP9Vi323g9uOwdwWPqfkS9850s7+Kg2h7xeEAgJHHVeFJ2EAB
         FUHeWKuPQDQb5S/MaEZ2zWDH9N/DJgmtwaMbvJnU0UxRDoX71LCfIR8A3Fek4MzSF/a7
         IqB5oX4sL0HrAOwbrfQ14wJZ4TrNO4wmzZC82v7U5z4zHKMWjV24jBjMNsm+lexoOhj8
         nd4ckPmw5rl2znaGLxGyXRBc+GqGJhK9i44xedhvawKt9ODCUKgvaWP0H7vYQP/h8OSH
         QcdA==
X-Forwarded-Encrypted: i=1; AJvYcCVuYQnvEGCtJRBAGmSefLQEjszuvjh5irPUw/qBEhDdK5xm0ZBf8Kqmqw93F5OIqsrJoyw/KwAVLYilD7mKBgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxztsS9TqpOMWn2SqZNj8NafDXVBxjeQUXug3SuiMSSIEM3oiNl
	rrbvr9BVcLXwDAdAr9naNHUZ6TEh5PEZjNBzzTHMegcXHaMWNDANoDHDrPz+4qt/4GhMHrHNl66
	oB7bW0YJ9ZmnkDTugX+HxCwyqiJWw1uT2FbqH
X-Google-Smtp-Source: AGHT+IFUsyddLhNJtQHS2CaSxunJXwGdMRztQxxVD3Cn4TtPHqXAGVxmlebqOy2QOfvAhJDtKSj/mHBWVCfjywlV1Ow=
X-Received: by 2002:a05:6402:2687:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5becd6c4e09mr124079a12.7.1723828128189; Fri, 16 Aug 2024
 10:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org> <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
In-Reply-To: <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 Aug 2024 19:08:09 +0200
Message-ID: <CAG48ez2z5bRdKNddG+kEGz9A_m=66r38OHjyg6CapFTcjT9aRg@mail.gmail.com>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, 
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>, 
	"mgorman@suse.de" <mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, 
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, 
	"bsegall@google.com" <bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "will@kernel.org" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 2:18=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Thu, 2024-08-08 at 09:15 +0100, Mark Brown wrote:
> > +       if (access_remote_vm(mm, addr, &val, sizeof(val),
> > +                            FOLL_FORCE | FOLL_WRITE) !=3D sizeof(val))
> > +               goto out;
>
> The GUPs still seem a bit unfortunate for a couple reasons:
>  - We could do a CMPXCHG version and are just not (I see ARM has identica=
l code
> in gcs_consume_token()). It's not the only race like this though FWIW.
>  - I *think* this is the only unprivileged FOLL_FORCE that can write to t=
he
> current process in the kernel. As is, it could be used on normal RO mappi=
ngs, at
> least in a limited way. Maybe another point for the VMA check. We'd want =
to
> check that it is normal shadow stack?

Yeah, having a FOLL_FORCE write in clone3 would be a weakness for
userspace CFI and probably make it possible to violate mseal()
restrictions that are supposed to enforce that address space regions
are read-only.

>  - Lingering doubts about the wisdom of doing GUPs during task creation.
>
> I don't think they are show stoppers, but the VMA check would be nice to =
have in
> the first upstream support.
[...]
> > +static void shstk_post_fork(struct task_struct *p,
> > +                           struct kernel_clone_args *args)
> > +{
> > +       if (!IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK))
> > +               return;
> > +
> > +       if (!args->shadow_stack)
> > +               return;
> > +
> > +       if (arch_shstk_post_fork(p, args) !=3D 0)
> > +               force_sig_fault_to_task(SIGSEGV, SEGV_CPERR, NULL, p);
> > +}
> > +
>
> Hmm, is this forcing the signal on the new task, which is set up on a use=
r
> provided shadow stack that failed the token check? It would handle the si=
gnal
> with an arbitrary SSP then I think. We should probably fail the clone cal=
l in
> the parent instead, which can be done by doing the work in copy_process()=
. Do
> you see a problem with doing it at the end of copy_process()? I don't kno=
w if
> there could be ordering constraints.

FWIW I think we have things like force_fatal_sig() and
force_exit_sig() to send signals that userspace can't catch with
signal handlers - if you have to do the copying after the new task has
been set up, something along those lines might be the right way to
kill the child.

Though, did anyone in the thread yet suggest that you could do this
before the child process has fully materialized but after the child MM
has been set up? Somewhere in copy_process() between copy_mm() and the
"/* No more failure paths after this point. */" comment?

