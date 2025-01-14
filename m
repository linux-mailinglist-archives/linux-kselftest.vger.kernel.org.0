Return-Path: <linux-kselftest+bounces-24415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3798EA0FE07
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 02:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D78D167404
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286CD224B10;
	Tue, 14 Jan 2025 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cd+F3WLO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271CEC5;
	Tue, 14 Jan 2025 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817924; cv=none; b=pIYjgX/6WhQJxCzj70dKg4wUgjw5z+/pJZWI8ra77wK3SrqC/87wkB5f84TadHAROYAmX+Mp2CS8PkdrSmk7ry6eot6lTfvkxlH9kSzIwk26VLviSrzn/RYmtUHXwGRGM0Ow3tdDD4me7RtDrNzQyfOPNp8ORSSaHNvsYxcOPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817924; c=relaxed/simple;
	bh=d1cDRoMa/0Gd1A2u3XXrBEuxEmgjaQbeMrvntc71RRY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OFGntcnNA1vz5LwNLFzndirM0b+5t1wEisuYx6Aozz44XWjiPh9KEJBCPt4J97hmDF0LaoKMCMgcl/se3ZE8q+FULGy30ZQdEoexjL2bF7TiIfVMKOUarhFmOz7OGUakSDi+UztnVcP+vZaGWosU3L4Tu/y7hSSIF9Vevlb47lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cd+F3WLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B98EC4CED6;
	Tue, 14 Jan 2025 01:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736817923;
	bh=d1cDRoMa/0Gd1A2u3XXrBEuxEmgjaQbeMrvntc71RRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cd+F3WLOFMwazrCVRPyGU7MKzOxuAGouAmTkRgM95PpOy8/x5G8soO5ItDid/MhlY
	 5PBx1UiRx7dc+hl2qfEhAUPt2RSsxiMJoF4OduEgK8vzFBHV8GobGaAyGgf8xJl8ss
	 j5th6zg+KFNGf3VzpyAPOdgpZHlYHhcQXYyakBDQ=
Date: Mon, 13 Jan 2025 17:25:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, Thomas
 Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3 4/4] selftests/mm: virtual_address_range: Avoid
 reading from VM_IO mappings
Message-Id: <20250113172522.3cb1d061994a076cd7362487@linux-foundation.org>
In-Reply-To: <20250113-virtual_address_range-tests-v3-4-f4a8e6b7feed@linutronix.de>
References: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
	<20250113-virtual_address_range-tests-v3-4-f4a8e6b7feed@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 14:15:38 +0100 Thomas Wei=DFschuh <thomas.weissschuh@li=
nutronix.de> wrote:

> The virtual_address_range selftest reads from the start of each mapping
> listed in /proc/self/maps.
> However not all mappings are valid to be arbitrarily accessed.
>=20
> For example the vvar data used for virtual clocks on x86 [vvar_vclock]
> can only be accessed if 1) the kernel configuration enables virtual
> clocks and 2) the hypervisor provided the data for it.
> Only the VDSO itself has the necessary information to know this.
> Since commit e93d2521b27f ("x86/vdso: Split virtual clock pages into dedi=
cated mapping")
> the virtual clock data was split out into its own mapping, leading
> to EFAULT from read() during the validation.
>=20
> Check for the VM_IO flag as a proxy.
> It is present for the VVAR mappings and MMIO ranges can be dangerous to
> access arbitrarily.
>=20
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202412271148.2656e485-lkp@intel.com
> Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated =
mapping")
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without relianc=
e on correctness of mmap()")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Link: https://lore.kernel.org/lkml/e97c2a5d-c815-4936-a767-ac42a3220a90@r=
edhat.com/
> Signed-off-by: Thomas Wei=DFschuh <thomas.weissschuh@linutronix.de>
>=20
> Revert "selftests/mm: virtual_address_range: Avoid reading VVAR mappings"
>=20
> This reverts commit 05cc5d292ac4238684b59922aecf59c932edefa0.

I'm assuming that the above two lines simply shouldn't be here?

