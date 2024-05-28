Return-Path: <linux-kselftest+bounces-10789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2066B8D1F92
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 17:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B717F1F23F48
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882A171E64;
	Tue, 28 May 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dVIFM7DZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0C171E48
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908546; cv=none; b=eqMUF5k8l8s0usvHc9SwgBKAUTuEHPhPdN0tsez2pUP8psIXBG/FsV1kVdgnE1rcPBOpvYRJd+Yw5N7TwM9ZEYCpuKTneSktu8TYuzECsF3PlwEVX1ICAyycMNqexJXB61D+3cPwKj/W6MRbkjrNEO5dKTiVkAnPaOjZ2oJc840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908546; c=relaxed/simple;
	bh=Lzp4sRKgxiIvRGFx9BiDXQxvVArzAz4MDOwKv4i6N+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3O0ETNabsi705IhR0b+kS5AxX7p57k6tkHN9YGKmzndGnwGrLi0y/G/PcniAiuR15+2KFpbKr3t6x8/znBDagdNzaIVXujPYmanaHxGBJzdvdyXFM3BU028Nxh9FF11tcCoZW8rsyGz5v3/ea6XRqTRuZ1hV4vRejqR8xH1GpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dVIFM7DZ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: technoboy85@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716908541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4E6/alJ1dW3jtDGeelSkZhj/r51bIr/djlPIaSzGDLI=;
	b=dVIFM7DZIoaSoZguZrOcx4emS0kHYbSk50Q7xp3ITtWQKViBHfc4hrAsd9zDMoD4CrPnm8
	ReQQEqhY1ujZVf42DgklW6YeM4lzKCynqyRjz3Din4rbZRdg5l1bPlQoG4WhwhNkA4LXhu
	tI9A/zKo3Eu14EKe4lA6BU+M+0f5X9E=
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: shuah@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
Date: Tue, 28 May 2024 08:02:14 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matteo Croce <technoboy85@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: make net.core.{r,w}mem_{default,max}
 namespaced
Message-ID: <hydlaj3xarekyqxf2bmlsudf5wbhghorrl54reora4gldm4lqn@xt4xdw7gi34k>
References: <20240528121139.38035-1-teknoraver@meta.com>
 <20240528121139.38035-2-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528121139.38035-2-teknoraver@meta.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 02:11:38PM GMT, Matteo Croce wrote:
> The following sysctl are global and can't be read from a netns:
> 
> net.core.rmem_default
> net.core.rmem_max
> net.core.wmem_default
> net.core.wmem_max
> 
> Make the following sysctl parameters available readonly from within a
> network namespace, allowing a container to read them.
> 
> Signed-off-by: Matteo Croce <teknoraver@meta.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

