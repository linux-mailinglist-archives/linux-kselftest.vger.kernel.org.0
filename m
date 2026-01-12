Return-Path: <linux-kselftest+bounces-48760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CAFD137DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D9FA301A066
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3112DCF57;
	Mon, 12 Jan 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DP6dRaIZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1E2DC34B
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230515; cv=none; b=Y/62wxJw/eRFHNwL8dwbHk0csHHIOv9AHjFiuZhh4pV+JbhaFXY2Qu6L4LaL+8Mm6fiK+A5VWBWODi8IVIUO9qvqsvmWiCrvbJEhSaD2N/QLm2LUDm6W20/7ShFti98GdUq2F9/xv2OwSiEcXHX0jGS1VGTh+hXBLTuvO+OS+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230515; c=relaxed/simple;
	bh=2LlAdcFOMuNXqy8VLk9nvlKy5s1t5Qbb33Ri0Pt3etU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beHzX0CZRQf82GKzXY+JG7GM1uWWEf4wMWFEpw8O3c32rVb1z3Jx14HQhz25vkPgtx6J9T+U0ry0KdPEccxQNhp8uEVGJ/mXNGNeeVGxg/M42paMxQ5qHK33qdi2T4wxhYN4UCcaLuEGQIeCnld6Do8eLoQbggi4c6yQffHBlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DP6dRaIZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc544b09so5173795f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768230512; x=1768835312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LlAdcFOMuNXqy8VLk9nvlKy5s1t5Qbb33Ri0Pt3etU=;
        b=DP6dRaIZSrMKN4qVhz6g/WgTf35PDGl+VFZw/EDha+a+cA+3myVw7WOKXDS2So94Py
         DA2TSiGdlx7nLSwpNWFFEcPXM0d7rfzwJP2IyDsx/sH4NBl75K3RnJD2wt5JjtTLn6We
         bqm965mwxDAZwKLgGKNK6h03qUwhbedVdPgBW+EGOpWDW73Iiy8NXxB9WFcNGeMEC4on
         /qGWZMeZzRuPnsd/VGPHYkacC+hziO3XR+tY3flqQ2Hbmqm7RPaAya5r57Ag3Nm26T41
         Hhbf1O1W8scP3LJR8TtakvX2HMOvGOU78+A4KwNEzQ3VdDcqb/D0ivWaaWyNTcASpOL3
         8ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230512; x=1768835312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LlAdcFOMuNXqy8VLk9nvlKy5s1t5Qbb33Ri0Pt3etU=;
        b=WmSJx2EKEUuwfy988XDUbmd6ljARU1mPjrXWBTCAJOEP0syz+oZez59/pXxFKRGVrN
         H9FyiEPiGvLztLMQbDwZZzjEXf8kj82TDX4UsEdWGFihakU1Gf9YlImjYli2yAMUhhxj
         dQpYhSigNYbA6ccqBkUB4ZLbOXhewyhOi7nlZb2TloUBFQMnsc9gZsB4aYZVKD6BMV1G
         xbqLOelnwHLhCSHOFp8pKgM4FDk1sfl+ZBL7ft0Jjen8UGUjPRkOkGZScsVsaD09bZxg
         FtsK2r+QeQED8U99G42dRRjJJsn3+yTDtAp8fYuX6abXR71cREkct9qS1VcRoVi/apK7
         XO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU39qBF5h7SyFCchJVSrotD6D2EaovdG52MYXHxjkjyrcOMMA4G7g1mPlgY+F9IhG3qa16kYI6yRGDqUhpY4Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEP/OAkGgFFUvjx1o2LhiEKlZ+iLgq/RMQowRaAlwiY4UhKasn
	fiz+gRNePAxDKewb7QaaGBoW40H2a4YYOdnO10SB73EXB4kzFa1YFjvAki8BMYXwBbk=
X-Gm-Gg: AY/fxX51Ip08AUlD9AFlu4rDGXD0ovFrU4iBsbswC7lApoCTxF6UaiHe6S7ZFEcfVew
	Oz4QrlTWqr0d8N8yjBg0SGxk8PzP34NprU2886WiZmRijaSC+lIsSXQi1E8CA/BjASq/FxUAFXq
	n65MXzRbDask+3ZXF7gfPMI3Q7SmEZNlKckyOylBa5qnn028kgmvnPzhn6Lrw4K77HG2LjwUPwk
	N40ym8VvzEoINLzLQJaTbYwOiMuWbblltAiMw+TO29V9urt2NBEd7ZcuyGmx5vyJwu/hYblnI0w
	M8vPtnkm64xzGoPeHrmqwO5t/5WOaha7uHwXwGYyIgsCn0DRQgbi9+bRzYghUCwqgDAwlA0OHuE
	XU0lA8ViM2McwJLEjErS8Jfe9Jw6ZAZk7VQ/3IDXxZoL+oJM7tJV9UGY7/zu3rzTfqcpcqkWCVe
	rvc6nSDjCZ7iYlA3yGSNIDPU/If7K9mHjHnKCMHW+psA==
X-Google-Smtp-Source: AGHT+IHKV1LEX2Kg3/u/Laf0CuUnSDbfVay62iMr9BZEu/EkpT7Nz24/p9OPfOdHBurpeZ+kYCwV8Q==
X-Received: by 2002:a05:6000:2311:b0:42f:b707:56dd with SMTP id ffacd0b85a97d-432c37c878bmr22055424f8f.33.1768230512058;
        Mon, 12 Jan 2026 07:08:32 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm40089995f8f.11.2026.01.12.07.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:08:31 -0800 (PST)
Date: Mon, 12 Jan 2026 16:08:30 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Sun Shaojie <sunshaojie@kylinos.cn>, Chen Ridong <chenridong@huaweicloud.com>, 
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
Message-ID: <uogjuuvcu7vsazm53xztqg2tiqeeestcfxwjyopeapoi3nji3d@7dsxwvynzcah>
References: <20260112040856.460904-1-longman@redhat.com>
 <20260112040856.460904-5-longman@redhat.com>
 <2naek52bbrod4wf5dbyq2s3odqswy2urrwzsqxv3ozrtugioaw@sjw5m6gizl33>
 <f33eb2b3-c2f4-48ae-b2cd-67c0fc0b4877@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="57d4b62ug42tsq4v"
Content-Disposition: inline
In-Reply-To: <f33eb2b3-c2f4-48ae-b2cd-67c0fc0b4877@redhat.com>


--57d4b62ug42tsq4v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
MIME-Version: 1.0

On Mon, Jan 12, 2026 at 09:51:28AM -0500, Waiman Long <llong@redhat.com> wrote:
> Sorry, I might have missed this comment of yours. The
> "cpuset.cpus.exclusive" file lists all the CPUs that can be granted to its
> children as exclusive CPUs. The cgroup root is an implicit partition root
> where all its CPUs can be granted to its children whether they are online or
> offline. "cpuset.cpus.effective" OTOH ignores the offline CPUs as well as
> exclusive CPUs that have been passed down to existing descendant partition
> roots so it may differ from the implicit "cpuset.cpus.exclusive".

Howewer, there's no "cpuset.cpus" configurable nor visible on the root
cgroup. So possibly drop this hunk altogether for simplicity?


Michal

--57d4b62ug42tsq4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWUObBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgfBQD+LRMv2fmPFzKZKYK7xH07
xkhePTg1NW33sf1/vTxdhDQBAOhjME1GIwRPEdrHWZa/OJA8akS3jrgvjUc32oNZ
W/AE
=x6DT
-----END PGP SIGNATURE-----

--57d4b62ug42tsq4v--

