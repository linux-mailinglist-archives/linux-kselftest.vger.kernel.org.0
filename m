Return-Path: <linux-kselftest+bounces-39955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A64B3699D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 16:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129D17A1C84
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0973568E0;
	Tue, 26 Aug 2025 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WUIF0PYV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A135334B
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218372; cv=none; b=U60bZdMP3VLlh1UxVkKgK+yoqAuZbA1aBfWNdEo6gjM9nv6Gd7xvPyyGUsBIAUiMgZPVYb8R87z4rcI8ZghS9ezOZwtTV9PTRYQ8aVOo4fK3zM1bueN1ik7cHoQAbEge4qnB6hWWGM4iQTD+YLYcLCoAxgiYztICpKqZ3B5UznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218372; c=relaxed/simple;
	bh=q9j2PZULGXZHOrc5kNbcezwPm4NZHYRo32d1BVrCjbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrKkY5A0rHAjm/iPA8rVmxMLNiJTZHU3h0O5jmDuNBGqEEbuRExoDiX0IYgfOgE8D0LYAt21ajHcrFqi7+2SoCA7QieqlXeteAsC0Wks5BacHU8DsQFmpNISz7+S44lJZ0I6eC2gYYUIiGyX1iS14U0KI4hoVXL6OKVG7ODLr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WUIF0PYV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c79f0a5c29so2621658f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756218369; x=1756823169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q9j2PZULGXZHOrc5kNbcezwPm4NZHYRo32d1BVrCjbg=;
        b=WUIF0PYVPiP61ALt5gogMALHqiaWz/BjzD7eEHWaUi5ZNbc3CFbkrwCZngCUd5Xrfg
         XtZM/elqZtL9XlkqFYAH+uC+uZqIvP6AG3XI1lXB1LeU9I6InRqAXPE1kJsNrY+L5c7A
         K9kLx/hEmYvQEON37u/5ziS7tZsu4bh50LmRHdhGoUk3YJmf4t2ahz8yGTkbUKSQEIft
         yGnqDCxda1n3nUz2n9noWr4Fqo64+MLCG1gr3yZgErNhQ/KwjD7LUFTzC3k8xiBlzITQ
         gt0ueC0mzs8B3B9W0Fn9nuo1IGQ7c7ejQlfToC0ZKyrVLOeG0/0B6C4KRyuFUwIrAodq
         criQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218369; x=1756823169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9j2PZULGXZHOrc5kNbcezwPm4NZHYRo32d1BVrCjbg=;
        b=Ice68aK0RcskJSl3NjMTGf1qtfAtWp3OcFtGbLjHCDebKCKptkp1ApPp832uC3wkRY
         ZghotQSmfX0kEFW1EccGdXIZ+n8UCsYrmssXP4LSaMeVCpml9/6/sTBlCkL2Q8B7nsyg
         NgLwVHapxJH9vkdFMPiEiPLd/Af0HpzMsyAZFHu7a6mRnRiSbpm6uSuZvbSYZs5k3CSX
         n8QP7oMFZ3AGlzXfjg2/b7HqLjRblpJhEtnrrkJXS5o4ZTDPqFiuckwDkhW8lzTzVSIK
         Sm/Zyph3KvmKSLsH/wUEYyiK+NGSwvCwclpX0BVDWQhIgp0nC0/fStAdKwcQPmi/lmCP
         7J+w==
X-Forwarded-Encrypted: i=1; AJvYcCWbwCc9KVFr6WIua7YSNg63J2ZUch/qtAiSV2+s7oUNaBv4C5+TH/mrlsFKxhTwtrs25ISBALNZq6AI0nVg8y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwk+ZuC+oJSnwuFdsuCa8gFGLWWLWR3xGWYLfWG2IEnygXRvpr
	wiySNnPPRJShcDUS9kmyg6/C/NjBKjzbzM1HBWUt8/Ociu5afVlQkC6rTBuQaqWynh0=
X-Gm-Gg: ASbGncsasY1y1Ac7XYTVO1MKASrZMCnpymUYBZdPYxyWuC4kF7Sj90R+S/DftAAmntr
	Tlke6F+ZhidP3OQQ0lKbIABF1KyBOsEev+Q1IbJRVUhoWJ+dyn6D614ONqpor5KQHIIbdROqtA1
	vtmdmZfKQDJUtk4UsKAs7BcH0FatfupXlb25czTlLjnseo70zvV4Y5KPR6dOOaEwXhHBDl1nnKK
	gAT8/DVCf7m+Z1LJ6h+hhAUQPlcxVunq9aTEUhsXFAVORq2xXXfaGoeVyz7DFlyXgH8ob+P+icw
	FvE7xBEoT2Ctq3tMH/E7umu/TrHwTLJCaEQkI0A0q1JVzEW1pQ9+iSuefMGl6H9XopYKLPst/B0
	AFGmJ9SfxBLg4PgODhYHMf5xuZc7uFzPv0ENnfGGHZA8=
X-Google-Smtp-Source: AGHT+IHNuSehu+kC/8JT6eOvIgtP+0NWIiWUAOSb8fB6NxBNImXOnuq9wHCo/AxRrqB9def2TYx5ig==
X-Received: by 2002:a05:6000:40cd:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-3c5dcefcf18mr14788726f8f.58.1756218368812;
        Tue, 26 Aug 2025 07:26:08 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880368sm97231965ad.109.2025.08.26.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:26:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:25:55 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Cgroups <cgroups@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, kamalesh.babulal@oracle.com
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at
 remote_partition_disable
Message-ID: <hyqcffknmjwjuogoe4ynubs3adk47t2iw4urnpjscdgjjivqz7@b5ue6csrs2qt>
References: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="23hhozo72xquqq7g"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>


--23hhozo72xquqq7g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at
 remote_partition_disable
MIME-Version: 1.0

Hi.

On Thu, Aug 07, 2025 at 01:57:34PM +0530, Naresh Kamboju <naresh.kamboju@li=
naro.org> wrote:
> Regressions noticed intermittently on AmpereOne while running selftest
> cgroup testing
> with Linux next-20250805 and earlier seen on next-20250722 tag also.
>=20
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Intermittent
>=20
> First seen on the next-20250722 and after next-20250805.

Naresh, can you determine also the last good revision? That would be
ideal to have some endpoints for bisection. (To look for any interacting
changes that Waiman was getting at.)

Thanks,
Michal

--23hhozo72xquqq7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK3D8RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjraQEA/sATM9lqrOJV8YGvjMwn
+GWni0VR34BMM7mWvDUzGxEBAJpsvXzuNyDJBDJGhCreK69pFRuLZ5En4BTai+Fu
Oc0F
=Z4+0
-----END PGP SIGNATURE-----

--23hhozo72xquqq7g--

