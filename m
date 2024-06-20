Return-Path: <linux-kselftest+bounces-12346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAD6910D97
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81065B2267E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E9C1B29C3;
	Thu, 20 Jun 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aMsv3ETR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341B1B29C9
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902322; cv=none; b=fRNdZxV4ablQ6EMYx7JwL3JlD+AXGYBwz9d6KYZ5Lio9aUqTa0LH2JxeI7EamSrL+ZRDR/pQ6JVvF2PObBai57BpPFkFjgvo0z4MDaqUK7pzVJ07NWY2JblIQ0kLWHNSJGjR0H8ru2vysKqq2y+stHM5zM4WVdNEYCJcbE+WEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902322; c=relaxed/simple;
	bh=uRBaIvxaZu1rEHI9TVUfJHuyw1MtoY1RVuSrPf6GqDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8CyyFKQRJpEhKItUZaq6I26J//pvYYSOLEYCLrMaNfQCDNuiIYv7XZfbrKScEOMal+oWQoKxRqDeisRtrZqKBtJk1Cg8n7UZPHHZsuRtYGBAH3F+/JIvza/KWbJKPP3UIwKjPb7wY4xq6ICjPIOTe5kgDzspOUWwQfgwTLSB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aMsv3ETR; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-632bcf111ffso10913237b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718902319; x=1719507119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlzckC1yv4AXj6i9qMAIkJ4utMa7nHRmmuxXuBZ0/Gg=;
        b=aMsv3ETRaaBmS80pad8BwHFt/YFw7ILfXeEn1cGMu438tByxcJU8bIEn8hOz2uGVcs
         6tpyRne0HgaXRPU5OnXKofAaeLlKB/GqfHi7sV1IYdtY3B9WIMlI5/+2VMc2eleq4uc+
         IrIJAdVRQXaoB4KjV7JkieVk1pH7dIipKGI4Sqs2j4QigaZFEznYHSOR9FpZz5uBqX8L
         FSGwQZHwZvpr2BNCwrhbwdNxklecSFMi+OXTaUdj7LsvgH/Gcr8FIsSY8iNpPS+I0P6J
         L6oTby43o2VtGb2VS60ev2mf3zlNQxbQ9FaKkDsSFA3Vns/Ho9jJTadITuhYK3GpTsrf
         kNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718902319; x=1719507119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlzckC1yv4AXj6i9qMAIkJ4utMa7nHRmmuxXuBZ0/Gg=;
        b=FE6MUCUzpksdrnI4f3WJGUHPQ6yH6J+WQG4Q+NO2OYWEHHdLMdvsJ5c80ElcrmaN/l
         CExWqhREr6oieA7o/2+UfGSTTYI9pRIG7oD2gmrdgM0kzI8argzj1AtbV5qDTzw30raN
         wdcWh0qi8IJpj5XhYawZ2QgR6mubJK9FBcXwPtAvAVsBWN3nKTkhuGiJbiuqAo3U8dSg
         LVp4UMsVVGACXodoKoOiPEf8qhhUsXqebnjlyt4x3fuS1BkZYMim8wDCBmYXRAuQ3/2o
         476QVkmA+YG7T7uuVn4u5wEK3gR3tnebMkZKfzFRf/7gV+aMkUWpPgqINjUtPWCdhTzp
         UAhw==
X-Forwarded-Encrypted: i=1; AJvYcCW0doSUB+lgEO511RepL9Mhovf+pz1E4azX7f0Dp6WeMrNesl5Hc2IiMu6Q8zw+ReqdjJNVFBiHY5ZdumPZo1Xy7I6DrFl9XwnYNhKPrHFu
X-Gm-Message-State: AOJu0YwkXg/D/LFXgJVYkwmJC3X+2RKr+6HCLpqmcMPpQ2l8LT9ZosE/
	wu5B07XchgAuimaIcVYkBUVMXormPe2MVR5I3pa+btKkKz65PxdvRcqHw5tLCulLDiiQUbtYV+e
	qe9yb8PVDp5NoAuKWQNGNCGWfOmFKpdGiiXOs
