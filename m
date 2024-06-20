Return-Path: <linux-kselftest+bounces-12349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C93A910E32
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 19:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E82EB24F37
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51581B3F11;
	Thu, 20 Jun 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CXQ6FnOW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D81B373A
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903647; cv=none; b=YlwP8HL8ge6uXgOVVYbrbzfPz/U8b0oriUXSQCoxpS3578VZaY/ceJVf0V0CjEhrzol0kAgcAHnkD6xbJwUlkIYBxTJTtQpOoeRmGPV+FLflDLZSiWxc0emPkBuCrckxlkpIMVmVaQijkiLds1fyNI3NWW6BZPj0UxQA2cLesbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903647; c=relaxed/simple;
	bh=RlxxN8z3HnKmd7RWEP2xagF6fJLvI+Y6nZ5HcYEuPFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+jWwmpaUK7hlpExNr7qU/X8Heqfd4vR1OhUP4IAWrfQX8Bti79w4VVndjulhpItvbWt/hnL21Ftk3jeBXdXNF00kjsxGx/gXhsT8bBmBVeaJHNdau1GbbJfE6zPum0avbbzPjQ4ryVjWZyd3srf9baCLnnMXIp8kO6S3U8eqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CXQ6FnOW; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso1157396276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718903645; x=1719508445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSjgOH3MRiYTPXLCETGqDmeFsSXsqOVl3xiPcS9XIH8=;
        b=CXQ6FnOW/JpZOU/rQckmm9hyE7H1okcnRx2PxFzN1CcAQhjeL9HOxRSt5B2g5XGsSJ
         RNzXqSUsCos/vq3BqXtHBWNrDunlXtIyCf1UKduvcAeO5aB3+r83QEK+aOhz7h/Ba1bi
         uSkJoAHLa4T9tqYujtU3MS3DNgefUHjZ/n0LKbqg8WfXsy+Kp7TcYX16HVuw6aU7APpm
         YYobzHDi6HJ+7Mz9lKzgXiLKLHFXvuusEZ3CzQDmw26niXBE9UarLVh1btKdgUEZilyn
         nS0GVrMtUgTQN9vDb48XMe3Z52OPU5gbCeotBX8dXGQ/Rkmw2khn0o4REqDyDp5KmZuy
         U7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718903645; x=1719508445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSjgOH3MRiYTPXLCETGqDmeFsSXsqOVl3xiPcS9XIH8=;
        b=JK6iAye8W1retBZuyCYBxUO4BxRtasDTBLvGOku9G7j3XAMHdBFNA1GvZ577wyxeLH
         AycS0ORmMn0fNwfT0Yx2Dy6KHTEmQilX0tgfsaVb8bXkhfFOZyr+qLWk/YBjeUzkWF8h
         59grfu6rePz1IyRE0HVfKD0b+Jg6cy+dysreIcbciXLS2CMyXz/C5sESleyctEABGAq5
         rzHF+yWzfBSvd3BQbmMBqfAHKkmXphUFDKIlHAwexhnWHq84g/rfETeU9rNpKgpRf3vN
         uOJ379qJ3jJGJ46pbjEpqUJ+k4DbueWs+ZQYklF3OfvKnE7ibIme/dH+bhvC33/CLJXz
         FC4w==
X-Forwarded-Encrypted: i=1; AJvYcCWekvH8vJsjayW75DdMxyo0FG8wOUA9namEIqTEmH7P5AAbKhPccvwlphAsb1A0YtE8jRKHY/rWaFUYUJvvYiq9f5OSUD7Gq+1I1HneBHlv
X-Gm-Message-State: AOJu0Yxk9rZiyouRhfGF5ZO3sqz2YLohwgWGZrLX8+h1KFt0+WGzBnbE
	0HtujG04/yev7udWuAEx/ltxQ3mZWMAeqIB/WnrPQls3AUWawOcH+jlfuuC2LgRrrb7Hc53oCIj
	NXlskTNABGsWV4u30HUIixkDKn80p4Cf26he4
X-Google-Smtp-Source: AGHT+IEt2BAX4ZSJpnrrhbSbQYDBiYx8y+fmuLpTpl/M0RJ3695pwMWckVzrkaOUEOTeYU5DlKOXBhfcyjQJ7VGd3Fc=
X-Received: by 2002:a25:dbc4:0:b0:e02:2adf:b0ce with SMTP id
 3f1490d57ef6-e02be16ed3cmr5340894276.32.1718903644904; Thu, 20 Jun 2024
 10:14:04 -0700 (PDT)
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
 <CAHC9VhSQOiC9t0qk10Lg3o6eAFdrR2QFLvCn1h2EP+P+AgdSbw@mail.gmail.com>
 <c732b1eb15141f909e99247192539b7f76e9952c.camel@huaweicloud.com>
 <CAHC9VhSA0dSQ1jaRO_J1S5xEc14XoCnYaVG3AWF=uYaDb-AjoQ@mail.gmail.com> <7ad255dce0b85e018b693d302689e0e970b8cc00.camel@huaweicloud.com>
