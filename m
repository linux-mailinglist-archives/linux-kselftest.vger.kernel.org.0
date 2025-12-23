Return-Path: <linux-kselftest+bounces-47906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9CCD7E6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71981303AEA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354EE2BF3CC;
	Tue, 23 Dec 2025 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erjsvEJg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB312BDC34
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 02:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766458001; cv=none; b=KXynthu4MEqmxKCYmYmh0+0BUTPj+XpYSUvjnht9LVLpiMDMMO9VNGXEQZcoTZ8ewGJJ8CNW4+Ofi5O8sS7yTVNy2aO62rxWEkTOOq5iEoOnMYs5TvNyJhjZBRAC9m2uHqr40vFIwp/WuZIoGCVwGo/DyQgvob10vJr49d4n9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766458001; c=relaxed/simple;
	bh=IM1xzLkv6LgWXr1XssXs5AKy95MkU3QFzZbuRWqJbVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6ITW+ccDxR15TJAyaqCtrfY3mE7xWko+KW8kSFf9UODs1xxPAVNWSGhNxfpyW+pm4w8wHH0Bu3nJXsg35x6SEsE9LZt17PlS3/YksYriR2dF8pjmOoEDU+RZmm46DEZ8Xx9+aBadKkSL2nh3ctOen0GkN8Kfbt+9PfPb2x9WiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erjsvEJg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766457998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2Rlf4OXs36AH80vjIKvAiM7VqatDlbcrhnjVYLo8N0=;
	b=erjsvEJgJ4qU5kP8zSOznlIkJEI0m+N+9aVOB/EwdLSkY6h/nZVy01w1VEgpKxZKF9YQbj
	S70CGyh3KRIxKVRpS/d+AqLgXEdSIvcvc8BkNOrNh5IKPnc+Vrw9sq+AAT9Kkqt5hCHeOf
	NHoR555sYBVDiXLqynwvHdduVcPE7m4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-ca8xmKuzNReQJJjUDgZbCQ-1; Mon,
 22 Dec 2025 21:46:33 -0500
X-MC-Unique: ca8xmKuzNReQJJjUDgZbCQ-1
X-Mimecast-MFC-AGG-ID: ca8xmKuzNReQJJjUDgZbCQ_1766457992
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 112291800365;
	Tue, 23 Dec 2025 02:46:32 +0000 (UTC)
Received: from gmail.com (unknown [10.72.112.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3ECE30001A8;
	Tue, 23 Dec 2025 02:46:23 +0000 (UTC)
Date: Tue, 23 Dec 2025 10:46:18 +0800
From: Chunyu Hu <chuhu@redhat.com>
To: Luiz Capitulino <luizcap@redhat.com>, akpm@linux-foundation.org
Cc: akpm@linux-foundation.org, david@kernel.org, shuah@kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com
Subject: Re: [PATCH v2 4/5] selftests/mm: va_high_addr_switch return fail
 when either test failed
Message-ID: <aUoCepcpRjuMKoNW@gmail.com>
References: <20251221040025.3159990-1-chuhu@redhat.com>
 <20251221040025.3159990-2-chuhu@redhat.com>
 <20251221040025.3159990-3-chuhu@redhat.com>
 <20251221040025.3159990-4-chuhu@redhat.com>
 <469acbcf-22f2-4774-8cf3-7f68c7095c0a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469acbcf-22f2-4774-8cf3-7f68c7095c0a@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Dec 22, 2025 at 02:36:18PM -0500, Luiz Capitulino wrote:
> On 2025-12-20 23:00, Chunyu Hu wrote:
> > When the first test failed, and the hugetlb test passed, the result would
> > be pass, but we expect a fail. Fix this issue by returning fail if either
> > is not KSFT_PASS.
> > 
> > CC: Luiz Capitulino <luizcap@redhat.com>
> > Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> > ---
> >   tools/testing/selftests/mm/va_high_addr_switch.c | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
> > index 02f290a69132..51401e081b20 100644
> > --- a/tools/testing/selftests/mm/va_high_addr_switch.c
> > +++ b/tools/testing/selftests/mm/va_high_addr_switch.c
> > @@ -322,7 +322,7 @@ static int supported_arch(void)
> >   int main(int argc, char **argv)
> >   {
> > -	int ret;
> > +	int ret, hugetlb_ret = KSFT_PASS;
> >   	if (!supported_arch())
> >   		return KSFT_SKIP;
> > @@ -331,6 +331,10 @@ int main(int argc, char **argv)
> >   	ret = run_test(testcases, sz_testcases);
> >   	if (argc == 2 && !strcmp(argv[1], "--run-hugetlb"))
> > -		ret = run_test(hugetlb_testcases, sz_hugetlb_testcases);
> 
> Maybe you could just have used:
> 
> 		ret |= run_test(hugetlb_testcases, sz_hugetlb_testcases);

Good point. I thought the result code is not encoded by bit, but for
KSFT_PASS and KSFT_FAIL, and KSFT_SKIP, they are per bit.

   85 #define KSFT_PASS  0
   86 #define KSFT_FAIL  1
   87 #define KSFT_XFAIL 2
   88 #define KSFT_XPASS 3
   89 #define KSFT_SKIP  4

@Andrew, do you think I need to send a v3 for using the simpified way?
if so, send the whole series or the single patch?

> 
> But anyways, as this is just testing code:
> 
> Reviewed-by: Luiz Capitulino <luizcap@redhat.com>
> 
> > -	return ret;
> > +		hugetlb_ret = run_test(hugetlb_testcases, sz_hugetlb_testcases);
> > +
> > +	if (ret == KSFT_PASS && hugetlb_ret == KSFT_PASS)
> > +		return KSFT_PASS;
> > +	else
> > +		return KSFT_FAIL;
> >   }
> 


