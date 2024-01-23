Return-Path: <linux-kselftest+bounces-3410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5008838FC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 14:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701E21F2A4F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9E15F841;
	Tue, 23 Jan 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeG/bYAW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17ED5F55E
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015872; cv=none; b=aagU1xT47jjx+e33UzFE0QAxDuD/9ORtzSspw0jro17Il5wTXq3oJK1NpdZ7VNXyz93PkgbCmoYojSlf26ZycfceZ7ODF4DoI69Inya4w/u7M/jiMuO1mi9E1aKyBnuzdY7e5V9KvL4hTa6oWCTD9092Fyoehmlt6u2mHrQ57bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015872; c=relaxed/simple;
	bh=jnct+Lzin4gh/Le8F45er7/TXL58Sl7/KC3E0pdohAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXfYyXUtQhE+Dvb0usgTefDdZLZ3BV6pObnI9dm1HuVnMNca2rQZDjsdJDr8cTPy/EJ1zIx5YbXvSriCrEn+xDpfHhF4Dqu0pWycRsegODcYCgEXjK+Jjn83aDxjLP2mCw7CQKRoRW3lVto32rP9s+hCh6riqOBqPEpdeR3/QDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeG/bYAW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706015869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBJWnNPWK6FEDvgCqnbrqrUFcx4g4CvzlBj7l9Q5CZo=;
	b=UeG/bYAWgURJf7Z9wjnwRJ5BQ/yBMSAVZcuZsmj38CdE2E9/LvTjH7WFV0UKiAGUfP2hyF
	aEhibpVkF1aMvlWy29B5zqY6NSX8BHkBnYs4ciTVVWuiLg0x9oSUXuo0d1Wvw7+MeWg6uq
	Qu/UC2G9V3Wu2w6BCWRrum1BeWenHcs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-jbVjFUCDM2ObrOIikzR3fw-1; Tue, 23 Jan 2024 08:17:48 -0500
X-MC-Unique: jbVjFUCDM2ObrOIikzR3fw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5100a0f0c55so398342e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 05:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706015866; x=1706620666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBJWnNPWK6FEDvgCqnbrqrUFcx4g4CvzlBj7l9Q5CZo=;
        b=kYLiKS6ekvkCbwvEQYc3f7F7ypZ+PuV0k4CiwqUjq7zaYGex4zwmf8vt2NfYR/RY+Y
         D1RAyTaLpD3Y6ccndVgTC5D4Us849v0fRPxoSa18Ylk1m72JeC3dnYwPNcODgWMfr3Ut
         xZEai/xuNBzTtnnE+bXNq46mDyOetL+6m8M0ZRumdjfjfeDTHKAoDnv6RVSsL4CTqlEx
         WWuS1bf8PnQ/AL5SDqfhyHy/Kjeao0Pbj+okiPjn7ZN6b4VQuebVUdgvdHYSFvRcO5+L
         K+uZSSfQL4wOkTKTmeBl5lynVjuacHVHrzi08tDrdaC7GA0KPhgYwJB00FpyJivhxBJd
         8aUg==
X-Gm-Message-State: AOJu0YxB49q7tsMUxllTGz5pq6BjXIcTpsVScOmIQXctQF8uGiB7s1Pb
	qhjm154sMcARVZRh5PgqbbWirX74HYwwmbfxoSwqhjaulnbbbl2rSwcm05UMNbBP9KyDAgKKyqv
	WibfykPc6e3Rh9CKE1bMGsCEP4mExgTA9ALqKepsoI1KXADXpLoRc3kEwz0kjM35SBHFem8lp7V
	kLH/wTUDSO9sRQnkntdlhV+O1wj+JdY5euG6cHBY5y
X-Received: by 2002:a05:6512:3b84:b0:50e:6168:c99d with SMTP id g4-20020a0565123b8400b0050e6168c99dmr2912640lfv.27.1706015866526;
        Tue, 23 Jan 2024 05:17:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7bPWvAk9q+1bk1V2Hwy2Rx2s8Ht69Kfn6jl0Hd/iIWEVFa6+7r5fF4lK4xsfj0+ptN1K/qJVhi/WY/v9H5+I=
X-Received: by 2002:a05:6512:3b84:b0:50e:6168:c99d with SMTP id
 g4-20020a0565123b8400b0050e6168c99dmr2912627lfv.27.1706015866249; Tue, 23 Jan
 2024 05:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123122736.9915-1-pctammela@mojatatu.com> <20240123122736.9915-3-pctammela@mojatatu.com>
In-Reply-To: <20240123122736.9915-3-pctammela@mojatatu.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 23 Jan 2024 14:17:34 +0100
Message-ID: <CAKa-r6s_DO1tfcZdsQNBCwjbE0ytJKnZWnvcKqTR+5epdNq4YQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] selftests: tc-testing: check if 'jq' is
 available in taprio script
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, shuah@kernel.org, kuba@kernel.org, vladimir.oltean@nxp.com, 
	edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi Pedro,

On Tue, Jan 23, 2024 at 1:28=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> If 'jq' is not available the taprio tests that use this script will
> run forever. Check if it exists before entering the while loop.
>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  .../selftests/tc-testing/scripts/taprio_wait_for_admin.sh    | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_a=
dmin.sh b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.=
sh
> index f5335e8ad6b4..68f2c6eaa802 100755
> --- a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
> +++ b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
> @@ -3,6 +3,11 @@
>  TC=3D"$1"; shift
>  ETH=3D"$1"; shift
>
> +if ! command -v jq &> /dev/null; then
> +    echo "Please install jq"
> +    exit 1
> +fi
> +

nit: what about returning $KSFT_SKIP (that is 4) if jq is not there?
so the test does not fail.
thanks!
--=20
davide


