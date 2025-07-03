Return-Path: <linux-kselftest+bounces-36389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8014AAF69CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EA34E1090
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558028935E;
	Thu,  3 Jul 2025 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HfCg6gJE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFF42A9E;
	Thu,  3 Jul 2025 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751520923; cv=none; b=U4G9NFjVj0bCHwG+V6eZ7K3ltG7l/3g5DIlucvQeiLmtE2co0gearCw+KfxqrVR4AGBCGCp8VM655X/6JBXc2Giw/Y0D5f6UmjGpUJS2HOMG5CGgnOf92JAc8PtYW3D86Ti0U/zCypvxv+KB3dFmvWDlUc5kgTPh0gq4FfjonPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751520923; c=relaxed/simple;
	bh=yeYg6l7jpX2wUFOOLFtqLbrA40KVIjwHufhNi0OeZVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN40ci4VV2/wYqZ0unnD+ffa38+/lZiK7G0makGzYINyrgNsoGUlbE7VNjmesuXJ4xEm84pgdKE8fgziBpqIubdZ+tGTaQQdlBPFo8AbTS5AqHPyDIU8mV9cl0SkjqZrXPtX2R/N1AUBxDdXpNkq/rs6ly48u366sdzSuEabv98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HfCg6gJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EE4C4CEE3;
	Thu,  3 Jul 2025 05:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751520922;
	bh=yeYg6l7jpX2wUFOOLFtqLbrA40KVIjwHufhNi0OeZVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfCg6gJEBBc2fdKMY/VjDjPSARvBed6UCnQS+loRwZyyd4AMNSAZydmhWRmqLuks7
	 LhfMbj52p6Q5Hw5ouwXsPMac14p6bu0ENd67wqa9yAWpFj340XhQ3vVUj/6ljx3wJd
	 o8ZRw+ge1GE33MF4wUQMaWgxZZB83olM/EydLA/w=
Date: Thu, 3 Jul 2025 07:35:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chas Williams <3chas3@gmail.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jiri Slaby <jirislaby@kernel.org>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-sh@vger.kernel.org, netdev@vger.kernel.org,
	linux-bcache@vger.kernel.org, storagedev@microchip.com,
	linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net
Subject: Re: [PATCH] global: fix misapplications of "awhile"
Message-ID: <2025070300-return-removable-7277@gregkh>
References: <h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnrufop6tch@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnrufop6tch@tarta.nabijaczleweli.xyz>

On Wed, Jul 02, 2025 at 09:32:45PM +0200, Ahelenia Ziemiańska wrote:
> Of these:
>   7 "for a while" typos
>   5 "take a while" typos
>   1 misreading of "once in a while"?
> 
> 3 awhiles used correctly remain in the tree
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Please properly break your patch up into one-per-subsystem and submit it
that way.

thanks,

greg k-h

