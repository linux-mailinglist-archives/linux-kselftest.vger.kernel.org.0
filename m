Return-Path: <linux-kselftest+bounces-13027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECEC91ED4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 05:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B190286B2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 03:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D6D2030B;
	Tue,  2 Jul 2024 03:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5TwHVY5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5A288A4;
	Tue,  2 Jul 2024 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889389; cv=none; b=mM6p5Wyw513Y8pnfQJrPypIOZA2zIz46NJMZB7FCHWuTt7Sh2hHxsl1LA3MlOCwzi+pdkivZsH3UY49VmZzheV8vhkU/lGuBUAtF/RSjgI9K0bMTnxYOS0GvTFJvXvKuZY2RCMX8omZ/GIeVNpBEIdu1k1oWJ/IyjxuqS5qJW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889389; c=relaxed/simple;
	bh=Mst3gO62KAP9YjVa3vTLzVXE7I0SlzT0bNqTqL4l9zU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LT+O1QjAl2vHTUWoBJXvffddCYqxAJRVrT2RFabIZzpWixUrhbeqwoVd1eX94yi0L7g4Mr8IpTEe5/gBdZYeUQak5nvLw95pH9l/nOspr/wYpvN7rK/iK/oZexjQ+IDyw8znAg+7kwV4x+8/VRKGOXr15LtSLnXw6vNzkBWhNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5TwHVY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D76BC116B1;
	Tue,  2 Jul 2024 03:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719889388;
	bh=Mst3gO62KAP9YjVa3vTLzVXE7I0SlzT0bNqTqL4l9zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5TwHVY5HTqK/mNXkW/uj/CP1tRkMf9iFRErq0Xo9PNBpDYvN4V5Mgw2I//JwomBN
	 y+e7mlV6VaIK+TkJWNZ3TaMM96OiFDTerg4DZR/hzmChQTpWUf/jXMuaT9SEkxH1K2
	 6BV9IrO/tOqv/maFN+3vd2+DEqRkYGoNk1F1VScK2v067DVuAXuwpumSMp+7j04ocT
	 Ux0OeLDjZKc/Dze8W1Ujtb2DwULbfqV8MxYOFAp8yd5B0r7zCeE1cvnzLYG+LqTRZN
	 KLw0PuunMjKT58MoSXRzRfzmr61HvqsJiPDX+bRjS62z6lq32i2FHTvlyXG+9aiVJ8
	 1jk7nBa114fug==
Date: Mon, 1 Jul 2024 20:03:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: epoll_busy_poll: remove unnecessary
 assignment in TEST_F(epoll_busy_poll, test_get_params)
Message-ID: <20240701200307.6fbcbacc@kernel.org>
In-Reply-To: <20240701113251.6630-1-liujing@cmss.chinamobile.com>
References: <20240701113251.6630-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jul 2024 19:32:51 +0800 Liu Jing wrote:
> In the TEST_F(epoll_busy_poll, test_get_params), the initialized value of 'ret' is unused,
> because it will be assigned by the ioctl.thus remove it.

I don't think this is worth the noise, please don't send such changes
to networking.

