Return-Path: <linux-kselftest+bounces-21341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB799BA14E
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D21282090
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092F51A2557;
	Sat,  2 Nov 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="ZCnNZl+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from qs51p00im-qukt01071901.me.com (qs51p00im-qukt01071901.me.com [17.57.155.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C02189BAD
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Nov 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730563128; cv=none; b=TOdZ9PS71SubGZdVGdZFGzQFzybtLeiKTMNNPBRJV6HkGRj1MWP60/u1PYNLufKA1Obo5EiukkN/0RviWM08a2YVRDuwzuonkbuCIAu012UrlCvee+LP5gkoNPSIIVnxhM2o8nD3GVwKW88BpdwxZx+p3E4bv6B9UMjqRqVSGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730563128; c=relaxed/simple;
	bh=8ZCIjqe6nbbqsWqN3Vcpxe64gjYHyzF400J/Pb64xNM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mNjEtv2x2252iL1OltGmAOSfV6NVkwWTGG3EvClxAldoO1bAkPK1fNCsUxY4xEw4PKbLZPxxDEHLj+PEW+7zrrW/qpAWvX3FIPBmoYJ7wle9E0JWDYwAL/8+CM/89CH6VT+VsSKIwm8Ekk4Bpkhj3vEU+nWurhBGRaTbI0Mb/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=ZCnNZl+E; arc=none smtp.client-ip=17.57.155.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1;
	t=1730563124; bh=dAlXGCff2WQWMMo4l+7vl5vNILyFo+zASwJ92FaKpGc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 x-icloud-hme;
	b=ZCnNZl+EQahElN4bOzUbvSJ0tMxXtcXDEBBxtsnUY3DNgKAPFZcCvKewXWEIzW/UK
	 nieMnjztjGtzYbiTO1LADcx/f8Dw5Fc8JZURkvsVtPSeLGP58UyLMoBbtTUM89iapl
	 OqvJYBmLFF+MyC7+pfTVNYCQ6sbQ+DtGKMVBrwRGZCfICQ0+mDXRjnLgupF1Mwpi9t
	 NQnAXQ9jEbxQPx7epPyL5IvUWUpQh7Bk0PtelFtu/9hhhbvG8ue1H8e7guVWf+9ppj
	 CzKNJONBHAgHHE5OR8ekgNGse9ar6U1PtwQsg5u0yql4+l7OdL9nzzpm8he9G1RZ5E
	 zSL9C2DbB3mQQ==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071901.me.com (Postfix) with ESMTPSA id 53C4D628000C;
	Sat,  2 Nov 2024 15:58:42 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 18:58:39 +0300
Message-Id: <D5BTFE1AXSVK.2YNEV7RO2T5IT@verdict.gg>
From: "Vladimir Vdovin" <deliran@verdict.gg>
To: "Paolo Abeni" <pabeni@redhat.com>, "Jakub Kicinski" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <dsahern@kernel.org>, <davem@davemloft.net>,
 <idosch@idosch.org>, <edumazet@google.com>,
 <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <horms@kernel.org>
Subject: Re: [PATCH v5] net: ipv4: Cache pmtu for all packet paths if
 multipath enabled
X-Mailer: aerc 0.18.2
References: <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
 <20241101104922.68956-1-deliran@verdict.gg>
 <20241101064511.1ef698db@kernel.org>
 <D5B0U1C0N9JC.3PXNVEEH12786@verdict.gg>
 <141acc87-19a4-44b5-a222-3f159835c711@redhat.com>
In-Reply-To: <141acc87-19a4-44b5-a222-3f159835c711@redhat.com>
X-Proofpoint-ORIG-GUID: OZfPGOPG-8bvVJjDkRysZ1ZR0LpBklyj
X-Proofpoint-GUID: OZfPGOPG-8bvVJjDkRysZ1ZR0LpBklyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_13,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1030 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=512
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020142

On Sat Nov 2, 2024 at 11:49 AM MSK, Paolo Abeni wrote:
> Hi,
>
> On 11/1/24 18:34, Vladimir Vdovin wrote:
> > On Fri Nov 1, 2024 at 4:45 PM MSK, Jakub Kicinski wrote:
> >> On Fri,  1 Nov 2024 10:48:57 +0000 Vladimir Vdovin wrote:
> >>> +	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions		0"
> >>
> >> This new test seems to fail in our CI:
> >>
> >> # TEST: ipv4: PMTU multipath nh exceptions                            =
[FAIL]
> >> #   there are not enough cached exceptions
> >>
> >> https://netdev-3.bots.linux.dev/vmksft-net/results/840861/3-pmtu-sh/st=
dout
> >=20
> > Yes it failed in V4 patch, in this V5 its already ok:
> >=20
> > # TEST: ipv4: PMTU multipath nh exceptions                            [=
 OK ]
> > ok 1 selftests: net: pmtu.sh
> >=20
> > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/841042/2-pmtu-sh=
/stdout
> >=20
> > But in V5, there is failed test, not sure that this patch causes fail:
> > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/841042/31-busy-p=
oll-test-sh/stdout
> >=20
> >>
> >> Also some process notes:
> >>  - please don't post multiple versions of the patch a day:
> >>    https://www.kernel.org/doc/html/next/process/maintainer-netdev.html=
#tl-dr
> >>  - please avoid posting new versions in-reply-to the old one
> > Thanks, will keep it in mind next time, sorry for my ignorance
>
> Some additional notes:
>
> - please do answer to Ido's question: what about ipv6?
> - move the changelog after the SoB tag and a '---' separator, so that it
> will not be included into the git commit message
> - post new revisions of the patch in a different thread
>
> Thanks,
>
> Paolo

Thanks for your comments,=20
I will resend patch with fixed commit message as new thread.


