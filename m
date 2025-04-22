Return-Path: <linux-kselftest+bounces-31300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3BEA968A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 14:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78926178BD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1727CCEE;
	Tue, 22 Apr 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KH1OViQG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA427CB30
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323897; cv=none; b=Pc58t2td3ttI04NQjyB1BrlhytgsN/kHlJW5dT+WVXvXPoUnDXmQ6lGFJJCHI0P/jFyRtP2YngAymwOurbHch+BIiw4Z//E5iRCeELrK3vA7h9U47XBq8AuVd7HmUah2/2ZZWqqdPTva30vnDPKyszZlHuOtREdEWzvHLS1S/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323897; c=relaxed/simple;
	bh=Q/0eQ4z6xF/rZSS6yNW+QOVGiNYbzpf0j7hh9npWX94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR1EcwCrmuAj1IrB+ytXCTcELggvP8LUoyIjCelE425qDSml2N5TQPwDJUvnsirzSkCThojpp2XgGVj8xW9zoNi/2wj450Qs11EB0fqkj5DeVfVMCUkzf4qP/irCrl6oVhPJMF9nnT96dCxdRwIcw+YKoqiKMwK8532vlAtd2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KH1OViQG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ace333d5f7bso56053966b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745323894; x=1745928694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KT1JxRWSPsmY8fesz3r5b2lILhpBpQyPhmAe3rmQpu8=;
        b=KH1OViQGN/9Izj1jLQ6iOqU8f1rpU4HpLRSKlHxG+hpwZ0RTgkdnUlnydB/Je2YhMN
         AUYbcyFbCMFK/aq6y+GMjpWunX/jJ+sYUpULEXUvbh9QIWZSJmXd9oN2AvmD+z45kJnm
         KLOtqrODJ+Q6PBRgq34JwMSttRarvpTO41Bzjf/FnLJiGNSDhVGu0XEJ51gRi2F7X/kT
         yvSg27sjlI8t0dT2ixjAgyQVPeloMRLtsqpU4PGzcVXl2f0yeWX+DohxBfLbTE/WMI0R
         Y97tCfDVKys4eelK/2fCfefHNBjjxc25LN+fJ7WCXXfqSDYRMvkSqNXWWW41Lo9dzPGn
         Yy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745323894; x=1745928694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT1JxRWSPsmY8fesz3r5b2lILhpBpQyPhmAe3rmQpu8=;
        b=kwfISIxp4jVAiw4pVFTBP3Um48NIZnO2G+7sqxKZpboh5sS41/hez7nSkmvScf0FAe
         plWFumztOdaiV8AivcVe9wSEvcq9hCGc8HBS3Dj8zCWkTTIc7GPUVTj9d0/MH0lFvgMf
         P4sB45ySqtfru7W1LIs2hEonyFkLqlxOE21Pu4XQRljgKRevQu6zTrWVGgwHHa0YTZEK
         BbHfNWyUkFj0WJsaWOoJD22dAYBGXXYF5DFjPFzoLCZI6jeLkIlNqz/PCnVBSxwrp8V9
         bujpWe2m85/uHAKugzgi2jWHwVIJNafyfVoC4UDZy/SPzGoUMcRPAgqVVQrdsfHYfGPn
         8cGw==
X-Forwarded-Encrypted: i=1; AJvYcCURPwzHex4G/BaDMz0tsCriq644jvu9QQHuj+zgSmaxlCa1UJVo4KO6FIy5Hejh0aq6HZoOBWy6QLD7egYnt+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADV9Z//J9b3war8cVv5anddojaI3jw32zU7zMNlkff0Oa2uZO
	J34s2Ika4b8frTGwkgGYkDJJFvCsNS4Rz5CE2xdJYI4EXMaooqndg1eevcN6das=
X-Gm-Gg: ASbGncux2g21TjlCmcfsjbF6W+I17tbU8nRGBIsiKqFNN1K8siF6yNAoO1ojXY0o7wg
	Oqeq7hRfR1lO5gHPSCBcx5Cz/rvJMzettGB6ltveNs1CV/H+887bK8pjd9tEo+64jVjnWX674uw
	A6iTebpEnGacsJN3EX2844xySp9RPP1VJzY8DSwKo3ysfSVo9YQr9R9O3boLDhQlWe6VZT1stXe
	7+ot1tszgs1gxd7TCe5RBDXsZ+Jt8BIfTIn8hjp26vjULFgNvEVM9x9Ac8fPlmxPotDOt9hmh7F
	kh5bDGnIxMb+YevJ1bpQCjtXiUi/ULWnIVTUqJwOl/k=
X-Google-Smtp-Source: AGHT+IFyYmcZlvcAITMghOEvilutpzLwoU5xPOnInSRoTQAJsg2jq3a94IEVeo4CoWvMA1NEnQNxKw==
X-Received: by 2002:a17:907:96a4:b0:abf:19ac:771 with SMTP id a640c23a62f3a-acb74adabfdmr1382972966b.2.1745323893733;
        Tue, 22 Apr 2025 05:11:33 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef4ac41sm644389366b.152.2025.04.22.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 05:11:33 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:11:16 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
Message-ID: <h64z4wl6mw3qxfwmqsvlddsie62ehkoag47lm2in3nda7dhloq@rjxpkggawqem>
References: <20250415210415.13414-1-longman@redhat.com>
 <20250415210415.13414-2-longman@redhat.com>
 <psbduszek3llnvsykbm3qld22crppq4z24hyhsp66ax3r2jji5@xhklroqn2254>
 <0033f39f-ff47-4645-9b1e-f19ff39233e7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sq3j7fc2pogean7z"
Content-Disposition: inline
In-Reply-To: <0033f39f-ff47-4645-9b1e-f19ff39233e7@redhat.com>


--sq3j7fc2pogean7z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
MIME-Version: 1.0

On Sun, Apr 20, 2025 at 05:48:15PM -0400, Waiman Long <llong@redhat.com> wrote:
> I was referring to the suggestion that the setting of memory_recursiveprot
> mount option has a material impact of the child 2 test result. Roman
> probably didn't have memory_recursiveprot set when developing this selftest.

The patch in its v7 form is effectively a revert of
	1d09069f5313f ("selftests: memcg: expect no low events in unprotected sibling")

i.e. this would be going in circles (that commit is also a revert) hence
I suggested to exempt looking at memory.events:low entirely with
memory_recursiveprot (and check for 0 when !memory_recursiveprot) --
which is something new (and hopefully universally better :-)

Michal

--sq3j7fc2pogean7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaAeHYgAKCRAt3Wney77B
STU8AQDtPchwdDd7GvYG9/lftHphnD62oj3o0m0hpo2aWJjY4gEAjv+IF2GZLFKQ
73DPixoPDX77bf3ZdvlqpW53y0lI8wo=
=3Mvf
-----END PGP SIGNATURE-----

--sq3j7fc2pogean7z--

