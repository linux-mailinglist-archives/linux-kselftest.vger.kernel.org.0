Return-Path: <linux-kselftest+bounces-42046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F137B8F522
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 09:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E1916E84A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 07:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A52F60C2;
	Mon, 22 Sep 2025 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dEPG0EV5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF38F40;
	Mon, 22 Sep 2025 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526904; cv=none; b=OSpTTlDf8WqCNdwyiXmppYKtaFFLanb0Uy8wkXNbWb2zY+DeWVjEXv5WWTUsmffRWXXMaOZXmqFjKxivxak0x3u1+KFQvNK3K02qMsQdGUDXK1XjrhxawrWfa/E38JLemx5cHlJu8TofwxN8DsF7QD0F5coVsghwVluKfqrVTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526904; c=relaxed/simple;
	bh=rFAOLGviG/2mP1OhYX7FlhiEMHelWHhCH4/Cdy1hs+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f2389RBnGT5CKpRYk6fdBUWESvtZUkViq7KD39OKslbs/ym+0cqiil7DnUqeVAMnTZqtaOH1aRfEy17Z37Xj3JdkLcozJUuBNCH5zCGiFZKgGzhTSJoXSO1ZG3PoBLFC8/NJNFhvEPCej82AqE1ywR2vyZcbR5mHE7IxF2Arzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dEPG0EV5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nJooTaP9EJUEuvdRKkg/AUuCEpA5pVQOOm9tHzbdOy8=;
	t=1758526903; x=1759736503; b=dEPG0EV5Wzls7zrH7weEdoCS2DlQtCoIlkBUYbQUh2B9ODo
	dee7M+8ltGxfc7xKyjQ6ZRHyjsjTglp74J114VabIG8VDsHojJH3Tl+FB4KKIwLF5N7y65YAavrUM
	uss8N/TFp02ymyk7BpgGmMuhvzfKTuxKskTiL3ARrdGoJAqUMoNAYpg6wEMI5YEychT2UxUXqvEmh
	IxkTS4satdDHVOlwmtYkdtG/hl3gf0NyftVbhQsbnlKaGfcaI4aYZhpVVPR5S0nu2mOEn1WrAaIu1
	dJQRIOlsxPo5BjGCO6NXhYSy1oDlL82Q9wjqmRq0WMi4yChgpQAHLXeg/ViZrqTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0bB3-00000004Dep-0kKa;
	Mon, 22 Sep 2025 09:41:37 +0200
Message-ID: <4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
From: Johannes Berg <johannes@sipsolutions.net>
To: Christoph Hellwig <hch@infradead.org>, Benjamin Berg
	 <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?=	 <linux@weissschuh.net>,
 linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@redhat.com>, linux-kernel@vger.kernel.org, Benjamin Berg
 <benjamin.berg@intel.com>
Date: Mon, 22 Sep 2025 09:41:36 +0200
In-Reply-To: <aM15eChUObXfxLzs@infradead.org>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	 <aM15eChUObXfxLzs@infradead.org>
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

On Fri, 2025-09-19 at 08:40 -0700, Christoph Hellwig wrote:
> On Fri, Sep 19, 2025 at 05:34:09PM +0200, Benjamin Berg wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > This patchset is an attempt to start a nolibc port of UML.
>=20
> It would be useful to explain why that is desirable.

Agree, it should be here, but FWIW it's been discussed elsewhere on the
linux-um list in the past and basically there are various issues around
it. Off the top of my head:
 - glibc enabling new features such as rseq that interact badly with how
   UML manages memory (there were fixes for this, it worked sometimes
   and sometimes not)
 - allocation placement for TLS is problematic (see the SMP series)
 - it's (too) easy to accidentally call glibc functions that require
   huge amounts of stack space

There are probably other reasons, but the mixed nature of UML being both
kernel and "hypervisor" code in a single place doesn't mix well with
glibc.

johannes

