Return-Path: <linux-kselftest+bounces-33408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B58ABE016
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483271BC1267
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36EC27AC48;
	Tue, 20 May 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTzflJx9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378C270EB9;
	Tue, 20 May 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757374; cv=none; b=DNa9BFHLqMzIf2W95iuifzUW1ZGMKSiQ7Pa4yriNLVRqrGfEZpfgIzqr/DxbHxn2xSazbLzP497+Sm5qPWJOJkwiVxeqbT22/uZ2TzzsNyeNKMVz9aNnbF8JTHl1sxbCcaxwEWQ3d0p9Db+NPjWBk3HUTq+v+m+umMWf8V04oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757374; c=relaxed/simple;
	bh=4Y7jAPvp7RkAHwsvtdLYvU0N11A+iSh5DBiVZdL5nDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy4OoJ7oOXUwbAYMHZJmxfqosU2BKBOyvOrbvMEn6oDlAIp61MxM/3Istyh7trSwTPyQL7+iuumyiXEX3umO6xtqwHH5syZAuKswn0q1re4/WTVC4xapCMn4isajYj7+lCBUrlCSMyQ2CrNMv+egWNh3Mcs4LQyD72LIv0hY9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTzflJx9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e331215dbso51344175ad.1;
        Tue, 20 May 2025 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747757372; x=1748362172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJbvV7JdvyCORj2i+In/wTPSbv06vMfn69rfjvMw4mk=;
        b=MTzflJx9GLRoWagcwd3adrsn4gFwLPpBiJcPlHGmobTgCumBNcA4GcEmPkOr2y2aLp
         Mh/dM6rB64YUc5aReX1UyGDz74ekVoPxTDV6SiSbww1UNBKXC7R/EDtCRPublI3PYHRx
         eLpov20DYmxdHyMt8PY6KgmJ9hIiRdPybqqa4EQWkeYMOePG6118YMfz1x54pgoxBeDd
         omXEsai3R4qBwcFMNKvvZSWSlZOmnO70s0YceO3EfXI4pdhYfgnmzik5VkpW6PAjRr8n
         M3odeziKSUCZvpbRrS8AMiYmdQDZ66O0Qrzp2CkGTS0U8XpLiiK1CSZaT6rgkvuZqTNW
         gVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757372; x=1748362172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJbvV7JdvyCORj2i+In/wTPSbv06vMfn69rfjvMw4mk=;
        b=UcPXyJm7pwOlwnF/HVDjDhcurNLKD1Vy1dEUOrYNOaKaAkzTPtPscb1fBo3s4DBItA
         b7gtefMuOT4KvXXZsC2bm65f/SqMBEahbobvmi7cB6Yz5o5EeOI69CV+eiY0+a+pc/Ka
         1ilbG8hgfJ4PNMySfBNinh4PsbcoAG44NRGhE8Jx5orkV6vJJRHjO1kS2PKDVqL8oiV+
         oXu4SZnAe+Sk60ObMnMlebn3gwXJPcz4PEjWU+92LdUQLd697N1MU6++F3MGlub4Gdjt
         QhKpFNa1P1PMejC4tSWsuggaAq0MMwE4vw+dUNT9FYn6PRPQFRpmb5Qw4wLGPpldkggi
         34zA==
X-Forwarded-Encrypted: i=1; AJvYcCU+5fbSISBJLOuZSrOeCdo5jcTgPugFc8/jCEpORg3B7VZHsRTTQYclf550KCQIKYyeb7zV2LRU@vger.kernel.org, AJvYcCUEd8EnJ6tQ0hsrsce8vljWISYzpWMiYuNyF+m71nGXuL8INrfrElPXFYNh/UgD4IwN9U5rNakfGK4NDzbR@vger.kernel.org, AJvYcCVftlj1e+5Q+WPc/OiY6TOt/EG7QL/BmPkxVfYX2w7kM1vy5i17fmwDKYgYrBjR1vV7ESE1maQykii07Sui7MQE@vger.kernel.org, AJvYcCXalzYwQMmyO/LmbF4vdOQuKTMWut5e3VVd8Xn6G3jZa4LSek5ZpNh1SWa2EgzxXGc5DMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYy7E0c+rrb88i9wOX5gHD/rsDYJuoJBaiwhtK5YGeESxrmNK
	Xi4K5rS0+LMp2W3YvePewCTPKL36lMRT0kOaCaUddqteWDVTS96w77Qp
X-Gm-Gg: ASbGnct1//Z/eJpd05e//SgQRcBj8MNewNJQ5AWKxc03cZRkkMNsZDUzgCe7/Y+XSNe
	RyqPXRtw+Bdn6O7zVjaWtGH0v5NXunRyxoRa+0RlxzTMONrD9+m/Vrm2yXI+e+6V/J84EgxInfu
	9ZrcSTumFHqR1k6X4IfhJFzX4ciu4Jw2o2U9iIjgmvjdF67Y8Z+0yw3mWxMBxmohn/p0cfNd6So
	azFRRUrZy5SGMNxRzYmtQtGi718Uk0IwRftEQ/WU/Fa/f7bunwM7A3o3G8pFz8ThCcM0bUqv8sj
	qhPWt2pM2agk0sa3nM3JqZFQ7gubb2ksWCnulqnL+It+KHKaW0YO3QIKncbPREfY9mEfQlo+
X-Google-Smtp-Source: AGHT+IEz0kuJ8dqHy5xsovdOQCep+1sxQFLFFXzvnTwQtTvX+/bZldVprSyeTrsT6Ae+mpDb+9592g==
X-Received: by 2002:a17:903:187:b0:231:9817:6ec1 with SMTP id d9443c01a7336-231d4e55359mr236562605ad.17.1747757372052;
        Tue, 20 May 2025 09:09:32 -0700 (PDT)
Received: from devbig793.prn5.facebook.com ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba368sm78700895ad.200.2025.05.20.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:09:31 -0700 (PDT)
Date: Tue, 20 May 2025 09:09:28 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <aCypOHoB4fxHW/Di@devbig793.prn5.facebook.com>
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <0d3a3a42-4141-4c4d-b25a-3c9181d5842e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3a3a42-4141-4c4d-b25a-3c9181d5842e@redhat.com>

On Tue, May 20, 2025 at 01:24:43PM +0200, Paolo Abeni wrote:
> On 5/16/25 12:00 AM, Bobby Eshleman wrote:
> > +tap_prefix() {
> > +	sed -e "s/^/${TAP_PREFIX}/"
> > +}
> 
> I think there is no need to the tap prefix to the output you intend to
> 'comment out', the kselftest infra should already add the tap prefix
> mark to each line generated by the test,
> 
> > +
> > +tap_output() {
> > +	if [[ ! -z "$TAP_PREFIX" ]]; then
> 
> AFAICS TAP_PREFIX is a not empty string constant, so this function is
> always a no op. If so it should be dropped.
> 
> Otherwise LGTM, thanks,
> 
> Paolo
> 

That sounds good to me. I originally copied that over from
mm/run_vmtests.sh because their they do have an option for disabling TAP
output (if running as non-kselftest)... but I didn't add the knob to do
that here and am not sure when that might be used so might as well
remove it.

I'll go ahead and remove all of the tap style output.

Best,
Bobby

