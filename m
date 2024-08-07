Return-Path: <linux-kselftest+bounces-14975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B867294B202
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB12829F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E9E149C52;
	Wed,  7 Aug 2024 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBTH4dMu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EF4D5BD;
	Wed,  7 Aug 2024 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065661; cv=none; b=gQzcElsPuePmekEutF7aRiafI9Y6FuvMW6eIS1bEbuFMx4AWA1lR7yJ1zQAOe3I7jjV+yYCvSNQ/b4I0MJmLKSjXOtNF5t8IaIX2Ua6CHeEPArR++Qry3dkc+ySEYV0yMAChm99Bk7C/4n65WDfhFy2iw5+QNhUqzsvBqJhYv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065661; c=relaxed/simple;
	bh=Q9StI1/oLF+reeI0BzXDCOqRdiXqcMHJpL+sJx+ZEH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DN/dtv8E7nfQtEAcBlhNlcRFbs291lSyuJuXYc2EzxT+23t7FxMkb3kUzrrLZ7UTCMhJKQ+phxCabIjBJrn8Omh/hZIRSN20xluWyPLcyp1pK0zI42HeNmbBJoIGnCTlpejIfwPd/xCgtVSvtIm/lNF9gusFo4pufq2GgKAH7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBTH4dMu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efdf02d13so476461e87.2;
        Wed, 07 Aug 2024 14:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723065658; x=1723670458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9StI1/oLF+reeI0BzXDCOqRdiXqcMHJpL+sJx+ZEH4=;
        b=LBTH4dMuv9O4vCotSulK0NL9e9ndZRbM43AQqeHem69VUIJNFQDhZMUBaopyyW+lhw
         19lTiQi2MJjmwMTOrihLX/g0jqS9xLwW5oc/C3ZRYxKcSPZhJTrjHXjGxMh0k0S6jq71
         /4ZbmEa6xNTxZk20YXPk63MLPXeBUESOh3Uf14A4PFy5758WA0Xl5osp0YcFHIwXan4M
         eHLeLnERE2341hkUZQkY20pPig4n8sO708qms5SCwXx4QeO7MKkfPer5SIAqUC6RF3Hj
         XGvAzJ+uB4GDPXf5E7ZhBlaZRInrn/AaglQYtlyc9jfdXx8p+q8AJFkefhEY8WWF/Cj3
         i1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065658; x=1723670458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9StI1/oLF+reeI0BzXDCOqRdiXqcMHJpL+sJx+ZEH4=;
        b=PkYybIFQ6k2HR6H3sXt9HS9lavKEXZFmLF6HpCYVXFa4G7Jpak88Ix/RDmorja+VqG
         msnrWvM0xLzPTeOE2u48MFH33uhne7H4XFHiXcaMvCoY3jxqyIztwxr/KQjY3UnDuWx9
         3mrxmA8oqAW9tQdxgl90QB65aufuBYpX5dfBq757V+hNDuHX9QOPMew5krsqJBWhuLu1
         anRg+9wX2XiFxIMwgfp9gC1XV15prNNZF9im195z14TpelRvvgq1cc1F3rpNXE3WjL1a
         3ZmXiG7wgqN9LwSv3cpQ3zmPfM1wxPDePASC34rBf5KNH4nDO/wzss+1fj/u1cl4M4Jt
         yFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPQ8oUPANFmQbKYYBcBLpaute9U3TGGBqABbN27k7dLW4RB+NFxC6MCeQrRnQ6amb4Xqn4T7V1fQUOnAzkSGEfORVJUKFOe16SFBXb3wYzn1zOOMsaGlTKApideUS05QEt0iFf4K4GEvXqMeDlBT3I/lIdHy7dB6w2Ag4eVd6gCvMDTA3WsduH+/KvOQV9
X-Gm-Message-State: AOJu0YzRkJcxMYd6I5UuMWxDHbzxd+AhO1JNMEDFEA84BgyiaYKGJnNE
	Z60u9o8EpeJeMTKetNupBfn+58tRXw2FWMDnrEpxRu/d3jpUK0FLXWkL/R/ProorhjQNR62ZbKh
	ef09SbhgL3B8dQ3Q2QjPbEPUVQ1s=
X-Google-Smtp-Source: AGHT+IGpRCJ1YRnn9uiP0qSF32UWBzHiNfVncOswejvTC7AEhNh8Su/FWlYjgnFO3/eOiUS+Ojcdk0H0lvKTkM+qwWE=
X-Received: by 2002:a05:6512:1593:b0:52d:582e:4111 with SMTP id
 2adb3069b0e04-530bb3810c5mr17636399e87.18.1723065657821; Wed, 07 Aug 2024
 14:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153544.2754247-1-jeffxu@chromium.org> <CAKbZUD2xDdbxOTvR3-P=636jvhG_JPO3h79tgB59dfPmv046hg@mail.gmail.com>
 <CALmYWFvDH=8U8wsaSjMrfCg1__S66SS-9Zo0f826XJDJT7hOSQ@mail.gmail.com>
In-Reply-To: <CALmYWFvDH=8U8wsaSjMrfCg1__S66SS-9Zo0f826XJDJT7hOSQ@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 7 Aug 2024 22:20:44 +0100
Message-ID: <CAKbZUD0JuEwfd2VnY_Kbv2Mr0g0KN2T2mYCLhPuS8j6PhbCNiQ@mail.gmail.com>
Subject: Re: [PATCH v1] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
To: Jeff Xu <jeffxu@google.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:03=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote:
<snip>
>
> test_seal_mremap_move_dontunmap use 0 as new_addr, 0 indicates
> allocating a new memory.
> test_seal_mremap_move_dontunmap_anyaddr uses any arbitrary address as
> a new address.

No, MREMAP_DONTUNMAP uses the address you pass as a hint, aka you're
just testing get_unmapped_area, not any mseal capability.
There's no forced moving here.

>
> > You also don't know if 0xdead0000 is a valid page (hexagon for
> > instance seems to support 256KiB and 1MiB pages, so does ppc32, and
> > this is not something that should be hardcoded).
> >
> usually hardcode value is not good practice, but the point of this
> test is to show
> mremap can really relocate the mapping to an arbitrary address.

That's what test_seal_mremap_move_dontunmap does, no?

>
> Do you have any suggestions here ? I can think of two options to choose f=
rom:
>
> 1> use 0xd0000000
> 2> allocate a memory then free it, reuse the ptr.

Personally I'd prefer 2, if you really want to keep the test. It's
also a strategy used elsewhere (e.g mremap_dontunmap.c).

FWIW I don't have the mental strength to bikeshed over this any more,
so please do what you think is best!

--=20
Pedro

