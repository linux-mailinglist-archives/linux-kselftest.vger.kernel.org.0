Return-Path: <linux-kselftest+bounces-45572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C88C591B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 18:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 805C735FF16
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD80351FC2;
	Thu, 13 Nov 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bv8M1sdP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743C26A1C4
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053659; cv=none; b=Zg6HO4qRg6LsaZqInS/1sb6oyEQzHfQkhhJtgGNKRWNAUkVbDfg4mN8U115oOBUVAjr6q2SfgPuTYChXMZWjUbchJqQDZYWm3f+94lkpkz4x9f2D8vQhwD3paBLOhJXua0VN9FoJ3RwQ+57ekQLjw92Yxb8r3h6AA4W28FohMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053659; c=relaxed/simple;
	bh=3wHzdTnzv/9koblQs4sk6PY2OUVV0EFT9zAT0iA+YQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz/Lg4b0E6O5wHkWYEpjwfG4JiGnQz0u7Q/psGXq3FGo2udEZLWAIJXaN+YJjerPrAKRziBMNM5dT/o9n4BiSKlZmqFcOXMR07xSlqxI4WatxklLBQOa5VgpXM777sIKt48HzeS3cnDUO/LHuKgKhlyhnAo2q+//MZqdv5xjY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bv8M1sdP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711810948aso7673155e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 09:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763053655; x=1763658455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJwtOPWKmmTBRwvu3K3EIMtulS3eBFOLsMuoPcJT6P4=;
        b=bv8M1sdPv9k28oZt7NxnZh8yQ8JaHVqhx1lnLNb2BqCHU2JFNpAsrWi98GuW0VRHlS
         0vfV9gWXmN5ghLZrutVLjEZLAE3W2O4dnAFRII6fabQ45fHxrV/JqYa6trTeq2ZZh7Hb
         oZDA+8a9590BfSHIDVpTTLX/gRFXSvyiYqh8devGZtpnMXDsLbeCsVTgYBiU4yP8OUKz
         0pty2mr0yHspYF06nM3zwBiqiLWLhwR5x+NMquWtK3AIpNzMNA9LK9zgT2EGMZNLIHOS
         /c5ep+jEJEPsz4Ep6Q1VLaHxW8ZS4El4r0mgF7u6VJbEAAFzSJ//VZ0KIKVo+UX2zt63
         s7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053655; x=1763658455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJwtOPWKmmTBRwvu3K3EIMtulS3eBFOLsMuoPcJT6P4=;
        b=nClfxv+7y2hUhUWYE37BK5zWZHfhX8wZfj0Ng2uA+3+eSSVyVDqloegw6Thd4XTIFE
         tR8nHK3txjjQ2gsEwxxruTVvdEbmEap6eGkhnougMAV5ke/0N0kjJScwZC+dxZXiUSc8
         xikZxxpdMsbX3p/ddyCnaLbPaNrF4ShdPnvnptu/3YfXA4Z6CXxx+RIoCcP34du/xhCR
         AbtDuSiabEwDF6u+H579LSRPxYpsrUvJG2tO+uc/2guCF3L2sUyASZNXjBzkNQN4HDyz
         QstK6Nq5Eq8CzL07w7r+aPhaZP7D2VhEaqFO92lgdZDghY8cVTBj6OqeBtB3vm+0TCHW
         KPLw==
X-Forwarded-Encrypted: i=1; AJvYcCWhwYAyxrdPIlFpmxFC5emwbDOxj9gBLPMeCfutDQXmoTdLR+W3EMnzbJtiCyvTjb1RjWZCYk6E55XSxj0DPcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIbhys3GRf0fAMnGSiSKgWa0nj5g3jyQFGOXREOImNHjD2Cpu
	CsxQ+hLjg+eRFmGpb8DBiN5RXfavaNDsanvmcpqXBeBPbGxB3RRa563Fd6cstV2jdsU=
