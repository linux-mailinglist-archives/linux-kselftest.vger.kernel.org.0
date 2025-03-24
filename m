Return-Path: <linux-kselftest+bounces-29697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E16A6E314
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 20:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FDD3A475D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCD266F1A;
	Mon, 24 Mar 2025 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsEJ/yHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561EF266F16;
	Mon, 24 Mar 2025 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843360; cv=none; b=T0uq7ID6CT+0W7mqsMVgmK47Ye8/YYBfBR5SGF6CHAtVDLSmzT9zhdqWzd+SIiyzLL7CmmP/aFkEvlLX2etcJJjtdmNP6uaBRslM7KRaMakQGtCL6Q8TVUGL6H207fdY3vEhRIlF9e0iOOcCRw2JaZHMMg0JC97rMkzw5TCMqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843360; c=relaxed/simple;
	bh=Bq1pvDnmiAJ7jDDDjsKuvbcMRlZSu2musSJBtoGFzlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuwhgcoChm54EQI38pOHLdmS4Q3sCDyUFo9D7eN0KLB74uv6XYRi1nyCMDouHDnHWvBA02XsEqEpgUOL/blH25OgZLNG2B6GzMqvnYdJehb3aoAdLKp+PiNgvBNMFuy2hiCyy0QvPRn4lCJuvp2mSGHD78zkkH+nBiolPjftEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsEJ/yHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6892DC4CEF0;
	Mon, 24 Mar 2025 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742843358;
	bh=Bq1pvDnmiAJ7jDDDjsKuvbcMRlZSu2musSJBtoGFzlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WsEJ/yHarZEk+dwb/vNlkd33ViuEiXPb6vtFbELxpOwiNUvxhQSVfV5N+LzJraQn1
	 vUf3+WC88vGuy6MPlYydRZ1LCo8uUhM5M1VMYTO5kUB4FSX6lr4ax52wJaOjT3VouJ
	 /3tF73F1zuFma97IFm6MUwAYx3gB5/PokVaGMLcFk3w8g4gsBjjo3DsXl4FZ3oAcN+
	 LXAhVQUck8j7PSfzmH9wMwAAtLDoavlaEUJZx4Hjj5eJKmvmhfLWBO3FQdCRlpPICI
	 ygpmqEBDgxHU9PxxqhHBpUwxDEaY3En6jB8u55vtuyOaQTmlM2omHr+KLURL9cpogU
	 CFCK6rwtYvzgw==
Date: Mon, 24 Mar 2025 12:09:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v2 net-next 00/15] AccECN protocol patch series
Message-ID: <20250324120905.06dcabd4@kernel.org>
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 01:26:55 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plese find v2:
> 
> v2 (18-03-2025)
> - Add one missing patch from previous AccECN protocol preparation patch series to this patch series
> 
> The full patch series can be found in
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/
> 
> The Accurate ECN draft can be found in
> https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

Does not apply:

Applying: tcp: fast path functions later
Applying: tcp: AccECN core
Applying: tcp: accecn: AccECN negotiation
error: patch failed: net/ipv4/tcp_output.c:354
error: net/ipv4/tcp_output.c: patch does not apply
Patch failed at 0003 tcp: accecn: AccECN negotiation
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
-- 
pw-bot: cr

