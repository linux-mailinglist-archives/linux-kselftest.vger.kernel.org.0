Return-Path: <linux-kselftest+bounces-9264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA48B9C15
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 16:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502B6B214EA
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D113C690;
	Thu,  2 May 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVMXDmU1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6B12DDBF;
	Thu,  2 May 2024 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659154; cv=none; b=JZIcQ7MZzu/+iRVq34+LrBlF08wj08ai4DJ+Ysya+uaNuwABkrlpNc0FrzOo4I0zJbkPK/ArwrI3ilGF58bYxPvNc6EhA26HVe4XMpoTdrHWj9NT++9e2F6nvND5Uo3zbaFIEeebCYkSzDhxhXxMKIrH/a/O3f3xR9CswpZi+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659154; c=relaxed/simple;
	bh=APYmhw1izKZnLnWSVZlvp9Yc0FRlykckQXCKWnvWuPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSAvpSfx4VSMTj6yIvq/CXcbX9qLMLKE/5GUzBXGlarQyyUo6EjntSBpcaW3X7phVBaTJ/GP+0u/LgGIs30AQzUjd0Dh5P8tXy/Rs0c1hFToAXbDsOgUSqLJAU+v+C3t5Pi6YvDk4Ji3zYZY26YbX8taxbfTj1YK1tAeWSz6pEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVMXDmU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C481C113CC;
	Thu,  2 May 2024 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714659153;
	bh=APYmhw1izKZnLnWSVZlvp9Yc0FRlykckQXCKWnvWuPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVMXDmU1RJ+EhWd3nXOR9t3euMFo7lWLAeFcUtDGLEGe6kjYN5WMqknNpFiu3sAhN
	 WIQzcEoX139cAujwDFxwLcErn+d32M/CIbmAfZJ0tbVxlf3Yl0FZUzYAfRtSAEcXFE
	 1SZW59djndvAjYa3cJKOqUEVso+KnT9rJE/JB48Ds/eSF/F9ngAS7VVaG8M35dXA0G
	 Ec27tN7JMq2IUNmJgyjPxW3fafOUnFpVtFwOGwFXw4c9at0/kPqAwQ/hPGfV+vOkoe
	 4fAuNZVc2nqJU1/IkJ1ENxQgnHjjNGxfguyr2PVkt1k83TMFrr0LVXucH8N3lgs5/V
	 0FMwr+LEXuf0Q==
Date: Thu, 2 May 2024 16:12:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Mark Brown <broonie@kernel.org>, Shengyu Li <shengyu.li.evgeny@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Will Drewry <wad@chromium.org>, 
	kernel test robot <oliver.sang@intel.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 7/9] selftests/pidfd: Fix wrong expectation
Message-ID: <20240502-leiden-wegnehmen-9ac8f35c7204@brauner>
References: <20240429191911.2552580-1-mic@digikod.net>
 <20240429191911.2552580-8-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429191911.2552580-8-mic@digikod.net>

On Mon, Apr 29, 2024 at 09:19:09PM +0200, Mickaël Salaün wrote:
> Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
> which will be actually tested on the parent and child sides with a
> following commit.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240429191911.2552580-8-mic@digikod.net
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

