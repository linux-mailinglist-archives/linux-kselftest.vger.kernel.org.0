Return-Path: <linux-kselftest+bounces-29554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824A9A6BAFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 13:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314B319C15AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA098226D13;
	Fri, 21 Mar 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOYvqTnE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0EBCA5A;
	Fri, 21 Mar 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561127; cv=none; b=b7ylh6ePwPBW5ix9RBRUQscVcmv8GqXlH6ecm7iJ5iGepdnrF+BYnlo7llWuuTTUnAW9jvLqgQsm2jnC2smGu8vQpeRNZDQsNMFdyAI0HE+mnXML/BsHAKJsroOntkOzkfyZMpOFCB63fqAAl0BQVSaJk7FogvT+qUeN8+C3jBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561127; c=relaxed/simple;
	bh=owd4qIVO9vgaRMbapG447WdJfLBcEtmkQ1F85L/faoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3xDQL5tIhMA/flghCJCoGz17U30/0BSoBJRCnITXY6F+pWj3uJgdQ1NdtV1rkkHJOeNs4WSE6NRKJbIUG80QKYcosF1MMzQiK0k1NCgzV8KEcQoUP8AejgntmQdSf4ARqj+o2pWkgQRsTfKkwAuAdSXq8teCrHWDY6chBK08Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOYvqTnE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225b5448519so36244105ad.0;
        Fri, 21 Mar 2025 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742561125; x=1743165925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ri8DrHl9V+VnfdvMXOIXJllITyYvJjqgNAio1XrDnKs=;
        b=XOYvqTnEjp0Stkk3i4LDMpRrzIE2yepkbbVyg5Ktzag2pw8NnWwYVtIqRzWxPVX6+M
         gU0EbXf8u1b9lKhRRR7MoRlw67HLmdnFQhYjj6V87LeDF0LvEmt7on0H5wx0mN7KF16D
         1ZDgb6mkV8sFb4zqtGHiTMjOfZHqQHziSDhglTMArNVceKBbj9LYDkD2XNJpfO6pUZnv
         jfVZpmHMa6cfwDlwJ9/pIpCOx5XMF02pqmnQWFscFKm7TJGpW+df+ceXatiG89yz7D5U
         sm10kZlPE7yycxrp9BgYrG4RRRXdB/xaS1UFwbigsd/lBkHBTGYxGyZJqIi4cT5d2O2J
         h2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742561125; x=1743165925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri8DrHl9V+VnfdvMXOIXJllITyYvJjqgNAio1XrDnKs=;
        b=RqkvNxS1DuppDO3XLrctclqu1YE80K86xjdsNYOZxXmH8Qk9C/9io9xzRPg5AtHDy7
         b1w3BidQqg6qtybuKSZwS7mrTpTRbdGi3dOFfLOWzZ7pRvYbDExjasiOrKP7QVB8bjwA
         wA9LwNNCKFhvBdUisyFWPJYrogbaebqJLf2K/7o0JIPLGb0+r9SaYhCuoI5UVdUJ1zkb
         Oxv6KanaSEF4w4CeXdWDVzPsgcJFIgWuQhsAu0dnAf3U5UYc3cFTpqKdGrwrqzoq4oyX
         tCgzMe+Lc4/uE+qSf8mQMqlceY5/GKnM7axkrUT+NTGYSRdVW5KvYuIqkfoG8Pu3j+lk
         oFeA==
X-Forwarded-Encrypted: i=1; AJvYcCUP047vsNyz+TJxofNFpgsv2pAUzZM/VmsRi7qUI9P+buU3nXu7bW4gEBvce7Auc56ZAv0=@vger.kernel.org, AJvYcCVvSY+fWBYQ5j0GBjIJ7jrAkIFo84704Ko5ZYzxG+An1FwUXG7rdkETMKwLtfkVqlMu7oGxB+b8FWvSAiZu@vger.kernel.org, AJvYcCX4393e417JSqnO29WmOaWXNONpEqJLGHESPMzGTsNlILGirGhLvVg098k+hoVj6nHUjnLr1dqMUOCkYV+HtJPD@vger.kernel.org, AJvYcCXCeG5XKV/8vTTBI31vf5BuFJI9avoYcvVbZ7KvDJMbjLhySDrOUdyRc3WtRquvtUL8GiwHVZJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YyNuIA1/oafZoK5XgmmPJAUMJS4q/eAvacw31f31ciWxkK1YcM+
	3AxewEN44gloRJlroH5dl2s5Wei2mJpgqFgSKexkDuRJLR+fOhtq
