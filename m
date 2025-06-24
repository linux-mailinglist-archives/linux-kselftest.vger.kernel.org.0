Return-Path: <linux-kselftest+bounces-35716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B5AE7126
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1631BC06E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 20:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BBF2E92DA;
	Tue, 24 Jun 2025 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITJ2ydib"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5821771B;
	Tue, 24 Jun 2025 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798707; cv=none; b=gYncc8rY3F16uMeRHKSP7lSPDlm1Q5dyBbgKsPTnthdmmb58tg4dGbUMI3K/XJC+knBHv/4yQLr9zWv/Zzit/wovE3EAKi4bL+M/lL5HcFCVNYd5cCrW7Mdkc7IS0QlGC9difkC5ilSB5/xohSuyhPbdmKF7QBx0tZjtclJ97uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798707; c=relaxed/simple;
	bh=ku7s8J7NNaVRw7IojtWRiPUGuS8pNyYSGsxT4vIfzIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edc6fZIUATTqhn1xcCkG/t54LKYUoLZZst1/fN/PBdnbyJTYXrPFPAW21oA1kK6c2ZVTymwcxkCpOaQjDuleU2v0EgSo9+SNQw9/1wkVvzUd7vahixRrBSqbw4gcP3OhofJ59cIPJ9v08s0S21FIyRZD5cf/lHC4xGNx062mtf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITJ2ydib; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a582e09144so3569289f8f.1;
        Tue, 24 Jun 2025 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750798704; x=1751403504; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zz2ubMDTUSZ3CzP5tOdKSgALba7wz8T19kE34wyz8os=;
        b=ITJ2ydibI91f29bZD2LzT56abHD05SEaXsz33VlT2Y6WTu+CwoRbJ8nWQawB6BC/Tk
         /cklgGhG/m+krTbAokh5fwvkarWAKcttu3x4cObu6OaCZK17GkeWBo1mTb4JILrwFnhy
         0hlbAce/iEfD9OyxAxFFwoF4C6TiCtwst5wGTjuPZ4x8yq9GUPXc4dxuvd970peVpMkn
         uO6VVm3aCqisonsWRsGlPKpJeENMHaKIgNyBbnrt+coanv0d2VlxPFbhyemytjB1VzeT
         OvDwBn77dJ3Evlvj1voda0cx6jYfDdWhEWgYHVUpPQ6tWsTOLCix9VBle/usS7WTmA23
         rigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750798704; x=1751403504;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zz2ubMDTUSZ3CzP5tOdKSgALba7wz8T19kE34wyz8os=;
        b=XbxTgJEtSg08+ozwcOrZUia7Us/h5W3F0aSFdPbXqbTImYBQb8cjWiozmoIlbfrAf5
         91GQeIoPMPZbgEfaS8P8hmZJ6ivQtjgnKcfrr4nNKOF/PbTgqSDxPXPz5Eg77Rr7xM72
         UYhDBnDzPfCPf0Rw/TixL23xwlhB0nz72mc4m175zRV1j7Tk4wf/RV/3sNMbgjaxYkC8
         cc3EfjwVGE+QbOwdxDc/FwOVZlkCZDU4gj6tntyeeUgPh7aVFd/fkOlaeypj9687LwUI
         BvlKSH30JsqstinTnmmsu6Fb16oAfgSH0HMRsKJF7dIyeHXSXtEPgMwfxzqpt746RcCo
         rhKw==
X-Forwarded-Encrypted: i=1; AJvYcCU/I30jxsUQcwtIMdgW7OIS9MLXgcV7WwvY8H6KB5qFfeBd7Epu/t8YkEX5fMHYS+VdShSPG0lXff5kt2cUbqYi@vger.kernel.org, AJvYcCVmaRFfRkmlbO1746GOXsM445tI643Jlermd1emkbqmEvMmz20HQYvIlOOIg20PgkWkLcvG8sCttA==@vger.kernel.org, AJvYcCVubb+g4dX2iYIERGldCz3ClciwagGGybV1QqhVWJRG8iwGWpT5audPTvqrwecUxjvuggD43DKoTusXIQt62Dg=@vger.kernel.org, AJvYcCVwdAc8NZoIE2J/zk2K4a2sJOhoHAt+QmC4pddsN/GOcVEkOrgrh1F9iEuacyRQnq0S7DAhd6k2a0PXj0YL@vger.kernel.org
X-Gm-Message-State: AOJu0YxtugN8UxHf/C359l/OCHFqgBymRSndy7yMpcybAtGRNnNLaycw
	chp/aLjHff7yZSSv5JVVPBdlWtbGj3nqzRkFCZ61WMXGbEgT/ODoJV1Q
