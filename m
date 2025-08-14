Return-Path: <linux-kselftest+bounces-38984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBBCB26BBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA525653CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F623ABBD;
	Thu, 14 Aug 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HhUKmSmR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F54204680
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186905; cv=none; b=cH2KUE+Mr/b7mczhQ/NSfH3CDP7UwEA6rGSQfaMj/e3rt2nx96LwF6T+IJK0Psxll4ddgBnsiGPRWwILBeDJPGx14X1nRxMzwPK65j45w9cTmZNyW6PoSszcW4vMSDXmmB4Qf33z9yzEvqbT/uSt1t+1TbEgQ6k2W2YuwKz1YfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186905; c=relaxed/simple;
	bh=XkpJgq+lIXUCppVHf15aiVr5Q8p7XI7C729dg+Vl3Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQNLjE/FRxfJe2uJ4mYSIjCptIHbnv9S9YrvrejnqxyEia9x5BiE7roDlukxUx5WpWy6ZWcU5llLIx2LxC9ZkfPFiYyDGdRiqd++h8nU63XOUqrKdHEpGPsSxz4o+eykT0LmqihTQnVeMF5FZTXoemqXP2PCqx+YACuXVP2SF48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HhUKmSmR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9d41bfa35so899372f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755186901; x=1755791701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SviimhcnBMLOVVMhOENj2J5Tfh1/NQV1XS5VZG0D3iQ=;
        b=HhUKmSmRpXmjZFZ5q/DoCDAPbLa89O1pAzxr9RG0pfEAMsY+VGEGPuPpus4BiNfK2f
         OP3UWnBLgTiFOCLKIOudw+RO+8dZhLZQVivsrnUqdRizT964W2XrjTDknJ7fbqSEdXCB
         yQMXKx/GosmiQWhAZd/aJRMxp7ySrXoZYphjtdkGbLVaI3vqu4tGWTrWRo1+ULQhcNeS
         nXBonXQaaLA5APE+I2oLRjaM1LBFz644LtblJhLyqsSDU9umKxA3xEqg5nmQOzS4o0Rf
         mnGGbtJDtkPowPQlKi/43B9xwTc04cJGX27HvfZ3NaBqROEu2Gl9OaqgX//qGncDXwlL
         R3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186901; x=1755791701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SviimhcnBMLOVVMhOENj2J5Tfh1/NQV1XS5VZG0D3iQ=;
        b=RfBzDhUhA8K7eNtEHg+HgXjw0NbmjAYK+53sK2W0O3u/v2aI1BvVH+S/qmsaeVGp9E
         Xztl5wpLcI5OZQITtSLjB9sNNc3gmjgPZC23qXWSZ1iw5cNESQcaYsMvf04/0jp37T54
         5xActeO9UfxPZF/TrWP2oxIto0T6RDYNOScDNHKTsl5JVXLhtj0eROrkZIL4/5O9Ewzb
         dX/ezXQuwt2Ij/u3U3eUZzvXZEnppeIAUL/VDKiwBMjYgYwzYG8j6OMAo2uLcHEDt7nP
         bl+w/6mfYAYnmpHoLjt3hIDRvFd4HI7lyzhoKw7Juhf88ENQdaF36tiuij22wEAkuC2q
         Wskg==
X-Forwarded-Encrypted: i=1; AJvYcCUYiaLiXsLPJ4/S7hlbw1nN7OjvxTbBSQ+peIGnBiv3ef/IgUHE9ZOUU94GMexuX6VF2D0Jt8XG+o9U+bcMuNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU4YSiQLHN2WPaPEs8V4Ruv+IUC+EF2BnfE2dOQhUWPtMuh34y
	VYdSV6DlDRWPGGleRD97cE0q3yeRpj6/kj3Tl17QsP9fDjp2FrmbOxPZ6G3RSb+oN8E=
X-Gm-Gg: ASbGncuf5VpCwrBUVmSweeEQffyp2W7Ybk170IW53Ttx7O07HM1q14zo89WzYMfq0XN
	UeY4iR3qsGB5doalpl0n2tGkj6TAX+fajEcaIifSB304LYUDik6f2RrD/SjAYh8Xs9IMwgdT+0I
	7txP7sVw1FPj1NQGvl28wGbsm03C3eGFsxR+48aVqGofGaSaWIJDTPeagB2s4eo34ruhPkE6Ber
	3xXaRB555YU7awkOODGEVv4SadlCkbYEb/jOMMbI0O+tyz50QFHgNcC7+VQ/Ly2iJdpZTH/PF1d
	oYIPcXHFj/PWhM93jyzeqQjQyFfcG80jr7PZPnLmAnk0HXdTNmiR29upfA8PXgpv1scrkjiCUHE
	yiPoxh3218aMkYPPLJLmiCsLlm0FzdhiVnMTuPK3s5g==
