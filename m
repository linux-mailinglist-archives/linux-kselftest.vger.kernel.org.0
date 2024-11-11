Return-Path: <linux-kselftest+bounces-21784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CFF9C3E54
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 13:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A10B283BDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 12:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDD919B3EE;
	Mon, 11 Nov 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZxruIoh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFAB1369AA;
	Mon, 11 Nov 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327413; cv=none; b=HHXkNSSicp/fEV5HcwJywdiPnr7yMPsPFIFjW6yd7lsR7wjpAPNNswYlmr0VIDqEp+wcs/O1jywJnsvUY3+7Rz6PTeOaN6whCL4Vyxvs429a1TkRXNq2QerzTDJX/eanbQihiebyZijClYgjmLu4pkoneCwbD2YI2xZYZJlW+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327413; c=relaxed/simple;
	bh=pToqxL/FLgOHlS6DlsxqaAkSvkTKEVD1+0wYGYbj0Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkyCvT7M219eZkG+/wBDPBJg4ZMtnn0NPsRLqmYmufXnLdFiH9eKLclxJpvLXf4iLp8PcUH6pw/0xWUokD7mVbts+kTRoLu7HHQVd5ty65le1Euu3r+t55FKULfgs2OdDxNh3AKPmGHT2JCy53YC+IsbN6l6QUUGZENg5sQEBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZxruIoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D35FC4CECF;
	Mon, 11 Nov 2024 12:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327412;
	bh=pToqxL/FLgOHlS6DlsxqaAkSvkTKEVD1+0wYGYbj0Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZxruIohzRmAlmGa4+bvkrM5XExd1XfLYHVSbf0JTfMCGCTBKBl8kPFl4nEKvc6TZ
	 lZNvvxst0ZvRafsdW7zuFNJvAs5rQcuyQQB+D1dW3+21tAOQ7pCpJWIuKrbMuRgw33
	 chX9aeYqfN38+4RWkZBBMTv2FxxWhyhX5Z84wbas6tyKi1n0TIhd93hK3Qzgg1nTJ5
	 LqMUY+jutZP6L0Di/ydfTyJt+xkF+SG7YtAHPluNI7a/MdpzJDOaL2UREm5TIs7h+J
	 NIEkZoFbbd3PUd3LLJ6hTVSbS+kjJK0+5wgI9+zefX2Yzjvep3rkdFDlfMxplVoj73
	 You7uJTtNhSew==
Date: Mon, 11 Nov 2024 12:16:49 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 8/8] selftests: netdevsim: add ethtool features
 to macsec offload tests
Message-ID: <20241111121649.GB4507@kernel.org>
References: <cover.1730929545.git.sd@queasysnail.net>
 <ba801bd0a75b02de2dddbfc77f9efceb8b3d8a2e.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba801bd0a75b02de2dddbfc77f9efceb8b3d8a2e.1730929545.git.sd@queasysnail.net>

On Thu, Nov 07, 2024 at 12:13:34AM +0100, Sabrina Dubroca wrote:
> The test verifies that available features aren't changed by toggling
> offload on the device. Creating a device with offload off and then
> enabling it later should result in the same features as creating the
> device with offload enabled directly.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


