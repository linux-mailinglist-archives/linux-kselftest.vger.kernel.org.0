Return-Path: <linux-kselftest+bounces-31522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004EEA9A4AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357F23A8D6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6266A1E5219;
	Thu, 24 Apr 2025 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CZhOGtQD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD00DDC3;
	Thu, 24 Apr 2025 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480760; cv=none; b=QncgMgw0c4AIsYuY16Ef39iTxFolSTY7k3Rb7qUi6lKDPDAhEDiJv+sQQlUPW58QqEZUxheMcGsoYcQOZjCwFc1FRFM9m0UeHSLid3h88luGKJJsRKL4hTWFIdI941dj6iJQOXcyJ36IzDOeJ+KD1lrImbFi0apF3IsWEnqFE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480760; c=relaxed/simple;
	bh=sxpPaFhd+Ue6b02ohkhAO2i4Z5lkuhyrfHxIzZsWLIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWzSAj7p+BZ3IE+n+aJUm/b2RyBLyo+BV43n7sRrhTqdB4RDrpAOdiFuXKHg2gvyTj4hUVNgujqb7YywzWvexwIreNcOmQawoS9FtXrudPYYHMEYP8+xT+mEBxT7//xCfkN0/Du/SMmwZPyOI2LSBYqtqeSxaMIO3ITOBNHn/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CZhOGtQD; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by smtp.orange.fr with ESMTPSA
	id 7rHMuyZ0fRaJG7rHQuYlyJ; Thu, 24 Apr 2025 09:45:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745480756;
	bh=2fqv4IDSS2zr1aUyGU0ieiex1pCPFx+Sg+AMYvPVOJA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=CZhOGtQDVNBzTGef0MCcbPx2sQ/2YgBsuuJxn/5fSoiC6J0ZmJzUpG4hWa7LB8LcV
	 l+8i4AlJJuQEbJNFV+MbekNgf/OauuEbKnbfHZJvVMCC1W0NnYNOIwvKmLKvZR6mWU
	 SrTCYAzAOccBtwmm5JnIXmt34bYWU82DGcO1HogkEvR/Q7r1Xx8j7GQSDuS4TPxu3F
	 tM75tmApZxH0KfNm+Av7YMbDnQAeZjlVtbIF6hLySANyX2g83krQw/vIuJp1/N3NLS
	 r6j5RHBRwAmxrgC2ovVrSPSavv+SqQYWfFyjE+dcx1YcRpDGBQfSvmyprDUqJlrEw5
	 bqbhe1hO4HJUA==
X-ME-Helo: mail-ej1-f42.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 09:45:56 +0200
X-ME-IP: 209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso118263566b.1;
        Thu, 24 Apr 2025 00:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHpsjiTF8B23UF5skpC5ORXXSaeWO8PfGPHoDqMvnsPBkUXcn8eX8M7ex2vAnKnneyDBcBi05V@vger.kernel.org, AJvYcCVgGMkyEDmfY4/yUFNnGDWTIWcYzQ4BHXlI60Khk0pHp2J7YeWxdI/82cakdzHFR3W+7dkKyvj5sHqY1lVkAu48@vger.kernel.org, AJvYcCWpHAMeGOsoQFEIty2cF0vfDpohpofAo8EcKZJwhan6G8oFDvQJ0aqlLTmrzDTegtPnRKybLYZWy8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyGfCI4mrKSSL3k2e81F1bGm38Ldb4QzlCNOY4CVqzLvGJoCT8
	VFNB0F8xmUMqsyr0B0GWPCss5HgMTGZ+Ysg12sudazFhTvym1K1Wartvn2uQGCH5+5A+O56XjOq
	E6WqcvpiM8xdNEGMQlOd7gAxHDcg=
X-Google-Smtp-Source: AGHT+IEXEuzhAtzMJUDSys5Tp9omu6oqt32tdaeZ9eDKgN3uoXirPbUeaxeLP4sm6QZQiet7HI/xBdUBvWJbK92Zd60=
X-Received: by 2002:a17:907:3c93:b0:ac2:9093:6856 with SMTP id
 a640c23a62f3a-ace573a6e8cmr170228666b.54.1745480752789; Thu, 24 Apr 2025
 00:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745323279.git.fmaurer@redhat.com>
In-Reply-To: <cover.1745323279.git.fmaurer@redhat.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 24 Apr 2025 16:45:41 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqK8TdzzMW645OLq5tbkyQdYW+tGGVcr7vsRBE81_u4W4Q@mail.gmail.com>
X-Gm-Features: ATxdqUGcHCEvNbNb4kKFz7RewC2S_idBvf0uxICwJ6_bEDAtUlXro5ygwq8HyoU
Message-ID: <CAMZ6RqK8TdzzMW645OLq5tbkyQdYW+tGGVcr7vsRBE81_u4W4Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] selftest: can: Start importing selftests from can-tests
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, dcaratti@redhat.com, fstornio@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Felix,

On Tue. 22 Apr. 2025 at 21:08, Felix Maurer <fmaurer@redhat.com> wrote:
> This is the initial import of a CAN selftest from can-tests[1] into the
> tree. For now, it is just a single test but when agreed on the
> structure, we intend to import more tests from can-tests and add
> additional test cases.

Excellent initiative!

> The goal of moving the CAN selftests into the tree is to align the tests
> more closely with the kernel, improve testing of CAN in general, and to
> simplify running the tests automatically in the various kernel CI
> systems.
>
> I have cc'ed netdev and its reviewers and maintainers to make sure they
> are okay with the location of the tests and the changes to the paths in
> MAINTAINERS. The changes should be merged through linux-can-next and
> subsequent changes will not go to netdev anymore.

I am not a netdev maintainer, just a /drivers/net/can maintainer, but
you have my blessing on this. As far the location goes, your proposal
makes perfect sense to me. Actually, I can not think of any other
places than

  tools/testing/selftests/net/can

for this kind of thing.

> [1]: https://github.com/linux-can/can-tests
>
> Felix Maurer (4):
>   selftests: can: Import tst-filter from can-tests
>   selftests: can: use kselftest harness in test_raw_filter
>   selftests: can: Use fixtures in test_raw_filter
>   selftests: can: Document test_raw_filter test cases

You are doing a lot of change to the original to the point that this
is more a full rewrite. I have no intent of reviewing the first patch
which is just the copy paste from the original. If no one else has a
strong opinion on this, I would rather prefer if you just squash
everything and send a single patch with the final result. This will
also save you some effort when migrating the other tests.

I have a few comments on the individual patches, but overall very
good. Thanks a lot!


Yours sincerely,
Vincent Mailhol

