Return-Path: <linux-kselftest+bounces-42276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66951B9E126
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F337188BA6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 08:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F127467E;
	Thu, 25 Sep 2025 08:35:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D72727F0
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789301; cv=none; b=DFpKaKFhUX6p72HNXTCOP33mLbD0H+SwTxyVRG3ivtPeV9VjBGb6NM3OcM1GRvoy31JmGB7gB5iNm4hHCyn0r0edpS5/Mayb/d9WNHxMFezEnljE5i6gIPY+m+MCThkmowly0/1bRp3hu4VAdTEtzuuOqLudUdoM4awR2McKFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789301; c=relaxed/simple;
	bh=DJ1q9Crp31KPzDvdOQpVBt7D29LMFTTduJ+18kfO72k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUonjrKeqwLYiefb4pqA90DjsNjaPFRXtrEJDDOv+/k7DZii5aXZ0FHlRKfgKdp8XmeN1x4jjLhEBHGfC7oWl+k2fIbXaDjUI40AdZ6B393E8X6EAoh6N+yWjVBDGGc//jK0EWLzeHEBDLeNmdyg1GhNku2twk8F3V5/qV58VJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fc686dc41so580191a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 01:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758789298; x=1759394098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zDaJVs41LQUBnbqHVLMQ3tXnbakB9l6TXCCNtHO7SU=;
        b=mVAEOMvSOiETBsI093EKh88qO1TUg6q+VGPJ7e7eD47rVr9IqhsYkqAUiWlRV9aZjC
         atL+hn0lMXjZeuuyGyn6aYzhSvw9hu5PYDZT6pTadL64DpCJFiQYxhJhzo2wM8EezcDf
         nu7H+qbNORrcfBe6ux1wuDCvpKN2NzwyTbuzDA4dXspxhUx4XWGaP6PRbBXEyE6piCCr
         8R0eghtEilALdruIMDJ++2mnsfVCRguBOO8IP9JGpVXoujwCrRE3ctxSCJ3Dk8GjOlYX
         X1LZIR587QGf6HkVrCpMhHaB59xxSc+i8Kc6focghDbssXP6ccQmbeEzE/y5yX0ltIbQ
         sJYA==
X-Forwarded-Encrypted: i=1; AJvYcCU/HF1KH8VDKct76EITgQaeHBlZWZMblScYdnmUVOgzo/h72BPO5USINtnQ7U0HnDmix8dkS8LrTaR9u/KzKPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypYhBOzNEJq8LAKFj1Jo3t9t7nKCEgc5Wpgo+mVYic9aWOsnSY
	LcXiFqTki4Ym/nZoRBZEgqM/2/ebdTSeT0gmOsKUMgc+4XPz82/wZuvw
X-Gm-Gg: ASbGnctpBvhuwuzUMCPGamZqkWIRWL4jAizfodwYmRS5ZT3EUUmSWk3s0xiEn0ey4fB
	3SmG2cnCJkxr5WY4FXMJLXxvJMmVrYtTn3CQJtw5ZC3p7prOFVNd3BLiYf4R/ctjJvPWihxJQdo
	1mpCAi0tFha6SyYWuDzmrCCAXDHDMaR0O15HRx9EpcNJH03iu6kw9mWEGTR2WDtsLwo1/34iIQU
	r4PyiFZLdCPqq+f8plPknWNN+E5wrG0uMMrT7YbMQvxYhl/Galp4tgW/UxjHPHk8LM/1XfFXhx3
	z9lw3zz0Kzkcmq2335P/V33KIFQTU9WAsZFkwRR0EdgyvSruhkjBTQAL6lQpTFbZ/Q9cHlkZDMS
	3kNaABVagxGukCyS2pjK4UAE=
X-Google-Smtp-Source: AGHT+IFW24W7o3bTWAsFoY4rllK5I1ic/HQWQVPhMEjT8+gukUVi5DmlXH9g2CZqkSx3goPwUOEnOA==
X-Received: by 2002:a17:907:7f05:b0:b2f:faf6:dfad with SMTP id a640c23a62f3a-b34bc8766d0mr287556366b.48.1758789297677;
        Thu, 25 Sep 2025 01:34:57 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35448dfee7sm116570966b.63.2025.09.25.01.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 01:34:56 -0700 (PDT)
Date: Thu, 25 Sep 2025 01:34:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <iyeqx4bkzk7pha5neslqkey55ptjcrhn7sgairdpmzlf363b7q@ai474sr27tq3>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
 <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>
 <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>
 <dafma6drqvct4wlzcujoysnvjnk6c4ptib4tdtuqt73fcuc5op@efjjn5ajqwts>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dafma6drqvct4wlzcujoysnvjnk6c4ptib4tdtuqt73fcuc5op@efjjn5ajqwts>

On Wed, Sep 24, 2025 at 11:26:58PM +0100, Andre Carvalho wrote:
> Hi Breno,
> 
> On Wed, Sep 24, 2025 at 01:26:16AM -0700, Breno Leitao wrote:
> > The other option is to always populate the mac during netpoll setup and
> > then always resume based on mac. This seems a more precise resume.
> >
> > In this case, if the device goes to DEACTIVATED, then np.dev_mac will be
> > populated, and you only compare it to check if you want to resume it.
> 
> This sounds good to me. I've done some initial testing patching __netpoll_setup
> to always set np->dev_mac, changing maybe_resume_target to simply compare the
> mac as you suggested and seems like this approach works. 

Thanks. You probably want to clean the dev_mac once the is disabled for
such case. in other words, if user configured a target to be dev_name
bound, dev_mac might be NULL once the interface got disbled.

So, if user disable the interface, it should unbound from the mac. In
case the user re-enable it later, it needs to bind by dev_name instead
of dev_mac.

