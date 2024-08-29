Return-Path: <linux-kselftest+bounces-16722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D979965067
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 21:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69B91F246F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 19:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAAD1BA29E;
	Thu, 29 Aug 2024 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oJiF1HZe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F72148FF0;
	Thu, 29 Aug 2024 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961504; cv=none; b=fsVbu8mryBeVgml7s8BE0ok428CDKkf9IREaeYCIW7vq7hXqvt6fp1XN0U8SoEPLwU7sH8KRxNLj5njd9y13wQaZzCZ9rSSCW5tVq94qeMRzX80dpGcmwX1LBUe2Zxf3kV1E3154E/GqsWA2ygAfh6+QuglmPVjbDPqe/5OFEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961504; c=relaxed/simple;
	bh=5ZJO21J7u88izzuci2C208UHwROGrNt3osb4f9ZFkdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC7YeLcOTk+ZfjYB/SyZxCxGuVBiTtqNHCqywpgaehg7tYKXYeOSdOdPMkDHRN8sEZ+3yq4R0I6NCjqUxITy+ldfuM+G6aJbrLuQKhPb9e24R/mlt4iyP6u/81n0zvyTFbxAti0tJSq5G46kLmLfduafu10biFPMbFsJU2zWQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oJiF1HZe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2y1Q6Z5FNb1Px58aZg62B3qtSMZPeJoICzrTDFXz/eo=; b=oJiF1HZeObZH20BOyCNMGtmWAs
	IO1Rwzl99g6OHDbdJ+L3srXUg5bjrIgdPietSUfnzQ2pi9I9J8fzFRowOoMltDOrG06t97zKOq5YE
	6nj3v7fvizoEY0BM7r1ybz3vnWNE/t63bfgy1cG7odCAfP7TfzhfiviOVttKOf93PisNO40zVNoiM
	3qR41XcAI+LOyA7JHB3xmJOA/RBGb16jotT0XAiGb70IQc6iYQ5TC1JiKxu2tLd/STAagMUCeJF0f
	UfexAuysX3JVXrtdzM76fq5UWtJ8JV/whXRLHa9hFkqcm6J01WGm0i6Mnn9HISpnJV6UW/Bjp0c8e
	LjoMQ/VQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sjlHg-00000002T5Y-3Lzf;
	Thu, 29 Aug 2024 19:58:20 +0000
Date: Thu, 29 Aug 2024 20:58:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, pedro.falcato@gmail.com,
	rientjes@google.com, keescook@chromium.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
Message-ID: <ZtDS3AP9Ejt31EbU@casper.infradead.org>
References: <20240828225522.684774-1-jeffxu@chromium.org>
 <20240828225522.684774-2-jeffxu@chromium.org>
 <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com>
 <097a3458-0126-48e3-ba0d-d7dc7b9069d2@lucifer.local>
 <CABi2SkVe6Y4xypBw0n8QbqKJgsfy9YRNJWvBZ3bjTa=-Z5Zn2g@mail.gmail.com>
 <5a312d38-4591-47b1-9a6c-4a7242dbe20d@lucifer.local>
 <CABi2SkXDVgiUeC1StbfggvtiYG_kDxQJsZPpDw-NDPNv6-dwmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXDVgiUeC1StbfggvtiYG_kDxQJsZPpDw-NDPNv6-dwmg@mail.gmail.com>

On Thu, Aug 29, 2024 at 12:54:09PM -0700, Jeff Xu wrote:
> Hi Lorenzo
> 
> On Thu, Aug 29, 2024 at 8:44 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> 
> > > >
> > > > Also, this is a really unusual way to send a series - why is this a 2/2 in
> > > > reply to the 1/2 and no cover letter? Why is this change totally unrelated
> > > > to the other patch?
> > > >
> 1/2 has a fix that 2/2 is depending on. That is the reason they are together.

The normal way to send out these patches is as three emails; a 0/2 cover
letter, 1/2 replying to 0/2 and 2/2 also replying to 0/2.  That's what
has Lorenzo confused.

> > > > Can you send this as a separate patch, preferably as an RFC so we can
> > > > ensure that we all agree on how mseal() should behave?
> > > >
> It is not an RFC because it doesn't change any semanic to mseal. The
> updated test will pass on linux main as well as 6.10. The increased
> coverage will help to prevent future regression, i.e. during
> refactoring.

You seem to not understand that there is disagreement on the semantics
of mseal().  I mean, ther's been a lot of arguing about that over the
last week.  There's understanable reluctance to accept a large pile of
tests saying "this just ensures that mseal behaves the way I think it
should", when there is substantial disagreement that the way you think
it should behave is in fact the way it should behave.  Be prepared to
argue for each semantic that you think it should have.

> I will add a cover letter, split the tests and add more comments to
> help the review.

Thank you.

