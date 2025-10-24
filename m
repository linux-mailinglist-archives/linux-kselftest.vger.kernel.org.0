Return-Path: <linux-kselftest+bounces-44015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F77C075EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F70F3ADBCF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8310327FD52;
	Fri, 24 Oct 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMTdi6wi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5968320E029;
	Fri, 24 Oct 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324202; cv=none; b=K2Xdjze4/hIFodG+fY9J/Q7biAtFJzGDPRgzEhu+W9yqxcW8bwHn2yY/ny/IG5iNJUEQ4guq4M3OFjuhHkPcNnk7FXFaWnt+pVXcg9HxL2l9J14DJcgcWxjX0FflRrjgaHTFIeFH3bp7GQtwnZc/Bz2jFLBKjx8Bk3Hc0bNJFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324202; c=relaxed/simple;
	bh=YnthGUIKXztXO+a34kp8fF8ri6TxQZg51paSG28MCk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ci50pmXJhWJtWSP6VNzSYayiS18uY5wdCt4BYVAt63f8Ax3ZQoY/7Zl2c+Lih4teUdqzBdsJFfQbOj6EeHgrSVPZyud5cjoUOIl/xqvvZme4HmZ4kfzhzsP6dtQXI4+UZ02jXncKFGBDeNgQREauV2kUpF/N9RyoRIkQI1zH0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMTdi6wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C9AC4CEF1;
	Fri, 24 Oct 2025 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761324202;
	bh=YnthGUIKXztXO+a34kp8fF8ri6TxQZg51paSG28MCk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XMTdi6wimkywjFXY9hXcH5M2b/fBrCVF+7EhsdWkYDZ4qHMm1InoFTJtN2pDQetlo
	 bNMzE8oQun7FpMpNCi1rBv6ws+/XV92fV8QrAJ8osvZoY2KBLXqpjqWJ3bG+ZVfO//
	 E3O45AsxayedOGiBT4m5F19QjliZm26HRef1ekUTgVBWEfd9FBaducwx9Szxd5MVmr
	 X0A/dQ7nZMK1TXUUsMyAQySumS0yMuZeXV3H++2j//MnTc9YgnxbVMYqPOl/8bmRcQ
	 kZMCr17yt8i+zrf1P4160HG6IAW9Ve/0zWziU2z4WSrHcV/3Q5TBpIPlC6pwHP/toF
	 yJoCGOCHFh1JA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org
Subject: Re: [PATCH v8 3/8] kho: drop notifiers
In-Reply-To: <20251024161002.747372-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 24 Oct 2025 12:09:57 -0400")
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
	<20251024161002.747372-4-pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 18:43:18 +0200
Message-ID: <mafs07bwkdzdl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 24 2025, Pasha Tatashin wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> The KHO framework uses a notifier chain as the mechanism for clients to
> participate in the finalization process. While this works for a single,
> central state machine, it is too restrictive for kernel-internal
> components like pstore/reserve_mem or IMA. These components need a
> simpler, direct way to register their state for preservation (e.g.,
> during their initcall) without being part of a complex,
> shutdown-time notifier sequence. The notifier model forces all
> participants into a single finalization flow and makes direct
> preservation from an arbitrary context difficult.
> This patch refactors the client participation model by removing the
> notifier chain and introducing a direct API for managing FDT subtrees.
>
> The core kho_finalize() and kho_abort() state machine remains, but
> clients now register their data with KHO beforehand.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

