Return-Path: <linux-kselftest+bounces-12703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C2B916D68
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8AA28EE8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA3B16F910;
	Tue, 25 Jun 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWjJ8xT/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735316F29C
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330543; cv=none; b=Up79Bot06wtw0q6SuBDYuUvbzIRS7hL3ntpAJh0/8aApqyhdl+oewWVaOBQX7D546tVDDVQG3dyCnSuXq+gL2/0gQe9LNOYhcPRotLH6JSdh4L0Wn7Et1YR553rsPfe73AOb4zkpd2y4x5LWqHbaTQ+tlxvwpFNYUAN/O8WgX+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330543; c=relaxed/simple;
	bh=IQXgv+CoqziIu1jPjhD/1Hlxn6w+ndusTZW11A0npas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzOceQSX2wP0mfCPSTM6jzcTATYqzhpFfrzxN9Bey2WQvslNLZ5yqsblxJjLdQ/T1pzKGZimJ4Au4aDnlBKSlcwpnUgzrEpObWv6+Ex23+GDX6qUa6NdHYdyJBSybGEpqjMl0CBocEsLDjqZkRgAhQydxKdR/SnsHSVmOJQ87m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWjJ8xT/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52d259dbe3cso260397e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719330539; x=1719935339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxb67F0epg0WUcpjIVopItAKW3yTsqHV0EkWYkb6TKU=;
        b=fWjJ8xT/ZgCPmsx5P4hQW2ZWy7c3QxNhc8L8mG9aAu9t31mtKxoZsmpbgZpdxspK3e
         KDDnmWfJl1wH4Uzrng+XAsJOXjFzu9coweGMElBQtIRMcWCOeyBqbNXsEuM+9SszqEj1
         7tOMXPmw7Upvf5G7F5wuTtUSymXMoiJ4ie18yHGmyxTxNcs2yJTeEkuBqUu9O3xv3qbh
         /e28L20CR7q2gFr6MntoUuwwtCjw4KaS6crjHU2yBLsI1XetQOCrYKalzvx7spiyt+5+
         ZEGKBE7JRbAQxpH1zBCQFeIo+Ww8fPMT6U6LZ1uoayzoN+8xbsrLy87W54JBnm63ny82
         6xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719330539; x=1719935339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxb67F0epg0WUcpjIVopItAKW3yTsqHV0EkWYkb6TKU=;
        b=K3ewphtpvgilhkk/nukxZpXicwvncMcPUh2id5n5xtgcsJOOjpWkyPIfL2FA7g8CJP
         1fbR8EQcYHmwkRtyIDjAwCyGXWFEsIZkACwI3PRYqg7PFHX3QamXnUaziUe+sMNg1RoJ
         9aEGzsnxejFMXGMnEmvPPD06o9B7C3v78cbwpef7X3VajePRnQLUOtmrBoMx6gGCPtFg
         +MLPI66e4yFDxdH6qI/cw7CCVuS9I3ubg+m1VIax5SljbRlZK9gHmvuJl/Ixs7TzkfZN
         9A5AyEM4iSaSBApCRjaZHHSg+ydgeq4iVBDNrI+6601nbkvGwgWyWfIALpTaiQsLVI/U
         esHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+U8yt93p8uHppa3wmnBYpve28SW/XnX7RBrKnyne2vpRfZvZsODuBzuGwbCVls1ElQFctbKPdfkSSsBeBAKKgy2WFviKzNNBbmk7rxFQG
X-Gm-Message-State: AOJu0Yy89lJoQEEczhOJQqWHBU3uKqcQxwEYXgh1k8rfjhpqx8WObcmj
	pmUVp+ayZuJ0V7G49w6iHYAiMtfDk9Ds/Le4YC1CPaHxqg9NXhi/aH/Utf0BrZP7YOnU0sutn8f
	qBofdeIdgOGI50at5JWCkG+2IjvEi/nrDEUF8
X-Google-Smtp-Source: AGHT+IHcWe8Q/heq47iYVyRVbt/goSPcjLABzSqKs/piB9Ciz9feIfIDC39cZFwoe7e1yt7HahE0jpTztGd58ymd0zw=
X-Received: by 2002:a05:6512:348c:b0:52c:86d7:fa62 with SMTP id
 2adb3069b0e04-52ce061b1femr6166980e87.23.1719330539167; Tue, 25 Jun 2024
 08:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624163348.1751454-1-jiaqiyan@google.com> <20240624163348.1751454-2-jiaqiyan@google.com>
 <b669e378-45cb-981e-ba58-1e3c4943577d@huawei.com>
In-Reply-To: <b669e378-45cb-981e-ba58-1e3c4943577d@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 25 Jun 2024 08:48:46 -0700
Message-ID: <CACw3F53H96xws-ZHacWFbDt=YjaKiGYKRMwLJkUe+pUPGy_M=A@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm/memory-failure: refactor log format in soft
 offline code
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, nao.horiguchi@gmail.com, jane.chu@oracle.com, 
	ioworker0@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:41=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> =
wrote:
>
> On 2024/6/25 0:33, Jiaqi Yan wrote:
> > Logs from soft_offline_page and soft_offline_in_use_page have
> > different formats than majority of the memory failure code:
> >
> >   "Memory failure: 0x${pfn}: ${lower_case_message}"
> >
> > Convert them to the following format:
> >
> >   "Soft offline: 0x${pfn}: ${lower_case_message}"
> >
> > No functional change in this commit.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  mm/memory-failure.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index d3c830e817e3..2a097af7da0e 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -2631,6 +2631,9 @@ int unpoison_memory(unsigned long pfn)
> >  }
> >  EXPORT_SYMBOL(unpoison_memory);
> >
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) "Soft offline: " fmt
> > +
> >  static bool mf_isolate_folio(struct folio *folio, struct list_head *pa=
gelist)
> >  {
> >       bool isolated =3D false;
> > @@ -2686,7 +2689,7 @@ static int soft_offline_in_use_page(struct page *=
page)
> >
> >       if (!huge && folio_test_large(folio)) {
> >               if (try_to_split_thp_page(page)) {
> > -                     pr_info("soft offline: %#lx: thp split failed\n",=
 pfn);
> > +                     pr_info("%#lx: thp split failed\n", pfn);
> >                       return -EBUSY;
> >               }
> >               folio =3D page_folio(page);
> > @@ -2698,7 +2701,7 @@ static int soft_offline_in_use_page(struct page *=
page)
> >       if (PageHWPoison(page)) {
> >               folio_unlock(folio);
> >               folio_put(folio);
> > -             pr_info("soft offline: %#lx page already poisoned\n", pfn=
);
> > +             pr_info("%#lx page already poisoned\n", pfn);
>
> Again, it's better to be "%#lx: page" to make log format consistent.

Ah, I missed a ":", thanks for catching this!

> Thanks.
> .

