Return-Path: <linux-kselftest+bounces-28502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6BDA56E8C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299331693CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33FD23E336;
	Fri,  7 Mar 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV9Hd4Yf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651921D3D7;
	Fri,  7 Mar 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367014; cv=none; b=tR7veFQOZlHld37sfp5fh7FHwfRexOeg8a+BlJoaLalxXqMQXdOMUUub7iolPpZznVqUpGGMmq4PjqtmVhZTDBWc5NTDXBgDMBVMVWW/23FjmIC2ggJpbJSyE8ETGd5vjdgCh+sPHWlk5E1U59jKCb/Lj8hTldaglVNOUxBSw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367014; c=relaxed/simple;
	bh=XBbVJpPHg4+2H/f38CpCQLx2/GuGU/dn/gz42YpI29w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbOMDC92sGdBucjDK+uIN8OPiWrcGFvYntF9jVnj/LAyEJ3Qtu9/2v4PlOcrK5ksSdA8odrccuhZdWJF1jSxGssyifgFU0lNCmsjG3QBL5sT4xX5Ch2BevmTkOXRRbUcKAVREVAtlZCncQzwJUBsKW719snX8Ygw0Hc9QjpZwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV9Hd4Yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CF7C4CED1;
	Fri,  7 Mar 2025 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741367014;
	bh=XBbVJpPHg4+2H/f38CpCQLx2/GuGU/dn/gz42YpI29w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sV9Hd4Yf9C49FE32tguBVSysvAGK55gV/SYBpBVyTUbVTgzKy6XQXMAkjzfUgcm9/
	 yC+p21WNf5WDyatZEYTIriHWbcpBLv3DXMppjSSCFpWtWzXYR+Coz7uhlly4lGCkS2
	 Y4Q8JYoBVhXAD30Cy6aRI4nK2hA29jMAZtWrkoaTAVtM++ne8uhqsAnrmcpjI0/KPw
	 L/3qtIZkzWKPnVbUFWpDRzUDgtAGblMHA7G8m3uPxLT3wGkcycB74I1wWsix7ubqVo
	 RigqULAA4BT8fJ2D8mXZ/JRoc//B0j1QskgHCSQxAvs0rtSUoM+5Nz9ZubnENo2Mny
	 e8725pSMUaXMQ==
Date: Fri, 7 Mar 2025 09:03:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu
 <jianbol@nvidia.com>, Jarod Wilson <jarod@redhat.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, Cosmin Ratiu <cratiu@nvidia.com>, Petr
 Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 net 1/3] bonding: fix calling sleeping function in
 spin lock and some race conditions
Message-ID: <20250307090332.5b556ebb@kernel.org>
In-Reply-To: <6dd52efd-3367-4a77-8e7b-7f73096bcb3f@blackwall.org>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
	<20250307031903.223973-2-liuhangbin@gmail.com>
	<6dd52efd-3367-4a77-8e7b-7f73096bcb3f@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 09:42:49 +0200 Nikolay Aleksandrov wrote:
> TBH, keeping buggy code with a comment doesn't sound good to me. I'd rather remove this
> support than tell people "good luck, it might crash". It's better to be safe until a
> correct design is in place which takes care of these issues.

That's my feeling too, FWIW. I think we knew about this issue
for a while now, the longer we wait the more users we may disrupt
with the revert.

