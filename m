Return-Path: <linux-kselftest+bounces-46916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0955C9D13A
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 22:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4471345228
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 21:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDBE2F9DB1;
	Tue,  2 Dec 2025 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjOwo0C0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF42F9D88
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710695; cv=none; b=cxGfImv/CZlPgRQJkfpflQTKFLjBIcCz85YnnIf30v0UhDp+TYt/q/tW27tgUxCuBPxL+b/UpHRP/JXJrwE68RWf6AMWXElbzFwjSEmh0n2WdHiTgdyRJKEWT1zir/OBJh5xPSQxWPlACvNATRP+MiMDWpIPayUeAIUHDgJGCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710695; c=relaxed/simple;
	bh=twzlEgd1Uy3xBQygSmzqjkTyVpzrZwq82oXybMvd4Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzzEbmdRe/7Vum8sFdkglkUAyyghUX4z+aSgBpMDwW/efC/wiRV9Erph9FF7xKcXr3hEBS/8YZZ+SM5fyM/mTB+dIvmmpRVHcW0H5NhkRtIisYV0rsLQg0XRKMBO/S4Ca/a6nhV9H+AdLzSKqvkzgEQTPI++lvsWVQAhuJfK8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjOwo0C0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AD7C113D0
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710695;
	bh=twzlEgd1Uy3xBQygSmzqjkTyVpzrZwq82oXybMvd4Ts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UjOwo0C0R41CCkkMo1yHKnf8nPEpxYqR6qWOrW79GA0lJA29Ln8n0rPdPPBLubbAJ
	 /HuUmJdrNAcHLjoORKVrg+jq2A4G5BbnqslSbf+b5qWFejHHpkvH1EPUq7PwAcq5do
	 ZfHZ+b7cYWQy++XFZJ1ObWn8aKLA/ye0xHIcJj13TJ7H4pDQRBttBRJOfVMr/K8vt1
	 MPyXD9dN05IL/bGNdRsVohytv9r2ar6Xfm2sbq5fDAH7QkJfjfvHoOTe4QUKTBSISV
	 w35aKWaCNlqInE8G/wWxxP5AWsKKmI7FAjrluzEl7kq3gFGdjDLqttd0BXMvyav+1h
	 39IkWCHQbNcMQ==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640c9c85255so7807157d50.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 13:24:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgLDCR+QdRR6HCZ4vYnPmL0ZvpAxeM5HamcZqydQOxKLajb0AEh+f1pI4Rd9ulsx1Vofh/+mN2Uk7KrBTUhx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUP7Q/tghyzNPYvLrVDGr7DENPz3+04hZ4iRvuKAkoo82Ib3+p
	+7rlRV+5b20/qUqELAQAsZV/kYC4DqDHTHyHMpU9wEPThKeg/6LI7+DQ9r6ktxuWWlw5p7bQqmt
	w8JAd+sQ+m61nBu3YrzozUdW3vBAYG0iMkW0bxxbCaA==
X-Google-Smtp-Source: AGHT+IGXS8N0qVpsi45NpshQIQRkCyoKAhvWrYx/r7DKOGPA4RAYabycnr/422TJNgN0FEvJwv5Gt8IcOOcvFSu2Znw=
X-Received: by 2002:a05:690c:450d:b0:788:f66:7822 with SMTP id
 00721157ae682-78c0bed5b14mr204377b3.4.1764710694438; Tue, 02 Dec 2025
 13:24:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-4-dmatlack@google.com>
 <aS9XEm96ifPd_ier@google.com>
In-Reply-To: <aS9XEm96ifPd_ier@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 3 Dec 2025 01:24:43 +0400
X-Gmail-Original-Message-ID: <CACePvbXQXVgD2YnEB+_6AWzPrrmwjWcPQxZkraMGenThd2NgcQ@mail.gmail.com>
X-Gm-Features: AWmQ_bncd-BYrtpp-lQGJFmMLIZ0Pjo33dadC0Ws1vhv1RczBgJlOMNAYsR45kw
Message-ID: <CACePvbXQXVgD2YnEB+_6AWzPrrmwjWcPQxZkraMGenThd2NgcQ@mail.gmail.com>
Subject: Re: [PATCH 03/21] PCI: Require driver_override for incoming Live
 Update preserved devices
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 1:16=E2=80=AFAM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2025-11-26 07:35 PM, David Matlack wrote:
> > Require driver_override to be set to bind an incoming Live Update
> > preserved device to a driver. Auto-probing could lead to the device
> > being bound to a different driver than what was bound to the device
> > prior to Live Update.
> >
> > Delegate binding preserved devices to the right driver to userspace by
> > requiring driver_override to be set on the device.
> >
> > This restriction is relaxed once a driver calls
> > pci_liveupdate_incoming_finish().
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
>
> After some offline discussion with Jason and Pasha, I will drop this
> patch from the next version to avoid hard-coding a policy in the kernel.
>
> Instead, for the time being, it will be the user's responsibility to
> only preserve devices that do not have any built-in drivers that will
> bind to the device during boot following a Live Update.

Ack, that certainly can simplify the PCI kernel side of the code, the
kernel doesn't need to deal with PCI driver binding.

Chris