X-Gm-Gg: ASbGncsktN3Yi7hNpTVDg1ZJFTCsUT44NKxHxoIdJRjqn7+WGUc0LtyvSTafQKMNt89
	npOuPabnnwYZeVRuvrwdHYrpp6ItHMQL8jI4ClUdCH+mvEQfdiQt+g4ITHa47CJhydj3nBQfWR5
	rynpjEf4InqpDIH5GaV8DBghQ2l6bB9kxyCcvJo3nEiJtQBVwlliPM7g68WgOY6gEmhBhJMiGUD
	lpjEddfvJucPbHfu0+bvQIii1lso+WGNTKtmTirnoMnR9AUTS4/G6fXlw41+32vlwCw+aubTlli
	CGTje0KnIks10yU/TKkjcn/Rpf/UTn+OtUm1usSdiKMGIc0hbSGmrb3LYf3j3RyUKePyr+3D8Ge
	Bu4L67ifippEFTly1OREswTycX6hECCUBVrVP6yTkZZ9mRRbJ3MdmyWVPYPP8HN553xLiljkw7e
	6EXDjAXtzGS4jZzpdRVIYJ
X-Google-Smtp-Source: AGHT+IGEwb65FvPJGLb66aSr9nqC7poeWs9ugZLSftaq0Hld+3M0XPCgYNsTqP6hCKw35URKMlz8sQ==
X-Received: by 2002:a05:600c:4f07:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-4778fead9a4mr1762145e9.27.1763053655325;
        Thu, 13 Nov 2025 09:07:35 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e442c2sm106055695e9.7.2025.11.13.09.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:07:35 -0800 (PST)
Date: Thu, 13 Nov 2025 18:07:33 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, cgroups@vger.kernel.org, chenridong@huaweicloud.com, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Message-ID: <lhfcykirz5afdzdc6wnroubsdhasww4gsfri4dxpzagiejjbep@322rtmyvwiyd>
References: <20251113131434.606961-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7h7ewfrvbadf2ean"
Content-Disposition: inline
In-Reply-To: <20251113131434.606961-1-sunshaojie@kylinos.cn>


--7h7ewfrvbadf2ean
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
MIME-Version: 1.0

Hello.

On Thu, Nov 13, 2025 at 09:14:34PM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> In cgroup v2, a mutual overlap check is required when at least one of two
> cpusets is exclusive. However, this check should be relaxed and limited to
> cases where both cpusets are exclusive.
>=20
> The table 1 shows the partition states of A1 and B1 after each step before
> applying this patch.
>=20
> Table 1: Before applying the patch
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> mkdir -p A1                            | member       |             =
 |
>  #2> echo "0-1" > A1/cpuset.cpus            | member       |             =
 |
>  #3> echo "root" > A1/cpuset.cpus.partition | root         |             =
 |
>  #4> mkdir -p B1                            | root         | member      =
 |
>  #5> echo "0-3" > B1/cpuset.cpus            | root invalid | member      =
 |
>  #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid=
 |
>=20
> After step #5, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
> use CPUs 2-3, so it would be more reasonable for A1 to remain as "root."

I remember there was the addition of cgroup_file_notify() for the
cpuset.cpus.partition so that such changes can be watched for.

I may not be seeing whole picture, so I ask -- why would it be "more
reasonable" for A1 to remain root. From this description it looks like
you'd silently convert B1's effective cpus to 2-3 but IIUC the code
change that won't happen but you'd reject the write of "0-3" instead.

Isn't here missing Table 2: After applying the patch? I'm asking because
of the number 1 but also because it'd make the intention clearer
;-), perhaps with a column for cpuset.cpus.effective.

Thanks,
Michal

--7h7ewfrvbadf2ean
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRYQTBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhD4AEA/GWWlwm3wrl5ni3OWMly
l1jxes5Q5f9YIl+tVi4awEQBALGU4JhCDZ5CMZflO9yIUuFRu7zXymMjo3Zgx7Wf
1OAH
=gUoG
-----END PGP SIGNATURE-----

--7h7ewfrvbadf2ean--

