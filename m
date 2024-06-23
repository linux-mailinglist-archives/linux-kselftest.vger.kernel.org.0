Return-Path: <linux-kselftest+bounces-12522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0684913C4F
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 17:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C00B20D2E
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F0181CF4;
	Sun, 23 Jun 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7grALWB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434C181D01
	for <linux-kselftest@vger.kernel.org>; Sun, 23 Jun 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156405; cv=none; b=kGOtBaG8dZHvOjGrHekxQZRUx3zWH7TlmRyaKV2Dlz5qffdHswhV5EcM6DjWBCrZMlbECK5LaGsqsstnj5nsREzNacuBHdDa3uAzbGpoTOwLq0KHkvvdsixXsaRtveRJGAwgNcDW+DAjXmtStwJEF10WxERylZ9IJiOLqMFEzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156405; c=relaxed/simple;
	bh=ooh7IaQj+cWRnQdaw8/1O4YXQwna4SUhIk+dL5M7/JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBJV8f4jT2IzKVZwfBDqpL0Hwj9sB0ZW+gKcxvj2y2k7uHSDRn/z7790MV0KzgJZDGVArovtrTjXmvW305J87KEaeTIh9tk5mbdaA4As6iSpwgZIwgkdjw+oa+PEdweSJXH1sd37/9dBz9Xq3ruj22aA4WpcZj69lFHMJDANAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7grALWB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719156403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFXK8G1SadQvGVrWX2KcQ+fiVJ5r+OsD2zAk1SpxTqU=;
	b=i7grALWBBNd5WFPJXUzlrFzwvqD3yrhfG9mBkZ1C82ZSlzp0+iYHMJHoLQuZBXcivn1J14
	yMsUUC8i3z76gd/MAFijp3JHUuapexcriBbu+t3R9+6RsiEFQDYZMCkLiziZR5BUw+3dPU
	ta5i5+TOPVxyLLkXocFBs+hpwk6ds6Y=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-h5P48UCoP1CcXGgtGc_qEA-1; Sun, 23 Jun 2024 11:26:41 -0400
X-MC-Unique: h5P48UCoP1CcXGgtGc_qEA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3d52868214aso213569b6e.2
        for <linux-kselftest@vger.kernel.org>; Sun, 23 Jun 2024 08:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719156401; x=1719761201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFXK8G1SadQvGVrWX2KcQ+fiVJ5r+OsD2zAk1SpxTqU=;
        b=GlhtSsw94Wl2Fw6HsDKHnx/2A+iXO/8ctSVfCRdk6RXmGjYOzo8Qvm3KaFunfll3kE
         GD7OeNHPBmDJ/7/anpEoRnDiE4C9WoGx3kG/mk9mLBkBsOnbVCcEPrbJgu3R33R9Yj1B
         tNWUXFVOpYGm4y3A/Koq1epp/oIP8DhDuJG4h2iGp3cSWfUA+AE1ew2XrRRGECLF85W+
         C4QK0FFjzkUDXbY66Fk1oiQWWRkCvbI0Zu7vPOLQFJckbC8SzSHNVbLZAcRIEp1eSPir
         WbAPRp8BtnDdZBeR27XkCQp/X4VKoVN0w6QDoiPLQO3Nx6Xwo0QV6MbUauVJtBYfaQWH
         ZZFg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+PzvGLH9rjYn6DQ9wedxzIef0zlwtCPSqmYmyA7H8vbdzoLp19XX3L8duM3cA3Q58OVTY4Bt7eUt2ubC+n+eBfC59PBjUfssYLrRZOe4
X-Gm-Message-State: AOJu0YwF3haay32cZDXFxIF4yn02T8w+Z4zAvSGZg/+vXf//Kh1zjCcy
	BsKIBlZSC0jzDNuV6FT21mqE6bT71xpMeoxqIWHfPNrNqT4UElaAflCm340UTLN5+svheyhEwUw
	PBTUwA6+XwGJWJvrzDHcZ+01XSF0x5D2nLe4wIuAykFplrc86n0QCi9b6q3fkUCZ2Kw==
X-Received: by 2002:a05:6808:2392:b0:3d5:4326:3601 with SMTP id 5614622812f47-3d54326392bmr4078221b6e.1.1719156400676;
        Sun, 23 Jun 2024 08:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwMz32C8X8OkYsczYb+AeCSDZLUo60k21JarMrjxnPjcSuR/TnvND69SCP53Zz/0qBqCliHQ==
X-Received: by 2002:a05:6808:2392:b0:3d5:4326:3601 with SMTP id 5614622812f47-3d54326392bmr4078192b6e.1.1719156400151;
        Sun, 23 Jun 2024 08:26:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b6b048sm32901281cf.38.2024.06.23.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 08:26:39 -0700 (PDT)
Date: Sun, 23 Jun 2024 11:26:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Audra Mitchell <audra@redhat.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, aarcange@redhat.com,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 1/3] Fix userfaultfd_api to return EINVAL as expected
Message-ID: <Zng-rfCPvSaGvL7p@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
 <20240621180330.6993d5fd0bda4da230e45f0d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621180330.6993d5fd0bda4da230e45f0d@linux-foundation.org>

On Fri, Jun 21, 2024 at 06:03:30PM -0700, Andrew Morton wrote:
> On Fri, 21 Jun 2024 14:12:22 -0400 Audra Mitchell <audra@redhat.com> wrote:
> 
> > Currently if we request a feature that is not set in the Kernel
> > config we fail silently and return all the available features. However,
> > the man page indicates we should return an EINVAL.
> > 
> > We need to fix this issue since we can end up with a Kernel warning
> > should a program request the feature UFFD_FEATURE_WP_UNPOPULATED on
> > a kernel with the config not set with this feature.
> > 
> >  [  200.812896] WARNING: CPU: 91 PID: 13634 at mm/memory.c:1660 zap_pte_range+0x43d/0x660
> >  [  200.820738] Modules linked in:
> >  [  200.869387] CPU: 91 PID: 13634 Comm: userfaultfd Kdump: loaded Not tainted 6.9.0-rc5+ #8
> >  [  200.877477] Hardware name: Dell Inc. PowerEdge R6525/0N7YGH, BIOS 2.7.3 03/30/2022
> >  [  200.885052] RIP: 0010:zap_pte_range+0x43d/0x660
> > 
> > Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
> 
> A userspace-triggerable WARN is bad.  I added cc:stable to this.

Andrew,

Note that this change may fix a WARN, but it may also start to break
userspace which might be worse if it happens, IMHO.  I forgot to mention
that here, but only mentioned that in v1, and from that POV not copying
stable seems the right thing.

https://lore.kernel.org/all/ZjuIEH8TW2tWcqXQ@x1n/

        In summary: I think we can stick with Fixes on e06f1e1dd499, but we
        don't copy stable.  The major reason we don't copy stable here is
        not only about complexity of such backport, but also that there can
        be apps trying to pass in unsupported bits (even if the kernel
        didn't support it) but keep using MISSING mode only, then we
        shouldn't fail them easily after a stable upgrade.  Just smells
        dangerous to backport.

I'm not sure what's the best solution for this.  A sweet spot might be that
we start to fix it in new kernels only but not stable ones.

Thanks,

-- 
Peter Xu


