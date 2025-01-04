Return-Path: <linux-kselftest+bounces-23899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C467AA011B9
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 03:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C238164BE9
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5197711F;
	Sat,  4 Jan 2025 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joD0NAbR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57035280;
	Sat,  4 Jan 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735956446; cv=none; b=Hb9DidHAdgz16eeqc5annIYFn48Zqa0pLHfrOE4BjbMGed4YszkTjqLeIrS9vjyQF3pNX5w7io1x2quJfVX0GX3yKhoGzcRqOaqik834mn7U1H/hw2R0em+RJoj5NLrDqgZR/hofku4kyw0P+aAcuVpfw/jRed4pwmLRycuSmxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735956446; c=relaxed/simple;
	bh=5+k5XIDfmklKhyQNZnytCq6Wbtr3vAtBCZfKfKHl6CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5hL11w7Xod8pldHAPy55U10eS9edtfP+HEbTG9YH8knh29nCHebnVgO/pShEJPimq17w3mueHowuyLwz3DB5Ql7dDS1R/Lo7LMpHQrou9hcBmNo2h78hip12bxd+8sKHazBtbhgIhQy+SbT80PdI8Bu4g04vJMUhHgaaL37VW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joD0NAbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E24C4CED6;
	Sat,  4 Jan 2025 02:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735956445;
	bh=5+k5XIDfmklKhyQNZnytCq6Wbtr3vAtBCZfKfKHl6CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joD0NAbRBPE0lezKTTDP1O/kr2E6iJf9COWb+q26eFjVoffuI5L/uXxAbsoYlryoQ
	 fYP/yaVyXmntFcDd1a3Fy5BzamjHbURSTyP3IdaXyhV79hmDEblPiZtS6iVgzwGlo3
	 Kx4vTa/nHoqIBT7WaRKz0y7zXQ0mNg/SZWWNqb701SX3cdNH0ZRCTN14xhyhSGJ8Pg
	 cXiLSChUUEnHpXT+4yMfzWCREm/wGuuwBvwu0rahfPZ8BSGvXEuUhX3QReboXWGoBI
	 95VoZXg6cVJmIgpcGSWX14DR8XQkeIf/4vXIKDW+eMgmO5cxqmChke6AdKsiTp7rM/
	 m8eDNhFD+TAEA==
Date: Fri, 3 Jan 2025 18:07:22 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Marek =?utf-8?B?TWHFm2xhbmth?= <mmaslanka@google.com>,
	Adam Williamson <awilliam@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com,
	bp@alien8.de, brendan.higgins@linux.dev, da.gomez@samsung.com,
	danielt@kernel.org, dave.hansen@linux.intel.com,
	davidgow@google.com, dianders@chromium.org, hpa@zytor.com,
	jason.wessel@windriver.com, jikos@kernel.org,
	joe.lawrence@redhat.com, johannes@sipsolutions.net,
	jpoimboe@kernel.org, kgdb-bugreport@lists.sourceforge.net,
	kirill.shutemov@linux.intel.com, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	live-patching@vger.kernel.org, luto@kernel.org,
	mark.rutland@arm.com, mbenes@suse.cz, mhiramat@kernel.org,
	mingo@redhat.com, peterz@infradead.org, petr.pavlu@suse.com,
	pmladek@suse.com, richard@nod.at, rmoar@google.com,
	rostedt@goodmis.org, rppt@kernel.org, samitolvanen@google.com,
	shuah@kernel.org, song@kernel.org, tglx@linutronix.de,
	x86@kernel.org,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
Message-ID: <Z3iX2mNtqSYrvYPT@bombadil.infradead.org>
References: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
 <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
 <9878d90f-faf3-4853-9a79-a21b4f58ab4c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9878d90f-faf3-4853-9a79-a21b4f58ab4c@suse.com>

On Fri, Jan 03, 2025 at 07:58:13AM +0100, J=FCrgen Gro=DF wrote:
> On 03.01.25 03:06, Andrew Cooper wrote:
> > > Hi Mike,
> > >=20
> > > This commit is making my intel box not boot in mm-unstable :>) I bise=
cted it to
> > > this commit.
> >=20
> > For what it's worth, we've found the same under Xen too.
> >=20
> > There's one concrete bug in the series, failing to cope with the absence
> > of superpages (fix in
> > https://lore.kernel.org/xen-devel/6bb03333-74ca-4c2c-85a8-72549b85a5b4@=
suse.com/
> > but not formally posted yet AFAICT).
>=20
> Now sent out:
>=20
> https://lore.kernel.org/lkml/20250103065631.26459-1-jgross@suse.com/T/#u

Thanks,=20

Marek, Adam, can you try this patch? Although the reply here is for
another future series being worked on the fix is for commit
2e45474ab14f ("execmem: add support for cache of large ROX pages").

  Luis

