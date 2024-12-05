Return-Path: <linux-kselftest+bounces-22858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C89E51BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 11:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66582167504
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C341DA313;
	Thu,  5 Dec 2024 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q61MEBf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB851DA0ED;
	Thu,  5 Dec 2024 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392298; cv=none; b=fKmNxp5camphklpHdda1xcyWq5rLAMTnQcmzFKHlI2AqD/QGcQ8fDDlvQrDnQDsRVyvfLhIbrkJsnDFOYuit5U1Xz8aSgw/0vxTipQNxW6DlfmLl6qxRabvEPUxOrsNledI+C9zV+qTzQeqg0MsWy/PStz7OW2JT8Q9TztoVgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392298; c=relaxed/simple;
	bh=wuoye3dUGkRBh7386DHWKpiGlFh08f+epNY8QIOWIEI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsYbEjluRUoQcQVgnYRQ+9sIQR8rGwL6WW5kXnOo4vwWbbOjAfDka5/ay4AxY/QSkVc60uc68xUvtDMIxSHg0SyEmKevGdPjBwOEVBdKlLBkd/lC2Md4YGHKdyGVm2jcofTlu/VuY2AbHwiq/+luXmbcDMdzOrHtaj1JPn41utY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q61MEBf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3594C4CED1;
	Thu,  5 Dec 2024 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733392298;
	bh=wuoye3dUGkRBh7386DHWKpiGlFh08f+epNY8QIOWIEI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=q61MEBf2X5S2oNIn91BYQVCb1YezaWPj69naQ0KkbNLTt/j2aVtcWNRMcEuLwvAJb
	 pEzVCF2nmQOaFGClPdHXQFEz7SQe9JTK67a/qlkOl/43o8kT7oTuh8qAVR3tlM97ix
	 o+SjGjkghHzamDvLtB/PdL1L5NZRjEb1uredBKfVkwzn9F7X9bcVYNousEFtYfViIm
	 6eQgZCaChh181x+zxS/xAShM1PlsINOisopMSQfwiNHnnf38cQshIdHH7QNcsoJ/Db
	 5mTdK5JAQnUiaQA0kH+AppjmsOC9eM6EsJxiI3KBJ/0HUGnDp1r1l7cuIph3+PkRWb
	 8tCcofU1CJqaQ==
Date: Thu, 5 Dec 2024 09:51:33 +0000
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: cleanup busy_poller.c
Message-ID: <20241205095133.GA3382@kernel.org>
References: <20241203012838.182522-1-jdamato@fastly.com>
 <Z06T0uZ6422arNue@mini-arch>
 <Z08xIyc7OcRoEE-C@LQ3V64L9R2>
 <Z08zacl_IhADP0FZ@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z08zacl_IhADP0FZ@LQ3V64L9R2>

On Tue, Dec 03, 2024 at 08:35:53AM -0800, Joe Damato wrote:
> On Tue, Dec 03, 2024 at 08:26:11AM -0800, Joe Damato wrote:
> > On Mon, Dec 02, 2024 at 09:14:58PM -0800, Stanislav Fomichev wrote:
> > > On 12/03, Joe Damato wrote:
> > > > Fix various integer type conversions by using strtoull and a temporary
> > > > variable which is bounds checked before being casted into the
> > > > appropriate cfg_* variable for use by the test program.
> > > > 
> > > > While here, free the strdup'd cfg string for overall hygenie.
> > > 
> > > Thank you for fixing this! I also saw them this morning after a net-next
> > > pull and was about to post... I also see the following (LLVM=1):
> > > 
> > > busy_poller.c:237:6: warning: variable 'napi_id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> > >   237 |         if (napi_list->obj._present.id)
> > >       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > busy_poller.c:243:38: note: uninitialized use occurs here
> > >   243 |         netdev_napi_set_req_set_id(set_req, napi_id);
> > >       |                                             ^~~~~~~
> > > busy_poller.c:237:2: note: remove the 'if' if its condition is always true
> > >   237 |         if (napi_list->obj._present.id)
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   238 |                 napi_id = napi_list->obj.id;
> > >       |                                            ~
> > >   239 |         else
> > >       |         ~~~~
> > >   240 |                 error(1, 0, "napi ID not present?");
> > >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > busy_poller.c:226:18: note: initialize the variable 'napi_id' to silence this warning
> > >   226 |         uint32_t napi_id;
> > >       |                         ^
> > >       |                          = 0
> > > 1 warning generated.
> > > 
> > > Presumably the compiler can't connect that fact that (!preset.id) ->
> > > error. So maybe initialize napi_id to 0 to suppress it as well?
> > 
> > Thanks for the report! Can I ask what compiler and version you are
> > using so that I can test before reposting?
> 
> Err, sorry. Haven't had coffee yet. I see you mentioned LLVM=1
> above. When I use that I also get the same error.
> 
> FWIW: I'm using clang version 10.0.0-4ubuntu1 (which as far as I
> can tell is pretty old). I'll see if I can get a newer version just
> to make sure no other warnings appear.

Hi Joe,

If you are still looking for recent LLVM toolchains, I suggest taking
a look at https://mirrors.edge.kernel.org/pub/tools/llvm/