X-Google-Smtp-Source: AGHT+IENAd7r6k0hcoKPurAjxge/3tlio5u013vzrxAxRlV6VnO6fxsl9wW301WYnJG4BzmkDZu20x81guAy7n54YLA=
X-Received: by 2002:a81:84c5:0:b0:62c:e6c0:e887 with SMTP id
 00721157ae682-63a8d72f60bmr64327437b3.9.1718902318965; Thu, 20 Jun 2024
 09:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
 <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
 <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
 <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
 <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com>
 <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
 <CAHC9VhSOMLH69+q_wt2W+N9SK92KGp5n4YgzpsXMcO2u7YyaTg@mail.gmail.com>
 <e9114733eedff99233b1711b2b05ab85b7c19ca9.camel@huaweicloud.com>
 <CAHC9VhQp1wsm+2d6Dhj1gQNSD0z_Hgj0cFrVf1=Zs94LmgfK0A@mail.gmail.com>
 <c96db3ab0aec6586b6d55c3055e7eb9fea6bf4e3.camel@huaweicloud.com>
 <CAHC9VhSQOiC9t0qk10Lg3o6eAFdrR2QFLvCn1h2EP+P+AgdSbw@mail.gmail.com> <c732b1eb15141f909e99247192539b7f76e9952c.camel@huaweicloud.com>
In-Reply-To: <c732b1eb15141f909e99247192539b7f76e9952c.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Jun 2024 12:51:48 -0400
Message-ID: <CAHC9VhSA0dSQ1jaRO_J1S5xEc14XoCnYaVG3AWF=uYaDb-AjoQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, 
	akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, mic@digikod.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	linux-integrity@vger.kernel.org, wufan@linux.microsoft.com, 
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org, 
	pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, jikos@kernel.org, 
	mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de, 
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:31=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Thu, 2024-06-20 at 12:08 -0400, Paul Moore wrote:
> > On Thu, Jun 20, 2024 at 11:14=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Thu, 2024-06-20 at 10:48 -0400, Paul Moore wrote:
> > > > On Thu, Jun 20, 2024 at 5:12=E2=80=AFAM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > On Wed, 2024-06-19 at 14:43 -0400, Paul Moore wrote:
> > > > > > On Wed, Jun 19, 2024 at 12:38=E2=80=AFPM Roberto Sassu
> > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > >
> > > > > > > Making it a kernel subsystem would likely mean replicating wh=
at the LSM
> > > > > > > infrastructure is doing, inode (security) blob and being noti=
fied about
> > > > > > > file/directory changes.
> > > > > >
> > > > > > Just because the LSM framework can be used for something, perha=
ps it
> > > > > > even makes the implementation easier, it doesn't mean the frame=
work
> > > > > > should be used for everything.
> > > > >
> > > > > It is supporting 3 LSMs: IMA, IPE and BPF LSM.
> > > > >
> > > > > That makes it a clear target for the security subsystem, and as y=
ou
> > > > > suggested to start for IMA, if other kernel subsystems require th=
em, we
> > > > > can make it as an independent subsystem.
> > > >
> > > > Have you discussed the file digest cache functionality with either =
the
> > > > IPE or BPF LSM maintainers?  While digest_cache may support these
> > >
> > > Well, yes. I was in a discussion since long time ago with Deven and
> > > Fan. The digest_cache LSM is listed in the Use Case section of the IP=
E
> > > cover letter:
> > >
> > > https://lore.kernel.org/linux-integrity/1716583609-21790-1-git-send-e=
mail-wufan@linux.microsoft.com/
> >
> > I would hope to see more than one sentence casually mentioning that
> > there might be some integration in the future.
>
> Sure, I can work more with Fan to do a proper integration.

That seems like a good pre-requisite for turning digest_cache into a
general purpose subsystem.

> > > I also developed an IPE module back in the DIGLIM days:
> > >
> > > https://lore.kernel.org/linux-integrity/a16a628b9e21433198c490500a987=
121@huawei.com/
> >
> > That looks like more of an fs-verity integration to me.  Yes, of
> > course there would be IPE changes to accept a signature/digest from a
> > digest cache, but that should be minor.
>
> True, but IPE will also benefit from not needing to specify every
> digest in the policy.

Sure, but that isn't really that important from a code integration
perspective, that's an admin policy issue.  I expect there would be
much more integration work with fs-verity than with IPE, and I think
the fs-verity related work might be a challenge.

> Also, the design choice of attaching the digest cache to the inode
> helps LSMs like IPE that don't have a per inode cache on their own.
> Sure, IPE would have to do a digest lookup every time, but at least on
> an already populated hash table.

Just because you need to attach some state to an inode does not mean a
file digest cache must be a LSM.  It could be integrated into the VFS
or it could be a separate subsystem; either way it could provide an
API (either through well defined data structures or functions) that
could be used by various LSMs and filesystems that provide integrity
protection.

--=20
paul-moore.com

