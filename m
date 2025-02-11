Return-Path: <linux-kselftest+bounces-26371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14370A30FAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0BB1692CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF989253B6A;
	Tue, 11 Feb 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H319oK41"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C320253B6B
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287453; cv=none; b=jGR/CdC5mJw96yce9nlFJqsdH94MzwhPzhlAhfYFNgyQuXBjt/tKyKy9H+LYFATxjPoDIH3FLVEAIFaL0P/yo7cu2aQSsKjJVUcr44Atjap6tYFMO5n+BDsKBNCmgy9GT/nIhTXggKgtKlzVV0bMvuIHrsA/lvRMcKEu8DTirkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287453; c=relaxed/simple;
	bh=jdMdgLerobsP+yMcSdARJ6BtI8zGEUAwkq9ZKb+/l68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAdHlyq2O3pYb4oFei4rEWM/tRb3OSB4H/g9/quWtKhbDyCEYVN56W35bY4YkwA4b+dluqDaFXdf+vfvxbhTgKJ6TKs9eOUQAWMTRrbKirPWdhdG0ys4VFJFUn1chC34u3okXBlVJ5+GU2iFRtYDF5lnd1BOyBKpXC8E1MPkhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H319oK41; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de47cf9329so7093564a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739287449; x=1739892249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBvU4Dm8bwzLR9Wj8jIUktjjWFEcu/PHjQzCficyKJE=;
        b=H319oK41WqIiB3iRZc10DwubNF8cPsHZCoAU9H9l2gGcIX++SEErgJk47fZWBuMBFC
         IqBas9xi/IpQv0Ox106bjQpUoPYzeYhBRuaYr/xMZET/aAx42kcUa+ef2m4Ols0Qcvct
         Edf8cyBG2ZDhbS1Fty0NdRZ1rCsjVdENc00qpa95QV5CUrWAQg9aWN7+wqj2xYlz1x/G
         JddRrrlmrVUQvlhOctZEBEanWj9fSSaVXqprrGf6afTAoyaB3SuXpHD/KK12EgOTIJ9T
         ckpcL70djZvyuf3SXQdiMZXCf+Yy+wdBsy76uKMPlg19vxRZs/OC7fdSq1EsLu8AU9Hi
         ZE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739287449; x=1739892249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBvU4Dm8bwzLR9Wj8jIUktjjWFEcu/PHjQzCficyKJE=;
        b=okAw8eBMvo/7+FJHncA934xKuhokddw8KNhsMd+GfOsUOj8a+Z2XnEUd8Yo2hu4j/8
         oZxWlacmVzcjbrcWnjgWngYEHr0yBS6WKqo2uaruykO8mgnbEPV3C33X+Gvz95yH/qpu
         /CvUBxo/6nx8OmyKmNwBjgu32noMEVV0AIL4LRUvkSvOWh9Tjt+Z1qH12H9iQcVPmR9Z
         yfMtu9RbmDm03EnmIW4AyP39dQVXgzZ8a7d8HbXzNWQg9lDLKu4JOtzpHggf1EnWZA+F
         2l49Lw9QMo9+6fVAhIOquvBtOwU6TYfWRxjn0qLgd2wY+fco+ej4ImnQE3Gt1n6jLhRR
         yTlg==
X-Forwarded-Encrypted: i=1; AJvYcCXOpxWVSXjVWtzj7o+3S/b85I0vMwjDrd7Ti9lIq65w4h7pRMDp3lQtk1BBrTPZKA0iVAWdEw1djcb06vMTnX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUO2vnfG/pe/dQGWQgmkOqTBjhJribs1dWxb4XRyBNsL+yKnU+
	2KcvQojXS2lQqB3r8oQV7miehfK/hqvqKpkEsjFrFa4r7INIkH5BiNWlIFGk/wk=
X-Gm-Gg: ASbGnctkf3uXKJfwXI2NP++nbwHaT28bwNfEuboz55rh2XX+VGD3u33X8kQoVPOUilF
	0bRw7czrPx/I/NyiJTqiD/H0RmVPF+zBfx7u6P+aPP0CpisnVWZ1Fy04DGynRVVXILXOjlAJ61V
	G13ExoKG0L1mx0PieOVJT+vIZvv3BfnExGQ+g2SJzmOVRTwwM7QKT1PtmINc/hcJBwtlnK90NtF
	xZY84K9dkRIdT5m/K6I6ek6tvb8zwIXecTwMaasHyQelNBuQsO71Wnhk8qKixsHDzBMf8btN2/O
	Ff5cdlAz8pOsBEtfgw==
X-Google-Smtp-Source: AGHT+IERX4U02RBjjELzamqHtVUVOA9PKYON51fVOHE8xRaV3mjjYDHIg8FH5jXIOBBQliZ9fehckw==
X-Received: by 2002:a05:6402:4605:b0:5de:6bc2:7bb with SMTP id 4fb4d7f45d1cf-5de9a3dc37amr3981363a12.17.1739287449386;
        Tue, 11 Feb 2025 07:24:09 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4e6d60bbsm7856667a12.15.2025.02.11.07.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:24:09 -0800 (PST)
Date: Tue, 11 Feb 2025 16:24:07 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 1/6] pidfd: add PIDFD_SELF* sentinels to refer to own
 thread/process
Message-ID: <gij5nh63s73dj5u33uvzl5lbmsvoh6zr5xnqpnfltwi6aamy7j@47iop2wgtdac>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <24315a16a3d01a548dd45c7515f7d51c767e954e.1738268370.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s774j6juqpksx26a"
Content-Disposition: inline
In-Reply-To: <24315a16a3d01a548dd45c7515f7d51c767e954e.1738268370.git.lorenzo.stoakes@oracle.com>


--s774j6juqpksx26a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/6] pidfd: add PIDFD_SELF* sentinels to refer to own
 thread/process
MIME-Version: 1.0

On Thu, Jan 30, 2025 at 08:40:26PM +0000, Lorenzo Stoakes <lorenzo.stoakes@=
oracle.com> wrote:
>=20
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/uapi/linux/pidfd.h |  24 +++++++++
>  kernel/pid.c               |  24 +++++++--
>  kernel/signal.c            | 106 ++++++++++++++++++++++---------------
>  3 files changed, 107 insertions(+), 47 deletions(-)

Practical idea, thanks.

> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> + * To cut the Gideon knot, for internal kernel usage, we refer to

A nit
https://en.wikipedia.org/wiki/Gordian_Knot

(if still applicable)

Michal

--s774j6juqpksx26a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ6trlAAKCRAt3Wney77B
SacWAPwM6cjj3sPJP6MuZliNrQSB1iRXPL96jf7fhryBBezaDgEAzpQV4pbefEW3
T3w/EV38bXlaUQpqVL+5QFF3BmA2uwg=
=WNsn
-----END PGP SIGNATURE-----

--s774j6juqpksx26a--

