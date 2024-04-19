Return-Path: <linux-kselftest+bounces-8429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9FC8AAFE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63ADD1C22BC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6B12C53D;
	Fri, 19 Apr 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WArAd6Dd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA212CDBF;
	Fri, 19 Apr 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535193; cv=none; b=H4SrxgnmUydsiNhgJ+sxIYbu7iAp7SJhrD80CYUA0vJ6gLbHHELXM0G41A0lo2n6m8SvInMB9mge6ewJpc6aMauWTdzEku12kdT1bK2FbraNlaGu6gptpSpw4QuL6n+FNieHEHa5Q1D4kNFGOJyVRezVRPisC345HLRXMnsbiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535193; c=relaxed/simple;
	bh=t7Rb5hCY4Np00gpS6uJ1Fonk+kodFdWdVd1OfwvnTcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRZ8AJUXpn++8Z2NSfIuGHR3GEwbovgoOdlRhX1hxl9uSl4ZqAYcXchFh4ssFEdWDdcNiKJtw2fIUsridR8b4dwqcOhpC06hJuJwyvSP14/H3In3Ao8CwGx8+ExCSgOiZ2r04gdCs03Xufb0GzI03w6UJkVeLj9nepcMTMBCKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WArAd6Dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0FFC072AA;
	Fri, 19 Apr 2024 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713535192;
	bh=t7Rb5hCY4Np00gpS6uJ1Fonk+kodFdWdVd1OfwvnTcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WArAd6DduSO//Nqx/0pdrXzNJvfql/DoLNuvlPuuLwDR7HFVh4akn7IbO0tpEmwTW
	 HouGLmClbfk0Mwzp8RDOOGCrJQI9eejPj9dc5r94VPMwaVUuBBDzverIFP9bQWlBMZ
	 487/xjo7/l41WiPMMdsMqY8HNzHvCg5RvgZh9CPw=
Date: Fri, 19 Apr 2024 15:59:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] kunit: avoid memory leak on device register error
Message-ID: <2024041941-declared-footrest-9e8f@gregkh>
References: <20240418210236.194190-1-wander@redhat.com>
 <20240418210236.194190-3-wander@redhat.com>
 <CABVgOSncx1eS_8EWsNkoDOj+TaNsaW8MpjG8XaFY2Q8JXo+oqQ@mail.gmail.com>
 <CAAq0SUmMdTb5C-SCSD5WPPyj5B1iB6dD5QWuDTsXPnJktFr36g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SUmMdTb5C-SCSD5WPPyj5B1iB6dD5QWuDTsXPnJktFr36g@mail.gmail.com>

On Fri, Apr 19, 2024 at 09:30:06AM -0300, Wander Lairson Costa wrote:
> As a side note, the behavior of device_register() seems
> counterintuitive and error-prone, IMO. If the function returns an
> error, it should ensure it leaks no resource and shouldn't require the
> caller to do any cleanup.

I too want a pony, but that's not the way the code works here, sorry.
It's always been like this, and has always been a problem, but last time
I looked, there was no way to really fix this.  That's why we document
it a lot to make sure people don't get the error paths wrong here.  I
know it's a pain :(

sorry,

greg k-h

