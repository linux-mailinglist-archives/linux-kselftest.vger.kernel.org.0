Return-Path: <linux-kselftest+bounces-26632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADCCA3550A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E593AD101
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FB714884F;
	Fri, 14 Feb 2025 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNyeqlUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D013C67E;
	Fri, 14 Feb 2025 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501359; cv=none; b=QXWNGG+7wZzlU08g0y8WKXlKanXAhkz1rmhI/5LLORguahdUh4lVtjsaAwtsXffwTjT+pQ0/AcN/xjA/NvsB7uOhgsx2bX9kH1mKg+cQysvUnVnmB6ISTIkdR756UVSRA3ojnBIVBlC6SSLLV1/cLSw5I3cNUvI9llOdsxXv7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501359; c=relaxed/simple;
	bh=/aaQWg+YeEPuNctVbeajNUJMARTgmwKnAUAbqnJAsEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2/l++svvUW+x6LyCsbinY/zzZAlBpfWx5U+iJo8EomcFkGco+tKI9OsfS54JRSwEB+jxkP3uowMm5L/2FINRiBMVNbyxiBigInTfJI0SaqXdsc2EIX0piGMfFhfWIP7Jn6UVWKf8zRielYXUtCvW7JJhmukd/6+xHhUhnD3Ta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNyeqlUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DD5C4CED1;
	Fri, 14 Feb 2025 02:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739501358;
	bh=/aaQWg+YeEPuNctVbeajNUJMARTgmwKnAUAbqnJAsEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HNyeqlUOQpAvzZO22GqE9nrezFZ0FKs6y8/7IdZNJbUKWj+DIYc2ixwIHRjzFHRdq
	 3ok2huby0iOzi7Q96+TfOOm+HcXUlP5wji7YVgshCJdZBv1rs4Zyy1BXDuSv8ODQjB
	 E6oNQD+EafE/53+g/OKl1fmdCb4atxDwVRaCKGo0/QcCXMxCkWaKVqyCU4de2EoshW
	 34H522tz6S3HeDozH0ybzdU6phr/+BmaMh2Whqmg9lOXuCDeHHimpf0+ne1P4Z9xNy
	 vA9u544B7Kr9Jd5eplHGXj4PkWGTYGjX7CWU+qxKI+qf2CJlOP2ZTQF5ooyZR+2trI
	 0zz+PMfFqyEOg==
Date: Thu, 13 Feb 2025 18:49:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, stfomichev@gmail.com, horms@kernel.org, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org (open
 list), linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST
 FRAMEWORK), bpf@vger.kernel.org (open list:XDP (eXpress Data
 Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: Re: [PATCH net-next RESEND v7 3/3] selftests: drv-net: Test queue
 xsk attribute
Message-ID: <20250213184916.47735d95@kernel.org>
In-Reply-To: <20250213192336.42156-4-jdamato@fastly.com>
References: <20250213192336.42156-1-jdamato@fastly.com>
	<20250213192336.42156-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 19:23:13 +0000 Joe Damato wrote:
> +TEST_GEN_PROGS := xdp_helper

TEST_GET_PROGS is for self-contained tests
TEST_GEN_FILES is the right variable for building helpers
-- 
pw-bot: cr

