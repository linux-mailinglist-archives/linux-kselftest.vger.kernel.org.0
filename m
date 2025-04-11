Return-Path: <linux-kselftest+bounces-30615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4DFA8647A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 19:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4EB19E0B17
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED7F22539E;
	Fri, 11 Apr 2025 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a8RZR2ML"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF7221DB3
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391523; cv=none; b=qqiyaw8cU5+MM+drfcnk0bZeG+NWj7914Ft45GtytcWQYRZRrFy6cyHT7WfY6vtegfoDhndleJZSDhP0r3a4NRAK2HHaXuVfx/3hvreAFRmDAHQrHJ1dbW6+rkPK5yQ4MJ6UHEUg3cnOQFMBS07hyeDVDorAGnM7/5PikgXyJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391523; c=relaxed/simple;
	bh=OYphbyhoYzlQdJS6+N5tDVqhL4XTIjegUyZQMQBubds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYZSy9lCWyaAJv7zA6SJh3ov4hkQUvljnEYIsRCLQdki+U1MYcp6bXTSnEpDoOiqHpdRbX+x0zPp8eIcn2fxPNN8MXU9scP1Mu1K2u8/UbVsMNXPCRnaRHEBpy09ShjBQCAtxKOQv0cvBaMjRr5nTIef8Jyrt4UKyBnTBoBN8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a8RZR2ML; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso15642695e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744391519; x=1744996319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrunUqs/N09Jqukhxf1FYqRGiAYPy6gzssLwyfD3SEQ=;
        b=a8RZR2ML8/AMZWmnQZSSyed2dGwwKu35Lx62GN0eKtNtBTs3e9OGixHjYIn+BVIoB/
         y8c/eaqaTyqIsizYaTFfLzUnRMFl8MVYxhUid7zdviH2OVfhVrUrjAMOQ2iFAU3OFSFo
         V0m1D+7yy0pK7hR5TYspiR1ClFGYwh39aU5Ui10U73v8dsuhC2f3uUwnlhW9O55/jDN0
         kn0LnQSM3sPukbya2ldwz5Yr2xBNbf+03VwD4vcW45cSALg8kd+hQM3ijxYj6FMqlwTt
         ry53S7cWai+uBamSVk7NzDkVWf4sfNdAh2dWEWMr4nx56+DDvfOwMqs6BgUSUKpoXeVs
         o+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744391519; x=1744996319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrunUqs/N09Jqukhxf1FYqRGiAYPy6gzssLwyfD3SEQ=;
        b=HUXpXfypydoSoBzZtGiltNguKf/aLuMafZH6JBRy61FOqdRvecHG/cfsUpu/JirvAw
         3j1u1Stsy6YhrpkNSurNqetnvnnpfWsiMctDqfnqa35gyzkbIQfMPj5cvWwmxvnaulSY
         8qhXnljm/p9h42BchXZIVChWZQ3JIicx5RIlZPtH8YLZzfjpyrzblJzFd4yV/LpSOW0i
         TtzpKJQYLB7l+WcctRcU2PFyyHDyhd6an7mhJJHbgjhWypwNmIZqzFEbahmVdgi1ArUc
         LW+z3ixwYQWH3lFFq9iMZHQ8n05dJ8MTaEhCG0D1pmoIPCbFShCnkfLqlsX0+5nKTqvL
         vRhg==
X-Forwarded-Encrypted: i=1; AJvYcCWCJlDuJAkCm/FXL+DOtdGZqIQOYZjOu3hA8ROXIuok7I/RIRFwaSXTBNPhWYuPHHIInrm/GjH1mOsWqKz2n7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRmPtJT6aRdkZtbgSBTIeZS07vKY6ZuoIVN96eYTlEY2aR7vj/
	JBjHNs5Np4pHbFb2kT3QZ5jZN0FKcpCGGveLhOnRT5ooC+DslrZ+rsU22ZzBv8U=
