Return-Path: <linux-kselftest+bounces-12706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E79916E29
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A42A1C209C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE21014D2A4;
	Tue, 25 Jun 2024 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9vCHuYf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFF11185;
	Tue, 25 Jun 2024 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333024; cv=none; b=mOZJE3P2e1buvDN4J/Tz042f+vtT4UaGWyzqSAIXTC3SWelZb1qAenXA77DcqnicPSK8Bg+HWp649wWfeZ1QvNL/jcQyFPWaaVpZ2bCZbAPaborc4mJuof/V8H6ykK5Q1y8m6+vfr0rLT3WymmRDImJ3jZQ4m5IEDxnR0+COevM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333024; c=relaxed/simple;
	bh=GopYyPT2mgzQ4xpNM7JtEdBw2TI+wPIejxMM8r5q7dI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMWfF/NO2+Sx7FDRuDCBhK3CradRi2DAiBVWEOgHr+4OCQUl3TqfQky087iwdQMcrXS5kAyC032wKfNm98R+1uVspKMdju1ir/G+Wfl3rO5FXQmjONg2AAfL7zs5fasALgpYK91qfKRcL8Az5bzHznFTT47bHbPNCbw/wCRsgP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9vCHuYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5EDC32781;
	Tue, 25 Jun 2024 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719333024;
	bh=GopYyPT2mgzQ4xpNM7JtEdBw2TI+wPIejxMM8r5q7dI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D9vCHuYfPxeJST3BSYVulRbqHkP2li0PFm/YanDRLgsfesFHqkUciqsn/rgcSAPo3
	 YbAXGFpUa9d0qzwgjX1T2U2iSc4ZCa5Iel3sp1VeUE/alfGa2rdAVsLuF95x93EZ9j
	 BrJeNVwxeEqaj7Ck+yqkxV41ssPiHv+oBkrYAqNVkqgihDG3ia/pLBPDKMjzE8QR81
	 LQSUscQ+I+BvWis6e08ZEjJRTavadTuuZdqsbXrPEqoVVrgm04TZ8b03bNJXfwb1KQ
	 cVLZDARP3Zb2O/eRGEnJz0qbpL8dfIZP9rMIm4aMQMR3Uc8Ltrm8UnJ9ehHuKrw2DH
	 0cNBz+4FEj2iA==
Date: Tue, 25 Jun 2024 09:30:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Shuah
 Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
 =?UTF-8?B?QWRyacOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240625093022.6daf9ba0@kernel.org>
In-Reply-To: <f7tsex1f3wl.fsf@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org>
	<f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
	<e4f69335f90aae3f1daa47ba8f69b24ea15ed3b7.camel@redhat.com>
	<f7th6dhgnvm.fsf@redhat.com>
	<20240625070654.6a00efef@kernel.org>
	<f7t1q4lgldr.fsf@redhat.com>
	<20240625074145.69fc9d9f@kernel.org>
	<f7tsex1f3wl.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 11:17:14 -0400 Aaron Conole wrote:
> > BTW I popped the v2 back into the queue, so the next run (in 20min)
> > will tell us if that's the only thing we were missing =F0=9F=A4=9E=EF=
=B8=8F =20
>=20
> :)  I'll wait to post the v3 then.  So far, the only change I have is:
>=20
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -34,7 +34,7 @@ try:
> =20
>  except ModuleNotFoundError:
>      print("Need to install the python pyroute2 package >=3D 0.6.")
> -    sys.exit(0)
> +    sys.exit(1)

Looks like it didn't get re-ingested :( please go ahead with the v3

