Return-Path: <linux-kselftest+bounces-16986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD7968B42
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 17:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8183BB22C61
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E2E19F123;
	Mon,  2 Sep 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J9jt39xt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87819F115
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Sep 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291945; cv=none; b=JesCZ0LmNzKH62Mh4Yo70jPQXtMHFf/4ghRgymMBgurhuO+fXDrgwR9jM3l7S71QIuq+AJWLRVzt81D0UZhp5BpGRZgdpIm0xyU7euOGm5B3kdkCDywm8YrPIQmIVRdqHhbSCWqwMK902lIYoUY1aJ3MGZ7WFAPKvoaenAchC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291945; c=relaxed/simple;
	bh=WfNDbFKaXEQ+UWHsRcQOC0oApgX22xfzOoTR1bFeDKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/Rj94cVTNWQkTaKBI9JNjQ6/Hrn+2E9xBt/yrN07oVGh7JRiYs1b9M1PmCdmmB8PRNKswDU9BqNN7wR3yIlb2bv1YZhFz/WkFBaghsIHmJkHnJKu6rDJFGe4i9CNEt8veZ+D9oeBTzIaHzMFk4EaJJiSt1LrroLL9waB0O3PDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J9jt39xt; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f4f24263acso65591481fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Sep 2024 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725291942; x=1725896742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOSvR4tMpfpkU/JecxX/SlQqf0ig96cu+JpUFgP7gSQ=;
        b=J9jt39xtf8MEVsUOzpdVBEr/VDkIMf9THG+VRdAH8oHSJsdm8zQJKMrekipkli4Uz4
         tLavPykw4hpSQTl/d4ryHmimPSNY093084mUr2Nv4RnakLxWBOVOMdzmCVuQhIhP07KI
         WMNuJu7oWF+ZBxDl4XanHClIZlcL6582qOEbT7c+ixUwLV5g870qpPqZXb3EBR0A19HR
         Di1u5QVgOThUh+7XAMGZhrF8L+eb6BwcVExkGJQ4ADrfV1OSOb+rRNQSCQNj/70BDexF
         AgygmuGbce+kLONjOcpozneBZcOWSKZ3UUhu+cS7Orpy7zPCRKm71dMhpkOa1h53hHTp
         ZGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725291942; x=1725896742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOSvR4tMpfpkU/JecxX/SlQqf0ig96cu+JpUFgP7gSQ=;
        b=ignB/2O7ffOX8ozH64vDNAkfYIWZQ04PszwfXjVuzuhqvbA8LuijRU3R14IELTlqMK
         kLmDCO+AXHgpOX9LjI5nhzZSVhFtNb/MMUssWVLUp468hPJrbYP13wQfiedSHG7ewJBL
         XdnS+VXHPMNS7R1XZ7dnCLr5UDLCRyRpqxUeq704MsRp6ZOFFygvK5ksXlcBPOGQfcoF
         +b8T/93K+l9CBrQjcUE/wU1nMA3mcIQae4FlZ2K7UUbud3uEp//jrDTyfWhk6oIZ9+PE
         uI/ZfImeLXQorHajh6kMeohPXQ7xbDuCjsbRJ7oKbLNxOyAqHYOwO3CUyrDtF3KLXO9I
         NklQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDSDegsFQQ861h/+sL+x7NfvLKrGhc1v0Kyy0BevrlqPGmxg8rPRnhcYh3CMc5BxUSzSP2JYPZfXQHYn+31hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIJLLlCn62J/mACf2eUsb9Rl/yEu6GwYsSNVs4XrqUOKli6ekD
	if6kV2DiXcuFo3E8mpYHdxPC5RFcelz1Hq0kHpFVQ9UQBZHhh2+y1eZ9gC1k1bM=
X-Google-Smtp-Source: AGHT+IFgi/MueWlxs3WBPqBpaI2dWmWxiH/V1PyeAg+px8C/9CVU5AJ/GqLVc1fypY/h30wt2uBgxg==
X-Received: by 2002:a05:6512:ea8:b0:535:456e:f56f with SMTP id 2adb3069b0e04-53546bffe51mr10454338e87.58.1725291941544;
        Mon, 02 Sep 2024 08:45:41 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891968f4sm569547566b.106.2024.09.02.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:45:40 -0700 (PDT)
Date: Mon, 2 Sep 2024 17:45:39 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com, 
	shuah@kernel.org
Subject: Re: [PATCH v2 0/2] Exposing nice CPU usage to userspace
Message-ID: <mhugflcvgtv2iwyz2i63dkteur3xhnqn5qi37gzwc7mkt4sfn7@32kenf3bnhzf>
References: <20240830141939.723729-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjp4wemvnp3oxeku"
Content-Disposition: inline
In-Reply-To: <20240830141939.723729-1-joshua.hahnjy@gmail.com>


--pjp4wemvnp3oxeku
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Joshua.

On Fri, Aug 30, 2024 at 07:19:37AM GMT, Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
> Exposing this metric will allow users to accurately probe the niced CPU
> metric for each workload, and make more informed decisions when
> directing higher priority tasks.

I'm afraid I can't still appreciate exposing this value:

- It makes (some) sense only on leave cgroups (where variously nice'd
  tasks are competing against each other). Not so much on inner node
  cgroups (where it's a mere sum but sibling cgroups could have different
  weights, so the absolute times would contribute differently).

- When all tasks have nice > 0 (or nice <=3D 0), it loses any information
  it could have had.

(Thus I don't know whether to commit to exposing that value via cgroups.)

I wonder, wouldn't your use case be equally served by some
post-processing [1] of /sys/kernel/debug/sched/debug info which is
already available?

Regards,
Michal

[1]
Your metric is supposed to represent
	=CE=A3_i^tasks =E2=88=AB_t is_nice(i, t) dt

If I try to address the second remark by looking at
	=CE=A3_i^tasks =E2=88=AB_t nice(i, t) dt

and that resembles (nice=3D0 ~ weight=3D1024)
	=CE=A3_i^tasks =E2=88=AB_t weight(i, t) dt

swap sum and int
	=E2=88=AB_t =CE=A3_i^tasks weight(i, t) dt

where
	=CE=A3_i^tasks weight(i, t)=20

can be taken from
	/sys/kernel/debug/sched/debug:cfs_rq[0].load_avg

above is only for CPU nr=3D0. So processing would mean sampling that file
over all CPUs and time.

--pjp4wemvnp3oxeku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZtXdoAAKCRAt3Wney77B
Se8gAQDRh3DgBLtj3DCNCk75FE2vtjfD+GRH6awHFPeBC2A+IwEAxBg0GoPbsEYV
jr31hYEW3dftJtxBNrZ5yUFj2uTuXAc=
=DYNI
-----END PGP SIGNATURE-----

--pjp4wemvnp3oxeku--

