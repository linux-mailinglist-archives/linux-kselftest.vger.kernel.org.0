Return-Path: <linux-kselftest+bounces-16721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531096505C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 21:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2236228228A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51A21B9B38;
	Thu, 29 Aug 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bk+JaODB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E6D1B81DF
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961263; cv=none; b=ltxAslQSHSKmq7k5LiQBIO9dDsUYQgG2EWpK814Xgp457Eg+MHs9yVCUTvebXHtAAh3FYqBsBOY2o+3JTH8D1ImMnRT0I9vzdef+W5+YMiX8eVEyO0wJYK7CCMhPnfWIBA0KlZ7x7Hh8FGk79PbLji/gtU4zBL7hMnerBQEGUGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961263; c=relaxed/simple;
	bh=guVxu9HxEDSLtaNB6zapABbY8BPidXJ8qvB9HSCs1b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aD7jjjp3r4J3X3VdutU9zJeARIwuJKffMMzv5fcxjgBA3NviaKX6Pq+1zDoInNLCITbi6GowIoQddZkLa2IHeCqzckFee+Ea+9lDgYTKKK1G+/CsGituM91JaBzA+sBJqmzgwuHKsoE1r8CA/V4cqy8aVUQvhtgGfoMkVRrZJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bk+JaODB; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-268e0b13471so73807fac.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724961261; x=1725566061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guVxu9HxEDSLtaNB6zapABbY8BPidXJ8qvB9HSCs1b4=;
        b=Bk+JaODB/0OHRkcroTeTsHNL5sOjGHKhXIqPuyHkj0m8ORBiRd03qZyTS/HiGI0e4x
         H9Olr/h5SLMWEimLzz8M48h20/QKV4GTA1NkAd0zG4fbLC9fI3nF9UlwzXKttubxzsVQ
         0I86QweIed+z6C8Yx30z7rr8aYzjre7SOtLSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724961261; x=1725566061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guVxu9HxEDSLtaNB6zapABbY8BPidXJ8qvB9HSCs1b4=;
        b=bp1tVIZsccZUr+SeuO9kJ3VcCg8rvzMVNO1Qp+bqp5n64vNkhkFVIxlzslkW+XEZYn
         0dbDZBXayzVhIPqJR1LH5uoueZPjo5bf1ZkRbaj189qPPlpSJnA3e+QUx57eEqUMRnmY
         WwsgbQg5fpLEdWk6lynKe+RAjlJAl8lcGW8gOCt1MrlSiYFyoxNRCtTfPC4j5ebLAPkS
         GPs3hjjeWxjGHMb6J+tJlC/SzCTIGr2MHp4Zk2V3foVEDIwr1DYO7go4/8pB2i2MVerc
         a6En5oMoTPfULlrsfghuhKE/CfJs32pXsD7BTIR0dZI+YKN1U44619gnmlvXIBdOu5iO
         nTlA==
X-Forwarded-Encrypted: i=1; AJvYcCVRnycNRUjoSPGb6fwzsTl05xXW9o8pdWwsqqpxtpwnb5prFp3sgAXOF8NRVCnRCcv8oadrXOGN/tLibU+51K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYg7H/l6DCL6Ovfm+odoEfcO4lKCzf24G0OkNiBpxex2uBiRR
	w6o+blprX+Ki96paCCJL3JDFmX7fq4zDvluoq3RTURIWz3JW11QZUTOX+4ih+Ag2glKJdHaYC+a
	1DIu31FrayChcO0kw+9mf324S0qIMl4ejkSTM
X-Google-Smtp-Source: AGHT+IHRaSJMxiiEHHnyyPMW+E6Zchvcl2ZBtiZzi3ND4sx5NZsr8zR9UFo54QC6zM0irr40VOAnC+AYh5/ejQvMlDw=
X-Received: by 2002:a05:6870:fb89:b0:260:ccfd:1eff with SMTP id
 586e51a60fabf-2779031ccd4mr2354479fac.7.1724961261302; Thu, 29 Aug 2024
 12:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <20240828225522.684774-2-jeffxu@chromium.org>
 <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com>
 <097a3458-0126-48e3-ba0d-d7dc7b9069d2@lucifer.local> <CABi2SkVe6Y4xypBw0n8QbqKJgsfy9YRNJWvBZ3bjTa=-Z5Zn2g@mail.gmail.com>
 <5a312d38-4591-47b1-9a6c-4a7242dbe20d@lucifer.local>
In-Reply-To: <5a312d38-4591-47b1-9a6c-4a7242dbe20d@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 12:54:09 -0700
Message-ID: <CABi2SkXDVgiUeC1StbfggvtiYG_kDxQJsZPpDw-NDPNv6-dwmg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, 
	rientjes@google.com, keescook@chromium.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Thu, Aug 29, 2024 at 8:44=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:

> > >
> > > Also, this is a really unusual way to send a series - why is this a 2=
/2 in
> > > reply to the 1/2 and no cover letter? Why is this change totally unre=
lated
> > > to the other patch?
> > >
1/2 has a fix that 2/2 is depending on. That is the reason they are togethe=
r.

> > > Can you send this as a separate patch, preferably as an RFC so we can
> > > ensure that we all agree on how mseal() should behave?
> > >
It is not an RFC because it doesn't change any semanic to mseal. The
updated test will pass on linux main as well as 6.10. The increased
coverage will help to prevent future regression, i.e. during
refactoring.

I will add a cover letter, split the tests and add more comments to
help the review.

Thanks
-Jeff