X-Gm-Gg: ASbGncud6H1dasuR44xebu1EYRl7umxuiEL0YAOTcyD+IDYFjVrhMM0tdGOTy9uAlDo
	UnMRToSop7hTcCuPf2bJafHF4XVt4A2RPXzCG7o7HJIA3d/ccHeqKtlMTcJauf+L43JtBtL1zVv
	GGI4jjLu2Sk7bFw7/nKpVHHiKEXqFwcFGMvaAk/SbvKeoI3qNXYq2Sp71P7HjmaYss+g6WCPFQ/
	1ISJJQdvlPEvMmCO6x2e1sZXVg/XxpjZ0LVLtIni+UU8H5k7KJbJJLS9MGi11H/u4xSofSkxj3f
	/Hiynoag/UYgp7S5AoNdD3sIoMEArPFjw+MbYU1VstqOY8SGHVK1hworxg==
X-Google-Smtp-Source: AGHT+IGvRDON52aC7F32xyTsDzrric4VeeMtyvVJzhPR2+fqKMhg0dkJITxDSB426QL/PeWs4NeQFw==
X-Received: by 2002:a5d:5c13:0:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3a6ed6259e5mr149097f8f.13.1750798703771;
        Tue, 24 Jun 2025 13:58:23 -0700 (PDT)
Received: from localhost ([2a02:168:59f0:1:6ea:56ff:fe21:bea7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45382373c6esm76865e9.34.2025.06.24.13.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:58:23 -0700 (PDT)
Date: Tue, 24 Jun 2025 22:58:18 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, xandfury@gmail.com,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	selinux@vger.kernel.org, kees@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] selinux: add capability checks for TIOCSTI ioctl
Message-ID: <20250624.3bb75890f0b0@gnoack.org>
References: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
 <20250622-toicsti-bug-v1-2-f374373b04b2@gmail.com>
 <CAEjxPJ6v12nLFx-x4-=esuPMp7L8UBvTzoj1kkTPcD2mDKKW8w@mail.gmail.com>
 <CAHC9VhS8gPQwgesV_0VbUuqxGrADm5uDofM3m=wZuAEgkWi5Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS8gPQwgesV_0VbUuqxGrADm5uDofM3m=wZuAEgkWi5Hw@mail.gmail.com>

On Mon, Jun 23, 2025 at 11:15:39AM -0400, Paul Moore wrote:
> On Mon, Jun 23, 2025 at 8:39 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Sun, Jun 22, 2025 at 9:41 PM Abhinav Saxena via B4 Relay
> > <devnull+xandfury.gmail.com@kernel.org> wrote:
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -3847,6 +3847,12 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
> > >                                             CAP_OPT_NONE, true);
> > >                 break;
> > >
> > > +       case TIOCSTI:
> > > +               if (!file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN) ||
> > > +                   !capable(CAP_SYS_ADMIN))
> > > +                       error = -EPERM;
> > > +               break;
> > > +
> >
> > So, aside from what I said previously, this also will break any
> > existing policies currently controlling TIOCSTI
> > via the selinux ioctl checking in the default case, so at the very
> > least, this would need to be gated by a new
> > SELinux policy capability for compatibility purposes. But I'm still
> > unconvinced that this is the right approach.
> 
> I want to add my voice to the other comments that adding these
> capability checks to the SELinux code and not the main TIOCSTI kernel
> code is not an approach we want to support.  Beyond that, as others
> have already pointed out, I think some additional inspection and
> testing is needed to ensure that the additional capability checks do
> not break existing, valid use cases.

+1 from me as well.

If the perceived problem is in core TTY logic, but the proposed fix is
in SELinux, it only addresses a fraction of the install base, as not
all machines use SELinux.

Also, it's not clear to me why the perceived problem of FD-passsing
with SCM_RIGHTS is a problem at all.  If a CAP_SYS_ADMIN process
accepts FDs over SCM_RIGHTS, it is the responsibility of that process
not to do unjustified privileged operations with these FDs, on behalf
of other, less privileged, processes.

In the more classic attack scenarios (as described in a series of CVEs
[1]) the process who had the FD first is normally the more privileged
one, for for those ones, the existing CAP_SYS_ADMIN check seems fine.

—Günther

[1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=TIOCSTI

-- 

