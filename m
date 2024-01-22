Return-Path: <linux-kselftest+bounces-3376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C683767C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 23:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C152899BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBC71095B;
	Mon, 22 Jan 2024 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIjjwsOE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2410785;
	Mon, 22 Jan 2024 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963686; cv=none; b=GiDwDQe8GqSGZWbdBTmHy4rHPCnx19wJVXo8GpCIgNJrNlFfmZlsU3Yw2kU93dOYRI6YiLSJNdFMGQ7FBrOdIZtqsQfjV3mhtLxYRiiDdmGg9gcyjnEwM6DHaLn6KqGOHgX/bRcDdccB2B6rj666BVlxuneNFLWUqtxtCOuRVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963686; c=relaxed/simple;
	bh=aRO5rI2gBLdjP2Ow80R5wBiyllC8SGlBK8PAr36wVzM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=fXCtJ3tcsMedYrV6ABxVJ8KAfS1zpRGlQN/PK7xvZ+uW6bO7pZfUvuXdrA7OUjJIcZ31d/Zjov2+VxBCDC8yaRvLtWUsVQDn45TebrZF64q9B3WB8ZA/FMmms6itnHHYCBazkI4zs3L+3A5ERGXmvljaBjrr4Qie/+87fyNY1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIjjwsOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA8FC433C7;
	Mon, 22 Jan 2024 22:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705963686;
	bh=aRO5rI2gBLdjP2Ow80R5wBiyllC8SGlBK8PAr36wVzM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SIjjwsOE6XK+oLQbheaQg4QVbT9JVjy30vmiv3ORQOgq7S6FQv8k4XG1s+wW0x7pV
	 rx0n35Uq4nT+ZfAzyV16EE9P7CUcDxdy4Icwo2SNAdM9eOEySqywBnNzQ7Q2hl9E6p
	 Tgywv2wmPhDPHpupI2h6rmRx1SHz6teEPZdyv/hgNuoZeaFCxSSi3LMVS1B+ibfCbK
	 vKIDGeQ4xW+0SRKkxmJ2tElQ/1pSXE32RtcqnyaHKQaD1NOYmigFdzJeoeZzVPXj3/
	 b1n491PKznHSazyiLrteCXRpQiM73c5yKwOCGbF6NbuFEgi04cxyKmCb29ES6WsT/2
	 KFWIaCNP3a57Q==
Message-ID: <47062115ff518edf8c4b02e22f3058bc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSkymMzaOFtJ-6OuVaB4i4zoVafPMqssA=GHByMJ9VTsKg@mail.gmail.com>
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-7-sboyd@kernel.org> <CABVgOSkymMzaOFtJ-6OuVaB4i4zoVafPMqssA=GHByMJ9VTsKg@mail.gmail.com>
Subject: Re: [PATCH 6/6] of: Add KUnit test to confirm DTB is loaded
From: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>
To: David Gow <davidgow@google.com>
Date: Mon, 22 Jan 2024 14:48:03 -0800
User-Agent: alot/0.10

Quoting David Gow (2024-01-15 21:03:12)
> On Sat, 13 Jan 2024 at 04:07, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Add a KUnit test that confirms a DTB has been loaded, i.e. there is a
> > root node, and that the of_have_populated_dt() API works properly.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
>=20
> I won't pretend to be a devicetree expert, but this looks good to me
> from a KUnit point of view, and passes comfortably here.
>=20
> checkpatch seems to have one complaint about the kconfig help text.
> Personally, I think the brief description is fine.
>=20
> Reviewed-by: David Gow <davidgow@google.com>
>=20

Thanks! I noticed that x86 has some devicetree init code. Did you happen
to try on an x86 kvm instance? Or only run on UML?

----8<----
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index afd09924094e..650752d112a6 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -283,22 +283,24 @@ void __init x86_flattree_get_config(void)
 	u32 size, map_len;
 	void *dt;
=20
-	if (!initial_dtb)
-		return;
+	if (initial_dtb) {
+		map_len =3D max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
=20
-	map_len =3D max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
+		dt =3D early_memremap(initial_dtb, map_len);
+		size =3D fdt_totalsize(dt);
+		if (map_len < size) {
+			early_memunmap(dt, map_len);
+			dt =3D early_memremap(initial_dtb, size);
+			map_len =3D size;
+		}
=20
-	dt =3D early_memremap(initial_dtb, map_len);
-	size =3D fdt_totalsize(dt);
-	if (map_len < size) {
-		early_memunmap(dt, map_len);
-		dt =3D early_memremap(initial_dtb, size);
-		map_len =3D size;
+		early_init_dt_verify(dt);
 	}
=20
-	early_init_dt_verify(dt);
 	unflatten_and_copy_device_tree();
-	early_memunmap(dt, map_len);
+
+	if (initial_dtb)
+		early_memunmap(dt, map_len);
 }
 #endif

