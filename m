Return-Path: <linux-kselftest+bounces-19553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA799A99B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 19:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3EDB24E1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0D01A08A4;
	Fri, 11 Oct 2024 17:12:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF881AD7;
	Fri, 11 Oct 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666750; cv=none; b=GmW3Uvy0yEvG56ixjlPso/u1Xd1pQ5H9RJw0nigEP8JFIQEfNP6JTXBniVVOHsQLjGq6OtYeVgSRn2zeQqw9mVyvXdTr17OTTmzXf+K8GZLNp/FwMqbqGy1Tjx3nqk+R719beoDguDgt5AZDLVk2/2PmDbEcP/i55LpuzLBKiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666750; c=relaxed/simple;
	bh=tAyqjljXvfzvMta7rhreCUqmzV06XkpJxK3Fp2fCvoY=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=mUQ6uVgzNYPyGIQ3UN5i1JASKRZEAhR8DxVQsqO3SPpVINwE4GOGXy7d+TYHC0sFcQ30fbbguC+Pl9VjIGQrsykRvi5QIWp6afy2ENRLOYYgTBDB0c6CXlJfQmM8QFxfZFbWmg0FrdaOAvfWVcp/OPIHKBATGge7VpUOKBtPTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XQCkB51VMz6LCtW;
	Sat, 12 Oct 2024 01:08:02 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 39133140B3C;
	Sat, 12 Oct 2024 01:12:25 +0800 (CST)
Received: from GurSIX1 (10.204.104.19) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Oct
 2024 19:12:19 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch> <20241009065837.354332-1-gur.stavi@huawei.com> <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch> <002201db1a75$9a83b420$cf8b1c60$@huawei.com> <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch> <002701db1ae3$368d9b70$a3a8d250$@huawei.com> <6707e3028d844_20573a294f0@willemb.c.googlers.com.notmuch> <000101db1b2f$7410c2f0$5c3248d0$@huawei.com> <67085135e4fe2_21530629429@willemb.c.googlers.com.notmuch> <000301db1bbc$453feae0$cfbfc0a0$@huawei.com> <670937c990fca_234aca29481@willemb.c.googlers.com.notmuch>
In-Reply-To: <670937c990fca_234aca29481@willemb.c.googlers.com.notmuch>
Subject: RE: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket is not RUNNING
Date: Fri, 11 Oct 2024 20:12:13 +0300
Message-ID: <000401db1c00$bd86afe0$38940fa0$@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbGWzwQMZqw76ooUWOpIJuIeDZyLJ8x9WAgAEVHYCAAHM4AIAA1CkdgADoeFuAAINGnIABEt/xgAAqsjA=
Content-Language: en-us
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

> Gur Stavi wrote:
> > >
> > > If we don't care about opening up fanout groups to ETH_P_NONE, then
> > > patch v2 seems sufficient. If explicitly blocking this, the ENXIO
> > > return can be added, but ideally without touching the other lines.
> >
> > I don't think that allowing ETH_P_NONE is relevant.
> > In my opinion the 2 options that should be considered to fail
> > fanout_add are:
> > 1. Testing proto == 0
> > 2. Testing proto == 0 || ifindex == -1
> >
> > The only corner case that is caught by [2] and missed by [1] is
> > the "unlisted" case during do_bind. It is such a rare case that
> > probably no one will ever encounter bind "unlisted" followed by
> > FANOUT_ADD. And this is not a dangerous corner case that leads to
> > system crash.
> >
> > However, being a purist, I see the major goal of code review to promote
> > correctness by identifying corner cases while improving style is a
> > secondary priority. Since we did identify this corner case in our
> > discussion I think we should still use [2].
> > I don't consider the code complex. In fact, to me, the ifindex clause
> > is a more understandable direct reason for failure than the proto which
> > is indirect. Having the ifindex clause helps figuring out the proto
> > clause.
> 
> It's interesting that the unlisted fix does not return ENODEV, but
> returns success and leaves the socket in an unbound state, equivalent
> to binding to ETH_P_NONE and ifindex 0. This seems surprising behavior
> to the caller.
> 
> On rereading that, I still do not see a purpose of special ifindex -1.
> 
>

Can this code be relevant?

		case NETDEV_UP:
			if (dev->ifindex == po->ifindex) {
				spin_lock(&po->bind_lock);
				if (po->num)
					register_prot_hook(sk);
				spin_unlock(&po->bind_lock);
			}
			break;

Perhaps, although the socket failed to (re) find the device, the device
is still aware of the socket and we need the ifindex condition to fail.



