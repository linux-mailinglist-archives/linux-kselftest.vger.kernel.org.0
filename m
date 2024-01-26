Return-Path: <linux-kselftest+bounces-3643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27B583E4DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908FB1F21C66
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BCB50A7E;
	Fri, 26 Jan 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkuaGWlc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713847F50;
	Fri, 26 Jan 2024 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307048; cv=none; b=VRrU64JVafd5MMcqk2aFIOaDcTQtfkGiR2MAV8wBuKB3g8bfMX8zsj8+xeHygjkTxCQT+fsGkFBaWxHd0SvkJU13wrtnfaKgPQilcUhHSDr1+ZRbvCqtEgN+Z5lfyAH4+zQhwpgay3wk68MqrZXFEJ/rdxiisCMRBhWoSjE7kck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307048; c=relaxed/simple;
	bh=2kq65lV1tfa/50j7TiZ5ooIVXnX5fWKjFZpkUNuod70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmEZf35YdZMhv/JhAUihXvSKoIhI5LvHOSWj3Gina6CGG2Sb61lwnA6NYKn0oWcCWKeLJfhnmGL9OVDpenE4yueqAUbAXccJFhNdmzlBw7mdT5KeauMg9lGNqXFGwliVk0u1R5Qla9nZ7rFVvdzY15QfmOhggEvh6ztus9txnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkuaGWlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2C9C433C7;
	Fri, 26 Jan 2024 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706307048;
	bh=2kq65lV1tfa/50j7TiZ5ooIVXnX5fWKjFZpkUNuod70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KkuaGWlc1XIoj9CK/BkSHMErpgSULJu5LWLSptWJ1AOsYUPPKocvrPlaN8LECSB8T
	 QBnBXn172DaozZRlsXbxNLbGTAxM8No99pfgnrfv+kvhsY7wO+L9QAAZmvpIdXY9U5
	 LjyQW3f+YuCITIwn6rDZDGIqjhTZq8hNES5DwRcU+KVJN/Xp0CAy7TerkdPwiITrlg
	 spySPeoGYaUkMJMVMzakBvdMSOqm1AWh5ziXIsWveyqhXq13PO6QRmMFuVpESrj0ih
	 HsBN8xYQUASctScjT+QGCDVYemUwuPGb/doWEK//s65wQycO1O8SmHPyHj6SzYYXZi
	 Dmp16aXl76xyA==
Date: Fri, 26 Jan 2024 14:10:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Maciej
 enczykowski <maze@google.com>, Lina Wang <lina.wang@mediatek.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: add missing required classifier
Message-ID: <20240126141047.6cecfb52@kernel.org>
In-Reply-To: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
References: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 09:22:50 +0100 Paolo Abeni wrote:
> the udpgro_fraglist self-test uses the BPF classifiers, but the
> current net self-test configuration does not include it, causing
> CI failures:

Ah, that's what the other patch was on top of :)
Applied (also slightly reordered), thank you!
-- 
pw-bot: accepted

