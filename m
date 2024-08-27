Return-Path: <linux-kselftest+bounces-16370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF59603CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0091F2296C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46F118859A;
	Tue, 27 Aug 2024 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TApA65aH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1F18756A
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745721; cv=none; b=r3T6OcZamHYWpbQteWMmtFIG8fr3ftQn/cVGxLk+tqtZLqQatUGrST/LqF+Hdixov8ggsU93TAiZ81tz/dzSY3byUJbQflyUnwgloZE0oFsZbw0ihSacujsvvQAHIufuf17RxClCsHEe8jdDSBvpNkgApi8nP8IU1BrZgwnPqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745721; c=relaxed/simple;
	bh=PuA1gLwSk4WwmDJR1lNXPA48us3ZO5qR6eklqYT2M3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InZu69XBqvYRuzNEoqDjPn4Kplw06gsMHOWyr0i+cV5Go754hDbzss80vOf8oC3+88JI6pPkYYZ06KZfImt7I1npjeiQdn+2YnVjANrRwYbETwhRULTtGcxjCzYzmMBcQ3y7zgrApFzia17/a/P6OvcKbBPrGsGbFDXw/Dfnt0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TApA65aH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c0a9f2b967so2244045a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 01:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724745718; x=1725350518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PuA1gLwSk4WwmDJR1lNXPA48us3ZO5qR6eklqYT2M3I=;
        b=TApA65aHF4TJ1ll3M1XutrX7ahLv7jPCuiTygDVzJ6Uq8SXz5LX88NJZS28745ewzD
         z7dOAQEmE3kAuIA7PN1oK6Bpbx/uLnGj1VbkBMJjOot5FGN7aYyBmDuSTX8trHCGuPJX
         PqxrA9cQ7uVOpwGbZ/l6bem8oYuaagEWXWrtOnFAiik7ClBDnxjErwyquQzMQWxKBn0H
         ZzMkiA4w98zalns7hkqPEX2gWPeYd+w7/rdgqCNHdJ4CLGwlV4QO/Xzbj64OvPytCclW
         1EqeolH6sIGlS49/MBwZXMi8ta06LvbT2xvfuKZ12hOueL+2WwxRjhoBQNquCxUWFuf0
         q/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745718; x=1725350518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuA1gLwSk4WwmDJR1lNXPA48us3ZO5qR6eklqYT2M3I=;
        b=xKkKT2dUeV4oupyYmJ9quIMEhktzQrXvcgVJykMAGWi5+Drxx0MgL/wYSu6Tx7ijwB
         zGDBvgpzyiikUFofLTnZGINWhqHp70hPPETpF5Mi3awhNB1eNVPksad/ItGnIKhe+1i1
         J1yAYOFKuEeG5IYtdZl9uM22yZImDR+eEYzwp/a1MI6nuzyAb2AP7HLgk7i3YpxyGI6r
         BLUCBjRVDz0rlL7+WhZ48UxP15ktvVYdWnerdkI892Oexz/O3SWnfClfuAceP44u8x4F
         JMtgnEBO0xkVEuQ4JhfLvyVUWjuMM2luBRI8urxmbBC3BvKBa5Td8NTsPJjN3C7PBEQD
         qUow==
X-Forwarded-Encrypted: i=1; AJvYcCWEhb0pQPpDRVaSD3MlhE5FWK+grXQsyqFJ6ZLwsQDD8OPtLhSVJ3ZILU8Mv5/Nx+UlPc6dZBAQaiyRNq8x4js=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfeZ12WQ++yswoARZvINlYczNkvY6o+KaFVmrvS9eBvE6dEJ/c
	6BPRDs2lRik7rdW/LIB8GTsi623mYpzlxlYlZSCy7mrq9XddGs1+ux6og/P11D1PgkV/niF7tp1
	A
X-Google-Smtp-Source: AGHT+IGGBA9PYVTwFBHl+4OYvwJUuL7D79H2eAjOStEoh4TX688DbRYtDD5Vmgp5xQcHv6BfUvtmBg==
X-Received: by 2002:a17:907:3fa4:b0:a86:8cfe:ec0e with SMTP id a640c23a62f3a-a86e3a60f50mr151768766b.36.1724745717891;
        Tue, 27 Aug 2024 01:01:57 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cf18sm76868266b.82.2024.08.27.01.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:01:57 -0700 (PDT)
Date: Tue, 27 Aug 2024 10:01:55 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH-cgroup 1/2] cgroup/cpuset: Account for boot time isolated
 CPUs
Message-ID: <7ropw3hu6low47tklrjj66zb4ldrzzes7rkn5vwfguu5jvvr3a@3lxrzrbqbod7>
References: <20240820195536.202066-1-longman@redhat.com>
 <20240820195536.202066-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agwofo3jpz2qgprn"
Content-Disposition: inline
In-Reply-To: <20240820195536.202066-2-longman@redhat.com>


--agwofo3jpz2qgprn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Tue, Aug 20, 2024 at 03:55:35PM GMT, Waiman Long <longman@redhat.com> wrote:
> The prstate_housekeeping_conflict() function does check the
> HK_TYPE_DOMAIN housekeeping cpumask to make sure that CPUs outside of it
> can only be used in isolated partition.
> Given the fact that we are going to make housekeeping cpumasks
> dynamic, the current check may not be right anymore. Save the boot
> time HK_TYPE_DOMAIN cpumask and check against it instead of the
> upcoming dynamic HK_TYPE_DOMAIN housekeeping cpumask.

Why is (will be) checking against the stored HK_TYPE_DOMAIN mask correct
when this mask becomes dynamic?

Thanks,
Michal

--agwofo3jpz2qgprn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZs2H6wAKCRAt3Wney77B
SfpbAP0d6LYT/BkVp9PhNDWIuCktAJHM4sCJGeXLeRVplyWwOgD/beF5yHs64/Vn
nRiEL2O014NlpIXc2YASbUZdcO7iNAY=
=9SyH
-----END PGP SIGNATURE-----

--agwofo3jpz2qgprn--

