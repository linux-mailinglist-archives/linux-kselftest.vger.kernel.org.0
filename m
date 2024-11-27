Return-Path: <linux-kselftest+bounces-22567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE09DA7DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 13:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D30B27689
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A61FBC97;
	Wed, 27 Nov 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="lcUuJgGT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lj0FmaI3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2441FBC93;
	Wed, 27 Nov 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709638; cv=none; b=GoDuPs816KDRJOdWIEzGu14f1IFq7EMhI3vvFd6sK1QbCVNj59Qj1MJ24oD3zwJ/I5LHq3VMeBAR+jkzzZr4UhQTKv/bVYzWUUQFRzd3+2MxiaP4NnqGh9LHFnhImuy/0I2O91ULCLQQ9trgF/OHYPODXwpMM4O/houqFeUVRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709638; c=relaxed/simple;
	bh=JesDxQS3YSalkPW0RBx1OmcpU543kk9vLBXgYMAqDd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOqPM3mvdg8vYq4RGoCOB9NL1qa9Fnnd0jnBJHSOo8b1VIVaNH29uPWLRMRDfeYnRUq+iYUWlEH770gqueIs3Qz+fC8eqAzfCQPZ8Qn9zYsf3IeG+9tEZnYnFWCHhnuNifiHn1WlcP2zB1xudBi4QS3UcJgi7nabHC+QAvo9rws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=lcUuJgGT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lj0FmaI3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A196E1140197;
	Wed, 27 Nov 2024 07:13:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 27 Nov 2024 07:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732709635; x=
	1732796035; bh=yziGJFntCAGyHF8vBIeJITZTeQgarmbf75AN8cRSyVg=; b=l
	cUuJgGT2FkR294suRtMxxbipPsVc6nRTRIT3pDV2WryR57PPmJnWxDPjhBNOLhXU
	5TykHJ3NSmakmjmL2ZwzPoCSOTCOoJWZ4/vb7HzJsZT/t/UKaSrkzHhwXS2oESZs
	KZ5fpRR4NCpF2FvxqrWzakl8WK/De1FwZ810mHjsrMG/C8XzOSCwOd81XyTj9GyZ
	OBsBdK/qJlov5cEc64+wXHWRUvIFcA0T6cADCxdEMIJ7b6uErI7Je0m4GHcnRkE5
	jS0XegK9DfWczi63YH8BbeMSm0bHKZmVcIFMiFk68yOniGHMxB9friDqNRf1FCK9
	8b+i+gGu57iBAwgtsHZ9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732709635; x=1732796035; bh=yziGJFntCAGyHF8vBIeJITZTeQgarmbf75A
	N8cRSyVg=; b=Lj0FmaI3H93b0xaVlAoqLyQmRRs7cvR7qEPNj6mooEmmdW38mB1
	i54tTks/CMe3lIGWbw7GCwG2yV6XgmZyzFEF4MsDVOrP0g9meCQ3IC+KUVBxsWgc
	bJLMK6Yt647wxnp9KO1T4LYa8H8g3ugBzDv9DxTUzahfdnLy8hd/C+B62z5bErqF
	b32ExHfHmwnJwJN4lUXEiic1pVyQLOYN6jpPWqIbvzleD04udY7Rs3CGsEinDnJk
	owXWYMpBnv+VVBv4y0FCTwh7ub85Eu7qM68Z7rCNAMefnuUEHBPWgqsjfAf7wR0f
	RscCvrhNroZNFp5xT5aFYPvYf/5LujDn6/Q==
X-ME-Sender: <xms:Aw1HZwBz6Etz48V23YygbFVW9SnTRoKRxzd55uMIEdKUchk6C1ZhSw>
    <xme:Aw1HZygTQXXm0wBxmhh4mLbvddHnGvi30ZU2DjN-utcca0aayojAqe4l3aZCSeTnI
    AaFmpKHJ3u2DdKvvEQ>
X-ME-Received: <xmr:Aw1HZzlwK7SuTCztbzZDBuc40UMgzlUTEHHYXA7PFSvAMDk2yLUwoXL0zAM7v5cmoCJPBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepleetudegtdfgheduudfh
    teelieeuvddtheeijeejudefjeefgeettedutdeggfdunecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepud
    dtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrggtihgvjhdrfihivggtiiho
    rhdqrhgvthhmrghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthho
    peigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnse
    hlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggv
    pdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhglh
    igsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Aw1HZ2xqweTsqOO2ww3OzgzxLso-EWTtC_GN7RlSMhAfEHAO_Ve50Q>
    <xmx:Aw1HZ1QcyyvA5fhXoYrWMTmwaYeuBkW6XSd_lpQ5cvMlwNHrlIxw8w>
    <xmx:Aw1HZxYkRZd3Gl4s6aqRw42VnbA35zGuRo-wXCQlyG8j1aYpNxs4qA>
    <xmx:Aw1HZ-SywVE5uc4c1bkPNNj3xfH0DnisAH9gw4FC4z80g2UK_nVLzQ>
    <xmx:Aw1HZ6JrQZt_n44fLNFT_0PjVL4m409h1VNY3TFWGfPshJsBwu0WQVFo>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 07:13:51 -0500 (EST)
Date: Wed, 27 Nov 2024 14:13:48 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: shuah@kernel.org, hpa@zytor.com, x86@kernel.org, 
	dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/3] selftests/lam: get_user additions and LAM enabled
 check
Message-ID: <3dnmce4m7cgarq74gev6sbae5djwdqjm44ri4pwl3uhesxfgpk@6srb3wppkeun>
References: <cover.1732627541.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732627541.git.maciej.wieczor-retman@intel.com>

On Tue, Nov 26, 2024 at 02:34:47PM +0100, Maciej Wieczor-Retman wrote:
> Recent change in how get_user() handles pointers [1] has a specific case
> for LAM. It assigns a different bitmask that's later used to check
> whether a pointer comes from userland in get_user().
> 
> While currently commented out (until LASS [2] is merged into the kernel)
> it's worth making changes to the LAM selftest ahead of time.
> 
> Modify cpu_has_la57() so it provides current paging level information
> instead of the cpuid one.
> 
> Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
> get_user() in its implementation. Execute the syscall with differently
> tagged pointers to verify that valid user pointers are passing through
> and invalid kernel/non-canonical pointers are not.
> 
> Also to avoid unhelpful test failures add a check in main() to skip
> running tests if LAM was not compiled into the kernel.
> 
> Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
> test was ran without issues with both the LAM lines from [1] untouched
> and commented out. The test was also ran without issues with LAM_SUP
> both enabled and disabled.
> 
> 4/5 level pagetables code paths were also successfully tested in Simics
> on a 5-level capable machine.
> 
> [1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
> [2] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/
> 
> Maciej Wieczor-Retman (3):
>   selftests/lam: Move cpu_has_la57() to use cpuinfo flag
>   selftests/lam: Skip test if LAM is disabled
>   selftests/lam: Test get_user() LAM pointer handling
> 
>  tools/testing/selftests/x86/lam.c | 122 ++++++++++++++++++++++++++++--
>  1 file changed, 117 insertions(+), 5 deletions(-)

Apart from the nitpick in 1/3, looks good to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

