Return-Path: <linux-kselftest+bounces-29548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED44CA6B8ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 11:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B10E484BCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41C21C9F2;
	Fri, 21 Mar 2025 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TETQ1dQm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E916214A74;
	Fri, 21 Mar 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553635; cv=none; b=pM6uFmIe/f7xmRydYxAvkrm4es7q3yM7c4QY9+wnoNDcqyi6sjzdv6U6bHCFqhLIpRl0fZyHpWPpsjUelvqP8may9dkqvx8U4Lj4potBspW6iWxPgeOewh2uxP47x1Il8WjX2tiq3+afDbNOi97xGPyi2JlBX5B/4rcWdrtR1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553635; c=relaxed/simple;
	bh=Iue1Lgh81S/J+D/jTnJX8H2KzZOJHRiThoffvR/VuQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ujq0BIf8NIwFz7R4tJ/uWRvJzsUZJXR7eE+5jgEJMMHSC/RIOQma2dr/KxDOgHRiXYZ/Xy7z715zl/goQwnfDhemYTu8RWsS0yy1JlJaEt4gMuy05BnleohUQBdxkVX0q34tFAIja6cZJG3dHkJvmwRNYDm3NnZGYivdI8wqdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TETQ1dQm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22438c356c8so34256025ad.1;
        Fri, 21 Mar 2025 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742553633; x=1743158433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGN8+jyuXdIKgFC5SmamsVca/i/p3bqkMBsaF9BgFCA=;
        b=TETQ1dQmGc5fyWDQ0AoFdS/VJ3B+DFzmyAw9LqCr6uFECaH/Ik0bn42y6tf4n3BCK6
         dN4P/zw7kfCmn2j+zevxRcPwpyURew/cvGXcdxbG8RWHN31Bg52GfO0IcayupPCI0mlK
         ZJbCvE/9S6nV9LMHe6esrunMEn7I1TTyGyBKc8TbAuyIefRknZr4dPQBK0WBFwXSUTDA
         l3i1YLdsdbHKJ84ms4EAYxnuaO4++2U03Zlbjcp0EoQq3pxwPn1WFmueOQp5Vn5Kcce4
         1zPG68hPIa2IeAO9DNDQgbZbPELiDHDhdXY8L2od55E8yV0an2EtQNFb8Y2JJjA6tI2q
         4I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742553633; x=1743158433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGN8+jyuXdIKgFC5SmamsVca/i/p3bqkMBsaF9BgFCA=;
        b=JVtn8KCJXnRrb6Dxjf7K+K7LV0aYUn2rHR0i4c9i+lEaiFAAOjQ16n4BCcPmpTkIol
         esJuD/pXBov1dk1h9IC37NzJtKkNaH4MV/BgJNDiosNN8O0yMfhnKy5LuvatCXjlYbyf
         eV6ytwWk+dgsAZRXZVDW6jejguYLELIsxE2VUClf4lbLr16ZE6uO+rnv7TCuor9mWbC9
         5ioDyn2++cNAnioxkKnBxIsrFv5dhRDpIpoGiZlRxOzAys7AJl4Btu/w5WXbYeDxScs9
         U4Zn8ytTvbYWfQTSjV7tduuCWsTFPca+OK5Phz3Yxv/ZGtz56NvDr9p1bCWpOFyiE3TS
         vJeg==
X-Forwarded-Encrypted: i=1; AJvYcCU9R7zOH6agFnsETQzrxGIBZ65IS7gXG2HBqUZ9IZ+eCGSiDEibFvpNHqDm2X4yDg8oBQU=@vger.kernel.org, AJvYcCVBr2eF+finjnVXdcNXY/HIRWSsA9902s0FQeLVbFS3OnuuPDtPO9SI2yABXKYszNyWSXZ+xFdenxls3MoO@vger.kernel.org, AJvYcCXNJv/rt61AjdOB6Xe72/XwPTUo6FfhhCjaPQRzX+rNFBbkUBrk+SzHd+BTYKfVP++Mxl4K4Z/6ldjRwCTp2SrZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwbEw53wIrXi1fAed1QDWmhOlQ7WvyIA1DRE2zFusgcElgNFP34
	fqh/UEv2B/Uw5h+XngfQpOq8eJ8ySjWxm6cgJIHK+iCPiNRTaLPl
X-Gm-Gg: ASbGncs7W13o91wPJ4P0HUslLPZm5tLQNwFmTQnfBy9YnyEkMbyRIPdw3LE16RMVG2M
	uH/mJRWSN3IQ6YOL3/4Cp6sSnsLRklNeSUW60tXdYSBb7rAK2MvTAgcNFPny6D2KApI34i4H8MV
	8tVuYZb3C3PlAlJ6uL6zaP2FEFgCmGtnAAIrYMBfMR3s+qiU8RkjyGgaLl7VYzG6+XYLKMu/olo
	3GnrmV6/M2pnMeZUBubm8zAuLKQBlLHx5M1Ywp+dwJw4oTtSuAXHDcazSh/KHj7ardM8Re/jCWC
	h/EZjLvOStExmK/S4r2QRb3jBv5IbGGztLzmQwhEDVtS8p4C5Q==
X-Google-Smtp-Source: AGHT+IE5d61IKdQUVqIuK3tZPZAqsdBa4ZBvtIiT+3a8/1I1RIjBnF97317bCAJX5B/9SMIXdU1Dcw==
X-Received: by 2002:a17:902:d484:b0:223:6657:5003 with SMTP id d9443c01a7336-22780e121cemr46814965ad.32.1742553632721;
        Fri, 21 Mar 2025 03:40:32 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b40esm13292215ad.12.2025.03.21.03.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:40:32 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:40:25 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Phil Sutter <phil@nwl.cc>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 RESEND net-next 2/2] selftests: wireguard: update to
 using nft for qemu test
Message-ID: <Z91CGRP9QLdZONiZ@fedora>
References: <20250106081043.2073169-1-liuhangbin@gmail.com>
 <20250106081043.2073169-3-liuhangbin@gmail.com>
 <Z9rtrVk-15Ts_BNp@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rtrVk-15Ts_BNp@zx2c4.com>

Hi Jason, Phil,
On Wed, Mar 19, 2025 at 05:15:41PM +0100, Jason A. Donenfeld wrote:
> On Mon, Jan 06, 2025 at 08:10:43AM +0000, Hangbin Liu wrote:
> > +	echo "file /bin/nft $(NFTABLES_PATH)/src/nft 755 0 0" >> $@
> > +	echo "file /lib/libmnl.so.0 $(TOOLCHAIN_PATH)/lib/libmnl.so.0 755 0 0" >> $@
> > +	echo "file /lib/libnftnl.so.11 $(TOOLCHAIN_PATH)/lib/libnftnl.so.11 755 0 0" >> $@
> 
> Can't these be statically linked into the nft binary?

If I omit these, I will got error like

mnl_attr_put: symbol not found

Even though I set `--enable-static` in nft build.

Do you know what's the reason?

Thanks
Hangbin

