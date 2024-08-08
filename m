Return-Path: <linux-kselftest+bounces-15005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4502494B4A6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 03:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BB528396C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 01:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414258BF0;
	Thu,  8 Aug 2024 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOPlTJ4X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944579E1;
	Thu,  8 Aug 2024 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723080518; cv=none; b=pPsPLuR/MKD/O9V5gwQwyLaVqrtMOY7VgKGwnl6x120IlE0e38p9DQ2duYtmZH3thEL7TolTknPjj2P5FZKFfH/qUEFg95v/Vm7Vq3UPqcX3rxrZEkY8fsIT9xan5Kpq8iKZmYUxhMIlYX57sH6r3Ys7R6HzQ507Sbl+5bLSueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723080518; c=relaxed/simple;
	bh=5RUxO6QCexIH/qQafb7rx0FQEMg4zHf33UeNT5058pI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=To7F5Lo/6SgXbsXdUBljWygUy4LdRky5q1OAABpNk/pKf16GLYfiH2Kwl2XVljmnO51wyDsxBowpZwvsYElQ2/x481TYX+5vX/xoH1CF8jgAhsJJmfblE1Yw4lZHspr+daFnfgRCqpdUJ9DA6bkZ3GwbvBznP4CBQog+ezE2oDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOPlTJ4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCC7C32781;
	Thu,  8 Aug 2024 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723080517;
	bh=5RUxO6QCexIH/qQafb7rx0FQEMg4zHf33UeNT5058pI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jOPlTJ4XwBPYF8VDJDmZVz6VqJQzHm7ou3QhaVOo7jHUFgiMi5pYQxFVh4hi1IJ2U
	 a1LuvxU6Lz9BzjuchoHTdc85fBzStcih/vIE1h9aydvU6KTZs1xF6M0NSiU/yFIXld
	 Mk8M+Soycub9DzM4XLphnbYkOqAG7IaWyPp8edWdvt4VMwz7vF/jMAOGnQs6bL38Tj
	 FmxbIYM2BBoTlMfeivonvM3RqxSDWaLGUiGHYTtg9uhjEoNQRzHWhRQKjMtEgN6EU7
	 4/h0cb3gD8YBcCMpGlV8TB7bUBUhVTmkChNa2OJDL20AdqKJQLdE9qCPGlohb4EkBY
	 ZLY6fOkQrLwlQ==
Date: Wed, 7 Aug 2024 18:28:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v4 1/2] selftests: net: Create veth pair for testing in
 networkless kernel
Message-ID: <20240807182834.25b8df00@kernel.org>
In-Reply-To: <20240807175717.7775-2-jain.abhinav177@gmail.com>
References: <20240807175717.7775-1-jain.abhinav177@gmail.com>
	<20240807175717.7775-2-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 17:57:16 +0000 Abhinav Jain wrote:
> +	ip link add veth0 type peer name veth1

That's not the right syntax..
-- 
pw-bot: cr

