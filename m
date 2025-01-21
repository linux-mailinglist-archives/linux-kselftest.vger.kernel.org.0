Return-Path: <linux-kselftest+bounces-24817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B580A1754A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 01:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D84D3A383F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 00:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7BF8BFF;
	Tue, 21 Jan 2025 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEy4iB9w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0A7464;
	Tue, 21 Jan 2025 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737420384; cv=none; b=lToGedKEniThE2zlT/Tg7WILEmGBhIMxHBKVEb9aXcZ8uEFL+XNohWGCsOxR6poYQPDrq2jaRbBPev2R5/ywaNX3bOmWjRp4TP7wR7pdK+muBO7p4nm/kz7cq8OjtaWAjJKZe0ejgcitjT4VnS7C/K6YTk2cr24WiyZB2Tt4Khw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737420384; c=relaxed/simple;
	bh=z1LrzfOHjxZ6uJgLi9v+gJvY9HLWrNDWS8jnaEMaYb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJy4ZocjbEhZtZ2mxMYOCzPyAzK619cr4FTpTLO3WG8Sw3K9yk+JudI9YIE4dkh7BWGkw78qfS/xIhqtiesUWtp8nR4RAYbTbGM8n8U0LkpGkuC53e2SFge46I2nHgrQKUZ1bUG3mNq0O88c5tEYMNC71CKHdNy+Ka1Oog25ZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEy4iB9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D163C4CEDD;
	Tue, 21 Jan 2025 00:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737420382;
	bh=z1LrzfOHjxZ6uJgLi9v+gJvY9HLWrNDWS8jnaEMaYb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gEy4iB9wMghfe9BhW0wPDueOXKSqvz7Mc2nZegknRTN6c5QviUjDpNwwnyFPnWjwL
	 ZZ7N/Q64mx9F8hvEZ1R1sQiJ6Iu4Z+HgyKR8xj0Tmo9+1HqFBupqiutqRaSKp6aCKy
	 0KFnfqzH2tyOUS1wjjAgzJ2PEy8jv7Tz55nkUWKvihkdAf4nXuxpDz9ehTp6pUJEgY
	 klc+OOSJr4iSFRDV1GAsY8Tvgm9ajIJ/XNVK66PM9XcZsmKrcPuL4lDQPw9bDMXIbJ
	 qIInabx4cXhaFRQoxqynaR6EiZEdmZof3ucBIGuKobiqN+Ayy82jKAqeilmu43FelM
	 UIFHu5IISQUSg==
Date: Mon, 20 Jan 2025 16:46:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu
 <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kselftest@vger.kernel.org, "Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?="
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next, v6 1/2] netlink: support dumping IPv4
 multicast addresses
Message-ID: <20250120164621.287af2eb@kernel.org>
In-Reply-To: <20250117081600.150863-1-yuyanghuang@google.com>
References: <20250117081600.150863-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 17:15:58 +0900 Yuyang Huang wrote:
>  include/linux/igmp.h | 12 +++++++
>  net/ipv4/devinet.c   | 76 ++++++++++++++++++++++++++++++++++++--------
>  net/ipv4/igmp.c      | 13 +++++---

IIUC Paolo's suggestion was to create a new header file under net/ipv4,
if you consider addrconf.h unsuitable. There is no need to expose this
argument struct in kernel-wide headers.

