Return-Path: <linux-kselftest+bounces-44011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C395FC0754D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91731C40D39
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C30255F22;
	Fri, 24 Oct 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmTlFHF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381A2264C4;
	Fri, 24 Oct 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323602; cv=none; b=PBUKRdrlSl2Ge3AMJxrpl0R40dcBsmzdXj2RFj2xSD/9seY4RSSUdyZ8gF8HHY7/Ed8IwFsdoVksw61yAEMleaQKWcGMKJ/Xu7LQhhSnDKA4mh5VbTRsGfq8dmruqEJA6wzx04GqWftvUSuQDc9viP/pXRCKJgUmKfmtHJsGNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323602; c=relaxed/simple;
	bh=XMFgwNWwAN/K20/zNCeSu65GygTTYqfFzRDZdRxe48g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O9vgHclnk01Yfq+PXGUASDR1OkLtXHUQG3hc3xn2pScmk8YlIYXi2yh3Dddw3BA6tCg5S9s3WzgyjWMAtktn5WgXOvdsWtpH54K4RJsUb76OIMUewSe8uJNW7IRnCVICVfFNTxFYK+HBtF3kIOVbBNlLnBebat3NOBVOOyZqivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmTlFHF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240A6C4CEF1;
	Fri, 24 Oct 2025 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761323602;
	bh=XMFgwNWwAN/K20/zNCeSu65GygTTYqfFzRDZdRxe48g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TmTlFHF7zZ8dPZGX3jEH/pSYjzxolXyF5dUE0S+bL+Nq+hpo1P9ou18OJNUiu6KBI
	 NSS3Xm5dytcFzfJ7puDv1DsP7KGA2uEMxJXDWWiL3vGS/ELCNIULr40DEEajfZrYqy
	 qTpYAvlJQobc9AHEDUYmaq0s961QH7d8g/xPl1jFWOAEVLEPQOV8Paa8m14RPAPxot
	 NH+OqVP2QIpszLJHcV4EnBFFxrsuP9ac79OdrpmNJfnG+aj598hT+O64jUZa9Y9OFL
	 LUz2EMmzrLKkbiTR1MVOlnkTT5nZOOEwemDPmZEmex3FgyirppOmfweer1mxPrJE+Z
	 N446Xpue2eMkg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org
Subject: Re: [PATCH v8 5/8] kho: don't unpreserve memory during abort
In-Reply-To: <20251024161002.747372-6-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 24 Oct 2025 12:09:59 -0400")
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
	<20251024161002.747372-6-pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 18:33:19 +0200
Message-ID: <mafs0bjlwdzu8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 24 2025, Pasha Tatashin wrote:

> KHO allows clients to preserve memory regions at any point before the
> KHO state is finalized. The finalization process itself involves KHO
> performing its own actions, such as serializing the overall
> preserved memory map.
>
> If this finalization process is aborted, the current implementation
> destroys KHO's internal memory tracking structures
> (`kho_out.ser.track.orders`). This behavior effectively unpreserves
> all memory from KHO's perspective, regardless of whether those
> preservations were made by clients before the finalization attempt
> or by KHO itself during finalization.
>
> This premature unpreservation is incorrect. An abort of the
> finalization process should only undo actions taken by KHO as part of
> that specific finalization attempt. Individual memory regions
> preserved by clients prior to finalization should remain preserved,
> as their lifecycle is managed by the clients themselves. These
> clients might still need to call kho_unpreserve_folio() or
> kho_unpreserve_phys() based on their own logic, even after a KHO
> finalization attempt is aborted.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

