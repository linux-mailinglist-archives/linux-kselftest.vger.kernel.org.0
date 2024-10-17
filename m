Return-Path: <linux-kselftest+bounces-19921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DD9A1B75
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E36A1F21FF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BF71C1AC2;
	Thu, 17 Oct 2024 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zBrQfXoS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5FA146A69;
	Thu, 17 Oct 2024 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149283; cv=none; b=bLIlLDXwYyc4iDd+0hfzCnzaxN7pcJtRx/+9Q77oicjRnXNhVN9kyQnqtCNn/7M06J2X8PF9tipQoAfYnJ1f9rm2rS87UpNqxMYMgymQclLpfYxb+4bzW5nAVnTN4wSDQlw+o4u/JmF6v8B31Qvr+q4dbxi0o3Dhf5Q279I0NaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149283; c=relaxed/simple;
	bh=uNzEuamxD/Zyqn90TxU3o2uEqJ394EoOeZ9AkxHXUCw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EqXlu8/x3lIKnyao6F5pHA0b3rz8rGcFYkTM8pHv0VDAIl5HfifMuGDbt9eLxs2iEekg4V7vGtdVphxbfqKTUDHArdkLK6sAJv1t61QJqD8Ga5pERkZOYbWjStpLyk0lC1hxdKNqdhWMNATD0nbVh2+lhjZ3asVOPIUXLoHdxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zBrQfXoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472C6C4CEC3;
	Thu, 17 Oct 2024 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729149282;
	bh=uNzEuamxD/Zyqn90TxU3o2uEqJ394EoOeZ9AkxHXUCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zBrQfXoSoGBX6d6N7gQ+Ft0j4XiJZIamj6wjYqMVAkaCPU5Wi3gBC6jjVrXmT4JLe
	 5lTh+S6jzS1oy9MUrzIlcFWji9HA99+YLOrKjIucbqfU7G43sLa4u/9mrEKFAMkaWx
	 WvhvPu31Uy4Q8I2op8lUdse/Gqny7qLyWdshHvzk=
Date: Thu, 17 Oct 2024 00:14:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, shuah@kernel.org,
 zokeefe@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] selftests: mm: fix the incorrect usage() info of
 khugepaged
Message-Id: <20241017001441.2db5adaaa63dc3faa0934204@linux-foundation.org>
In-Reply-To: <37ce9dfa-3193-4e11-bfd1-d2c8b60b0090@arm.com>
References: <20241015020257.139235-1-sunnanyong@huawei.com>
	<37ce9dfa-3193-4e11-bfd1-d2c8b60b0090@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 12:31:31 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> On 10/15/24 07:32, Nanyong Sun wrote:
> > The mount option of tmpfs should be huge=advise, not madvise
> > which is not supported and may mislead the users.
> 
> Agreed.
> 
> > 
> > Fixes: 1b03d0d558a2 ("selftests/vm: add thp collapse file and tmpfs testing")
> 
> But nothing is really broken here. This just fixes usage information.

The usage information is broken!

> Please drop the "Fixes:".

Fixes: is appropriate.  It tells people which commit introduced the error.

I don't think it's serious enough to add a cc:stable.  Others might disagree.

> > Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> > ---
> >  tools/testing/selftests/mm/khugepaged.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> > index 56d4480e8d3c..8a4d34cce36b 100644
> > --- a/tools/testing/selftests/mm/khugepaged.c
> > +++ b/tools/testing/selftests/mm/khugepaged.c
> > @@ -1091,7 +1091,7 @@ static void usage(void)
> >  	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
> >  	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
> >  	fprintf(stderr, "\n\tif [dir] is a (sub)directory of a tmpfs mount, tmpfs must be\n");
> > -	fprintf(stderr,	"\tmounted with huge=madvise option for khugepaged tests to work\n");
> > +	fprintf(stderr,	"\tmounted with huge=advise option for khugepaged tests to work\n");
> >  	fprintf(stderr,	"\n\tSupported Options:\n");
> >  	fprintf(stderr,	"\t\t-h: This help message.\n");
> >  	fprintf(stderr,	"\t\t-s: mTHP size, expressed as page order.\n");
> 
> Without the above "Fixes:" tag,
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks.

