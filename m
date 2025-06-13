Return-Path: <linux-kselftest+bounces-34925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E3AD9351
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2A71884774
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BCE215179;
	Fri, 13 Jun 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpTMlk8b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E8212D9D;
	Fri, 13 Jun 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833876; cv=none; b=L9O608HqXnuUHFO77mipo4oen0kY15Zz8X4Xkhx9TAzpaUI2kzjBd4Uu/CB3VqaIO2WasmG/xEPNhCnX+OQ4Qa+IN9rQUo95yZAd5R8pd1SyJU3MiPS3yxKJJkad/NV3coYQ8inu+8va5qbdasFY9KxlQNry8OcFJP879e3fbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833876; c=relaxed/simple;
	bh=T2Oj8D/j/kyuzbO06KsrbRNkvwQVpzzj5nMYYY93FCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axtQneQQGT2BLdaEPEmuHKNiBxciKostPsx9skPtx3NeoyzUHhObOGIvUDUHQ95FlsNI6TKV81lK6W4wBELHERj76htjJqNw0VoK2pTHx46rqaVioo4FeZhFClSwLMrY4hyMuSwbw4QisgAyxj7Jr/pLiJoQtShk4g5YH8rsUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpTMlk8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4564C4CEE3;
	Fri, 13 Jun 2025 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749833876;
	bh=T2Oj8D/j/kyuzbO06KsrbRNkvwQVpzzj5nMYYY93FCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kpTMlk8bN29mHiPUPNzgC0uXXS+eZNED1t/Hq9Zira6sFqlNjfVsOZuXvjura2CLh
	 nCBCWwqg4No16ghCspvi4iuOePB6VU+cgSOiMLA+gS0o6JtmYovp2sVlg/fv6IbRO4
	 WPEyS3WfreQfHg2dyQVC+UXSvp8jZKYLysCfrRx5ncKu3f6ZTFqZKmSQMZJIOqwlqO
	 LQY/WrtIZrjqh/PPlvkW5DvLo8mveU9Dng2S9lXjKM6sx5OBjgw1gmD2FgH5c2UevL
	 NKaWQ1g3OWF+PN5QHBM3KseS7L12HgTTOEQhUt1mzfVGkYD5ww9MK/gT/IeEh7vFy2
	 WE/F0m104jy+Q==
Date: Fri, 13 Jun 2025 09:57:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 14/14] selftests: forwarding: Add a test for
 verifying VXLAN MC underlay
Message-ID: <20250613095755.54381628@kernel.org>
In-Reply-To: <78edac89730a346e957b69d4107fcd8f1c5c6266.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
	<78edac89730a346e957b69d4107fcd8f1c5c6266.1749757582.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 22:10:48 +0200 Petr Machata wrote:
> Add tests for MC-routing underlay VXLAN traffic.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Adjust as per shellcheck citations

Noob question - would we also be able to squash the unreachable code
warnings if we declared ALL_TESTS as an array instead of a string?
IDK if there's any trick we could use to make shellcheck stop
complaining. Not blocking the series, obviously.

CC Matthieu, I presume you may have already investigated this :)

