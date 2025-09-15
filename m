Return-Path: <linux-kselftest+bounces-41543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7855B5884E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9E01B23C79
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 23:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3D02D838C;
	Mon, 15 Sep 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH7uZ0kP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB91229B36;
	Mon, 15 Sep 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978921; cv=none; b=kSV/o9Y4p0Adq81aFkwiGOGTEmxBeI46RV7OKsFmtADTy1jgWKc8zDacZBLGZCw13BlbqJKuudpxR3T8f6VLlVWqpWhsHOJQfeAze12E3rtmJmxnhFtlhisn7ydbrRJfbP8JxZ3ardF9ArbB2tUHLJv95i3xwgaQHRZYmxPIcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978921; c=relaxed/simple;
	bh=PA6UoBlSVe0qI71y4d+0FeBhLV3+k7F2gbm2YXxBHSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvbFthgT8gfgmbRz4Dvq24TzUPPvl1g2ERHBT2OgZ1nZ5S6fWWMey2tqsxiazTG38oamLsEOupV9xFpVizG1U4mC3ne676tXRQEx+w0MHcyrKU3DRAapgDa+EJqfc1y0RXq6I5QqfOpbB2RMeBRj2qLVXSRbwwjn+PVQFqZXTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH7uZ0kP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B325C4CEF1;
	Mon, 15 Sep 2025 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757978920;
	bh=PA6UoBlSVe0qI71y4d+0FeBhLV3+k7F2gbm2YXxBHSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hH7uZ0kPPtDZeqFuCChGGhnIQmPfE/I+l2jSOEMr5lN3oMVpQjpevALXKVAon98Rh
	 pBh8o5lRKjXUMjFTXf1aV4NpWIPjL0gYosArFnlxhM2rV2HP3k2SLp0EEHIOY5b0qD
	 OureWc6oIamF/uUl6RkszeHt99ZB9MWEbHI9Z/9XWaclhlyg0DDeAqPd+Z57wVzJMX
	 WaGF4+qZSQdRsBN9CBbcl5V+pygYkemNaQRAH+etJosOh+2ILRbRN35IlaP7DBkY6A
	 hfbTaNs/hMttI5IKZ/Gk8CWN5Aw6Xj2zAsUonvSkug+87rWwwLEB3jXloTk9GRSYeb
	 CqhRPj3BsT5hw==
Date: Mon, 15 Sep 2025 16:28:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v18 net-next 00/14] AccECN protocol patch series
Message-ID: <20250915162838.2d968900@kernel.org>
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 13:06:28 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> Subject: [PATCH v18 net-next 00/14] AccECN protocol patch series

I'll apply the first four patches because they keep conflicting with
other series in the CI. Please repost the rest.

