Return-Path: <linux-kselftest+bounces-29788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1650AA70C6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 22:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A268D174BC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 21:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192E25BAC9;
	Tue, 25 Mar 2025 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFRtPxx6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0611DD0F6;
	Tue, 25 Mar 2025 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939688; cv=none; b=aKjClFRkK6vTaICnViybGCjKK+F8UhaNADQ+sCbdMjNkGxM05ues5Loj3Z5MIYuRqCduT2AO/CxWg0ZZqVshYAWKY0SB40UM+Xp8ohexfCnXhDycaouZgvGSHlWEWZdwWC+jja/Rj8PzyBIvLbvk4OzjQZNJimrqoolhPd7kiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939688; c=relaxed/simple;
	bh=xxY53mJDy11RLGXH4SbC6QGMalVy5XEmiyyRgRTBCCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrhrlAyARAoXcDeJdWlRfArPHv++S4eCQEK1OlpFBYucZ3L9iuhAgVu0ZeOQ1MOwhr79IkK/cEDVBmtNef4hbZkmlwIpMt2/yuYf2ggphmXza4/uDj71by/2HEICJlVByBTrpyddOwW+j1c85bsP+CTLlp1GAyKrIM+4hsHg35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFRtPxx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E9CC4CEE4;
	Tue, 25 Mar 2025 21:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939687;
	bh=xxY53mJDy11RLGXH4SbC6QGMalVy5XEmiyyRgRTBCCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aFRtPxx6zodyLX5IgRqM2hVFearmuSJZ6oXqq0gUNGRMxc8dh5EQqVT0QZlyXIQ4F
	 etXT6i1vGeJ5RoX8EkRCINNDi3i8VT8ku5D4EZpdBrqzEzSeJSEf90GB+anLl4UoRH
	 7FZ+cJ1/yj+d36rbw+s4MnoP5+A9hlD57j74uR2wz2nI221xsN3sa4Mi/uZUt8vHWP
	 /rii2zr+aeHKQtFAxAiZSc5YF1Jl9qkr8Sd3UDTYAaoBmS/XJVc4aH7CpARh+BueKu
	 hLAcyUbh7E2YgFBnDHASK21zvo365fKEw/Zg6PeTkHWjqbP18g9HGV6OuIGetJcFhC
	 CvzEOeZ+y4CCg==
Date: Tue, 25 Mar 2025 14:54:34 -0700
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
Subject: Re: [PATCH v10 net-next 0/5] DUALPI2 patch
Message-ID: <20250325145434.6c4085df@kernel.org>
In-Reply-To: <20250325142836.47048-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250325142836.47048-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 15:28:31 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> Please find DUALPI2 patch v10.

## Form letter - net-next-closed

The merge window for v6.15 has begun and therefore net-next is closed for
new drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Apr 7th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

