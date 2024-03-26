Return-Path: <linux-kselftest+bounces-6597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A588B621
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 01:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4D42E695F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 00:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80054171BB;
	Tue, 26 Mar 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSvhX9g8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AADA14AA0
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413259; cv=none; b=X8IY7ZJzTLiAYp2VkecYXM27Klo3Hbl+M6TrcYSJAmjqZUhiaUvW2tx75K+YmEe4Hj7xWtiUBQCfAqnbZA/zi6GaWaq6dCKkAaxXwXV449Mhi9DsYpMCAU/K7+4fyIi3sqy1G5afs+7sOZfSeuEKOfdCiBQCfeI2ypKviYDtJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413259; c=relaxed/simple;
	bh=u/OvrOr9MaSsJQXXEDaXUzo5U7fkMQKTygssg4Jzmb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmWjgBFhfSrxkTAdLmS6XQKcOLqcMMprUp02+eDm9aQWvv/4hYKZHHzXAmF/SvzSxok2Uhj6MCv9HOYQilZpRO/ns4i+xzDhtYpgJFJ0Ynf4MrIFgi7kwe/OG1ZQ4RgntFfC276GXJu4wJgKCIelrv7RwUoSSMflP+BkIR9QrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSvhX9g8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31159C433F1;
	Tue, 26 Mar 2024 00:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711413258;
	bh=u/OvrOr9MaSsJQXXEDaXUzo5U7fkMQKTygssg4Jzmb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DSvhX9g8QPWfY44/dSv8RFl4cDyhxOT2DqnB0F8b76vFG/lHA/DBXIeCu7ikd9Wox
	 KIbVlFSYcw4AsdMLtOdMZ3Wvlb+xP0p6LrumGHnqsTjyH6ADooFOI2v/Zne3sQDuJo
	 K5mZHr4+qxDsGWx1WPP/JZSraYXiDbEEux+wjIhm5VAc5fEQdu6UpDZogNaZOuKYtk
	 ZbKqweYQn/bEMjBJnZzfBamOHtOYqE5eJEefLHqas+l6FWCplYJVa3nL/5jI1Ylk4E
	 pGK4tzAxcAqxQQ6BzBtb1dGEr5RSMhTv8OK74K+LfdmW5VLLk5EarBK5hbMR7d1/So
	 gnKdYeKHkUtTA==
Date: Mon, 25 Mar 2024 17:34:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <nbu-linux-internal@nvidia.com>, Shuah Khan <shuah@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, "Ido Schimmel" <idosch@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH net-next mlxsw 03/14] selftests: forwarding: README:
 Document customization
Message-ID: <20240325173417.1a79b631@kernel.org>
In-Reply-To: <e819623af6aaeea49e9dc36cecd95694fad73bb8.1711385795.git.petrm@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
	<e819623af6aaeea49e9dc36cecd95694fad73bb8.1711385795.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 18:29:10 +0100 Petr Machata wrote:
> +The forwarding selftests framework uses a number of variables that
> +influence its behavior and tools it invokes, and how it invokes them, in
> +various ways. A number of these variables can be overridden. The way these
> +overridable variables are specified is typically one of the following two
> +syntaxes:
> +
> +	: "${VARIABLE:=default_value}"
> +	VARIABLE=${VARIABLE:=default_value}
> +
> +Any of these variables can be overridden. Notably net/forwarding/lib.sh and
> +net/lib.sh contain a number of overridable variables.
> +
> +One way of overriding these variables is through the environment:
> +
> +	PAUSE_ON_FAIL=yes ./some_test.sh

I like this conversion a lot. Makes me want to propose that we make this
a standard feature of kselftest. If "env" file exists in the test
directory kselftest would load its contents before running every test.

That's more of a broader question to anyone reading on linux-kselftest@
if there's no interest more than happy to merge as is :)

> +The variable NETIFS is special. Since it is an array variable, there is no
> +way to pass it through the environment. Its value can instead be given as
> +consecutive arguments to the selftest:
> +
> +	./some_test.sh swp{1..8}

Did you consider allowing them to be defined as NETIF_0, NETIF_1 etc.?
We can have lib.sh convert that into an array with a ugly-but-short
loop, it's a bit tempting to get rid of the exception.

