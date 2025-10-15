Return-Path: <linux-kselftest+bounces-43207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C9BDF1B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98EF19C3E9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FC9296BB4;
	Wed, 15 Oct 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeuEpObN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A741284674;
	Wed, 15 Oct 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539014; cv=none; b=qxCbsoyM+bIXwiXA00Z+Ss9Ug3vbqPTGiZlV+N5BfDNBhCf7l0hCIDnRVZcBFt+kYoaCWS649dt8wShQsof6FIqOCB0+8P/jEXL8toQIOHRtmLxoSjRUsDXXU2MUMiwy5EouGd7BcAigF3/pU4cXxs8xJVVMIRG+Cnhl8fO6aWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539014; c=relaxed/simple;
	bh=q3IGuHOuKYj1maeYSdpMggw3+0tCzoglIrAlJxaChrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hWmXVlAG46uaHk1AN4+Hp3TxjvSL+kh7Rb5QPHYgqjm4reBd+QsAb0qYmb/1DOeH1rGFEA4EYs+NuasTLO/RVLg/eLB0gZpifcnoIbAq7H48cU4LJeQRA5RfAdqMEYXDy3VWgcXD5OMRq9DR3PTDVMvFIEhdt/aDi0l14YMgyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeuEpObN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A763C4CEFB;
	Wed, 15 Oct 2025 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760539013;
	bh=q3IGuHOuKYj1maeYSdpMggw3+0tCzoglIrAlJxaChrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UeuEpObNWodrFe4Tcd1s9U/Sm/Y5TnD+d9mC4iU5oRQWU1NrpE9yleEJA1tMc5CL6
	 pUXElVnCMOMOlGKSzQMpNP3XatEpCUfiP2n2ZX5ww3zuPxvzkUeCrCkcPK0xHZJm4Y
	 9pRWmSbBWsOyTGOqDnwjP0uM0xa4h9xTC3IbmXlUtc9seeayfDaeFIO7kXU3y4nv5o
	 ow/MYtiSFUM4KeP2cqyaqBcLtUbrhqW+BqSkCo0y0D2FeKTrFLIAzUPT8iOrrhHpz6
	 olpW5FHanTOG2gPbdEI+gtn7bwBfW3zi31TGCzTrLjNJBgU7NkiHO7y33aw/gD0uSF
	 u7BCek6kMzuZA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org
Subject: Re: [PATCH v5 1/7] kho: allow to drive kho from within kernel
In-Reply-To: <20251007033100.836886-2-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 7 Oct 2025 03:30:54 +0000")
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
	<20251007033100.836886-2-pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 16:36:50 +0200
Message-ID: <mafs0ms5sjkot.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 07 2025, Pasha Tatashin wrote:

> Allow to do finalize and abort from kernel modules, so LUO could
> drive the KHO sequence via its own state machine.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

