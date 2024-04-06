Return-Path: <linux-kselftest+bounces-7329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4503489AAC9
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 14:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A191C20CCB
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7182D05E;
	Sat,  6 Apr 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvXAWZAu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7282CCA0;
	Sat,  6 Apr 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712406994; cv=none; b=ifN9y3aM/lPu4YlIeYjS8feMVhn0sxSgoz3xJuFNpN96+diyi3hpyvEML238eeFl5Vd0wX84xX+5Wb9+OmWmpAB7W7JFR8Y/hcqImSc5Aer+zR2tzG38sG7oc66gUxYMoOwZhn26dz0vUBgPHArOgc/cOUQGt5EdP6AUlfUkdqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712406994; c=relaxed/simple;
	bh=QPBTr00SK0kSTFqmClVhMGkpM+Rdxk09fOhF4603Gj8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T1IWXr8iRKrH7db7MTxMSXReV+PofpQBQ7tfBSj5d4WOqivnXzjt2poCQTi8h4CC7RXDhy00KpLDubw1j3g7wTforHei69dZrmul0Wg/fGlpMZMXjCpyuvI1VbTSV3SCSoHzdn56hzHgOYSqXOFurQtHpt2FH+1NJfyqlInJPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvXAWZAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F46C433C7;
	Sat,  6 Apr 2024 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712406994;
	bh=QPBTr00SK0kSTFqmClVhMGkpM+Rdxk09fOhF4603Gj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvXAWZAuujdD31Z7AC56BVm8Kaqw5OSCGuDwrzCNfwRECBBQhVqJ4fh3bNfO4Shuz
	 0C3ejYZ/Cw0S6Wwww6hAEza0RyqysOBi96JPe0Jxf/yhPazuS1Zvu6vXBOHkrvd4Gq
	 4sEYRo85CyiDLP97jss7fPP9kyEQ1VXeI6jdH+Yd8iOu00N7dF71uJVrsV2Pmb+M5D
	 haLCMQRCjJUEkJuPil/x9s7Da+omcTf6UKk1ASH6MapRNcGv5asP92bgUH6W6fi8Zu
	 8FJWE+EZMgBzF/CcR09uMltiQY429kmiqudqoxvOFCJ87xHCW2Otcs8OdCjg4HWAeh
	 D1l1CGhqj3aDw==
Date: Sat, 6 Apr 2024 21:36:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan
 <shuah@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Aishwarya TCV
 <aishwarya.tcv@arm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing/selftests: Verbosity improvements to KTAP
 output
Message-Id: <20240406213628.007e67c8374c45d488bc897c@kernel.org>
In-Reply-To: <39f406e4-685e-4371-8726-c7df02299295@linuxfoundation.org>
References: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
	<20240326120809.09574951@gandalf.local.home>
	<e2c68911-9b49-4080-b827-3b139b4f3257@linuxfoundation.org>
	<39f406e4-685e-4371-8726-c7df02299295@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 10:32:33 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 3/26/24 13:11, Shuah Khan wrote:
> > On 3/26/24 10:08, Steven Rostedt wrote:
> >>
> >> Shuah,
> >>
> >> If Masami is OK with this, can you take this through your tree?
> >>
> >> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> >>
> >> -- Steve
> >>
> >>
> > 
> > Yes. Will do once Masami gives me the okay
> Hi Masami,
> 
> Are you okay with this patch?

Hi Shuah and Mark,

Sorry, I missed this series. This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> thanks,
> -- Shuah
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

