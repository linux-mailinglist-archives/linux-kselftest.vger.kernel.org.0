Return-Path: <linux-kselftest+bounces-12213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E02890E396
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 08:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD572848E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 06:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640D274059;
	Wed, 19 Jun 2024 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqRATEGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB1974043
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778969; cv=none; b=gB0/139m5V+hMZFJ8T76bhgO500nTHzUzmj260+5+lRV/yUrrsML3vSwCJfxYweolQy3Sg0PckCXCxkOfjqz1cPXyAfeBd9/6ZnorNnlTlr/pO1LkKUpxM3Za8miocRcn3kofWLJvirtC5G53y0Vsanvq5jvfExP1nz+i7ccZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778969; c=relaxed/simple;
	bh=eFoNHEsNU8rN9fD1bcCS2LpMK1sY2sSZroJWi50MjlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INeQCoUWZb/+431Sw/dq2T+M9cU2TJrG6A1GPBVLQoMh01+mfr5E1f5dUviIkKeAhcZ9vkzQ21ZQBm1BxoTn8vsfvAN6LTgBAkK/cUZ362c4bcDrRQkUdc1aSvMpeJOUxpK2M6AL7owC0B4iM9C7mu9wgwjcz2/MFEzqrOfSg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqRATEGi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f275c7286so5561161f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718778965; x=1719383765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hlGoj1WJJZ3FnqOdHCOQOom5O1x4l3tplNmOT+ncro=;
        b=nqRATEGiP+rfYWpa3pAxVTscTSlvd7unR978LqRsryYyB/QQ13HYztf+h4269m7rUy
         DltqPtIyQRpCEBF9TDNn90/js3lCZVWci/RPVIBgFmzXf/iXtt7nKuGE3Pdtud3RVdZa
         7tX4gLprFNDbhgLfQ9OV7y4xCblrRPxUjzbA2zxalJQ/aeEVUHir8mFowGF37F+OyrEK
         L1PgC4K0sHsi2z0VJswyPvEShjhvqyiTKsJyje9+z4e2ZphHKc65C8EDu32aeUbtebGF
         A6FbjEr3PGxzIOXMzAvZ0lj8GgKalj2xdI5nmUo/cL7dfeBdHuqJ6xzDbsiNetPup1D7
         xPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718778965; x=1719383765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hlGoj1WJJZ3FnqOdHCOQOom5O1x4l3tplNmOT+ncro=;
        b=gKNxo4s7g8mgizWwrkESv7d98KSwZvazWgn43fcjezacRwfp8A7r6mSNUFXT7+Lzim
         ZzXoqaYxbUXkXVwUz9+HkJ7UYzNpVeKW4z3siMQ8suQIV8lL/ySJnMTpfj60J6eZfLIN
         seb+rkk+5A4K4fsH1H+RgPNsN66xWPKVGnQB+JFWf17y/hDdPwb/QBBWydupD8Obc/NH
         cVy8AaF14nt+6Az2KCs9SMIDg603aRuRFWyi/K6+FbXErfehOPjIxeOXHCYT7hoWEe7J
         fkHtIuw9KvKw+095+TkrT1sKCG2k3WzuhyHSTL5PMtO2j2OAC38be96GQt1YRM3MvN4U
         rl6g==
X-Forwarded-Encrypted: i=1; AJvYcCWJC2hl2EFsGoCFDbgsQxa9GV3z5llHo3j6/w+xr48CCzpkOJCxMAVsdzOoFMFnWkuWbp2mlDqxlxCsOVxvs/Y9GE1NvM9r8zU5DHVx08Uk
X-Gm-Message-State: AOJu0YwJpfkKINcU3noUtk91xwNSDdyyKvRFPBzlgQFXigFd+MIWtazN
	1cR4aBb4G9SGdI00ib6KZwwvQUqKlANppd0MoAAexxZ1cEm1pQkUmq11zEcTlnKK2/ylYA6WmSG
	czP4TcAsSxp+LWzhLq1KEEqrj4RPisGedT52U
X-Google-Smtp-Source: AGHT+IFmJwrN1XtzxVor8Ksc5pIRoSEYDV4HvFEp9czSMYJ+DnMAA3sRjTwtOF/ttR1vYn960PnYiUWt7/NrxEw/MPE=
X-Received: by 2002:a5d:4d4e:0:b0:35f:1e09:ac7a with SMTP id
 ffacd0b85a97d-363177a3931mr1215725f8f.15.1718778964729; Tue, 18 Jun 2024
 23:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617170545.3820912-1-jiaqiyan@google.com> <20240617170545.3820912-2-jiaqiyan@google.com>
 <20240617121348.4ee672a1d6bc9202b3ad0e08@linux-foundation.org>
 <CACw3F51wq4H-Hoxvm7GgCKodAR4Wy28hwBD=VngcF-fbxyRmUg@mail.gmail.com> <1a40217a-240c-4efb-5c2a-fe885c0109ea@huawei.com>
