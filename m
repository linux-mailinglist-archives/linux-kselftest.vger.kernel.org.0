Return-Path: <linux-kselftest+bounces-41270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA368B53F20
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 01:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B06189A7C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 23:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849CA2D2489;
	Thu, 11 Sep 2025 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/IemM+u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C225D1E6;
	Thu, 11 Sep 2025 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634099; cv=none; b=UuI0MC3N9Bto9aOs34zzYEacM1SPuIuHFbvIc05rwh+vmWvWMzNuOu2LKAcx2wUF+1ZXkIhUIqfMU0zgh1fYGurEokxP32EVhY7Ftk6vbjUphmRlvjxlAzZGZEOrWs/U2bkoa/HjJqxvN+bXsRRwYzENPqCVpxgksv+5/YEOldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634099; c=relaxed/simple;
	bh=o666/70NeLChTgVfWpxXWVkLw+F2bVvwHJUC9iqefBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGRfvz7aN44iugoqK+Ccsv++9/wV2JcESkZSEdkaF9CuJIIkfnB1aZ+am7VanRK6avMzhfxg1oUItUa+oAA1yFVkMe7cwDnwn2pM6+PPiKZRmJOF9e+G69/u0KcYTuDXY0bXNUddo/e9eG9I0jZAum/lMxfI0c30sR9baaMjKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/IemM+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6515EC4CEF0;
	Thu, 11 Sep 2025 23:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757634098;
	bh=o666/70NeLChTgVfWpxXWVkLw+F2bVvwHJUC9iqefBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e/IemM+u5/LBk/0t6OUdk2FI52mPtCkDBqUYE3IrrIlGpKiiZoZHqCmIzxqWRiS6u
	 JNJgK2gJA38+UTKEd0hfMRqkWhZvP32jJTkTO9ihq/3dt1y8oBQ1a+NwOrluEoWZ+Y
	 kz8M1vuR8AO0CjBgV4ukOUoF52G6Jz41+ua5gKMu4fspj8Hmyk7wHZftWqpvz5hvLm
	 C4nIZ+DhPyk7++OlgFQbwZKJ8UTU+cvl5E0xw1X+ioAY8PaKF4xAkgE+3LkEhSX9YE
	 GLTQXFXafkSmoMDz6/H0/GxBbHttz8XrF9G+96vEyf5LUD13jVs1nXfC5AGmWJQSCj
	 AyYSzWGtNHdBA==
Date: Thu, 11 Sep 2025 16:41:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nai-Chen Cheng <bleach1827@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/Makefile: include $(INSTALL_DEP_TARGETS) in
 clean target to clean net/lib dependency
Message-ID: <20250911164137.29da651f@kernel.org>
In-Reply-To: <20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com>
References: <20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 19:30:32 +0800 Nai-Chen Cheng wrote:
> The selftests 'make clean' does not clean the net/lib because it only
> processes $(TARGETS) and ignores $(INSTALL_DEP_TARGETS). This leaves
> compiled objects in net/lib after cleaning, requiring manual cleanup.
> 
> Include $(INSTALL_DEP_TARGETS) in clean target to ensure net/lib
> dependency is properly cleaned.

Shuah, please LMK if think it makes sense for netdev to take this
(net/lib is the only DEP_TARGET today).

