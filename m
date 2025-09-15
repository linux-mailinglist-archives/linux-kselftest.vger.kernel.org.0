Return-Path: <linux-kselftest+bounces-41451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D47B57059
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 08:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8521E3B7747
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 06:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E81C27A92B;
	Mon, 15 Sep 2025 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iB0ibLlr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421021F2361;
	Mon, 15 Sep 2025 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918000; cv=none; b=g/S+CPWQeVnx7mLIvTQIHVdAL4jz7KCDCHdDoDwbHElEvqLgl4NOrnuK8BC/saSE9xATVvxE7YAb4LVgfk9EVw79NU5LPm3zox5mMkRPx+3btILMMv2xl2SZBeb+BfBtDYqWZaNjI6md++MOwEE973Z39Wljih6x8vDsZ1Z49Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918000; c=relaxed/simple;
	bh=QlPxaZpQgAbJ15RgCwCxR2W4D+X5bJYrlbORaI22aqg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZReHTIuU1Q6CKMSDNpRDpwg1z8TXEqhlu+rzOxw6fF83rF2IiuiBFasJrkLrw1z3sF/xg+OAdj721l78cQ8Zn1xXHDpS9fpARtUO1gh1uY+gdo6Bh0YbTvCOf6SlrBMwvQvMYztsL+sUccTW5SB74N6Vp9TjYDBfUofUQ7QWI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iB0ibLlr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QlPxaZpQgAbJ15RgCwCxR2W4D+X5bJYrlbORaI22aqg=;
	t=1757917999; x=1759127599; b=iB0ibLlrQzr7wy7mTR3wVlZtM1tW+Dvb9bTAcNPpdqEcP97
	ZXgFeZx/7Tsv4GCH78ZhlKnAPYfcTqjposb3icB17MVqJBB5r4QmAN3/PZxlllz0XU8A7BCAbyo9S
	T3MSYimLd6nSgK6SRwk9CiPcDGiSGjXgDdoVkWoz3NKozSnRrSEUeV6WoR2jaBY7PrdYCM4W4EpB5
	7BLxS41xGD1a05iOgDy1NsyWyhJxgxjUCr8287iquvg/AU4gpFqEQcQkRdf1xpeb3XdwYQwhezXJg
	nYRoyrHRQYmU5a4W2/fGkUvbrQCXnj51Z9MCt99P+SfUa6pIeUi5MicJcLyueNUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uy2lx-00000005sPh-0Vis;
	Mon, 15 Sep 2025 08:33:09 +0200
Message-ID: <8e75d6cc3847899ba8d6a0cbd0ef3ac57eabf009.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>, Bjorn Helgaas
 <bhelgaas@google.com>,  Luis Chamberlain	 <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez	 <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org, David Gow <davidgow@google.com>, Rae Moar	
 <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, Sami Tolvanen	
 <samitolvanen@google.com>, Richard Weinberger <richard@nod.at>, Wei Liu	
 <wei.liu@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	kunit-dev@googlegroups.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 	linux-um@lists.infradead.org
Date: Mon, 15 Sep 2025 08:33:08 +0200
In-Reply-To: <20250912230208.967129-2-briannorris@chromium.org> (sfid-20250913_010956_669404_FC913C9D)
References: <20250912230208.967129-1-briannorris@chromium.org>
	 <20250912230208.967129-2-briannorris@chromium.org>
	 (sfid-20250913_010956_669404_FC913C9D)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-09-12 at 15:59 -0700, Brian Norris wrote:
> The PCI framework supports "quirks" for PCI devices via several
> DECLARE_PCI_FIXUP_*() macros. These macros allow arch or driver code to
> match device IDs to provide customizations or workarounds for broken
> devices.
>=20
> This mechanism is generally used in code that can only be built into the
> kernel, but there are a few occasions where this mechanism is used in
> drivers that can be modules. For example, see commit 574f29036fce ("PCI:
> iproc: Apply quirk_paxc_bridge() for module as well as built-in").
>=20
> The PCI fixup mechanism only works for built-in code, however, because
> pci_fixup_device() only scans the ".pci_fixup_*" linker sections found
> in the main kernel; it never touches modules.
>=20
> Extend the fixup approach to modules.

This _feels_ a bit odd to me - what if you reload a module, should the
fixup be done twice?=C2=A0Right now this was not possible in a module, whic=
h
is a bit of a gotcha, but at least that's only one for developers, not
for users (unless someone messes up and puts it into modular code, as in
the example you gave.)

Although, come to think of it, you don't even apply the fixup when the
module is loaded, so what I just wrote isn't really true. That almost
seems like an oversight though, now the module has to be loaded before
the PCI device is enumerated, which is unlikely to happen in practice?
But then we get the next gotcha - the device is already enumerated, so
the fixups cannot be applied at the various enumeration stages, and
you're back to having to load the module before PCI enumeration, which
could be tricky, or somehow forcing re-enumeration of a given device
from userspace, but then you're firmly in "gotcha for the user"
territory again ...

I don't really have any skin in this game, but overall I'd probably
argue it's better to occasionally have to fix things such as in the
commit you point out but have a predictable system, than apply things
from modules.

Perhaps it'd be better to extend the section checking infrastructure to
catch and error out on these sections in modules instead, so we catch it
at build time, rather than finding things missing at runtime?

And yeah, now I've totally ignored the kunit angle, but ... not sure how
to combine the two requirements if they are, as I think, conflicting.

johannes

