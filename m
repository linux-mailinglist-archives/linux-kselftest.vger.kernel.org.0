Return-Path: <linux-kselftest+bounces-8103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0408A6677
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A44B253D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADCD83CD2;
	Tue, 16 Apr 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H3CCsruG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389D2907;
	Tue, 16 Apr 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257403; cv=none; b=WDxwjM3ux7YaN5avWwBGlwLQmEtsG1i5zactoqehmNzWZDIruGWq0TVkVuSen5BBtgg+z3/zPYDGE1LB1PVTjV1aflVn2b4IYYTCx735GLY6SI1SUdG2g9UjRqEkeo/wUGzPVl8/95bGccfV2hXmX42qxPDgvPPnUZVeckbXyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257403; c=relaxed/simple;
	bh=3qx/QIvtlfg5a5J0QcAKUsi/DDLtbBM0/jmcM30KQCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBpRegiO0Pm1x36/IgSWn9RuXFGFjgm4ERHprKf0gH760grL8a8W8Ipk+3vyXJg9dTHoWzeuUUhdIGw6LxWggwvz3UqyUTs69HKHhmzxuAKR0gfqROBzNyqAaczXvKfxB3Gv21lkVAmlKN0VlDAuzrR7OV0a7YoFYQN2LmIuDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H3CCsruG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC0EC113CE;
	Tue, 16 Apr 2024 08:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713257403;
	bh=3qx/QIvtlfg5a5J0QcAKUsi/DDLtbBM0/jmcM30KQCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3CCsruGoclAZXzbSMyjaaTWT8tfRgDokx7oUc+rXkx7ORXNF99wPPcUJgTU8RTh+
	 8b01dCZBoY5vm3u3IOZ+MY+2KcCkiAnL6SjoSF4PuWBB60dkI5zNxbHrphWgJvJVGu
	 /KYpdKFby2hbJHzJNaE7fVJQvswWCAhdXVtY4Xso=
Date: Tue, 16 Apr 2024 10:49:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Elizabeth Figura <zfigura@codeweavers.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Message-ID: <2024041638-levitate-sustained-2058@gregkh>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416081421.GB31647@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416081421.GB31647@noisy.programming.kicks-ass.net>

On Tue, Apr 16, 2024 at 10:14:21AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 15, 2024 at 08:08:10PM -0500, Elizabeth Figura wrote:
> > This patch series implements a new char misc driver, /dev/ntsync, which is used
> > to implement Windows NT synchronization primitives.
> 
> This patch series does not apply to anything I have at hand. Nor does it
> state anything explicit to put it on top of.

Should work on linux-next as I took a few of the original commits from
the last series already.

thanks,

greg k-h

