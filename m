Return-Path: <linux-kselftest+bounces-8620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1E68ACEA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 15:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D2A1F21EC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256F14F9F8;
	Mon, 22 Apr 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9UExLxU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891B5028B;
	Mon, 22 Apr 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793707; cv=none; b=ckaH4aHuit6nuIkSKkbV5CiJRpTVSuVveowHiW1jVkaDYO0N6RemSVVqzPGyIZRC7t9YC/uA1zCqz40pHJA9M2ldqYSMKNxtIHtMMfo89WIGpexCoKedriR7zDNSLntU/GWiojrmN6ei8etcdGOgmOnL6DAhZ6otMWvmAFEp+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793707; c=relaxed/simple;
	bh=jIfESBYcn4GIuY3V7ZuPe1Yco422+VcolBLfi8XrwhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtsQTQhdhwLcqJ8ceckZxBXbcUcjkpdHT+v8kS3yqK/bW7rWI1bdwHb3s9iCpjXCCAMAyq3VMaOgV/QhH6TfEXd9OkeirU81tawxKaALhild48Gqx8Y9PmXD9qUZ5LudVPVeEzXDr99/DbJ4LlDV7sO6CiIy3i/eCR1C0g3OCv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9UExLxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B758CC113CC;
	Mon, 22 Apr 2024 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713793707;
	bh=jIfESBYcn4GIuY3V7ZuPe1Yco422+VcolBLfi8XrwhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s9UExLxUjV2Jdr4ZkIexniSi2cfn4NHasbXvbOF9KkABZoaB8KVs2Ai9OncOGYrV/
	 aYTyXjqLOFx5KKeyP3YMyVuswag2GU6Ptb/IfrMLyoUm5iIAyJKYh+plbosgmCFBvB
	 tXBwChNajwlLuWW+TUrywzqhgSJ9OCmj3zMdhzQY6w88OC+K2JzHRbRVTpfQS6GpkF
	 ZbJOOVL7anRl8OGeDDu/O8oE2kgyBj+/SPhQOU4MCZeXomsMXasBwr9bZotWNCYO+H
	 lW4r2pUrHE/6EXQscp+RzgmokJx+RD7ex3CLcv1iHnqbcnqvEoMW2DdKkrJFhIilZ4
	 oGI4k6ryOmlsw==
Date: Mon, 22 Apr 2024 06:48:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org,
 sdf@google.com, amritha.nambiar@intel.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] netdev: support dumping a single netdev in
 qstats
Message-ID: <20240422064825.18850cc3@kernel.org>
In-Reply-To: <a1340c70-bbc9-4b23-8e9a-1bc401132721@kernel.org>
References: <20240420023543.3300306-1-kuba@kernel.org>
	<20240420023543.3300306-2-kuba@kernel.org>
	<CANn89iK-wnNeH+9-Oe6xi9OjoY5jcZCowJ5wDL7hJz1tRhMfQQ@mail.gmail.com>
	<a1340c70-bbc9-4b23-8e9a-1bc401132721@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Apr 2024 13:32:24 -0600 David Ahern wrote:
> On 4/21/24 1:17 PM, Eric Dumazet wrote:
> > I wonder if NLM_F_DUMP_FILTERED should not be reported to user space ?  
> 
> good point. We do set that flag for other dumps when a filter has been
> used to limit data returned.

That flag appears to be a, hm, historic workaround?
If I was to guess what the motivation was I'd say that it's because
"old school netlink" didn't reject unknown attributes. And you wanted
to know whether the kernel did the filtering or you have to filter
again in user space? Am I close? :)

The flag is mostly used in the IP stack, I'd rather try to deprecate 
it than propagate it to new genetlink families which do full input
validation, rendering the flag 100% unnecessary.

