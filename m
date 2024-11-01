Return-Path: <linux-kselftest+bounces-21310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA66D9B969B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 18:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7CC2828BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80B1CC8AF;
	Fri,  1 Nov 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="MUCgY3jU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from qs51p00im-qukt01072701.me.com (qs51p00im-qukt01072701.me.com [17.57.155.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928081CB321
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482465; cv=none; b=G2RBLLsVVQQBwti4uuJ7wzaL7rpwHO/kMRcVnpw/q17sp5fTKViMZ8S2AlGSaiRP7ipKgEml8EWCgsI3f7DgoR4GqQVzs2siTWKSEWSM0eTeIphYXLA37YpYHok7puF9pEcAFKtSGU2gNNv6VX0vvarfbRQRTPPOPBd09CPWPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482465; c=relaxed/simple;
	bh=yWxSY6lpq9y436+CBlx7pOJWYkE1IZeB7U9qpm5zK2s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X+KW8dzcjqydfzTbbfUEqdxcDwfNP/NDxZe4YQiF/xi/VWHNkpF1/ZnQUCKrJ5HnY00aogWRdFVuiqBw0PzJEMlRWAeJlrsGQ5taE9BtI9ZnZpIb5staEW1G0wpU+aIOA/6ebX4lO7E6LkYZr+cgVWB4XgpK0AFVUriikzr/0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=MUCgY3jU; arc=none smtp.client-ip=17.57.155.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1;
	t=1730482461; bh=o0PyLD589lYfc1t+zExAXE2fviy2AdnQrnho3zTWnfw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 x-icloud-hme;
	b=MUCgY3jU84Vtq9GS2uQ87VcoA5hUhvGkRoI2ROmlHWEGyFNHem6q776LJ/YKv+Czj
	 tCAABVWL92Z6309PUyAZg44NARfF7axlliGPA0Q91GIgJc7uWfj8KxLh+GIxxnUf1e
	 BOKw8wjyAwxCS18xjFI3edfH3+YUpRTGUBTXs80uurgUjoCUPA1HKAANNSfNOccz+8
	 oUbRnWzBKgEz2MIaVHENhXyC72mGRuEwD6DW8Feay1ELgb0KO0Lct++VbOv/NVjlcb
	 D6P+goabyqupEDS8eMcF191eIMZ5J6i08R1T7OU6zyfZXplv5umTgYjJZGPQ1T20a9
	 puX9SLeRoiopA==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072701.me.com (Postfix) with ESMTPSA id 10B8615C062F;
	Fri,  1 Nov 2024 17:34:17 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 20:34:15 +0300
Message-Id: <D5B0U1C0N9JC.3PXNVEEH12786@verdict.gg>
Cc: <netdev@vger.kernel.org>, <dsahern@kernel.org>, <davem@davemloft.net>,
 <idosch@idosch.org>, <edumazet@google.com>,
 <linux-kselftest@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>,
 <horms@kernel.org>
Subject: Re: [PATCH v5] net: ipv4: Cache pmtu for all packet paths if
 multipath enabled
From: "Vladimir Vdovin" <deliran@verdict.gg>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.18.2
References: <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
 <20241101104922.68956-1-deliran@verdict.gg>
 <20241101064511.1ef698db@kernel.org>
In-Reply-To: <20241101064511.1ef698db@kernel.org>
X-Proofpoint-GUID: pWPWANGMcJnZRigdq-1M2A07egqp_Pa8
X-Proofpoint-ORIG-GUID: pWPWANGMcJnZRigdq-1M2A07egqp_Pa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_12,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=238 clxscore=1030 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411010126

On Fri Nov 1, 2024 at 4:45 PM MSK, Jakub Kicinski wrote:
> On Fri,  1 Nov 2024 10:48:57 +0000 Vladimir Vdovin wrote:
> > +	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions		0"
>
> This new test seems to fail in our CI:
>
> # TEST: ipv4: PMTU multipath nh exceptions                            [FA=
IL]
> #   there are not enough cached exceptions
>
> https://netdev-3.bots.linux.dev/vmksft-net/results/840861/3-pmtu-sh/stdou=
t

Yes it failed in V4 patch, in this V5 its already ok:

# TEST: ipv4: PMTU multipath nh exceptions                            [ OK =
]
ok 1 selftests: net: pmtu.sh

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/841042/2-pmtu-sh/std=
out

But in V5, there is failed test, not sure that this patch causes fail:
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/841042/31-busy-poll-=
test-sh/stdout

>
> Also some process notes:
>  - please don't post multiple versions of the patch a day:
>    https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl=
-dr
>  - please avoid posting new versions in-reply-to the old one
Thanks, will keep it in mind next time, sorry for my ignorance

