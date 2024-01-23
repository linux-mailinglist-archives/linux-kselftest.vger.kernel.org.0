Return-Path: <linux-kselftest+bounces-3434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B1983978C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 19:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B132928BB08
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A181AA8;
	Tue, 23 Jan 2024 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Nfgg82sI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8B60EE4;
	Tue, 23 Jan 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034153; cv=none; b=aBRuUQvsouCPY8G16Env9SJg9m+rP7TYLkf6JRWnsFO5uAd6Gdc51fnTJq/3BYtXPfB/wj43m/UITCKDUO8PAsxdFQ6CYJUojqkMouenBKRshpniEAWsdMLTidBkf6qhIwIrzsBIHsg/ae7TSzzIDLwmWWohvDxBxODBrRx3cBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034153; c=relaxed/simple;
	bh=cNmqFK7wvZwbuS6t4Jro/2h2f6lm3N11QauIhjtbbSA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DREzd24jo/m99tf1CWs+QjNvJNnrNG1luovjE03Y8gKmrvOp8lCf+PjopAhMfQz6higeIyeGu7EhzhSXV4G/zeoUenVt/39SRfvvqCOMdL8QZquLUj6Bf1kn3e2ow12TDpFqhM4u9UW3ju/Tezt3slAd6qwPsSqo03Psvfhd4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Nfgg82sI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cNmqFK7wvZwbuS6t4Jro/2h2f6lm3N11QauIhjtbbSA=;
	t=1706034151; x=1707243751; b=Nfgg82sIXeFA74o3mh9axNjBJcSCgnaffHx7su73xcR9+Jz
	intivtZitP25vPNv5AVLAx/FP8dGu6pBlr7NBvmGbIvIASwBsSrDL03wK4UEjb9aLFaAjnyFLOsll
	Wb3YHyQsT2fGnAMr2TtzV8Cr+9uwRxOH2w21/oZYjf7KvZUrxNSW5pJ1lJxNkBn2BVGpDTWdUPuMz
	mb3CPgd7Tb1ZaABZab0Q+8WjemyKUjUBk7F2jZuEUFwKTC3ywaj+eey7a5R2rt9Z8IrDRc/rq9yG1
	Sn4yfrHnFSFYj7pZaM+Rd/ZE11WdO36QPaPBeY7QVdYw7TwhM1ELjpuw3cf12aqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rSLPo-0000000FAai-15H4;
	Tue, 23 Jan 2024 19:22:28 +0100
Message-ID: <9390c3aeb374e44810e0e93dd48561c1ef1a39d5.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-2024-01-22
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>, Lukas
	Bulwahn <lukas.bulwahn@gmail.com>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org, David Gow
 <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com
Date: Tue, 23 Jan 2024 19:22:26 +0100
In-Reply-To: <d4c1a7c715a1f47dc45c5d033822d8f47e304bd4.camel@sipsolutions.net>
References: <20240122153434.E0254C433C7@smtp.kernel.org>
	 <20240123084504.1de9b8ac@kernel.org>
	 <d4c1a7c715a1f47dc45c5d033822d8f47e304bd4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-23 at 19:19 +0100, Johannes Berg wrote:
>=20
> We're also adding unit tests to iwlwifi (slowly), any idea if we should
> enable that here also? It _is_ now possible to build PCI stuff on kunit,
> but it requires some additional config options (virt-pci etc.), not sure
> that's desirable here? It doesn't need it at runtime for the tests, of
> course.
>=20

Heh, in fact Miri just posted the first bits:

https://lore.kernel.org/r/20240123200528.a4a8af7c091f.I0fb09083317b331168b9=
9b8db39656a126a5cc4d@changeid


Also, should enabling that in
tools/testing/kunit/configs/all_tests.config go through our tree, or
better through the kselftest tree?

johannes

