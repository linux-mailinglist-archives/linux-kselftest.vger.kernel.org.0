Return-Path: <linux-kselftest+bounces-48300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B49CF8A90
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 15:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 414763044B91
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF42346FA4;
	Tue,  6 Jan 2026 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fmt/StmZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653A346FA0;
	Tue,  6 Jan 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707667; cv=none; b=PGxBVPdH0Z0MNZCMUrfUKt8W0hV9CfZ3Uv7bCDWlu6VujtX6bRmHhU+zEKw/ThCxX20+ozGqT9ndGoGLeOkobA/btmJBUQYgGHh6uH+ys533o6YP2WDVqXRPCyInqylJYs7w0HjSPhyHt82z29ScnNbutXZZZaEqVkI+4/Zhe7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707667; c=relaxed/simple;
	bh=7c0mUuNG2wSgyg9E9Bzh/8JnffEnQp+qh2iBn7T+okM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dMW4bsZzt/kfZXxfXQMSn+xlWIXAK1qJClp/P4rozq/99WDWmRy7wz3TftkquS5MH75JFb5lm1Dfi47tZqZm9MTsVYDpiQDoL+sa8cXXiwxgo6a2vF1QyncMQISJJc+5/29WEV4S5xrEaPNfGYm7xzvrVxAlC+zJ36H9Y18EVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fmt/StmZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0cb5a1103b1bac18fb0b35c6a5d4fd2ac537dddc.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767707653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7c0mUuNG2wSgyg9E9Bzh/8JnffEnQp+qh2iBn7T+okM=;
	b=fmt/StmZ0JLVFvTPU8yHfzpw/OzzQQ3Im0y655Al0L015XKS+Dbix3jVmEXBRsa8GYSFiJ
	jNQ1V/tn9e9X7U5iCcrkimhl/5VLRNkWmyKaukJBaL8sQOV5mDlCb1dJSlQt2r3DEu9UH7
	ZTy9TkFJ2Dxab6H3Zk0OgnOXUyLcM2s=
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Fix user-memory-access
 vulnerability for LIVE_FRAMES
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, 
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev,  eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev,  john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com,  jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,  pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, shuah@kernel.org,  aleksander.lobakin@intel.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Dongliang Mu <dzm91@hust.edu.cn>
Date: Tue, 06 Jan 2026 21:53:57 +0800
In-Reply-To: <87ms2s57sp.fsf@toke.dk>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
	 <20260104162350.347403-1-kafai.wan@linux.dev>
	 <20260104162350.347403-2-kafai.wan@linux.dev> <87y0mc5obp.fsf@toke.dk>
	 <38dd70d77f8207395206564063b0a1a07dd1c6e7.camel@linux.dev>
	 <87ms2s57sp.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Mon, 2026-01-05 at 17:43 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> KaFai Wan <kafai.wan@linux.dev> writes:
>=20
> > On Mon, 2026-01-05 at 11:46 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wro=
te:
> > > KaFai Wan <kafai.wan@linux.dev> writes:
> > >=20
> > > > This fix reverts to the original version and ensures data_hard_star=
t
> > > > correctly points to the xdp_frame structure, eliminating the securi=
ty
> > > > risk.
> > >=20
> > > This is wrong. We should just be checking the meta_len on input to
> > > account for the size of xdp_frame. I'll send a patch.
> >=20
> > Current version the actual limit of the max input meta_len for live fra=
mes is=20
> > XDP_PACKET_HEADROOM - sizeof(struct xdp_frame), not
> > XDP_PACKET_HEADROOM.
>=20
> By "current version", you mean the patch I sent[0], right?
>=20
> If so, that was deliberate: the stack limits the maximum data_meta size
> to XDP_PACKET_HEADROOM - sizeof(struct xdp_frame), so there's no reason
> not to do the same for bpf_prog_run(). And some chance that diverging
> here will end up surfacing other bugs down the line.
>=20
Oh, I see. Thank you for your explanation.
> -Toke
>=20
> [0] https://lore.kernel.org/r/20260105114747.1358750-1-toke@redhat.com
>=20

--=20
Thanks,
KaFai

