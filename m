Return-Path: <linux-kselftest+bounces-47909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37772CD7EF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 04:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9865D3002509
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81062C21EA;
	Tue, 23 Dec 2025 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBxKrYLe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFB15624B
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459095; cv=none; b=e7h2jMRLN9I6P/XntFOrUtKDcVxcfY7vtzAC7VpjSaBv41bAho10dEYFdxYg/iSiaWelODjSOWFClAJJ7rJVgQ9FdCRo/uNgdDjw1KBp/k50nN+W2+WY3RmCfhfFKTG0+/5dkTWEMUN3DL1jrwPmaE02SjQWjiFmTcmW2bQg6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459095; c=relaxed/simple;
	bh=aucvQJ0k3ACZsll7r/d/s9M8Jn+xEyBOr0poHSKAO8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl4JdcpYvbNx4+/37c7f298auphFOfM2tZghSfwAXVYOce51G1iIWPe/EEMsURy/883CvJ3rZo+HoU7IVVHVMkpi54p0bn9MsQkBhLbAdkzCWqRUFHGWXhA7ydDwptfPgVgnZ7clrpVyqh4idmHovvUX9f+jB68mJ0joAh366aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBxKrYLe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766459092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nLHMRdZp+52WlmJl70YIYmzq63XF1C8+A5V76VrIqbw=;
	b=NBxKrYLe6iEJPb3eIeFwR6WChcACVMgpEINcjJe/1/stIqBx+kFjXaZ/JNlZiR446D96Xe
	wwmvDVijHk1PNPPHLo8ORLt0jTU8z47Q7JZpitSyeOr7ftOC3u/XMC4upICj5IR90Ftdil
	9Wfoy/mu9nJB9rcHOILMtp/6s51Hrlc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-FO9ON-jNNkaN51tbHpAx8g-1; Mon,
 22 Dec 2025 22:04:48 -0500
X-MC-Unique: FO9ON-jNNkaN51tbHpAx8g-1
X-Mimecast-MFC-AGG-ID: FO9ON-jNNkaN51tbHpAx8g_1766459086
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82163180060D;
	Tue, 23 Dec 2025 03:04:46 +0000 (UTC)
Received: from gmail.com (unknown [10.72.112.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FEAE19560A7;
	Tue, 23 Dec 2025 03:04:38 +0000 (UTC)
Date: Tue, 23 Dec 2025 11:04:34 +0800
From: Chunyu Hu <chuhu@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Luiz Capitulino <luizcap@redhat.com>, david@kernel.org,
	shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com
Subject: Re: [PATCH v2 4/5] selftests/mm: va_high_addr_switch return fail
 when either test failed
Message-ID: <aUoGwqSnRbPWD0aR@gmail.com>
References: <20251221040025.3159990-1-chuhu@redhat.com>
 <20251221040025.3159990-2-chuhu@redhat.com>
 <20251221040025.3159990-3-chuhu@redhat.com>
 <20251221040025.3159990-4-chuhu@redhat.com>
 <469acbcf-22f2-4774-8cf3-7f68c7095c0a@redhat.com>
 <aUoCepcpRjuMKoNW@gmail.com>
 <20251222185618.e5c3e0303cdc5f34c45c9a29@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222185618.e5c3e0303cdc5f34c45c9a29@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Dec 22, 2025 at 06:56:18PM -0800, Andrew Morton wrote:
> On Tue, 23 Dec 2025 10:46:18 +0800 Chunyu Hu <chuhu@redhat.com> wrote:
> 
> > > >   int main(int argc, char **argv)
> > > >   {
> > > > -	int ret;
> > > > +	int ret, hugetlb_ret = KSFT_PASS;
> > > >   	if (!supported_arch())
> > > >   		return KSFT_SKIP;
> > > > @@ -331,6 +331,10 @@ int main(int argc, char **argv)
> > > >   	ret = run_test(testcases, sz_testcases);
> > > >   	if (argc == 2 && !strcmp(argv[1], "--run-hugetlb"))
> > > > -		ret = run_test(hugetlb_testcases, sz_hugetlb_testcases);
> > > 
> > > Maybe you could just have used:
> > > 
> > > 		ret |= run_test(hugetlb_testcases, sz_hugetlb_testcases);
> > 
> > Good point. I thought the result code is not encoded by bit, but for
> > KSFT_PASS and KSFT_FAIL, and KSFT_SKIP, they are per bit.
> > 
> >    85 #define KSFT_PASS  0
> >    86 #define KSFT_FAIL  1
> >    87 #define KSFT_XFAIL 2
> >    88 #define KSFT_XPASS 3
> >    89 #define KSFT_SKIP  4
> > 
> > @Andrew, do you think I need to send a v3 for using the simpified way?
> > if so, send the whole series or the single patch?
> 
> Leave it as it is?  This thing isn't a bitfield, so using |= happens to
> work thanks to good luck.

It works for me. Thanks.

> 


