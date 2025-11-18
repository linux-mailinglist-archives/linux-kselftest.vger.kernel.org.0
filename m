Return-Path: <linux-kselftest+bounces-45899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C4C6B0DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AA6202AD13
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B03546E0;
	Tue, 18 Nov 2025 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PMeOj8Mz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E4349B17
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488350; cv=none; b=oZPOT8zcVgwNyT/TYKMU7pm9SPvH4ix8hK0RPFRRgev9Dwwrbn7e5nqdcThiQUBptVV5jnJ935zo3o3nv08KFCbOC6CqB+ySXLhRGPgITSWexAif1btU3t7VjleVsIt/hUo8/HHponiT4Ts60M7Tz4q/3TBVvKchxybvLANKQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488350; c=relaxed/simple;
	bh=9tDLmEl0AlG+JlkcUzxp8d7AUiUIQj7FJpPRHfm9nJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Z55+lD/vRVPggMdBnhFBkP8U+WNxz2F+0RHbsmR1v+SJ+ubSNRvgC2Nc8eKXd3hwKwroG53kMhUQtuc2VzNnQxXpH4tAk395QVvZfN1ajSjoJ5Mdu9P29kfI927waChFlL11kDDe0LqpO0qr2KZiRK3PMAp2+3OqNqMnGHfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PMeOj8Mz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47778b23f64so39609425e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763488346; x=1764093146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaANC36yaZF4chZG7yq+ENtiQcLbr4MDM5mx57OGjSU=;
        b=PMeOj8MzQU9TjG+chSwzqc/g7OHOg4GaivoUcenfMSZc4JEgEBtb1cp7oDh5WUO9oy
         cVxmnn5mud6VwYvHx1jGRBKKpIYFaCsnu05YmwcclYInW5MpkmChcyJmy/qam1YI6UFj
         lVjjHJwiT3nOOe6ZuRhExPd+BYL3cnRdJ7JSiMnzblOGn40JKzwdok7/BKByQu2t010Y
         kfBBb9imbGWqoy6PR70gl3ldcqR1y0yhTPh/3d2eSuxCmOtR/mXc7XQkGkF2rFahho9R
         Jx+6LHWxsjY66cEhwSLQ4SZCtpeeZoFFXv+dg9JWwfwWZJHfx/xaF7srp/QFutfiVWK/
         AhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763488346; x=1764093146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaANC36yaZF4chZG7yq+ENtiQcLbr4MDM5mx57OGjSU=;
        b=AeetvgkVQg4ZpB0RvDDftQOV6D0NvN47h6NYbCbfLSbm2YJsjsl3ba6riHP95/GxoD
         nZaYHQ9HbPJBPVOE9dC75/zgPvf9aLVHBkNx6Crf4WkP8ptgatEnsGJxX0PgM7BX/ygs
         hyfknchdXzwjFG6cB4RrvUMCNxODx+Cru5xoh75lGxvgFYqG+EIKCVycnXSvH/LjtkvC
         RDvp/bIdxaRcd6F/bVExVu5rEUdoYwGCLjCbeQpSHh5p1Pc1IknWVMS1qzSOcD6SEaYi
         9ufQ/icJVZLZiDBFZKKSCPVG0VYjqmkfU46DWZGOqyqDT3iQKCx6XTkUlLxQMEJCHfWb
         o1hA==
X-Forwarded-Encrypted: i=1; AJvYcCW2UO6aBzttL+rpYHUQFoHTC9d8JrsO7FdUqyJDGsRPYuMyghrtB60tMMkYHIz2py3CIQuizfUY6XwvtuGzXJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjo1J3fBPMTfhpPTM4SrBTHWzl1yJw6nqTFTuIzrep0tJpcjOq
	KjgIQG4T9jFIc3twg3bJVMWh06coDnmgTxGx299973gkvqxC3bkskJ45SuEI9Cmhpdk=
