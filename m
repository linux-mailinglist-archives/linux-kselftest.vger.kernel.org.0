Return-Path: <linux-kselftest+bounces-46918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0182C9D1BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 22:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 613CA348715
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 21:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5348298CC4;
	Tue,  2 Dec 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Op5VRHid"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E612E62D0
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711716; cv=none; b=mdC5OaDoXPQAsad/gm2yG+pw4Xtp7m478lv0MjzHKxjhoyMJlc84pZ/jjGXNgkZGag9BsWNJVgVeV6gxuGMeirLFC5Il/wvTsLE5ZcQCGQoqUm91ueZQY+vBm622hFBY4oG9woTx2SDX7B/X9Qg/mlttpFzDAdp1bGqVZ3kPTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711716; c=relaxed/simple;
	bh=bK1bgqioLqPqNCUbFDzXCG7JyoMoUTbDQKJcABIxh2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlpL576HEMDNGvT/7dz1lfY+NWbrk5tf4KkRy5QzuTmfzjGYVpOlY8TKqJgophBKrJaJttFwMPyHhBL5HqJ4FtaewtEPNrS6KiBiPzpA0gsF9Y3Gfb1gZqA4WI8vlwxAeDuaD+yhcp4FJFaNNd18jtYXGJqwPyyZJScJDDDGNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Op5VRHid; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so11261650a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 13:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764711713; x=1765316513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BBy8J1XDJHjmvX+Es4TFPSfzkazm1BSKmXhHEtk+CP0=;
        b=Op5VRHid8eH8ab8VEX0QPXgsFu0URtp8bXZp/H8ljdQMHABjoPeqMIU6h/A5GYp09O
         KZ5CJiq1zG2ZcYTiSuZL8G0HA7ePok6V34mVi4UsUQK1mZxHsBufcTh95QTs0z2ihO9K
         tul2bvvQ5hdy8L1+JKgxMlJ+AOV2OxXlnOLcOjQ+85y1ot0k98PVhHPZiiqQMk6K08n6
         WNGL8ukYm6/qJrI6EynDO9OHFaoqeIRrK7YKnrvMut71cFGvIs9qYblyM7l6+yODBLjJ
         f+kzAAZBOXpVBv2JJwnoBkpwjQTpeE7PG0BVbxTnw1VjhZV5e9z3joJfWgH9xun4FFo2
         zWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764711713; x=1765316513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBy8J1XDJHjmvX+Es4TFPSfzkazm1BSKmXhHEtk+CP0=;
        b=w/hZoXoid6Go0ytUqpg+chjW4fXPXvn/hiTm/ifiTFtzxhdcBXWB9PNY5huCi/reim
         9f6JnWGVr1BQl0aR0UiAcZ6dk1rI68cdPy/rl28XYwtKcqbW23o8JpuALjXSAO2TcqsV
         y2PcKnUlfpchu8SlJe5SeqBgyJyVKej+Mqat1wUlHyLhOPpuUQFjderVNr+n1f4Yo+jH
         5tAh+iGA8SDbYfJAV4jOOj44q+InX0uD/lsvhZy3AbeSDh1eQswwkgAkGn2uc7VRM7Gk
         gRT1EhSQZN0vuXnwFk+1MeFasvnP87UChhVvMQAjm0ztVAehWsYTUoov1FMAIBhBKqlD
         Itng==
X-Forwarded-Encrypted: i=1; AJvYcCVs6iLckZDEvtmhuFOW9j8EdDDkrR9s0XmZsj/kYDaA3h0pLZPbp9AGRBTJy2AOtOf30OgT4I+fLoQKQOItZr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVG98TjJcuH67jxGKDaltm2J8JCnRZ4J4xC7pteTJARioWX+o
	bryx5sUOy9Bh/NJFa4yQcqmCgdJOmaw4i7IqT2Y2VqjcYLbrBN1uFG2jv4qIGlZqPmeFEGmnrBt
	OTRkmLIr4M6tk5IzCRyFhvDfwBXwUBaJkX0GpN9Fa+Q==
X-Gm-Gg: ASbGncuOrOQY084uhNK1jkSav284Lb0DgPR8TjA2kyGkrRb1c7uOvgedzCXMuFeBPgn
	5Jlh6CbZ11jhU5l2aOc4iAKMjPtpw+C/sphkTuwqcFfIJg5VNLwE7zexHkQpD3oYa+vqW1ggOrd
	eNTg4djiMzsOWgs2+6o9GHHysJ/OLZLoXgAFaZjfFY8/BfYBdrkAJQKOb9BKSq/PAxloCrqrlLI
	iGeRagVSww9DQvUHwVwn5iP6noRpxAs36w52uSrKSTsGTPPGTKg3FIQwx/H9KD6c+a2gqWdVTqn
	dn8=
X-Google-Smtp-Source: AGHT+IHWLpn7rUj8mxZXJ9rMfRKD6U7DeusV73jTTRLFZkQI3y5z61JVyECIWb2QWdSzz1X1Lv1zjhKD+XOAMt/wgfo=
X-Received: by 2002:a05:6402:455b:b0:643:129f:9d8e with SMTP id
 4fb4d7f45d1cf-64794f33cc3mr841742a12.8.1764711712986; Tue, 02 Dec 2025
 13:41:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <CA+CK2bC3EgL5r7myENVgJ9Hq2P9Gz0axnNqy3e6E_YKVRM=-ng@mail.gmail.com>
 <86bjkhm0tp.fsf@kernel.org> <CALzav=es=RKMsRUdpX03m+2Eq4SVxPZSZuy1fLXV+dv=rhDhaw@mail.gmail.com>
In-Reply-To: <CALzav=es=RKMsRUdpX03m+2Eq4SVxPZSZuy1fLXV+dv=rhDhaw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 2 Dec 2025 16:41:15 -0500
X-Gm-Features: AWmQ_bnrPyeCqV6AbWIFTsaIoktB-kTeS5xKZG_PhpHyIHste-GfTWjRKtK6tnk
Message-ID: <CA+CK2bBWB_+SOf6EgFm0nfovQd0-KPHQCRkqbWWTq4Yx2wAL7A@mail.gmail.com>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

> > >> FLB Retrieving
> > >>
> > >>   The first patch of this series includes a fix to prevent an FLB from
> > >>   being retrieved again it is finished. I am wondering if this is the
> > >>   right approach or if subsystems are expected to stop calling
> > >>   liveupdate_flb_get_incoming() after an FLB is finished.
> >
> > IMO once the FLB is finished, LUO should make sure it cannot be
> > retrieved, mainly so subsystem code is simpler and less bug-prone.
>
> +1, and I think Pasha is going to do that in the next version of FLB.

Yes, I will add this change in the next version of FLB; however, I
will send the next version of FLB only once list_private.h [1] is
added to linux-next, so I can replace luo_list_for_each_private() with
list_private_for_each_entry().

Pasha

[1] https://lore.kernel.org/all/20251126185725.4164769-1-pasha.tatashin@soleen.com

