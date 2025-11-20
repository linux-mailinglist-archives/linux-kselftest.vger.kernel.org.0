Return-Path: <linux-kselftest+bounces-46126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C83DC752B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF98D4F3C73
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827443612D7;
	Thu, 20 Nov 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CO70V/jR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927123612CC
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652909; cv=none; b=TPY4LW7n7wK34R2rlBRARGSulGgdi+BFIy4JX/cNJoKarqdkiFPJ+543qAa5O+YNtTfJsMzUkW9bkYPArH/wEe8WN96Xyl7uGlRObG1mkVQwVCl4HJTGNjnmiLcKcF310y3gnxZzkFOik+6ej+acWf5OJdcawWEpC/G2kcyP4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652909; c=relaxed/simple;
	bh=HxGHVYEEBatxVNzTWUVGUN69/JYbXDtI3jufM2nxqoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwhkoc2yX2bqSJHIFD+qeRY4MXp64I4DQRt8xbYmebYBRiiigMaGlPOUE4ueqWq0/q7OudbQIToAI7KpCounAeW/ARLAkRDGpD+UOej3Mp+BX50Oa4b+WFzE16ncoLs4tLeCpxIF53qfBaT8LnTIjVS6F+1a5S6oeYeZDLyS358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CO70V/jR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779d47be12so8493955e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 07:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763652905; x=1764257705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11esoKSgE8g1amitmv74A8N+MN8ZcrR64u90u3R6V54=;
        b=CO70V/jROHASWx0ueJGmOA7YnYZpUxvnNbjTU1/9UyJs+4nnIKqR89GXlNp793Lw49
         TFEx4KRSO6AWumv0u+L7yZg2qSdjaOpOagxgHTcRRF5pmwVVfKLH3RV4IYlWXqolVHMR
         noCeq8ooWLAMyrp3tV6bE5NIoSbfnxCoAw1a9GruffNXF56AC9I491LynObi45RVtB5A
         1F3I1zrJGWwGXBRXI1nq+xsUNYyZ8+RGZ7plylbjcW+qZwemMN1LJyYTvdGAL46o/IBq
         b3VP0U8D1voQSMLlw8ZUnXzWcPbX5xoazR/mvNCVTO8Z1SPVwAu4gQ4SUMNIH90L3mpx
         pbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763652905; x=1764257705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11esoKSgE8g1amitmv74A8N+MN8ZcrR64u90u3R6V54=;
        b=CC9YVwfAqaWiR+24enaNGHCHb8D3HAnV8n9KGaPnkODgZmKCs+m4DNyArNqIJwFAX0
         BUcs+DKdKTOPFR7SZWLCtV8o4n2PfDjRdAua/Jyd0FSPI4XKjUdK3Jr4o9xgjSb2iJi4
         ZExBJ8hl7RWz2zox4jQ3lmokE9KxiS2Kj2dEP3e9Uqto7WG0qD1A0+N7pMkhQXYr4NpF
         QUiQPVj8KLQiOqYi/7HcuO6fVRhCXupCGVe7lCUTe+cyaSbV/q9kgwr2Rcq7cMX9EO4F
         n6WCpAWQJmVhrerOaGtcejh2ZMwv7T/bV9g+fBu9ZzHHdBt90EAIyQw3y2pFwQNs8Ggp
         pkkw==
X-Forwarded-Encrypted: i=1; AJvYcCUuFuvVyCjhnRaXYFOjok1N2AWDoN0Zzw7FOe0PZXNMy+Pf+RdXOwkC/p6B8pkghbt09KgPJZEc9NlyfAs3Y1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCRszxg5DVYk7VxgXfjwaas3m/ZQmBl+cthKYoLxwMdE4ditBa
	h6djOKF7uC5ZNzJCO1+q1VYiOp9rgzZLH45hnrxXEAX65x+59+68jBH7QuY0Xiv6+t4=
X-Gm-Gg: ASbGncuSCSX0J1q9NOQd+ifsgVS7fSpNyKnrsZZpoKWQDxH1nlv5/bmxya+bPyzC1hh
	YUorn/wD6NH4O8Zjez3rwQ6ZK005it22ZxCQ6M2FjmkctaXLev4dtK7VvPrJ3Kdd0eMf/xQ+5/8
	/3Pj5A/cvnpxB6H+vwUqCU5SfsVPyJUayK9p0MTRgECzE19lWPBwdZY+Wmgk1UOxEnpILEMJkDN
	75AoAMCtt4vkwTi7LiiI37mCXcduJkOvsN7KijgcUBP38SKOJ+DPeoQ7DEEgNaNf8d+dNAepfJo
	f6bnd9SSYUuATyWLX78iBayvQpoq7TJaihoMb6tccL7PLeoUNoVStVXG5b0oGjzNKRhfV3b0SVW
	aii3OFeN4QaLBrKAJ0xIkHvFhR1l0cXyU3fI68PVQRY6q/1wGjwV14Xqyh5/w+PjFAeAS/d4MgS
	ixHpeb0P5kBGB5SwR08wzZnALmPTApqGOV
X-Google-Smtp-Source: AGHT+IEPAYYqmLfa62VPjHRp0h443J6MQXeseMV1CiVvWJMFtArLSISsoWd97XXXD7e7TlfONuWvEA==
X-Received: by 2002:a05:600c:3b08:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-477b9dd6e39mr32508755e9.10.1763652904777;
        Thu, 20 Nov 2025 07:35:04 -0800 (PST)