X-Gm-Gg: ASbGncv3EViLJ+r6Wifg7pjzOxqwJo/1/R4AH3i92YEAWmgWd0m1EQ/RQtuuWMCeZ7D
	Y6vwQhW65M/E+/eiB/njRg8hT96uS8wcfsZPO8eaNOxucotV8cD6pQ3TcBepbbuLqOhE3VAu5YC
	lL/lZs9Imrt0qXop8cZJZDi5Iy9IuyBfsGqr+8U5DqVOiYo6uucNFUdGEhN7fMTtveqaHCu6tRk
	gPL53rRaogms9sBLkaVcgi9hLNGQHTBPycihO9RAYNm0MwUNCH77KLTc0Z3f+OA4LTVb6aPMFBk
	qQHOpOlwSBMasBtWDl9KzQpfs25aYeVFbhkOZm+9FcTFOZptT/IuCVBCJ1Au9aUA922mQZLQPdL
	kXhTwEx/54E9ks96oEIYH03XBfeWngw66iUadyJOsZfhtlCtTLpwoMXwvbwaWw8+lJYQ3PNlmW7
	vLHgFjceZxnwJbpfHzMxsfPqoeha0Pd0o=
X-Google-Smtp-Source: AGHT+IFUj6UETFT7esarzT9wjbjzFkPLV1Vezhy7cP2e4tBVdvrdSt2otb6qr2e+Rrdr7C4erQ5TWA==
X-Received: by 2002:a05:600c:4712:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-4778fe9b36emr155621345e9.24.1763488346164;
        Tue, 18 Nov 2025 09:52:26 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d21591sm23572965e9.2.2025.11.18.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:52:25 -0800 (PST)
Date: Tue, 18 Nov 2025 18:52:24 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, chenridong@huaweicloud.com, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v4 1/1] cpuset: relax the overlap check for cgroup-v2
Message-ID: <mcpsxwjouoxfgdoqbysxlvjrgx7m2475y75fhssz4uoryb3jqj@lnigmwq7nage>
References: <20251117015708.977585-1-sunshaojie@kylinos.cn>
 <20251117015708.977585-2-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yqudl6qznctquhdl"
Content-Disposition: inline
In-Reply-To: <20251117015708.977585-2-sunshaojie@kylinos.cn>


--yqudl6qznctquhdl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/1] cpuset: relax the overlap check for cgroup-v2
MIME-Version: 1.0

On Mon, Nov 17, 2025 at 09:57:08AM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> This patch ensures that for sibling cpusets A1 (exclusive) and B1
> (non-exclusive), change B1 cannot affect A1's exclusivity.
>=20
> for example. Assume a machine has 4 CPUs (0-3).
>=20
>    root cgroup
>       /    \
>     A1      B1
>=20
> Case 1:
>  Table 1.1: Before applying the patch
>  Step                                       | A1's prstate | B1'sprstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>  #3> echo "0" > B1/cpuset.cpus              | root invalid | member      |
>=20
> After step #3, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
> remain as "root."
>=20
>  Table 1.2: After applying the patch
>  Step                                       | A1's prstate | B1'sprstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>  #3> echo "0" > B1/cpuset.cpus              | root         | member      |

OK, this looks fine to me, based on this statement from the docs about
cpuset.cpus.effective:

>  subset of "cpuset.cpus" unless none of the CPUs listed in "cpuset.cpus"
>  can be granted.  In this case, it will be treated just like an empty
>  "cpuset.cpus".

I was likely confused by the eventual switch of B1 to root in your
previous example.
(Because if you continue, it should result in (after patch too):
  #4> echo "root" > B1/cpuset.partition       | root invalid  | root invali=
d |
and end state should be invariant wrt A1,B1 or B1,A1 config order.)

> All other cases remain unaffected. For example, cgroup-v1, both A1 and B1
> are exclusive or non-exlusive.

(Note, I'm only commenting the concept here, I haven't checked the code
change actually achieves that and doesn't break anythine else ;-)

Thanks,
Michal

--yqudl6qznctquhdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRyyVhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjW9QD/c2y0ArZIX75uJ7oNlCG+
+AR0L7BKrnxC/iw8IDwHzwUA/jZoh2yJaEM+blH9V1++aGv6PORbyXfY/6FSFL6u
ZUEF
=v8ne
-----END PGP SIGNATURE-----

--yqudl6qznctquhdl--

