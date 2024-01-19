Return-Path: <linux-kselftest+bounces-3242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 094DA832A22
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 14:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F399B21360
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D84F1EA;
	Fri, 19 Jan 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuUH4I/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745363C467
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669943; cv=none; b=JnJ/easi75PlG7JUAGvQQsiDTPfsDxyp3GQMB0lOxX20YCSFnOBwu4wrfV7Kll0O5WSl+7VNszIBAdRY5TEB61LzihlunCAd9nVSvvhUN4LNSUSTYKhm4jm97vPia6xKA1dglIj4y3D5vOpb9PKOKSRSCnojrL9Jmt332gYyt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669943; c=relaxed/simple;
	bh=Ib20zY68P2ii/G09SSPsak2hYrVP9F1ZwDcarzVgh9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COQSM1WbcmGUNvq+HyZz5Zzg2vqseMNF9bOjbphcy8atajxrPh4aj2V9M5w6qvNV7sZS0HNSYEugj2EXuvH9fct2EE7+QFvwerOUvMuBslvj3CUBe0y+gUM9M+kF2HLRznKZ0k+RoC/brDp0exBGQtieumY0w2+p8FnN+YdufsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuUH4I/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705669941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi/ghrBJ2abck4Wwi0h7DJOTr7ObAnQ+55jlxgP3HjA=;
	b=OuUH4I/ElixPlLjwG0toH+dcDBtPYPdQ2h+bZSbS7NLVtPUq5bZuPE6LGFWVAu6KwU6b0D
	GO4+xD+hQe5H3v8SpzkQFgVtyCHoCV/YNkBNQXHYaLYk/x1fA+cBIqDdzeAGRtN+xYr6bc
	artYrVSH6fwOYafBDEy0z4wJA+YAgY4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-ihUNu-CZMHClhBmB8iEtQg-1; Fri, 19 Jan 2024 08:12:20 -0500
X-MC-Unique: ihUNu-CZMHClhBmB8iEtQg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5f53b4554b6so11070177b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 05:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705669939; x=1706274739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi/ghrBJ2abck4Wwi0h7DJOTr7ObAnQ+55jlxgP3HjA=;
        b=MBesRvZPHdgmLszuMMIYbKljeMMH5APEhflNMVlOAA4PVariPWYAr22Ty7B34+lO6J
         m24Nz4sHth4DRFsVMVaWy+t1XqTyYGTkbdGinkNfsHlm5FV13YwCBkq1/nHgy56uyjCp
         KT2eh8wQy8EO9zn/rrDI44H17Wd7HNf957MNnXmERPXXwiaCDyNWgBrJfn4DUhVFeeuP
         xdyXV1zjGCACaStwFZhPBgn0f4++yTU7VwMk6V2n2+4kMpJI9q8dzkV657PxxTCr9AxE
         AwTSisCnWqDUz/EKBRA9BYYQmKKzu48RG1eSD3EEGnez3VXZwZBaCFdt/XGklWqSIgTe
         oRSg==
X-Gm-Message-State: AOJu0YwBIaIkW+ZIu1CfuR19BBk3Bg8ZD/a1Z+exUYfl0bA5lMWaDZzY
	zMVrwtyWEi/w2ni4hOdYFU6ORaLbv6sH6mFrTWjHUFvoXafkNDfrUKcmp6Z80h4pHzH7VftFWcq
	Ayw/UN+ek4p/QBtrX1SW7yiTBLm7EiUI2XZmnOfHW67oZa6jWSqCxKCmQNReWzM/NArd4WQqxdC
	rzqPm7Yq1NLNQC0N43VpuhGJccOpvKMiEAW9yu0zLg
X-Received: by 2002:a0d:c645:0:b0:5ff:a425:d64c with SMTP id i66-20020a0dc645000000b005ffa425d64cmr315878ywd.81.1705669939711;
        Fri, 19 Jan 2024 05:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWU7V9Q1CXIQM2Ccn6r6qwMKr0viLEcFyZjGJWi2COiELrL6Ao+cdsiwQaNT8Dcq5w8OWMxHAZin/mrp2Jjac=
X-Received: by 2002:a0d:c645:0:b0:5ff:a425:d64c with SMTP id
 i66-20020a0dc645000000b005ffa425d64cmr315869ywd.81.1705669939501; Fri, 19 Jan
 2024 05:12:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119125753.152354-1-npache@redhat.com>
In-Reply-To: <20240119125753.152354-1-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 19 Jan 2024 06:11:53 -0700
Message-ID: <CAA1CXcD55JLQfpW8OzzfHsyaVX5cJHO-y7v8miRyL1t3fnejqg@mail.gmail.com>
Subject: Re: [PATCH] selftests: mm: fix map_hugetlb failure on 64K page size systems
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org, shuah@kernel.org, donettom@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

NACK.

I accidentally sent an older version of this patch. Following up with V2.

On Fri, Jan 19, 2024 at 5:58=E2=80=AFAM Nico Pache <npache@redhat.com> wrot=
e:
>
> On systems with 64k page size and 512M huge page sizes, the allocation
> and test succeeds but errors out at the munmap. As the comment states,
> munmap will failure if its not HUGEPAGE aligned. This is due to the
> length of the mapping being 1/2 the size of the hugepage causing the
> munmap to not be hugepage aligned. Fix this by making the mapping length
> the full hugepage if the hugepage is larger than the length of the
> mapping.
>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  tools/testing/selftests/mm/map_hugetlb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/map_hugetlb.c b/tools/testing/sel=
ftests/mm/map_hugetlb.c
> index 193281560b61..dcb8095fcd45 100644
> --- a/tools/testing/selftests/mm/map_hugetlb.c
> +++ b/tools/testing/selftests/mm/map_hugetlb.c
> @@ -58,10 +58,16 @@ int main(int argc, char **argv)
>  {
>         void *addr;
>         int ret;
> +       size_t maplength;
>         size_t length =3D LENGTH;
>         int flags =3D FLAGS;
>         int shift =3D 0;
>
> +       maplength =3D default_huge_page_size();
> +       /* mmap with fail if the length is not page */
> +       if (maplength > length)
> +               length =3D maplength;
> +
>         if (argc > 1)
>                 length =3D atol(argv[1]) << 20;
>         if (argc > 2) {
> --
> 2.43.0
>


