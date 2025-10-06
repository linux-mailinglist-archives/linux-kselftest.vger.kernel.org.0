Return-Path: <linux-kselftest+bounces-42780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2FABBDC62
	for <lists+linux-kselftest@lfdr.de>; Mon, 06 Oct 2025 12:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E40B4EC4CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A9226CE06;
	Mon,  6 Oct 2025 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E597mMN/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D4259C83;
	Mon,  6 Oct 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747669; cv=none; b=tml4xtVwYWs7mwKu465pxaD9M1wNYmsIhsvhYxtQe8J4IYyauWoIwFyBOajIomUKRi+FbYs4heASeBAJovYd3/4qXOaToPNs2uKLWlmDGAxuudifybv/pb6Jz16G0BR61jbzOUzpKpUlXQcLdtryVBvskiTo1m9DbqRTPnXAq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747669; c=relaxed/simple;
	bh=FX1Lzu7+bvM9e8qmukvbO1hpPMzmlxgfp1qFo7AK/EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miDG5M6zH2nR+N4KhMGspZyicQXFTmDEh9ybswXjTlXN3HR+mLrxpPwebHxHysiiOqDHjMS/H8EKFHhQdNj4df9F7p4DBzVyfAygw1GCUL1GC9xovSEVk5dzcfGjbrAE8tYY2km5ucrFKZ8EY44tph7O1wcpbAS0IbE7mE7jP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E597mMN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDD7C4CEF5;
	Mon,  6 Oct 2025 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759747669;
	bh=FX1Lzu7+bvM9e8qmukvbO1hpPMzmlxgfp1qFo7AK/EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E597mMN/x7YVkjNX1Bc0G8W7GHt89kk8u2seksXgi5q2H3Gw9DqBry/MoIgd7Hl/f
	 QcuYuZ/DwxfZxXg04LwRoNwgtiAl8T7SsOstK7UXK8SyqkUmffohAckrwzORjzcTe+
	 /i/1SV3Pn0pttPu3dXePy8Hlmyjuwx9fL801o6Qw=
Date: Mon, 6 Oct 2025 12:47:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, tony.luck@intel.com, qiuxu.zhuo@intel.com,
	james.morse@arm.com, rric@kernel.org, airlied@linux.ie,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robdclark@gmail.com,
	sean@poorly.run, jdelvare@suse.com, linux@roeck-us.net,
	linus.walleij@linaro.org, dmitry.torokhov@gmail.com, maz@kernel.org,
	wens@csie.org, jernej.skrabec@gmail.com, agk@redhat.com,
	snitzer@redhat.com, dm-devel@redhat.com, davem@davemloft.net,
	kuba@kernel.org, mcoquelin.stm32@gmail.com,
	krzysztof.kozlowski@canonical.com, malattia@linux.it,
	hdegoede@redhat.com, mgross@linux.intel.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, sakari.ailus@linux.intel.com,
	clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, jack@suse.com,
	tytso@mit.edu, adilger.kernel@dilger.ca, dushistov@mail.ru,
	luc.vanoostenryck@gmail.com, rostedt@goodmis.org, pmladek@suse.com,
	senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk, minchan@kernel.org, ngupta@vflare.org,
	akpm@linux-foundation.org, yoshfuji@linux-ipv6.org,
	dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de, jmaloy@redhat.com, ying.xue@windriver.com,
	shuah@kernel.org, willy@infradead.org, sashal@kernel.org,
	quic_akhilpo@quicinc.com, ruanjinjie@huawei.com,
	David.Laight@aculab.com, herve.codina@bootlin.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, linux-edac@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-mm@kvack.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, tipc-discussion@lists.sourceforge.net,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH v2 07/19 5.15.y] minmax: simplify and clarify
 min_t()/max_t() implementation
Message-ID: <2025100648-capable-register-101b@gregkh>
References: <20251003130006.41681-1-farbere@amazon.com>
 <20251003130006.41681-8-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003130006.41681-8-farbere@amazon.com>

On Fri, Oct 03, 2025 at 12:59:54PM +0000, Eliav Farber wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> [ Upstream commit 017fa3e89187848fd056af757769c9e66ac3e93d ]
> 
> This simplifies the min_t() and max_t() macros by no longer making them
> work in the context of a C constant expression.
> 
> That means that you can no longer use them for static initializers or
> for array sizes in type definitions, but there were only a couple of
> such uses, and all of them were converted (famous last words) to use
> MIN_T/MAX_T instead.
> 
> Cc: David Laight <David.Laight@aculab.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Eliav, your testing infrastructure needs some work, this patch breaks
the build on this kernel tree:

In file included from ./include/linux/kernel.h:16,
                 from ./include/linux/list.h:9,
                 from ./include/linux/wait.h:7,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from fs/erofs/internal.h:10,
                 from fs/erofs/zdata.h:9,
                 from fs/erofs/zdata.c:6:
fs/erofs/zdata.c: In function ‘z_erofs_decompress_pcluster’:
fs/erofs/zdata.h:185:61: error: ISO C90 forbids variable length array ‘pages_onstack’ [-Werror=vla]
  185 |         min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
      |                                                             ^~~~
./include/linux/minmax.h:49:23: note: in definition of macro ‘__cmp_once_unique’
   49 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
      |                       ^
./include/linux/minmax.h:164:27: note: in expansion of macro ‘__cmp_once’
  164 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
      |                           ^~~~~~~~~~
fs/erofs/zdata.h:185:9: note: in expansion of macro ‘min_t’
  185 |         min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
      |         ^~~~~
fs/erofs/zdata.c:847:36: note: in expansion of macro ‘Z_EROFS_VMAP_ONSTACK_PAGES’
  847 |         struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


I'll drop this whole series, please do a bit more testing before sending
out a new version.

thanks,

greg k-h

