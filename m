Return-Path: <linux-kselftest+bounces-48405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D78CFF183
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 18:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 885EE336B57E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5D534A785;
	Wed,  7 Jan 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzVEwdzA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3A34A76B;
	Wed,  7 Jan 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798838; cv=none; b=MjD/nBoiJdAG3T5hXozSWxCSncSosNteBnA5P6KuG+Rp30nJvqrrWdJEoLYO3NMDE8HK/I67d+VQsvefao4PR8mVzgCPsOOaQumL1Hg383QJj3qf8qXs/8X6s4uMrihi7OMkI6Di/5iDsRG8tw9RKrQHQOm6gg7ubVghdhfdvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798838; c=relaxed/simple;
	bh=v4b18UtipHE6LMTKtAqRsOch/ufQxjoOOq35WzPJAFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J/Hl2oS2sszHXTPl+ip190kXS0oMuhyXnPMbWD2rVogPjVlU8LaQztwsreu618EM82DbqxS8XTSUZ6OfAODfneOA/kTqioxiQ40pPFdrXKXj+A59EtOtkHLx+FMrK2weawTUyt+7KXjfyPOHNOq/j4kpdV210twtmCOojBaAfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzVEwdzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4FBC4CEF1;
	Wed,  7 Jan 2026 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767798838;
	bh=v4b18UtipHE6LMTKtAqRsOch/ufQxjoOOq35WzPJAFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XzVEwdzAd9ND0IAujCqm463x0U7wM5Sz/D8e0yZy46dgULImMkFgMiGxzh05ybAzv
	 +VR9xVaule8Iy9/qutnP0N4EzF+lkhGZyz2p2aphymZuJ/NsYG6/MYR37Tk1qaSrXC
	 65uBa0wvODQe/b992xyntkQqJJIGX5VsPXLVcQXnfzT7G84Kr5Hy1T2fnwXQTNAU/T
	 W/+AHto7Dr/eiyd28Tg/jxIVlzrxgz4npoZtmMxx0DI3ierZj0Eo93UJPf0KUVq8AC
	 rL2T+hkn1c63zFVTb7W5re0b1yw3wGqIt1Z0a0NXUJcZnmyoNVk3Kv2ieYhcRZ4UZm
	 77IDFZOl4TXRQ==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>
In-Reply-To: <20251222-wip-hid-pressurepad-v2-0-054ac9689bb7@who-t.net>
References: <20251222-wip-hid-pressurepad-v2-0-054ac9689bb7@who-t.net>
Subject: Re: [PATCH v2 0/4] HID: multitouch: set INPUT_PROP_PRESSUREPAD on
 compatible touchpads
Message-Id: <176779883659.3436366.1608867230221882776.b4-ty@kernel.org>
Date: Wed, 07 Jan 2026 16:13:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev

On Mon, 22 Dec 2025 09:43:33 +1000, Peter Hutterer wrote:
> Nicely enough MS defines a button type for a pressurepad touchpad [2]
> and it looks like most touchpad vendors fill this in.
> 
> The selftests require a bit of prep work (and a hack for the test
> itself) - hidtools 0.12 requires python-libevdev 0.13 which in turn
> provides constructors for unknown properties.
> 
> [...]

Applied to hid/hid.git (for-6.19/upstream-fixes), thanks!

[1/4] HID: multitouch: set INPUT_PROP_PRESSUREPAD based on Digitizer/Button Type
      https://git.kernel.org/hid/hid/c/2b29a90131bb
[2/4] selftests/hid: require hidtools 0.12
      https://git.kernel.org/hid/hid/c/1d6628f7f279
[3/4] selftests/hid: use a enum class for the different button types
      https://git.kernel.org/hid/hid/c/4f36fdab084f
[4/4] selftests/hid: add a test for the Digitizer/Button Type pressurepad
      https://git.kernel.org/hid/hid/c/f287ba5951a4

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


