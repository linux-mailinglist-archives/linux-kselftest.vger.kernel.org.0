Return-Path: <linux-kselftest+bounces-2672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9A4825AEF
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 20:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE391C23296
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 19:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63835EF3;
	Fri,  5 Jan 2024 19:08:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3F35EF1;
	Fri,  5 Jan 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=shelob.surriel.com
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <riel@shelob.surriel.com>)
	id 1rLpRC-0000a3-2o;
	Fri, 05 Jan 2024 14:00:58 -0500
Message-ID: <b074426bb17af70b9db98e7de7023180822a8c40.camel@surriel.com>
Subject: Re: [PATCH 0/1] selftest/mm/hugetlb: SIGBUS on stolen page
From: Rik van Riel <riel@surriel.com>
To: Andrew Morton <akpm@linux-foundation.org>, Breno Leitao
 <leitao@debian.org>
Cc: linux-mm@kvack.org, vegard.nossum@oracle.com, rppt@kernel.org, 
 songmuchun@bytedance.com, shy828301@gmail.com,
 linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 05 Jan 2024 14:00:58 -0500
In-Reply-To: <20240105084238.306269c3f3a63cb0fd130baa@linux-foundation.org>
References: <20240105155419.1939484-1-leitao@debian.org>
	 <20240105084238.306269c3f3a63cb0fd130baa@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Fri, 2024-01-05 at 08:42 -0800, Andrew Morton wrote:
> On Fri,=C2=A0 5 Jan 2024 07:54:18 -0800 Breno Leitao <leitao@debian.org>
> wrote:
>=20
> > This test case triggers a race between madvise(MADV_DONTNEED) and
> > mmap() in a single huge page, which got stolen (while reserved).
> >=20
> > Once the only page is stolen, the memory previously mmaped (and
> > madvise(MADV_DONTNEED) got a SIGBUS when accessed.
> >=20
> > I am not adding this test to the un_vmtests.sh scripts, since this
> > test
> > fails at upstream.
>=20
> Oh.=C2=A0 Is a fix for this in the pipeline?=C2=A0 If so, I assume that o=
nce
> the
> fix is merged, we enable this test in run_vmtests?
>=20
I've got some ideas on how to fix it, and hope to get
a fix to you and Mike by next week.

I'll ask Mike if I run into any unexpected complications.

--=20
All Rights Reversed.

