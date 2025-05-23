Return-Path: <linux-kselftest+bounces-33646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE75FAC2379
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 15:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FE7A25ADF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749B83A14;
	Fri, 23 May 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcBej1hc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD50151990;
	Fri, 23 May 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005726; cv=none; b=tVMsVCvJMCPL2cdYkH2cCftRpaDTwtjc9r0zKVjy3n3zmjqwBN7jQmP1lyeUmGghsS9NgP2ESnnliJlnxX+oEHXhNZFWF/yTPX7EzPpDhS31iXWoO0YszSm/5xKzSJrsOSDMHhcVqy8iM4rRwHBdANBhkkzbN5pyvMo51qWzGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005726; c=relaxed/simple;
	bh=JV/1Gfqr7/DTYbohhc0eut/n2vI/4G6jIFGhCVznTik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtqJJrwWY9C+xnQ7QQ0dLTNUA3UckakF8wPFCaVLCS1XPMlfujZKYacDotIO+oiz2+TQRITgdRylg0kp0dKkXM/7fyoGwyHspck1y+Adc7/5NwG8dhKw0KpPsIIlxu4p1kTd0l+g9pmzU6yf3C87EES2uWfCNesRSrOZH4o7+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcBej1hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D868C4CEE9;
	Fri, 23 May 2025 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748005725;
	bh=JV/1Gfqr7/DTYbohhc0eut/n2vI/4G6jIFGhCVznTik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcBej1hcKyPZAL+Y6Kt7H+YmTtUJEXG/vbY9hEAEOFrqAtuluopoLxfNZyc6B4mZp
	 gm/W9sDufD3sIEvS5sMDANkwMqtYNJF7kI4vmb6i+yTcHcYnkEAtoTbrFz/XeaLUd5
	 KFjrR/Tk/FXeCjfhhTSjEkcbnf7Lkpd+DlM/5Ng5VS2xQNnkjyvbGq9p21XidbBxfb
	 uMD9xjY+eRFel9a3tJpF/wQbvgDCPvhfevuBJvFewf2sC1UHvgqyLXkjfSi4T/kcAR
	 c7SLAcnFIgrHt6WXrxvTHHrmcqruZtj5MWOcgJjCo6Lmw6FArbJBlEVbBHTvavzaq+
	 I3j60WApuHbCQ==
Date: Fri, 23 May 2025 14:08:40 +0100
From: Simon Horman <horms@kernel.org>
To: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shuah@kernel.org, aconole@redhat.com, echaudro@redhat.com,
	i.maximets@ovn.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] selftests: net: fix spelling and grammar mistakes
Message-ID: <20250523130840.GT365796@horms.kernel.org>
References: <4f0d5c19-8358-4e5b-a8f0-3adcee34ffd4@linuxfoundation.org>
 <20250523022242.3518-1-praveen.balakrishnan@magd.ox.ac.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523022242.3518-1-praveen.balakrishnan@magd.ox.ac.uk>

On Fri, May 23, 2025 at 03:22:42AM +0100, Praveen Balakrishnan wrote:
> Fix several spelling and grammatical mistakes in output messages from
> the net selftests to improve readability.
> 
> Only the message strings for the test output have been modified. No
> changes to the functional logic of the tests have been made.
> 
> Signed-off-by: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
> ---
> Changes in v2:
> - Resending to full recipient list as requested by Shuah Khan. No code
>   changes since v1.

Thanks,

I agree these are all good improvements.

Reviewed-by: Simon Horman <horms@kernel.org>

