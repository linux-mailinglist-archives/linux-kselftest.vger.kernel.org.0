Return-Path: <linux-kselftest+bounces-18735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE2C98BCE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D015D1C2210F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384A1C2458;
	Tue,  1 Oct 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OGxEdPvA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AC19CC3F
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787401; cv=none; b=dqfTv+eQHq4bskzSX7K+8sxJ5qZ6Oc/d6kAbpB4DIvQJoqMmSbYoic36A08O2nu53BSoku8gCt7/Bm5+zlpJ5yI+av24fi1NfDsoZFNLYutM6nLeZv+b1axgWLETV7gRu1cxwueQUAtvXhe+F/QmMsX7Rb9uJHLplDKTIGh2iH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787401; c=relaxed/simple;
	bh=elaqumYw4bHnm8QveWuP63/6Z1Z/ku0pn5Z9ShUswHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqfkfEz+mEdnNOq8EHe3QhXBtEnTyR+Om92dlTkvyLe/v1EDSQuus3mMkC/5T/On2rJpJFcPLNFOYLqIEhO9PggTcnwm3FZ1NR4hHVxxBjeWMhUuNpGwlUDqbblyjGCEOLUeLPW0MjiId/faQsTEKBT3Qqcq+0KNnkfDxNubxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OGxEdPvA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c88e4a7c53so3476652a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727787398; x=1728392198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=elaqumYw4bHnm8QveWuP63/6Z1Z/ku0pn5Z9ShUswHg=;
        b=OGxEdPvARtw6QEZlbuUXyWOhhtURAEAiCCbDR3rEtQ4KCP4jZF1RsED9zLGY/imTDZ
         Ijuo+ACmted4d1dFSc+Wqw66IYBAW6i1AjYVQMq4O1+15ZwPN/t07A+45tQ5W27ylP/u
         5ADr37E9joQBOUG+ANG2VkXOZBpCBxiyhY1gRqR1y/C53bdXKVREM3C6v7hapm0Wq3fm
         XTS0A6oJq64GzFladM/DMuAjWFuhwQZKNxi5+LrXKgDavi0tErZNhEmPk7Dry3LylOL3
         aMO+zvV2VC96i/Jmx3VIjIsvVZLZ0cDAzg95oh/BoEkM4CurbzX61fZu7ZxBwP7cV0kg
         2V+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727787398; x=1728392198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elaqumYw4bHnm8QveWuP63/6Z1Z/ku0pn5Z9ShUswHg=;
        b=whygpcHQXR37pWw4T6iT7uso45BRZx4sRrWWhgmDovsL9RupwQXgvZ5D9xaMCdV+lR
         vx/ACbC9piRqf/WdKUB3yJ1maWg9UmlVOCjndGmSQoyVrq62xqzN10UFQq9Fs6p8Cr2S
         kveQz8HgFpvuhSTJiAzVsvkzwA34MtBD5dZazba+//AF5eovun/EDBJ4Cgz4ELpku74u
         sptMHIjSF3MI5SKKxge46INBDI+gjtKy8TPBFkJf5J+r8gnAKCclUKOW7eJDM1excN8V
         19R0i1EsAximoVFxC58xP8MY1nguNUbWj7jhMFcMydO0Zz6QjnzGiA3kig5ptbq8W38h
         NFWA==
X-Forwarded-Encrypted: i=1; AJvYcCWdvlQAU4zwYlsmJJkmnLBTlxrPgRBIpB1Nk70ETavVKokUujysboBkgHPCXL56W4DZ9HaWyZs/7taifbmnrkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd1siDbiMfcXjlX6TJrXRF3jqUERm8pAgmHHIsClSiWjioJQXt
	kY4dxQynZb9t6IGd3RJhbxoArBQ9ObgtNcyIwvYJnpZk86NqB+iMXAY3uifeOd0=
X-Google-Smtp-Source: AGHT+IFFuMzQa8bLdVb7xiP9LqqJ3d220UFLpvDUhIN5ChMnYlsth1zhIaCEGLIP7a8oqbX36nHraQ==
X-Received: by 2002:a05:6402:401f:b0:5c3:cd88:a0a with SMTP id 4fb4d7f45d1cf-5c8824ece42mr13869853a12.18.1727787397495;
        Tue, 01 Oct 2024 05:56:37 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245e990sm6131493a12.52.2024.10.01.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:56:37 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:56:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com, 
	shuah@kernel.org
Subject: Re: [PATCH v3 2/2] cgroup/rstat: Selftests for niced CPU statistics
Message-ID: <4l4afsuzqd6vowki7ldafoikpyw5sfwcvhhpeaezwhdmdj54bc@fhp6yt3ygq3r>
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
 <20240923142006.3592304-3-joshua.hahnjy@gmail.com>
 <xmayvi6p6brlx3whqcgv2wzniggrfdfqq7wnl3ojzme5kvfwpy@65ijmy7s2tye>
 <CAN+CAwO8XEAkoBDc03Zveaci9hASaFvk8ybQ2Mwoy_VacqgRfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ns7hq3omeehksxir"
Content-Disposition: inline
In-Reply-To: <CAN+CAwO8XEAkoBDc03Zveaci9hASaFvk8ybQ2Mwoy_VacqgRfA@mail.gmail.com>


--ns7hq3omeehksxir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 30, 2024 at 02:07:22PM GMT, Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> The reason I used a fork in the testing is so that I could isolate the niced
> portion of the test to only the CPU hog. If I were to nice(1) --> cg_hog()
> in a single process without forking, this would mean that the cleanup portion
> of the test would also be run as a niced process,

The cleanup runs in a parent process and nice is called after fork in a
child in those considered cases (at least that's what I meant).

> contributing to the stat and potentially dirtying the value (which is
> tested for accuracy via `values_close`).

Yes, a test that randomly fails (false negative) is a nuisance. One fork
is needed, the second doesn't divide different priority tasks.

> What do you think?

My motivation comes from debugging cgroup selftests when strace is quite
useful and your implementation adds the unnecessary fork which makes the
strace (slightly) less readable.

> Do you think that this increase in granularity / accuracy is worth the
> increase in code complexity? I do agree that it would be much easier
> to read if there was no fork.

I think both changes (no cg_run or cpu_hog_func_param extension) could
be reasonably small changes (existing usages of cpu_hog_func_param
extension would default to zero nice, so the actual change would only be
in hog_cpus_timed()).

> Alternatively, I can add a new parameter to cpu_hog_func_param that
> takes in a nice value. For this however, I am afraid of changing the
> function signature of existing utility functions, since it would mean
> breaking support for older functions or others currently working on this.

The function is internal to the cgroup selftests and others can rebase,
so it doesn't have to stick to a particular signature.

HTH,
Michal

--ns7hq3omeehksxir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvvxgQAKCRAt3Wney77B
SbiUAP9af/mzRnk0+6KuLlvEpaZlgQ792QW8ztnjyA4Gxa1H/gEA/txhhvPclRRi
6fUMFJnOb9l7N859/ZMEOAuVXpT4PAA=
=5tXx
-----END PGP SIGNATURE-----

--ns7hq3omeehksxir--