In-Reply-To: <1a40217a-240c-4efb-5c2a-fe885c0109ea@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 18 Jun 2024 23:35:52 -0700
Message-ID: <CACw3F52agKixs45J67AevQi3enmgU-UufdVBfM_YCSKAUV9+eQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, nao.horiguchi@gmail.com, jane.chu@oracle.com, 
	ioworker0@gmail.com, muchun.song@linux.dev, shuah@kernel.org, corbet@lwn.net, 
	osalvador@suse.de, rientjes@google.com, duenwen@google.com, fvdl@google.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 8:01=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> On 2024/6/18 7:17, Jiaqi Yan wrote:
> > On Mon, Jun 17, 2024 at 12:13=E2=80=AFPM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> >>
> >> On Mon, 17 Jun 2024 17:05:43 +0000 Jiaqi Yan <jiaqiyan@google.com> wro=
te:
> >>
> >>> Correctable memory errors are very common on servers with large
> >>> amount of memory, and are corrected by ECC. Soft offline is kernel's
> >>> additional recovery handling for memory pages having (excessive)
> >>> corrected memory errors. Impacted page is migrated to a healthy page
> >>> if it is in-use; the original page is discarded for any future use.
> >>>
> >>> The actual policy on whether (and when) to soft offline should be
> >>> maintained by userspace, especially in case of an 1G HugeTLB page.
> >>> Soft-offline dissolves the HugeTLB page, either in-use or free, into
> >>> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
> >>> If userspace has not acknowledged such behavior, it may be surprised
> >>> when later failed to mmap hugepages due to lack of hugepages.
> >>> In case of a transparent hugepage, it will be split into 4K pages
> >>> as well; userspace will stop enjoying the transparent performance.
> >>>
> >>> In addition, discarding the entire 1G HugeTLB page only because of
> >>> corrected memory errors sounds very costly and kernel better not
> >>> doing under the hood. But today there are at least 2 such cases
> >>> doing so:
> >>> 1. GHES driver sees both GHES_SEV_CORRECTED and
> >>>    CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
> >>> 2. RAS Correctable Errors Collector counts correctable errors per
> >>>    PFN and when the counter for a PFN reaches threshold
> >>> In both cases, userspace has no control of the soft offline performed
> >>> by kernel's memory failure recovery.
> >>>
> >>> This commit gives userspace the control of softofflining any page:
> >>> kernel only soft offlines raw page / transparent hugepage / HugeTLB
> >>> hugepage if userspace has agreed to. The interface to userspace is a
> >>> new sysctl at /proc/sys/vm/enable_soft_offline. By default its value
> >>> is set to 1 to preserve existing behavior in kernel. When set to 0,
> >>> soft-offline (e.g. MADV_SOFT_OFFLINE) will fail with EOPNOTSUPP.
> >>>
> >>
> >> Seems reasonable.  A very simple patch.
> >
> > Thanks for taking a look, Andrew!
> >
> >>
> >> Is there sufficient instrumentation in place for userspace to be able
> >> to know that these errors are occurring?  To be able to generally
> >> monitor the machine's health?
> >
> > For corrected memory errors, in general they are available in kernel
> > logs. On X86 Machine Check handling will log unparsed MCs (one needs
> > to read mci_status to know what exactly the error is). On ARM, GHES
> > logs parsed CPER (already containing error type and error severity).
> > The shortcoming is logs are rate limited. So in a burst of corrected
> > memory errors the user may not be able to figure out exactly how many
> > there were.
> >
> > For uncorrectable memory errors, num_poisoned_pages is a reliable count=
er.
> >
> >>
> >>> @@ -2783,6 +2795,12 @@ int soft_offline_page(unsigned long pfn, int f=
lags)
> >>>               return -EIO;
> >>>       }
> >>>
> >>> +     if (!sysctl_enable_soft_offline) {
> >>> +             pr_info("%#lx: OS-wide disabled\n", pfn);
> >>
> >> This doesn't seem a very good message.  There's no indication that it
> >> comes from the memory failure code at all.  If the sysadmin sees this
> >> come out in the kernels logs, he/she will have to grep the kernel
> >> sources just to figure out where the message came from.  Perhaps we ca=
n
> >> be more helpful here..
> >
> > For sure. I took it for granted that any pr_info will have the "Memory
> > failure: " prefix, but now realize there is a `#undef pr_fmt` +
> > `#define pr_fmt(fmt) "" fmt` just above unpoison_memory.
> >
> > I propose to do `#define pr_fmt(fmt) "Soft offline: " fmt` above
> > mf_isolate_folio, so that any soft-offline related code generates logs
> > with the same following format:
> >
> >   "Soft offline: 0x${pfn}: ${detailed_message}"
> >
> > If everyone thinks this is reasonable, in v4 I can insert a new commit
> > to make the log formats unified.
>
> This sounds fine to me. And even better, `#define pr_fmt(fmt) "Unpoison: =
" fmt` can
> also be done just above unpoison_memory.

Of course. I just sent out a standalone patch for unpoison_memory to you.

>
> Thanks.
> .
>

