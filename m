Return-Path: <linux-kselftest+bounces-37962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A30B11480
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 01:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6857F5A1541
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 23:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE49241122;
	Thu, 24 Jul 2025 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTY4d9c2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599A22B8C5;
	Thu, 24 Jul 2025 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753399742; cv=none; b=Kz+ZD970v+uNSTrKeMBRuyTzQlddRYpL88OtaM1LnAuC7t0lKgQBIKUFmgYDe8C4GvrWLyK9fsWc0tGQ7oxoO48RSF/bPKeFgqewC+h80HBjSin9Yp0+inhEtakwKy7zVaMKUgWeNhAZa5r+SWrhBsxQbbPr7LaRe+bEEyxatz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753399742; c=relaxed/simple;
	bh=/vMI1gAbE14l/MD915CCScv7uo0GQ0QduZ103FVYc/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbr902o29F1rg4s0XGmNx9NUVZIrRcBYgwLJdWWaX7+kZCSsYSW5kVvkJHTWQmeXlChkm4HbzCCvWb1GrCPhnmAn3UWjiiW5HA6/+2kDlgh8MQcgPVEcBQO/zpn4E5033C5YR44uVtS0qlSfioSOdIbVbzltxsGcbMOSu7ZlkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTY4d9c2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CB0C4CEED;
	Thu, 24 Jul 2025 23:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753399741;
	bh=/vMI1gAbE14l/MD915CCScv7uo0GQ0QduZ103FVYc/c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HTY4d9c2+L7OJ0ETTjcxloKZZxO2B8QBJi+XCjb2cBI1nv+rHzcKuD4u13fRuoPdJ
	 jPAQ88snfAucp2vXqd1vIKOL3j6mpHa3/6kuEjh42CZmUGqcyAD9ojM6cfqHXxwg7Y
	 1eXMQ29t0mbjS00sbkq5y3a/QxaK1PFrUZef0lKtKv/IvI+/EVXL5se6oCV5Bdz/0X
	 HzE3VAzmuioGff1rlmD97uP7fXG0bL6B07Akpt5VzJtUe6fuWYzvxpT/Il163mwNXV
	 KltdCODsYbZIgLE7i294ixJC1QJ/4uIqkRTm1jkXe6NE7+l6SOA1e/8GfPkves1mAv
	 TK24/5Bg7uAFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 20A0CCE0ADE; Thu, 24 Jul 2025 16:29:01 -0700 (PDT)
Date: Thu, 24 Jul 2025 16:29:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/pidfd: Fix duplicate-symbol warnings for
 SCHED_ CPP symbols
Message-ID: <51840986-f959-4f71-9be6-75519d0a08f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5b53702c-0dab-46c4-9cb0-448b4da36c2e@paulmck-laptop>
 <f82e3092-31ab-4ceb-a51f-208d13e7b2ec@linuxfoundation.org>
 <dbb9ca63-15d5-4547-beb4-5c4044938967@paulmck-laptop>
 <cc7e4fe7-299f-4bf3-af46-df6551d61997@paulmck-laptop>
 <90c793c3-91fd-4808-8fea-cbd07d2098e0@linuxfoundation.org>
 <369df3d1-8d6f-4f69-840c-46619f7cdaf4@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <369df3d1-8d6f-4f69-840c-46619f7cdaf4@linuxfoundation.org>

On Thu, Jul 24, 2025 at 04:17:07PM -0600, Shuah Khan wrote:
> On 7/24/25 12:26, Shuah Khan wrote:
> > On 7/23/25 17:13, Paul E. McKenney wrote:
> > > The pidfd selftests run in userspace and include both userspace and kernel
> > > header files.  On some distros (for example, CentOS), this results in
> > > duplicate-symbol warnings in allmodconfig builds, while on other distros
> > > (for example, Ubuntu) it does not.
> > > 
> > > Therefore, use #undef to get rid of the userspace definitions in favor
> > > of the kernel definitions.
> > > 
> > > Other ways of handling this include splitting up the selftest code so
> > > that the userspace definitions go into one translation unit and the
> > > kernel definitions into another (which might or might not be feasible)
> > > or to adjust compiler command-line options to suppress the warnings
> > > (which might or might not be desirable).
> > > 
> > > [ paulmck: Apply Shuah Khan feedback. ]
> > 
> > Looks good to me.
> 
> I picked this up for Linux 6.17-rc1.

Thank you, Shuah!

							Thanx, Paul

