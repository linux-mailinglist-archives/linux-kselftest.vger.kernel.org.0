Return-Path: <linux-kselftest+bounces-29150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BBDA63362
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 03:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0523A167F
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 02:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4974383A5;
	Sun, 16 Mar 2025 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="sgr6dt0a";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cdBU4kE4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a48-105.smtp-out.amazonses.com (a48-105.smtp-out.amazonses.com [54.240.48.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99992D26D;
	Sun, 16 Mar 2025 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742093839; cv=none; b=ggPlARfioIfb4sT9mSQzehmUqXLI/wKMgolSHKWF4SJkAOKf3ghMvhfcxvf42nQMGXLu7yOgGpPtKm7qhs8qeSpFKIl6qv4CKqgJ++SjyYPgqli/JcylQhCRS26lVwNlrktMbmrIAm1rST332d1knD4XC1EkM0GpE09R9NWh/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742093839; c=relaxed/simple;
	bh=V/Hofvva/tI/9xwFYj237s5Y/mAkuzG9//5niNcWUes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsPdxuIh0B1csx8VXn0Qepaosk5R0gHftani+x8oi+TrBHBhvn2nKGozLfNldxyYB4hQghzp9MDjXAF/DnIRAYSKsYkdrlQMJ8570PKZT1NPhE/PofUlGfZFwmYyaLK3zQtzzHNplS8OS8tcUHi81WWHXe9H50XJGr8DF9m3QPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=contact.antoniohickey.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=sgr6dt0a; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=cdBU4kE4; arc=none smtp.client-ip=54.240.48.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=contact.antoniohickey.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1742093835;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V/Hofvva/tI/9xwFYj237s5Y/mAkuzG9//5niNcWUes=;
	b=sgr6dt0aQCm6CWyx60Efq+NaH4J77lXJ/VbVXnQZPAG+sOLnPvMDnrctSPadj9v0
	Ia4cG0hMReXfPDulzVYM+J0hy8qK35w8BeFvUdH69yGO2chJQ6ASbT9t7D17Ju5TQ5g
	69fFKTwTC7BZOT7FnBuYkJkpMHBjTlGQqRhUEJOi4nS3/SmQIigAI7rxRCnkbyscE+Q
	thRFkl5q6ZREsfAWplwz37ialodcZqqgWsQ/4ydXPSuOao6OcpYO09Rodvq/yGC2PKD
	zGEpfqYRGDmUArHFyRF7azLPBI1kFuh4BI5G/QvAp+RaGZBV6QGJVma6BosPMO3vhs6
	7eaPxxnzFQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1742093835;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=V/Hofvva/tI/9xwFYj237s5Y/mAkuzG9//5niNcWUes=;
	b=cdBU4kE4lye1j/25GGNgpltkhyTIn8HunKAWi64VV1mTlvTyaao8cx4mr9W5GIQV
	oDtO95sFNqDYTQjsI9VMLaH55QKSdIrj0BIgHf80inxZyGmL2UaeUzIjAhNkhSSi5Dr
	tDLG4pP8ASnt2PA8e15LxxSMwYWX0Vn09BGTL+qw=
From: Antonio Hickey <contact@antoniohickey.com>
To: boqun.feng@gmail.com
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bhelgaas@google.com, 
	bjorn3_gh@protonmail.com, brendan.higgins@linux.dev, 
	contact@antoniohickey.com, dakr@kernel.org, davidgow@google.com, 
	fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	netdev@vger.kernel.org, ojeda@kernel.org, rafael@kernel.org, 
	rmoar@google.com, rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: Re: [PATCH v3 2/3] rust: replace `addr_of[_mut]!` with `&raw [mut]` 
Date: Sun, 16 Mar 2025 02:57:15 +0000
Message-ID: <010001959ce25be2-a436530e-858c-4da8-b823-24f98bad392b-000000@email.amazonses.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d4c74d.050a0220.66d0.b23d@mx.google.com>
References: <67d4c74d.050a0220.66d0.b23d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.3SHHfi5Rh4c+NdtIv+pxNWeqDT0J3zAhYZLMebdhE9o=:AmazonSES
X-SES-Outgoing: 2025.03.16-54.240.48.105

On Fri, Mar 14, 2025 at 05:18:17PM -0700, Boqun Feng wrote:
> Besides, it'll be easy to review if you can split the changes into
> multiple patches. Thanks!


Hey Boqun,

Thanks for the review, do you think splitting this patch
into a seperate patch for each file would be best?

Thanks,
Antonio


