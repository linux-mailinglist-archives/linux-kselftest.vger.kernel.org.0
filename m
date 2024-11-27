Return-Path: <linux-kselftest+bounces-22566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B16179DA779
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 13:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7732827F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5C71FBC8A;
	Wed, 27 Nov 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="r92Kl2md";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5Ok6EUPv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024851FBCA7;
	Wed, 27 Nov 2024 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709511; cv=none; b=q8Jj2pC42biXTjsxqvzHp3e/Y6zJrUG729AqHojD9oLKWbkYx/2vGW36bbHmqB//84GPWqYN3AepaHDuaAFuF6/ctZZrIQSvd2fA1OYzx9Zyoro/FwiEsdq2IO/iDNL2eyYMFWSBUkupK6/aIzgzhFOJZ7rzfscAhplIKWbXU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709511; c=relaxed/simple;
	bh=jzXiWxyCibDahW4FWBCnt++CATpAWgnwTob3s6EhX1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFF0n2dcRw0ZmD1PRo5vESBwz+u7OSMp1ppE4mqazNmrgowM5YT2YiV15rGNo2LHE3IgyrMYbWS4vCOqmGul65H28CG39oaw58Ho4uk1NfS1nS2C/Q2v4aJTwnOuvnTNSCwLBfnQdzndCaucV5NH3kzagbqLcY3XvpR7l4NrYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=r92Kl2md; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5Ok6EUPv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8CEC2540072;
	Wed, 27 Nov 2024 07:11:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 27 Nov 2024 07:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732709507; x=
	1732795907; bh=3blg7EFfpE4vkXvFpR4yFVjJmH1gJFZZGLgmEe/FrLQ=; b=r
	92Kl2mdbB7MQSS/OYx2J7FaxG7RGB+rJ2opdgVWsrauQUxP1R9UKURWGMk4Sgy6D
	Hy3VvCwDrLbV9WLbwyW3XS5K3MPISolYAP8FE34TDHpJBZWfyMxPLVoqjJ0oQohx
	zDKPSps3kySeOow5tTSe0bdc5c77MaHrTfkchpJo9go6McjucCcupA5o9JWj6e8d
	akcuhRUdsDoGwu3TnjsC8ksZ0FF1vht46iatKiKEryuyTGocRzVSXPzfnwpLVWzK
	wsWD+ao/JEJsoLzDj+KF6ECUkLSpxZCPEwHEIDmepro3cQkEd5n2YmmK1ggyCLlm
	5TNMFnz2qj8p7ttqNJQgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732709507; x=1732795907; bh=3blg7EFfpE4vkXvFpR4yFVjJmH1gJFZZGLg
	mEe/FrLQ=; b=5Ok6EUPv4W3E+86ly6MTj646iphZE5wh39OT0XlnGD6zMifZVX6
	61CuLvas9D4P6QiKBTyIiLwOiwHeIpoh58j3qdKLcsrIJScu+0ZWJRlY1KU/aRGV
	VXOYwFYkcMClK6qTK4HTHy5LZ+5bA6AyxUiwGICmFJ5qm/vNCQrgQYTZTky2G4/F
	OlMN7jI7nx/kZTYx29ejyx/k8oZAIVgxneAlg+JQIIxPzygY8x3zjO8OJOkuUys5
	dU0iP/oH1w5KhznOnJU5KZU1+fdJOVPxI3Bu9m38rSEhfLxUUc7axOvVTKixBhn5
	B5bbFnXxL9bkELzwTx870ZETQBvY+4C2oeg==
X-ME-Sender: <xms:gQxHZ9cPIQMhvlrfw7ukEFjBWQCjXbfbLKPtibs0SrsODWSDs5dOFw>
    <xme:gQxHZ7MEeV3tnUAe2LWbNFbmbnGnFQldhs8dO4nA3P3AL-V4w0nlxwETYIqrcu1_F
    y4l6_EKtkCITlVm92k>
X-ME-Received: <xmr:gQxHZ2gqJA0ewDdKrhMGszWxK3eagRdUMT6rcgRfJKQzm3jFG8FrSBzvg6T9BVWGEPyUIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnheptddvkeduhfeggeduheef
    hedtffefudfghefgfeevveelueeufffhvdelueevvedvnecuffhomhgrihhnpehsvghrih
    gvshdrthhoohhlshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtoh
    epuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrggtihgvjhdrfihivggt
    iihorhdqrhgvthhmrghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphht
    thhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgdrhhgrnhhsvg
    hnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedr
    uggvpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepth
    hglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gQxHZ2_qQqMhvC_1J1mvY9t39ia2LDjDXuWPu3DNT0RYNo_2h9BhIQ>
    <xmx:gQxHZ5tPtT6jUvhgPxhOeJHNiNLZSNNn-HcbpUqx2GT5Xbgz9OtkMQ>
    <xmx:gQxHZ1HDguZcTK93FA8Teeiu_jijpBJ7ucFFRjr1PWq04xprqX4XhA>
    <xmx:gQxHZwOBcWCc3MdI5faqvzBW9U3YO09WngXRnwrlrbYlLC0u7t2ShA>
    <xmx:gwxHZ6n-ShnUolqwu1bI3ur7mUmXxaqEchFUXJ4a5NfYgw5fxTzPOKf1>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 07:11:42 -0500 (EST)
Date: Wed, 27 Nov 2024 14:11:38 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: shuah@kernel.org, hpa@zytor.com, x86@kernel.org, 
	dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/3] selftests/lam: Move cpu_has_la57() to use cpuinfo
 flag
Message-ID: <6kfafs7wio7ruth3p54pezqwcultxqqpnjvehjzaz7hlba4rp3@6kb5zdqfglsl>
References: <cover.1732627541.git.maciej.wieczor-retman@intel.com>
 <4979b3de7021f34cbef22d44799e28c914f993ca.1732627541.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4979b3de7021f34cbef22d44799e28c914f993ca.1732627541.git.maciej.wieczor-retman@intel.com>

On Tue, Nov 26, 2024 at 02:34:48PM +0100, Maciej Wieczor-Retman wrote:
> In current form cpu_has_la57() reports platform's support for LA57
> through reading the output of cpuid. A much more useful information is
> whether 5-level paging is actually enabled on the running system.
> 
> Presence of the la57 flag in /proc/cpuinfo signifies that 5-level paging
> was compiled into the kernel, is supported by the platform and wasn't
> disabled by kernel command line argument.
> 
> Use system() with cat and grep to figure out if la57 is enabled on the
> running system.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v4:
> - Add this patch to the series.
> 
>  tools/testing/selftests/x86/lam.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
> index 0ea4f6813930..0ac805125ab2 100644
> --- a/tools/testing/selftests/x86/lam.c
> +++ b/tools/testing/selftests/x86/lam.c
> @@ -124,14 +124,11 @@ static inline int cpu_has_lam(void)
>  	return (cpuinfo[0] & (1 << 26));
>  }
>  
> -/* Check 5-level page table feature in CPUID.(EAX=07H, ECX=00H):ECX.[bit 16] */
>  static inline int cpu_has_la57(void)
>  {
> -	unsigned int cpuinfo[4];
> -
> -	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
> +	int ret = !!system("cat /proc/cpuinfo | grep -wq la57\n");

Heh. grep can read files on its own :P

	return !system("grep -wq la57 /proc/cpuinfo");

>  
> -	return (cpuinfo[2] & (1 << 16));
> +	return !ret;
>  }
>  
>  /*
> -- 
> 2.47.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

