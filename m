Return-Path: <linux-kselftest+bounces-20063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D599A2F05
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79F1282E98
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763E2227B91;
	Thu, 17 Oct 2024 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSHV7O4U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86AA1DE8A1;
	Thu, 17 Oct 2024 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198172; cv=none; b=R8Df4usM71ULnAog0vsAZSn8JaGEHfrhj3pnWhjap7R/2ueafPnMuqjKJetXySA2QToScKUfikJKPy2pQcxpLfI7FMBAgp8nqlzYebJWQBwdMoe9CrTrZxtzLtkO6z/QpwC17srCge+PSZU7aS4T1uCBZGzRgVJ29YwSuAQCEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198172; c=relaxed/simple;
	bh=Ayv1AmTMNgi7cfLIJoCCcfIDqQcdT7vKOvz8kp3d2Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ubiz8YzqPyMh9SHYedQ7mgs1ts+rRi32HxJdKqIa6ETOhwDjK9JgxfUb3cAsQX7+q4v4fK/Xr33GBZXLA5fE/N5EyXH9oLIU1rnsb356UzMwROCwq4L5KQp8PspNMZ4regzhF4Yuy/WyA/f17hH37SnayclzsGCZQBoVzMlOVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSHV7O4U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so12357655e9.3;
        Thu, 17 Oct 2024 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729198169; x=1729802969; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Q8gmzOdl//bRG3iPJ2MKUkse51Vm7Xefy/9rAvHyEk=;
        b=MSHV7O4Ufi2dqwYGwjfyj4gBamRIiDdZFO2B0KSc+iuXHcUvTtwSCDHaZaDcKbQOHI
         D9nDyIKBEg38NUqEeVzTeSN4OdaErgTOWhUu+q28RyAbRhQiaYgU0KChko8hY6UMwyp5
         ZCw9z+zo2NeYFqoljSX4UHwpghsCW++xxgP8RjLvtLC4Or10k1nsanyTxKBtQJZ+s8qz
         8XGewD68azWHna2deZbSSahB0RvFiJGEC1AGZjK6C5V5peK+zwCO3h//9fs7e7Bq8yic
         65XZW4WqYlr6hRkW4LoJQqNjai8B2AS3il/uJxvFQaFI7Ednd1vXAyPRRWJOuT/gdn/4
         Cd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729198169; x=1729802969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q8gmzOdl//bRG3iPJ2MKUkse51Vm7Xefy/9rAvHyEk=;
        b=Mo55fJkwnemjPp5VfP5TIOwcK4wHyqkY6kTp/sxAfTEoESTF5vLh2r9alGiOzPOQfK
         2Odc4WlFnZnn8nw3PWN+5T9HgiU5whCTL6to+olgQ+aKgl+yEp5x19MXJ3GBwKyOOBK9
         xQbx7tAK1M99XFZdHqEVXeuf0/tPyCX+zU26CyXQb2MnGJu4v/JmocLl+7w8W0jyyrI0
         +ULkADALOZPNyptcYkTzpbAYmYRF6o5XW8DkSn5VrYWJlHg3NhCOsrT689cp6h7Hg920
         B/Lu69ge5X3l5fu6cU81jISbSPfrvp+UpUcLKvJ9t7YO0jLc7kq6LVCA5BcYtGcuFVCn
         RmvA==
X-Forwarded-Encrypted: i=1; AJvYcCV/RQodExlR+FIy+jxwXy0fbU2B0A5miLwRjr92nZF//HA85JXOkLdaTaVlsINEyy6KbrCqwnBjl2tE2ZPsI90=@vger.kernel.org, AJvYcCWI5LAj5uBIXhU7i/jrNGbjR8iq6s572IL93QckSWE2JCY1hp7gFr1PyHnt9wPP//2r7MJjmvSe@vger.kernel.org, AJvYcCWZ8NWP8qGBFOmqr2yifqh/eBIvKiaL8p0z2Wr4d2jaJKlh3Zhk75n9/hycvNtyS5+rROsQNkVaADcei5ApLUa/@vger.kernel.org, AJvYcCXmSVM4MsmbxyFEU/aM/y5y5OlkQ19q2neE5Mx1NqStDzhZFAm9arg5Q57NDDO8rhURv50I9xtxivVS32fX@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtSDQxZXP2dNKoXMdQ0bEmT1LQa/yynFPxiGt+YWj+KkcmxJd
	42NY7zI5/MwlSX5iLGWgJWrikq2v+L589u1MisLLrEYa5JbzoFrf
