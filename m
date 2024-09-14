Return-Path: <linux-kselftest+bounces-17988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7CF979114
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB75D282A9F
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6526A1CF7B7;
	Sat, 14 Sep 2024 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC6EZITf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352FE1CEE87;
	Sat, 14 Sep 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321111; cv=none; b=QqIyl7R1AN9g8MuAlrY4tAyfTMyDgYzosxOj8V5AYtlWvdiVPrUc3drNsWFizXBizu7Sq/YsIXXqohW6io+Zs5Ytz7DDxTAxxMEzziL1/uNvHwKFo+vWbZoojlfF2q0GOt9gZicfC4hPBLP0YDjXNm2ez17Y8WiFZT1lFnQwMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321111; c=relaxed/simple;
	bh=1YymAszQUKrYqEpjx3Mib9yXvMotNA+i9P6+wOex2ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5yRG6y2o5T/NPlVrP3skDM2NhJsWPB+oXPP5ds8LSR8fxNgiAWWZCA+pOrWLyB2//Xm4NeKrVfZILW2o0Btv6jfa6CQLJARYDA/YmK0KDakO0xas4Rn+FyE11i7orSDDvP0/DIVfOrvqUVvj0h3Or1xHIeOEy96UaQ0QA5giTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC6EZITf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EB2C4CEC4;
	Sat, 14 Sep 2024 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726321110;
	bh=1YymAszQUKrYqEpjx3Mib9yXvMotNA+i9P6+wOex2ng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IC6EZITfk2pk4O1EGsN+gEZZchhozK2IKu3caZ+ZtZ6z7wQrOz9eHWxeXvO8HHnq3
	 yc8/spNygEbEkbPRef+A0lxXUgyJ0cdQckL8iNpJqbDwi0Q3JuCZzReM1ZY5aDTHBx
	 e7aIogQlWFpXgruml/qaaBY7o9Zi7z7ON8WgL/sS4gyZh4ikjI1NEUwnzlr8iW8w6r
	 tJVyClwjUtEd7xH2s+L6yn4DWw0KfgEKt0uu0GQwmpdPyJpaNd4qnRgF3jcTmqOtsD
	 LPh+qEwH4Q/gwqC/QlAsqEn0n3k8ZrISgnxtCBGScG0R6k8elxAjGp3YMEWe42myQ6
	 pV6xR3RjjD9aA==
Date: Sat, 14 Sep 2024 06:38:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, "Alexis =?UTF-8?B?TG90aG9y?=
 =?UTF-8?B?w6k=?= (eBPF Foundation)" <alexis.lothore@bootlin.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
Message-ID: <20240914063828.7bd73c5e@kernel.org>
In-Reply-To: <ZuVWmxoqXFI3qvVI@lore-desk>
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
	<64df8d41-6cfb-45a9-8337-5cc04daedb60@linux.dev>
	<ZuVWmxoqXFI3qvVI@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 11:25:47 +0200 Lorenzo Bianconi wrote:
> On Sep 13, Martin KaFai Lau wrote:
> > test a physical network device that supports a certain XDP features.
> > 
> > iiuc, test_xdp_features.sh only uses the veth and veth will also be the only
> > device tested after moving to prog_tests/xdp_features.c? It is a reasonable
> > addition to test_progs for an end-to-end xdp test by using veth. However,
> > test_progs will not be able to test the physical network device.
> > 
> > Lorenzo, is the xdp_features.c still used for device testing?
> 
> correct, xdp_features.c is intended to test the real xdp features supported by
> the NIC under test (DUT), not just the advertised ones (iirc that was a
> requisite to add xdp kernel feature support). For this reason we need two
> separated processes running on the tester device and on the DUT (they are
> usually two different devices). test_xdp_features.sh was just a simple test
> script used to develop xdp_features.c.
> What about extending xdp_features.c to integrate it in the CI?

No preference but just to raise awareness - drivers/net's NetDrvEpEnv
class provides the setup for running tests with an endpoint.
XDP tests intended for HW would fit there pretty well.

