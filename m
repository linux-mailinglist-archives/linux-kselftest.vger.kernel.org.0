Return-Path: <linux-kselftest+bounces-22159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64C19D065F
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 22:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CD52823A5
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80E1DB375;
	Sun, 17 Nov 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oTJ4h7HK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142D84A4E;
	Sun, 17 Nov 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731880004; cv=none; b=B0bqkV0YGPrims13vnV9bAfbj9we0LVnEIPCysA7APr3oKC5RlGfJ+WAKzY4lRXWiKDqcgLvh/koyeb7v3XwuyW3MlKvh48cpu29mXZ0BQrTgNlpP6IMjQ7oyTwpE/vjVG75eum//QwRMyUcXIf3t5gxGOVcgKim0nKOJfez7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731880004; c=relaxed/simple;
	bh=tVbjePvJxAihAr5c+yvxrxecce4aYrZYlaaKG/tupuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uReMKfCoVZ6Zs201QEh3xBMIkUldImPvQLv9wM2G6qz7MTrUBA3Z6d9xFkHRIyW48zflRb/p38O0XfsyIfmonrdqHDfGD9fgAIialhH3kskrauhDmrvnFyHMyaXyIEZaYFF2BaJk48zFGVdjwizTF0mT0X7vtFgKfeXRRvgggJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=oTJ4h7HK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D16C4CECD;
	Sun, 17 Nov 2024 21:46:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oTJ4h7HK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731880000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g34p6sutZbsEQgGncL8Aj9TPilMj0nJj3hqG1gcNwxo=;
	b=oTJ4h7HKsouagIo1IEmrWaqe5IBR09lPV0IxR246g8HstAVayNcqeyRo5D09tXW3LoLibp
	5zS9bMOPOranNBRBWPJok4u7PaAmRs8mx1FOKFWrcrSol+JWrKyOXLMkR5cllwxONd5aOz
	zpWZarC6QcbV+kMRXC+Ne/HPC65mFGc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id aea12104 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 17 Nov 2024 21:46:39 +0000 (UTC)
Date: Sun, 17 Nov 2024 22:46:37 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jordan Rife <jrife@google.com>
Cc: wireguard@lists.zx2c4.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
Message-ID: <ZzpkPWrrb_Z2ZfCq@zx2c4.com>
References: <20240905200551.4099064-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905200551.4099064-1-jrife@google.com>

On Thu, Sep 05, 2024 at 03:05:41PM -0500, Jordan Rife wrote:
> With the current API the only way to remove an allowed IP is to
> completely rebuild the allowed IPs set for a peer using
> WGPEER_F_REPLACE_ALLOWEDIPS. 

Just for posterity, there actually is another way: create a new peer
with a random key, and give the allowed IP you want to remove to that
peer. Moves are atomic. Then destroy that peer.

Not that this is clean or nice or something, and I like your patch. But
in case somebody gets into trouble before this lands, I thought I should
note it on the list.

Jason