Received: from blackbook2 (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82d8251sm53046445e9.6.2025.11.20.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:35:04 -0800 (PST)
Date: Thu, 20 Nov 2025 16:35:02 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	lance.yang@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
Message-ID: <p655qedqjaakrnqpytc6dltejfluxo6jrffcltfz2ivonmk6lb@bxf5xlgo4iw2>
References: <20251120060406.2846257-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ai47sd76qnrx3mju"
Content-Disposition: inline
In-Reply-To: <20251120060406.2846257-1-zhangguopeng@kylinos.cn>


--ai47sd76qnrx3mju
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
MIME-Version: 1.0

Hello Guopeng.

+Cc Leon Huang Fu <leon.huangfu@shopee.com>  =20

On Thu, Nov 20, 2025 at 02:04:06PM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> test_memcg_sock() currently requires that memory.stat's "sock " counter
> is exactly zero immediately after the TCP server exits. On a busy system
> this assumption is too strict:
>=20
>   - Socket memory may be freed with a small delay (e.g. RCU callbacks).

(FTR, I remember there is `echo 1 > /sys/module/rcutree/parameters/do_rcu_b=
arrier`,
however, I'm not sure it works always as expected (a reader may actually
wait for multi-stage RCU pipeline), so plain timeout is more reliable.)

>   - memcg statistics are updated asynchronously via the rstat flushing
>     worker, so the "sock " value in memory.stat can stay non-zero for a
>     short period of time even after all socket memory has been uncharged.
>=20
> As a result, test_memcg_sock() can intermittently fail even though socket
> memory accounting is working correctly.
>=20
> Make the test more robust by polling memory.stat for the "sock "
> counter and allowing it some time to drop to zero instead of checking
> it only once.

I like the approach of adaptive waiting to settle in such tests.

> The timeout is set to 3 seconds to cover the periodic rstat flush
> interval (FLUSH_TIME =3D 2*HZ by default) plus some scheduling slack. If
> the counter does not become zero within the timeout, the test still
> fails as before.
>
> On my test system, running test_memcontrol 50 times produced:
>=20
>   - Before this patch:  6/50 runs passed.
>   - After this patch:  50/50 runs passed.

BTW Have you looked into the number of retries until success?
Was it in accordance with the flushing interval?

>=20
> Suggested-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
> v3:
>  - Move MEMCG_SOCKSTAT_WAIT_* defines after the #include block as
>    suggested.
> v2:
>  - Mention the periodic rstat flush interval (FLUSH_TIME =3D 2*HZ) in
>    the comment and clarify the rationale for the 3s timeout.
>  - Replace the hard-coded retry count and wait interval with macros
>    to avoid magic numbers and make the 3s timeout calculation explicit.
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index 4e1647568c5b..8ff7286fc80b 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -21,6 +21,9 @@
>  #include "kselftest.h"
>  #include "cgroup_util.h"
> =20
> +#define MEMCG_SOCKSTAT_WAIT_RETRIES        30              /* 3s total */
> +#define MEMCG_SOCKSTAT_WAIT_INTERVAL_US    (100 * 1000)    /* 100 ms */
> +
>  static bool has_localevents;
>  static bool has_recursiveprot;
> =20
> @@ -1384,6 +1387,8 @@ static int test_memcg_sock(const char *root)
>  	int bind_retries =3D 5, ret =3D KSFT_FAIL, pid, err;
>  	unsigned short port;
>  	char *memcg;
> +	long sock_post =3D -1;
> +	int i;
> =20
>  	memcg =3D cg_name(root, "memcg_test");
>  	if (!memcg)
> @@ -1432,7 +1437,30 @@ static int test_memcg_sock(const char *root)
>  	if (cg_read_long(memcg, "memory.current") < 0)
>  		goto cleanup;
> =20
> -	if (cg_read_key_long(memcg, "memory.stat", "sock "))
> +	/*
> +	 * memory.stat is updated asynchronously via the memcg rstat
> +	 * flushing worker, which runs periodically (every 2 seconds,
> +	 * see FLUSH_TIME). On a busy system, the "sock " counter may
> +	 * stay non-zero for a short period of time after the TCP
> +	 * connection is closed and all socket memory has been
> +	 * uncharged.
> +	 *
> +	 * Poll memory.stat for up to 3 seconds (~FLUSH_TIME plus some
> +	 * scheduling slack) and require that the "sock " counter
> +	 * eventually drops to zero.
> +	 */
> +	for (i =3D 0; i < MEMCG_SOCKSTAT_WAIT_RETRIES; i++) {
> +		sock_post =3D cg_read_key_long(memcg, "memory.stat", "sock ");
> +		if (sock_post < 0)
> +			goto cleanup;
> +
> +		if (!sock_post)
> +			break;
> +
> +		usleep(MEMCG_SOCKSTAT_WAIT_INTERVAL_US);
> +	}

I think this may be useful also for othe tests (at least other
memory.stat checks), so some encapsulated implementation like a macro
with parameters
	cg_read_assert_gt_with_retries(cg, file, field, exp, timeout, retries)
WDYT?

Michal

--ai47sd76qnrx3mju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaR81HRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AikgQD+P75H+Zk6KLQv5jtwZR2/
lc6k9NlLyZw80qeoVGUId3MA/3Xf79tB9qS682uIdC73LCKqrsTyqHG1PFRf/s6U
uGgJ
=oeRR
-----END PGP SIGNATURE-----

--ai47sd76qnrx3mju--

