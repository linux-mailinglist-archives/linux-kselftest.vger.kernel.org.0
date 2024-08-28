Return-Path: <linux-kselftest+bounces-16584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DF9963032
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D06FB226E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1271AB504;
	Wed, 28 Aug 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhZZbol0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF61AAE29;
	Wed, 28 Aug 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870356; cv=none; b=m85BABdapn7/LDRrcI2k28sxX1HaPK8Q2qOWHHVxXMA1TctL+awal4lhTRKQ2nvtlDsl2yLW+BvWqV3rdMswaSu1CpYVaWSrvKkkWM30TIDSC6tV6tZ9/DYVaFu8LDcdvssQuFECftkVJVuudmja/Oc+IvQzHWTujxc1kPiRPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870356; c=relaxed/simple;
	bh=si9PGTW5YR5qxD3Gd7n4NhVm2017Y0onMUljYnXwq+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N03HghVkipoJ1YW0mHaeVEbd3qan5mUogyHGgWEpk6Q4TJeaDh/H71PhCylTDM+x6R1YInvMuizgb6H2BFm+3tVxXLmQ3oWP9VHlfdwxw0xim02WD4W0eEQyC3TMEPYKScVcaANSfbCxT0UkopWV7TXMwfZD/O8YqGu3jl4hYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhZZbol0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C16C4CEC0;
	Wed, 28 Aug 2024 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724870356;
	bh=si9PGTW5YR5qxD3Gd7n4NhVm2017Y0onMUljYnXwq+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IhZZbol0Jzu/bNpRVoGBWYpQyBx0/0zqgRIETrxChd52k3YNvLebKUcvaU9yI4R1a
	 1sbpdquqJyg5aDaWd3MgMAZMNl6Nmbo/DuxdbzlfqJydX1WcEgS6+RvzukR3iQcWpl
	 tJaTPbV9YNHj7ihHyJr/yLSsKADMW24fxxSX7BsrIzCuzoNizAZGQX+oaK2UH5mnEq
	 5IOkHXofYrDuincgsmFRbS8Pp5gV3ul+rEG9iTL4kxraIsyfNXAV8GK04pujeOlGVO
	 S7thV4c/rCJEvkMJ2DPgSXD7hbnMBN3P1B2WHVPRaYJkjDLqW78PXzlNTgUXjiKpNY
	 M3Z3auyIzIuFA==
Date: Wed, 28 Aug 2024 11:39:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240828113914.3aade555@kernel.org>
In-Reply-To: <CAHS8izNyJgr=rFM8H_v=A3yfqdoDJysOtKA0CuZHRfgZ11ec4g@mail.gmail.com>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
	<CAHS8izNyJgr=rFM8H_v=A3yfqdoDJysOtKA0CuZHRfgZ11ec4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 11:26:28 -0700 Mina Almasry wrote:
> I did not know about run_kselftest.sh. From a quick look, it seems to
> require selftests to be installed to run them. I think nipa relies on
> something slightly different, it does something like this, AFAIU this
> runs an individual kselftest without requiring it to be installed
> first (which is nice):
> 
> make -C tools/testing/selftests TARGETS="net"
> TEST_PROGS="rxtimestamp.sh" TEST_GEN_PROGS="" run_tests
> 
> It may be worth it to check if these added tests can be ran in a similar way.

They should, the ksft infra converges into the same bash script
(runner.sh) whether we enter via make or via the "installed" runner.

> This may also solve your issue with 'intermediate output' being
> printed after every test. AFAIU if the tests can be ran individually
> using a command like this, then you don't need intermediate output,
> maybe.

selftest infra tries to prefix raw output with # to make sure that
random prints don't get mixed with KTAP. IIRC there are two ways
to do that, one is a perl script and that doesn't buffer, but if
there's no perl in PATH it runs the output thru sed, and sed buffers.

