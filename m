Return-Path: <linux-kselftest+bounces-13133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B71E926676
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 18:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523431F2305B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E931836DF;
	Wed,  3 Jul 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddmuluGZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366AE17995;
	Wed,  3 Jul 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025720; cv=none; b=EHE5RbnG4qjtWk8ZP0ZRWqrKscNdinJBNVvdRXZow5RdoZvggd9nUuSkLRYOF3pJrk+cWpUOtixbnzK2K3vb9D1an8R+LnFQg7a6zDFgiHCyiiKfBSGqCLIX/uXMhuJCrUqd9NEgZtK5MWXe+2O8tkL/3aEaW53b3MMV5aol1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025720; c=relaxed/simple;
	bh=+PeXrHsaPMzp69WfyGaJ9XKQl2xQRAGuZTf5N3KQs/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cauLCjv9Lk92RtXQnm2wn36D1ULMGKBbW/Vn5/CRtUCfg1UQyRequrEZtA3RYl2ZDIwesDjpEVdTXNH/RsL3gMI2NA9zH/fgcOk4mRqcA1busF7Gz6W4R6d31F3yFmbDsjI4dUAcwZUqDodBUAPhdT+zmjTQOYgrq0spUCGZjac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddmuluGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7F8C2BD10;
	Wed,  3 Jul 2024 16:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720025719;
	bh=+PeXrHsaPMzp69WfyGaJ9XKQl2xQRAGuZTf5N3KQs/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddmuluGZPOX8FIcHX2KfjspT0MBdo4E2deQ3g0TOxC2PNb3FrfJRqsPtHkU++v0IT
	 WuD/k/mRw/QVQqQv4PeosQDh5LiRzq0EnHvxLATAE9x1jZ7sAJ1bMHCXosz03m7001
	 Lw1s8z7n7r952uaq/J6uv1sShQMGgvNbvWaw6xe8NOTOtO2VNkY/GxA0D0Y2CCt9eV
	 kCT74CxJvXCx/4MdXQhl+vJ4ThCkX0G8j9d08M2Qb+ql7S9DKfFJ4rv/Z+v7ptcUGL
	 l0tNB9h8HDvt/xPdeAWDbhjsd+FUVKZUHWfhaJaokCV/oWu3ykiCj1yxi3gr9cmKux
	 IleJFHU/+CgFA==
Date: Wed, 3 Jul 2024 17:55:15 +0100
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
Subject: Re: [PATCH net-next 1/3] selftests: openvswitch: Bump timeout to 15
 minutes.
Message-ID: <20240703165515.GS598357@kernel.org>
References: <20240702132830.213384-1-aconole@redhat.com>
 <20240702132830.213384-2-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702132830.213384-2-aconole@redhat.com>

On Tue, Jul 02, 2024 at 09:28:28AM -0400, Aaron Conole wrote:
> We found that since some tests rely on the TCP SYN timeouts to cause flow
> misses, the default test suite timeout of 45 seconds is quick to be
> exceeded.  Bump the timeout to 15 minutes.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>

FWIIW, locally I had been using a timeout of 720s.
So 900 seems entirely reasonable to me.


