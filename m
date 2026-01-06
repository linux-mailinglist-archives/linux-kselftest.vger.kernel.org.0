Return-Path: <linux-kselftest+bounces-48351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3AECFB4DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 23:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10A373004638
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 22:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE732EBB89;
	Tue,  6 Jan 2026 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUiT7U1J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126341C63;
	Tue,  6 Jan 2026 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740304; cv=none; b=QZNFaydRvI0rskJkbfy7vXORcPMGPyYTnWr3uhRhJh8LI7A8es4FKOO8Ay02eKBA9PYQTF4k4uA6KURgYFmFUcJoS4HjDBt6jRHMypkIq6udQ+eUTs830sLtDhg92cjeSXtjXiouCvM4ebAxGf/1a/JekqV78YKrJWoW0ukZWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740304; c=relaxed/simple;
	bh=Eqzf3y9jgNy6E/dgJ3LKlxzK/khxC21x5RUGmdWptBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ih/W73p9Vx+5CPFncBRABVSFYvX7uuP0q+6Ou61dFM/FTfDId1APJ4K2gxugIHZ8T/6tYE3fcwTGA2sQxzhX6nsCUJNq+uotNLUNfG/d87kURrJcnqS1YqR/+wDEwlLAmnZqpIfjjCpJ2GPJbSUWx2V3FAcK5t273l1PSSGEN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUiT7U1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA179C116C6;
	Tue,  6 Jan 2026 22:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767740304;
	bh=Eqzf3y9jgNy6E/dgJ3LKlxzK/khxC21x5RUGmdWptBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tUiT7U1J3Ok0cVOkwRz8L47URpzh2t63VU/O8iMuf4Bisgc6zFi1dUcm+9qVpthv1
	 9xrtlfcEp5jIHDwy/upiGfN5lEEIURWu6L3d+A2UiSzRuNaDHNTjpaPmwS6wu2Iv3D
	 yhxTkMtRQAqs8PoeY7WLuRqqadx6kQqOe+YvfGn/89O66Yv/3884+7gbQNzWkzvrn5
	 j9n7VYfVXOUPGbgZR7ibLZLEcxsZPEh1G7DcUO6hW55SsL77f8JUQZ4zRcVSgIJg1s
	 9cVzLHmwKTtxxYtDXBXKUF9mWrNOPxDpeMddWrgGIYfBddarqgeQbyjJaya7uM6mf6
	 7IR3x2hg0nXlA==
Date: Tue, 6 Jan 2026 14:58:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Xu Du <xudu@redhat.com>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage
 for GSO over UDP tunnel
Message-ID: <20260106145822.3cd9b317@kernel.org>
In-Reply-To: <willemdebruijn.kernel.3ae0df5f36144@gmail.com>
References: <cover.1767597114.git.xudu@redhat.com>
	<willemdebruijn.kernel.3ae0df5f36144@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Jan 2026 17:14:05 -0500 Willem de Bruijn wrote:
> For instance, can the new netlink code be replaced by YNL, whether in
> C or called from a script?

+1 looks like YNL is already used in net/ tests, and it supports
the operations in question, so that's a much better direction.
Please let us (YNL maintainers) know if there's anything missing
or not working, IDK how much use the rtnetlink support in YNL is
getting.

