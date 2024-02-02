Return-Path: <linux-kselftest+bounces-3964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB8A846542
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 02:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC8F288636
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 01:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715D53A2;
	Fri,  2 Feb 2024 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="esiuD9iU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F753A1;
	Fri,  2 Feb 2024 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835965; cv=none; b=SrHntAGg4NUv1TsQVbXFfWU+WFYaOvABqca/IAhHb+2udVWjljag6sCzMx4DJ2+pw1kTPaZtIyuMtiJH9g+epTIKj64bKfbKzJoxqCO//Xuai7PgcXu/1/1cCAMK4d4Kzy5TDcM1B4BORVi9Fn579maVcEGjiI2gPuKuIfQcWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835965; c=relaxed/simple;
	bh=FCd8HoHZrcX63bQlMAlSTqIPH/4qdHcUl1FKM5j5vsA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8Qbln+6a/z1mPYAH8dLl2zPXnc0H9btqasYeZFcreWlLjYFYq1vzSrufpg2L2JFVykN70YQdb9zNuWlwONTjpU+cpSPsKX5cEp01olS3iFz3Bmymsfj1DCeGjHF6UzC6nle1fitj20Q0cQfmaHpkFZs2uKI7NJ61sPHsg2kxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=esiuD9iU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC09C433C7;
	Fri,  2 Feb 2024 01:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706835964;
	bh=FCd8HoHZrcX63bQlMAlSTqIPH/4qdHcUl1FKM5j5vsA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=esiuD9iU7YeWm66qZS9sotr0oscjl9KHVUZ0JvRlbyJyTgwZ2DAHvReTGSJj8Exwk
	 QsMvI06Zan9QzIH7ULW++Jl5sWbQROYd2EqWQtOwbm7OmDIp7qWO3e04fRioc4jaFG
	 n2kFJpJUOY92viQr7+kBMQwQD7oBQXt6boqi7cEc=
Date: Thu, 1 Feb 2024 17:06:03 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Jeff Xu <jeffxu@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	sroettger@google.com, willy@infradead.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
	groeck@chromium.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
Message-ID: <2024020137-hacking-tightwad-a485@gregkh>
References: <20240131175027.3287009-1-jeffxu@chromium.org>
 <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver>
 <60731.1706826280@cvs.openbsd.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60731.1706826280@cvs.openbsd.org>

On Thu, Feb 01, 2024 at 03:24:40PM -0700, Theo de Raadt wrote:
> As an outsider, Linux development is really strange:
> 
> Two sub-features are being pushed very hard, and the primary developer
> doesn't have code which uses either of them.  And once it goes in, it
> cannot be changed.
> 
> It's very different from my world, where the absolutely minimal
> interface was written to apply to a whole operating system plus 10,000+
> applications, and then took months of testing before it was approved for
> inclusion.  And if it was subtly wrong, we would be able to change it.

No, it's this "feature" submission that is strange to think that we
don't need that.  We do need, and will require, an actual working
userspace something to use it, otherwise as you say, there's no way to
actually know if it works properly or not and we can't change it once we
accept it.

So along those lines, Jeff, do you have a pointer to the Chrome patches,
or glibc patches, that use this new interface that proves that it
actually works?  Those would be great to see to at least verify it's
been tested in a real-world situation and actually works for your use
case.

thanks,

greg k-h

