Return-Path: <linux-kselftest+bounces-40180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F21B3A23B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 16:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C25E47B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 14:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3A63148A3;
	Thu, 28 Aug 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cDPB+8s6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55EC313E33
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391946; cv=none; b=CxW3zs548AQtyKZ/cRSBTkHatkQUEdUEwchyOgxZf3aYJsE2kisWLpgBrpL1QrvsWUdueuTgqzvlSUfbl78uMBR33D9nBDIU7CVWYs1mueUgrEeYdXw/k4XIxKoU3+Taf6fSMPXnxhW04mDG7l6N0edz5DIct/f5FrotLBtOlQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391946; c=relaxed/simple;
	bh=IPbm3EEleMFbUVespzsN0f+yx0VLB7ZL/rwtdsPEdrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAzuWAc3nLQVhaLjqk20K1R29Ob/Q22bzdwr2GnwgHefHhp4oOq4FoyFHNJE3+0+M4vNwaVojupOjvBSUz4QaT3etW8GWKI5v1Q2YppWGhrhqLbyZG/lVMMXLYefOzv9WNekyIW29zTdzD7Wct8RngwSVYsToW5v/1MLscHmJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cDPB+8s6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3cef6debedcso30722f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 07:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756391943; x=1756996743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iucEIZ4LkNYxckWKLsrRaxl+yyXGvtlT30ovvAVN0RE=;
        b=cDPB+8s6XqSk/1Ea8uOt6g1HRieHVwcDsM2SZisYufXOG8DFmdA9mz997oKvUQnMiN
         LajLLiBdyx/rADunnv/XYHdL9Kv+t4hb5PGkQwZn/G75q0nwtYoZ+o60bSJo1hWwCO/j
         Za0NXOE5a+mVY1W7mP9V76hAEdxfMC+r8bUYBRdzgLcWI5K3ohq0ZEdsXPXKTHAkSRmV
         T0XeXQ0tmWZEEOJIUvEo0/iD+Xsy326Umdgpe1YCQCCroiHVn455+040sp7+qzRUcPuG
         Mf+OwTS0O6accpDS3EBi5RTkXGK/+V47HnbwMP3ZMzw0MeCsdHoHEYxARf2dS0rp6qOL
         nN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756391943; x=1756996743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iucEIZ4LkNYxckWKLsrRaxl+yyXGvtlT30ovvAVN0RE=;
        b=SQHQImfIJJTZhSKf4JEDWg6BUqJeqi6GKGA50E3S7xxzRu7v+Mvhyp2ufo0ItjpSv8
         rPhYV0xuQJzCvuuRpMz+gt5y49K0xJXP5hhbg1FfasdOKwo5k74/5ABPpKTvFSx3nMY8
         zLkZBIVMhCIp+ziwhvLubr8srL8jq0gnqEYgpVEaJ16xxZfu8mWeCmR9ThJ8IgmAoFKU
         W+zZR9DsmLyKjEaHAGrzKkPhxp0rfKdohlY8RWApP5NrM/fGHFRq+gL1Et4aNLFoEWJ1
         MRAc0pj+SU1nheodKYo4A5bSIXVnBZjgeww0m/2BSig3ouJnr4jJGZT+vagzcYYmspjK
         OrRw==
X-Forwarded-Encrypted: i=1; AJvYcCX4/bA05Xvjcop89FniysYh8i1f2xUcgX4Gdfy+QbqbUZTdht8bmIMiBffe0aFO4vNhOMVwjFCCfAo367vy4gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqmMt1N0taykByVUQq365K4EAqL4YV3GWnOl66ce3aeELNSTo
	FgJSs5178NSDHQD4JWH31rGfFS1xeMPAWMknB8VAgxFdKIrMBttTvqxyazqL6TmHVPM=
X-Gm-Gg: ASbGncs8r1FQGH4lVvQfsngovSLkUNJnNc3zMHVZqwf9PUtZaKpCgy9AvAI8GV3mdij
	B3+/L3xwZwaA5SYS2qh0G87I6HRqi+1SpqsQMtSoWHYgQwG+H3N5+UNL/uFcQqQZoUdEl4vHetv
	10ahX25msZZOQBwjIbHXsK5y3AFk8jx+oRmFQgEVXYdhBwOBOYbjNgjvuCJFvGRBH09tqDRZZ1Q
	Oie7lSMQL3u7xe53iAkLIOSpvlMmybRxsxp2Q045lM9rvCpVVCspvsuDeoI+T10wUCFGNoUhAwq
	U5+CYFgSSqpQtCJCQhFLpZgpq5FaIQ/kKkE9K36gBHOyuvDs12l0ywouuN1YResDiiNgZPWva3F
	Sdmrm45sCduqE/aOt7+cP8mX0GG2qx9dnT8CRnHa5Rjw=
