Return-Path: <linux-kselftest+bounces-3211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F9831DDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 17:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB59B2531B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084312C1BD;
	Thu, 18 Jan 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iua8rT7j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41241E52C;
	Thu, 18 Jan 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596691; cv=none; b=WG/qgc2gCHfIl2KUMKkZjvLSTPfBsGhu3LCQIcApZL7UvL+JiTjVr1cJ3G6/VIhuDzh4lOrFYP69v1UZwVLpIs19SD5orFzerGp3h72tZ4OpcIDf+mWMLPN/sOnCi7/O92g6WanM9/JIbeV3L8HANWPDMyiuImnUvEwgwxD43Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596691; c=relaxed/simple;
	bh=R6FcPnDT92v22HuM2bu0YUkieECXLxrnglbf24UlY9Y=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=IO0Pr5q1WyYtV9+4HLudsa+RZcAKn+mQef9W4kRUKGbFnaNW0/pWeMjorvGnsbnMcEpFT6Ok8Jo4yu+1JwcjCoaDXD/gRj7bOM16IJO/aZBtNWU85O5Qi/rnokmnOAOZbYKSueXo666GDPuIz8coQkb20oihLiqvD2J6utlMEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iua8rT7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D1CC433F1;
	Thu, 18 Jan 2024 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705596691;
	bh=R6FcPnDT92v22HuM2bu0YUkieECXLxrnglbf24UlY9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iua8rT7jUuux10YEw4HUYxD/UHDrjY3bFcCf7QzdmZrUAJmDMy83IIS4AClbfZVYE
	 mEJ12y0SfTsMQtkXJ61i3EdzOF5qSRKbpUAbqWU6Do+pVtQkTnDY9f38CE8k80ohLY
	 CGK4S/dTHa2yRjMXF/ESKU3XHpDzwI1XVtLoCUZovqMGXRCQl95SFivQoiMgNIKoMG
	 0MZRhnNmhPb+IhOqysHLfSEVPyBVY8mlv2B7MfZBZr2Alo/96ZVu+APISN1/bN2O8Q
	 CiG5Zg93329s2Hlog/NfR7go70ZdgrrnyLBAOQVkcvykNrQoI/Jop2pltfa2rwzttU
	 tPINWZYmTAWxQ==
Date: Thu, 18 Jan 2024 08:51:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Mohammad Nassiri
 <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/net: A couple of typos fixes in
 key-management test
Message-ID: <20240118085129.6313054b@kernel.org>
In-Reply-To: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 02:51:33 +0000 Dmitry Safonov wrote:
> Two typo fixes, noticed by Mohammad's review.
> And a fix for an issue that got uncovered.

Somewhat unrelated to these fixes but related to the tcp_ao selftests
in general - could you please also add a config file so that it's
easy to build a minimal kernel for running the tests?

Something like:

  make defconfig
  make kvm_guest.config
  make tools/testing/selftests/net/tcp_ao/config

should give us a suitable config. Differently put it'd be great to have
a config we can pass to vmtest or virtme-ng and run the tests.

