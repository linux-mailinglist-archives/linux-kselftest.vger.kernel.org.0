Return-Path: <linux-kselftest+bounces-33903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7DFAC5DC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 01:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D997AFBE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A31218AD1;
	Tue, 27 May 2025 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNSOgs0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E172634;
	Tue, 27 May 2025 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748388497; cv=none; b=FlhN2xitXB+gfJaauUoW+dgBgLbrvEYPdfIhYKxWmzrUr48VdlezCkFh2u55ebmeu4Uar7GPW+fZyD+S9QL1lx3WZfokWOGC0fqs+7rc/uG/+R/LRfeChXponQDXgfsbqOvrnUokwHGdsc9n3l3E/TlqWi6VQ7S9WLl40ijSlZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748388497; c=relaxed/simple;
	bh=/tKIbBRB4eqwFsfNPxWxDMJxIv2XgaVy/w9RvaSEf4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GK6yeLOJHxGVKAn/2s9tAVwVYtaQLSASfc6Pi2y/QE8wyfmBcc+hfyOLeu476CTjktFdyS84dRDGghFTPpr6gKmbOaYnfaWK6trWyS3LfPNiMVfpRhDhKOgI983gtcxQA9Ylo0aSxCemXmsgB0/kijVHbK0FxBuau+ezYOfCu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNSOgs0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8BDC4CEE9;
	Tue, 27 May 2025 23:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748388497;
	bh=/tKIbBRB4eqwFsfNPxWxDMJxIv2XgaVy/w9RvaSEf4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rNSOgs0DZT0Du8doPtxLVzrzsv02CWrDt6hanqP1BN8bcl5gRqbZQkx7Wqt+VZKC/
	 tRKu4BEZ2lvp4BD7DO8o8BxZrAYpEyoOVKelNCIdWWxQNAr64tPU/0GQ8k2+FfFqGr
	 MJqgO7k93yAOt6QuaLZJki2y1+zxoWTOxqL+bejw4X/4EQEWosncOe+2epaCp/8mLm
	 k1HEnH/8QabOAXcwLwHiBagKkAuNf3QAifjSL54fy1D+N1Z/Di9ykLyyi2+SWEAuLX
	 Wo/WeJUE1I2bk1X0JnQ9VIeh7UTylgxxyaGCJ8SY1Khe4hkdhvOn/EefD+1RTlW/TG
	 iYUfiYuipdSaA==
Date: Tue, 27 May 2025 16:28:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jiri Pirko
 <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V10 1/6] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20250527162815.7c73d945@kernel.org>
In-Reply-To: <3dddb35c-d3cb-453d-8e60-70f241abd018@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
	<1747766287-950144-2-git-send-email-tariqt@nvidia.com>
	<20250520155301.5217dd81@kernel.org>
	<3dddb35c-d3cb-453d-8e60-70f241abd018@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 25 May 2025 17:57:28 +0300 Carolina Jubran wrote:
> >> +      -
> >> +        name: rate-tc-bw
> >> +        type: u32
> >> +        doc: |
> >> +             Specifies the bandwidth allocation for the Traffic Class=
 as a
> >> +             percentage.
> >> +        checks:
> >> +          min: 0
> >> +          max: 100 =20
> >=20
> > Why in percentage? I don't think any existing param in devlink rate
> > or net shapers is in percentage right? Not according to what i can
> > grok about the uAPI.
> >  =20
>=20
> I thought percentage might fit better here because it lets users clearly=
=20
> set the bandwidth share for each traffic class. While this isn=E2=80=99t =
the=20
> same as tx_weight in devlink-rate, the idea is related since both use=20
> relative values. If there isn=E2=80=99t a strong reason against it, I=E2=
=80=99d like to=20
> keep using percentages here.

The existing APIs use absolute values for b/w limits.
If you want to diverge please provide clear and realistic use cases.=20

