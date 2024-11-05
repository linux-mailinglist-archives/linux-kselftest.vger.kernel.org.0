Return-Path: <linux-kselftest+bounces-21429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC99BC296
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 02:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668EF1F2349A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 01:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7531804A;
	Tue,  5 Nov 2024 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVD1DX0a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F617BA6;
	Tue,  5 Nov 2024 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770445; cv=none; b=nJAUCTJ3Y2yVdDTPfZiB+tABXjzRKgXoFLfNulG5qB/2lqRK35/wsoSmlHfMseOWJQX0UORTtFwtagfu5I+snwvtOSZLvuF90VHAZhL/RfXQaBXh+OiDL3FqrInGEcM1oU6qlLGnILVEn85HqH/LO2pJvup4J9g03Yc5qjfNU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770445; c=relaxed/simple;
	bh=7ZY6NfnwmzvnOKiQX/Sgmi2yLhNynfjc4SY4a+muKpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7vyygCpPL80yWokmiXaO6q7w3B4ztKudhrkwDIE+x5Mkaoe2Wi9y3ysmOuwTEKEj+L9sDYpZV98wfF+xFsHnE/0mvD8d4zEjgnVRTI/L+ucxcztFF1pZVkTIilhBlhdaUl/W4u2X7qCmw5J/ZqHNXENFyQdseh4U9LCVG8BhG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVD1DX0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BCDC4CECE;
	Tue,  5 Nov 2024 01:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730770444;
	bh=7ZY6NfnwmzvnOKiQX/Sgmi2yLhNynfjc4SY4a+muKpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fVD1DX0aZecIdLPxavn9gwElpEbKB9IWeYpNi5lsv/R6P4BMs+/y2+p7u42KboNMt
	 Df0WSJ9CUr57FXmXeYGyyFFoWIIAh3pmEsUqMtoWW6R2uthg4zM64SrZRHis5htYUU
	 9tSgcMD9JEqlqkC0ZChELZPt6LkAkrCKbtylwXNyDYpk/Qq+8cSQGeyVs+gX4GkLAF
	 yQ+y1s8iowdkLK1k7JQQrCnkqHqch+A/cKRWmkk9ZzywkEeiaYJPbJOfU6f8HSDlXW
	 I2CaFCpjQOd5QhfudeKP+/54ZqiDkUOulsHZ2OlMJZhq2DU9SqhYaU5+Kz7F7wKBRH
	 wvUEKGvjEt8OQ==
Date: Mon, 4 Nov 2024 17:34:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org,
 almasrymina@google.com, willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 12/12] selftests: ncdevmem: Add automated
 test
Message-ID: <20241104173403.49322788@kernel.org>
In-Reply-To: <ZyljjgxP94IBWnI6@LQ3V64L9R2>
References: <20241104181430.228682-1-sdf@fomichev.me>
	<20241104181430.228682-13-sdf@fomichev.me>
	<ZyljjgxP94IBWnI6@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 16:15:10 -0800 Joe Damato wrote:
> > +    with bkg(listen_cmd) as nc:
> > +        wait_port_listen(port)
> > +        cmd(f"echo -e \"hello\\nworld\"| nc {cfg.v6} {port}", host=cfg.remote, shell=True)  
> 
> FWIW, in the v3 of the series I submit, Jakub asked me to replace nc
> with socat due to issues with nc [1].
> 
> Your usage of nc seems pretty basic though, so maybe it's fine?

Good catch, let's not use nc. I seem to recall it's also funny about
address family selection. Also may be useful to add a helper for sending
simple strings from remote to avoid having this problem again.

