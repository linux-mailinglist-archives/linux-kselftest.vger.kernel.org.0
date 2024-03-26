Return-Path: <linux-kselftest+bounces-6598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCECE88B649
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 01:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BB12A4068
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 00:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723711B285;
	Tue, 26 Mar 2024 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVpbXJc+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E458A955
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413828; cv=none; b=rBzfYt7EjS8Ii1g9KTJXa3Yz5HQzwj2XYxhC9ufMPDJL8UgKsCwGRk2v8zlHezsDCIN4uATPPb485T32tgY9facRb5Imof19pIEYusgUUD1ws494jLRb8HSo6CTtkgvUffWOZV8RJrO3tU+zUkZuqri+MkFuDn3lpNNro6LQwGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413828; c=relaxed/simple;
	bh=DOS6C6+i6YqBYc/2+sEHzgL2uywR/BcZehjv6Sk0otI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cw2XWY1Vs7C7w0QfCcZ0qidSFmccmERMPT16Ulut48qQfKaDkZvrYX9AQUNlLDv+JHSgpr27xRgbEIPg/xhCPWfeqqTWMEqrhhSSiFy5Ps0dYGktCoGHJcuIPrWPrmHxEBM48QAfs7mlD8Fbh+5lfDS4zi4Rl91kd+yInxgLMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVpbXJc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A056C433C7;
	Tue, 26 Mar 2024 00:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711413827;
	bh=DOS6C6+i6YqBYc/2+sEHzgL2uywR/BcZehjv6Sk0otI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVpbXJc+gQ8B5BjmdIXr9qRglN+zwdBd9BkZ15PPKNFJWOhh34X/DRtGYf2rIb9Ye
	 z1i/JhJ71jlBT+DxCeSO/lBFpqUUcCoetB1n4kgWgV0HmGyvL5URddLKiw6urLPKUG
	 vqjzah2hAW4hc/6ZR8T5B9TZccW8fgel45iVMgdot/MW5YYeU6AWC4fJGc4KnYh7Ek
	 0JNnPjugWThs6SwPz8R1IDwJvTVqh5AFBecv1KGfQ/K/72KNWPmJjsdg9FEG2lJv+/
	 gK4YiRi9YtzmxVTKuVXlMpF7njWxwRGcMz6BnUTINfYA1Z0yXKhAo2HQdORcrSDwVh
	 XwwmZ7O5nSmjQ==
Date: Mon, 25 Mar 2024 17:43:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <nbu-linux-internal@nvidia.com>, Shuah Khan <shuah@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, "Ido Schimmel" <idosch@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH net-next mlxsw 09/14] selftests: forwarding: Have
 RET track kselftest framework constants
Message-ID: <20240325174346.2aca1bc3@kernel.org>
In-Reply-To: <fb7c72469b1d51556914b8a4ba3b7dd6e16815ec.1711385796.git.petrm@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
	<fb7c72469b1d51556914b8a4ba3b7dd6e16815ec.1711385796.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 18:29:16 +0100 Petr Machata wrote:
> +set_ret()
> +{
> +	local nret=$1; shift

May be worth throwing in a comment that $1 must be a legal ksft ret
code, not any exit code from random commands.

