Return-Path: <linux-kselftest+bounces-49177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4FD338D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37F5B3097C33
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE1394472;
	Fri, 16 Jan 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHMRLvhP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB633D6E6;
	Fri, 16 Jan 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581713; cv=none; b=TgO1BRtBajJhlrezKy9USz31+Wv9lLF35LBsv4vW2e0NNzyyrSJheLGL7mSd5Ro0FGeXvkHb8U66WSm03iAPlCnBt8TimefWNhK2aaRIXRY/zeEwv55Ygv4Az8Tfk5zTu8w8BXS16UZgMgX5mMj0BLkcGy3dYYJOt7Arf50eaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581713; c=relaxed/simple;
	bh=UUqsgyZascW9bL55SH5mw94V3XSsw2UiZr6S63xzoYA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=lITu3Fw2DJsvX/7sxAmZL0gBw7fJDMMTUL7obDTTZK8pl6KGCA8y16IUXIU1T/E3Y3ilPj3x3PRWdO/A15NkVBXtBUdYUiyPZF4v3I7/vk6AvE7UelzghAoMqmfUF/LZwZqMC0SHtPoPhN0LxgKtZFs4+YZItvRr9QuyTKLSecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHMRLvhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F39BC116C6;
	Fri, 16 Jan 2026 16:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768581712;
	bh=UUqsgyZascW9bL55SH5mw94V3XSsw2UiZr6S63xzoYA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=XHMRLvhPQj36KWKO5o1RPd/7s2L9jUMDDoaR1A2L7wgHeWqlYEizLi1AkhWkbjaGQ
	 +BNVwgTm4ffeTtpP4nLGkTQCB6ltcNySeT9eAmZNMjUEK3xq2Bfq2vsjzOPIfRO1Gu
	 F4aICMFfXTt4Nf1cNBlg1Ob4O667jWcaDFoEFr+/0bk8Tz14W9Tpb+xXo0LGOQJccQ
	 VLRWeguQFSi+1zhiWeLpYLJwZkzJBHTYstgrM4BGWcSeStpqw+zMTAXsmY4rjoisja
	 WFJeW1TeECHBgbTSFnpooblKQy6Y/ZO7O+63gXueNIvKjTvgkmKMGEMb1AxfWpLPOV
	 Xsq+pGGjhi4dA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 17:41:47 +0100
Message-Id: <DFQ5W41X6Z7S.3V6FRPXYMDJ1F@kernel.org>
Subject: Re: [PATCH v7 1/3] revocable: Revocable resource management
Cc: "Bartosz Golaszewski" <brgl@kernel.org>, "Tzung-Bi Shih"
 <tzungbi@kernel.org>, "Benson Leung" <bleung@chromium.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Linus Walleij" <linusw@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Dan Williams" <dan.j.williams@intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, <linux-gpio@vger.kernel.org>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260116080235.350305-1-tzungbi@kernel.org>
 <20260116080235.350305-2-tzungbi@kernel.org>
 <DFQ45FWO4XHC.2BW7I9LGC76WT@kernel.org>
 <CAMRc=Medaqr5UPimc8o+VTy=9MgU5p8AXjArisQfBNqi7ktSGg@mail.gmail.com>
 <20260116160424.GA14499@pendragon.ideasonboard.com>
In-Reply-To: <20260116160424.GA14499@pendragon.ideasonboard.com>

On Fri Jan 16, 2026 at 5:04 PM CET, Laurent Pinchart wrote:
> Based on the discussions we had at LPC, the revocable resource management=
 API
> is not the right solution to handle races between device removal and user=
space
> access.

Please see: https://lore.kernel.org/all/DFQ5D44A0348.PZJIGPL972N@kernel.org=
/

> It is however a possibly useful tool for races between producers and cons=
umers
> *inside the kernel*.

Do you have an example for such a case?

