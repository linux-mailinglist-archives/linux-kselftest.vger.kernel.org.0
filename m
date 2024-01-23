Return-Path: <linux-kselftest+bounces-3437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24786839B48
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 22:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02681F225C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDABF39AE5;
	Tue, 23 Jan 2024 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnpLjQ59"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA8442F;
	Tue, 23 Jan 2024 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046176; cv=none; b=V52i/RremWrmDV5Dm8obztoEH/7sv/oxNQ7VewcrX9m8Wq/IRRMboWPBqlmffpTHdKaGGmViv1+mbnVFS1VqBPFt0Ud5naO/zZLb2UnIr2gdv7OKm3IcD1tOMV0jInOQDHEBZzCIIyksqdSTN4HiXbXc4ExUtDuL2DeYPPusYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046176; c=relaxed/simple;
	bh=NpQv4S8oPU0k3iSrzk5lY5kY5ErVmyclbPIdZ/b3Mdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAfGwlom+/f4ZQxODYmVYt21VQWIY7wRzo6eXsdjW9zlsDO6g3+hrU/pSbX0XrzTm3GIVRzEGQgpU6JjTZOYPYvBUR50mX0Nw6pStRNYK6Z4067vR0sbrXBxZFnYanL/tD2PFVVCs5OPXlICnlyXcZa7Jfrlz+fQagbkTT2vcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnpLjQ59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29041C433C7;
	Tue, 23 Jan 2024 21:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706046176;
	bh=NpQv4S8oPU0k3iSrzk5lY5kY5ErVmyclbPIdZ/b3Mdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VnpLjQ59l/FGxHgTBTWwHvfhXNNYiMoQwjFCTnU4s2KMeLWDKm61gCzy3ASAVqX7P
	 DlqSsELBEPkjK0/rttNqaiL3AEOj8P9yV1lNWdh8gZjssuXDos84NuQe56azVCowVR
	 JC8Kx6jts38gLxw+YUdmh3scK9j52Z6cw6rQPr38VF7xqpuvxRC0IWZt0WoNefoLMx
	 tQUJ1MAlGcRX1o9h/icbc0LQ6tEUM/zi5L4Yn3MX0OLWS6lInEV0NDSrpAH+IXRr7s
	 VGvN+vHhQZ44sJVh/OzIF4gkexfxdb4YJff3hHafgVs3XFx7nurMxBQL9JAijRUg9Z
	 zL3nfD69SX4vQ==
Date: Tue, 23 Jan 2024 13:42:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, David Gow
 <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
Subject: Re: pull-request: wireless-2024-01-22
Message-ID: <20240123134255.3eef6fd9@kernel.org>
In-Reply-To: <d4c1a7c715a1f47dc45c5d033822d8f47e304bd4.camel@sipsolutions.net>
References: <20240122153434.E0254C433C7@smtp.kernel.org>
	<20240123084504.1de9b8ac@kernel.org>
	<d4c1a7c715a1f47dc45c5d033822d8f47e304bd4.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 19:19:35 +0100 Johannes Berg wrote:
> Looks like that needs adjustments to the config file there, mostly? I
> can see about adding that, probably not that hard, at least for
> mac80211/cfg80211.

To be clear I was mostly thinking about mac80211/cfg80211...

> We're also adding unit tests to iwlwifi (slowly), any idea if we should
> enable that here also? It _is_ now possible to build PCI stuff on kunit,
> but it requires some additional config options (virt-pci etc.), not sure
> that's desirable here? It doesn't need it at runtime for the tests, of
> course.

but curious to hear about driver testing recommendations.

