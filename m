Return-Path: <linux-kselftest+bounces-2903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236D82BBF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 08:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8FA285999
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 07:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00ED5D72E;
	Fri, 12 Jan 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns5wnlEi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F25D727;
	Fri, 12 Jan 2024 07:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A626DC43390;
	Fri, 12 Jan 2024 07:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705045509;
	bh=QDKvLfHcVgDLq23uE3D+65a5GLHkyMlCz9HrxqSl/UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ns5wnlEiKkgmTVCBcmxcjJL72keAjJOrwRSc3yjtX/gZgBJwvKMIvYcTACWw5Iw9B
	 DzHXIfWKpA4MsG1TF58sD/Mgd8GVWLcHqznM0cI9pINBpbtCmquXZx1nj6r3r5ZYRE
	 3EMAdjdud2cGaaFWALMJm/fOL/r62Ncari1Ju1TRL03qwx4sNbLoL90K9xVqmqbfUM
	 XLdUMuY4fYInCOn7rSBa8mk2yQFT6V02LbiWuxMJoU+yLk61vWliiDyON8NVeNu/U7
	 iWN+lMSl76INE58kgY/wSijVyR+TbIYg2LbxB87c3RL1ZpM6E/Kb6EG6yAnBM/UPOp
	 v48RTzaktkzwQ==
Date: Fri, 12 Jan 2024 13:05:11 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] selftests/ftrace: Add test to exercize function
 tracer across cpu hotplug
Message-ID: <fseaxfxqh5xjbn23mjpgev33zpkpfthbcwfd2hset5bxtznt4k@2cxci6mcnqyl>
References: <20231213113802.1278600-1-naveen@kernel.org>
 <20231213215450.792f5e6f21eb3e709f4ea05c@kernel.org>
 <20231213100629.338c358c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213100629.338c358c@gandalf.local.home>

Hi Shuah,

On Wed, Dec 13, 2023 at 10:06:29AM -0500, Steven Rostedt wrote:
> On Wed, 13 Dec 2023 21:54:50 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Wed, 13 Dec 2023 17:08:02 +0530
> > Naveen N Rao <naveen@kernel.org> wrote:
> > 
> > > Add a test to exercize cpu hotplug with the function tracer active to
> > > ensure that sensitive functions in idle path are excluded from being
> > > traced. This helps catch issues such as the one fixed by commit
> > > 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
> > >   
> > 
> > Looks good to me.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Thank you,
> > 
> 
> Thanks Naveen and Masami!
> 
> Shuah, can you take this through your tree?

Can you please pick up this patch?

- Naveen


