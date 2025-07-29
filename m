Return-Path: <linux-kselftest+bounces-38052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD102B15199
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 18:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F73544000
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C578A2253A4;
	Tue, 29 Jul 2025 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shadowice.org header.i=@shadowice.org header.b="SmEVtYeY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from shadowice.org (shadowice.org [95.216.8.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ADF33993;
	Tue, 29 Jul 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.8.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807559; cv=none; b=sz1uY81cUeVlfYBSxzs/fMXqUQrXv0O5jptPRjzx1013ZZnudF3jGq3xUIZ3ix6DG0reVaMkqVBwwz0s/jzQ1f3bSFvxWrr6QoaYB1Fbp20NNr4fLDzZb5QxGkvFqfBt2idcpf8/VKoprwDrftTIqD5huA80KYIPFqRDoiZtIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807559; c=relaxed/simple;
	bh=pVF1vswbbxePK12gpYAzIN0tf9oD1WO9AGE7jn/ow1o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VI1+wROLsu4SnH1zpuZq7OrxFzJiEjL/ovCK1jRNmUhISRm3IBJmHgjC6liaybDmtdmtyKTSmd1ru8jg1ou6DbaEthlRlu3F//2Fsctec7SnME/5GRThVnQ7LfEjYSnJipoko34McuxzZssAT46QpPnj6xECcC1z4E/seUcAFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shadowice.org; spf=pass smtp.mailfrom=shadowice.org; dkim=pass (1024-bit key) header.d=shadowice.org header.i=@shadowice.org header.b=SmEVtYeY; arc=none smtp.client-ip=95.216.8.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shadowice.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shadowice.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=pVF1vswbbxeP
	K12gpYAzIN0tf9oD1WO9AGE7jn/ow1o=; h=in-reply-to:references:to:from:
	subject:cc:date; d=shadowice.org; b=SmEVtYeYg7yuSdJNqbZjzzM0rZ/EKpiLiy
	hLIKDWtSoqXDMEd0cLvjakg19yr4v3jC3LFHiRs0hZimAe22B2AjcTsg+Y5Yzo49cGCCcm
	5T3YAaivjr+nLmw6vu5BDkIEZAMo6hpb5Tv1X9Js7mQ1Jy1Bf0RDmCw57BBUag5XEqg=
Received: from localhost (p4fc618b5.dip0.t-ipconnect.de [79.198.24.181])
	by shadowice.org (OpenSMTPD) with ESMTPSA id 49603c6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 29 Jul 2025 18:45:47 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 18:45:46 +0200
Message-Id: <DBOOW06CYM2U.11R0PDE4QNQK9@shadowice.org>
Cc: "Andy Lutomirski" <luto@amacapital.net>, "Will Drewry"
 <wad@chromium.org>, "Sargun Dhillon" <sargun@sargun.me>, "Shuah Khan"
 <shuah@kernel.org>, <linux-kernel@vger.kernel.org>, "Ali Polatel"
 <alip@chesswob.org>, <linux-kselftest@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] selftests/seccomp: Add a test for the
 WAIT_KILLABLE_RECV fast reply race
From: "Johannes Nixdorf" <mixi@shadowice.org>
To: "Kees Cook" <kees@kernel.org>, "Johannes Nixdorf" <johannes@nixdorf.dev>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250725-seccomp-races-v2-0-cf8b9d139596@nixdorf.dev>
 <20250725-seccomp-races-v2-2-cf8b9d139596@nixdorf.dev>
 <202507281805.14457D3EAF@keescook>
In-Reply-To: <202507281805.14457D3EAF@keescook>

On Tue Jul 29, 2025 at 3:07 AM CEST, Kees Cook wrote:
> On Fri, Jul 25, 2025 at 06:31:19PM +0200, Johannes Nixdorf wrote:
>> +		struct itimerval timer =3D {
>> +			.it_value =3D { .tv_usec =3D 1000 },
>> +			.it_interval =3D { .tv_usec =3D 1000 },
>> +		};
>
> To get this to build, I needed to add a sys/time.h include:
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testin=
g/selftests/seccomp/seccomp_bpf.c
> index b24d0cbe88b4..fc4910d35342 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -24,6 +24,7 @@
>  #include <linux/filter.h>
>  #include <sys/prctl.h>
>  #include <sys/ptrace.h>
> +#include <sys/time.h>
>  #include <sys/user.h>
>  #include <linux/prctl.h>
>  #include <linux/ptrace.h>
>
> But, with that, yes, I can confirm the race and the fix. Thank you!
> I can fix that up locally.

Sounds good. The change looks correct to me as well.

>
> -Kees

Best regards,
Johannes

