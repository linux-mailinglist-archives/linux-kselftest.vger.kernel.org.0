Return-Path: <linux-kselftest+bounces-22156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471C69D05A5
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 21:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CEB1F21B4B
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D1C1DB52D;
	Sun, 17 Nov 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G3gnCfZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CE433A0;
	Sun, 17 Nov 2024 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874146; cv=none; b=XfrfRlz391x2VliRsOlnTI8gEcs4pmQwEMiRlGio+dw7duYrM0UwkS/Te1FHOzbph9M/gQSjOVe1FAflYCVmyO8z7EBrd1jZTIMzpkydlXHU15Y4r1OYFEI+oioewmtuvoQXL6MoakxLLhUGwe35uD0r6zuzeXKBhBXWwxEov4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874146; c=relaxed/simple;
	bh=N+F5tcrApWLaSp/pnLw0Tj0+q7xf2t4tiaNSflFzdP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0AgLQU39Zteo57OrO/nsfGggQ/0NNbb8u3ZTZiyACdTOW9gVYCzWEYNnod/0fgVKZJe6N6ZSA2C7zQLt9L6XcNxdUjYQf/DO3sSDBT9G0PsuAebW7V78dSKIRd7zPqL8i8MX+v9ZOhXz133/tcqGDwy6CuJg0fUEbbH7K4Fesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=G3gnCfZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92668C4CECD;
	Sun, 17 Nov 2024 20:09:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G3gnCfZd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731874143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5sw0h/dqgM08uFeUSgZnIFoY4ccd5OOzMdaWfA9G/Pg=;
	b=G3gnCfZdz1VKqYPylbwF7EEntLMlnS6x7yLBnqeXCjMb6JxDg2+3ep8qsrGYtOBQAX6T+r
	7VAJY+ynhfBhggpBHI8YgQXvwYTmlFQOKCs6L08cc27396MufFCQLU+dU3bq7KTzRaTSr1
	fEciguDpl6BXdhvaOO3GyzPH9rFvKT0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5177d8e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 17 Nov 2024 20:09:02 +0000 (UTC)
Date: Sun, 17 Nov 2024 21:09:00 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	wireguard@lists.zx2c4.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net-next] selftests: wireguards: use nft by default
Message-ID: <ZzpNXM17NX3nVzMl@zx2c4.com>
References: <20241111041902.25814-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241111041902.25814-1-liuhangbin@gmail.com>

On Mon, Nov 11, 2024 at 04:19:02AM +0000, Hangbin Liu wrote:
> Use nft by default if it's supported, as nft is the replacement for iptables,
> which is used by default in some releases. Additionally, iptables is dropped
> in some releases.
 
Rather than having this optionality, I'd rather just do everything in
one way or the other. So if you're adamant that we need to use nft, just
convert the whole thing. And then subsequently, make sure that the qemu
test harness supports it. That should probably be a series.

Jason

