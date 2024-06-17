Return-Path: <linux-kselftest+bounces-12045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3DE90AB2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 12:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461441F223BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188861940B3;
	Mon, 17 Jun 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8lwyU1i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E222190069;
	Mon, 17 Jun 2024 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620481; cv=none; b=sQ/gDkeYkUi4yI8GcO/DMdYB2lwH67O5wkzUPZFRnUxY/Lh+1RoFW35RMTlsTvPbSXKevSLmNsTbD5X3i6FoXbYB0Twusb9HjRSOXzdh2bXdKMBU8mgwKpNMceUpmwuX5Iy8GT9EACMVS/BYhoBsniE+KJcvzxqyE16xzHbz3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620481; c=relaxed/simple;
	bh=R6kuMQcODbpcdFv6Mmo7QCnm98Fnuy+ktalW6vWVeGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nxs1TqUwV4AVHUCifhWeZwPZ6Ysb2Lo0NmZdKBtFT0Oq+vWFMPqVYPVWODiNQBlhy144NREx3TPBvIpPXP16y+T488sKpLMYDnYB6ZF3t/LdcVYr3QMzdwXxfWm9ilFrNFPrX9SROiyal5w8XbBbgfWO/Q0dhccA2NDvtkUngcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8lwyU1i; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so45137266b.0;
        Mon, 17 Jun 2024 03:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718620478; x=1719225278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6kuMQcODbpcdFv6Mmo7QCnm98Fnuy+ktalW6vWVeGc=;
        b=i8lwyU1iLT/2ge+jjO0YUM3ezUfxFEDzcSZsMvRsRDu3JFzFgpmxX04AZ4xyVt8i+B
         eqyN+HIpZQOrEM0DjeeuA5rx+JvOsTtEvj9+cjDSM7wf+M+v+JZfrRi9/JUcc6SdgR0b
         IiSa/8gmfNSqYvOYg+ibid1qME1mZPEUodSZ3QbZm3QUsNinUfEgu7m5ARawJ09zGrc9
         9PyTwXpN2QyhcdwTKjNcI4ej4Ll63fCVBUGCn0vdp6KgkeqdHf4mxAJrm6sQTDFMsnfb
         j89IDSNsJqHll4BCTqk053ZhNj36f1YEa73wT6yd1df6q4WdUA7QhlTplgJok4Xzgvmy
         g5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718620478; x=1719225278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6kuMQcODbpcdFv6Mmo7QCnm98Fnuy+ktalW6vWVeGc=;
        b=LbHKqvXB6PZPZQUmLtkZArxT4ISXXU2K6xRP8mIgQUEIIfEJDyfZuhveaaan/7LhdQ
         pFq1Ruygy2TmqZsUa+In9xsSES+CKXAAsdZOOMeUT1+LqNkXFtjzevClc5+O2TCJ53Yx
         L2O7ivVBgWdT2ZfohuWQgSfq9I6TkiBVKHHBtJ004xjqNW4xEOj7T5VcvVl9R1Da2WWd
         Ob2H69/jyGges7nc74yGRlGdKcJ7KhxU4VFglrw5rw5tbxHzAxW87wEGJRKGWwoLwTma
         tGbRrm9mrC52olmqm27i9oL+CUurz9HmlpnAB7qjh2izHmhxBPEekREIJxh3sxwKC4tW
         Lf4A==
X-Forwarded-Encrypted: i=1; AJvYcCWipA54OV9L4MU0cAxlv10gZPluDDbKEk/nSSAxsDKX7SmVULx72rPdUjqkRNDCGCZd2BmJpN1PKaOVrE/g/zdNiNAWWKpPSUJq8K0SPzSptOZhBvWN4trnzFl6NNxXDzC3hptJXQ09Tml8
X-Gm-Message-State: AOJu0YyADVTmyc81jvao+10EVdm5eoWeQ3oC7+NmxF59KRrOZEVXVmrW
	k4E4RF3TDqQ6C2UVd/PDvNZfq4Ju8eGA0RhQdF79KljwpQ0LddFDPO2dKh3V9BtgoEAOPs6XYVe
	yavghDQ/zbTtoBtdD2Dabcu2gDJA=
X-Google-Smtp-Source: AGHT+IEJ9LDSRjzd5mprtbVbxdNtfSDp0HSYO8YB7ccTmM+wVFsIlIajqFMms5d2WwHu1fSJMH1UsG3vIb+/dvYP9p0=
X-Received: by 2002:a17:906:d157:b0:a6f:46f1:5434 with SMTP id
 a640c23a62f3a-a6f523ec1ccmr873561966b.6.1718620477464; Mon, 17 Jun 2024
 03:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611215544.2105970-1-jiaqiyan@google.com> <20240611215544.2105970-2-jiaqiyan@google.com>
 <CABzRoyYGY2EgT5wC9o98Vn_auh59poQ-OOnKceCiWQAJrbZoBw@mail.gmail.com>
 <CACw3F5134NmmLNr4zXHV1h0sLMTGcAJLpApQ7Fv_-DtUieD7zw@mail.gmail.com>
 <786a08ff-aa7e-49d5-f589-0a405c7e1a34@huawei.com> <ea8c5e390bd18c532b768dd9eeaa105a@suse.de>
 <8faf45d3-0722-2b9e-f641-9d081aad5a82@huawei.com>
In-Reply-To: <8faf45d3-0722-2b9e-f641-9d081aad5a82@huawei.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 17 Jun 2024 18:34:26 +0800
Message-ID: <CAK1f24mRaScJgKc7E4riQ6xTc-SVx_PanTJkA3duwpJZVhyxFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Oscar Salvador <osalvador@suse.de>, Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com, 
	jane.chu@oracle.com, muchun.song@linux.dev, akpm@linux-foundation.org, 
	shuah@kernel.org, corbet@lwn.net, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 4:16=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> On 2024/6/17 15:51, Oscar Salvador wrote:
> > On 2024-06-17 09:31, Miaohe Lin wrote:
> >
> >> IMHO, it might not be suitable to use EAGAIN. Because it means
> >> "Resource temporarily unavailable" and
> >> this can be solved by simply retry later without any further actions
> >> taken. But I might be wrong.
> >
> > We usually use 'EOPNOTSUPP' when we fail due to a setting not being set=
.
> > EPERM is more for a capability matter.

Agreed. Let's use 'EOPNOTSUPP' here ;)

Thanks,
Lance

>
> Thanks Oscar. So we should return EOPNOTSUPP here.
>
> Thanks.
> .

