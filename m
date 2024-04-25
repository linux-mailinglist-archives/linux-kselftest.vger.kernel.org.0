Return-Path: <linux-kselftest+bounces-8890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E358B2D06
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 00:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45691281AF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DFD1553BD;
	Thu, 25 Apr 2024 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBtyv2U9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CD25A0EA;
	Thu, 25 Apr 2024 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083773; cv=none; b=FaWq/+75Rix8bKk4fMrIsZGm1CjQm17nYWE0b4qWXg6rofzMZ8erlRAxKTJUUfeJ4KQ+CYShd+6MdYXm1l8AZ/oBuqHP01qAEV2Ei5rgRwjtojdGjwSK2f9Vxw2asy62L3RQuOxUifXjia9LaqOr5exztQYnsd76Cf6ZnatpjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083773; c=relaxed/simple;
	bh=xlXK/K/8hbLvzhTKP2jrmngieB3J6JBqicunSETwrNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca14Xu6T2wQZLMedTZ0xbcyAdcxVm9zaKlOGPsQxQhV72LYzOD7f+MkDQluDLqZHvP8c1DkhmoefSYzQWqAL1Z1nO9lIjuXDp41d3UVFCIsgspZtoku9+fcaJf6jsQQcQNIF5lE1p5N3ljVd8uEPrirIBrHgU/mSPO89UX/7MuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBtyv2U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B48C113CC;
	Thu, 25 Apr 2024 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714083773;
	bh=xlXK/K/8hbLvzhTKP2jrmngieB3J6JBqicunSETwrNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kBtyv2U92vgnjG6HR2uE35Bv/yvHuf3U+j36Xt+D9GgYtVoOosaNGpiVxsp6bnB6J
	 HiefiybYDpLPd/b26T0Y1J5Ge+NdeK2wDYJuIiKoNT24kqzeN0LnOh+O/CqIqZyX5o
	 EY0xMSjBODHVKsuzXNp7Dtb8surQURr3DJ3jm9Ja2LVUxxKX+nd9VCeb/ntcmm8CIi
	 qoNHKMmrSer0ToLEEGdjNkR55Ut2ew2EWCleM2ydeuxK0JGLdDuinLHgn3dxt2CcsD
	 EVuBXex1DwRCDJ6lCM+L+/trSMclfasavjwUel0qlH8sP23kibiZNYtp3gNzPOX3kb
	 srAz7PwgAhGxA==
Date: Thu, 25 Apr 2024 15:22:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] selftests: drv-net: round some sharp edges
Message-ID: <20240425152252.1eb4b01f@kernel.org>
In-Reply-To: <6629b5cdb68c6_1bd6b0294c3@willemb.c.googlers.com.notmuch>
References: <20240424221444.4194069-1-kuba@kernel.org>
	<6629b5cdb68c6_1bd6b0294c3@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 21:45:49 -0400 Willem de Bruijn wrote:
> Left two minor points comments inline, but nothing important.

I'll respin, apply your suggestions and drop the unfortunate patch.

