Return-Path: <linux-kselftest+bounces-44647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F79C2C004
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 14:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46DA54F8846
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF7C30E832;
	Mon,  3 Nov 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY42H521"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434DF30DEAE;
	Mon,  3 Nov 2025 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174765; cv=none; b=hfCRkeGcuo8O98oF1eFGUtmROuArxnc8aoRdWE4MuGLwgI52ZOFWSRGYLMDDMAl1e9SdAIjuJnk0gKSVwx4tzSfMSAMTo+eN/iKHtI9G+VWKJttiub8jvDapIicfnUARJB+G54vahxEsuirz0T28dsqI9zf1Kj95Qe8euuNVvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174765; c=relaxed/simple;
	bh=MDaNcpqSBRCQYr6Wbo2CVleFilV3wzUK5ugsLst5xT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WFwL6nnB7/tGWsP3RmrZOMtc8JXmCeCdK9H2wC4iY/iqpaPi+DvAG+GBUNXx/D6HsU/rk6MOhJVqUUuGra7C25HJ3nRdIc/uuR6WnuoWnT0Lg2ExhO9cMSdz1ijfGxkF3HQNy61kCtN7QJ9mo4I3k9afPXTdB63lRRa85FifddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY42H521; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49628C4CEE7;
	Mon,  3 Nov 2025 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174764;
	bh=MDaNcpqSBRCQYr6Wbo2CVleFilV3wzUK5ugsLst5xT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oY42H521Yn+pOawY02ln/CrSRSLuk/RGTyh60MiSOfW31GE4RkrNH24O4273FClhs
	 j3cOa7/batoDl+c+utfBg2bFbpgaBZEjPa2C+3Exd8sdn7T46GE6AfDGn4oZInxCVl
	 AEje3gcExkCYqI0uSIDPLXCiF1UoaDqxn73PFGmUVz+P7huu7XAyGb8j1b8I2tzUKK
	 z64NU+i0nElDX92pUmKbbxvn1qgxCsoNU2/Rk/pttp2qLu5NL/VKLspCUZTtAhM+hd
	 jzqukYeEEZmzp3U/EERtC5HFPtnuoYzNty1QSPuU3cADVRJnK0Fh1DrpwtloDaIyZV
	 dgq+cUVfCWNtQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org,
  yanjun.zhu@linux.dev
Subject: Re: [PATCH v9 9/9] liveupdate: kho: Use %pe format specifier for
 error pointer printing
In-Reply-To: <20251101142325.1326536-10-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 1 Nov 2025 10:23:25 -0400")
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
	<20251101142325.1326536-10-pasha.tatashin@soleen.com>
Date: Mon, 03 Nov 2025 13:59:21 +0100
Message-ID: <mafs0h5vbclw6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 01 2025, Pasha Tatashin wrote:

> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> Make pr_xxx() call to use the %pe format specifier instead of %d.
> The %pe specifier prints a symbolic error string (e.g., -ENOMEM,
> -EINVAL) when given an error pointer created with ERR_PTR(err).
>
> This change enhances the clarity and diagnostic value of the error
> message by showing a descriptive error name rather than a numeric
> error code.
>
> Note, that some err are still printed by value, as those errors
> might come from libfdt and not regular errnos.

There is fdt_strerror() that does this for libfdt errnos. Something to
do in a follow up patch I suppose.

>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

