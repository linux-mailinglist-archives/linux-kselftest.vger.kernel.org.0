Return-Path: <linux-kselftest+bounces-21294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56F9B9192
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 14:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA721F23160
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 13:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6A41A01B9;
	Fri,  1 Nov 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wa9R8oC3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E319B595
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466671; cv=none; b=ojRMumQPtvkSmG8+P8KOFBt5LRqKllPOMMddzHBvLzxlZ6Gm2rYTD0RSosCutVaVlsoxssoevHZt+HS+ApjEzoe/mLQpFduvhgJU0oxR0EMYYFd8um37ypIUDFKYHyGLN+DIcBcX2Wya528X1J/JyIZQX+l5/vxNhL8vXp5DWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466671; c=relaxed/simple;
	bh=rBKvdBkDgEnZ8/2t7qkPf2PV6TUL/0RusHurefk/Ut4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EX/lQKx8J7ZrlUDbQLB+//TwnzVAnGIfldIAGlPJMHrQCyXw66cn1cuIKvAMrigolxjKZUNfMAl3L3KA0wux8C9hHE+EV+9kkCX0xtUlKLzHN1IHWkmNHR1xjwOGvENKT3HY0TDOIuVFVpQgEb/aKUX9Xm9IGg+85I5aQOsz3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wa9R8oC3; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso350045ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Nov 2024 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730466668; x=1731071468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBKvdBkDgEnZ8/2t7qkPf2PV6TUL/0RusHurefk/Ut4=;
        b=Wa9R8oC30ojESYlGBaJN5FHhWFWGwcEABhXi/mNfOP60y6BuCHFir7o3TzMbmilvVq
         PT53JJ2yG/EGDClXQFIeNxVtIC2d0T0nNCq9OTngcuJ26YVOkTcrXA5zBeGQFnu7FDc1
         ObBB8rUPsHn/jS4Lh/EzOA2W68h+2befr+FLrxBasY/CbKW2LQdNQNIgAgaA1gvHvjvP
         VfsOKzT7C3RS3ftszzU4IOCrXkMnbjCTYk/nM97H//8sYv0oAWHO/v0ZxlQnHNBOdFFY
         dP4iZVsQ5acussnrc5cwIgYs72l8Q4sffYeIy5R8EKEDAMr9ELOUhxowAmR3bapuRcEA
         SyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466668; x=1731071468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBKvdBkDgEnZ8/2t7qkPf2PV6TUL/0RusHurefk/Ut4=;
        b=k5ta/Kyy85vZJ3M1MSkaDIcD+1VIwiOYO28iXtzZMSyKFz5y/nA1XcE/jmZU2u3xqd
         u32kq0ZmbyvMqILZbLuK5Fr/9PpFofg+QDUFZwVsOUSkH2G8Z+xaK5qZRjgKKejDlDpr
         AUDcu54aEm8U0tyy83cRut51z/hGv0Qx+fqul6rkvZhMqVHDWSo6dFwZuVcE02S7+6Xv
         MpJiEH6w6dqtgZf/fHct5sfEeFZoG9uWTX+gWEzY4mbQ8xsYghsD9wV/RXfNYMGJQNPJ
         a/Df0sHtV+hYH3+chdqc++bn7ar9XUtlzaZK4G3W/tlNpbiQ7v69Sbgj+iBwC5YPcnbk
         IP0w==
X-Forwarded-Encrypted: i=1; AJvYcCVIY7JXska3VT7StM4h9l30CCiKO/TaJUpl4h1rIOyyCohKwkQO1FKNt3c6mKLTBwHscijH4on8A8JQkHzslvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjzp/F9Y5gNxj+C3AvhmHM5HWE6HTz12D989kI7X38S4y+19tX
	GGfEJKluUuBHhV7aho5Gu5WqVmoq6oqWFHa34hpQ8vci5oZTCivEXnfZbtrdPXQuJNv4e8dC95d
	KoEQpyrVHwDG2q+YxhYnXaiDNoEhuYh+058CP
X-Gm-Gg: ASbGnct3z0J18FprldKjPpLSPhC/J/K+VX0R+t1jEOvsikkqtuknlehcNeUAQZ5/OaW
	wZaOzBaBUJkU/LZkuCTgbxbrRWlH2y10=
X-Google-Smtp-Source: AGHT+IGy5jtPAQs70nZmSVQRpEpNW+aE/1kV6A2Lr9FjnVTsOCY2FVzGfSbPMwj3G1YUCRVN/VYED/7JXkuD6qBixIQ=
X-Received: by 2002:a05:6e02:1a08:b0:3a3:dab0:2399 with SMTP id
 e9e14a558f8ab-3a6a9414a07mr7484945ab.27.1730466668433; Fri, 01 Nov 2024
 06:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
 <20241029204541.1301203-3-almasrymina@google.com> <763d9630-3064-4d88-8e99-549a07328ec8@huawei.com>
In-Reply-To: <763d9630-3064-4d88-8e99-549a07328ec8@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Nov 2024 06:10:56 -0700
Message-ID: <CAHS8izMgF8nx87D9pWPmq1pfDm1v8x5Z6gc_eMHcYo8zKX-Lrw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/7] net: page_pool: create page_pool_alloc_netmem
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 4:14=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/10/30 4:45, Mina Almasry wrote:
> > Create page_pool_alloc_netmem to be the mirror of page_pool_alloc.
> >
> > This enables drivers that want currently use page_pool_alloc to
> > transition to netmem by converting the call sites to
> > page_pool_alloc_netmem.
>
> For old API, page_pool_alloc_pages() always return a whole page, and
> page_pool_alloc() returns a whole page or a page fragment based on the
> requested size.
>
> For new netmem API, page_pool_alloc_netmems() always return a whole
> netmem, and page_pool_alloc_netmem() returns a whole netmem or a netmem
> fragment based on the requested size.
>
> Isn't it a little odd that old and new are not following the same
> pattern?

Hi Yunsheng,

The intention is that page_pool_alloc_pages is mirrored by
page_pool_alloc_netmems.

And page_pool_alloc is mirrored by page_pool_alloc_netmem.

From your description, the behavior is the same for each function and
its mirror. What is the gap in the pattern that you see?

--=20
Thanks,
Mina

