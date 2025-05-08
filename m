Return-Path: <linux-kselftest+bounces-32677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06ECAB02DE
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 20:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288D17A681E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED27286D50;
	Thu,  8 May 2025 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7NB/AL1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C444B1E7D;
	Thu,  8 May 2025 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729173; cv=none; b=dPtKKKlVCEZ5G7Bljp8cc/DLuQb8HuZzrrg+NnaHtSMMYVTCyLYO3mh1rrs/9aMulfnfYJN15a3/cf0tkSP3CisOVkCBQl4RmjSF0ACAo2PReX1PT9Bc/izDvyxQYgsQluM5Ze0ZINfJtNN5F4Wf0skx8HBR46WgbCagBBXgCG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729173; c=relaxed/simple;
	bh=dI9PYz2NiVcz9XB8oLCo4yQGCH+anaoEe3DTOVFETh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVWW7aPabsTxzFyncLe9i/L2bkfr+3lehARSt9Xrau7GuEuHV2sE0xLMXBQvnes5k0xn85p4H9J4ZZSLd0EYxeoZ5D/zxOf6ZfLqG/pIyawdfwxVLHJMdVnqaUAmWdj+YaYsCMBOd+i6hbwsQ+3hvF1A7oWGaS+BvLxeVww9eIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7NB/AL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FDCC4CEF3;
	Thu,  8 May 2025 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746729172;
	bh=dI9PYz2NiVcz9XB8oLCo4yQGCH+anaoEe3DTOVFETh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t7NB/AL1fy/mTrbiHY/MCL2wqDOxfSJ5ZaouwvyNeFyhSvHVzRHcapexCm80sRaiE
	 qN8bkVF2Wluimr+pQyWA3JqyyvItf+KYo1kdpcVw11nq4aeYiZGjmha/CJDJ0naK8u
	 qmlmHGbqa0T9ikWCJPAgCzIFrmOQdtmnrWa3Hjamo4RXGxrVg/M/eAX9oYz56/jHbY
	 2d8t+yRuqWPz7TCMvBmBxtT9aPzZJDKSyXA4wZ8jOQI4s9WpNHjRSgSFnBIiqd2UYW
	 dr19azTjkz5GVGlRbnHMQCe83yZZvPQdTTFfqyQEUdrs8nAh70VlkbcrLUe+4vyu1X
	 c8Sjjw9ybXmXA==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f54e27405dso5370416d6.3;
        Thu, 08 May 2025 11:32:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGNqfMlaRrMH3FQEuGYLmw3vmWAtcLVaAOfA6gcVVB/rbaP0550H0zf1htprU98eA0R1nUB+t6fb/XVqAJ@vger.kernel.org, AJvYcCUsfKjJDuRHikpRYAdu3GVEVZJbzLnm8ybzhUG04CNHua+d6H1k67rCoXbup0PhxI8nk3/emgGObs6YezM=@vger.kernel.org, AJvYcCW2+Zc0ZUXa+bM49P/kzOiObjXEdWVlwo409Fi+B7QLfosvHRYT0BCST98Q3SWdesFxXnglE9mORhbF/KtWvWw/@vger.kernel.org, AJvYcCWxfzdKaxXu0YtUqSQnulunKUobDikQCHsQeIwb4gvGD4cN8rFAAS6l8ZPWgR85asD4DM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+AL0OGnubg5PdDcIup/MSqziaDy3AVhucjJFmLArhjKSwT/y
	TgrOxxXaDdIl1cPUYhjKtMaGQDxq/SFBrTBT8qAnQ58a8T59O7PUWaGtJFvskgrp6lFDA6RrqTq
	w8DZfpM9W3fRmy84T0xXnqNXCDas=
X-Google-Smtp-Source: AGHT+IFGy1cRgySSEQi/MG5bIU6lid7JLUbcXDq643AD1ZUr6eRMCZ7Yix8NvK6uHTAvzj7j2m5rR44CYrq6wg9RldQ=
X-Received: by 2002:ad4:5dcf:0:b0:6f5:46b0:7d11 with SMTP id
 6a1803df08f44-6f6e48100a9mr5001936d6.36.1746729171544; Thu, 08 May 2025
 11:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com> <20250508182025.2961555-2-tjmercier@google.com>
In-Reply-To: <20250508182025.2961555-2-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Thu, 8 May 2025 11:32:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7aGCof7=4kcPC0qFr9R1CD-L8aXFV6viBBK43UJZB1KQ@mail.gmail.com>
X-Gm-Features: ATxdqUF9-QhsdlBFsjsiwpLDumtKQSWnSrDHS1EoJZlTkU8ysEENxH7Dxn847kM
Message-ID: <CAPhsuW7aGCof7=4kcPC0qFr9R1CD-L8aXFV6viBBK43UJZB1KQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] dma-buf: Rename debugfs symbols
To: "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 11:20=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> Rename the debugfs list and mutex so it's clear they are now usable
> without the need for CONFIG_DEBUG_FS. The list will always be populated
> to support the creation of a BPF iterator for dmabufs.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Song Liu <song@kernel.org>

