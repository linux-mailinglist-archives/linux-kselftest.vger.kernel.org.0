Return-Path: <linux-kselftest+bounces-14675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B909452B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 20:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F702854EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745FA143883;
	Thu,  1 Aug 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuiH6RiT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF251E4A6;
	Thu,  1 Aug 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536691; cv=none; b=reIA9Yeyd350aw4rWdewjb7Omlj1l35/JBISFyEuaqtQc8NzSw4pNNRyqF55qNuhNSUZuUx/ikZDRQ+3fSI3DyATYOQS2SGgT4kS8RBdNpsL5gn+jyfh9Npucq66fe5piM1Agha6l2IGEi9T01T+5FBVYoQjryQ9F2/NzPKerDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536691; c=relaxed/simple;
	bh=PJNNC8ODOP8B8hNWHK7KIAUSZhZ0ElFSNwJ1lz5J/RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaUWbw03phXVzhir0q8+puYlmoqCb4z+mym+D1YBKY1+jY+OvkF6FdqqDDG1kJl1JqxRpjKiA/q9/28Mk/e1P0Sn7DHtV0fmtTU07VG6y54AK42spQb/S5WGBccpos9npfrKBRDkwrJwdeVBKdIduNbzwz/27wfK/GkXnu8sPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuiH6RiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA12C32786;
	Thu,  1 Aug 2024 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722536690;
	bh=PJNNC8ODOP8B8hNWHK7KIAUSZhZ0ElFSNwJ1lz5J/RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UuiH6RiTTMN3rvJ4LEBQSPuqM2zs2KOQ8G8az+xzVVpNJ6I8GQ13TCoY/jxhJmKRl
	 JwA1OoEs7+6ODuRm4MXzb7kAsuxa2faV/ny86N6NczX7g/Cikap3xRNH9EQ/mzQ3Wq
	 8tdkrSDk4k7xloOSPOk/xK4vRfPEK1R+vuD2giyMn4fNtL3nCLZhP9kam4qm/KpbvH
	 hQH0K/RF0bEQI7Ibw/PofD9p1JI/dm/6HpcU/i4njk1qf9mXKVZeR9++ehPcPJlpBX
	 TuBL7dK28ZPA3+Ka5DCDLnzaHeSzCl+DzCERSYcFJ2fv7x6a5P6xHSA5aFTBW3AoGz
	 s44wAngqtY1og==
Date: Thu, 1 Aug 2024 19:24:46 +0100
From: Simon Horman <horms@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: tc-testing: Fixed Typo error
Message-ID: <20240801182446.GZ1967603@kernel.org>
References: <Zqp9asVA-q_OzDP-@Emma>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqp9asVA-q_OzDP-@Emma>

On Wed, Jul 31, 2024 at 06:07:38PM +0000, Karan Sanghavi wrote:
> Corrected the typographical of the word  "different"
> in the "name" field of the JSON object with ID "4319".
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

Thanks,

I checked an this is the item flagged by codespell in this file.

...

