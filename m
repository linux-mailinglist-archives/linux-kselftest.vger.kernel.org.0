Return-Path: <linux-kselftest+bounces-27788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F8AA484CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1177C3B317D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4031AA1E0;
	Thu, 27 Feb 2025 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZAfu6kP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325F14F9F4;
	Thu, 27 Feb 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673221; cv=none; b=lRgHIRzuXhyTsCQRv7Esi77Kmk3vjxrOWUyaPKni8nTkHubVS+mrUZDG+teGzXjRyG2AcfnPi0sDh5HFOoU+lc9v55PdMow6IW6h6PpkbIQ2GsDOuVh9rcIXGjtJFCWCOko4sFoaBMVTFDUo9R3wQ6d95b19oawybzyPfUJFLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673221; c=relaxed/simple;
	bh=DgwvWH5GwoJzRBwoaio+BR7mjvVFocdG/vb2dbwbaVQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=StGlX26BjvslY26EHyMt5EBlln2DmTUzH6W2VFDfsi43s4XLq4lUwnOIVcBodamM5oOjY8/uzmHIdEgTrGxf8DUneSUHVyAI6nMYPY4VRR3uNv38i6YCOdp5bZtCm/D4zdE7jfsxlhWCdrAvwkLlPRLxmTnoeuYxNqst84WcaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZAfu6kP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0a1677aebso98558185a.0;
        Thu, 27 Feb 2025 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740673216; x=1741278016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kud2WTj0tBJQm/quENmNnvzX0zOrrRqm8oCK5LnQrRo=;
        b=EZAfu6kPR/GalouOJYURJ/mTRHuT12fwt5BlYiG20D7ynH9QMvK3wH+kGAYOCFV/FH
         qPIYMD5TL8lqERDHybcCehHYM8Gf7Kk5iNWY1PQgvC8Rj4ssgvhfRSGOGyMHT1IkMHFz
         kmYY6ri+T5yq60Agu7tk05IpbIX570KH8TTOPfjF4LAHYxSAI4BSn8AlnUP5jJZnlgmz
         C1L7c2L0t03p24ClSl06HBn3FQ1Ja4yAK942gfsdAwh87aHqVrk4xNj4HmbYtfElPvv+
         l7cyBV8y+GB+FGSz5OARTKntfUex/MG4QkizSPIewtv23vWMi4ib20fQ/1xP8VLBUZzG
         YdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673216; x=1741278016;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kud2WTj0tBJQm/quENmNnvzX0zOrrRqm8oCK5LnQrRo=;
        b=A001u2KaThibFwbkMzFABLNza2Mp6s3AC0ILJc6JhU69h0aO8GqPULCL3bNMMdQR/R
         0Dkdu0Q3vycsL4BnFeTqbIF1cXFKV82yMquDNtb9G/1xWH5bp5NrJqiVgxK1vQlc2Qnt
         dHhrwYQ5j786BYAKpUVlqx7yBnc+b3X8yDJdgnDtfunWUHnkIebiSlOzFwYOUKDLuVyn
         CLUwk7cabc7yMs2zlVblvUFqw6he9muUWsgfcAyrRqT8lGGPR+JlMFVGxh/S81aolgy2
         9RnlNBhFO5gwe+my96H/x7isqcpdcMKEMP3Q6rdz8kFR0TCLFsAcCz6ngDDdzey6jj0i
         QIUw==
X-Forwarded-Encrypted: i=1; AJvYcCWImDQrh0c2TyebdnPvFB/bqIOKbwMqPaejHvfSTIdm97l4O1J+Dwv9OoTK09IxF9Pg04E40kEt3RQr3xJDI4wU@vger.kernel.org, AJvYcCWQtey8uoQhaN08oq9yGFLTLbPzJkgQ0kT1I/PnKqCcxpuu58q5cExt+PBiiJwayJe25h/CY3IABas4JPA=@vger.kernel.org, AJvYcCXTHh3oENDAeyHwfxOxFL/BRZvAXQJJhjp7UTIOQelJTpGQgWqRjNFEIew9Cq2sQgGUs/GGeDg4@vger.kernel.org
X-Gm-Message-State: AOJu0YzsEBohCxTV3JBjT3eGpzjN/q6QUNs8rK0jdWhXd9tI1HaSTYS0
	2DE2hkGAWVWJfO0zBm1clsLk9SvupjxiqzaaRn02j05hci7lmxIi
X-Gm-Gg: ASbGnctFeVnIAw9iJ3WZQJzWa8gSzvz2GD9F9j2SYG4l0MQCs7UjvMZ7lI00CDo03QZ
	gZ0cD4iF76M60x2Fk45docDOV0/JuWTTLDCx7O2MjISn2XeBK99TaLdUfGymkXp3HQDNOGYG0X8
	ZscAsMm4xQ4e/VtJ6BJZ8gyECjUMtd+I40tQIVlWDH6jBms94gYADVYeaC2dsEnUDOHfqXW+8JE
	8SMH8zrZHbaYTRzlKhq0SYyfrK8YdzdpOW3oJnPcS20/0iuniCAsumzZst7iGOmNx+8QeuS1k+x
	DUUeO7qWJ7BpPm40tgrhn+UQuSRdYZSvHSb/tUKYW7pYoC2ncq3bcV2fLWij7r8Oi4Biz3yIY3Y
	Z8Cs=
X-Google-Smtp-Source: AGHT+IGBGJt+BS/B9DlQEfd0TOQEvOOUThsrHKjQzgxY8ef6swWxy7jzq9cuvtIaZrC+8g5iCm/ksQ==
X-Received: by 2002:a05:6214:5193:b0:6e6:6048:f42c with SMTP id 6a1803df08f44-6e8a0cd3f2emr482526d6.8.1740673216471;
        Thu, 27 Feb 2025 08:20:16 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976534c0sm11395106d6.40.2025.02.27.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:20:16 -0800 (PST)
Date: Thu, 27 Feb 2025 11:20:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kevin Krakauer <krakauer@google.com>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Kevin Krakauer <krakauer@google.com>
Message-ID: <67c090bf9db73_37f929294ec@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250226192725.621969-2-krakauer@google.com>
References: <20250226192725.621969-1-krakauer@google.com>
 <20250226192725.621969-2-krakauer@google.com>
Subject: Re: [PATCH v2 1/3] selftests/net: have `gro.sh -t` return a correct
 exit code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kevin Krakauer wrote:
> Modify gro.sh to return a useful exit code when the -t flag is used. It
> formerly returned 0 no matter what.
> 
> Tested: Ran `gro.sh -t large` and verified that test failures return 1.
> Signed-off-by: Kevin Krakauer <krakauer@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  tools/testing/selftests/net/gro.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
> index 02c21ff4ca81..aabd6e5480b8 100755
> --- a/tools/testing/selftests/net/gro.sh
> +++ b/tools/testing/selftests/net/gro.sh
> @@ -100,5 +100,6 @@ trap cleanup EXIT
>  if [[ "${test}" == "all" ]]; then
>    run_all_tests
>  else
> -  run_test "${proto}" "${test}"
> +  exit_code=$(run_test "${proto}" "${test}")
> +  exit $exit_code
>  fi;

This is due to run_test ending with echo ${exit_code}, which itself
always succeeds. Rather than the actual exit_code of the process it
ran, right?

It looks a bit odd, but this is always how run_all_tests uses
run_test.

