Return-Path: <linux-kselftest+bounces-43978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBCAC06805
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CFF94E1E75
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E531814F;
	Fri, 24 Oct 2025 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gY6LMLXr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE34277CA4
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312553; cv=none; b=edW5mse0SVf7fLrB+a9+4UGxyPyIRhoGIp9PUIOO3bXXRd45RIhGz5Ju7fp+VPGgo1EuQl810aYSX4icmstPyxZKLW9s+ttDEmsRJAsUcMykZml5xyAhpL5Nvz7Y9ekOp7NPYS0rPFwoX6J5+yR1g1Sdz5F7kTP2PUrUXoWCL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312553; c=relaxed/simple;
	bh=UXdtgGSy67AXQ/JN+KMrNawdFYDZClThA2tajsuhr2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZhnF7NuCH9o3eV643W8o6i99Eq3ROZKPqgWYOSJ+x0dNj0ecbHE68A93fG4T3OOtjQBvsH1RjGvWOCzEPTnMAiAh9R/EfeB9eaVe8ZbptpMFobijRSshsAn9TYlL686yTOdcf/Xh7T7Hyw/BVoPo0JP6P6u+UmEwyFbnf0pJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gY6LMLXr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso3413782a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761312550; x=1761917350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXdtgGSy67AXQ/JN+KMrNawdFYDZClThA2tajsuhr2k=;
        b=gY6LMLXrOsCr+m7WtAFPEh5/RwCp/n17wwmCZYRhRT27lWblSL3/7X0IWFPFg/LSR/
         bjppGZqcYIyk95quSsRvzaXHQ1m7f+QFgcjsGm6HKqInxb4ybzd1gWi4MinBaXx7SMy6
         9P98QOi01KE4jbz21rgXF2XnE9tXzNuGSBR4B/g0YZp2fLopYt/bTMVyO7paWIfAVNUs
         WqbvgbFdjZ4xZvbLAVmW94LhJ/n++2MftlLP9xZNWmqmA0gAUYbCtf4hcgX30NPB+cES
         853xJoFeIiDKAUcY1Vt8T1AylGF07komcBqv7NSDdcqmukxSHfV+e8MgKAeLqEmxyzOw
         z3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312550; x=1761917350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXdtgGSy67AXQ/JN+KMrNawdFYDZClThA2tajsuhr2k=;
        b=cFrzWc/g2yaqnHbYfTTqN5hZYT87RWmsLsPX3boDdQVZ5W+/Tbush8ehmydT5RoIV7
         kbln+yTkTY1ptdAs9J53u4inj3SrA5POznLaWWjvh0HtF6bxbwU6EzMGL60kZSJ+kXcG
         rL2Q/5XlUJIxwfjOy888jR8OibwP3pYrVxX7U74IsN494tjEyNPX1NfVLDxEZZvLr5Jm
         U2+5DsxcZjk1ADi/UwgdIQnJz22utR62kooTFEO8g9F48gzZg9C3ocbKl28cmyZ2AGVr
         3tSPJCSI+XZT/itmgfSLY5Hv03WxWbqsrbKZXLKC6RTyHK6/eKUdl933k146YtKzJbLx
         dhMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAgfH4ISawuEaaiTgBjgVBr99l1JAwOI7+Z4RqFHrht9o2cqz+rb94uIHxq77SBtz7lMVrB64HY0J5Ah2C19Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YweLNa63hcF6COpL5fLxc7hjnL1APXTv0qqmtiJzeEoynXURWLM
	k3G7XoErpqEb0Zy9HBhZjBRNos/NBk/xV2ky8sMQ6CKyY9Bc3rf7KanBJaoXdc6Jd4NRn6a7THp
	i62PlZwPtyzWdrFjuQnOIcOmOyaaF7Aj+Yxqg7Tn5Sw==
X-Gm-Gg: ASbGnct9cEEHje3Qtxg8Q+Vo5vsoLqQIzh3Jtmdwj8rTY7yQfXMCCUTWiwCZ4wImZEE
	H9gD8dk+esCcvFOqyfGBqef1B6NoxlPVwoJKTkYNInN+MGrSV8EZoyFmIgYTGrl4GDi2/YTwVHW
	cIxMKxaTlfZursoSColqkpXaGQ81uRXGona11LhJnNuF1ksmTiWDMItmiBL47wWhan9POqTXvNF
	SLdEF9usnQGGURfQxV/V7Owb2LI7cmFgDnDtbMJ7Xr4+vNzs7mPHskzUw==
X-Google-Smtp-Source: AGHT+IF9MiMCR+Z3JtT4KSFyjBh3HzN8cHN6uyk2vE6IyQ6AKjCXbGpL+3ybW4eaSvJVFraK7LGXZ7DDpV/DAUCWP3Y=
X-Received: by 2002:a05:6402:177c:b0:63c:f79:91f6 with SMTP id
 4fb4d7f45d1cf-63e5e905089mr1789898a12.6.1761312550105; Fri, 24 Oct 2025
 06:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-6-pasha.tatashin@soleen.com> <mafs0a51jfar1.fsf@kernel.org>
 <aPnXVmD3cNmYNRF_@kernel.org>
In-Reply-To: <aPnXVmD3cNmYNRF_@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 09:28:33 -0400
X-Gm-Features: AWmQ_blGhDYvfV9psBHWFmiE2E4dNn6kiGgtaPdxw9qpGoO8Tm-jcSBJExmJsMY
Message-ID: <CA+CK2bAvKrfuOXTa-RWtcuSR8rkPMhurwCn41NcUm44_vT63rA@mail.gmail.com>
Subject: Re: [PATCHv7 5/7] kho: don't unpreserve memory during abort
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:21=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, Oct 22, 2025 at 01:15:30PM +0200, Pratyush Yadav wrote:
> > On Tue, Oct 21 2025, Pasha Tatashin wrote:
> >
> > > KHO allows clients to preserve memory regions at any point before the
> > > KHO state is finalized. The finalization process itself involves KHO
> > > performing its own actions, such as serializing the overall
> > > preserved memory map.
> > >
> > > If this finalization process is aborted, the current implementation
> > > destroys KHO's internal memory tracking structures
> > > (`kho_out.ser.track.orders`). This behavior effectively unpreserves
> > > all memory from KHO's perspective, regardless of whether those
> > > preservations were made by clients before the finalization attempt
> > > or by KHO itself during finalization.
> > >
> > > This premature unpreservation is incorrect. An abort of the
> > > finalization process should only undo actions taken by KHO as part of
> > > that specific finalization attempt. Individual memory regions
> > > preserved by clients prior to finalization should remain preserved,
> > > as their lifecycle is managed by the clients themselves. These
> > > clients might still need to call kho_unpreserve_folio() or
> > > kho_unpreserve_phys() based on their own logic, even after a KHO
> > > finalization attempt is aborted.
> >
> > I think you also need to update test_kho and reserve_mem to do this
> > since right now they assume all memory gets unpreserved on failure.
>
> I agree.

Hm, this makes no sense to me. So, KHO tried to finalize (i.e.,
convert xarray to sparse bitmap) and failed (e.g. due to OOM) or
aborted, so we aborted the finalization. But the preserved memory
stays preserved, and if user/caller retries finalization and it
succeeds, the preserved memory will still be passed to the next
kernel. Why would reserve_mem and test_kho depend on whether KHO
finalization succeeded or was canceled? It is possible that user
cancel only to add something else to preservation.

Pasha

