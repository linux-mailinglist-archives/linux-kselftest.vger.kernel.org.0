Return-Path: <linux-kselftest+bounces-24511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2BFA1119A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1C33A119D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73F1FC0F9;
	Tue, 14 Jan 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIgh8ZIL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00D1FAC5A
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884956; cv=none; b=RjBUYzw6P4a+id2Ba65QtOXzJVtDQRxwZNtzGrW7qeGFshesghlz+ZbLteM9yR8FnTacANI6qEX6apFw1/JKS+EzZSBXyD+JoODnF/sf5ZTuOXD3e9q/U1J9iaK36KaXlipKKfp4oduNYvx4rfQG2giLdgFMbE1kCLueBT6OS4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884956; c=relaxed/simple;
	bh=G1NWNqJ3o0Xvmg9Lzh0JSizt0ZbxBRfw6HXipcTT9GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh7RZ4KBu3NZZYAh7o2gxqe3//H4sJ9x8t0IIi4DhxbtM5p0qnnaRBcPt2CEZswJBPu992S4KG8O1//jb6A4PRrHiZS7ZrfO+jQiRxHlVhYrgRT876iSQlm1npcvAXL9PH1q1lrUOXL/IsvLg5jAZcJ3WRryvCqcsktC1r1I+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIgh8ZIL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215740b7fb8so224325ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736884954; x=1737489754; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hveyb9aoAeVizaRGg6hO7M1qP+MaTyjktW+AITDIksU=;
        b=MIgh8ZILmrms4HrmimPHIB2jU+0iDLe6t9piLQOU3pOh1/2NhadWhHKK9bVH6N4coS
         5qSfg5a4vq6d8tO70BSspdST1SzvfzQWD+/lWfXtDB2Obz62QWSiRnijphTIVjEPGBce
         v/dsWLgJO3/zIzEFDkNp8LCClTgSbCY40Wb/mkoZw9N1KfGi/6dMJSU3/enYOTr3xr8d
         +Bv4IoM+0e4GiwA8h3i0Kzrj07o+3ka26yq7HogZnktqXkDvAumDgYcXfmYaL5wxamX/
         Zderm1u8g1AbAt101DZek+VwKHWnkjeCbm5Wie4TXmjavk7ODVi1fkQxc3lnXZz9qcIO
         r3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736884954; x=1737489754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hveyb9aoAeVizaRGg6hO7M1qP+MaTyjktW+AITDIksU=;
        b=bt2s8Tm5h3lNTUHuQC4GWsAiWoK4YmUSy6o+5/xGmBluWQR7rnG/xfNZC7WDlfKmxh
         12LUNgn4HSzBshXALbpmAWqwEA74alHke+801XAzxS7D35YIKDl3ArfUhGy06fe9D4kX
         rA5tfotfLAZgZ73WV0D7VHassSOCby3jrTQdxSavRaAq3g6ZEEAfK41Fr5mr1+gfZNJy
         K5EHQ/gjsCsRmouZa05S/ciucrDXI4fQseXAYxWxy9tXaYT7nYb6qNPkxUrDYT2e4DRx
         5FkVP82w5ZZV1vq33bTPPn1tfOgihVjOAVthgTWkPqWunIi/jdgtSiu9B0WNB3a8xHh7
         UQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9AFCkNRmur1Gjdz+/2dt6XexVPflEp2r/S8k/KxwIAQIITOWEBm8MomTU3BmNYgWZw3jUjO9JxdamHjVwdO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xepOvCk595DP/RwsCg2eK3kUX9nctZrDKzKNQ2n2Zu6qUGQT
	R7AFtSt8gvANAFd1hoBlXGKkEV6nRIOnfjP27sE7r8NJ7omlC8EnoG/PgYcrrQ==
X-Gm-Gg: ASbGncvsn84PMivao/GnCndAQh0gqQ0IIc0v49QtqonxHmhAl19EH806EB3pzQxtPJy
	MJnjh9JL8xuiYC+aGN3fvrheVcj5irRMMWO8wnHWrkeR5NKE1OhSNX9BUc+Gu96cM0P4uRW2bue
	dFedBENYMGHMJXMJ1oG3OpHTUT72l6vYrMwRriNPFXsbqcDF9QSZZo8YgZAXuKBuQRyT9Ll51gw
	vQ+N1P09+de59OTb8cJSWFaCVX6q8p0F44UVAwBuZW82KU6QXkzjtYV
