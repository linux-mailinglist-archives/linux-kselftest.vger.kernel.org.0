Return-Path: <linux-kselftest+bounces-25870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D35A29CB8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 23:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E871677B8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 22:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7EA21579F;
	Wed,  5 Feb 2025 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnQI3naM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765021505E;
	Wed,  5 Feb 2025 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794843; cv=none; b=GZ3x/T5G/hxSOoNCHBox06JkZTgqtGCLInOL2j8BxJKweE2aB8VfLJuJaWc0atg42MErA73mc7slwO1+v8oBGv5szjrJZA/ZeqGxVX/nMIXfle6u89WoTUGpVy6BsIVZ+y/QfUSF158pbeVFlf+7iOp7uCxMdmo7DIVXyTu6WR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794843; c=relaxed/simple;
	bh=adQTj1m3gmGYNXK4mStiHNB3LW4uOX5cg557NJXyWLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mo2ubjuW0x1cQWwQagfzfTZytmk0taIDPP+FMUwki9qQiIHJJDWANpCFSgEd0+zrj9CuDJB56j6b8Ao6p+ZTzDE6ssXXdFJi2TlHyYkDVPr6anrY3J1CD0TQhD7qZM+bu+rdTG19IQfV7mdh5PTNA4D0d7EAd/P7o9jx08U3kUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnQI3naM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso308433a91.1;
        Wed, 05 Feb 2025 14:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738794841; x=1739399641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH0PP844QcNcNPk9KJKcMheXTiPkxbPOA82ZgA1T/p4=;
        b=UnQI3naMTvjl10Ht1JAwpbY89sVJF+46jwAiEiQNojjrCZa0YPVP68vBI2DclVwZsj
         DwqPjOCBEUZ1DKEaLzsiND+8rytrXpT+q+PI3T76gxT2QzFYxjG/PrHxzST7k9+G9ogx
         5OGHPjNlHSDyEKy27nXqVB2Nqju1AV47yJvNl/UWLyeSr0+VpqYfqNzAsch6KbSAklwQ
         2lDoGP372BjO5qAkmvmqkMUx0CoHApgSmzvn3vkREqEek0Ewi63GstUzofO5B08KnRDl
         qLTxOwSHiaM/c/UPDNqHdYwvAPhzyQnHSkgl8ffp8gANl928G8IpAHFmX/T7SiA06D7u
         xQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794841; x=1739399641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aH0PP844QcNcNPk9KJKcMheXTiPkxbPOA82ZgA1T/p4=;
        b=WdqdRkZaC6TN0ydHf8CcziUm/EwSYrYcASDu2Pqpcvp0ZNVyfxlb6YzJne9pOuj81o
         RMW3A9bZh1OgW3JAwLbN/CsT0OqCSxhFkNqdStdGPPa02r120mBqH5xgY8Biolv0+quy
         kHRYCtWtbwhFflcWnbSEWxPV9ulfjkeVOGpXmZIIyqlPBrRuBKiirvT37m6sfUZjVkcO
         3y8LXXlS0VhpsZVfHBpTDDgl9KiXa4QEplhOdFMe1u3NJPcoQitpyEqbfnKvRTULBVaS
         lxUVPZwgqw6MX/ISntQbeNk2fUNOmBrZ6QJFcichGs2PFnYW77LwBnGnbKX6NnFWCfum
         dvXg==
X-Forwarded-Encrypted: i=1; AJvYcCUpKVvuy1P4QkLo8PRAkYEj4N0L4cOxCzXx+J/PnUjCUYINB/0U6HqAk41nkSczscOss4Q=@vger.kernel.org, AJvYcCVBbF3BP59MCcPkMlz4Zz+4w79+TOOq5zeZjTeNm7JbeVrtMWWHbqku6Y1CB8ZWWWhs9Gf8y61k0NVHs2qCZYGY@vger.kernel.org, AJvYcCXzAyF2Y5Tk8k1nxr1LWUZg9EvTeMFVf4G+cA+8r23lz9SR9SgFLGzqSl4V2k4NmpDFoqkRrtiwylbty6b6@vger.kernel.org
X-Gm-Message-State: AOJu0Yze13gyABpoXoaMk/jr2tViXDxGCfzGjJ2IKHZxi3oDjWCvf16i
	eUJW/vJqFxr5rWH9DH+lzUHxYi7xZMTJppb77mt70RJSXYfUE9tnAbTR4tycP4MWgMS/w3YtRas
	DQw3crhHLnbfIKBz1AqPsZ0RhTK8=
X-Gm-Gg: ASbGncv4H/JpBzP/ZoYuPJKM/lh29aHuRbFxx/x34aEJD+hJMxM9IW4bi/LwMlCCqft
	pNVWy0jln40ESB08rLl3JlLYatzb6qGODM8tMUyV8bak8lnlMs49cNBA96DPbT3bw8gqv92tM39
	ub2sBnVLerrw7W
X-Google-Smtp-Source: AGHT+IH6yHRsB9eq9KiZric8SOM0t9kXIeXj+JN4o1GstUwwyKafghnVHjlRCz9+B53uZayNYUHtcYUXxEAC5jbqe60=
X-Received: by 2002:a17:90b:4c4b:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-2f9e0761162mr7556140a91.11.1738794840681; Wed, 05 Feb 2025
 14:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215206.59859-1-slava.imameev@crowdstrike.com>
 <20250122215206.59859-2-slava.imameev@crowdstrike.com> <CAEf4Bzajxh4xvg-aCaBhLQdNOZdhwceYUD2UsCcWku4ZBca_Hw@mail.gmail.com>
 <8831ed8fa183f76fefd71244360fa0ca35b11910.camel@crowdstrike.com>
