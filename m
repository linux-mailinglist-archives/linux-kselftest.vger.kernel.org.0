Return-Path: <linux-kselftest+bounces-40414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F309BB3DE96
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF76201730
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5148F30BB8D;
	Mon,  1 Sep 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htlBgijE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF312FB986;
	Mon,  1 Sep 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718976; cv=none; b=in1zfhCpCjpLKEwk2eAJ3Vto/qtMxjnjl10yGkzdaDWPKwN6OqKDY4H06ILYJ9mb1T/UZ22l0tRgUpq8IVJKpMzhaXRXxsTtgMgovA+mL2rA/BRCl+lkBAeahJodjFuR06paN5SMxWOy7sPxTBkaXYComGiprEdeVbZxBdNQf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718976; c=relaxed/simple;
	bh=uz12qVgz0O6jwygjA3gniSLgHG81f9+byrwSrrDaeEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVB40p5MAdvpWVAeg/wHv0Ms202pI8qHatabyyUAkW+R5bOFFDlAgB8BK6EpJ45QTyMmSI7UdRBWfbbA2gQc3yLQbx2Nne/aqG9vPf0p9lcY8tsxxsnyJO7aRWHM1iLnWOfQr+YHZND+TkaFnChjKfcoxLu+8FwVVYJcZg8i/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htlBgijE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-771fa8e4190so2646116b3a.1;
        Mon, 01 Sep 2025 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756718974; x=1757323774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PXHLM5OpMogL2M5B4YLeTjEVKoKX+6lorFe4ipT8fk=;
        b=htlBgijEFE8j2ltapIkDX1dTfMrZOjHBUMRsY5A4c38FAwfJ3oJpsj0/JvUjNBCu2c
         xuRmszLh8bwH8IYMV36ZeSAsbhoa/djZsTO2Sk4tw3BoMcUBix9zYEZyQTzMLMXs3GqD
         KbRf3cd7fgqXxJwtLqlcISUbo0JCWJM+X0iN5M94yp46ekal16nMMXj+OusUFX3Tycyc
         2J6t44rXEnEgPAsJax5KLQlxjLy+vL5yvuGPgtS9CtD+99P4TJNzqo4kFbJqjjQi/q+8
         bKLegAEHx9dj8AXs2ePMj1CM0FjKTLRGaYulx3j2TsNiimL5MpIPKWz6TnpRs+XooREb
         ecdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718974; x=1757323774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PXHLM5OpMogL2M5B4YLeTjEVKoKX+6lorFe4ipT8fk=;
        b=qBw/bBHlVA/wFGV9q6W4NOBychxwuUex/LW0sddXav5/bsL+BLVh6PIhkpW1FpHAeE
         lWK9Fr6a0OOvLM2KthEvUzdDBzO4Kf5jAvf6JzjlcwW4ULtvZRqDMYNJdufICpTDLwMu
         IFNuHRI8/+2KbyNUL+lOXzPk8LgTSt3QxhLpWsg7nG1u+IRyv+8lRRKbzSGIzgDi6dQ2
         rsVFn+X7yryfYhd0yJKtNa+6EJt4WPjmuxJ48Y46aIYvKaADFTeyETJXNJYGmUezwfbc
         p2Jbt7XQAL7IG8BT+DeSoq72qNBKLcmSdfDgQqPYGczzhnTNEiruBgLx/Hb+Aoc0Y4pW
         +u8A==
X-Forwarded-Encrypted: i=1; AJvYcCV8uP3m9v42zkQ+9j9KdnhDJTR56Gm8ybXSDCK4NOkTmJ5xeaiS912kP/4xzGq1HF3zUQoXbJ2tYIfeILI0UcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8g7pabG0GfKHCHZHx0Ue4nnM0+s5a/FOb8d85B0eSRfQg1LdS
	llE5h41i/QK419dM7afUDWX15f7/4JRf9uU6XNVlYqjPu5TgupluwmeD
X-Gm-Gg: ASbGncswsMANNO5UNwuVdOIv23OHDdvmwefd+NaDCqPNhXueSzpCkASF6jJnWtaL8zg
	bNyH9BigJRAmwPfcnVMLep5aFcvJX30motIJLouM6AXr0CPfawRAyln79DBDEmS6AD0k1M0CUCE
	pyfiiVzcu16qqhimdOa08MGDzWfkWT4CT9ajseQASgYv59zRYQDIrMUtyI9aCHPuI/j/WIIRlgh
	XGRv11JOyid/q+QC3J3J2T9lmcDIC779OiPT40jIYhU4hXXN2lxNBnxB5fGJWd1NE+urggPVYlV
	lxtGJe514NtAMTlquHYRDHHhfu16C9IZzC5MLYVNqyPC0sJwBLjUVh4EDCD0eC69fQFhrPde8wD
	VEkKmHwkUoLQtxdlQeZHBXstbgiY=
X-Google-Smtp-Source: AGHT+IFX4ZU89Bc65QPsiJNa006dpfPFfoE8Cn6iBBzDXZp0agsnMmjjVtbS9GaQuT0/35gIrT3m4g==
X-Received: by 2002:a05:6a00:398c:b0:772:10e0:dc41 with SMTP id d2e1a72fcca58-7723e309f8dmr9034760b3a.15.1756718973924;
        Mon, 01 Sep 2025 02:29:33 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm10124747b3a.92.2025.09.01.02.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:29:33 -0700 (PDT)
Date: Mon, 1 Sep 2025 09:29:24 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aLVndADX4_nffUN5@fedora>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-6-liuhangbin@gmail.com>
 <aLRvoV33kUnzk_68@shredder>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLRvoV33kUnzk_68@shredder>

On Sun, Aug 31, 2025 at 06:52:01PM +0300, Ido Schimmel wrote:
> On Fri, Aug 29, 2025 at 09:54:30AM +0000, Hangbin Liu wrote:
> > make sure the virtual interface offload setting is correct after
> > changing lower devices.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  tools/testing/selftests/net/config          |   2 +
> >  tools/testing/selftests/net/vdev_offload.sh | 174 ++++++++++++++++++++
> >  2 files changed, 176 insertions(+)
> >  create mode 100755 tools/testing/selftests/net/vdev_offload.sh
> 
> Need to add to the Makefile

Sigh, I already added it to Makefile in my local branch, but forgot to
re-format-patch. Thanks for catching it.

> > +	# Common features
> > +	# NETIF_F_SG: tx-scatter-gather
> > +	ip netns exec "$ns" ethtool -K "$dev" tx-scatter-gather "$state" &> /dev/null
> 
> Why the redirection here? I don't see it in other places

When I tested local, I got message like

Actual changes:
tx-scatter-gather: on
tx-generic-segmentation: on [not requested]
tx-tcp-segmentation: on [not requested]
tx-tcp-ecn-segmentation: on [not requested]
tx-tcp-mangleid-segmentation: on [not requested]
tx-tcp6-segmentation: on [not requested]

So I redirected the log.

> > +do_test()
> > +{
> > +	local dev=$1
> 
> IMO, it makes more sense to put "RET=0" in the same function that calls
> log_test() (like you have it in check_xfrm()), so I would put it here...
> 
> > +	set_offload veth0 "on"
> > +	set_offload veth1 "on"
> > +	check_offload "$dev" "true"
> > +	log_test "$dev" "enable offload"
> > +
> 
> ... and here (instead of in check_offload())

OK, I will

Thanks
Hangbin

