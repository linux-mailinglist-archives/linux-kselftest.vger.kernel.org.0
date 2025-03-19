Return-Path: <linux-kselftest+bounces-29443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173AA6946C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 17:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E593B41E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6280B1DE4C9;
	Wed, 19 Mar 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CnCS2q8o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318512FC23;
	Wed, 19 Mar 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400687; cv=none; b=usuVlxZGsSzqnENALmN0F/wzQIyzx9uCtssb89BnlDAg4lnOtOy79iX3tvbGLY/fIKMydvnmjzHyyldKrGDQ7RLRbXa3/wl5xAVdh2fBqPIh8WwxEcITEk5fsqnrvMao0nBaFuCSBqUBtaWffoyveZVnMVFexbVKhwICC6oe+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400687; c=relaxed/simple;
	bh=VDkBk/j04kXLeyvA6lN60b7KihgDdLwHGTgbU7i+46E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARxCrcUrcl3cqP52ec6lTWubRkoYS/Z8KASR11ZFr3qso985pqjPvCwk8UDjMHjkiCHcdiuIEB1UByxdt7CJ4eE3sZRpYgoNRpXr1mSTK4QQJRspwDkPy2Zz9rXHekOKoduDMlgurWn4kwG9KXZPGv8jmfi1Yzm8XkkPhE8+Tss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=CnCS2q8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866AFC4CEE4;
	Wed, 19 Mar 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CnCS2q8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1742400684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VDkBk/j04kXLeyvA6lN60b7KihgDdLwHGTgbU7i+46E=;
	b=CnCS2q8o/i98SzZA+D8yIzi3hVmzwoySHEgmpMNVaOmlgs3gF6b7K5KkmMSQDbJq/ZZr/l
	d6vuwH7JLEna8Jj2xN2VipgfhO02KCAg4cB0yF5uKlZA+XcDGwLk46Sgurd5fZaPCyGRwS
	IuR0jCJYEbcCpWP4Vspy/venyTuNZ4s=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0ee6c8fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 16:11:22 +0000 (UTC)
Date: Wed, 19 Mar 2025 17:11:15 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>, Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 RESEND net-next 0/2] selftests: wireguards: use
 nftables for testing
Message-ID: <Z9rso2MXYBFGnJYl@zx2c4.com>
References: <20250106081043.2073169-1-liuhangbin@gmail.com>
 <Z9lJ6PXHeL7tfhUf@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9lJ6PXHeL7tfhUf@fedora>

On Tue, Mar 18, 2025 at 10:24:40AM +0000, Hangbin Liu wrote:
> I saw the patch status[1] is still "Awaiting Upstream".
> Is there anything I need to do?

I'm looking at it now, but the subject line of your series says,
"selftests: wireguards: " which is really not the same as all the other
patches that touch these files.

Jason

