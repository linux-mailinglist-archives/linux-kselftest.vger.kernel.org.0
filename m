Return-Path: <linux-kselftest+bounces-37065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7511EB013DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 08:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546C61C80081
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 06:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86D41E04BD;
	Fri, 11 Jul 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lOIUw6wi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522682110E;
	Fri, 11 Jul 2025 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216560; cv=none; b=aBi7iTSMi0SLZCjPn/vuKNNrjBi0GK08BHyQ1RBlqvbdectnJbEyZmx/iKG05CuOoCawpOPld/u8N/VLL9HrY96Mxa2FgNmcd5Plji+JLWbjpAtlWLNiGmaRIhyEom6WKunnXSgLHG8tXoJU6QcXlFuW6XGIvxLGdnToyvp1BuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216560; c=relaxed/simple;
	bh=44pCLGpLaIC4GmvuWhJV0PyvAaAXyESqQI2KW62Nrvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JygIDoqpTXnrO0ZnsoeZyWFExGludXz/Mjs8U7ohN3gzxS7HlPoOwvpwnSn4Vr0atbaj2/racbfTwZPAhHcmGXwMuvN6o72Uky1OnKLs9vpYlqrhnVBf8YmoLLLMfqLEPb1xSWArMiFtWfkIaSQQB2qesjM86P9wzPJCgbruEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lOIUw6wi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=44pCLGpLaIC4GmvuWhJV0PyvAaAXyESqQI2KW62Nrvo=;
	t=1752216559; x=1753426159; b=lOIUw6wimgs3mdats3vc/iM60lBMJQl8IIA0XLRVcN/9yVv
	Chf8ViZJqX3ycQ6ZL7YtRHmDEzPTWnyCA3P4J9RUVQrHJ22JnVB29QVV0SfEBWNg+RRzFg7O/Ly3S
	hg+o29z8CIn9yAUF1OrYKuRT8RgYsAR45HD68p1qdQaw8MwrBAy9vir2wAgM1uYu1ZBs14ktSe15k
	ZoTTZUJ+ijW2OtIDxQRSS/QR+u76tEAa/vsgAf4Cz9PdaJ6Fi9E91CIp3qInZDCEdW0QCbk8ZQZR/
	GdbW3zIJwQfhteRMpY4UEbegd37NsaSA5XkSpoXLIIJ9P4r8vkxD8hIrSc0dylkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ua7Z1-0000000FwWs-2LAn;
	Fri, 11 Jul 2025 08:48:57 +0200
Message-ID: <d88d15047569b57c7e7cd751670f56ffb4d5c1a8.camel@sipsolutions.net>
Subject: Re: [PATCH] kunit: Enable PCI on UML without triggering WARN()
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,  Richard Weinberger	
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Date: Fri, 11 Jul 2025 08:48:45 +0200
In-Reply-To: <20250627-kunit-uml-pci-v1-1-a622fa445e58@linutronix.de>
References: <20250627-kunit-uml-pci-v1-1-a622fa445e58@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-06-27 at 17:21 +0200, Thomas Wei=C3=9Fschuh wrote:
> Various KUnit tests require PCI infrastructure to work.
> All normal platforms enable PCI by default, but UML does not.
> Enabling PCI from .kunitconfig files is problematic as it would not be
> portable. So in commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by d=
efault on UML")
> PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=3Dy.
> However CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
> CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() i=
n
> virtio_pcidev_init(). However there is no one correct value for
> UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.
>=20
> This warning is confusing when debugging test failures.
>=20
> On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
> used at all, given that it is completely non-functional as indicated by
> the WARN() in question. Instead it is only used as a way to enable
> CONFIG_UML_PCI which itself is not directly configurable.
>=20
> Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
> configuration option which enables CONFIG_UML_PCI without triggering
> warnings or building dead code.

Alright, so looked like Thomas wanted this to not be merged via the UML
tree, which does make sense, so I've dropped it.

For the kunit tree then you can add:

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

