Return-Path: <linux-kselftest+bounces-49082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3C4D2A171
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 03:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D2F13011A58
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 02:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F52FBDE6;
	Fri, 16 Jan 2026 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8JPkY0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D220C00C;
	Fri, 16 Jan 2026 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530237; cv=none; b=fT8+FLaNgQ1Sm3LOkOj85k1EXNNZ7x+U3XS9W6BIiDZeEyVZmAZ+xkkzKIJdtoeOIGbJov6UUBjuNWpXFvEPCwO3DYmLiGWMRJPRn0tbqWV7/a89tLF/JgMNvp4I3m8BlOmQ1R5twU5oV16DsngCiIc5e5Crkcf8Ch/bH82TpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530237; c=relaxed/simple;
	bh=MzmrCrtyA9+q65UCLOKh8braO2rZBjQLfxzOtiYVe0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtIr5W0EposDFQZalA4WPhItwaLaE5JpX7A4OMig/EQfNWJEfY+GZcdTj71TrzIVskFi97STaD4uC0WA2PfU6Y18SZJE+weTgjl23kAyiawnRTQ0vUGeZ5G32WLVnraauqrlnNaxLyhxqhWP7fOTJ2bOgoEKhoc4DQgUrSf9GkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8JPkY0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309A7C19421;
	Fri, 16 Jan 2026 02:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768530237;
	bh=MzmrCrtyA9+q65UCLOKh8braO2rZBjQLfxzOtiYVe0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8JPkY0VKfrKr7g2C2nl1/5AgjNU3cVmbyEuV/Xr1iso9FGu0958xoR+/5WO5xR96
	 NganCa6kDXoT/v/2Bkpptbyjl6HRsSQ/k9evMYuvy8Xtbnk0SLeFmJqRKCvxcBs19x
	 STOMTdGwlL7Fy9XvxHsX7PEwk4hIK63SK92m4wbBwZAwwNs+B14jJHPgMiUYUuC5r+
	 Up5wQ7p41LB2hzHdJkY/7IGY25PdEE4d001BEep3vRpBMX1YeM/K60xfoo7I9VZBbz
	 ZjQfeLqyKOdWcPuFu3usW6r/afhlwcbxUdXECjHNcCwbU8GJ4oxJOB5vMmC/arCuLp
	 00DAFbPq+4XsA==
From: SeongJae Park <sj@kernel.org>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] docs: kselftest: remove link to obsolete wiki
Date: Thu, 15 Jan 2026 18:23:54 -0800
Message-ID: <20260116022355.71959-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115172817.7120-1-bacs@librecast.net>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Jan 2026 17:24:44 +0000 Brett A C Sheffield <bacs@librecast.net> wrote:

> Remove the reference to the obsolete kselftest wiki.
> 
> The kselftest wiki is marked obsolete and is no longer updated. The last
> edit was in 2019, and the information is outdated, referring readers for
> support to IRC networks that have not been used for years, and to kernel
> versions that are no longer supported.
> 
> If there is any relevant information left in the wiki it needs to be
> cleaned up and moved into the canonical kselftest documentation here.
> 
> Signed-off-by: Brett A C Sheffield <bacs@librecast.net>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

