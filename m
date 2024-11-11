Return-Path: <linux-kselftest+bounces-21780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FA29C3E4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 13:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2AF2813EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692119993B;
	Mon, 11 Nov 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc9xPxhx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED511369AA;
	Mon, 11 Nov 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327362; cv=none; b=koi3CHPhj1tMaBfglQqie4ZW4uDGT96ctfTcYoDBx9wP2kptteqgFaU3eJBtC2gNe2glE44QfarwQIBxkBsuefkHUDOkVwcru7NzA4Af0vPYcmrBgxQy4ukLOpRLBTFItFGQBMl0Pd0Lcn/c02EtPbgiUPgovA4lqOPETfigeN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327362; c=relaxed/simple;
	bh=tPd5kPMjZre3NDEPKoNOnMPgJfa9hVrMgOu+ojrX75A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLL+KPGb31vzIOi0GARlNzlY980Z2m50UMQ/B4HjoZxSkAmo7U/shBTz1x7mHz7Qt5hiBU+2IBQi4hmc/Mr16DrgHa6Xm/ZHYTXcdKnr6T60vnRug7ca1g84Qv7bEe9gMghn7VUxoZ2P7qBypZlvTNkrlCj46DiiO1uYLb1CRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc9xPxhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0A8C4CED5;
	Mon, 11 Nov 2024 12:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327362;
	bh=tPd5kPMjZre3NDEPKoNOnMPgJfa9hVrMgOu+ojrX75A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qc9xPxhxisK3byirKfthWTsXiABHXQ4i4gl0DbGqGV3OzahNCCEdrvz8EQUG84URl
	 rnimJwFC1JNN1fWQdsSj8RUCJ/RHZsRo72K96FDEpEqFU+jLhteHq4/xSY4HLIJ6cC
	 WrUQqa3MuFyLwbFqi3K2/5i78PNqAPuohqpi3rEcvIkcNwFggiSCM5cmHVynjqJcf0
	 MLMkpN7smSgEKu6PytI4PAImUjzsConHh05ap26QHGzkQGEBjx84b0AXImuEQQ7xgc
	 gL+Ym0le5S8PJeMa48aMyJzH+FFOo9QnwQJJfEgvDpZF5CDRyJ0wdGJfX8xCBppIvE
	 oLAVsxTGNthAw==
Date: Mon, 11 Nov 2024 12:15:58 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/8] macsec: clean up local variables in
 macsec_notify
Message-ID: <20241111121558.GX4507@kernel.org>
References: <cover.1730929545.git.sd@queasysnail.net>
 <9b8996af518fbeb3b7d527feb15d5788495e3108.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8996af518fbeb3b7d527feb15d5788495e3108.1730929545.git.sd@queasysnail.net>

On Thu, Nov 07, 2024 at 12:13:30AM +0100, Sabrina Dubroca wrote:
> For all events, we need to loop over the list of secys, so let's move
> the common variables out of the switch/case.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


