Return-Path: <linux-kselftest+bounces-28445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D4A55B54
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 01:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99AF3B5039
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 00:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE13320B1E8;
	Fri,  7 Mar 2025 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWLOl93m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85243205AC3;
	Fri,  7 Mar 2025 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741305618; cv=none; b=Ee17SF1z1P65lfFeObVBkKlNICEPMC0vqBGZm4xyTWZ4pOmxFREaYTjQoq+q6A1CGDV9VkifsIXChFYMv2LZXwB6vOsSc0Bn4DCAW63zw4Ef12oiLwCxK4hDHY3QCu4jKi/r0CM6rkTVQuMH6XKiiiILBsJiUHCwbGD7hWpa2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741305618; c=relaxed/simple;
	bh=FItWwzoS9Lbo2L/BMi14HcuJ9QdtDuU2oO98zy6iKf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPTSRC101CpeFCUaQwE6MNYD6mtknqgJBh8Qi3f2Z1B/giHBNSa+DxEqSiSjW7Dbs6CC56kefZAS8dzEaIHpGTngOLNbanBNTW9qzpHzZ8bws8p4apuhyIQnlE07jb9oG2j5X0B8SD62hc7qnM29TY0ijqMZyoDIVpneRsetp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWLOl93m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9110C4CEE0;
	Fri,  7 Mar 2025 00:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741305618;
	bh=FItWwzoS9Lbo2L/BMi14HcuJ9QdtDuU2oO98zy6iKf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LWLOl93mJHqGw4SEHsYpwhbBZukDSnlegW3FMgwkvrkreHweHjKD5bwT5LrDVO0+q
	 pNrnrSqq6jYccfEfux7FudVqXVoL165wEoCmf/zvAgEvDaEM0ELFYMtJCT4yVCiRMb
	 vFf63LgLlnPjwozGB+APzxhJljXRGore9DxuHZkDfun+k7jQo+wSv0RmbeWAw+WPIt
	 LvNEjWSjeamjkkA+QVw05DC62DuKG/cpuXQn0pXlZ9nK67rhibIPnY/XKV87LoxVbk
	 k2Bmh/fxaUslIyhiwAlvL3YsF5of73d26xmBblqMrIKmgIlINRJFCISEIGlVxHogG6
	 gScxHHtrRysfQ==
Date: Thu, 6 Mar 2025 16:00:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemb@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, petrm@nvidia.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: add path helper for
 net/lib
Message-ID: <20250306160017.1a385f6e@kernel.org>
In-Reply-To: <CA+FuTSemTNVZ5MxXkq8T9P=DYm=nSXcJnL7CJBPZNAT_9UFisQ@mail.gmail.com>
References: <20250306171158.1836674-1-kuba@kernel.org>
	<CA+FuTSemTNVZ5MxXkq8T9P=DYm=nSXcJnL7CJBPZNAT_9UFisQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 17:22:47 -0500 Willem de Bruijn wrote:
> > +    def lpath(self, path):
> > +        """
> > +        Similar to rpath, but for files in net/lib TARGET.
> > +        """
> > +        lib_dir = (Path(__file__).parent / "../../../../net/lib").resolve()
> > +        return (lib_dir / path).as_posix()
> > +  
> 
> small nit that one letter acronyms are not the most self describing ;)
> I would initially read this as local path

The other option that came to mind was to have one helper called path()
and pass rel=CONST to it. For example:

	prog = cfg.path("xdp_dummy.bpf.o", rel=cfg.NET_LIB)

Thinking about it now we could also store dir directly, which is
probably most "Pythonic"?

	prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"

Thoughts?