In-Reply-To: <7ad255dce0b85e018b693d302689e0e970b8cc00.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Jun 2024 13:13:54 -0400
Message-ID: <CAHC9VhSqtdwO_C1r_uduPLdZp3o+75ojSY+B7JG6H2noEmv7VA@mail.gmail.com>
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

On Thu, Jun 20, 2024 at 1:06=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Thu, 2024-06-20 at 12:51 -0400, Paul Moore wrote:
> > On Thu, Jun 20, 2024 at 12:31=E2=80=AFPM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Thu, 2024-06-20 at 12:08 -0400, Paul Moore wrote:
> > > > On Thu, Jun 20, 2024 at 11:14=E2=80=AFAM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > On Thu, 2024-06-20 at 10:48 -0400, Paul Moore wrote:
> > > > > > On Thu, Jun 20, 2024 at 5:12=E2=80=AFAM Roberto Sassu
> > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > On Wed, 2024-06-19 at 14:43 -0400, Paul Moore wrote:
> > > > > > > > On Wed, Jun 19, 2024 at 12:38=E2=80=AFPM Roberto Sassu
> > > > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > > >
> > > > > > > > > Making it a kernel subsystem would likely mean replicatin=
g what the LSM
> > > > > > > > > infrastructure is doing, inode (security) blob and being =
notified about
> > > > > > > > > file/directory changes.
> > > > > > > >
> > > > > > > > Just because the LSM framework can be used for something, p=
erhaps it
> > > > > > > > even makes the implementation easier, it doesn't mean the f=
ramework
> > > > > > > > should be used for everything.
> > > > > > >
> > > > > > > It is supporting 3 LSMs: IMA, IPE and BPF LSM.
> > > > > > >
> > > > > > > That makes it a clear target for the security subsystem, and =
as you
> > > > > > > suggested to start for IMA, if other kernel subsystems requir=
e them, we
> > > > > > > can make it as an independent subsystem.
> > > > > >
> > > > > > Have you discussed the file digest cache functionality with eit=
her the
> > > > > > IPE or BPF LSM maintainers?  While digest_cache may support the=
se
> > > > >
> > > > > Well, yes. I was in a discussion since long time ago with Deven a=
nd
> > > > > Fan. The digest_cache LSM is listed in the Use Case section of th=
e IPE
> > > > > cover letter:
> > > > >
> > > > > https://lore.kernel.org/linux-integrity/1716583609-21790-1-git-se=
nd-email-wufan@linux.microsoft.com/
> > > >
> > > > I would hope to see more than one sentence casually mentioning that
> > > > there might be some integration in the future.
> > >
> > > Sure, I can work more with Fan to do a proper integration.
> >
> > That seems like a good pre-requisite for turning digest_cache into a
> > general purpose subsystem.
> >
> > > > > I also developed an IPE module back in the DIGLIM days:
> > > > >
> > > > > https://lore.kernel.org/linux-integrity/a16a628b9e21433198c490500=
a987121@huawei.com/
> > > >
> > > > That looks like more of an fs-verity integration to me.  Yes, of
> > > > course there would be IPE changes to accept a signature/digest from=
 a
> > > > digest cache, but that should be minor.
> > >
> > > True, but IPE will also benefit from not needing to specify every
> > > digest in the policy.
> >
> > Sure, but that isn't really that important from a code integration
> > perspective, that's an admin policy issue.  I expect there would be
> > much more integration work with fs-verity than with IPE, and I think
> > the fs-verity related work might be a challenge.
>
> Uhm, not sure what you mean, but I don't plan to touch fsverity. There
> was already work to get the fsverity digest. All I would need to do
> from my side is to request a digest cache for the inode being verified
> by IPE and to query the fsverity digest.

So your proposed file digest cache wouldn't be used as a replacement
for the fs-verity digest?  Hmm.  I'll leave this up to you and Fan
(current IPE maintainer), but I'm not sure how much value this would
have for IPE, especially since I believe IPE's fs-verity support is
mostly around fs-verity signatures.

> Of course IPE should also capture kernel reads and verify the file
> containing the reference digests, used to build the digest cache.
>
> > > Also, the design choice of attaching the digest cache to the inode
> > > helps LSMs like IPE that don't have a per inode cache on their own.
> > > Sure, IPE would have to do a digest lookup every time, but at least o=
n
> > > an already populated hash table.
> >
> > Just because you need to attach some state to an inode does not mean a
> > file digest cache must be a LSM.  It could be integrated into the VFS
> > or it could be a separate subsystem; either way it could provide an
> > API (either through well defined data structures or functions) that
> > could be used by various LSMs and filesystems that provide integrity
> > protection.
>
> Given that IMA solved the same problem after 15 years, when it became
> an LSM, I'm not super optimistic on that. But if VFS people or other
> subsystem maintainers would be open for such alternative, I can give it
> a try.

I think you should, because I'm not currently supportive of
digest_cache as a standalone LSM.

--=20
paul-moore.com