X-Gm-Gg: ASbGncva8VQ9aPmMrqvxvm2auKXMP6Ank7sPBtKzpNqUG9EbUvA+Cty2HX1WWywczyU
	AOV5qeAj34Nfe5VPpGOMYp/bzV4sYAwOlwjexs+QJfi0053d7J1sHM6Hiyz5UJZ9ORR8M4GdZ6U
	zRqQ9kJLW426qBXB5RXBNm2dy+nsyXemcCxSpF1KKAupJj988RFrmYyvJFuLQtWikSHEx66B+Hb
	vUdI3vcqBdCplIaWYMLm8+Q2V081YvBDWhYemYEQvRw1TPSVdTDdNP4y2ts3BZ7Pp48S9KoBnfE
	JT6kAOBzL2l2bXvdmhauDoYGZx9aSI7f1bqsHA40BVRGvGEVZQ==
X-Google-Smtp-Source: AGHT+IELvK3I72iTUDDcO1O4UKhcvpwpm33sVFuK5wBfJpG1DU5drkzjkeA85Qr9LNOrEFCR0OcThg==
X-Received: by 2002:a17:902:c411:b0:224:1780:c1ec with SMTP id d9443c01a7336-22780e07b2dmr52456085ad.35.1742561125406;
        Fri, 21 Mar 2025 05:45:25 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811d9f0dsm15294545ad.165.2025.03.21.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:45:24 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:45:17 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Phil Sutter <phil@nwl.cc>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 RESEND net-next 2/2] selftests: wireguard: update to
 using nft for qemu test
Message-ID: <Z91fXURX3BQFDaq9@fedora>
References: <20250106081043.2073169-1-liuhangbin@gmail.com>
 <20250106081043.2073169-3-liuhangbin@gmail.com>
 <Z9rtrVk-15Ts_BNp@zx2c4.com>
 <Z91CGRP9QLdZONiZ@fedora>
 <Z91QshzKRlmPdpv7@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z91QshzKRlmPdpv7@orbyte.nwl.cc>

On Fri, Mar 21, 2025 at 12:42:42PM +0100, Phil Sutter wrote:
> Hi Hangbin,
> 
> On Fri, Mar 21, 2025 at 10:40:25AM +0000, Hangbin Liu wrote:
> > Hi Jason, Phil,
> > On Wed, Mar 19, 2025 at 05:15:41PM +0100, Jason A. Donenfeld wrote:
> > > On Mon, Jan 06, 2025 at 08:10:43AM +0000, Hangbin Liu wrote:
> > > > +	echo "file /bin/nft $(NFTABLES_PATH)/src/nft 755 0 0" >> $@
> > > > +	echo "file /lib/libmnl.so.0 $(TOOLCHAIN_PATH)/lib/libmnl.so.0 755 0 0" >> $@
> > > > +	echo "file /lib/libnftnl.so.11 $(TOOLCHAIN_PATH)/lib/libnftnl.so.11 755 0 0" >> $@
> > > 
> > > Can't these be statically linked into the nft binary?
> > 
> > If I omit these, I will got error like
> > 
> > mnl_attr_put: symbol not found
> > 
> > Even though I set `--enable-static` in nft build.
> > 
> > Do you know what's the reason?
> 
> I was able to have nft linked statically against built libmnl and
> libnftnl by passing '--disable-shared --enable-static' to configure
> calls of all three build systems. With --enable-shared in library
> configure calls, nftables build preferred to link against the DSOs and I
> did not find a way to change this.

The patch is using
"./configure --prefix=/ $(CROSS_COMPILE_FLAG) --enable-static \
--disable-shared --disable-debug --disable-man-doc --with-mini-gmp --without-cli"
to build nft.

I don't know why it's not linked static.

Thanks
Hangbin

