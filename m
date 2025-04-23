Return-Path: <linux-kselftest+bounces-31463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF25FA99BE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 01:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65A21B82332
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 23:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3FA1FC0EA;
	Wed, 23 Apr 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFAjZS5t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736619F137;
	Wed, 23 Apr 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450156; cv=none; b=egkTKxIEK4tMIqVl0lRUNSNVg+UwP1KR3cGaAA31lNs9je0AWaZTz+i9hWPvT/fkuhjdmI83uAgRTUtwFO9qeu7/LwyqadplIWI9ZfGU0tpybnk5YFhA74hhBCYpuqbFZ9raWtGcWTkfhDT8bzfbWN20ayVcsymlY5IDx0v+8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450156; c=relaxed/simple;
	bh=wgkEPpyz4ggaqmkw2eNvgj0JwXd1rBnLWEvXL1hDFyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUApKtOrip76DoJStSEWbLWRt4kdU53ha8BJYX2jkl8iU3dMxy+GvlAuxYCW7ff8c19rwGwtT/LZriS3WiW3SAYU+SedsICjllKnwI261mKF4mokcVLTTuK+TRuVmBVkdN0pVwI7xHYBDDD+8DqPIAyVwhl1Vjo6WQ0dD+quUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFAjZS5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE515C4CEE2;
	Wed, 23 Apr 2025 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745450156;
	bh=wgkEPpyz4ggaqmkw2eNvgj0JwXd1rBnLWEvXL1hDFyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iFAjZS5tB79Rvw1xGc2JrFEeW6eLEBGrkkzjDzAsTEPRHcA3q8jwym1To262TAsWs
	 +/WOB8++wVpz0GIrEK48YsjwEnMBlom8tRWX2Dn0VYg/VDIX0xWb75yWuBowit9fZQ
	 +CgsE5MDMyiS3jKyNC6CJyz1H7svWB3RbbzHGa7EJTQj81EAmjqVYmx2wcBnUavH7f
	 5Jdfvl7/v/ICkMCM+71AT72tdNB9o+luau9XjVsAepjEqs15l1tnkPqakZNHkobQQW
	 0sOegwtLA9G9UEw/bj1FjVLOoQmsnzDZr+dIpBpsjWUXBdslFsQfuFXZH1JjFcDYZM
	 vm0dV7p5I4Hew==
Date: Wed, 23 Apr 2025 16:15:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, shaw.leon@gmail.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org (open list),
 linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
 bpf@vger.kernel.org (open list:XDP (eXpress Data
 Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: Re: [PATCH net-next v3 2/3] selftests: drv-net: Factor out ksft C
 helpers
Message-ID: <20250423161555.025c0051@kernel.org>
In-Reply-To: <20250418013719.12094-3-jdamato@fastly.com>
References: <20250418013719.12094-1-jdamato@fastly.com>
	<20250418013719.12094-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 01:37:04 +0000 Joe Damato wrote:
> +#if !defined(__KSFT_H__)
> +#define __KSFT_H__

If you have to respin maybe __NET_KSFT_H__ ?

