Return-Path: <linux-kselftest+bounces-41423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A224BB55789
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 22:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016691B21378
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 20:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8377E2BF016;
	Fri, 12 Sep 2025 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmPfeuVj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095B1C54A9;
	Fri, 12 Sep 2025 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708244; cv=none; b=dGuDSpFNeoHRGyeipT+MGxdL3ooQ+AO1sClvwyERGG76SGNb5NFCvvxKDBCP6uk85pUGZTXT2r+1oe90wtfmdqNlh4Xc0yXguJGJoE9hcAkKWRrgy45ix6H6TfsNKa6IM1czKbD6VUU5nX9Dkejy/+zV45/751bzWax3NVp1iNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708244; c=relaxed/simple;
	bh=xzYM6gGITlLdf30EXs4Ltyuk3aaTOSZ0Cc0L+EpH8hU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNZIyyWjp5OYXUXPza90gG/LF0F8TUDAOpdeWtV3VfqyknJkjv2JMa3mu7Amp8QzW9Vp7xH0SeVyN5OkwHn0Zan5b1FawuSPgrG5z3Z4PTIsJux/MdGZ6v+l2EG0vciNBd9z4i69rYQ4tu1N8Z6x48jb28lezJyEqoOrB0bNcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmPfeuVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBE0C4CEF1;
	Fri, 12 Sep 2025 20:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757708243;
	bh=xzYM6gGITlLdf30EXs4Ltyuk3aaTOSZ0Cc0L+EpH8hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bmPfeuVjIhl84bamQEp4dco3dnTtzMRRex4ZranpAvU2GbR61Rq0qKN61JF2rk+iF
	 is4dJBqAAns/liU28pVKtOT8t168cvkMOPoCot2HF2Lk2Ou49TQP9G2AdZcXM5LlCF
	 qPGLN1vJAYQiWk6tNDG+Z4R0Wh8ep7Du2erMyWW2sdC010MMK9vSg4D+NaHOlgG/yr
	 XiOM3OmtRm1QJoWPKcwYUSK52EF7YSBqZn/UXwtYw1oazRlrq0YYScRYM44dU0T6z3
	 AeLpXxSFYEQ5CjILM4U763KcCBSi8l4+IxTctvGlmSWaUB+XmSt1UW8PW/QNRIewzW
	 6WcmQy4uBLAcg==
Date: Fri, 12 Sep 2025 13:17:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yana Bashlykova <yana2bsh@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1 00/15] genetlink: Test Netlink subsystem of Linux
 v6.1
Message-ID: <20250912131722.74658ec0@kernel.org>
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 22:53:23 +0300 Yana Bashlykova wrote:
> This series adds comprehensive testing infrastructure for Netlink
> and Generic Netlink
> 
> The implementation includes both kernel module and userspace tests to
> verify correct Generic Netlink and Netlink behaviors under
> various conditions.

What is the motivation for this work?

