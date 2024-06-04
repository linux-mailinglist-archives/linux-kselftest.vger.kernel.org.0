Return-Path: <linux-kselftest+bounces-11221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF28FBDA6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 23:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0DA28286E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0415914BFA5;
	Tue,  4 Jun 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fckzWAuQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157114BF99
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534810; cv=none; b=X2IVc4SClx/G+HQyN5bmPXwhJhDMM8XaUvcMTe/WE3M50yUJZl9MUJqjzBNtDy66X9S3Q9xfjMhvbzAn7oc1Y4SeONpLzTE1Nmt6e+uX+TMUL4vk/mTDwOsSv8iOQ0wiFW7/N8z+oCH0qEH7oH7h6k7PHlixrZ2E0+QuSq1uJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534810; c=relaxed/simple;
	bh=hvtn9Rpj72ax2PdS3Q2rjLwwSeA6zCTzR5nXK72FyUA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9ik4TSS2zKCNMJAK+1zmLKTnNaeWR+j84VpN98j1h9uKCvhFp50qmdUbdENPxyTSy+T9pFg2Kbf3Exd/RmwI03tAcD1E6/aLeOxz8NA04MEvsf5UNOjvpcolPld+iRpdSQHKGwnKPLRqr6FjMPRC+fKs50soRdsZp6YBG6BNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fckzWAuQ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaad2c670aso18547111fa.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2024 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717534807; x=1718139607; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hvtn9Rpj72ax2PdS3Q2rjLwwSeA6zCTzR5nXK72FyUA=;
        b=fckzWAuQjbPzZrK6prfoRK4QrdBzLLr3qVo4MHCWBbUiaG+XyFZjRTB/OHXCJBSOjH
         +XaR6KOHGMP3GFk45ZX1sllKgun2JfBz0wHB9IKrMtvP8l5vl8JGhbuAkorFO6tYYvwC
         ANYLJHwB3/0Jh+JX9K11qkvG4maDgdAD+EbjEeTO20vB1lT+Kvigadan4bciluZGU4HY
         P3XsDOjarxj8LZpo95Azq7NU7yAYuG4Vx6KSA7ZtmEvo7+ZGcLFtiAsUczQ54hkGOkRy
         4in3oRZSVDTAHQm4dM19hOEhKTrYpphOzZCFW0AfSwqSMugeerbtECfuDFfmUQqu+b52
         5rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717534807; x=1718139607;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvtn9Rpj72ax2PdS3Q2rjLwwSeA6zCTzR5nXK72FyUA=;
        b=Y2lXCLXWzWX3QU7a1898yEgpjv0gvbv/t8Yc7ezmHQeDPMmQF3r6PAc0KTZD+KmWob
         oUfVFI8MpDd3ZgWPZ0qPwiqbcQhb7JbF/x0ldltqA1emt2NYX6nWifjeOaO4Hf5llCbb
         kI2aRXvwS9cyMsbpGn4Cs9a+bNiiF7eZ4GjIo2TAUtRJp0ctv9rlAHKbA6B3gyqOZoq5
         6LDdgIrc8MAv3RbK8XXmDlP8f6tMjixsr37Fh0vx5Du09eoYsqaE4FzaNwR0DzkKIuJa
         6Am/7H5VvTrPhoBpnc5aXvMqvOGcVMzO/o7RUWlVrEA1ZgH6eiQ/OGiV+RCR0/kkMhN+
         2sPw==
X-Forwarded-Encrypted: i=1; AJvYcCXojcBi1s6cMYcZUk8fJYz13fcnYipdqy30fFhdNZlbxdAywJGSiV0bnCGJZtwUyPQ4cpTtcxnujAKXzkF8ihdZTF+bSIDmS/zARRP9wDyZ
X-Gm-Message-State: AOJu0YyGFstz5dgeASSdjm+vhB8ic82bPoUdhOIwyZFbigN0Cu77zFqD
	mxU3omh7Zzn7joErbw7UMB6Q2daZoTfeMTm7rksBi0D3Q/S3S8pgB/wf2BaV4P0=
X-Google-Smtp-Source: AGHT+IGNXY3i+FkcN4+0E6sb8vV5qlhvrzKI0eFOmCcYWLdRzRhWMrQ9qyPJs+PKngvyd4yPLeMdJA==
X-Received: by 2002:a2e:9187:0:b0:2ea:853f:18e4 with SMTP id 38308e7fff4ca-2eac7a11f96mr1893901fa.13.1717534806839;
        Tue, 04 Jun 2024 14:00:06 -0700 (PDT)
Received: from ?IPv6:2804:5078:851:4000:58f2:fc97:371f:2? ([2804:5078:851:4000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c354e744a0sm7435493a12.30.2024.06.04.14.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:00:06 -0700 (PDT)
Message-ID: <d98580bc15fd358a1bdfdbc95b94ca02f97324bc.camel@suse.com>
Subject: Re: [PATCH v3] selftests: livepatch: Test atomic replace against
 multiple modules
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Shuah Khan
 <shuah@kernel.org>,  live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 04 Jun 2024 17:59:48 -0300
In-Reply-To: <Zl9YoIAy+1bEnHCB@redhat.com>
References: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>
	 <Zl9YoIAy+1bEnHCB@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 14:10 -0400, Joe Lawrence wrote:
> On Mon, Jun 03, 2024 at 02:26:19PM -0300, Marcos Paulo de Souza
> wrote:
> > Adapt the current test-livepatch.sh script to account the number of
> > applied livepatches and ensure that an atomic replace livepatch
> > disables
> > all previously applied livepatches.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > Changes since v2:
> > * Used variables to stop the name of other livepatches applied to
> > test
> > =C2=A0 the atomic replace. (Joe)
> >=20
> > Changes since v1:
> > * Added checks in the existing test-livepatch.sh instead of
> > creating a
> > =C2=A0 new test file. (Joe)
> > * Fixed issues reported by ShellCheck (Joe)
> > ---
> > Changes in v3:
> > - EDITME: describe what is new in this series revision.
> > - EDITME: use bulletpoints and terse descriptions.
> > - Link to v2:
> > https://lore.kernel.org/r/20240525-lp-atomic-replace-v2-1-142199bb65a1@=
suse.com
> > ---
> > =C2=A0.../testing/selftests/livepatch/test-livepatch.sh=C2=A0 | 138
> > +++++++++++++--------
> > =C2=A01 file changed, 89 insertions(+), 49 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh
> > b/tools/testing/selftests/livepatch/test-livepatch.sh
> > index e3455a6b1158..ca770b8c62fc 100755
> > --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> > +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> > =C2=A0
> > [ ... snip ... ]
> > =C2=A0
> > =C2=A0# - load a livepatch that modifies the output from /proc/cmdline
> > and
> > =C2=A0#=C2=A0=C2=A0 verify correct behavior
> > -# - load an atomic replace livepatch and verify that only the
> > second is active
> > -# - remove the first livepatch and verify that the atomic replace
> > livepatch
> > -#=C2=A0=C2=A0 is still active
> > +# - load two addtional livepatches and check the number of
> > livepatch modules
>=20
> nit: s/addtional/additional as Miroslav spotted in v2
>=20
> Otherwise LGTM,
>=20
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

Thanks Joe! I forgot to address Miroslav's comment... Petr, would you
fix it locally?

Thanks!

>=20
> --
> Joe
>=20