X-Google-Smtp-Source: AGHT+IF2bVrYRNGKz3rWLJ9cyUWL1tYn9dVWhGa+vJQWRrJrlqeZGCgalALI2l4sQJoTdui4wjYezA==
X-Received: by 2002:a17:902:e943:b0:216:21cb:2e06 with SMTP id d9443c01a7336-21bf0e3165amr241995ad.19.1736884953891;
        Tue, 14 Jan 2025 12:02:33 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:5f58:5aa8:70b1:12b6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f130004sm70434555ad.80.2025.01.14.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 12:02:33 -0800 (PST)
Date: Tue, 14 Jan 2025 12:02:28 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <Z4bC1I1GTlXiJhvS@google.com>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
 <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
 <202501061643.986D9453@keescook>
 <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>
 <CABi2SkV72c+28S3ThwQo+qbK8UXuhfVK4K=Ztv7+FhzeYyF-CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkV72c+28S3ThwQo+qbK8UXuhfVK4K=Ztv7+FhzeYyF-CA@mail.gmail.com>

On Thu, Jan 09, 2025 at 03:30:36PM -0800, Jeff Xu wrote:
> On Wed, Jan 8, 2025 at 11:06 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Jan 06, 2025 at 04:44:33PM -0800, Kees Cook wrote:
> > > On Mon, Jan 06, 2025 at 10:26:27AM -0800, Jeff Xu wrote:
> > > > + Kees because this is related to W^X memfd and security.
> > > >
> > > > On Fri, Jan 3, 2025 at 7:14 AM Jann Horn <jannh@google.com> wrote:
> > > > >
> > > > > On Fri, Dec 6, 2024 at 7:19 PM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > > > > > > +             if (is_exec_sealed(seals)) {
> > > > > >
> > > > > > Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execution?
> > > > > > I've not tested this scenario so don't know if we somehow disallow this in
> > > > > > another way but note on write checks we only care about shared mappings.
> > > > > >
> > > > > > I mean one could argue that a MAP_PRIVATE situation is the same as copying
> > > > > > the data into an anon buffer and doing what you want with it, here you
> > > > > > could argue the same...
> > > > > >
> > > > > > So probably we should only care about VM_SHARED?
> > > > >
> > > > > FWIW I think it doesn't make sense to distinguish between
> > > > > shared/private mappings here - in the scenario described in the cover
> > > > > letter, it wouldn't matter that much to an attacker whether the
> > > > > mapping is shared or private (as long as the VMA contents haven't been
> > > > > CoWed already).
> > > > +1 on this.
> > > > The concept of blocking this for only shared mapping is questionable.
> > >
> > > Right -- why does sharedness matter? It seems more robust to me to not
> > > create a corner case but rather apply the flag/behavior universally?
> > >
> >
> > I'm struggling to understand what you are protecting against, if I can receive a
> > buffer '-not executable-'. But then copy it into another buffer I mapped, and
> > execute it?
> >
> preventing mmap() a memfd has the same threat model as preventing
> execve() of a memfd, using execve() of a memfd as an example (since
> the kernel already supports this): an attacker wanting to execute a
> hijacked memfd must already have the ability to call execve() (e.g.,
> by modifying a function pointer or using ROP). To prevent this, the
> kernel supports making memfds non-executable (rw-) and permanently
> preventing them from becoming executable (sealing with F_SEAL_EXEC).
> Once the execve() attack path is blocked, the next thing an attacker
> could do is mmap() the memfd into the process's memory and jump to it.
> 

I think the main issue in the threat model that I described is that
an attacking process can gain control of a more priveleged process.
Yes, having the buffer sealed against execution would prevent the
attacker from running the injected from *that* buffer, but
if they're already controlling the process, they could have the process
create a memfd that is executable (imagine a system where
MFD_NOEXEC_SEAL is not the default), copy the code, and then execute it
from there.

I spoke about this offline with Jann as well, and we both agree that
given that line of reasoning, this feature that I'm trying to add
doesn't buy us the security that I initially thought it would.
Therefore, we will be dropping this patch.

Thank you everyone for the discussion and reviews!

--Isaac

