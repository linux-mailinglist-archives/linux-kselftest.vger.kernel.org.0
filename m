Return-Path: <linux-kselftest+bounces-29502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A5A6A79E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 14:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0357AF3A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FCD222591;
	Thu, 20 Mar 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K5tKDA2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98B221D86;
	Thu, 20 Mar 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478717; cv=none; b=OEdlhGSSw507MA1rZCanMpjt2jpKlstoNtEzDZmS3zUBWE3ErcHkM/dq7DUTy+rV/2NHOlUj4Gh2dkE0kgh/MWyYEd3TFenZICOGMAMV51RYFZTqtphhXh2pPiWYZDQoVIf0UVW/4GuHWNfolcLa7CmTLlJz2X+bW3fNhqR+Hps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478717; c=relaxed/simple;
	bh=W13Q0riSEx+B7UhAj+7iSfVuXrSVnlRMRME4EPOQSY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewo5jPYgP4qqbJV1i+WDpRdbMFvTo475UqGBPV8BtdX06/GlL2GfjDov9cDPOCSVXIHhD7m2fFAEHMsXSiCHAeff23EiglziWkSjsJaL+A/2sYRMYu/uS65OqjmZx5tJHbVoWfU+kPHl/YnjiK2CV/mANqeVagMjwRcFzUTSsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K5tKDA2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04C6C4CEDD;
	Thu, 20 Mar 2025 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742478717;
	bh=W13Q0riSEx+B7UhAj+7iSfVuXrSVnlRMRME4EPOQSY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5tKDA2ulIY6MSuzOainey37mBkWdHVZX6DkM5G2zHQVpHaN7Sc3DIIDz1bDavT23
	 Q8O5fYfmpxG8jeSz4+7x08xFmXKtETI/Sv/Hc2Kjohj6ap9WxFZhLozBQ8toZTjIi3
	 8+xeBuMlgBDFW62Xh+teg9qTfnLj34pqCNnZGxhU=
Date: Thu, 20 Mar 2025 09:51:52 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>, helpdesk@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/7] selftests/net: Mixed select()+polling mode for
 TCP-AO tests
Message-ID: <20250320-fancy-chital-of-attraction-c7a096@lemur>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
 <CAJwJo6bkdeGh0j1ABfrMQ3dRD7frEsNnJERWP8-jJs8dSYFwYA@mail.gmail.com>
 <CAJwJo6Y9g0JYiLY-taxtj7bo=Jy+U7bqTFsQjhgu2Re7BgaLsA@mail.gmail.com>
 <20250319-abstract-classic-woodlouse-66eef5@lemur>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319-abstract-classic-woodlouse-66eef5@lemur>

On Wed, Mar 19, 2025 at 09:18:37AM -0400, Konstantin Ryabitsev wrote:
> On Wed, Mar 19, 2025 at 03:26:27AM +0000, Dmitry Safonov wrote:
> > However, as I sent the patches with b4 relay, it seems patchwork is
> > unable to authorise me as the author of the series. Ugh :(
> 
> Oops. We should definitely properly handle this.
> Sending a note to self via the helpdesk.

This should be handled correctly now, e.g. see this series sent via the relay
yesterday:

https://patchwork.kernel.org/project/netdevbpf/patch/20250319-rfc2203-seqnum-cache-v2-2-2c98b859f2dd@janestreet.com/
vs.
https://lore.kernel.org/netdev/20250319-rfc2203-seqnum-cache-v2-2-2c98b859f2dd@janestreet.com/

-K

