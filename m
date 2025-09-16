Return-Path: <linux-kselftest+bounces-41559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA7B58C18
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 04:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9061BC42BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6385623BCEE;
	Tue, 16 Sep 2025 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxEVaw8b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4605239E9E
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991520; cv=none; b=fwpJsiUKi8XTvGCmh64IVIVJEBEzCJe5Y91L9Mecc4n/s5QVEkizDVDmw99pVB9+mI+XiY331AN8Oy1xfQyl8x+UCbCsLJuDF5+3lLsGWXUSKAdqe89nLqC3CzFFQHRV5O2124ev3UpFvGREwOVXbbCTneF1kriJ8afwiEsiVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991520; c=relaxed/simple;
	bh=7XO66tFZ7sDtnbhU8FMTHuC7bAcZAOuj24LDeP0n+JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJYH1nSh/8UK2V3tlO+dSaHRPVRO28Aq3U2N6kqt06MwPSQrVzDQNShBkTNxzg9DIciWIwxMt3Zc++4gXHP0mTXMKZxo5aUclD+jp42kyxVEgj1BCqgcl+0jBOK4FbEPyx5PHn4E0Y5bN0QJyxISnIW//uFm0YkSllxWZRqncd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxEVaw8b; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26505197a58so14282585ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757991518; x=1758596318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQgTdWvdAbQBkxXTr6NMR0psWz9YegO9W+coZ5goAHs=;
        b=kxEVaw8bf9vuBlp2ZbMHx8xvRrOnKLl+SRELST874YRW/9R3lKOjE/oU/DTMwJGFyy
         5JWfUEs3HyfDMASVLzU89WA3Rvf1zazHsutNSDv6IvGT8tHh8Y6Ce7sV+U6aR3i+nILF
         OoHJs3AaXDfhtTWQMWQFVho3Gn1UTBFbe4A5FYns3rHUiZWnj2DIqBSybEOW0aKF3Byq
         kJ06WrhU+MM6j+8SdWeELVVLnmSaSQchi4RyNLXRfU9W6v3biM6PJN5B7sivChPDJGLs
         ugt56e6+7MwX4UVxcJQjL2Lq0Doz0W4sXWs7eTI1VbUCpeMJdpdzavEZB9kRnAhPDo4q
         r8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757991518; x=1758596318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQgTdWvdAbQBkxXTr6NMR0psWz9YegO9W+coZ5goAHs=;
        b=ZzaNl0UKAAI8fx1eWoxjju9aEA+QawsSuBzhX2hMtV/b/oyeK/a3m85E9J+EobRaiP
         63vY55KSuX/cyONv8RZUKosHUjDNJQJndcz+pD9G5e2x2qAaKGaYBtm+nr9stT/DDgjv
         61VIizAZAraAxGwgTXMiJRl+0l2LWhhZ7soyG6scBo516caQKSZOEOC2Or+bca7f7yN9
         iWyeulz0h6Z6CAQxry+wFsavgW8FoPivK+Xetz1RryIsiSZPmi56aZhnZu2fmfD0c7LX
         iVHDddqehkaE9e+STgLSPeKTW1nJMJnShCdx39/Lvt/9JAcnvnURBjTR27Taz4/wwl/9
         df7g==
X-Forwarded-Encrypted: i=1; AJvYcCXWAdl0W/001nx+VPs44tVvZjO2v3TxUydwj/Me85v/S1FNbI1D2UIBx46dJr2einK5Wjwc5E91GZWCh2ujb8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+7XMV2479zpDfLKZF/TN/GE1gs6C9IFP6YrjXy3DKht5PZi5
	A6Bk+/CAFDuffUwuqSt2DJmFItfqza80jSFudcncxS0XBDy5I/hHY+y6
X-Gm-Gg: ASbGncuNsXgijOnw+ZA9bJRwQeJoYUekhrGzi/Cqwhbef9ipfYp8W1vQbicmbff3DCa
	2I37I2wBInvp+XpYVjg3gmwyNmIexPHx3MkSBpTt4m8G7xe27HEkhFvUvKbtnXgBwlpAAQ4W1io
	mFLXxxAbtFvvvAukA1XtOYd81EJ+PX4TwJeAafnK7yyzTL1W0cW11ruIhVQospJDW2035DbZt/p
	TUjEMV3mZHWxPkqc4MnBnyhYu10KkN1tr4HGEQS5bB4T46qc0sffW9AcoI1sEA8jG54kOxd2pkH
	EaNnHb2CFGM60sco2FFsW6+k83Wkags9LGzAP+rH6DDQj7+EsrL63Ey/cOegPyOlRwAHYx38hrf
	Mn/bKk4y1lTHC5vpvzC7Nmth7k6H/F05xUvsEcw==
X-Google-Smtp-Source: AGHT+IEpu9RPplREq+3dMnA9cO4wkDr5H7kfF9jU5qM/IUS4/1bFfNRe4izqZKvwQuiVIt05YcDmPQ==
X-Received: by 2002:a17:903:388b:b0:250:6d0e:1e40 with SMTP id d9443c01a7336-25d242f2f14mr151186285ad.7.1757991518269;
        Mon, 15 Sep 2025 19:58:38 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b0bbabe6sm22016895ad.107.2025.09.15.19.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 19:58:37 -0700 (PDT)
Date: Tue, 16 Sep 2025 02:58:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bonding: fix xfrm offload feature setup on
 active-backup mode
Message-ID: <aMjSVwIv7f9VDvHL@fedora>
References: <20250915083742.423741-1-liuhangbin@gmail.com>
 <20250915184123.505d2bb8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915184123.505d2bb8@kernel.org>

On Mon, Sep 15, 2025 at 06:41:23PM -0700, Jakub Kicinski wrote:
> On Mon, 15 Sep 2025 08:37:41 +0000 Hangbin Liu wrote:
> > The active-backup bonding mode supports XFRM ESP offload. However, when
> > a bond is added using command like `ip link add bond0 type bond mode 1
> > miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
> > disabled. This occurs because, in bond_newlink(), we change bond link
> > first and register bond device later. So the XFRM feature update in
> > bond_option_mode_set() is not called as the bond device is not yet
> > registered, leading to the offload feature not being set successfully.
> > 
> > To resolve this issue, we can modify the code order in bond_newlink() to
> > ensure that the bond device is registered first before changing the bond
> > link parameters. This change will allow the XFRM ESP offload feature to be
> > correctly enabled.
> 
> This reportedly doesn't apply.. I suppose we want it to go via net?

Ah, yes. I forgot to add the target repo. I need to write a git format-patch
wrapper to remind me adding it...

Regards
Hangbin

