Return-Path: <linux-kselftest+bounces-48272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2ECF6630
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 02:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B98B3008F5B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 01:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A97B1A9F9F;
	Tue,  6 Jan 2026 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcsWiQrY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AC53A1E86;
	Tue,  6 Jan 2026 01:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664627; cv=none; b=G3jfyRCeJDrdpp9i/mkdGn//YIGc1unIN2oBA+5j2S8XtSjFIq/coFMb7fCyqoTE8cEUzvbBfo63U8xpT7vomG1ArZqu20OB8DdW2M0ZHjtRZlzC9BrNWS+T+GgYXVF3BqTgaNf7suK+YZTDehcWT9FOjS3ouw9PIPQ1RHtxE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664627; c=relaxed/simple;
	bh=LUCZvqk1WdSGXvspAPM9TM0I4FsNXF8+Iw2v1OJ+IKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0IsdhGIGToMFGRF6d1TCs8YkSkP7H3Ibj68cYNxCrIRjj36Ejmz1RDD617WrhxjiFl0UNRCMOg37FQedw/cGdJ6yNV/u1c4HZhaI6+VrCJZw3yx70/y1LoFeGo+KffsNqVPfH0vwZrWh2aEPsJotqoICQ735COw2XNv9aYJg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcsWiQrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50651C116D0;
	Tue,  6 Jan 2026 01:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664626;
	bh=LUCZvqk1WdSGXvspAPM9TM0I4FsNXF8+Iw2v1OJ+IKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TcsWiQrY7f/AMxoq8B7609tONlNpdj5GNzT7nk2F0TnTndfQGJJkDi9KeAz4uYOi9
	 ZqqcROfht0g/QXTWvSfJB14AIHzEQBYbBK8qiwZoFVjiJo4gFsFj4GxbSkGrSUZocl
	 SIVAQDIIm+4bwu4KXLr9lA/O2ExhSDdyq0C5O7ThTCSt/Xea9ZkQPZBRxgtzQkEjyz
	 0k4VXHJ2TytVauYtiivhzbxwZe6qPJQypGrc0fx5qGucuw77qwZ1DiqK01iaGIIXon
	 Rm2L7+H2YoRXipBf0BWgEsflCUa6nnvyAYegLqtvAXBSf1ylcJDFu1i4Wu7mEzLw+3
	 5katVhvynpzow==
Date: Mon, 5 Jan 2026 17:57:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xu Du <xudu@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage
 for GSO over UDP tunnel
Message-ID: <20260105175705.598c8b0c@kernel.org>
In-Reply-To: <cover.1767597114.git.xudu@redhat.com>
References: <cover.1767597114.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 09:35:13 +0800 Xu Du wrote:
> v3 -> v4:
>  - Rebase onto the latest net-next tree to resolve merge conflicts.

I just told you not to repost in less than 24h.
As a punishment if there's a v5 please wait until the next week
with posting it.

