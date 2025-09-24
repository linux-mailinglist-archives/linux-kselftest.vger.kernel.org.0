Return-Path: <linux-kselftest+bounces-42168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC20B98C71
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 10:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054AC3A9F64
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EC825A34F;
	Wed, 24 Sep 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f8DZpYAG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD22571C7;
	Wed, 24 Sep 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701718; cv=none; b=dRyJD+bEGTg2z+RkNNMC5dMsk2fpsk1kydoJWaodptTAGSYBTn9aI0buv4nn8J2GhU9t4aiMjTwdJFd/PpldM4sKv/1l/oiMPMRpXkvUkHfkUJrVmVgqF+rnIwCHkpWepQcxzWPdgKIZD0o7Q1ekNtD0DGbzHbWLkHnEd24LQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701718; c=relaxed/simple;
	bh=D2wn6RMMBnB/+9wWDZ2/t9VQgCDz7Hs9Ndx57HE6Dsg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iIXSeihCzUIJyVzOUI5adNWzm1PHzLfj+43YrbxCLePAR9g+ub4QL2BEiXaehK1koZ1CVaIRGOUM72SR9RZ8q7bVR2bY+0D57QviWhMatyjMFlnQMsI+RB//8tcw/8oTy5RSJNTct/0pJW3kn+dsj6nJS/F+rbKxS8E71ZAQgwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f8DZpYAG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=D2wn6RMMBnB/+9wWDZ2/t9VQgCDz7Hs9Ndx57HE6Dsg=;
	t=1758701716; x=1759911316; b=f8DZpYAGqZNrtO12hrxWKoTJxIBRZIkJOU4i7mzCmdm6LoK
	LDfy2qH1UUkyg0laJmQ8pKR9PGatQmgTbwLUQjlMbgiPtfQs4J3YAa2PtaWey6DdYc8VJlEcgWrHV
	sjRA3I0/1zzspQIdTkkQe1i06ZBA9XOTTOpNx1ladj7X81fqa11bZPOFgTiiKVOXN+N01R8K+co1t
	WZkqGmuxSu1kRAVfKWRw1xARslSoxjW3/3eXKAieH6+hwH2r+3Cyw9dd8Buiw0rG2GEXvp/7XIqkC
	/e47eSY+BOly6S1I7NBjfaBukDVONxDTpHkNpcpNzizSMALKvFdnEdfIJ01v0MYw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1KLs-00000008P0I-0JrN;
	Wed, 24 Sep 2025 09:55:48 +0200
Message-ID: <97fde69716ea4742b6cb4aca1a3ecc8788693cd3.camel@sipsolutions.net>
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>, Hajime Tazaki <thehajime@gmail.com>
Cc: johannes@sipsolutions.net, hch@infradead.org,
 linux-um@lists.infradead.org, 	linux@weissschuh.net,
 linux-kselftest@vger.kernel.org, acme@redhat.com, 
	linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2025 09:55:47 +0200
In-Reply-To: <20250924033217.GA9039@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	 <aM15eChUObXfxLzs@infradead.org>
	 <4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
	 <m2y0q47mbs.wl-thehajime@gmail.com> <20250924033217.GA9039@1wt.eu>
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

On Wed, 2025-09-24 at 05:32 +0200, Willy Tarreau wrote:
> On Wed, Sep 24, 2025 at 08:58:47AM +0900, Hajime Tazaki wrote:
> >=20
> > Hello Benjamin, Johannes,
> >=20
> > On Mon, 22 Sep 2025 16:41:36 +0900,
> > Johannes Berg wrote:
> > >=20
> > > On Fri, 2025-09-19 at 08:40 -0700, Christoph Hellwig wrote:
> > > > On Fri, Sep 19, 2025 at 05:34:09PM +0200, Benjamin Berg wrote:
> > > > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > > >=20
> > > > > This patchset is an attempt to start a nolibc port of UML.
> > > >=20
> > > > It would be useful to explain why that is desirable.
> > >=20
> > > Agree, it should be here, but FWIW it's been discussed elsewhere on t=
he
> > > linux-um list in the past and basically there are various issues arou=
nd
> > > it. Off the top of my head:
> > > =C2=A0- glibc enabling new features such as rseq that interact badly =
with how
> > > =C2=A0=C2=A0 UML manages memory (there were fixes for this, it worked=
 sometimes
> > > =C2=A0=C2=A0 and sometimes not)
> > > =C2=A0- allocation placement for TLS is problematic (see the SMP seri=
es)
> > > =C2=A0- it's (too) easy to accidentally call glibc functions that req=
uire
> > > =C2=A0=C2=A0 huge amounts of stack space
> > >=20
> > > There are probably other reasons, but the mixed nature of UML being b=
oth
> > > kernel and "hypervisor" code in a single place doesn't mix well with
> > > glibc.
> >=20
> > just curious
> >=20
> > - are those issues not happening in other libc implementation ? (e.g.,
> > =C2=A0 musl-libc)
> > - same question to nolibc: is there any possibility that nolibc will
> > =C2=A0 evolve as glibc does, and this evolution introduces the UML issu=
es ?
>=20
> Nolibc focuses on early boot programs. That does not mean it will never
> evolve towrards more generic usage but this remains unlikely, and in any
> case there's the goal will remain not to degrade the experience on the
> original target (early boot). That doesn't mean there will never be any
> breakage but we're doing our best to keep things in a clean and workable
> state. Regarding threads, it seems unlikely that they'll arrive any time
> soon. But if they did, assuming UML would by then be a long established
> user, we'd certainly find a solution together (even via build-time
> defines if needed).

Also, with nolibc it is really simple to override any functions as
needed. We will likely want to do this for malloc/free so that nothing
bad can happen there.

Actually, UML already tries to do that for glibc. However, it
effectively fails (for dynamically linked builds) because the
dynamically linked glibc still uses its internal version for these
symbols.

Benjamin

