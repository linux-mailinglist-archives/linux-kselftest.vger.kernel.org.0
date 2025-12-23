Return-Path: <linux-kselftest+bounces-47908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9138CD7ED0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC442301EF95
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B152BCF4A;
	Tue, 23 Dec 2025 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mKSA5/Rw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552A92BFC7B;
	Tue, 23 Dec 2025 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766458580; cv=none; b=AWwUCLNpe7vef2pSaFR5DpTn7ZrEbqyFVCUuZ6llG5OZxsKTdseWv3au9N+DffyT420CfUavnlo/NPsafLu0FNCaKP+wzVtKVrXSfJp7ZxzhTvDlc3lyPPy7ciXhM6B/8xmEOeGtepcK9ZYEk11bEn/OqBczWnS4zve8HBeM6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766458580; c=relaxed/simple;
	bh=U9A22yvSeV1PNJAgjZUA6GYw1/HANkzGS4qI6qnUm54=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TNy/WmL3u0JL9fFK5eXjlANd7cL/xcdhnw/vJEFgFA7mIij/lqkMImOsLY5QYpyQHT1Ea4VSWhsNVCWOz2L/9NyctNmDqHk1pt2HfHtZrhQDXIv3mFkD7T4eQHhW8N395eyl3nQ76Tb3okM8Vzjbdtr8LCGpOpxDMYF/EjseJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mKSA5/Rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C9FC4CEF1;
	Tue, 23 Dec 2025 02:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766458579;
	bh=U9A22yvSeV1PNJAgjZUA6GYw1/HANkzGS4qI6qnUm54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mKSA5/RwiRVSo+XMwVR2NyEQ/KdmZt3vCPVGYzH8nkQapUptA22cTcun3nJGq7b/x
	 qmYR05cZlFN9JbdHkzWXahDERT4s38GKFoJTjhw19mm0Bt9WOpDcsrYNFhdd7yGG76
	 befMYq85SpvJjefoZmHE9QIXWG6lu7gcYS5LIZF8=
Date: Mon, 22 Dec 2025 18:56:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chunyu Hu <chuhu@redhat.com>
Cc: Luiz Capitulino <luizcap@redhat.com>, david@kernel.org,
 shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com
Subject: Re: [PATCH v2 4/5] selftests/mm: va_high_addr_switch return fail
 when either test failed
Message-Id: <20251222185618.e5c3e0303cdc5f34c45c9a29@linux-foundation.org>
In-Reply-To: <aUoCepcpRjuMKoNW@gmail.com>
References: <20251221040025.3159990-1-chuhu@redhat.com>
	<20251221040025.3159990-2-chuhu@redhat.com>
	<20251221040025.3159990-3-chuhu@redhat.com>
	<20251221040025.3159990-4-chuhu@redhat.com>
	<469acbcf-22f2-4774-8cf3-7f68c7095c0a@redhat.com>
	<aUoCepcpRjuMKoNW@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 10:46:18 +0800 Chunyu Hu <chuhu@redhat.com> wrote:

> > >   int main(int argc, char **argv)
> > >   {
> > > -	int ret;
> > > +	int ret, hugetlb_ret = KSFT_PASS;
> > >   	if (!supported_arch())
> > >   		return KSFT_SKIP;
> > > @@ -331,6 +331,10 @@ int main(int argc, char **argv)
> > >   	ret = run_test(testcases, sz_testcases);
> > >   	if (argc == 2 && !strcmp(argv[1], "--run-hugetlb"))
> > > -		ret = run_test(hugetlb_testcases, sz_hugetlb_testcases);
> > 
> > Maybe you could just have used:
> > 
> > 		ret |= run_test(hugetlb_testcases, sz_hugetlb_testcases);
> 
> Good point. I thought the result code is not encoded by bit, but for
> KSFT_PASS and KSFT_FAIL, and KSFT_SKIP, they are per bit.
> 
>    85 #define KSFT_PASS  0
>    86 #define KSFT_FAIL  1
>    87 #define KSFT_XFAIL 2
>    88 #define KSFT_XPASS 3
>    89 #define KSFT_SKIP  4
> 
> @Andrew, do you think I need to send a v3 for using the simpified way?
> if so, send the whole series or the single patch?

Leave it as it is?  This thing isn't a bitfield, so using |= happens to
work thanks to good luck.

