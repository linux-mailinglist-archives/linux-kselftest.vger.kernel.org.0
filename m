Return-Path: <linux-kselftest+bounces-45645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03DC5DAEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFBB74F7A58
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB26032937C;
	Fri, 14 Nov 2025 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KhJzHNq9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD3329374
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130781; cv=none; b=OSUT4t4LRQW5yCmzm96vNJ8HnV0bSUaj2rqcjA1O174rc68tWYHe1qTkhBvKID2UIWKk477I5BZIpD+iasiycdIPeneFS8D5fxUwPXtwglrQA6V1DJOPdx+pdvtPUZNrcXrhBgWSFLoskQgJcItcHuM1fq19XIQJCpLBTcyV3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130781; c=relaxed/simple;
	bh=7qdco/QQvfGWM5vwE9iQYYA+QwG3ILtDr3ENUSIC4O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s55hdeIxD2I+gMkmnmSxOt1ZYLV4Z84bU9X4VE9R9mW9PWyByPfB/jJq4PDhnxVtibSi8vPAosjBVq0jj2Dv3qrblE+weiwAw9fpSasNpbna/adRR14UGpE1+G5KP6IntH/1l2eik8ySClaHMJHrU7Kr8W8K2g+/JbS9jsvy/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KhJzHNq9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b379cd896so1342904f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 06:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763130778; x=1763735578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHqTLrvZxttCqzjtuiPn9ni3n+eqD+EeRxjlL+RTa5A=;
        b=KhJzHNq9Qm3WxOEZVsZ8IvfQYaYlrptlUXjC+PVQ0nVVXKcSN1KrzNv0Ep9JsGJOfe
         MyjP3oTMqOHXBuhmL/BwVUKQ7VcVQ/sj9xA3Xoc12LF8f/B2qLgiTpZoU9B030dUhGyf
         wAsA9dBltlGnXrY4aFh3AS4RVVFgprre6Juw/XvxFwtbu2WRzJrAvK05lzJ8If1Or8Go
         MgCH4lgUUtDn7bunqj5rcrBO1eiV8qGhBt4OLwszV9RjeW6mv6hxrUh2nvQV4HQYZIak
         eX5jFNYUcfVJsGq25/vgSg6BHqt+4e191FO6rhp3SON10XcT8ehoHZs0IgK+MpArV6ab
         RPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763130778; x=1763735578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHqTLrvZxttCqzjtuiPn9ni3n+eqD+EeRxjlL+RTa5A=;
        b=iWIwyhwauUpDDZV+2Vfz5Y3SFNspvh8k1cCyz6UmCsFM/vgQ1l+lITq2/7l01p2mML
         BSNvdkihIdhv5dvCecV//Vv+q6eHyYYWR0YsmPu7SoczV0laCDNtJG57SUXmmBPCAuxf
         pB9F7DrUYdW7V0zSBotl9OsfGfWtR/6G4ORO7E14v2PJF9ijcpNTt+qMrRejQUtZWGJr
         TPcY9jBChJIxskhXhqMnffI1X603EjkHgEu3tyORkwKFJxCeaQRbc3l5gCUBSd64jExL
         JZb8POnwKLBOveJpA0tDieuTg4FvPJmOs2RP7QoqZH1wyToajmVL9mrlR/UNzSwC1baq
         4TLw==
X-Forwarded-Encrypted: i=1; AJvYcCUDHABYkJK22fxwwl7Hh//vicOIuBlxxCgt66BlfUBM8WgXKzlOlT2bR87PyPID0ef6N01ShddCu95N4/yX3Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQy1ezkobyUe8MBPnWJS3C4Jex5dq0CJUB33okIuTHGzoK9ga+
	is3DS9+qxIgEfXCSfBVmc7Pk6APGMHRUeBLB5Wbgn3M5ZsjC3sKfZmcQdbk5NGDYNzY=
X-Gm-Gg: ASbGnctGPWC4tGaImYk7NZzpKMTo3F697Dh7mif9ltCSoi6DCC4M7LE/f4AyX2/TQGP
	fgegUSNoPIS4ZpHputsQsi3tjHzUeuQdvLNFkX/2OuV3mdTgOv+lc05EC3Yr2shDAlfxdwI8Mtc
	pa9JG2BQ9TcSvW5WaPFDk4kkQbc4dZznaV09lbdKAPPmZq5cjdCWshKI8zGRf9tt9f5E/lP7Z/Z
	ZX4Z/8qXvSaxJk6qI7+XVRvDX3vGj+WhSBhRhgciJ+0kCoMElK82fpJdYaIu0o8g4zM0LDreBfH
	jWDKtkRdzLy1pvUq5NZ1PH0qsvhzLu6VjDLy+B8oecQnNH8O9wekEhmD65uxsMLC/BHokdkAG0n
	Zkfq48pzYB9xUwTsXAtBmWCmSyLqIOIs3C/XxrubwqtlA+EMabqGVqW15bsqJPzXh5vnxmbJPXZ
	72lYkAsn2LR9OsLQ/VVXwt
X-Google-Smtp-Source: AGHT+IH26aVrRDzlChufLyFGmxHyZGqRsdxpVP+1rmEkehnJenvkfGQPqfiv7exots+Nxemc71ThZw==
X-Received: by 2002:a05:6000:420e:b0:42b:41dc:1b58 with SMTP id ffacd0b85a97d-42b595adf22mr2877337f8f.45.1763130778179;
        Fri, 14 Nov 2025 06:32:58 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e84a4fsm9898656f8f.11.2025.11.14.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:32:57 -0800 (PST)
Date: Fri, 14 Nov 2025 15:32:56 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org, 
	cgroups@vger.kernel.org, sebastian.chlad@suse.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/cgroup: conform test to KTAP format output
Message-ID: <h3sy3xfvxuxyqf4jzaivbquff4f3uktr5c3khohdguc4yhll2a@wcnaig6ywzqe>
References: <20251114102440.3448810-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g4h64q4o7bv5knqa"
Content-Disposition: inline
In-Reply-To: <20251114102440.3448810-1-zhangguopeng@kylinos.cn>


--g4h64q4o7bv5knqa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] selftests/cgroup: conform test to KTAP format output
MIME-Version: 1.0

On Fri, Nov 14, 2025 at 06:24:40PM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> Conform the layout, informational and status messages to KTAP.  No
> functional change is intended other than the layout of output messages.
>=20
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> Suggested-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
> v2:
> Change subject and commit message to refer to KTAP instead of TAP.
> No code changes.
> ---
>  tools/testing/selftests/cgroup/test_core.c       | 7 ++++---
>  tools/testing/selftests/cgroup/test_cpu.c        | 7 ++++---
>  tools/testing/selftests/cgroup/test_cpuset.c     | 7 ++++---
>  tools/testing/selftests/cgroup/test_freezer.c    | 7 ++++---
>  tools/testing/selftests/cgroup/test_kill.c       | 7 ++++---
>  tools/testing/selftests/cgroup/test_kmem.c       | 7 ++++---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 7 ++++---
>  tools/testing/selftests/cgroup/test_zswap.c      | 7 ++++---
>  8 files changed, 32 insertions(+), 24 deletions(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--g4h64q4o7bv5knqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRc9lhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ahe2QEAqXn/k67ocURIofRnUExh
KUI3pYqs9HZu/dh74vHFlxMBAJL0kE3aiHgntjlZGRcjx7182xtPvQZRDm4Ah6+w
zGoF
=zjpi
-----END PGP SIGNATURE-----

--g4h64q4o7bv5knqa--

