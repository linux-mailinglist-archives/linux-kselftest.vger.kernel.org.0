Return-Path: <linux-kselftest+bounces-14829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E563194885A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 06:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A249A2825AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 04:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839F71BA87B;
	Tue,  6 Aug 2024 04:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIXyXEq6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F3EADC;
	Tue,  6 Aug 2024 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722918444; cv=none; b=a6j+KnlwrIZRV/TKYX7plJ6RPVvi8cn3gVRXhWRLW7SvxyxhWkcnuYxUy9vi4Aw4Y6qKhdW4Z0O1NqWipNm31kvTD+itwsq4ujlfi9AcPcd8OznzcwJEZgXdlewZRyL4DrKDh9i6IMgFryXjb4z8IZy6BziATRiWU6sUfJoXRtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722918444; c=relaxed/simple;
	bh=AZzy/I51vgXjxJSQvB6NDee/pSQvkl/ELAdj2zwi0es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/rLMS40l1HmwRLMxUZvmVqmSvZLjR7SXoDDKDeeZpcUYLkICtOgMVN8BeTOi9yaY+zwLjNM89P7fb0/jREmAQ0KrkOh8ywtD4anqYHt9ivrz6a2TMvI/8hLKd9mmqIIoMIvNs/MTdoTeRX5o/HYf99rk88QRVzAJgOnc8fevRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIXyXEq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8FAC32786;
	Tue,  6 Aug 2024 04:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722918443;
	bh=AZzy/I51vgXjxJSQvB6NDee/pSQvkl/ELAdj2zwi0es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIXyXEq6bDAqnFjFEN3iXLi/wiYv8IqNv2XLV5j2si3yZCU7rnzJISPVX/dgFq0NS
	 Vqhm+P/Cu4PxAaXoEOfgNenZMAo72oEeFUsibER62z7/MawhvCeE9iSFzJ+gTTkLv0
	 Rqi1KQi4PH9FPXLs52Lu1geS8Nmr2yWiXAyhhBk+lEV+yuUFun913JJQMxOhon5V1t
	 /nAQSjDOxbrJi4pQiCn3XzHlFGO2qcWVL0CzY/cZSHxRYnyr7Q/gsTTHiUZW3buyvm
	 4qAXewx7CPGy9dRB7I/8h3HALw6kxjFQ7OJmllUIJoHDfIcGTG7uyM3omyYkp3dMIu
	 iRgHG/EyuiSMQ==
Date: Mon, 5 Aug 2024 21:27:23 -0700
From: Kees Cook <kees@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org, kvm@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] selftests: harness: refactor __constructor_order
Message-ID: <202408052126.E8A8120C1@keescook>
References: <20240727143816.1808657-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727143816.1808657-1-masahiroy@kernel.org>

On Sat, Jul 27, 2024 at 11:37:35PM +0900, Masahiro Yamada wrote:
> 
> This series refactors __constructor_order because
> __constructor_order_last() is unneeded.
> 
> No code change since v1.
> I reworded "reverse-order" to "backward-order" in commit description.
> 
> 
> Masahiro Yamada (2):
>   selftests: harness: remove unneeded __constructor_order_last()
>   selftests: harness: rename __constructor_order for clarification

Thanks for resending this!

Reviewed-by: Kees Cook <kees@kernel.org>

Shuah, do you want to take this via kselftest? If not, I can carry it...

-Kees

-- 
Kees Cook

