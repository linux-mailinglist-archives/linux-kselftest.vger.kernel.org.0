Return-Path: <linux-kselftest+bounces-48531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FE4D0400F
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 16:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D73F230340DD
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37B1991CB;
	Thu,  8 Jan 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDGsb9Jb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4A4414;
	Thu,  8 Jan 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886762; cv=none; b=OButrIScaJybWSZPDZ7TKru1tolZmE7jvF1JbSJjoZxe2HrmfazQqybFtOpwJGmWQ1WHAE1hOxsfuyPbGkzLIJurflJRnZBMWZ9qFocyctBENcEzawhTyrTMIj+EvG4gV38QPQoJO/A/8kIGWhoDhogK9CZUhUS1ea1A1nVR25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886762; c=relaxed/simple;
	bh=Hi7vs1cUJYiT9la3vecJJWq3lFQhzg7SJsm+svPYA4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB6gKEVYEB6kqsgPWrVJ7L6Xp9Kir/Hi//yYAK/eEYUDkK1ztXSNfCBl5Gp9P/9Q23grR4a4l4jmOuZwiV4d/fH6joD8Wb4L/IZBoF2P0UdsUuITTBusJJUvmNj2OCh/xYGBjWMew3ccAsBMbSb63fT5VHFAGmpWL0VlTCMvTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDGsb9Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED15C116C6;
	Thu,  8 Jan 2026 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767886762;
	bh=Hi7vs1cUJYiT9la3vecJJWq3lFQhzg7SJsm+svPYA4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDGsb9JbMj0qv/TN5BPGZEWPOv4AFVm3WeS1ra4btcS56c0+tGVgkUkN4TrfQPHwp
	 qTIui4UBaVzaZ8gHiu9KnRMYGanTwNgff+d0E3XuJr2SCTrx2seJPfdE+z234o6IJh
	 1GfbzRxx8ERTfw454TifjdGgdXpwpkfw/PvfAWXRVylzION6vl6q9fsrtrW7786qzR
	 6Gs5uKEkoR/WN8q65Um2KcLOjmh8g3kEuJJ/NawC59R2ECSAsG8qMb2MDqJXApJa36
	 aK15RtngQ3SZijVYiD5QwYuNirCERLrR3Qh4os00h39rYMC+R90iMlt56lQ1oM88rV
	 m5hShqqSE7wCw==
Date: Thu, 8 Jan 2026 16:39:19 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Paul E McKenney <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Kai Yao <yaokai34@huawei.com>, Tengda Wu <wutengda2@huawei.com>
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
Message-ID: <aV_Pp5BUxB9dwp1S@localhost.localdomain>
References: <B952AB3F-16CC-4D28-8038-23DD052D6DDC@joelfernandes.org>
 <9086EA4F-0393-4E01-AE74-1B428904BFCE@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9086EA4F-0393-4E01-AE74-1B428904BFCE@joelfernandes.org>

Le Wed, Jan 07, 2026 at 10:35:44PM -0500, Joel Fernandes a écrit :
> > 
> > By the way, when I last tried to do it from rcu_qs, it was not fixing the original bug with the IRQ work recursion.
> > 
> > I found that it was always resetting the flag. But probably it is not even the right place to do it in the first place.
> 
> I think we need to reset the flag in rcu_report_exp_rdp() as well if exp_hint
> is set and we reported exp qs.

To avoid needlessly reaching the rcu_read_unlock() slowpath whenever the exp QS has
already been reported, yes indeed.

>  I am working on a series to cover all cases and will send RFC soon. However this patch we are 
> reviewing can go in for this merge window and the rest I am preparing (for
> further improvement) for the next merge window, if that sounds good.

Ok.

-- 
Frederic Weisbecker
SUSE Labs

