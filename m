Return-Path: <linux-kselftest+bounces-37112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F91B01E32
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C356AB6174B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E472BD5B5;
	Fri, 11 Jul 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX7Am6ty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050513D531;
	Fri, 11 Jul 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241308; cv=none; b=eATkhXlUWrav+groGBQ7FX5QdIsVxPNMimUjpOjacy16tIKr5QxES5bHxeEax2OuQq/fN8UJVVmbF0gF2M4dbc0qHHyuFJXu4sw5V/SUscZLa0ecQlmRyUFHMH03yM7cTboOxsftQ6/u4SG1NaEFpQdGV4z9NB1LEywW0TWecR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241308; c=relaxed/simple;
	bh=NCuwZiyNDvXkV4rhIkWShyl044DoIR5VmewlCMG4d5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7hGGpaAe9B7zfrqn2bT+WAG6ue0U4Hv/Cu44SpTdcOgk43VKxWAWievqKpMtGj15/BsiFXiG8/wJ3zTf3srIOAV0gA1fjRbhobHoC5Yu5T35JEjc7JYY3MUZFQa8OkZywrfXGh2PdxlbtkxEXHGjYFqVktTThjFzATmmG6m0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX7Am6ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974CEC4CEED;
	Fri, 11 Jul 2025 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752241308;
	bh=NCuwZiyNDvXkV4rhIkWShyl044DoIR5VmewlCMG4d5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HX7Am6tyzuj4PCmRFQhK8tB6RLSgwXwhw+OaV0k66kw8x1CjP43yPXYht7fS15lnQ
	 UhCjsWdMgaHMEZJOQVw8y9loO9OeLRQw4sjWcubzSVtuqZbaiidAym3wG46If08MnT
	 Wj9s65gnv/8SgFYj3lkWl08noexD+cPvbweydsqgephqbN9nto1U+k2tIeHIlcU6mQ
	 QgV/oWV7UZJHLMB/kIT8q7lGR3q/91P5KYMfPPRUPNkNsCv/hGEbV82W3dqSIWwIUD
	 k0zhfPP1KX4nCVoiEQlXq0qpgEad0Oaf67y3m2uspFhGsK8q3sEK+hrc0RO9u3MGnZ
	 F8oFmFPRTu8dg==
Date: Fri, 11 Jul 2025 06:41:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
Message-ID: <20250711064146.0db275a7@kernel.org>
In-Reply-To: <20250710184351.63797-3-mohsin.bashr@gmail.com>
References: <20250710184351.63797-1-mohsin.bashr@gmail.com>
	<20250710184351.63797-3-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 11:43:48 -0700 Mohsin Bashir wrote:
> +    try:
> +        cmd(
> +        f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} "
> +        f"sec {bpf_info.xdp_sec}",
> +        shell=True
> +        )
> +        defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdp off")
> +    except Exception as e:
> +        raise KsftSkipEx(f"Failed to attach XDP porgram: {bpf_info.name}") from e

Please don't catch the exception here, let it break the test.
The cmd exception carries the info we need to debug, I had
to remove this to see why the test was skipping. We could try
to add the error lines to the SkipEx but frankly I don't think
it's worth the LoC.
-- 
pw-bot: cr

