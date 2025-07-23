Return-Path: <linux-kselftest+bounces-37863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC10B0E87E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 04:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D754E42F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D061A073F;
	Wed, 23 Jul 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsjmsP2K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF244A1A;
	Wed, 23 Jul 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753236533; cv=none; b=m6w8REcEcvnwWP7ENT5k3u15FdqUy7PssfpDYP8p8s+HM9nLzLTy+B2W3d7NnAbwhlhsU66BRf1CnRGqcaR17NhOjw4jfRTJfy2lVS+fSRPHUAJMuIq5cVjz4Pw2dmfIhaxxWoNUf6sEjMTsiup6VaAdVPtu5U+kpYF/acwUU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753236533; c=relaxed/simple;
	bh=777U6qjOtYKD2//wo+TZX/3UN6qT22IkvqkW0/IUhT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZRfJwkSoVH9THl5/VxkDQjDeTkjbIvBuamUy5h4eLKNZQfXdN1TfGCVRAWdfUYYWevK6MNIISX/fVNomSQD/lhB7ImWobk5i6ATnz+Of9sgPF7/VbKPfwrvnDGoalfN4zMcHxlGaCFCTruDg5BoFt8vqvnv56fJG7Sf5jOxG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsjmsP2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A500EC4CEEB;
	Wed, 23 Jul 2025 02:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753236533;
	bh=777U6qjOtYKD2//wo+TZX/3UN6qT22IkvqkW0/IUhT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SsjmsP2KFHuPASDM25oNdjxB7vnKt3JPZi7k4+Awe6YNHSrmrboT+y9UNlNd8dNOe
	 pnQx2oRAXkUnJcaOT13M56v3NWqShzBy8tgzvJbx8JCsF3AD3EXNAHGk6PaMsVosNy
	 HoA3krkJ3BXyjRUvOduxPG5XCuUHNdkxZvxXDHJDBR4ni+LAXC1SG2ZJdIykzuFaX3
	 kIvGU03a+KyLAgTkWBsbtD1735CDr003MI29zPoooyphbAhrgmgB2zTGganF7AHwQB
	 L0nNmbmpVdao9g05O31R1A1a03okTpvW+nyApwQ5QyaYlLg7OyxvLZtvr9AXXZrqNI
	 /6AWqOpTy7/sQ==
Date: Tue, 22 Jul 2025 19:08:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Jiri
 Pirko <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next] devlink: Fix excessive stack usage in rate TC
 bandwidth parsing
Message-ID: <20250722190851.0b5a85a5@kernel.org>
In-Reply-To: <1753175609-330621-1-git-send-email-tariqt@nvidia.com>
References: <1753175609-330621-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 12:13:29 +0300 Tariq Toukan wrote:
> --- a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
> +++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py

Unrelated to this patch, but checkers report this is not included in
the Makefile

