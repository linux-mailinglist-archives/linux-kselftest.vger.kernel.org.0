Return-Path: <linux-kselftest+bounces-21783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC179C3E53
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 13:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D164F1C21C24
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 12:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE4C19CC0F;
	Mon, 11 Nov 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg+VBZVY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE314B946;
	Mon, 11 Nov 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327400; cv=none; b=MyJz3cQjIOoaX4ct5vld0lZmvEucqTXt0apz7r8PU735NGntb0xZIx379n5HfwJhDLsNXnR1HEhAqFrRaM1b2rJY19xzKkUk/0iHW8sNwSxrx6kV/n8izXzxGZlPUpMfhwitR5qXeanbAJS+nXkAI6J9xVsGCOoOeAgSED4GzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327400; c=relaxed/simple;
	bh=q40SP4Yho11YnIjVN0Ekc4I28feBna0a2qlfCB88FbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVsH2ivK3AwK1tGsTUE3yZoE8afv/T7UsTzXagczCahEYOhG13j7w/zw7QOrpzWlCQ1y0NsUBXX0/LVcndBTIi8+RVZibgTeGMIJ5lektYz7c4MoMG/U+bqAE7OErKYkqZtYfQYPzdkPD98hxLQoK2mUEyFsrNrXo7XJXwnlXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg+VBZVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD8DC4CED5;
	Mon, 11 Nov 2024 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327400;
	bh=q40SP4Yho11YnIjVN0Ekc4I28feBna0a2qlfCB88FbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wg+VBZVYpAkd2vHed17onCXWSXVDV2N1PQiVyGcKVDFvJOOo8LbaGAT0RT2wNd1QX
	 nRxhGEwxE2TFs78RCngux8+YN+mU/hKYz/bwb/dBxLiPi5RsfiDU0BqyujRyjjrxY2
	 HK5amt0yqwPxHj2tjCpoKZZjBMxjh18JvrETinuu6n0PNCbDiuQgz+/FbPkL3pgI3w
	 rHeVOO+LXHFakrfoAeETE16yAGAgR8TTIg4lyIbJ7Lg9IWgnLxsjSpENtDPkKV4gGK
	 jZfKIl9Sl7ddJ6FM0Uy/17/HknmIBEbkizwInscQ9VbaZJAVfmHJJTRCDvqKVRNu6P
	 ui2DwFj1b3k3g==
Date: Mon, 11 Nov 2024 12:16:36 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 7/8] selftests: netdevsim: add test toggling
 macsec offload
Message-ID: <20241111121636.GA4507@kernel.org>
References: <cover.1730929545.git.sd@queasysnail.net>
 <bf8e27ee0d921caa4eb35f1e830eca6d4080ddb2.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf8e27ee0d921caa4eb35f1e830eca6d4080ddb2.1730929545.git.sd@queasysnail.net>

On Thu, Nov 07, 2024 at 12:13:33AM +0100, Sabrina Dubroca wrote:
> The test verifies that toggling offload works (both via rtnetlink and
> macsec's genetlink APIs). This is only possible when no SA is
> configured.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