In-Reply-To: <8831ed8fa183f76fefd71244360fa0ca35b11910.camel@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 14:33:46 -0800
X-Gm-Features: AWEUYZko0wvNCjmlnOayQjsFSvvwvnSSwF6aSmRgeSYD_fPO9Zvi5IoEhUcXP2E
Message-ID: <CAEf4BzYWe0KCzA4-qwAGp5n_ydJ0_zyLSO=Crr_vewFHzZ0t6Q@mail.gmail.com>
Subject: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and attaching
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: Slava Imameev <slava.imameev@crowdstrike.com>, "mykolal@fb.com" <mykolal@fb.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "song@kernel.org" <song@kernel.org>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, Mark Fontana <mark.fontana@crowdstrike.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"ast@kernel.org" <ast@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 3:08=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> On Fri, 2025-01-24 at 10:31 -0800, Andrii Nakryiko wrote:
> > > On Wed, Jan 22, 2025 at 1:53=E2=80=AFPM Slava Imameev
> > > <slava.imameev@crowdstrike.com> wrote:
> > > > >
> > > > > BPF programs designated as dynamically loaded can be loaded and
> > > > > attached independently after the initial bpf_object loading and
> > > > > attaching.
> > > > >
> > > > > These programs can also be reloaded and reattached multiple
> > > > > times,
> > > > > enabling more flexible management of a resident BPF program
> > > > > set.
> > > > >
> > > > > A key motivation for this feature is to reduce load times for
> > > > > utilities that include hundreds of BPF programs. When the
> > > > > selection
> > > > > of a resident BPF program set cannot be determined at the time
> > > > > of
> > > > > bpf_object loading and attaching, all BPF programs would
> > > > > otherwise
> > > > > need to be marked as autoload, leading to unnecessary overhead.
> > > > > This patch addresses that inefficiency.
> > >
> > > Can you elaborate on why it's impossible to determine which BPF
> > > programs should be loaded before BPF object load step?
> > >
>
> The main use case for this patch is large applications that need to
> dynamically load/unload BPF programs. Our specific use case is a
> continuously-running security application with a dynamically-
> reconfigurable feature set. As part of that reconfiguration, BPF
> programs may get loaded/unloaded on-the-fly. Restarting the entire
> application during reconfiguration is undesirable, as critical state
> data can be lost and loading hundreds of BPF programs is time-
> consuming.

Thanks for the details (and sorry for late reply, been traveling lately)!

I don't want to complicate bpf_object internals with this third
autoload state, as this creates tons of non-obvious gotchas that have
to constantly be checked whenever any new feature is added to
bpf_object (or even during refactorings). It does seem like you have a
pretty complicated use case, and so maybe some of the alternatives
would be just fine for you.

I see two ways forward for you. Either you can break apart your BPF
object of ~100 BPF programs into more independent BPF objects (seeing
that programs can be independently loaded/unloaded depending on
configuration, seems like you do have a bunch of logic independence,
right?). I assume shared BPF maps are the biggest reason to keep all
those programs together in one BPF object. To share BPF maps between
multiple BPF objects libbpf provides two complementary interfaces:

  - bpf_map__reuse_fd() for manual control
  - BPF map pinning (could be declarative or manual)

This way you can ensure that all BPF objects would use the same BPF
map, where necessary.

Alternatively, we can look at this problem as needing libbpf to only
prepare BPF program code (doing all the relocations and stuff like
that), but then application actually taking care of loading/unloading
BPF program with bpf_prog_load() outside of bpf_object abstraction.
I've had an almost ready patches splitting bpf_object__load() into two
steps: bpf_object__prepare() and bpf_object__load() after that.
"prepare" step would create BPF maps, load BTF information, perform
necessary relocations and arrive at final state of BPF program code
(which you can get with bpf_program__insns() API), but stopping just
short of actually doing bpf_prog_load() step.

This seems like it would solve your problem as well. You'd use libbpf
to do all the low-level ELF processing and relocation, but then take
over managing BPF program lifetime. Loading/unloading as you see fit,
including in parallel.

Is this something that would work for you?

>
> The above points apply more generically to *any* application that
> requires dynamic loading/unloading. Reconfiguration can be done via a
> restart, but that has drawbacks:
> (a) Losing any non-persistent application state on restart. In our
> case, this creates a lapse in security that could be exploited by
> adversaries.
> (b) In applications with many programs, load+attach can take a long
> time. We measured load+attach of ~100 BPF programs taking ~10 seconds
> when done with current libbpf serially. Dynamically loading only the
> programs needed avoids wasting memory and CPU cycles.
> (c) The application itself might take a long time to restart, separate
> from the BPF load/attach time. By loading dynamically, the BPF programs
> can take effect much sooner and avoid wasted restart cycles.
>
> This patch set also permits loading BPF programs in parallel if the
> application wishes. We tested parallel loading with 200+ BPF programs
> and found the load time dropped from 18 seconds to 5 seconds when done
> in parallel on a 6.8 kernel.

bpf_object is intentionally single-threaded, so I don't think we'll be
supporting parallel BPF program loading in the paradigm of bpf_object
(but see the bpf_object__prepare() proposal). Even from API standpoint
this is problematic with logging and log buffers basically assuming
single-threaded execution of BPF program loading.

All that could be changed or worked around, but your use case is not
really a typical case, so I'm a bit hesitant at this point.

>
> In the future, this approach could also allow maps to not be
> autoloaded, further saving on memory if no program needs the underlying
> map.
>
> In summary, we believe dynamic loading of BPF programs is an important
> capability that will improve the performance of CrowdStrike's security
> applications as well as being useful to other applications that want to
> avoid restarts.
> >

