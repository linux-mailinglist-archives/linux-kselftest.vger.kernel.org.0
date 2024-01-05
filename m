Return-Path: <linux-kselftest+bounces-2655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B0F824F46
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 08:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D52B217D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 07:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3152D1EA73;
	Fri,  5 Jan 2024 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M6Mi5dqd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED320DC5;
	Fri,  5 Jan 2024 07:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB11AC433C8;
	Fri,  5 Jan 2024 07:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704440679;
	bh=q/3P64KpHAihzxvD0caK1igQCA+YfGCSt141JZdzjK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6Mi5dqdSZWVdEBavXuu+2viOk5ok5mAqI4jb9rVNwesgVUzuMogjOhPXu3rT3tmH
	 8/uxVRVmKSA8K94b5YmRYkTgxsWdWnkaC/dfCzUIBa3i7cJqeW1XkgSUImfd1fNJju
	 ZlPuqatkydtnm2eGm68loUt+djjT0pRsA/K6Vz/Q=
Date: Fri, 5 Jan 2024 08:44:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	sroettger@google.com, willy@infradead.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [RFC PATCH v4 1/4] mseal: Wire up mseal syscall
Message-ID: <2024010509-pretty-proclaim-78e5@gregkh>
References: <20240104185138.169307-1-jeffxu@chromium.org>
 <20240104185138.169307-2-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104185138.169307-2-jeffxu@chromium.org>

On Thu, Jan 04, 2024 at 06:51:34PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Wire up mseal syscall for all architectures.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Doesn't this break the build at this point in the patch series?

Normally you add the code for the syscall first, and then you wire it
up.

thanks,

greg k-h

