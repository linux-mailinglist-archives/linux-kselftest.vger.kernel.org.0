Return-Path: <linux-kselftest+bounces-29429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5468A68D90
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 14:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADE93BFE80
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AE42561C0;
	Wed, 19 Mar 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mu7JLya9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA82517A9;
	Wed, 19 Mar 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390319; cv=none; b=X3AVvJcBZULTTxtIjjwawfpcRP/M11cTxrhBNs4fsrxl7Nx53vMnKFrs99e50DGTVBMUVMu3ykvGvd+dfS7dZdR3LVIhKpAmX/HIMcz2fmLDTmsMRdJ97BIxm7DoOO6zVDOjUhMt+MOBnMVZykGR2pkV3XA7SD37o1dU8fY+OdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390319; c=relaxed/simple;
	bh=u8h+soXGFlqYrV3lXjgfXVhn6iFX9vUvTicEqeZ/BSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNBQz9gwcUfU4C5ZuwITObVh5ICT+rz/kzfbJXfZ1U6G1lzl06G/rPtb/X7Y0LFTDhZfMC6tprkqj2j/nW0qNtYYPaPXtZyvodD51YNs+UUQ60jHa2ZB0AT6gmZyOp2oSZ2RxufYi2SSSenVFqMGUz000uaa9O/qvg0pZp2/qAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mu7JLya9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556B8C4CEE9;
	Wed, 19 Mar 2025 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742390318;
	bh=u8h+soXGFlqYrV3lXjgfXVhn6iFX9vUvTicEqeZ/BSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mu7JLya9CmwgBcDj/jhViKgJnindBWIKQFzZUzTXX9A/VRDb1iO94lQWhqOF1wX+H
	 MqeCWP0Rt34WimLRI52IZIwKXOX8WrY1GepZgIOA8b80VT51vD7wm4C856/WFU+GoZ
	 2cSIdMmWX84jqgRwMoIAt/M5o1eFWMD5kxoMYshg=
Date: Wed, 19 Mar 2025 09:18:37 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>, helpdesk@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/7] selftests/net: Mixed select()+polling mode for
 TCP-AO tests
Message-ID: <20250319-abstract-classic-woodlouse-66eef5@lemur>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
 <CAJwJo6bkdeGh0j1ABfrMQ3dRD7frEsNnJERWP8-jJs8dSYFwYA@mail.gmail.com>
 <CAJwJo6Y9g0JYiLY-taxtj7bo=Jy+U7bqTFsQjhgu2Re7BgaLsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJwJo6Y9g0JYiLY-taxtj7bo=Jy+U7bqTFsQjhgu2Re7BgaLsA@mail.gmail.com>

On Wed, Mar 19, 2025 at 03:26:27AM +0000, Dmitry Safonov wrote:
> However, as I sent the patches with b4 relay, it seems patchwork is
> unable to authorise me as the author of the series. Ugh :(

Oops. We should definitely properly handle this.
Sending a note to self via the helpdesk.

-K

