Return-Path: <linux-kselftest+bounces-25040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC6BA1ABE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EEA7A41FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82B1C5D42;
	Thu, 23 Jan 2025 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma4Qyk7m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6316EC19;
	Thu, 23 Jan 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737667847; cv=none; b=ZnX9GkpbjeUSrEKVabfrpIcbqMe+6S5Xii9Hf8/V5Uq4Msv7VnHW0NDp7lTOs+0nYCZRhsMZ/PP1TpVUWBxdg0Hn9zIGcONFi1k1SvKAq4xCLVVMAtEiIesBOLkl66RTiuuq5F3492VmPywGqc/wXF25SIKuVBHt4YLzZRFYKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737667847; c=relaxed/simple;
	bh=929SbkPZ1rHZGzLzkzfyL8bQgeP/Kh91Wpz1dFourKM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oqAR+PCfHk4zc2e7BOX1aanWJpl2VV9zpLcPNG4/snA2RdK1Lg3CSqCNJEMNEN4zbF7Er+kq5oZ03vDpvswq/86T6f+kDc5t4PHKdBxRgOE+QUUwyYJy1oGzvf+xuxraUqZUXRzvpY65yUaKMRslTDSG7quIoDR83HJIQwcvBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma4Qyk7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D00C4CED3;
	Thu, 23 Jan 2025 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737667846;
	bh=929SbkPZ1rHZGzLzkzfyL8bQgeP/Kh91Wpz1dFourKM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ma4Qyk7mEhcwihmS3b+DFhOCXJEno6SD0X4g8jNX14SQHHum/jftVXnUCHAxXyJtj
	 9SCAboLAP8ky3xalfX1MbyKuArL+iM3esKuGwRSrPAj1qCmgkCadWn5cTMndCiG/N1
	 RomQpgO5gpQOVLLUNtM5AIFSKhHWhrOUwVYrG4aVlhwu4lRAOVQDuNhTw84HqZTrQS
	 s68Ut3F0dPYC5upgmdHekKp+ta38/e+bzO7J+CV3WCyD1RlM1k21fS5czBOV6e3IEu
	 UdqLHrUXpiwCWTFe33OduOL4KpBZ9aBUrqPmvzthFGqUnxzooQoE8UIgTWiFdIHwf0
	 lRL//4PJcktsA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 23:30:40 +0200
Message-Id: <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
Cc: <linuxtv-ci@linuxtv.org>, <dave.pigott@collabora.com>,
 <mripard@kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
 <gustavo.padovan@collabora.com>, <pawiecz@collabora.com>,
 <spbnick@gmail.com>, <tales.aparecida@gmail.com>,
 <workflows@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <kunit-dev@googlegroups.com>, <nfraprado@collabora.com>,
 <davidgow@google.com>, <cocci@inria.fr>, <Julia.Lawall@inria.fr>,
 <laura.nao@collabora.com>, <kernel@collabora.com>,
 <torvalds@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
 <daniels@collabora.com>, <helen.koike@collabora.com>,
 <shreeya.patel@collabora.com>, <denys.f@collabora.com>,
 <nicolas.dufresne@collabora.com>, <louis.chauvet@bootlin.com>,
 <hamohammed.sa@gmail.com>, <melissa.srw@gmail.com>, <simona@ffwll.ch>,
 <airlied@gmail.com>, <Tim.Bird@sony.com>,
 <laurent.pinchart@ideasonboard.com>, <broonie@kernel.org>,
 <leobras.c@gmail.com>, <groeck@google.com>, <rdunlap@infradead.org>,
 <geert@linux-m68k.org>, <michel.daenzer@mailbox.org>, <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Vignesh Raman" <vignesh.raman@collabora.com>,
 <kernelci@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
In-Reply-To: <20250123135342.1468787-1-vignesh.raman@collabora.com>

On Thu Jan 23, 2025 at 3:53 PM EET, Vignesh Raman wrote:
> We are working towards creating a generic, upstream GitLab-CI pipeline
> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipelin=
e
> is designed with a distributed infrastructure model, making it possible
> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> integration.

Why can't you keep the next version of your great pipeline outside the
kernel tree?

If there is a legit motivation for doing that, why it needs to be bound
to Gitlab? Why can't you make script callable from any CI?

BR, Jarkko

