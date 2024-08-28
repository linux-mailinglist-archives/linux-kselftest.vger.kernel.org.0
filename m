Return-Path: <linux-kselftest+bounces-16576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D55962FE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 20:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4189F1F268C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C81AB535;
	Wed, 28 Aug 2024 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvmtwZ9Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2D1A76BC;
	Wed, 28 Aug 2024 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869432; cv=none; b=KOo1hNnLyFInsPcwTVc7HVLL7eT58BDiVuXBitN1tbbBBUP3s8dBzvr2uNk3Yts3QANweOOTTHko2lFSJ6dSukqL+xWSvFhh4PciXrp84QGCyXFU2U3AAAKQeaqfmQm607+m4IBMs9M1ApQmRTgGw1HayA1VCprwRPKp8QM7dao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869432; c=relaxed/simple;
	bh=JmDmp78r8X3IiUi1UoutxU5gv4t1J0aVqfE1NBd3stk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lihGwf12MDu+qOHa8/R5oYBWDOAe9cJSaAXXMDhMzF4ZuwyrxG6iB6CPk6uULJu5i1ifZnB2diN+QxtkOesom3gxrOumunfKrrO8vRCQ0qYLt3NNjW3TzWmFqJSmrS8zcFYYFSYH7w/VqKM0CrjhtX++niXvJ15Ss+hNuN6Tjno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvmtwZ9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADDFC4CEC0;
	Wed, 28 Aug 2024 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724869431;
	bh=JmDmp78r8X3IiUi1UoutxU5gv4t1J0aVqfE1NBd3stk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvmtwZ9YtFpi6NhMtMO0zE2scJRoDP7AYOx5IBCGvjj2LDYnqbWRRMGnNvWPmpDTs
	 W63RXkVc49qBU12trYf9yKN6uvyQVFdn+d85KEGUPSxTsSTqMM86E//sh/3uwiJGgI
	 fzDl6ImKaHVmlhYe9ZJPhkfxVvQ+wxLf5DUMUh9ahKHh2Q/9xef7iKLcJiAZ0dA6V/
	 DyMKj04q5NvV/Xq1KgM/7JMcaGc9MyjGHgjO2j45+wZ2L0AJYS3D/NfYPW5ZyTCfOb
	 oS32V0i7mkaoI2SZgVt+0xJ849jQEA7RC+7GCJzOA8FYB7CKgNMjtHEQ5O0MBpU/0i
	 u3zAykea17htw==
Date: Wed, 28 Aug 2024 11:23:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240828112350.7b4ba8d1@kernel.org>
In-Reply-To: <Zs9cb1j88Y2glBdJ@mini-arch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
	<Zs87rhH9e_Lw-icJ@mini-arch>
	<66cf45bbd6a6f_34a7b1294ac@willemb.c.googlers.com.notmuch>
	<Zs9cb1j88Y2glBdJ@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 10:20:47 -0700 Stanislav Fomichev wrote:
> > As Jakub responded.
> > 
> > Indeed importing the whole application into the kernel sources is what
> > stopped me from attempting this before. Florian's nf_conntrack charted
> > the path here.  
> 
> Thanks both. I was expecting to find some build rules :-) But as long
> as we have this story sorted out, we're good.

FWIW I lied to you, the "script" for buildings things wasn't committed
in the repo, I pushed it now:
https://github.com/linux-netdev/nipa/commit/dde0f093774a4a4c85e595b5cf44bd3e4bd434d1

