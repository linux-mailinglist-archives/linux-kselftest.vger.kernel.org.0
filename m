Return-Path: <linux-kselftest+bounces-7955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895AC8A4F3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E950AB20C75
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE516F510;
	Mon, 15 Apr 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqA1Aq3O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E66F099;
	Mon, 15 Apr 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184801; cv=none; b=p5jwbFMd2rwbJDGzdfi4O0Y+8vbqSdx7jvW1dqrw4dD4unsrSO14pfI4DNftFI0as2VXwd6ugY1YlwsU9pIPS4/tc1KBOeVDmWIkEJd/EtcXPDDev3q9aA9QWCQ8IoqB6Kdvs6kxlZPpLVgEjgRXD6KQpivViRHo0mzj+MnAyBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184801; c=relaxed/simple;
	bh=jB1VosGsBUY9JV4PCO88etUHh/BTyK+8rKZfGP3r1Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyxLjhOPBIawq1RmY/tt3YO5x7CY+wCNlUOIlllk6T+e03kWr57xgJzud/HH3fcyyOvGVysOIdIGQueRzlPwqTtaUz+KKwjtFK05H3NKTbygCL5sL4kxcH8JYnQa2f3pOUiEibIuy8jbRqVEMJuGbRe4ohETH8haU+M3YPxd4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqA1Aq3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7658DC2BD11;
	Mon, 15 Apr 2024 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713184801;
	bh=jB1VosGsBUY9JV4PCO88etUHh/BTyK+8rKZfGP3r1Jw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HqA1Aq3OViuzcfMzeQgvUOfBstHNrGTcyCFhjdikApjR9A4rkRr6HUgR+GTVv5q2m
	 Y/vMLoG797M51FHocs/9U1Sq+hovi5MMqO8Q0NCehwTSdiN759c3ucyN0V6RXIykbe
	 6h/yi88cjqNA887LEeAfnMBVZXt4A+ki1mJZafSts+XGs83XHsvLn/rD8DWJj+cOk8
	 SMbEuSj1621QrwcJt8HKnJ4RG5AGN9DwQN6qJ382mY8wM/ye4DhE/2CY4nitJXbm5N
	 pQsfFd7uSBuau/HtZ36GY4pZ0Psomdkn+eLdfI0GQ07DDXP/II0z1W6jb+u2fkqNsj
	 yBWVi+GPM8xew==
Message-ID: <7ea70d7a-38e2-43c8-b45a-37fc800edce3@kernel.org>
Date: Mon, 15 Apr 2024 06:39:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/10] selftests: forwarding: router_mpath_nh:
 Add a diagram
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, mlxsw@nvidia.com
References: <cover.1712940759.git.petrm@nvidia.com>
 <2f82d982bf2a7c23dbd8ae63e94c3655ce9f92c8.1712940759.git.petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <2f82d982bf2a7c23dbd8ae63e94c3655ce9f92c8.1712940759.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 11:03 AM, Petr Machata wrote:
> This test lacks a topology diagram, making the setup not obvious.
> Add one.
> 
> Cc: David Ahern <dsahern@gmail.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../net/forwarding/router_mpath_nh.sh         | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



