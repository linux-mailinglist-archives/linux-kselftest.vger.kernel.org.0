Return-Path: <linux-kselftest+bounces-28198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E5A4DCFB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 12:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432B4188F22C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A41200BBE;
	Tue,  4 Mar 2025 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D20TNwTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961861FFC68;
	Tue,  4 Mar 2025 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089028; cv=none; b=sE6260TrivJEn3cxD6ZTbssXYXYV/W1qxINZhb9ZxwfPhsdEEUqIb2KWQ4YrW+qRQ2OUXjGl7tw0Hoc74swhQivjrwG8kZGXXWJghY0y6eQvHwUxI7mwZGoomzplCiVRHPK7rgmN0FjTha+bnUbsnE+VGcO554A4OTrkTqm4Ydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089028; c=relaxed/simple;
	bh=kmomjaiI3c2VGNM7oWwROpYWTIS/k9TkBJGFHrTSAeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKMm/amFbSqF4JTL+HNXr8GZCkWiEttbad0MWtnDzo+G/zDV171raQ570tDedKJlDrxMgrR6nhU3gMg2XajipXA7GJk4a3LV20JY35/ASS1DmR2ekOKLFyN31M8Sl/ROQBsMoehRNaJA4VRYt95cCnJ1ketMLVnX6+i/iNLqvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D20TNwTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2918C4CEE5;
	Tue,  4 Mar 2025 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741089028;
	bh=kmomjaiI3c2VGNM7oWwROpYWTIS/k9TkBJGFHrTSAeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D20TNwTK7KVFhQq1NmArBDPe4rQlX8/WvrpJFFgqMR0rG1pyCZibVccsp83IIzacO
	 RstbbvOSgYHkKA68NOPU8/tqoSuceilz9wLwtZuYWNnMFrgDg5LdHkUka8M7hkyhZQ
	 NNHND9WXIvgl6C5ouNJEwgQ2+zMulJHbIHDWLGBuWXhvWTFtV3oMuDqNao0YVT+Mue
	 xE6Q5y/Gy1j1U9uCHuq6cusMFA3bzv+0P5F9XY2WtcRJo/Fh9FiLxEOoDi/7B+BbSc
	 lAD0eFmwI7JFA4zgCG0LDVf1+FRPWJjBSA5GtdCmAlpyFCNmYKJY47kPLfn9zsgLxe
	 PTtZ0XI2l4bLA==
Date: Tue, 4 Mar 2025 11:50:23 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 2/8] netconsole: Make boolean comparison
 consistent
Message-ID: <20250304115023.GB3666230@kernel.org>
References: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
 <20250228-netcons_current-v2-2-f53ff79a0db2@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-netcons_current-v2-2-f53ff79a0db2@debian.org>

On Fri, Feb 28, 2025 at 04:50:18AM -0800, Breno Leitao wrote:
> Convert the current state assignment to use explicit boolean conversion,
> making the code more robust and easier to read. This change adds a
> double-negation operator to ensure consistent boolean conversion as
> suggested by Paolo[1].
> 
> This approach aligns with the existing pattern used in
> sysdata_cpu_nr_enabled_show().
> 
> Link: https://lore.kernel.org/all/7309e760-63b0-4b58-ad33-2fb8db361141@redhat.com/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks Breno,

FWIIW, I 100% agree with this change.

Reviewed-by: Simon Horman <horms@kernel.org>

