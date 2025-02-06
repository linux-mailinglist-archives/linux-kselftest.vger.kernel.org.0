Return-Path: <linux-kselftest+bounces-25935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD48A2AD3A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 17:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD9B3A7A65
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3371624C8;
	Thu,  6 Feb 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se9jQO6D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D41F416F;
	Thu,  6 Feb 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857845; cv=none; b=p5cwcaujRvQVQ4ctGTt3evpI7GlelDZTlTAslVvYqCSXj8nUeVqoQWpSqp7A1gQMUSacG80ip9Iq08lIMb61hcwi9lqHkTyiXvae/4f41bXv/k4K9oj5vVqC5C/3uhbqnXcfFP8abbIfaEIiaEyL8Ecs+aT0CIF/Fm/oMx53mA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857845; c=relaxed/simple;
	bh=hYjs2lETL2frxUQxLg2Ho0iMWUacIPhkm0jHyHYKNN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUfuG361dYL/7MemyNQo2YZwhj1tWuMdcypBNOS7BQorcL2B5jxxVizqz17ueNkIqiKLdzlCMXkrQbL+R4MjRQuHemsxLPoom0xKj7YqqGwLznTyBYKNKHmdI0i4b0qZbNngnDbnKlqe50XXZhD5r3WkRaTMrmkuTTA66GA+MJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se9jQO6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11610C4CEDD;
	Thu,  6 Feb 2025 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738857844;
	bh=hYjs2lETL2frxUQxLg2Ho0iMWUacIPhkm0jHyHYKNN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Se9jQO6DYwhuSMVoKrELwes5WbtFxAu2e3jn2/VldZE0yiJjm2gTK7jRIXFZ3RoUb
	 aNy1s51Eyy+ln+hUrQ55FtG/ETOZISoDi+Jo9kO+THLM4QAkR3dxpUrjgKjKRvMOif
	 7pLG1JhIXXwySTUOoSQxgp48Pa6CLj/6JMGYfvwI5v4IYoc0jwOQfcOskKHXBDoPVh
	 xYqtCkJ7WvMmTpc66RS+0k8N9Wc0TZ6ig37TsVLPu/BOnD5c5KuwMUjLou/zcIKq4W
	 j2tPZZsWGrf/f87pJGJq/hlq6pPyocepVLEKTGFqvi5FMkotkKO3V3B7pVq3JrXnbB
	 hbNBDZKrwjQvQ==
Date: Thu, 6 Feb 2025 16:04:00 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 14/17] net: pktgen: hex32_arg/num_arg error
 out in case no characters are available
Message-ID: <20250206160400.GW554665@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
 <20250205131153.476278-15-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205131153.476278-15-ps.report@gmx.net>

On Wed, Feb 05, 2025 at 02:11:50PM +0100, Peter Seiderer wrote:
> In hex32_arg() and num_arg() error out in case no characters are available
> (maxlen = 0).
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Hi Peter,

This patch and the following could benefit from:

* A more succinct subject
* An explanation of why the change is being made in the patch description

...

