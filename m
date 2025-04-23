Return-Path: <linux-kselftest+bounces-31429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B029A995BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D07188AE8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D82820CC;
	Wed, 23 Apr 2025 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oo3A0fJQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687CB101F2
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426984; cv=none; b=ad16S4Jbw8druP/2qpqs2Ka4lA382oGQRG4N25Oxm8pdPDdftwarBFXUAVtTJebfuMPclHyFIRskh6plaXf+P+qvowdmx/OUAltZr9cshRcZ/xfYM+iLmpAZXaapEboYiQrN4mhIdkKhkGRWjjGFcteoUsF+C5pUqmwUfIHIp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426984; c=relaxed/simple;
	bh=oQNZMJTmyhgvizGXpzduup4GcugHaOFijzv+8dpnUr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl17aE07HpThlSyDRpjZ7+BsVv2V9ShPHUN1coFnVcnE2sWK07l0bfgklCNZvLOE70ktFygHgSZXY1F9dZrpgKt3I6eNODuDwnEPt3S9K34mDfddQ+3b2aRlAtSPzbLeNVxaM8LH6/TKw0yqsXBN7vxqPtwKehSYjILLrUqZFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oo3A0fJQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso22455a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745426981; x=1746031781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdvq3dgbND2yhqAcp9bTHmeHLzUTNkf08e1f0uJeekA=;
        b=Oo3A0fJQXRgyg6jLDGabva23rjMgdtDT3xGkTq6eAgwihuGOcEYE75rYp5p8Nf1fzp
         HY/G7fo9WaGj4fsjS5Mh2PVwNHGYSolR4iAn85Zqx3ZetCaqDPO0aDEWKYIV4Edv/mPq
         faVzivNbpXF6tKhQaCkIeB4hzjii1O31SDi1E13swJ+taBMDDathkSk440RljSWMa6da
         oMwUNCZ4C/vqFcxBs/1ny3NxgZbpLqrt0J0slxDOhxp8a3ynQBqljS9eW/qpCCzKUv69
         bZ2dPWuhx70l/O2qze9LFtL7YfEAc5C5+yZGLblkE+E3rbeIr/quhQBKfaRKBq9eCKX4
         MkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745426981; x=1746031781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sdvq3dgbND2yhqAcp9bTHmeHLzUTNkf08e1f0uJeekA=;
        b=pxt0gFXOjbppCW+psuv7QXWelGT65aQdq0peG0GgCjHwy0HH/F7vfgPlTxPwjt5miu
         7VnzgMzyUiNWgOzmHKShvSezDRXJ8aDOX0N7EkNvlh9KXt2a5E5alpjuAxISPvkXwu6A
         uo2VCrxq1vYTT4pO/uD1NSXn3zF3t1B3WATcDeRUhE1bxgIUizOzWONe25BuJCVrNzUv
         wublNCH4IIojlOH12paXKIcE9GAa5fU6BoaZr3xrkGG4toxCXVcB7gQFj9NOsRKSLF4d
         hb0GWEHGgIV+0hTp1Gab/02dIq2dp7bwU3FIHJWRq8AtuMt7O/iBqq7xmKVFZKkALaFX
         1JOw==
X-Forwarded-Encrypted: i=1; AJvYcCWhOGOd10IulN4eoF6rsqaxeKjx3ZsNSxBdPuQiHoHIjECVfcRyZzlmR1B7/yZ27//5AZVf3Ph7YQnNIeTltsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE49RLp1E02HWJwp3t8osfw0c/TkP2W28zIRlXdsO7Hnu7TzaE
	LVuNYwQsLNk2sG+f9zTnRW3SZCdJ4o1X844K1/h9DzX4qjdWHkvLciFJt4iMECY=
X-Gm-Gg: ASbGnctqkAr9PEO+Tr06x7Fh4keTSOiL/DnrvreWsA8bickv4kmQSLb5LEfF0UsiofF
	71Fv5Z2jljDMuAYnS8oPZxVZutcP4w6EuPfE77JAn8BXVaPynk3U8GkHReIARL+V21wYnH/naGl
	/MoD3fKj1oR7Sxcd4pfBbgmhF0YRskitOOzp4T9pJZGi6AyzEgAzhqOCyL5qyhGb9Nvt8mBnHZp
	zzFczHuXkFHNwyVcjlOCkYGKGJcAHRQYi6rZyg+mDu575nwsrEh3wVUOtZ738Rdo7SsA4BPRTTD
	KV0Kn0KrKuxAVePEEw74JSfq77g83i/MxFMBHhiRXm0=
X-Google-Smtp-Source: AGHT+IHt7B/iOlBt7pmSJ7gzikFeMN6S/s93IPwCoTUeOdD3rWwMpgm1NgxIFUsDLPuDw5HktCTMuw==
X-Received: by 2002:a05:6402:510f:b0:5ec:9513:1eaa with SMTP id 4fb4d7f45d1cf-5f62860f525mr16307356a12.23.1745426980642;
        Wed, 23 Apr 2025 09:49:40 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625549cc7sm8007048a12.3.2025.04.23.09.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:49:40 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:49:36 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
Message-ID: <d36jhvahtoqqtuw4y2k4rjzmxnu4ejbffvimrnffvcu3raby6l@asjm6h6r7w3k>
References: <20250415210415.13414-1-longman@redhat.com>
 <20250415210415.13414-2-longman@redhat.com>
 <psbduszek3llnvsykbm3qld22crppq4z24hyhsp66ax3r2jji5@xhklroqn2254>
 <0033f39f-ff47-4645-9b1e-f19ff39233e7@redhat.com>
 <h64z4wl6mw3qxfwmqsvlddsie62ehkoag47lm2in3nda7dhloq@rjxpkggawqem>
 <d32c626d-1c93-47ec-8b01-1c085b4bf2fa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="anb7crrm3nolrfjp"
Content-Disposition: inline
In-Reply-To: <d32c626d-1c93-47ec-8b01-1c085b4bf2fa@redhat.com>


--anb7crrm3nolrfjp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
MIME-Version: 1.0

On Tue, Apr 22, 2025 at 07:58:56PM -0400, Waiman Long <llong@redhat.com> wrote:
> Am I correct to assume that the purpose of 1d09069f5313f ("selftests:
> memcg: expect no low events in unprotected sibling") is to force a
> failure in the test_memcg_low test to force a change in the current
> behavior? Or was it the case that it didn't fail when you submit your
> patch?

Yes, the failure had been intended to mark unexpected mode of reclaim
(there's still a reproducer somewhere in the references). However, I
learnt that:
  a) it ain't easy to fix,
  b) the only occurence of the troublesome behavior was in the test and
     never reported by users in real life.

I've started to prefer the variant where the particular check is
indefinite since that.

HTH,
Michal

--anb7crrm3nolrfjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaAkaHgAKCRAt3Wney77B
SQzZAQCIfMkqhFvSUMRJRs1nSND5RQHJzEcUbEd4lZSX5UqoYQEAty8vhN2bhzOm
8ceCcBpCY2lqn5eEbe8xSjLCAE/WZAI=
=fQl9
-----END PGP SIGNATURE-----

--anb7crrm3nolrfjp--

