Return-Path: <linux-kselftest+bounces-22810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D14779E3276
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 04:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 625D2B23892
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 03:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67959156997;
	Wed,  4 Dec 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuvzM4jn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6714D6F9;
	Wed,  4 Dec 2024 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284456; cv=none; b=AWGqb5xU9UzBjWkqoIQUhyZTp98GvIVUCQ9rbuMzhFZDR6jCSwoT6MhAvuaLKso3//VWA6oGbxAsdihqj5uRRJQgQQyhPU9MPXc6mgwZZQouIVcVtgxhVF4sfGpqeZl15YhT5c0kUeOsfVj9P8SavlKN5x92YuEIC6iW7cwH5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284456; c=relaxed/simple;
	bh=JknuEuZPM6yyYs6VRhTlQ8rqiEEbje5m8a4CD73pXHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIF/U0N8ttyKEoGLVWAJMhx88GcBFHAYsqUnci7gcSR7J7amtaT6kJ8zN+PBb/CqCUyFhnriO+piZ68xe8IbfWQf9AZ7OnGKlBTYJSHc0YVANuZP0xZiAmc6vuVF36C2WFDP2rHaA33+MQdvsmwQDrtyZ+MzXHyYiHxh2PylgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuvzM4jn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5921AC4CED1;
	Wed,  4 Dec 2024 03:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733284455;
	bh=JknuEuZPM6yyYs6VRhTlQ8rqiEEbje5m8a4CD73pXHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uuvzM4jnyCTa2xYk/et+13qLnOFzVsaymRu30j1TXAw56T3K4hkWzzD0a3ihmU/tq
	 xxMEjaGpMxslF37V9IVmqXh7nPm7/VoztL4KPyQ+EnYgG8cct3cN6UPPSFLTiLaA74
	 pC2Q3l+qvpl6Hjaa7CUdsawowDjPHxNEvE9/uRmWcWEKvlrr+T42++VH/dIhigG5d2
	 vA/dM5COUDyVtkAjaIhb8LuNpQUIPRse2SpW5eDvIW7mOM8MFOyUGNxDrH0WpQlkc5
	 DP6KVFJ3rrk1hk13IfeE9tPL228vAVbOuC9eut9IGLBINylk+/iJfCvgHQlGG3+f5j
	 XXN6PzJNVFbWw==
Date: Tue, 3 Dec 2024 19:54:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>, Frantisek
 Krenzelok <fkrenzel@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Apoorv Kothari <apoorvko@amazon.com>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Marcel
 Holtmann <marcel@holtmann.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 3/6] tls: add counters for rekey
Message-ID: <20241203195414.5023d276@kernel.org>
In-Reply-To: <2f5b01548afb3795fb5f6aace6c2182ab98b9076.1731597571.git.sd@queasysnail.net>
References: <cover.1731597571.git.sd@queasysnail.net>
	<2f5b01548afb3795fb5f6aace6c2182ab98b9076.1731597571.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 16:50:50 +0100 Sabrina Dubroca wrote:
> This introduces 4 counters to keep track of key updates:
> Tls{Rx,Tx}Rekey{Ok,Error}.

Possibly track detected rekey messages, too? Could help us identify
when kernel blocks the socket but user space doesn't know how to rekey.
Either way:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

