Return-Path: <linux-kselftest+bounces-8172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1758A6F89
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AB7281B53
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE2130A60;
	Tue, 16 Apr 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8Vpkrwr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565A130496
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280717; cv=none; b=nyuh2d6OA9Y1JZk109jrYJtsaZvRfa/8jnV+d3vUp7KYVHPIPfcMtIN1Q+YU8/Xw1oMDTJrEDDpcqSBOCIQVlpCnEzZA3QzwSpHGkuGCi1cnG4R4tN+E0uu8pEYsbBDwZq0vFwLcmyA+QproepsmmqW1LfaCdqQHTKepOS0BRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280717; c=relaxed/simple;
	bh=lYE1WwVWduqiUKk0/Fr7P7qfuRFB+3QoYoBsKP9XdJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XmQ2r5D3VmJj0zNsNTDaH/Fsf7DDuolNOn+xprhaE4G7UVcy42VWjTKVpO9jXXO4fi6iarnE9l53L/08XA8tHlXTUufjzXsaPn48KUcJPNV65nyTOzIwYqZfbYiRGnsT54ODVLHO7qHyswLUClGf6zT3ZYawPGj8LRGclqRdLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8Vpkrwr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-418426e446bso68995e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713280714; x=1713885514; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7xPJ4NgaRqZ7lnpDudSOzBFLojU78EScRSM6wvzvKk=;
        b=u8VpkrwrF0WFsuA3GGhf/Lxd1SsvcP77c/ULglw5r0AKH8/bb82svzCjOjmgEX2nA9
         QYiBiPJK2anos/fTkWQwBd4li3uuUHyxT61WtS1YwP3ijJf5hM2t5Czz1HwYSfhw1yUE
         SiVNT+jzxV2pZ2C2XELbhSRwFh4biD5kVNmBOD+V5Sg2eAtin2EwIGv13uiJh3MHf0eB
         0tEkzbcPF8c/ffbRm3KJZpg6lDn/fx7cNgSFGQJ/N8peYJAn1hEW+7BkZgvmFxoU6kYr
         I+UaVXCdF4B9qC170YW5v7Np+5VAz9wj12fLP+kuCLlORoZ94JRyG182LwcNl83xsKE+
         Pe8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280714; x=1713885514;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7xPJ4NgaRqZ7lnpDudSOzBFLojU78EScRSM6wvzvKk=;
        b=s+Y1ls5X9/+7iB7vr0TGhLG69wmIKp22N94R5vmantf52CwS1FacMlideykYmR3zZm
         UR8Gu3n4zy9pvldHihYF5H3D8c7YtIhVlLAVZtpHElTCnS/Qzj404yKq+XEjfcjYmKXF
         XeoXLQqUwU3wQYTRwiQdbC7HSoaERBBooh0nCL6FunbnzvrpxCXGtzb5jl58hqmJXykv
         u+LzETnpps3N0rZ4+hj5XgLNwrutl3mWm1hOus8mNkBJ9+rq/1h5T5ISPRMij2evmQu3
         t17kpQZ1919dANzdER3LoeQ2cqD4rHuj2yhSngc6ucxBJMztFT5rHN/N4J7eW3TxGQds
         qsaA==
X-Forwarded-Encrypted: i=1; AJvYcCWPG8lYXUX7UfpvRTOYkuN8C611pSXDVt0YGs9Gu04sMZjYhHguAJUu9wqMNbBDnIzLrzXWI0EN/Ttwjwb5qKxdWShwiuEZheSujn9XLKDM
X-Gm-Message-State: AOJu0YwWXoLphvGK3VJoemDZZbeI6kxC8XaN93bS87nHweF5/pselxg1
	yXdCmmTzytwMNwX79txRKrdSPG7ZptiNjL0o/O9mrbKzHrFyvE/KhIIlQ4PZJp4KzdmAFX3OqTc
	tsQRjRqM/Or4MxFgzTMGLiIP6O2d6KpHwLNzl
X-Google-Smtp-Source: AGHT+IEeH9C9bC1RaxsNelMnFwqD5KOxfvmXYJRoKyxe3Q7CaWZjnpYXhJ/saHUxjHvV1zQnpGdajAJ/hjr7wymfVm8=
X-Received: by 2002:a05:600c:1c8f:b0:416:bc07:a3c9 with SMTP id
 k15-20020a05600c1c8f00b00416bc07a3c9mr210315wms.6.1713280714469; Tue, 16 Apr
 2024 08:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240415163527.626541-3-jeffxu@chromium.org>
 <v22gngid25vcufvdfbv3pdymq3s72c47pizr23tkrmbbyiqoe4@y5yxseh6thnf>
In-Reply-To: <v22gngid25vcufvdfbv3pdymq3s72c47pizr23tkrmbbyiqoe4@y5yxseh6thnf>
From: Jann Horn <jannh@google.com>
Date: Tue, 16 Apr 2024 17:17:56 +0200
Message-ID: <CAG48ez2ezHXVWg4y7yUx9Wi1CKk_KeU_7RJVBqkABjQhM=HbBg@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] mseal: add mseal syscall
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	torvalds@linux-foundation.org, jeffxu@chromium.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:59=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> * jeffxu@chromium.org <jeffxu@chromium.org> [240415 12:35]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > The new mseal() is an syscall on 64 bit CPU, and with
> > following signature:
> >
> > int mseal(void addr, size_t len, unsigned long flags)
> > addr/len: memory range.
> > flags: reserved.
[...]
> No per-vma change is checked prior to entering a per-vma modification
> loop today. This means that mseal() differs in behaviour in "up-front
> failure" vs "partial change failure" that exists in every other
> function.
>
> I'm not saying it's wrong or that it's right - I'm just wondering what
> the direction is here.  Either we should do as much up-front as
> possible or keep with tradition and have (partial) success where
> possible.

FWIW, in the current version, I think ENOMEM can happen both in the
up-front check (for calling the syscall on unmapped ranges) as well as
in the later loop (for VMA splitting failure).

I think no matter what we do, a process that gets an error other than
ENOSYS from mseal() will probably not get much actionable information
from the return value... no matter whether sealing worked partly or
not at all, the process will have the same choice between either
exiting (if it treats sealing failure as a fatal error for security
reasons) or continuing as if the sealing had worked.

