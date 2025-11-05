Return-Path: <linux-kselftest+bounces-44794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD0C35169
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 11:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59C6189DA01
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 10:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B940301499;
	Wed,  5 Nov 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4NOZ3+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5F301007;
	Wed,  5 Nov 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338485; cv=none; b=KAAUkeROiV+Dv3hSKF6AING1r2OnaWItr3YMXKilFBAPnnaUSn8kFVZf0haU8X+lrMdX0INXRAXCVGfj+3GLjJ2juoGdDub2DsaogfkVP9qAERk3rFIxio3REX++xJav/vHbffT/pj4sTMSQQL7nvrbKWuesPB0HD4exxRJ1uGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338485; c=relaxed/simple;
	bh=iGm3ztCoHBoiX+8pTAlhDOq1wez0F7WKLBUyQq+ZXxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TUmnCw07RZyUPzc9hIV+DPmCX7sNFmQ6K/6je1dS9O9XQkcQy8x0dOqbiixtukhvRvtBsfdsB3qLSMA4IOn2Hm6qHrCT9UVlkJAgR+OEzdLaQtYN7AUQS5bOuCVUlGt6C7f2y/i2gE7iZ77GxGESj/6NGo08bIme9V+J/BsNG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4NOZ3+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36D3C4CEFB;
	Wed,  5 Nov 2025 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762338485;
	bh=iGm3ztCoHBoiX+8pTAlhDOq1wez0F7WKLBUyQq+ZXxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=J4NOZ3+F/wcCmEWLMyxtMF9GufxOdiPWEJI8FjD81Zi0epu/A0mcp8gt23izr6n4f
	 86B1xrYhjtkwryopz9jIVKj4zX0kBJ0++ccJSdXCtujeMEIYOh3dvGUfB2ntWo3AAb
	 kF/D7CDVvSaaGZpJuCFOkJEDRVWoHv39Vumf2zgRucUeJZVAADKyFzNS7hP23fCrCB
	 HMHVLNFXfG3g0z0Z+9Ozuw6YB354HaP/w5eoPMvA3vJFuURb7VS+JlBokheQDS5HKG
	 1hxJusWy8nEyoTDgDLLFEHYSTikww4QzLbCjZ90tylGShH+rC5VsGgNYutNKeRwAPC
	 5k7ucS2PrYDHQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org,
  yanjun.zhu@linux.dev
Subject: Re: [PATCH v9 6/9] kho: don't unpreserve memory during abort
In-Reply-To: <20251101142325.1326536-7-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 1 Nov 2025 10:23:22 -0400")
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
	<20251101142325.1326536-7-pasha.tatashin@soleen.com>
Date: Wed, 05 Nov 2025 11:28:01 +0100
Message-ID: <mafs0ldkkbwpa.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 01 2025, Pasha Tatashin wrote:

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

