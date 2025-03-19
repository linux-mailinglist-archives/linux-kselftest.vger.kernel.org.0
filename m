Return-Path: <linux-kselftest+bounces-29440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16103A693FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 16:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F97F19C6494
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEACF8F6D;
	Wed, 19 Mar 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgGWWrFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C61CAA8A;
	Wed, 19 Mar 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398932; cv=none; b=q0zABUh3av3d3Q66GPzGLeSzh9hel1Njawv+3JDcxACma0vLu1DpF6GnzvDxsxIIpWSHWAPH6ce1XsavDbDD0j96ew8NcWA8ca5M+81bstxqJ/4wsaPRSZXk/8u69z2wUCtpoxcOqZIdXNHCKTgtxv+d4+qdMVXYO7W9NHogpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398932; c=relaxed/simple;
	bh=3QdO2100YuVgRYlDdk0yVfkIcfiOkG8BVy4Jvy9DuOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbp6CrteOriy6o4jlwKBZCIDBqj67d1+bJddprNWO52bPTWZXpPS2wrB7lj33bXco0B4bFdsud+icv5UWqIVwdDuTpZSRgIMgCNgByJi5Yx8Iyr4mVVdcV61Rvz7Ennu6AhvuuF/SQXjoLjVEf8bgFbm41AUK+NSGxaOceQeE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgGWWrFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EBFC4CEE4;
	Wed, 19 Mar 2025 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398932;
	bh=3QdO2100YuVgRYlDdk0yVfkIcfiOkG8BVy4Jvy9DuOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgGWWrFjZ29014xGukFQQIbdhb5SZtE9gWi4HVhi8ondAJRatlZPIX6LOsvQXN7tU
	 7rLHlWOrGPT9XFY02Jt/6fv3gw2t7oWuK/LPTvrIEeMG6bdkMIMrs7j23ZuJGdZvyw
	 ennnHp32r5lxN7qX4TguffyzptZ3wriT3LSJ0eBDXb7PHxoCfe3pVqXaudMCSC2KJz
	 z/A4dwB2iUJ7G4lXjxxjAK9XMYn714Luw5etspPqOjvaOAc10qmnvnC9jOkHNc/qFc
	 49Ia1HSzaO0Cc343AoRfEzCzSRqqcZCExvwa0DX81r6LkJY6E0sF9QB6paYcGO6t4N
	 mzDvrPsIn1v/g==
Date: Wed, 19 Mar 2025 15:42:04 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next 6/6] docs: netconsole: document release feature
Message-ID: <20250319154204.GK768132@kernel.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
 <20250314-netcons_release-v1-6-07979c4b86af@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-netcons_release-v1-6-07979c4b86af@debian.org>

On Fri, Mar 14, 2025 at 10:58:50AM -0700, Breno Leitao wrote:
> Add documentation explaining the kernel release auto-population feature
> in netconsole.
> 
> This feature appends kernel version information to the userdata
> dictionary in every message sent when enabled via the `release_enabled`
> file in the configfs hierarchy.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


