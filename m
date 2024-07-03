Return-Path: <linux-kselftest+bounces-13135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD30926680
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B689F1F24092
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB5183097;
	Wed,  3 Jul 2024 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E44y8ZhS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B581426C;
	Wed,  3 Jul 2024 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025763; cv=none; b=EAbafeOx2NfAEyw4CGbpq//6BuVd/e3NDIzXy7Ktg0sc4SoiGU0P2iA+cAcmZSL/CdkbnZ9JLXF+94Cb9nVFSP3QR+6L9J4EpwHiNuCe5joe8A199cQrIKUEVWWQjaLQy1Dp2BFlfx61lpMFDLPov0T7rGZRdoCUnp18vL6Zub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025763; c=relaxed/simple;
	bh=C0GzLM3tgj2e/l7UjLWTgeesEvyPFQmncedX40xjN0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSLF1rxRg+SZs2Yw+ymvdNrZcGyXN7wxqtKrv3n1Wxo/I5EmA3TJ1xSZdhGLW13h6ZRbBhAEJb8uvq1GuRgGkuX2LMDcyFjsLowmWGg4JUj5Mu8Zo+Z/ehBlw8YPkqNw6hPDzHOXIFlh915JtMtpIWzo8lvQXdnTh/pmh0sv3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E44y8ZhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8799FC2BD10;
	Wed,  3 Jul 2024 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720025762;
	bh=C0GzLM3tgj2e/l7UjLWTgeesEvyPFQmncedX40xjN0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E44y8ZhSurerADhgbUiohUu8lcGyVfTtr1VBOncrpQxFCZgRMO/iKHN/c9LriZC/H
	 QUPMD/+Hd3GLV0rRKwhR+YfKTlxjyOIXY0pEVBT6eDzW318qPqU26atz5yMzQvUbva
	 8IfOqtZZziM2NCxnki4nj0EEUOdpIW2EHnfE/77PXo3tBLTX1vBpSrnDfQkhbhz07G
	 DSZjly4MSAhIMhKQSkN8E85eG/+gxFCEHnMTNr9A2J1r5nAKHP9NiLa3OSYkgTxwoI
	 Lf6AFvFkm085sM44I0L+79yZ2gKSsuqTsP6y2bk6m+YZQdOFNQk2jCSNzyqOx9a4TL
	 1XTj8mjuWSV5A==
Date: Wed, 3 Jul 2024 17:55:58 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	=?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Subject: Re: [PATCH net-next 3/3] selftests: openvswitch: Be more verbose
 with selftest debugging.
Message-ID: <20240703165558.GU598357@kernel.org>
References: <20240702132830.213384-1-aconole@redhat.com>
 <20240702132830.213384-4-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702132830.213384-4-aconole@redhat.com>

On Tue, Jul 02, 2024 at 09:28:30AM -0400, Aaron Conole wrote:
> The openvswitch selftest is difficult to debug for anyone that isn't
> directly familiar with the openvswitch module and the specifics of the
> test cases.  Many times when something fails, the debug log will be
> sparsely populated and it takes some time to understand where a failure
> occured.
> 
> Increase the amount of details logged to the debug log by trapping all
> 'info' logs, and all 'ovs_sbx' commands.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


