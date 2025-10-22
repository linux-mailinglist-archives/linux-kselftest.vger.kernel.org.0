Return-Path: <linux-kselftest+bounces-43749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F84BFB697
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 12:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7237426148
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BDD30FC07;
	Wed, 22 Oct 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWN+f88k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902272EC0A9;
	Wed, 22 Oct 2025 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129066; cv=none; b=ixmpUnZzOGvVk8yklSwL/GcOqdZ+0SXdYoNOkmBV0PHRmCwhM5tteXMBnTrHRG0+/cs1q3zKburSOvIQ0NNHfGQz0Is1rZXtSgKe7tW4Plp8hskRwXhGpDjZ8JUZoFbNQLY/qhY9CEbiC4OYXSFGvpRG7Vng98FqSYWRFyx94BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129066; c=relaxed/simple;
	bh=nxiK/SmuUZ/eJ7+8qPPttAoIuFOLIAmNOtowfTn06Zw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UtJanJV3WdYO04n+do5vtipGGLSg7em9PcnIVGZZDSYEA/nAK4CsQ0HxwaQrzGdc1hJ+6a27Qoo+xARqJntr6ufuj9civJijf0lYxG216j/AXcxnUzPpRwUOeZj6NJgsW2rVjvm2seq0vvRjvflaEX3WHHnrX9hbX+7Gc9DcdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWN+f88k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D9EC4CEE7;
	Wed, 22 Oct 2025 10:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761129064;
	bh=nxiK/SmuUZ/eJ7+8qPPttAoIuFOLIAmNOtowfTn06Zw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aWN+f88kmsR31F7356Nhjbat0XtNCNhOhXxy+mj03RUY7LWerEd1yedbWOXdr5vi4
	 tNC+xKsZSg2//FpnqZYu4HGomHdWZWKoWc4J0F163zczx7hJ134hS+2cI7rg4UBcBa
	 XULRgorW9kn/jRM+mwrHuIsfgAm9Feu+WSSlfWZaK8bF5cXpLuoNB5oQOnt9nO/eTV
	 PFj5BTL4kV1aXEPl1qTK/lkP91bINYUNHfh3yNabcAkBxQeumFTNfYyuMGkMlfSWTu
	 Ixo9tEXjSj5WrW0BDvq9FRVpnEYEXdeit9JcP7F8YmMqoDfwTE1pDA+TcIQPAuu6kL
	 QBEndSkG/yiOA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org
Subject: Re: [PATCHv7 2/7] kho: make debugfs interface optional
In-Reply-To: <20251022005719.3670224-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 21 Oct 2025 20:57:14 -0400")
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
	<20251022005719.3670224-3-pasha.tatashin@soleen.com>
Date: Wed, 22 Oct 2025 12:31:00 +0200
Message-ID: <mafs0ms5jfct7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 21 2025, Pasha Tatashin wrote:

> Currently, KHO is controlled via debugfs interface, but once LUO is
> introduced, it can control KHO, and the debug interface becomes
> optional.
>
> Add a separate config CONFIG_KEXEC_HANDOVER_DEBUGFS that enables
> the debugfs interface, and allows to inspect the tree.
>
> Move all debugfs related code to a new file to keep the .c files
> clear of ifdefs.
>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

