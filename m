Return-Path: <linux-kselftest+bounces-18411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226059878E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496091C211F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D015B55E;
	Thu, 26 Sep 2024 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UIF7QQB7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3115B0F8
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374218; cv=none; b=PstcVcO3t9CyuBw5aFC4SIDNmYpfkMyoQq9xtJqKSeg2gvnVUkQzaChKqycd+ljgI5pSd4t4cq5IYcW4Cq8wzny87t1LfIQ8M2mSeat7ZSB2QBAHuo11wKIdCrZnfr5tiijVTFBwIFfg7gkgiaKKU4prSQ7HMwityrBkhAD/0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374218; c=relaxed/simple;
	bh=qpVU4XxBpLxpVoXpPAGlozVOH5+EVpvozVpRmm79Z30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbBohhIg9TkUEqb+oNbkYSf/Qi4AtYMr/tG7q9SDv+PLb53UayGb8UVHUvLfWhdH+MHbhei66aCLvinqBciUyue6t9eZZbpAWIEvSk7xK3HsiMQWKjn/BV88hVEMiFMiCovNddb78zRuUfjPH5MoQqih+LYTvBee6bfT73cPnqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UIF7QQB7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so210502766b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 11:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727374215; x=1727979015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdLUqsRCgKs9xu0yc5QAq44cfc/XbnINgvpnk0KSrKU=;
        b=UIF7QQB7DlJMY+XWeGj40Vk+FCghvKNqq3JvBnuTBpdMP9mYk6lgwqGVCbTx7CdQca
         XNc4TdKfWDUFBs8eUI5ETyGA7bA+QHF0oT+OK4p4EavoFwDtchtp92dKMZ7N6imezmGo
         tCMEx4ToENa1znyrYCxFiSZqPm9hoLKcH8T4bfEvndylaSD5DUEdgsUjomKRFCQCgHj0
         sYfcxjq84qesc6LeyDK5GvrWXl54k45uoOu0vm7RRqhoiua1YIiPvXtjh1QhuGoTjkU0
         RSdmZi4PcuPRptWtxLUJaPXVPhjoLZgm6P8G/rvsYxwSAQ9IsMVW20/i5Pjm50GTRc6w
         +MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727374215; x=1727979015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdLUqsRCgKs9xu0yc5QAq44cfc/XbnINgvpnk0KSrKU=;
        b=BHxE4WDVQ3iTC15WwlsKGI+q/ELm6s5PLpiNTm2b8lHQ9q08awlzQ98lvjZe6hD0gS
         boQe5yjM2vYCOttA5M8bC99WPPBRCJOV39e26JvIN6Al35uNA+PWi3/DsdynO62f/JJn
         CB4EQqtZoNQZG7KkrwHykJmXq+RMfwgAWO3BKp7LwlOPAu/1qvP8C1C0vX3s5Sj/aWzz
         GuhD3qpLN81q5Y6SYphTA1A5w6sjkpCC5MXf6JYHv8dJewSnv7vu7fEBJxzwaK/EAX07
         25ihaHQO5yUV1SmHY5n/ZaHBdk/YfL0fhOKEpwqy35b9kSb5G1vGfiFLZAXCKN3W1q/0
         s9oA==
X-Forwarded-Encrypted: i=1; AJvYcCUUX7wkSmj9l2jiHBaIGzAA5P8SrRaf3JnhHVxiZxAmYcNYYVqdtCUInRp8Yifd7I21jVI0BgeIdZazecbOnhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3jRIAYmQMvJTepxnK1r+wdURbOWQgkT+2duAFdTI5znwCXE3
	Ypba6afZEPb4q1FMleHmd00eFF+CZjJkZEJaF1BziJvs19UmPusYAF5r0DUJnw0=
X-Google-Smtp-Source: AGHT+IFniY8fmaUhZ/fnujb4SqS4NPVhEDpJ1jgTM0BVn+LDEqv2jyzNVfGZ7xDl1iKSQOvNI8Ys0g==
X-Received: by 2002:a17:907:9444:b0:a8f:f799:e7db with SMTP id a640c23a62f3a-a93c49180a3mr38338966b.16.1727374215173;
        Thu, 26 Sep 2024 11:10:15 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948fd6sm23625566b.101.2024.09.26.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:10:14 -0700 (PDT)
Date: Thu, 26 Sep 2024 20:10:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com, 
	shuah@kernel.org
Subject: Re: [PATCH v3 2/2] cgroup/rstat: Selftests for niced CPU statistics
Message-ID: <xmayvi6p6brlx3whqcgv2wzniggrfdfqq7wnl3ojzme5kvfwpy@65ijmy7s2tye>
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
 <20240923142006.3592304-3-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2f3kmuusie7grq4"
Content-Disposition: inline
In-Reply-To: <20240923142006.3592304-3-joshua.hahnjy@gmail.com>


--t2f3kmuusie7grq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2024 at 07:20:06AM GMT, Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> +/*
> + * Creates a nice process that consumes CPU and checks that the elapsed
> + * usertime in the cgroup is close to the expected time.
> + */
> +static int test_cpucg_nice(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	int status;
> +	long user_usec, nice_usec;
> +	long usage_seconds = 2;
> +	long expected_nice_usec = usage_seconds * USEC_PER_SEC;
> +	char *cpucg;
> +	pid_t pid;
> +
> +	cpucg = cg_name(root, "cpucg_test");
> +	if (!cpucg)
> +		goto cleanup;
> +
> +	if (cg_create(cpucg))
> +		goto cleanup;
> +
> +	user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
> +	nice_usec = cg_read_key_long(cpucg, "cpu.stat", "nice_usec");
> +	if (user_usec != 0 || nice_usec != 0)
> +		goto cleanup;

Can you please distinguish a check between non-zero nice_usec and
non-existent nice_usec (KSFT_FAIL vs KSFT_SKIP)? So that the selftest is
usable on older kernels too.

> +
> +	/*
> +	 * We fork here to create a new process that can be niced without
> +	 * polluting the nice value of other selftests
> +	 */
> +	pid = fork();
> +	if (pid < 0) {
> +		goto cleanup;
> +	} else if (pid == 0) {
> +		struct cpu_hog_func_param param = {
> +			.nprocs = 1,
> +			.ts = {
> +				.tv_sec = usage_seconds,
> +				.tv_nsec = 0,
> +			},
> +			.clock_type = CPU_HOG_CLOCK_PROCESS,
> +		};
> +
> +		/* Try to keep niced CPU usage as constrained to hog_cpu as possible */
> +		nice(1);
> +		cg_run(cpucg, hog_cpus_timed, (void *)&param);

Notice that cg_run() does fork itself internally.
So you can call hog_cpus_timed(cpucg, (void *)&param) directly, no
need for the fork with cg_run(). (Alternatively substitute fork in this
test with the fork in cg_run() but with extension of cpu_hog_func_params
with the nice value.)


Thanks,
Michal

--t2f3kmuusie7grq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvWjggAKCRAt3Wney77B
SXAPAPwLI2zDUVdxqbLYo39+smefNll+tXGO41EZkNjzc/aAmAD/cC0yuzrf+NQ/
v/jEJxSx3OpRtUzyq9zehnGulc5RhgA=
=VLNq
-----END PGP SIGNATURE-----

--t2f3kmuusie7grq4--

