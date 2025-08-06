Return-Path: <linux-kselftest+bounces-38393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93DB1C9EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 18:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD30017ADB8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE82951B3;
	Wed,  6 Aug 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7u4orDW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A4274B41
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Aug 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498818; cv=none; b=MDVoEm9HQ98TEQHI/qhTpgx5f5TDtC8B7oADyqxO0csmATnHGtxIrVEwu8LQo/RLRaiXsK8v1gxJUf/KFZxCP113fVYFtUPCvyZSiIkHfbBBMUgMfd8vZNRS+JClmIEzb2UvALymGiYlkqDf01iHC/2EIHoang61BnZW0vN6pzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498818; c=relaxed/simple;
	bh=Fxy1GsxFgTmyC+DciW6Y5utDV003qXLrD39oL6xyDK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU63ZTX8DdP8uUpGLhS+puxL9d3an+Fhu4R9tR5OyrKR4u2GYk2+uN4rDijqwZlDXslQc1CZDUcKA5+TrDee2AlqUeC2zMgc4TtdwL5DgH3fZbYLHFhnwwUoIn7ngHRJJK7MTA8x0bA+OBr/4yd/42dBHsfSFuef/sqXMT9cEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7u4orDW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754498816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nd9MFnTlr7WVrR7s+mCfQ91mGkWMSL7YSOVN2ZEGg4=;
	b=N7u4orDWM4HIkOShClDFQKkWIk4j/RmRI5JPZDDShyvGzmxAXo47PHF/0viF90Bu5fXzMf
	haMR5WdukODZNPvnDWcpls7KZ/sROg0N71mzYQbO/5hToTvzgK32QVDFFu90SNTT/v+KDE
	hAH5pHyNmneOAYj0eOvbvz8VobNYRVU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-bFVvn4B7Pbyhk2epxRm3ag-1; Wed, 06 Aug 2025 12:46:53 -0400
X-MC-Unique: bFVvn4B7Pbyhk2epxRm3ag-1
X-Mimecast-MFC-AGG-ID: bFVvn4B7Pbyhk2epxRm3ag_1754498813
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e8fd5947f36so94504276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Aug 2025 09:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754498813; x=1755103613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Nd9MFnTlr7WVrR7s+mCfQ91mGkWMSL7YSOVN2ZEGg4=;
        b=qF2UHN+fxpEolfgARkEt4UJMyfSTLBzKWrQvxEdYQZ8LRP1C5X5ujURNd6qsFptd3q
         wW7cdW5Z2eHuAWwVOJFURakMSQ5q/e5n3HDpdx35g+zbrvQgoF2Wh7rZzbXgiyLQOiJC
         WqaAAVu3gjE/DaWRHdKDOoPvjfDpNrwpCBCF2sdYprLFZxIgTXL4YVETKlBB1dKlHDIB
         gCv5RX+UTG7p1uWnKQYmzt5KqTBc3cxofGZrG1n1n8WuihFyNA4DrNWh10aZXbXySFOG
         xTMjYgusMimFv5wJdw5oeUpYee5gQTAnMwCv/1FPZoE2YNmXHwQkqzNInZ3nnWdZh3SS
         YgcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk0NLL6099LRzRAezwknh3Yv+5XI8jCTqLZkeN/n+jAx7HRF3HlUD/zm+EM3BEDj7FTAZbYPmWHBiPLkNXrEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0R8GD7pNJjZkW8zqB9HVC+mW2xaRy5eC6sxMS5908L50A8HL5
	+mhhuca92JR+sQebfxA+qKmh5h5YvXTZfP96bZk5Sv6F5dbjntoukGZm3DhtMwjt/FDbXqjtzry
	2kpjzZHmpsUYAQCVWURoPX5cmGPb6kil6+LhNu0PesaLlVj0wolYOhNgeODP8stCI6yxUIQ==
