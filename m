Return-Path: <linux-kselftest+bounces-16471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCAF96195E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 23:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A700DB21791
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 21:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28C1D3631;
	Tue, 27 Aug 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sROgmd8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A376056;
	Tue, 27 Aug 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795090; cv=none; b=qrfqbrd67CHZ/tCLtnhojtjH/ihPl5krUDB8CFXZjnv4brv+J2M2VyUcc5IeY/V7AWz7+4VSS2EUbUE+CWDfFfftQpmQJcaDUSz+YA3KOZFzzwA+/wOFkIciiUWczdboSiT0XZ0YFfllluwZqd9UYchcyOjKUcgJ1z01hmnNfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795090; c=relaxed/simple;
	bh=U2sz/hFBHKZ7Q1bi4efWJ8xrKDEPk/xSIkvt7nQJU7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqjEn5toZ2niTqkiBTC4WzxHOBFWT5hGGeTw0N0NBah134qlCdXeMDtM35gyp/8H5+hakZ26O/UkRh70wMZpEBhXDmUQp76LGPnVh7HIA3BtT1mvAcduMAUcgeGIPs3YLLKmjZxQQpUyUMfiDed72CaiSWSHm9pVhQ+ZJfuWQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sROgmd8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB56AC4AF09;
	Tue, 27 Aug 2024 21:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724795090;
	bh=U2sz/hFBHKZ7Q1bi4efWJ8xrKDEPk/xSIkvt7nQJU7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sROgmd8yUWiirJphImEfmCLHCmchD3y+o6ztnlldiWnbtzQ8Mqh9lNNuesiYAynGs
	 WKt+EZtouPBe/NoNjjRzgN/IhknfypdsgjobB4Ebsmzi57AH0I5sRkZ+PRJZxEW9Dq
	 MokyXBz3PWVgTaNvYo7OR9eTFmqYCj7WKw7zuZlvOxWgGDBNgns45LJ+1FZQTIF3g1
	 mH0iYRMHBp+YgcZngKbQ0OKdbD66PjwuhaYl0NI1aBdJUJnu3mSeyRRo5zuD7WVc0Z
	 enD3Zs2gyABzBk8ECjY/9SmQ8qdnAodVFIDn7F8p/Gem5OkdbqNTN21WRjds5skikh
	 W4yV0PSLpbAzQ==
Date: Tue, 27 Aug 2024 14:44:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Hunter <david.hunter.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com,
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org
Subject: Re: [PATCH 1/1 V2] Selftests: net: Set executable bit for shell
 script
Message-ID: <20240827144448.64524df3@kernel.org>
In-Reply-To: <20240827213721.53379-1-david.hunter.linux@gmail.com>
References: <20240826144022.72a80d8c@kernel.org>
	<20240827213721.53379-1-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 17:37:21 -0400 David Hunter wrote:
> On  Mon, 26 Aug 2024 14:40:22 -0700 Jakub Kicinski wrote:
> > What is linux_mainline and how does one download from it?  
> 
> The Linux Mainline source files can be downloaded using the following command:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux_mainline
> 
> I meant to say "Linux Mainline". In my computer, I put the title for
> the directory as "linux_mainline", so I have a habit of putting the
> underscore when I should not. 

I see. But going back to the commit message - why would the files be
skipped? At some point you shared a warning which gets printed:

 # Warning: file test_ingress_egress_chaining.sh is not executable

that's a better thing to put in the commit message, than talking 
about downloading.

Keep in mind you need to put a space or two before the # otherwise
git will think it's a comment.