X-Gm-Gg: ASbGncs7veARYgloGNY6f1//tv38YwEv9Qc4GUfySdzAjG584yasxPdaqowseRIsB1y
	uUBBsxXtpZ3G4X38+xGThAesqDJU8CmWeQjjAf6dAqHttNE51VWQgO7GdvQJUj0QcGz0Xyk9rKz
	UbTmexCvvC7pI8JCFkyFtUcqurU5eTOwXCJwzOOvOa2F3IKn3RPlrapC0UFU0wM7cxIg0sVSDPz
	ob7jLS6gCgoplM203jxz66wUSvr17VC6bH+U4xKQwyBlPDpK/446qlQ73o0k/W34rbkKze4QPHH
	oAhjoA5+cLD6j+feFFzhFKikzd7vLLvtWLXmVXHTtmk=
X-Google-Smtp-Source: AGHT+IH0dLGja95QCcgcHh1wVVB1WPemcJDZs2T8C3sybPrHDMiiHlmMWJ7oUMDbKCpkKMWyzNOAAw==
X-Received: by 2002:a05:600c:3ca1:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-43f39420017mr32333865e9.0.1744391519127;
        Fri, 11 Apr 2025 10:11:59 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5e9dsm92843575e9.36.2025.04.11.10.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:11:58 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:11:57 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <wc2pf5r5j4s7rpk7yfgltudj7kz2datcsmljmoacp6wyhwuimq@hgeey77uv5oq>
References: <20250407162316.1434714-1-longman@redhat.com>
 <20250407162316.1434714-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3lluon3t4cqfa5a"
Content-Disposition: inline
In-Reply-To: <20250407162316.1434714-2-longman@redhat.com>


--t3lluon3t4cqfa5a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
MIME-Version: 1.0

Hello.

On Mon, Apr 07, 2025 at 12:23:15PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -22,8 +22,6 @@
>  	     iter !=3D NULL;				\
>  	     iter =3D mem_cgroup_iter(NULL, iter, NULL))
> =20
> -unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
> -

Hm, maybe keep it for v1 only where mem_cgroup_usage has meaning for
memsw (i.e. do the opposite and move the function definition to -v1.c).

>  void drain_all_stock(struct mem_cgroup *root_memcg);
> =20
>  unsigned long memcg_events(struct mem_cgroup *memcg, int event);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b620d74b0f66..a771a0145a12 100644
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

(Not only for v2), there is mem_cgroup_size() for this purpose (already
used in mm/vmscan.c).

>  		if (mem_cgroup_below_min(target_memcg, memcg)) {
>  			/*
>  			 * Hard protection.
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index 16f5d74ae762..bab826b6b7b0 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -525,8 +525,13 @@ static int test_memcg_protection(const char *root, b=
ool min)
>  		goto cleanup;
>  	}
> =20
> +	/*
> +	 * Child 2 has memory.low=3D0, but some low protection is still being
> +	 * distributed down from its parent with memory.low=3D50M. So the low
> +	 * event count will be non-zero.
> +	 */
>  	for (i =3D 0; i < ARRAY_SIZE(children); i++) {
> -		int no_low_events_index =3D 1;
> +		int no_low_events_index =3D 2;

See suggestion in
https://lore.kernel.org/lkml/awgbdn6gwnj4kfaezsorvopgsdyoty3yahdeanqvoxstz2=
w2ke@xc3sv43elkz5/

HTH,
Michal

--t3lluon3t4cqfa5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/lNWgAKCRAt3Wney77B
SQOUAQCqcf+/VLJ4QspbjJmrhi+j/ZGy+0Ms5yQ2UA3mfz96vAD+NYpSXSOXiT1r
0oyHlNs+QwiydZG2ffDsveeh1dl2ZAQ=
=eMQ9
-----END PGP SIGNATURE-----

--t3lluon3t4cqfa5a--