X-Gm-Gg: ASbGncubda/koo7310raNF2UAoHfDOhM8JGHYEaibuAyGj1Pu7XYl+SFW62NvfdPwky
	VhLQaEApzLPV7OoEpMrzKPHNYgigTKv2zrPldpgFACnfhhDY8fztj+qjFUbPuT7nt8iqFisAGfJ
	b1M2fCxVNU63TkSX3xRuyWkIE5QcW5fNodMc66npyc3HFOFz61bivdBCGv7Nfw3BLBR/wu9OJxd
	jpGg2qrVc8FcKYJkqxFd+evfk4osW8oX9TETN9kdmBY3lz2O+ZEmxLMDce703aXFLLooMKLoC+C
	XHtsF0o3RMSbpv2QsHxIeflVsjdecpMR+ptwqFWCZCPZAKqCDkFF6xraVr22c3s/QT0iVH5tEeY
	E8l+m5R1dnu7nW/9SNY1pIA==
X-Received: by 2002:a05:6902:1442:b0:e8e:2535:5ce with SMTP id 3f1490d57ef6-e902b825c10mr3495169276.34.1754498813148;
        Wed, 06 Aug 2025 09:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE53Eqc4ZZr2AAoa1BkY+1WkbLTnrnGZkrw+oh/AutRhwg1BqQQfEJzXdO3LO6YcxGkkHaG8Q==
X-Received: by 2002:a05:6902:1442:b0:e8e:2535:5ce with SMTP id 3f1490d57ef6-e902b825c10mr3495120276.34.1754498812599;
        Wed, 06 Aug 2025 09:46:52 -0700 (PDT)
Received: from x1.local (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3714cb1sm5654298276.2.2025.08.06.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:46:51 -0700 (PDT)
Date: Wed, 6 Aug 2025 12:46:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/mm: use __auto_type in swap() macro
Message-ID: <aJOG-IAmYhjoYVf-@x1.local>
References: <20250730142301.6754-1-pranav.tyagi03@gmail.com>
 <CAH4c4jJ8VywRUfn2z8HnA73vNxviZ53DZttcR3JaPULF3JFkQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH4c4jJ8VywRUfn2z8HnA73vNxviZ53DZttcR3JaPULF3JFkQA@mail.gmail.com>

On Wed, Aug 06, 2025 at 09:15:50PM +0530, Pranav Tyagi wrote:
> On Wed, Jul 30, 2025 at 7:53 PM Pranav Tyagi <pranav.tyagi03@gmail.com> wrote:
> >
> > Replace typeof() with __auto_type in the swap() macro in uffd-stress.c.
> > __auto_type was introduced in GCC 4.9 and reduces the compile time for
> > all compilers. No functional changes intended.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > ---
> >  tools/testing/selftests/mm/uffd-stress.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> > index 40af7f67c407..c0f64df5085c 100644
> > --- a/tools/testing/selftests/mm/uffd-stress.c
> > +++ b/tools/testing/selftests/mm/uffd-stress.c
> > @@ -51,7 +51,7 @@ static char *zeropage;
> >  pthread_attr_t attr;
> >
> >  #define swap(a, b) \
> > -       do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> > +       do { __auto_type __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> >
> >  const char *examples =
> >         "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
> > --
> > 2.49.0
> >
> 
> Hi,
> 
> Just a gentle follow-up on this cleanup patch. From what I could find,
> this is the only use of
> typeof() left in the mm selftests, so this should be the only instance
> needing this change.
> 
> Thanks for considering!

Hi,

Andrew should have queued this one in branch akpm/mm-nonmm-unstable (even
though I'm not familiar with the branch).

Said that, I'm also not familiar with __auto_type.  Looks like it's more
efficiently processed by the compiler in some special use cases, however
it's also new so maybe some tools (sparse?) may not recognize it.

Is it the plan that the whole Linux kernel is moving towards __auto_type?
I still see quite a few of typeof() usages (not "a few", but 2966 instances).

Thanks,

-- 
Peter Xu


