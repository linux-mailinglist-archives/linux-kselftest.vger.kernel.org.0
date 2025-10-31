Return-Path: <linux-kselftest+bounces-44558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A91BC27205
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 23:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29DBD4E61F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 22:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A53932B9B5;
	Fri, 31 Oct 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmqv0t4r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864532ABF7
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761949738; cv=none; b=oDDry/iznXMT3UXP8QVB4ZkHlfzB/zCZIpOJ0zPkpMuic0E+Qv1wCJE5WONd1YCL0LJL3wODMLi/De27W8JF+D8AiT9DxU5MslGCztnpbWFwFWx97VS3+B6bw6bzbWaSWmH2p/QzpDD1LtHMbIiUV8dlEZYp8L647j14oaSXtiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761949738; c=relaxed/simple;
	bh=VZXcKlS2NfJQUqJUaLkoMO31MbXfEPxVU5q67dhNYbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCdBPY3UrcAOWGWZ/Cdni0aAjQRdZdX7KfNMQ9tjeLZs3+vLPf/efeMiFTlH1D/ZDPZJWFHjHN9QGN5yaBmiRDrC35tf5YMlohlVMa4qkNMSKAMaCCohvAQZx9gSW03erx3X/NUJwJreB+Kii4rtP3IRZwJ/hGTNZDWpQjJA9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kmqv0t4r; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso3977137e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761949734; x=1762554534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4VDPOkfEPN3V+mmkEOqmJfTYjVG4ZaMp9wTEce6ggY=;
        b=kmqv0t4rwZ+OooujAZB89C6U1PE4NY/hxG/N3arnBNvt6gcdI5fjWrSGf9YrcyXxKN
         yGg9J1HH/8TDQyiQiH1cwV2QnT74vWm7ZDyzcEYxuprajEkVaX4f/gJzwKnq1HfQ20ZI
         X/H4W9dQ2Sgb7YJMKmtl9Y68AnxuYX3owuhcNhD5/lBrRXvnr8VB6MuiuH4tYrGBphz1
         FtPytlwa3a6X1saOPHQg4ZaGJlMimZNSNYSsVunvrU6M11Y6f++bi+QoWO4mJJIvDi44
         uv6MJFrni1aUExCr/m8s6EQTGCu1qWpjXecUUFYn+kyCivXg8JeMiTaqkLgHZZqwIxn1
         jxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761949734; x=1762554534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4VDPOkfEPN3V+mmkEOqmJfTYjVG4ZaMp9wTEce6ggY=;
        b=um8RIp2f1MMTTMtZYB7I7bEfu04UM+mAYv7cOhC7e9uahrPqV+BoLdOPMfJS1B1cdV
         1NzoZyZ0j4/wVEIY1ezGLY9dCviy8a+IyYKZ0HzkyHU5+P/EC2sATVpMjIbLbA/YQOOz
         3WXgWJTLx8O45IaV4rBwj2ZdpNIwfJXxVAbIsYZIkqqo1icHuaQLxhpilp80HHXnJ+8R
         79UNBufkcCgdL3iw1uPvkSg8/jWt3XtXxFyg17HuCb5U+UjnQu63KiSnPdHc4ooW9jnZ
         t3/mn85w6gRu2zOy3GQetlmuakmRWDGN9fagSkSGq4xZ+TTyZ4cXJHs4WtAn7R38Uq/7
         FSkA==
X-Forwarded-Encrypted: i=1; AJvYcCUPTUpzoueu/ZgbRhWVs/9WZvG3V+D7RQiO3vNLvs01zXR/841h8pZPF7iY31aSR7ziyN5EZBtIKzzYlRnApIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCerJhSeg2EcZ33IGV6uoTb/v/6OjFoBvfptFrphZiPOfyPBK
	GTnjxrw6hC8nKwQcAOgCvsbACJ3c6rZ1AK2YCmKze9LmTdq83gvhlCO3cM1k7OQ13m3KQx/BM6e
	lCJTGIQdCHq5sWwq+IeFGSeLqf018IHeZCMB8vQqX
X-Gm-Gg: ASbGncuzM3T4GdoqxaaKR1uFaSGfbv+gS2YcsLwoy1EjsimsVchLJpv9JZUf/rFVlw8
	7q4g8wAMrU58b+GsFl4p/neJoB/xfUUU0OmN8Qnz2u+JJMb2SvnU2MqsuItAUYZhIadT5vKDmMt
	PAuL59KWY/1wZ3L1Q8Cgjgh/jTdk1UTqEa6cqmnsT3Z9RclGbZ/i7iaGILdzGQMr5W5v1ObQ+su
	L/v6UvF8jAYydebFD3OT5vk9pPP8lwwEDpODFanBbhOpOGokJ3a40bkJAKNAZWbQqfoTKk=
X-Google-Smtp-Source: AGHT+IFSwcMwTIDGFtEaqjdkz/AcJl72mmVl0IpQ+J78Aae+a4oANLR7hdtuxWyAxkV1yPdEbNFPfRUD01apBcVpx5M=
X-Received: by 2002:a05:6512:15a1:b0:593:11bd:9af7 with SMTP id
 2adb3069b0e04-5941d5586cemr1780294e87.36.1761949734165; Fri, 31 Oct 2025
 15:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-6-vipinsh@google.com>
In-Reply-To: <20251018000713.677779-6-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 31 Oct 2025 15:28:27 -0700
X-Gm-Features: AWmQ_bkJhwWK8iLPcHy-hUK2RP4WggOSXosGGLXjIhn9TKPWrHQgEkrODFylvq4
Message-ID: <CALzav=f9tjgyF7TBsfjCpmvRezkkgfQY-OXwj+TaebjeffK-0A@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] vfio/pci: Register VFIO live update file
 handler to Live Update Orchestrator
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, pasha.tatashin@soleen.com, jgg@ziepe.ca, 
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org, 
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, 
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:07=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
> +static const struct liveupdate_file_ops vfio_pci_luo_fops =3D {
> +       .retrieve =3D vfio_pci_liveupdate_retrieve,
> +       .can_preserve =3D vfio_pci_liveupdate_can_preserve,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +static struct liveupdate_file_handler vfio_pci_luo_handler =3D {
> +       .ops =3D &vfio_pci_luo_fops,
> +       .compatible =3D "vfio-v1",
> +};
> +
> +void __init vfio_pci_liveupdate_init(void)
> +{
> +       int err =3D liveupdate_register_file_handler(&vfio_pci_luo_handle=
r);
> +
> +       if (err)
> +               pr_err("VFIO PCI liveupdate file handler register failed,=
 error %d.\n", err);
> +}

Alex and Jason, should this go in the top-level VFIO directory? And
then have all the preservation logic go through vfio_device_ops? That
would make Live Update support for VFIO cdev files extensible to other
drivers in the future.

