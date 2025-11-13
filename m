Return-Path: <linux-kselftest+bounces-45578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A5EC59B7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 20:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEB1734431B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 19:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD531A54A;
	Thu, 13 Nov 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRRo5/ko"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464531A051
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061676; cv=none; b=PVoqpsjca1j2Vfk5JGJStQy6QtH4TdoLEnewFIr8ZVwkVYoezGOF2H9qe6jshQIOKw24g4CyzsxHdrpHIMF1Ta1TTxi2T2btbCsQVrEz0NAVkYC75G7QUMIhe5ZoGN/G7XSdYuKar8DpZdWroHRJHj9JJG0DNZr6P0cVboBcLmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061676; c=relaxed/simple;
	bh=YV6sOxoXq6hGnFV0FtR8Pqna/c3no8BjtpDPc+tesEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IcHD2V4WPgMQg8dB2A4zVbGNhnugSCIgtkXfY/SsUzXuORzANwtfq8hdO0QCaGzABo+RHuLmZmR7wIQ/no6k2NUyXcXS6jycgbFY/3aif0U8EJDHQP8+zF8L6vsioEBEelBNsTe8uNycRi2nbHzTlD89aSZPek3sgOJKyEKHRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRRo5/ko; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3436d6aa66dso1822993a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 11:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763061673; x=1763666473; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YV6sOxoXq6hGnFV0FtR8Pqna/c3no8BjtpDPc+tesEA=;
        b=hRRo5/ko0m+0C3//rh0YIVeTifJukWDpcKaN7C9Wwcfkqi5QNW4blQOzYlHll5pvnB
         xAbRvySqMLlA7lHg3zEHrzK3UPpmLUgrpl4F3SZ7z0JuYWsOE6+eQJcoldQwThagkroK
         ZbOoWL98/j+CeeX/f6dN5fBRNgo9OMYw4KhHRzXZNV6Z901lf2kbR4mxB6QmDdGHoKS2
         wLdh+Z0uHjL3DJTHn5zLMaspz65wDvYjT3bJ0/nR/XnUODcYtUrHxw1a15NvkSuHHUT2
         XBQqfdgjrktY2+rpW/+t3ljqyCco+m8ggVZtoNYsMWyxLHcdvNchEaAmySjkBalxB7yf
         SXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763061673; x=1763666473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YV6sOxoXq6hGnFV0FtR8Pqna/c3no8BjtpDPc+tesEA=;
        b=K0YUKuUbIwSFTPUq0+7mfLkihZAs3EbXTeDvxE6buREWnAeDvelxmSDVHp2juceKuM
         WkvBxH+hMlaQT78BueSAaOkDV3a1P5L+bPfzPUMEs0C9z2+M6VWPSPbWYpl7AHu9c00I
         MhxGMQxttug0IsZRftN3uQ7w/FW1usftcTYgvWGIX9KAa4VsPbbDixP94BSZiuwzdcog
         QGoTGCikHLgRk4yRQWzrGDpzCkQ2K4+xAgMk2eZ49hhMyp36AkmaJuvl5ayM+uAx6XER
         WhCFmmdElN20RVfllgcc56MoZvpyV+kmHZnnoal/RnQxFrja0Mq0UTPakQyI6b98Anre
         QKHw==
X-Forwarded-Encrypted: i=1; AJvYcCUWz2gpr/4WPXac8O+Xi7m1sFv0Jo94Y5ssAhNvNlHuFBVjMl4++Ews4ftPGHGCGjbohCIwxGXmzEgjFCwylGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOeAaoLt3LYXvw0snxoFvOTQBDP3oky0o+fXOAkMCQ+Z5ii/t
	h71FX1Fw4S/1ayEGrwqKZ/V9z4i3SnVURFEkyORS0Qf67FsVxPxWa7PNUOHMNKOcyfc=
X-Gm-Gg: ASbGncvzZFTG+Gd7eQoU7P5eeNpFOfRQ8/7gSxFrw5Ue3D8NTRll0wzysbx9eO2qKbj
	RUerU0Mh85klB7OwrUmmwEG3a2AcnPwI3dKG4keFAKQjXT2w2PpQ5VP/aSP+ovNQETG0pcerCAK
	vgfZYctEJ76VKkX61qEyAvWC3yO15hWa1Diy8jaKTRVm41Rg9HegLwZ6s92kdLdvnkcjwg1V/bT
	NHeEkGMU/AXGyk8sL60QvSNil08nV7NB58litb5nM89x9IYfmFRkmWcUgIo48oQ+VXAtbEsmq+D
	lt7lJ/GxsttTlWzlp27GYEsyOMOfPDx4ZlsnejgZyjcC3x3hi+hx14L3Sxb0pUBFSFvUn3qgzOp
	lZO4QofFA0iVQXFf1Cy4yLMIUbHwWKE9KNxuCVfMXIe1L9BewpXqIruVDMZbtVV5w8oh/JGf+9D
	5EARiGO9BP
X-Google-Smtp-Source: AGHT+IHz5MAfkUB8H2U+X4Opj6NB0ta/4SEepskdKyPG77Ty3LlkB8Uvny/o7z5fI2DcCEhkb3ZvSg==
X-Received: by 2002:a17:90b:1802:b0:343:747e:2ca4 with SMTP id 98e67ed59e1d1-343f9177d72mr696406a91.9.1763061673216;
        Thu, 13 Nov 2025 11:21:13 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07b4b23sm6822395a91.13.2025.11.13.11.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 11:21:12 -0800 (PST)
Message-ID: <351b27a15b9222a48f720de17093ab24d14ec391.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] libbpf: fix BTF dedup to support recursive
 typedef definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>, Ouail Derghal	
 <ouail.derghal@imt-atlantique.fr>, Guilhem Jazeron
 <guilhem.jazeron@inria.fr>,  Ludovic Paillat <ludovic.paillat@inria.fr>,
 Robin Theveniaut <robin.theveniaut@irit.fr>, Tristan d'Audibert	
 <tristan.daudibert@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Paul Houssel
 <paul.houssel@orange.com>
Date: Thu, 13 Nov 2025 11:21:09 -0800
In-Reply-To: <bf00857b1e06f282aac12f6834de7396a7547ba6.1763037045.git.paul.houssel@orange.com>
References: <cover.1763037045.git.paul.houssel@orange.com>
	 <bf00857b1e06f282aac12f6834de7396a7547ba6.1763037045.git.paul.houssel@orange.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 13:39 +0100, Paul Houssel wrote:
> Handle recursive typedefs in BTF deduplication
>=20
> Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
> Podman) due to recursive type definitions that create reference loops
> not representable in C. These recursive typedefs trigger a failure in
> the BTF deduplication algorithm.
>=20
> This patch extends btf_dedup_ref_type() to properly handle potential
> recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
> handled for BTF_KIND_STRUCT. This allows pahole to successfully
> generate BTF for Go binaries using recursive types without impacting
> existing C-based workflows.
>=20
> Co-developed-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> Signed-off-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> Co-developed-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> Signed-off-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> Co-developed-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> Signed-off-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> Co-developed-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> Signed-off-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> Co-developed-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> Signed-off-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> Suggested-by: Tristan d'Audibert <tristan.daudibert@gmail.com>
> Signed-off-by: Paul Houssel <paul.houssel@orange.com>
>=20
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

