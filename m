Return-Path: <linux-kselftest+bounces-1845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4F8115BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 16:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1205B2811E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26F2FC40;
	Wed, 13 Dec 2023 15:05:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CF2F505
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 15:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7368BC433CA;
	Wed, 13 Dec 2023 15:05:45 +0000 (UTC)
Date: Wed, 13 Dec 2023 10:06:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] selftests/ftrace: Add test to exercize function
 tracer across cpu hotplug
Message-ID: <20231213100629.338c358c@gandalf.local.home>
In-Reply-To: <20231213215450.792f5e6f21eb3e709f4ea05c@kernel.org>
References: <20231213113802.1278600-1-naveen@kernel.org>
	<20231213215450.792f5e6f21eb3e709f4ea05c@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 21:54:50 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 13 Dec 2023 17:08:02 +0530
> Naveen N Rao <naveen@kernel.org> wrote:
> 
> > Add a test to exercize cpu hotplug with the function tracer active to
> > ensure that sensitive functions in idle path are excluded from being
> > traced. This helps catch issues such as the one fixed by commit
> > 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
> >   
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you,
> 

Thanks Naveen and Masami!

Shuah, can you take this through your tree?

-- Steve

