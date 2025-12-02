Return-Path: <linux-kselftest+bounces-46877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B5BC9BB9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 15:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7033A8280
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFEE322C7D;
	Tue,  2 Dec 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLaikgA4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB5D322C78;
	Tue,  2 Dec 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684638; cv=none; b=DdYX9qHGPOz2qwBshWDc3NNvfT7JdBO2ptQ7RzIiaKdMrRSv9QVZnaQkb9zZZwKm1mchJKkdWkVmkAZUH+JZ4b/GLVzavSr+u0kDs82Ius/EKVXEinFRGhoXnUKa+skoh2Q3MKtDmYyay7KpRSEwJLsy1ARMewkdDHJPTyeuRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684638; c=relaxed/simple;
	bh=URgri6CpO3X9jzw1OjvEtPKkg18tROknUFwKrRlIq9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K09ZZqYMtF+6c3KN3J62zdFNZnfuGyc5E15WLI0d7yYorvps2xxOE58jj54NFYQUitQmMqzc7b/OUOfSdBOJcxkgF0N4u26W68jFuheDuBtoCv9RAPUJFYg+qR3yC3Uy/hmIulP20jyprtt0BiEkE0OTs1c+2cCkovX9bpkhVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLaikgA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04C3C4CEF1;
	Tue,  2 Dec 2025 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764684637;
	bh=URgri6CpO3X9jzw1OjvEtPKkg18tROknUFwKrRlIq9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nLaikgA4ve9G0uBvuQ4SatN4sb2/QXUllDdM2zFEpUhvaHeWT33INaJ6IDcpVOobG
	 ei/R654EgJu8W5YLITv/04Fej0voEK6nOjxgUpgOpaNGSOsBXUWdzNppcIrMZjJjym
	 +itzE8FFx8zEZSyqNtWpQc5jba7Qy8P1QahZkA/1Er6RMBJPdlCZhiZ9e2s2fSbrCf
	 6gk9q5BXnJyiVPYsHvRs8cl4ITbRzWngVQ/sDmc8R4k5BxXpzCNl6u6EtToX6xoV30
	 FzLqDjvFPKH3LSSMJmO3AMDb7QsRdTZT3q1XJ5c4G04yvDumKt6C9FNVyiOKZsD4IT
	 s7TNnLPp478KQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Matlack <dmatlack@google.com>,  Alex Williamson
 <alex@shazbot.org>,  Adithya Jayachandran <ajayachandra@nvidia.com>,  Alex
 Mastro <amastro@fb.com>,  Alistair Popple <apopple@nvidia.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Chris Li <chrisl@kernel.org>,  David Rientjes <rientjes@google.com>,
  Jacob Pan <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Jason Gunthorpe <jgg@ziepe.ca>,  Josh Hilke
 <jrhilke@google.com>,  Kevin Tian <kevin.tian@intel.com>,
  kvm@vger.kernel.org,  Leon Romanovsky <leonro@nvidia.com>,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-pci@vger.kernel.org,  Lukas Wunner <lukas@wunner.de>,  Mike
 Rapoport <rppt@kernel.org>,  Parav Pandit <parav@nvidia.com>,  Philipp
 Stanner <pstanner@redhat.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Saeed Mahameed <saeedm@nvidia.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  Shuah Khan <shuah@kernel.org>,  Tomita Moeko
 <tomitamoeko@gmail.com>,  Vipin Sharma <vipinsh@google.com>,  William Tu
 <witu@nvidia.com>,  Yi Liu <yi.l.liu@intel.com>,  Yunxiang Li
 <Yunxiang.Li@amd.com>,  Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
In-Reply-To: <CA+CK2bC3EgL5r7myENVgJ9Hq2P9Gz0axnNqy3e6E_YKVRM=-ng@mail.gmail.com>
	(Pasha Tatashin's message of "Mon, 1 Dec 2025 16:59:23 -0500")
References: <20251126193608.2678510-1-dmatlack@google.com>
	<CA+CK2bC3EgL5r7myENVgJ9Hq2P9Gz0axnNqy3e6E_YKVRM=-ng@mail.gmail.com>
Date: Tue, 02 Dec 2025 15:10:26 +0100
Message-ID: <86bjkhm0tp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01 2025, Pasha Tatashin wrote:

> On Wed, Nov 26, 2025 at 2:36=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
[...]
>> FLB Locking
>>
>>   I don't see a way to properly synchronize pci_flb_finish() with
>>   pci_liveupdate_incoming_is_preserved() since the incoming FLB mutex is
>>   dropped by liveupdate_flb_get_incoming() when it returns the pointer
>>   to the object, and taking pci_flb_incoming_lock in pci_flb_finish()
>>   could result in a deadlock due to reversing the lock ordering.

My mental model for FLB is that it is a dependency for files, so it
should always be created (aka prepare) before _any_ of the files, and
always destroyed (aka finish) after _all_ of the files.

By the time the FLB is being finished, all the files for that FLB should
also be finished, so there should no longer be a user of the FLB.

Once all of the files are finished, it should be LUO's responsibility to
make sure liveupdate_flb_get_incoming() returns an error _before_ it
starts doing the FLB finish. And in FLB finish you should not be needing
to take any locks.

Why do you want to use the FLB when it is being finished?

>
> I will re-introduce _lock/_unlock API to solve this issue.
>
>>
>> FLB Retrieving
>>
>>   The first patch of this series includes a fix to prevent an FLB from
>>   being retrieved again it is finished. I am wondering if this is the
>>   right approach or if subsystems are expected to stop calling
>>   liveupdate_flb_get_incoming() after an FLB is finished.

IMO once the FLB is finished, LUO should make sure it cannot be
retrieved, mainly so subsystem code is simpler and less bug-prone.

>
> Thanks, I will include this fix in the next version of FLB.

--=20
Regards,
Pratyush Yadav

