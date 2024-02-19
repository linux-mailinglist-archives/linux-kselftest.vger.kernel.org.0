Return-Path: <linux-kselftest+bounces-4943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE585AD2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 21:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3F51C223F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 20:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260AE5339E;
	Mon, 19 Feb 2024 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+/PvT2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D82524B1;
	Mon, 19 Feb 2024 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374537; cv=none; b=fOrPvRdWmAZAlduX5iGM9E4nimeLPS9W0FcnioJE4Me6glS3PGN8RtV6pjDOlxiz0FZk9kdRLMp6MDjmVStznI6BWsNXE7bcsMIQm5WCNoZO99bBpoQNeGppKj4AJWCXYnEYlf8a/zLBi3Xg4oP6OVTOHPLMjGODCR/TmaywTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374537; c=relaxed/simple;
	bh=Dfn0OfhWGIoYuprurDxmGKgCNS7+424UotfKzhkZg4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2cF479I6hqLkp2Lc/FoJqrxAWQUaiI7D2HM+TzH1chq8eHtau4qhJFhGI+fKIY2HZi9ExLC7XpSLaoXrko7/N4G2+aSZVG1yeY2NBUrgHW0pjUfThnxevG6Org8Ia4xXNJGewynAb7mKnNDoQ+6qdjtMUVTq7R/bu0BpE78fNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+/PvT2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EA3C433F1;
	Mon, 19 Feb 2024 20:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708374536;
	bh=Dfn0OfhWGIoYuprurDxmGKgCNS7+424UotfKzhkZg4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s+/PvT2Bug/Wjruc1JbqZdGCxSNYQfT5D5hBlgNh4L8WjHGhMLJpj+nUG0AqqDFIT
	 182gJTDnHhkJunNAjuam8328VXZzNUta2eij2PlHpRFyrN4ixe54t7lMw5mXexZG2Y
	 tBYHpHahhartIVT9CiBLz+MDNcMuxwIEiF4l1/XRvfb/kY47cWNkvMnFx78tNTF5Z6
	 2SkFm8DygF0uM9x8yNbS4vQH72S78C4d30Zc45fi3C3bhgH8fv1lrurgMi5vu1Pncz
	 9XTshkwe++KllRYeqYS4meoRLB/71PwZmIL3xnvFC+ivlev9Lln+Dl28BgR5G5+oxl
	 BQtWt6i369oCQ==
Date: Mon, 19 Feb 2024 12:28:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pravin B
 Shelar <pshelar@ovn.org>, dev@openvswitch.org, Ilya Maximets
 <i.maximets@ovn.org>, Simon Horman <horms@ovn.org>, Eelco Chaudron
 <echaudro@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [RFC 0/7] selftests: openvswitch: cleanups for running as
 selftests
Message-ID: <20240219122855.1f1ad0ac@kernel.org>
In-Reply-To: <20240216152846.1850120-1-aconole@redhat.com>
References: <20240216152846.1850120-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 10:28:39 -0500 Aaron Conole wrote:
> The series is a host of cleanups to the openvswitch selftest suite
> which should be ready to run under the netdev selftest runners using
> vng.  For now, the testing has been done with RW directories, but
> additional testing will be done to try and keep it all as RO to be
> more friendly.

Would it be an option to make the output go into a dir in /tmp/ 
instead of in place, in the tree?

  mktemp -p /tmp/ -d ovs-test.XXXXXXXXX

or such?

