Return-Path: <linux-kselftest+bounces-31908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF54AA13F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 19:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F9B1889363
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD8241664;
	Tue, 29 Apr 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLcKogF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A4211A0B;
	Tue, 29 Apr 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946438; cv=none; b=s8riRC4V1fArO4l3J+T8vzklhY+Zt4y7obGIUeeyHLW1GjshF2zEPpR4J/i8aPCPTfUyu2VquFSFC4IjTbmiI213QRnlkJOuILTrv730W3OxcsqNaAFkT1VyJZJGrxOjnvJXOu6riC0msB3Ea62W5AhbmJZ/jevubytoU+rfIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946438; c=relaxed/simple;
	bh=P1kkf866KBSK4l53ZwwH2bEg7Fv4bcFit4Cr+A/39XM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bK0AH47Vb5XuIIS8hGoIhSZfeEmYP/3nybQexASbYYRMM/lCp8vUg6vOZVyRThVYOqFHuG/6t1/ax6veMw8J+MiGtE+CzRTmyx/QsAEjTvACVcXJ27WLjyeEryxGL/IURsjM2v9NrYOLme7g6F069/AIpKJqJ67UL9FZ7Dr37H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLcKogF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6679AC4CEE9;
	Tue, 29 Apr 2025 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745946437;
	bh=P1kkf866KBSK4l53ZwwH2bEg7Fv4bcFit4Cr+A/39XM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JLcKogF7t6ZQVkrhdNXiTrAVeJ3A2UVP4pDE3/aL06+5LCnkvSSxeknFZQI4YGF1n
	 HK7Qga4FJkuyy/BwueQvj8Wf5PhmYK0sCdMMenFg+tyBjQ7SIBan+2xGQRTUzrfNZX
	 vD0G84VXCgGBVYxrjuuMDw6jIkiFeOr025VgsF4JNTkF1aL84hXSp5gv9qNUUn25+9
	 fKoKGh08daRZUTuXnAd/wlhL3dVLZZFSN08RKpPGkZr8ZIhOdwJXBZXZfjknPdvTi5
	 PhdTG0IXMMj2UTV6SDPbZQRE4ZgwVjsDmyByQtVlPof60w8KNQMXh58NbKqBWs1i3q
	 yF7FTVjCijPfg==
Date: Tue, 29 Apr 2025 10:07:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com, willemb@google.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: exit cleanly on SIGTERM /
 timeout
Message-ID: <20250429100716.7f604a06@kernel.org>
In-Reply-To: <68102b0477fcc_2609d429482@willemb.c.googlers.com.notmuch>
References: <20250425151757.1652517-1-kuba@kernel.org>
	<680cf896280c4_193a06294a6@willemb.c.googlers.com.notmuch>
	<20250428132425.318f2a51@kernel.org>
	<68102b0477fcc_2609d429482@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 21:27:32 -0400 Willem de Bruijn wrote:
> > > A bit ugly to initialize this here. Also, it already is initialized
> > > below.  
> > 
> > We need a global so that the signal handler can access it.
> > Python doesn't have syntax to define a variable without a value.
> > Or do you suggest term_cnt = None ?  
> 
> I meant that the "global term_cnt" in ksft_run below already creates
> the global var, and is guaranteed to do so before _ksft_intr, so no
> need to also define it outside a function.
> 
> Obviously not very important, don't mean to ask for a respin. LGTM.

Oh wow, thanks! totally didn't know that using the global is enough
to add something to the global scope.

