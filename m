Return-Path: <linux-kselftest+bounces-30680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5925A880B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14EA3B3560
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5F1261381;
	Mon, 14 Apr 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RsAdBq9H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5928FFF8
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634584; cv=none; b=B7K/qgu/f4tYRJTKtthYM35P1n4N+kmZDa07ihKFINvvtlK95wMhusK2R8eqz7cHpZVI5h+VMUaQayOcA1jcOzO7ezMuO+4L/80lVBbp7T8b4Vbm3LKhfQ2CfUF0RUdYCoGiw+cZU4pUKRDfXtApml7uj01Igr/YqJYGTvdjGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634584; c=relaxed/simple;
	bh=mkz2kA+VXnowiojV4uf1dKbm0WdGQAV1VMpX8sQUKbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQO1+n2lov17WsuVmYXUjy/0/TwVfUt+ugK7g1GY1ql57fi89ckOcBMauMO9MEhOCpPJtN+7gZo8V7bQ4gDiIFuC38vM6ric01gP5RTUy9SkJEowYilzIhFBwT+oG4DKdfRszclxPPMEbWWFDpbr3CbFlQu9JZO5sSelhR6+Ox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RsAdBq9H; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edb40f357so35853075e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744634581; x=1745239381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9ixK134YSYVvgH5n+g61PRZpWOKvjguSgzISWbKA2I=;
        b=RsAdBq9HVJZPiOtXUhr4Yy/KlVOOZMiHRMjgSA6rTYzvprpodglhgCe5ufVYdoKibL
         1r07vATVUoCqq6TBJy6lAKDgNlWF+bJ/MvQuCTgQmOut9arLH8yx/qcBWqwYJpXeOhBB
         FY/v38ZLMLYhtF4tJPQABh5tWzqdR/N8Jorf4VnIpfIjK+uhCpgx80E5nlah9UD6b1uB
         pNyyc3FS3pj+HOAnhgVzadQ7ZOaKiMLytyubPxmgTsBvYxl8NJikCWdhw9TBfJOnlQYB
         kB48EmwtrizcPpkusu0Hfxj2cwq5wwHaWVBE6ikvBJOJBOQJ2biOkKYEoYeI+MS0pyCd
         rJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634581; x=1745239381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9ixK134YSYVvgH5n+g61PRZpWOKvjguSgzISWbKA2I=;
        b=MPXiiErtFtw1jtt0rv8/OF8RJz5sj1vuZFL05CYFBSsFPCIxq7ZUATOGWBCU8wm7xe
         lWBgwi6TBjsXAqEho53ISS0iUQXXQIUPKW4N3jSPR9+XlkTLUrrsFZ0Rem6zMiN2/0Ud
         KaZsFSuOelOp9dk8AfVbzAJZ5kLJv8nLYusMt0wBaFDfRYXPN3bPpEfGtJ711vJfoY/5
         khF7X3CWjGdlUbqnG0UY1kSA7WEBST6mPrmbGgWS8de9U3rzulR31NclCdxTETMyhwE/
         0Dwd7LkVjnLOhYgCuj2b8fgd0PEFX21bkWBsgp0mANwEgtcS5MZX6WQH7gX54qctXsJ4
         kDNg==
X-Forwarded-Encrypted: i=1; AJvYcCVxoEgNMDMgDrj04spSq6klAUlIdNDU4C4M0UgYAUSb864fCKFUo+Yr+z8gEfsDaNptrfiZNtP+li1Cqi5Yt4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZML7hUpgsBjr2I9iqsJNIVWyiw+37KkjS4cLyVdzVJXYDs0D
	04z0X5ZSw0ebFqCacIPy5f14Mat2ntDgZVQKHOVUHZondY5A6Cf9400dSZEbNJg=
