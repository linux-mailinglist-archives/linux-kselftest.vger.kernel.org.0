Return-Path: <linux-kselftest+bounces-15651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0406956E23
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD169284BE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289C91741F8;
	Mon, 19 Aug 2024 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN5W2u3O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13B12D045;
	Mon, 19 Aug 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079787; cv=none; b=hHJOhBeFKkolhThWDVGSRpWF+6U4hRhAljEchR+VQmoeQh5UKGO4XhQpMVTooiyO+LY5cUlcWBxyd3LD9JMbS6DNeD8YYYNWaGeGMNlSsURSZ1V04KMIUSd7Kro5JCmjzREOcoc8JVDGq6KAmlPmekaa0lYBIAnAMi4JO17RLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079787; c=relaxed/simple;
	bh=JlzGbNXb8Cdlww0lt4GLVPReewcUs1MaZWUYEHWvNGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEkGVCvQTZDyZbVa1FZiM17w3gQ9peqQMLl16E44bt2CaWiRLRvv7K6E1uBazJRSKVA5AzqEDjfIsznnBfmXSYcRAGy1H24WAUOI13UvOk6hflWUN8Y2lgf/ggviTtGePalek48tnhofKEaeyP7KENibQJ4szUHo7OvKl3zPbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN5W2u3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C0EC32782;
	Mon, 19 Aug 2024 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724079786;
	bh=JlzGbNXb8Cdlww0lt4GLVPReewcUs1MaZWUYEHWvNGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kN5W2u3Ob67pIYp/Xx30gCMHEk+co1mFoOe2E2WjOh9NVuvXz7OnQhCuye5FaDxtQ
	 hxOuVpCg20at4mwahEa0/qm67wRg/JeqY+khYwKsIXQn5Osx61mZgfTmLa9uNeeK2k
	 eNEh4o04EdY9V3t0g2RJYHZ3BanQ+2N83A5rdiPQ9UQWp66EwyD2K2E4JFUTUYifRu
	 EOKeyjhm6pMYxdOQOeP/cwWK8TooCpZ17c3EwaHBHeo3EV56j3A3o1pKujC+0N9c0R
	 AE00XITisTVevMRXT+R002eP/n9pK38RPL/o57Owr0+HpW2wCrGgBW72XMPM05Mb1T
	 8upxrr6WLHqHQ==
Date: Mon, 19 Aug 2024 16:03:02 +0100
From: Simon Horman <horms@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v8 net-next 2/3] selftests: net: Add on/off checks for
 non-fixed features of interface
Message-ID: <20240819150302.GH11472@kernel.org>
References: <20240819121235.39514-1-jain.abhinav177@gmail.com>
 <20240819121235.39514-3-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819121235.39514-3-jain.abhinav177@gmail.com>

On Mon, Aug 19, 2024 at 05:42:34PM +0530, Abhinav Jain wrote:
> Implement on/off testing for all non-fixed features via while loop.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


