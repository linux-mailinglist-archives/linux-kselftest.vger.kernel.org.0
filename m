Return-Path: <linux-kselftest+bounces-25263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1621A20153
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 00:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0541885DDE
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720371C8FBA;
	Mon, 27 Jan 2025 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txqCkd5m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470301EB2A;
	Mon, 27 Jan 2025 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019048; cv=none; b=hRg8RfKWHSxLJv6j3Ys7mpBNBCirs6yd24+IMDTG2qQjsYGu9qwBevhGfYX7KfJUS/STxz0AxEGD19ivpczPOykFoq4Y3LZAA5R3ooed7uyp2PxOLtGc0gbXFLmdcdv6BoHvtiqZEpxWrodABXFQzopsNveVtOcHiT1GlDZMrIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019048; c=relaxed/simple;
	bh=S+q9E81fwjvKrr5avSJ7WQLIaON0+6nn+3UXi0+nD6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6OJzSDdzL9VlMHJhezt6ODxS5rnu0zaxl5XcbMqj6Fy8cwtiTFKReJyd1XJbL7Q01StfNkMIORxG39ZE2nk9UpN93TxP8MqtQJy0FIoN4NETOI6eYZz/atnHWLvuhtmt8fAsfrgqCaZmCRnrOnPdQPH+xKSb9vQSlzXoFBR3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txqCkd5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEBFC4CEE0;
	Mon, 27 Jan 2025 23:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738019047;
	bh=S+q9E81fwjvKrr5avSJ7WQLIaON0+6nn+3UXi0+nD6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=txqCkd5mzbFjjJ/P2y0kqLzWWIBI3E6S1lJeUqLTPpNlbODCk8lVD8blRDdt2lbaI
	 /Bj/W6NtS5N34ytC7TXtBQ4wVV1zj+oZCASaNknHjt+ytUzx4AO+3m7/J9UQCjuHOF
	 QqiHQEwaPGxp9c0Fnim9skvlMIphBO+rUQ2ArFyX4hiuOHYPcLGYTGd5mT/4JLW7yV
	 ZkCNoQEtGs9c8ArHA7uHNtydrfqOmFV2sUUg89GrKYSlPiGdbS0Ea2tUILwMDxmJzg
	 7LtolK7QwAK1lWO9ctrhcr4u831X80WXRoFevMS8f6JqglajQthB1FxD2HKZ2fGYAZ
	 u8d7ZrIgKn75g==
Date: Mon, 27 Jan 2025 15:04:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Jan Stancek <jstancek@redhat.com>
Cc: pshelar@ovn.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, liuhangbin@gmail.com, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] selftests: net/{lib,openvswitch}: extend CFLAGS to
 keep options from environment
Message-ID: <20250127150406.0d97a181@kernel.org>
In-Reply-To: <26ad0900-bd9d-464e-be9f-c1806b96c971@kernel.org>
References: <3d173603ee258f419d0403363765c9f9494ff79a.1737635092.git.jstancek@redhat.com>
	<26ad0900-bd9d-464e-be9f-c1806b96c971@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 13:51:27 +0100 Matthieu Baerts wrote:
> > -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
> > +CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g  
> 
> (small detail: I guess the double whitespaces after the '=' were there
> to keep the alignment with the next line, so probably there should be
> only one now, but I don't think this alone is enough to ask for a v2!)

Adjusted when applying in both patches, so the bot will probably not
respond.

Thanks for these fixes!

