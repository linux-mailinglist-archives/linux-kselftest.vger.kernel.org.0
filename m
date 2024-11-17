Return-Path: <linux-kselftest+bounces-22157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D949D05AC
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 21:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CD1282221
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 20:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D15D1DC184;
	Sun, 17 Nov 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N0kI4HPy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC68433A0;
	Sun, 17 Nov 2024 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874317; cv=none; b=oXuTNA5b3AO3X5o6seuOGCiYO7D+drW/dWnK0xYOrJKu5K8WQCTY2JKPT4LP+e+DKKBSiqeO3QCK5niFXERqmZsz9Gv/nLvtMBnV7zkEKLaG2K9LyRpxfKdaED4sRtJXrBUSsbEpCrHq4MC/Le61BKTbELMLs9TPLiRuoS75s6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874317; c=relaxed/simple;
	bh=Raxqo+j8JPeAWZhKq2Qzo/SYgzh0KLS8eRBeAlAk8mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMI3uyyTp0zxzOwlpfI58iFihDf9r71CI1gqivg5lcGpiDVENslN0h0VFfrgGQbFzJar3XGAh8HLyp44TCPcajZHnvnXVK/7an5sBw9EEm9mVk0Me0nQH/IH8eFIOQIDvdp6dvvq2D4rZDzy9puCdZkcDzs3slZDO+Jsx0K3F+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=N0kI4HPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6BCC4CECD;
	Sun, 17 Nov 2024 20:11:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N0kI4HPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731874314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mk1KepV+1G2oSCm2lHII/IKroPxppluHk1Hg/th29HU=;
	b=N0kI4HPyjRi9MTFgCoV8f2hEATaQAdMfU4z9VD9EjgKLiuVKxbuA+3kwL5RjyKwjUwkCWX
	E1aGDUkeqfvMsqZRVjSNjeZOshgio9jshvzhQunOHz7xvuXWnXZwCIU5qsNUADvVnb6qt0
	UTQ0zIjspBHYAv5wbwX/L8QNMOXu+dQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8ec7c31f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 17 Nov 2024 20:11:53 +0000 (UTC)
Date: Sun, 17 Nov 2024 21:11:52 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] selftests: wireguard: load nf_conntrack if it's
 not present
Message-ID: <ZzpOCCKaRNTfCftr@zx2c4.com>
References: <20241112094828.391002-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112094828.391002-1-liuhangbin@gmail.com>

On Tue, Nov 12, 2024 at 09:48:27AM +0000, Hangbin Liu wrote:
> Some distros may not load nf_conntrack by default, which will cause
> subsequent nf_conntrack settings to fail. Let's load this module if it's
> not loaded by default.
> 
> Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Applied, thanks.