X-Google-Smtp-Source: AGHT+IEg8KfFdsEWg4VePIf9NMFdjfj2YyB1TPJBwkQF8f3PI8g01heEQys1xj+KdL5pkHweD6cG9A==
X-Received: by 2002:a05:6000:2910:b0:3b8:d5cb:ae1c with SMTP id ffacd0b85a97d-3b9edf2d87dmr3225979f8f.28.1755186901323;
        Thu, 14 Aug 2025 08:55:01 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24302e028dcsm70954145ad.91.2025.08.14.08.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:55:00 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:54:44 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, kernel-team@android.com, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/2] cgroup: cgroup.freeze.stat.local time
 accounting
Message-ID: <oel2dyzlyvzggpwxprhwbd7n2ye2bst32izjnzywjdilo4nena@p7bcxgy6lqyq>
References: <20250805032940.3587891-4-ynaffit@google.com>
 <20250805032940.3587891-5-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjtwomnmbus7efjt"
Content-Disposition: inline
In-Reply-To: <20250805032940.3587891-5-ynaffit@google.com>


--pjtwomnmbus7efjt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v3 1/2] cgroup: cgroup.freeze.stat.local time
 accounting
MIME-Version: 1.0

Hello.

On Mon, Aug 04, 2025 at 08:29:41PM -0700, Tiffany Yang <ynaffit@google.com>=
 wrote:
> +  cgroup.freeze.stat.local
> +	A read-only flat-keyed file which exists in non-root cgroups.
> +	The following entry is defined:
> +
> +	  freeze_time_total
> +		Cumulative time that this cgroup has spent between freezing and
> +		thawing, regardless of whether by self or ancestor groups.
> +		NB: (not) reaching "frozen" state is not accounted here.
> +
> +		Using the following ASCII representation of a cgroup's freezer
> +		state, ::
> +
> +			       1    _____
> +			frozen 0 __/     \__
> +			          ab    cd
> +
> +		.. Originally contributed by Michal Koutn=FD <mkoutny@suse.com>
> +
> +		the duration being measured is the span between a and c.

This is so little "artwork" that a mere mention in commit message is OK
;-)

> +static int cgroup_freeze_local_stat_show(struct seq_file *seq, void *v)
> +{
> +	struct cgroup *cgrp =3D seq_css(seq)->cgroup;
> +	unsigned int sequence;
> +	u64 freeze_time;
> +
> +	do {
> +		sequence =3D read_seqcount_begin(&cgrp->freezer.freeze_seq);
> +		freeze_time =3D cgrp->freezer.freeze_time_total_ns;
> +		/* Add in current freezer interval if the task is now frozen */

Nit: cgrp is frozen, not a task here

> @@ -179,10 +179,16 @@ static void cgroup_do_freeze(struct cgroup *cgrp, b=
ool freeze)
>  	lockdep_assert_held(&cgroup_mutex);
> =20
>  	spin_lock_irq(&css_set_lock);
> -	if (freeze)
> +	write_seqcount_begin(&cgrp->freezer.freeze_seq);
> +	if (freeze) {
>  		set_bit(CGRP_FREEZE, &cgrp->flags);
> -	else
> +		cgrp->freezer.freeze_time_start_ns =3D ktime_get_ns();

I wonder whether it wouldn't achieve more stable results if the
reference timestamp was taken only once in cgroup_freeze().
Measuring the rate of cgroup traversal is rather noise in this case.

Thanks,
Michal

--pjtwomnmbus7efjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ4GwgAKCRB+PQLnlNv4
CNbxAP9FzlDCoVP1/jhXEaVA20T+mwq1x7BETTs7XxHWatYQTAD+OE7kYl0NbVYD
g6r21AfecI9/DXVLMsPPub/G82cpWwI=
=3Weh
-----END PGP SIGNATURE-----

--pjtwomnmbus7efjt--

