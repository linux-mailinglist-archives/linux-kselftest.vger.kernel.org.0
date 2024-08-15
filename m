Return-Path: <linux-kselftest+bounces-15372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B389A95274F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E6F1C21543
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C710F17C9;
	Thu, 15 Aug 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H39DNUXt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BCC144;
	Thu, 15 Aug 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683412; cv=none; b=oQoWvKhKvzCAxoiquqnGYdYzOAPPyPNw5fSECYa440Y0CueM29bBRolP9eFj9D6nOkn+0a/EkCK+QhVosFDAOa9J3CHDsFpRDEAchjnPC2Cl0YtSZrUv7YVeLN0Qrje2epimTZ5xOmNhvyitljOeMzPBWue6sLkCHpV8t1o/b+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683412; c=relaxed/simple;
	bh=dKyxcfo7YNnxvmGb0vztFcT/BfgAs5jKOb2gY5+XKgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTrCNNb/QLN/NdifWIXS+Xddgv/WvM416wW6yq/6PH6WqSy5natAQIj/0obYAU0RsLKhjOniKPZRtPIdZvKbTZcHL8as7YHLW0GZ6ET28ueHAPpO/CGfnhYhanCNrbI0GcEed1GYNYB7he+UWz4BM/R66gituKk/UJUBnu32mzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H39DNUXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B43CC116B1;
	Thu, 15 Aug 2024 00:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723683412;
	bh=dKyxcfo7YNnxvmGb0vztFcT/BfgAs5jKOb2gY5+XKgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H39DNUXtPJ1v7ch9W68IYEDJQgHFbm/jtYkbquTcWQAJvzM8fDyDn/ICZAkV2EsMe
	 vvmb17PUT+73VJ+G/oyXF8AVMNtOExNSVUEWNNOntMtnmPZAH1mD0EkEmEhLUIh83c
	 z+yvIwcFIgml7qnpsGd1AFa4fSWbBqXlbHmjlAvYOB00+Yypm4WYlZ28Z8vI25Shd5
	 Vg0EMl7UK7Wlk21FLWl//hBPQhoAabULryVw3Z/zaam3jP3NV9DAdxIIsT9pUvI6uP
	 f86O+IH/7ZCPd3gFLOlYX9vqOmBi+kp4tnJd6iF5N+UbCO6KWYt5H4kRhWtm2KkUXS
	 VLJUoej8nJV4w==
Date: Wed, 14 Aug 2024 17:56:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH net v6 0/2] Enhance network interface feature testing
Message-ID: <20240814175651.447982cc@kernel.org>
In-Reply-To: <20240814191517.50466-1-jain.abhinav177@gmail.com>
References: <20240814191517.50466-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 19:15:15 +0000 Abhinav Jain wrote:
> Changes in v6:
> Use XFAIL for ethtool operations that are unsupported instead of SKIP.

One more:

tools/testing/selftests/net/netdevice.sh:       echo "SKIP: $netdev: set IP address"

I think the SKIP -> XFAIL conversion should be a separate patch (for
total of 3 patches in the series).
-- 
pw-bot: cr

