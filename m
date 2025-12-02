Return-Path: <linux-kselftest+bounces-46915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F063C9D10A
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 22:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DB41344460
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 21:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A22F99B5;
	Tue,  2 Dec 2025 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMUEj/bf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAE2F8BFC
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710456; cv=none; b=A1BWybtplkKSOAfRJsKrzy56OmgBGTLWjuAeYUbNCVffGxm2XjQa4s1UGVXM+erH5cEdWf9qrIm3uD0JfPsJzhO3/eKawrAG6XkWNv4ZSDRUj24nBuAgi9r0AdL0GpKQvaI40pQSkESrCPqD9/6fe8w3aLf83nZdekmQKYF68Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710456; c=relaxed/simple;
	bh=RagZc9tkE1owikse07dj0ABgQH9MJD4ApwZha2okJgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1kfOMXnGspNKB8jdsK/0dUd+43W5fQtAFC38HuHInfmqzZaKrLwdy5DogBpMuzQuxEZE3Ym+/X1E3MiImmJkPQXF7i4GlW6qwiY7nQyYnXQNzfifi2DTyD3ZqXHlcuqaQcWu+VL+NtdrMpKR/sTYwqRhnl7p2JoZhdcEdm2TRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMUEj/bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E809C4CEF1
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 21:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710456;
	bh=RagZc9tkE1owikse07dj0ABgQH9MJD4ApwZha2okJgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lMUEj/bfRO1czfgIM9fmplkrHpKyG/sIfKrHdKtpB+A1zw6SzPo3mn5incy6/1+PP
	 WfAXHQfHOOEXJGwJ5uKXnH7jsnTRZFof9JAgKOGZw467IgyA7GI8KUzHygCzJG3piO
	 J1aT0jdRWscCYdS7Id+X5LvxnjjJNuCxMPjbtKDUf9YZmNn7Sbyha5VUoYJow0GmXW
	 ty7VlRAMF56XkLyXOGWaKTE44lWhHVpSNBs5D92DP+iZXDvNAvwM09sjZ6G+ELWs9k
	 fVwgdU8FyYJGGLcSdUVxKHtxNSBICWBqo+ONYUv1lBG0/YoP6BsrS4vlKVfUbKtSYg
	 mf1RSx18kMYDA==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6430834244aso4958029d50.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 13:20:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUBvPfrnAuS5i480UhwLIPIxTnXdCUO6spu1EDBcpd+SB4IfU5xlEfOfck0tfeJDGedu/RwJ6+X9pF/6tlNFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1B9A4mbQqw5gFxGpVPUsDB7Wss/4R2evQu8OVXEdvPjMLKkfy
	TxVfa4D/dGoE3fy9FFjx7RDGbKEiCFrO2dUeyohrFyoQ5XK7oakilF85pAgjRccUP81Ce9pPYir
	p2vHPKLnERFjuYzhQnZN7kHTmFvE7Zrm9nL8klK9uwg==
X-Google-Smtp-Source: AGHT+IGeVegJbnbcxMokO/4tzPx6hfftjvmsjbssHsXtb0MWSZghQPn9mBotsEquaBQ4WWH9ewbS1R3BbyNo64wixE0=
X-Received: by 2002:a05:690c:6982:b0:784:92a3:68b3 with SMTP id
 00721157ae682-78c0bed40c1mr99577b3.12.1764710455003; Tue, 02 Dec 2025
 13:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de> <20251130005113.GB760268@nvidia.com>
 <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
 <20251201132934.GA1075897@nvidia.com> <aS3kUwlVV_WGT66w@google.com>
 <aS6FJz0725VRLF00@wunner.de> <20251202145925.GC1075897@nvidia.com>
 <CACePvbVDqc+DN+=9m1qScw6vYEMYbLvfBPwFVsZwMhd71Db2=A@mail.gmail.com> <20251202181923.GB1109247@nvidia.com>
In-Reply-To: <20251202181923.GB1109247@nvidia.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 3 Dec 2025 01:20:44 +0400
X-Gmail-Original-Message-ID: <CACePvbUnY_0HXmfBH5Y2fASZTw1aBLQhxCMXKCNOEKHTf4NnyQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnfRbn0_i7txAStVixQnfWzzZaB25DkDNbFdz6FVjEnJEmpmv2roWbmiDI
Message-ID: <CACePvbUnY_0HXmfBH5Y2fASZTw1aBLQhxCMXKCNOEKHTf4NnyQ@mail.gmail.com>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lukas Wunner <lukas@wunner.de>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 10:19=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Dec 02, 2025 at 08:36:53PM +0400, Chris Li wrote:
>
> > Jason, please correct me if I am wrong. My understanding is that not
> > only the device that is actively doing the DMA requires the bus number
> > to stay the same, I think all the parent bridge, all the way to the
> > root PCI host bridge, bus number must remain the same. After all, the
> > DMA will need to route through the parent bridges.
>
> The completions need to route back through the parent bridges, so yes
> you cannot do anything to disturb RID based routing in the active
> fabric either, with also means few changes to the subordinate bus
> range of any bridge are possible.

Thank you Jason for the confirmation.

Lukas, that means if we are using the path, we will need to save the
bus number along each path node. Different liveupdate devices might
share the parent bridges, we might want to de-duplicate that. Then you
end up with something very similar to the BDF design, where the path
part is just redundant if you have BDF.

That is what I mean previously, using the BDF has the same protections
as path design, just simpler.

Chris

