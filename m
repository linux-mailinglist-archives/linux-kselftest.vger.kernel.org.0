Return-Path: <linux-kselftest+bounces-16693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2132D964A0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 17:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC31F2872D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBE11B29B0;
	Thu, 29 Aug 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gxth0b/4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABE1A255C
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945428; cv=none; b=AfW/lPHPJ2nfjEvuIOkGyYIfXKMX9inheS9apiVmgRdEq60R6sV5xj7xhvS4Eh1VWsOs1IdNxzs/EUZamrHd4eXLEoiv5/eDiJaQlDreqYpCtPvkLY7p+d88LzWuVLpjzFRG1qonUS76YIEFXYiIoCs3ZSTrmZMxf+XaLVEUSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945428; c=relaxed/simple;
	bh=ah5xq0XzWgR3wqwzNeXrdDAaDaOFMa4cDEh8tekvkco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMWd5E+NAQNKm3Yqv3sJuxhBgbqXLIalXq4OdUjI/iVBTGdPxgLxbmGYgVxG7zZisTS71x6auJYMPNvK93TLeHn8ncUXmnLvqzXFlyPwhQjqSdeKiY2pmSmFnTwINdNDRO65hYcdSgw8TRfocC+9flxYQZkzLpzUcCBTRMx/alQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gxth0b/4; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3df036d7132so71765b6e.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724945424; x=1725550224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfirTw1c0aIcYb4weoxcT30+5e5JZv0jxRwuMnAz9/A=;
        b=Gxth0b/4021iOeaKj1n0nQpVgr+Sgm7FXvOCMe9NhsRM8dRvlrl7IRiUnZkSOPzMfc
         lkaPudCPNmv9MaJOWtJbBx/zPtt+iWQI7nhbJbl8SswguqA1pMQpbedzFJBcqsMl9FhP
         qC7Al9NZe5IHiDUAtqLM4hjuTrXCn63aqPan4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945424; x=1725550224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfirTw1c0aIcYb4weoxcT30+5e5JZv0jxRwuMnAz9/A=;
        b=d55vXOgZeezrv7GZgqtdXdayW6HWxjCIJxKQlptf+FxmkTkbfmset6+7hrmjL42rQQ
         65OBuLEYm8sLbcxFsfkPHbkAhblVU83BXsrNfj411pm/DLzKCMd2pjs3ZzGjgU31IP16
         SMF+xEK4T8aXXgV7ohFf1bhz+/QZ0snTopXVrJwnMeqvySHK6pXsfSXEdoZNqusbNhwY
         WIBTA8qRtxZaa7kX+8dROqsrWwrUP7xo6PAFdKva551FER4QSplvi3ybqCNAimFLs2yw
         /IdfsWc61mKGTTR6eEJrvShn11ng9Vb5N3cZUl7TBOc2efBGOoRvKRKuaG+lpZqn7bwh
         yN+A==
X-Forwarded-Encrypted: i=1; AJvYcCWaBK4Qj7UpTn93NPf0VQ/FKW8eRnpQ6EDN42jQNXiHE7scVwYCWlXvHEJuUXR/sDUVkxvkUSpEhQVU3hF/Glk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhfx/ZhSV4q3ETQnpL7HMYxFFmHTA6S9z5uXcalOw8gaY18Sv2
	HhOfRSbJMcT61T42D0tHcheJh3CLYp+8aSWgGEBfhap1KUOCaqWXe3kV4JR6WViDd/UIglwz0ky
	tZ+y+qB5Ap7vQPJCAl0dkWLGlfzd4qojBVjAs
X-Google-Smtp-Source: AGHT+IGEUawEh3mfQp6LCKeSaw+tM4JS/Jg17r0MLTtyYvI0UVg00MKhSKv4na3gy4ai0yuC2fEh+dcYDGEE1VVcg80=
X-Received: by 2002:a05:6808:34b:b0:3db:421c:1bce with SMTP id
 5614622812f47-3df05c28735mr1735969b6e.1.1724945423657; Thu, 29 Aug 2024
 08:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <20240828225522.684774-2-jeffxu@chromium.org>
 <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com> <097a3458-0126-48e3-ba0d-d7dc7b9069d2@lucifer.local>
In-Reply-To: <097a3458-0126-48e3-ba0d-d7dc7b9069d2@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 08:30:11 -0700
Message-ID: <CABi2SkVe6Y4xypBw0n8QbqKJgsfy9YRNJWvBZ3bjTa=-Z5Zn2g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, 
	rientjes@google.com, keescook@chromium.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Thu, Aug 29, 2024 at 8:14=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Aug 29, 2024 at 07:45:56AM GMT, Jeff Xu wrote:
> > HI Andrew
> >
> > On Wed, Aug 28, 2024 at 3:55=E2=80=AFPM <jeffxu@chromium.org> wrote:
> > >
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Add more testcases and increase test coverage, e.g. add
> > > get_vma_size to check VMA size and prot bits.
>
> This commit message is ridiculously short for such a massive change, even=
 for
> test code.
>
> > >
> >
> > Could you please pull the self-test part of this patch series to mm-uns=
table ?
> > It will help to prevent regression.
>
> No, please don't.
>
> This needs review.
>
> These tests establish a precedent as to how mseal should behave, this is
> something that needs community review, not to just be taken.
>
> There's already been a great deal of confusion/contentious discussion
> around mseal() and its implementation.
>
> Pushing in ~800 lines of test code asserting how mseal() should behave
> without review isn't helping things.
>
> Also, this is a really unusual way to send a series - why is this a 2/2 i=
n
> reply to the 1/2 and no cover letter? Why is this change totally unrelate=
d
> to the other patch?
>
> Can you send this as a separate patch, preferably as an RFC so we can
> ensure that we all agree on how mseal() should behave?
>
> Sorry to be contentious here, but I think we need to find a more
> constructive, collaborative way forward with mseal() and to act with a
> little more caution, given the problems that the original series has caus=
ed
> I'd think this is in the best interests of all.
>
> Thanks for understanding!
>
There have been two bugs I found recently on mseal.
One during V2 of in-loop change and the other mentioned in 1/2 of this patc=
h.

These additional tests will increase the test coverage of mseal and
ensure the functionality of in-loop change is correct, also help to
detect future regression.

If you feel it will take time to review the test case, please do so
and comment on the tests itself directly, I will send V2 after that.

Thanks
-Jeff


> >
> > The first part ([PATCH v1 1/2] mseal: fix mmap(FIXED) error code) can
> > be ignored as Liam proposed to fix it differently.
> >
> > Thanks
> > -Jeff
> >
> > -Jeff
> >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  tools/testing/selftests/mm/mseal_test.c | 826 ++++++++++++++++++++++=
--
> > >  1 file changed, 759 insertions(+), 67 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/=
selftests/mm/mseal_test.c
> > > index e7991e5fdcf3..4b3f883aae17 100644
> > > --- a/tools/testing/selftests/mm/mseal_test.c
> > > +++ b/tools/testing/selftests/mm/mseal_test.c

