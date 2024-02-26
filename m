Return-Path: <linux-kselftest+bounces-5443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CB3867BF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 17:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E37B2F7FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA6412DD9A;
	Mon, 26 Feb 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zYEG/ovZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F3127B4D
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964867; cv=none; b=u9E5ueJ2nusZVJ3ATKASGWJAqelCcZfqZXDqFZhepxnvQQ/c3ONANZrmQtF1utKnr8oexmS0GtbSBnY5uXvPFOK83d+jMnS/zRXBQwwfp+g0FewFNo05+NXkIDXKi8styKBvtP/rpQ7pR40uTmOusuC5uxlyAappx/vo+bW6OLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964867; c=relaxed/simple;
	bh=9oIJaUSzzlfVyV6JEd/5V+zZ2B5DVJZOSdtTGUS1/DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFbDk5A29Su35LvMQWBGk07cCDzWndVBPLZcUuoeUuzF8P8TxMn2TTDTBoyKX7lPFWH6w5c2/drsMFBaMCYtMOkjwgu9FKOmi8sPwsS3RtXVG+toQgbWgF3SyX5OrunNvwqs7mAA+c9PBrb6BMj56kO5l8YlyRLq9AfGahM5COo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zYEG/ovZ; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tk5ct5KzYz7kl;
	Mon, 26 Feb 2024 17:27:42 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tk5ct1T5kz8JZ;
	Mon, 26 Feb 2024 17:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708964862;
	bh=9oIJaUSzzlfVyV6JEd/5V+zZ2B5DVJZOSdtTGUS1/DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zYEG/ovZoEHk3G1dlz0YQyNIvsDRQNqe1gt7Eygn5EZTGo/wfWYNkmjzUjcQH+O4R
	 VfG5q3Dg5EQWoAcyg206oeap9fRk/sYXi9hYZfN/RdGPsLklur7SCsUJ4ZlVub3DGM
	 aecKX9zgbRozPacZWnTWRb2BqG3CgpKZrkO7qE8g=
Date: Mon, 26 Feb 2024 17:27:34 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 00/11] selftests: kselftest_harness: support
 using xfail
Message-ID: <20240226.Juthoojee3qu@digikod.net>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240223160259.22c61d1e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223160259.22c61d1e@kernel.org>
X-Infomaniak-Routing: alpha

On Fri, Feb 23, 2024 at 04:02:59PM -0800, Jakub Kicinski wrote:
> On Tue, 20 Feb 2024 11:22:24 -0800 Jakub Kicinski wrote:
> > When running selftests for our subsystem in our CI we'd like all
> > tests to pass. Currently some tests use SKIP for cases they
> > expect to fail, because the kselftest_harness limits the return
> > codes to pass/fail/skip.
> > 
> > Clean up and support the use of the full range of ksft exit codes
> > under kselftest_harness.
> > 
> > Merge plan is to put it on top of -rc4 and merge into net-next.
> > That way others should be able to pull the patches without
> > any networking changes.
> 
> Hi Mickaël,
> 
> would you be able to take a look at those changes? landlock seems to be
> the sole user of the "no_print" functionality in the selftest harness.
> If the patches look good I'll create a branch based on Linus's tree
> so that anyone interested can pull the changes in..

Hi Jakub,

I missed your patches before this series.  I just sent two patches to
clean things up before you change them.  This should simplify your
patches and improve the overall maintenance.  I'd appreciate if you
rebase on top of them.

Regards,
 Mickaël

