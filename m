Return-Path: <linux-kselftest+bounces-44793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C57FC3514C
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 11:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DC63BDD56
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C93230103C;
	Wed,  5 Nov 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxeq53K0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CF30100B;
	Wed,  5 Nov 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338397; cv=none; b=tWUuFLK3O9RqVqLQR4cwl8fyqWcAyqL9VirmvYpsQhyIKMBBt0bSNLne35Lj4ilkM+eu5giyHL5ArDS269zLXZqBNAvlp17oH4RULL9Nd+Y26ACkLsZsRRyTRiSOIJGlKvrFMsrUgsReWvAcGWJw0GelqJmx2gsYhxPvgLk4sF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338397; c=relaxed/simple;
	bh=I+3JMkmXub0Om9x1OdwocGKiSC8yEiSgXZyoFKMlEVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HCNYolk8/k764n58+DGxpdybZ02CB2p2122rFKOvbm352txjMB0PyPMsfMOnwq4P4KGITkNrGr21ek3uEIG+vBU5Sb2haoQ/03VHxV2dfJ6ORD6+2A00Eeb8L2R7KSJO/kBVj+smJ9ffeTTTa6BrzyfYbWF5d1oP2AO3SLpgQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxeq53K0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B37C4CEFB;
	Wed,  5 Nov 2025 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762338397;
	bh=I+3JMkmXub0Om9x1OdwocGKiSC8yEiSgXZyoFKMlEVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Gxeq53K0YO1rrLqRKi+ZKDxCWG/hCytZXm6QxtcTY10w3UtM/t4lFglfJW71RwS7z
	 gJk9TjarlsPVgn2uvkEWUQT3sAh2Zf29TZeIYsl4JZ/DdloehsvLLvMdm0oSmtJJ4S
	 lEMH3OdAF9ZrxxffeXERgioD0IEkvJIfLMJu9FeGR473c8ifRyXUvB2rDI05Ct83YG
	 U4tNW0QlqxPdfuLjV5LyS6k3EZxD+PVPzas1hkDW3hzcUIH1jRJ10jHOGPZwH8YyjD
	 OUDZyHxGBM6YcrHMPGRDojRusKwMYp4Ne/R6OaHIXbjiigR3mDnzOtM05ctjUqfe2j
	 jU3eZPNpb814w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org,
  yanjun.zhu@linux.dev
Subject: Re: [PATCH v9 4/9] memblock: Unpreserve memory in case of error
In-Reply-To: <20251101142325.1326536-5-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 1 Nov 2025 10:23:20 -0400")
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
	<20251101142325.1326536-5-pasha.tatashin@soleen.com>
Date: Wed, 05 Nov 2025 11:26:33 +0100
Message-ID: <mafs0pl9wbwrq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 01 2025, Pasha Tatashin wrote:

> If there is an error half way through KHO memory preservation, we should
> rollback and unpreserve everything that is partially preserved.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>

Nice! This is quite an improvement in readability compared to the
previous version.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