X-Gm-Gg: ASbGncu3Wbk8vnu2FDb0+smaJYaRA+1952hqzyGqvaWZZ+UBiHHoWenuikZnO+pzp/L
	pk+3l5SFjfkBqGD0318pOcqbBdZ8y6X1j4CagFVHgMIVl3JBjvH/vkri8FB+Rdol/H3XwPUwZt3
	Nw1gQITPj2i72KldrrfylHJxMU2mdCSqApB7iQzT0R+tc8RHpOC5v4gHgjRmS1GgFsZ9ccIPfwi
	Y2sbpQqVbG9tNVEYW2Kd4R2mIUDDwfhBuHrG4qIGkLqPcrCTKxIFWtAHO3IV3s7FU67vWy4F08Y
	jZLVpqODTE2oigOhzG8RB5J/C2PhisZ3NkRr6JVjR9U=
X-Google-Smtp-Source: AGHT+IH7iIHRZ3vV/WkqxRDldhrP0zYk3mfrclbeNsJTpYta2piT0N21vJ20EAFWMAd7XZkrfuQvEQ==
X-Received: by 2002:a05:600c:8519:b0:43d:300f:fa51 with SMTP id 5b1f17b1804b1-43f3a93ebb3mr104821235e9.9.1744634580452;
        Mon, 14 Apr 2025 05:43:00 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm173048895e9.23.2025.04.14.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:43:00 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:42:58 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
References: <20250414021249.3232315-1-longman@redhat.com>
 <20250414021249.3232315-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="npwwpgxnj2lpvqxn"
Content-Disposition: inline
In-Reply-To: <20250414021249.3232315-2-longman@redhat.com>


--npwwpgxnj2lpvqxn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
MIME-Version: 1.0

On Sun, Apr 13, 2025 at 10:12:48PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> 2) memory.low is set to a non-zero value but the cgroup has no task in
>    it so that it has an effective low value of 0. Again it may have a
>    non-zero low event count if memory reclaim happens. This is probably
>    not a result expected by the users and it is really doubtful that
>    users will check an empty cgroup with no task in it and expecting
>    some non-zero event counts.

I think you want to distinguish "no tasks" vs "no usage" in this
paragraph.


> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5963,6 +5963,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, s=
truct scan_control *sc)
> =20
>  		mem_cgroup_calculate_protection(target_memcg, memcg);
> =20
> +		/* Skip memcg with no usage */
> +		if (!mem_cgroup_usage(memcg, false))
> +			continue;
> +
>  		if (mem_cgroup_below_min(target_memcg, memcg)) {

As I think more about this -- the idea expressed by the diff makes
sense. But is it really a change?
For non-root memcgs, they'll be skipped because 0 >=3D 0 (in
mem_cgroup_below_min()) and root memcg would hardly be skipped.


> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -380,10 +380,10 @@ static bool reclaim_until(const char *memcg, long g=
oal);
>   *
>   * Then it checks actual memory usages and expects that:
>   * A/B    memory.current ~=3D 50M
> - * A/B/C  memory.current ~=3D 29M
> - * A/B/D  memory.current ~=3D 21M
> - * A/B/E  memory.current ~=3D 0
> - * A/B/F  memory.current  =3D 0
> + * A/B/C  memory.current ~=3D 29M [memory.events:low > 0]
> + * A/B/D  memory.current ~=3D 21M [memory.events:low > 0]
> + * A/B/E  memory.current ~=3D 0   [memory.events:low =3D=3D 0 if !memory=
_recursiveprot, > 0 otherwise]

Please note the subtlety in my suggestion -- I want the test with
memory_recursiveprot _not_ to check events count at all. Because:
	a) it forces single interpretation of low events wrt effective
	   low limit=20
	b) effective low limit should still be 0 in E in this testcase
	   (there should be no unclaimed protection of C and D).

> + * A/B/F  memory.current  =3D 0   [memory.events:low =3D=3D 0]


Thanks,
Michal

--npwwpgxnj2lpvqxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/0C0AAKCRAt3Wney77B
Sd/BAP9TY2qAV5thRUJlYr+lBEw43c7tulDcGAlAmMTw3fVIxgD/TAOGmPlsQ9YN
ZZJQOw3S4qTSiiwaCq9RFx8VCKUEjwE=
=J0fF
-----END PGP SIGNATURE-----

--npwwpgxnj2lpvqxn--

