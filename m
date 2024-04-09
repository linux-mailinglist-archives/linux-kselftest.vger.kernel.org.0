Return-Path: <linux-kselftest+bounces-7504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B989E4FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 23:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0402820D6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 21:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F61158A0A;
	Tue,  9 Apr 2024 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqki+8aI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C62905;
	Tue,  9 Apr 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698283; cv=none; b=iPyHy25trgSYEfFJyqndDqRt0wviwnqjKWhLQe4qnK6D42z3o/qGk4NWST1He5KDmU9fSRn4X/nmqI3lzBabqg8PaGYAUfi+D/7x8/XJ3aTIKzSoKKbaIa+2zygNJ92gKu5oF3+x57t6OQon/vK62tHTl2hfnm1kFu2ufidU+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698283; c=relaxed/simple;
	bh=kZkqN+KEknBqYHvhZQeTKEcrCwU1tZSadC2SpfHTG0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2N5BMk7dMYOCMFSsBmyANLmmDwFnf/3yAfr1mUYcbcVNjBlFea2lO3ai6cAqirQZetB17BLGoHWGZk0CGPjb52fjhI1K96f1fBk4pW43JSu59C7MRvHgwcX8lQJBU9/LL1x71t0FNggVQE8QsDr2oJkUUcEC6ywLeKhKaumTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqki+8aI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E666C433C7;
	Tue,  9 Apr 2024 21:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712698282;
	bh=kZkqN+KEknBqYHvhZQeTKEcrCwU1tZSadC2SpfHTG0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aqki+8aIk5piPdQavjn6jST6szJBJZnKEt7ih/8K4uxzeEYL0zlW3bH71TOWqHCoD
	 2956t7U0kYI8xtaSd0Kzg8ItSt7rNh1pRsCm4CJ9eBz3WJm2XDT8p/SsaSEfKwT09w
	 /6F0YiS6xbjz4irFQsGe/H5Hma9zBndFBAGFhkfzjF/f/KnbH9YnkSJtxjXYYxdoNJ
	 boe+mx0fn88rpDGfvzylDh6lgeldGzlg62zwn4gXfO6sFoxOsOHY4R0CZI8nZv+CYs
	 S8/MJwA2rlFcbDe6jscuaYqBY0/min78qGYeqtzu35CBPtofyS9s4QQX9u4fuhJi/N
	 R6ZGMxGDzr/kQ==
Date: Tue, 9 Apr 2024 14:31:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
 eddyz87@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] selftests: move bpf-offload test from bpf
 to net
Message-ID: <20240409143121.789fd417@kernel.org>
In-Reply-To: <20240409091908.21296831@kernel.org>
References: <20240409031549.3531084-1-kuba@kernel.org>
	<ZhVoXIE9HhV5LYXV@google.com>
	<20240409091908.21296831@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 09:19:08 -0700 Jakub Kicinski wrote:
> > Far too often I've seen this test broken because it's not in the CI :-(
> > Hope you can put it in the netdev one so we get a better signal.  
> 
> We use kselftest infra directly, so they got auto-included.
> But I gotta investigate what's going on on the runner because 
> it seems to be failing right now:
> https://netdev.bots.linux.dev/contest.html?test=bpf-offload-py

FWIW looks like iproute2 on the worker was built without libbpf support.
Fixed now, let's see if it turns green :)

