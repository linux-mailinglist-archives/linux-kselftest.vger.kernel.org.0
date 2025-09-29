Return-Path: <linux-kselftest+bounces-42601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3E8BAA701
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BCD1923982
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15582417E6;
	Mon, 29 Sep 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP8Wh5fc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A51E6DC5;
	Mon, 29 Sep 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173268; cv=none; b=KZUAJKOO2+irEIv+AZXEDLHD3J8/RZ4koWG5Ubcc8B2kFRd3fGAIhdtMyEJxHnGlwKIz9H+K21gAUJpCZisp/Yl8+vtt0XLbLOMW1tnh+8xzqI/ZrW0DOSYvQiin97nebQi++/j+kl1NpkwLNi9bguh784WP4JbyyoUvvYowqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173268; c=relaxed/simple;
	bh=IHWl3V/9VxXoVyYAfC5FhfIPgvkTIDxYH/FXhdTSOaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmhlcTOPGtycoNxD5u65zFGAWV1ps/sYfI16ZTU4bluctNmnhQ8bOY3oL1NHwt3AVuAr3apTEvoVW/chiLtMmaO1j7brbq4MjSAoLzY2xTV2Ct/OHNWTFzjJvhSGbYy66C0TMR4b1Ewi/kRw+efCFlTIM5ORqm8irPJGl5pXmVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP8Wh5fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE799C4CEF4;
	Mon, 29 Sep 2025 19:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759173268;
	bh=IHWl3V/9VxXoVyYAfC5FhfIPgvkTIDxYH/FXhdTSOaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RP8Wh5fcfC1T6ij+yBqI2djk8xT3ojMDhIBpmBnAYvznyP6kaCqHtghr8nkYRdUbb
	 ZZTu44UCWwUKBvVu3hWilu/+ZxBPRbJVj+bmPlw2wPIZ55/W0bF3YgZyMDMY4Gjl5w
	 V9PngqfVmk9yBdgvcotfV0POKmtRHUrVS0/hrZIQ9BuYAFb9te2bLN8ziIOcQLWJFZ
	 MY1tKQXMM0XuiFZKFc2UCGaD5f/AmqahGdo1MtoQZVpP/ZAZmCLxBW5+1fpxu3LLzd
	 7WOvG30Js5ihz03KOeLnlM1LfQQxmIx/QERVRp2CyXUOuvlXTzGaj/4wdnBSX6vxG9
	 FDP78nVbAv9+g==
Date: Mon, 29 Sep 2025 12:14:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: net: Check return value from read
Message-ID: <20250929121426.604f433c@kernel.org>
In-Reply-To: <20250926161538.57896-1-alessandro.zanni87@gmail.com>
References: <20250926161538.57896-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Sep 2025 18:15:37 +0200 Alessandro Zanni wrote:
> `make -C tools/testing/selftests TARGETS=3Dnet` emits the
>                        [...] =E2=80=98warn_unused_result=E2=80=99 [-Wunus=
ed-result]

Sorry if I already said this but it does not repro, for me.

Please clearly explain to us how this can be reproduced
so we can make our CI catch any future occurrences.
Getting follow up fixes for this sort of non-issues after
patches are merged is not a great use of reviewer bandwidth,
so we should really catch this in CI..
--=20
pw-bot: cr

