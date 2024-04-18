Return-Path: <linux-kselftest+bounces-8342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE658A9E37
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093231F2115C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9551616C691;
	Thu, 18 Apr 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUCv9OEb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F016C6B2
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453699; cv=none; b=eZOXY9t+dcDiZUtK0EmGifnq5c1X6ox+xV9/O5FUAMWYdWlmzNZBaMsW6QViIcyX0AiYwT67889R1MrNl6BRR2tOyD9MNjo3azL/iDrq+m8fMi4fIP29nHznWUltBstFWaqKFr75ro8yvVFBJxUCK9ZmTlan1fUmhkg6naPywbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453699; c=relaxed/simple;
	bh=CQohQLqvPc/tHvgWJq7mh9PQ9WJ3XLzzwtQN4cmxGqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQbbb+Y7jrcTQ+nTWIvfhkjciLJ25AVN9YZgj7IIRwTsRDgXjjH7Vfb3SG90Ognd/dfKOwJxkECg8mtLZP3uaZf5M/Msnj2d1sGobm5OZo6BrZOkUfBtj9AW3qWYP1OayKhwFGGy+R/8ip0+epJ1CqLbQr3drcUEo6rUqu788lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUCv9OEb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713453696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQohQLqvPc/tHvgWJq7mh9PQ9WJ3XLzzwtQN4cmxGqc=;
	b=TUCv9OEbc/VwiFRchQLCoHUsxqu1pjymec/cKtmFJC1LSm9VtDI5Fz5ZbbJAPIgrWbOJe7
	VdXFYGrfXDut4UY84b0u5EwiOdlCXjyyw56ffkoEc1mLmTpq0EFU/lYGb/OOZNr7AfrTYi
	xsOKT3CxOAbgiK1mAXgJGGbtvJThanI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-K0nNN4fwN9izwLJQK5ztYw-1; Thu, 18 Apr 2024 11:21:34 -0400
X-MC-Unique: K0nNN4fwN9izwLJQK5ztYw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-437acd0cb2bso5300401cf.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 08:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713453694; x=1714058494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQohQLqvPc/tHvgWJq7mh9PQ9WJ3XLzzwtQN4cmxGqc=;
        b=UT9TFl6bRfbZyzrsR/wIdnMjXPXQf5HE93Dg5uml52LjG1A0XugQHjuMw765euEIcy
         x4Nz6ANhrmjZeEj4VQWznLsBVoiKkwh6NkRUsp5aY/cTghKGxZj3jqfCEHMT0vUZvXX7
         EWvGmbjz3v3j01AxuSRnrdQ+1qyHVhFK61CdsqTxij1XfHRrBO6vOg8gNs5Bb/Q2bkYh
         vO9VxP/jKwpboOGUSOMA+vAWOhzEpEsFOVaIMuFfOi/8c+aamhR9ho7yyMnZtF1c+5I1
         L/OFZxPKUUycoJE228QZoHtsQ7AxUZs4io7HjDTeXHu694ZYUfPJ5eFcMauVTVtUtQj0
         sDiw==
X-Forwarded-Encrypted: i=1; AJvYcCX5EXZddhZQ1d1ujNPbtZzjdsmmph1ujnrdhAOgRMStUeCiLNGVRRzpXydSUToO9o5NsUFYJC1YghJd0UPgtqjoVfc5g02Hg4Iwd9j1RHcL
X-Gm-Message-State: AOJu0YxspdNP47uOMjI0R8dJ4S/6iIwqRzcge0tDBXtI66orxMVISTDf
	moUhsd/U/PtoxS/DmFCMiN86DADZXf/ecoc43bAkmVfvIi6528/e347gFWTJbm7UllFCqOYvb1U
	MPDGchJI1RHLBqa8rARjwv1YEgo+i0d6X7er8nrLNKDTzP55qVn1wwTtKZ39+g6/pj1olaKtPKP
	xst+nJL1HXnH+qoFBq1sBuPuAPPsiadvlIwYbguLK8
X-Received: by 2002:a05:622a:164e:b0:434:68ad:bc6d with SMTP id y14-20020a05622a164e00b0043468adbc6dmr3752450qtj.52.1713453694197;
        Thu, 18 Apr 2024 08:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYZwCA+06wOvVVCIasxw9xTrMHDeFH+2lLqLF9z2iIkb9Ub+iZ6WZb5a1fMomaWqQomkeAzQiYpEptyX8KM74=
X-Received: by 2002:a05:622a:164e:b0:434:68ad:bc6d with SMTP id
 y14-20020a05622a164e00b0043468adbc6dmr3752430qtj.52.1713453693884; Thu, 18
 Apr 2024 08:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418131754.58217-2-wander@redhat.com> <b96697ff-3177-4559-a410-104ca3a1110f@web.de>
In-Reply-To: <b96697ff-3177-4559-a410-104ca3a1110f@web.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Thu, 18 Apr 2024 12:21:22 -0300
Message-ID: <CAAq0SU=HJ8nysYWBj6_FGbRv5QyetdV0xJJKpn2oy6Hub7-6QQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: unregister the device on error
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:06=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> > kunit_init_device() should unregister the device on bus register error.
>


> * Would another imperative wording be desirable also for this change desc=
ription?

It makes sense, I will change the comment description.

>
> * Will the tag =E2=80=9CFixes=E2=80=9D become relevant here?

I often forget this tag. I will add it.

>
> Regards,
> Markus
>


