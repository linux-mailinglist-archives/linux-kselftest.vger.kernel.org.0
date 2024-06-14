Return-Path: <linux-kselftest+bounces-11950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A1908E05
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 16:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754541C230DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181E15B118;
	Fri, 14 Jun 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqiA2VIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E215EFC1
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377053; cv=none; b=VovI16RsSIReylBo30o9X+Rf721mAV55dMNbkcp/nTEV/DZfh7/3zW1wvP80aVJ57Mq75MdkQjt2G5oiitXvkaFAY8QsT6MsYOcJ4UZZiyxjwBU9yCx12vXotuiBuZyiKWlJc9gHyxSd5GMpA6HIBmqCAMszB0XW2tDz1FRKLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377053; c=relaxed/simple;
	bh=PDBN7CfZoySclWGICiQXNm0dLSN3WzDrHOHH5KLuTBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gACxzUcDx9NoCHR/mSoUCHY7b4OlkCCPnkiYjJwv8XZFnEgVkhf0XJMTCsuF0il7FJKP7xj0nEJqXxhCWe0qkDiHvwrNMuehwg8VZshAQdCZs9ibrkBmx9Icpp+9RuF6gBxD0Yjm3X463/CFcZQ/D56EmNmx43QPxl88PLliu7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RqiA2VIr; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24542b8607fso1131828fac.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 07:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718377029; x=1718981829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDBN7CfZoySclWGICiQXNm0dLSN3WzDrHOHH5KLuTBY=;
        b=RqiA2VIrxAOZYTsqAo8GuIbdlsUvpOHlVWfUE5OZ2lOHx3TehibFiFxCa4fso0dFQw
         ZdMZAgNLfrA9TEpk10rYcsqx2RmMkBADquXriPe8v0k5UoIjKTl/Lv4jDdQ2BX7K0nUz
         aE0bhrbcm7wLkCANOH5rpITri/4e+Bd+96WVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718377029; x=1718981829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDBN7CfZoySclWGICiQXNm0dLSN3WzDrHOHH5KLuTBY=;
        b=kwA4xlpY8CcapuMrREn+HSP+A/9PV93lQ3i2+YSo0mJyi3yG+LqzeDZCrj3vYq0WlY
         XiDT4x1xbfaHf7XFeLOt/TG6588KQsqpX8nJ+vYY9++Jv3r3ZT40xTHxJnAWPLF1BVPh
         RtLEUHOlkgvnwGXDUNNKAbiM4DZDno3A6L8d4YAMX1BC8Evi5RxTPjTodwH7E55+sGO6
         rYCpBuLypKEflFJJe5oVBBYCdtq0RvEXeaYWgIF//+6cSkVjh/73oVowhG1LbQ1ZkI9U
         u+eFebAN/w4DRoDxSneF26D/LnMTqJwr7rfUXlT9QnHzGapi1HQtYLTkLO0+Os8NArRX
         /Xiw==
X-Forwarded-Encrypted: i=1; AJvYcCWrk/3A4ODGFgDGvV9TVixcIxef8wqwtljb+yNHPlEKTjf8Uy2tJ8Xa+1EGV0GWHG3jq/+c6vcrwFf255pNW8HTQfnoqsBtDGon9zxRQH+2
X-Gm-Message-State: AOJu0Yw+zVwJ4hFhV1ftbdpi0CA6vrnBn7rXK72jvTaHRIvGAZiDYHTe
	aS394oIWFXU9nxqfevAIOsSR6VZlC6orQphpKFYJaQr9nGcNONbCSTWCqMbwtYNPquYhD1Z+shK
	TEUs0FzQMIMcQL388yw23YMLeKYJZdpDtYhdM
X-Google-Smtp-Source: AGHT+IEUcAWOw1CVNlN0YcNfMetLlCT81YqYJzny/v8B5VIR1b7mnqvJKLKUWEnEomwJ3Vd4mFsoMMwH5EJv6fYqHso=
X-Received: by 2002:a05:6871:72c:b0:24f:c241:4d16 with SMTP id
 586e51a60fabf-25842be40f2mr3448708fac.50.1718377029521; Fri, 14 Jun 2024
 07:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614023009.221547-1-jhubbard@nvidia.com> <20240614023009.221547-3-jhubbard@nvidia.com>
 <4c6ffb1e-0381-4d5e-afa2-f8809f0b445f@redhat.com>
In-Reply-To: <4c6ffb1e-0381-4d5e-afa2-f8809f0b445f@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 14 Jun 2024 07:56:57 -0700
Message-ID: <CABi2SkXcb_GaSomWrj+n8tEg-VmR3e5bLpqw0-h9K=6gkiBxow@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] selftests/mm: mseal, self_elf: factor out test
 macros and other duplicated items
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 5:28=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.06.24 04:30, John Hubbard wrote:
> > Clean up and move some copy-pasted items into a new mseal_helpers.h.
> >
> > 1. The test macros can be made safer and simpler, by observing that the=
y
> > are invariably called when about to return. This means that the macros
> > do not need an intrusive label to goto; they can simply return.
> >
> > 2. PKEY* items. We cannot, unfortunately use pkey-helpers.h. The best w=
e
> > can do is to factor out these few items into mseal_helpers.h.
> >
> > 3. These tests still need their own definition of u64, so also move tha=
t
> > to the header file.
> >
> > Cc: Jeff Xu <jeffxu@chromium.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
>
> Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jeff Xu <jeffxu@google.com>

>
> --
> Cheers,
>
> David / dhildenb
>