X-Google-Smtp-Source: AGHT+IFBYwy2F++3ncPm55qG+21ejA1wmCaAToncm0YEYTbr1Tq6m/UqhyTCk5HXpSwCEXGHzwhGHg==
X-Received: by 2002:a05:600c:4ed2:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-4316163b8bbmr109125e9.8.1729198168453;
        Thu, 17 Oct 2024 13:49:28 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:a118:25f3:b27f:9f34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160dc9396sm3426395e9.13.2024.10.17.13.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:49:28 -0700 (PDT)
Date: Thu, 17 Oct 2024 21:49:24 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, sroettger@google.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, gregkh@linuxfoundation.org, 
	deraadt@openbsd.org, surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when
 sealed
Message-ID: <r5ljdglhtbapgqddtr6gxz5lszvq2yek2rd6bnllxk5i6difzv@imuu3pxh5fcc>
References: <20241017005105.3047458-1-jeffxu@chromium.org>
 <20241017005105.3047458-2-jeffxu@chromium.org>
 <5svaztlptf4gs4sp6zyzycwjm2fnpd2xw3oirsls67sq7gq7wv@pwcktbixrzdo>
 <CABi2SkXwOkoFcUUx=aALWVqurKhns+JKZqm2EyRTbHtROK8SKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXwOkoFcUUx=aALWVqurKhns+JKZqm2EyRTbHtROK8SKg@mail.gmail.com>

On Thu, Oct 17, 2024 at 01:34:53PM -0700, Jeff Xu wrote:
> Hi Pedro
> 
> On Thu, Oct 17, 2024 at 12:37 PM Pedro Falcato <pedro.falcato@gmail.com> wrote:
> >
> > > For PROT_NONE mappings, the previous blocking of
> > > madvise(MADV_DONTNEED) is unnecessary. As PROT_NONE already prohibits
> > > memory access, madvise(MADV_DONTNEED) should be allowed to proceed in
> > > order to free the page.
> >
> > I don't get it. Is there an actual use case for this?
> >
> Sealing should not over-blocking API that it can allow to pass without
> security concern, this is a case in that principle.

Well, making the interface simple is also important. OpenBSD's mimmutable()
doesn't do any of this and it Just Works(tm)...

> 
> There is a user case for this as well: to seal NX stack on android,
> Android uses PROT_NONE/madvise to set up a guide page to prevent stack
> run over boundary. So we need to let madvise to pass.

And you need to MADV_DONTNEED this guard page?

> 
> > > For file-backed, private, read-only memory mappings, we previously did
> > > not block the madvise(MADV_DONTNEED). This was based on
> > > the assumption that the memory's content, being file-backed, could be
> > > retrieved from the file if accessed again. However, this assumption
> > > failed to consider scenarios where a mapping is initially created as
> > > read-write, modified, and subsequently changed to read-only. The newly
> > > introduced VM_WASWRITE flag addresses this oversight.
> >
> > We *do not* need this. It's sufficient to just block discard operations on read-only
> > private mappings.
> I think you meant blocking madvise(MADV_DONTNEED) on all read-only
> private file-backed mappings.
> 
> I considered that option, but there is a use case for madvise on those
> mappings that never get modified.
> 
> Apps can use that to free up RAM. e.g. Considering read-only .text
> section, which never gets modified, madvise( MADV_DONTNEED) can free
> up RAM when memory is in-stress, memory will be reclaimed from a
> backed-file on next read access. Therefore we can't just block all
> read-only private file-backed mapping, only those that really need to,
> such as mapping changed from rw=>r (what you described)

Does anyone actually do this? If so, why? WHYYYY?

The kernel's page reclaim logic should be perfectly cromulent. Please don't do this.
MADV_DONTNEED will also not free any pages if those are shared (rather they'll just be unmapped).

If we really need to do this, I'd maybe suggest walking through page tables, looking for
anon ptes or swap ptes (maybe inside the actual zap code?). But I would really prefer if we
didn't need to do this.

-- 
Pedro