X-Google-Smtp-Source: AGHT+IEETnhwgNf+iEEImikgXshAoM3ByKssB/yJbmHC25kj/2urjm3QbTo/QrJZdvSHWPBi0xGjZw==
X-Received: by 2002:a05:6000:40cf:b0:3cd:fd51:f6d1 with SMTP id ffacd0b85a97d-3cdfd51fbc5mr2081166f8f.0.1756391942818;
        Thu, 28 Aug 2025 07:39:02 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ea46b3b7sm10776165b3a.57.2025.08.28.07.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 07:39:02 -0700 (PDT)
Date: Thu, 28 Aug 2025 16:38:45 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Djalal Harouni <tixxdz@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, shuah@kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, tixxdz@opendz.org
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
Message-ID: <m7laj6747wtu5r732iph47zn6no3mbu6iq3mne3zslzyqlq523@7tmw25ap77ek>
References: <20250818090424.90458-1-tixxdz@gmail.com>
 <356xekrj6vqsmtcvbd3rnh7vg6ey7l6sd6f4v3dv4jxidxfd6m@cepwozvwucda>
 <0e78be6f-ef48-4fcc-b0c7-48bc14fdfc7f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k5xghjz3fialy6l2"
Content-Disposition: inline
In-Reply-To: <0e78be6f-ef48-4fcc-b0c7-48bc14fdfc7f@gmail.com>


--k5xghjz3fialy6l2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
MIME-Version: 1.0

On Wed, Aug 27, 2025 at 12:27:08AM +0100, Djalal Harouni <tixxdz@gmail.com>=
 wrote:
> It solves the case perfectly, you detect something you fail the
> security hook return -EPERM and optionally freeze the cgroup,
> snapshot the runtime state.

So -EPERM is the right way to cut off such tasks.

> Oh I thought the attached example is an obvious one, customers want to
> restrict bpf() usage per cgroup specific container/pod, so when
> we detect bpf() that's not per allowed cgroup we fail it and freeze
> it.
>=20
> Take this and build on top, detect bash/shell exec or any other new
> dropped binaries, fail and freeze the exec early at linux_bprm object
> checks.

Or if you want to do some followup analysis, the process can be killed
and coredump'd (at least seccomp allows this, it'd be good to have such
a possibility with LSMs if there isn't (I'm not that familiar)).
Freezing the groups sounds like a way to DoS the system (not only
because of hanging the faulty process itself but possibly spreading via
IPC dependencies to unrelated processes).

> > Also why couldn't all these tools execute the cgroup actions themselves
> > through traditional userspace API?
>=20
> - Freezing at BPF is obviously better, less race since you don't need
>   access to the corresponding cgroup fs and namespace. Not all tools run
>   as supervisor/container manager.

Less race or more race -- I know the race window size may vary but
strictly speaking , there is a race or isn't (depends on having proper
synchronization or not). (And when intentionally misbehaving processes are
considered even tiny window is potential risk.)

> - The bpf_send_signal in some cases is not enough, what if you race with
>   a task clone as an example? however freezing the cgroup hierarchy or
>   the one above is a catch all...

Yeah, this might be part that I don't internalize well. If you're
running the hook in particular task's process context, it cannot do
clone at the same time. If they are independent tasks, there's no
ordering, so there's always possibility of the race (so why not embrace
it and do whatever is possible with userspace monitoring audit log or
similar and respond based on that).

> The feature is supposed to be used by sleepable BPF programs, I don't
> think we need extra checks here?

Good.

> It could be that this BPF code runs in a process that is under
> pod-x/container-y/cgroup-z/  and maybe you want to freeze "cgroup-z"
> or "container-y" and so on... or in case of delegated hierarchies,
> freezing the parent is a catch all.

OK, this would be good. Could it also be pod-x/container-y/cgroup-z2?

---

I acknowledge that sooner or later some kind of access to cgroup through
BPF will be added, I'd prefer if it was done in a generic way (so that
it doesn't become cgroup's problem but someone else's e.g. VFS's or
kernfs's ;-)).
I can even imagine some usefulness of helpers for selected specific
cgroup (core) operations (which is the direction brought up in the other
discussion), I just don't think it solves the problem as you present it.

HTH,
Michal

--k5xghjz3fialy6l2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLBp8hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjsxQEAnKdbH9e9i+AM0uU2XoOx
WOwY0p0bJzdNOs/CKDWmexcBAJWoa5XhMLAt9worCmHF+E1gfKT/4Ay9P/xEIC89
hxsJ
=u+pg
-----END PGP SIGNATURE-----

--k5xghjz3fialy6l2--

