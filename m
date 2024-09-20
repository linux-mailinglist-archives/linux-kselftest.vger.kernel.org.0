Return-Path: <linux-kselftest+bounces-18160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C789197D386
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 11:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6111F1F22077
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 09:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E635C81AC8;
	Fri, 20 Sep 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWXnBuNY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3E52F9E
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823882; cv=none; b=c/CWSXRo/fPHtDmKzJJgnLx66n3QUhFqn71Gw7a/n1Twx8W9XZp8rD2NTZ0X47YtMUz6ZfqegPM89q8QfIo85Y5sHtJUHt+BqgOex1dF3Hra+tqfymS47TLRDsJpd7NdUNO2HbfUoQKALl3WK7pGPmPUWY/A/1ZtWs91RU2C09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823882; c=relaxed/simple;
	bh=zbhZuLmkZH4JNEw70muk9rH99tbwjzi1yOc+2Q6FsuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tthXiKamgDoqPLFi29hDG4nwiY3t3h/UpIuOAaUBvcYZKOxqLVN9WDrf3B1LMLzBArfiO1yYkiL/h8lpAUgtR6n54rDCF5GSHc8wtQ8dXchu99UAAsjXEISOMDt0ixOYoI63/0f1H0UONvh4L2Wa+M/nGj3CvL2iPYSvxjD8USQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWXnBuNY; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53690eb134bso19295e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726823879; x=1727428679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lFk8tXQAtRWRov+FyUw+DOlND+znAP6uIhHjKMCkOc=;
        b=nWXnBuNYa1af+RZGUCxS2/DGpzXz8ajuakHEj7vIutbYjRGWn29ldzrEHhsT1/4fkb
         2JkGIsvhE7+U1mODu1Cbh2NHJFyVLMKDviYYZLpXO6V2bb+0Ngurky1Dq4yRStBy2TI5
         KxmDv/imlMqXphCk5p0kqXJaupVCsjhmDioUAXPo7KSarjJft3q2xZAxn97BRdBgwnVH
         rl/pt5gnp9ghhq4RB/o7pdvnPTAAtKLSKkzQMVaT/M67Ojl3VbnK+EKxp6mSMbz8Mshk
         o6rnB/Y4/Sr2ipnx/F2Ys34F0fKBEW1NluDe+ZWNtYzqTHOCNzrOhe9Bb7MYTav9g1Mi
         5rJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726823879; x=1727428679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lFk8tXQAtRWRov+FyUw+DOlND+znAP6uIhHjKMCkOc=;
        b=pBl//kkm4V+OBgCFvZ0hebZ9KR0cOsuHH4cA3p9tjH/qiAttROWdBuCuO9yZjdvsag
         gwU5w05AbzouDjUrvClJq2RQ6Fm4awoHuT3EmH4XbcdDs4yBsuIqcdJTU0/5o/CtxwO3
         gLjXkptJ6UmF1uJAF6lheNuZNH2/xj8kXh98Q1ROUnzeY2Ihx/uGUTvE+cNCUb01ziFL
         91WmkK3lFp9dOgRJ7PvAo3EA0JzK7kB2O92mCrvA5nsL60c/oGf0I6xB9VDmbEKhV12i
         t7LAXV7tKwLPFeShNx9/15sb/xJ2bXRDSJu6jRN7jl2AtcPtqDf3rJg5zv2U51TeScqN
         2WNw==
X-Forwarded-Encrypted: i=1; AJvYcCXC7FjrmQdIMtzbw9LkTaWpaQuj/kzlqqOljrraFX7vhm08FpURNXd8qsfvP9GTXRuJoza3jtFoA4g6KSNN0ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFf4rab9v9RMFQDGp9Aa8Iz5RbGxdeYx+zXGajCL4xKNIUf0A
	xEb6xGgftmIebJCbq2l06FvIJuLxhdxE2FygSbkzl6VBIpOO13iYT3HNiF815kidQL82o4SWAvu
	wKnCrJPHK+CTsCSmUKgau6g1dw53V6nZchm1h
X-Google-Smtp-Source: AGHT+IGUyIDlL02SNNAcH/QvRLTVV1cCj4Jx4XR/xAOmRuwfotB2Vg+l7WNmIIRqJTSsmPZsLrQ01b0WIBQsdccc7K0=
X-Received: by 2002:a05:6512:1192:b0:535:6a42:90f2 with SMTP id
 2adb3069b0e04-536ac6a8cc5mr341346e87.6.1726823879081; Fri, 20 Sep 2024
 02:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <3fec11d8a007505405eadcf2b3e10ec9051cf6bf.1726009989.git.ackerleytng@google.com>
In-Reply-To: <3fec11d8a007505405eadcf2b3e10ec9051cf6bf.1726009989.git.ackerleytng@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 20 Sep 2024 11:17:45 +0200
Message-ID: <CAGtprH-xw9DFwheTicNStXKhMJTsuXviBnq1PwvrxEHMNkb83A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/39] KVM: guest_memfd: hugetlb: initialization and cleanup
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com, erdemaktas@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 1:44=E2=80=AFAM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> ...
> +}
> +
> +static void kvm_gmem_evict_inode(struct inode *inode)
> +{
> +       u64 flags =3D (u64)inode->i_private;
> +
> +       if (flags & KVM_GUEST_MEMFD_HUGETLB)
> +               kvm_gmem_hugetlb_teardown(inode);
> +       else
> +               truncate_inode_pages_final(inode->i_mapping);
> +
> +       clear_inode(inode);
> +}
> +
>  static const struct super_operations kvm_gmem_super_operations =3D {
>         .statfs         =3D simple_statfs,
> +       .evict_inode    =3D kvm_gmem_evict_inode,

Ackerley, can we use free_inode[1] callback to free any special
metadata associated with the inode instead of relying on
super_operations?

[1] https://elixir.bootlin.com/linux/v6.11/source/include/linux/fs.h#L719

> ...


>
>         if (size <=3D 0 || !PAGE_ALIGNED(size))
>                 return -EINVAL;
> --
> 2.46.0.598.g6f2099f65c-goog
>

