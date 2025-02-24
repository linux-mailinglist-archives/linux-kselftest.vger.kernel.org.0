Return-Path: <linux-kselftest+bounces-27375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2D3A42C99
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 20:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F1C3AB77D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 19:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADB1CBE8C;
	Mon, 24 Feb 2025 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="szA2t9NL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA316CD1D;
	Mon, 24 Feb 2025 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424893; cv=none; b=WMKVXyl5jNSxsXSrSWfCl4bgTDPIXapYCOj4OXsHQ2itQsFXmRPUjrPXTIiV+u5zUUfHAlJ/SSYINxV1ssLZEGO4m7F+MzqA4KrzcrAtwvBaeaWlbkPDvGfzqkxgn9gUuMIypDdTx4peWTlVWw/6ahm39iHA8ht1j3P+XeQyp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424893; c=relaxed/simple;
	bh=r62V08DrRzjjK54gPBNqoYsEgdwtSOiF3QghmfM/F/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY4N+29JBZRHddSRwONJX7bzAGZHqcGdHuDjrqNiDPHrJ7FzeFqNq4OLst30yblmXdTF4fQRjVS/b1tophdajoFyIbbRUCIeZLsy1id7muukHTXI6YL0GlKMNs3pAsclYt7t07L+ITOnaHdkrkN5NmFvrfwPIAGyao2biDeboGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=szA2t9NL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-beaub-VBQ1L. (unknown [4.155.48.115])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6D65F203CDE2;
	Mon, 24 Feb 2025 11:21:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D65F203CDE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740424891;
	bh=YDfwX9E1hJkSh8xAHhzeNn6UhO5C3v6ln9dld99jH7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szA2t9NLnwELCstDp2cTAqq+d2J7ySsKHxiS6Xh6+9F2faS057XZGd3gEto/yzOiy
	 GPktbvcFA3M1/jRfP48c4SvLhzzIdjjdJWA2ofgIsCZRWM6J2BB20mJHTlpk1+qggo
	 uEii0GV+5BGQeqZuOECHHX9HezAfKSsYpf8a180A=
Date: Mon, 24 Feb 2025 19:21:26 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, realxxyq@163.com,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yiqian Xun <xunyiqian@kylinos.cn>
Subject: Re: [PATCH v1] selftests/user_events: Fix failures caused by test
 code
Message-ID: <20250224192105.GA48-beaub@linux.microsoft.com>
References: <20250221033555.326716-1-realxxyq@163.com>
 <b62b6dbf-eeb1-495d-a86b-38f05a17d60e@linuxfoundation.org>
 <20250221122842.379198f9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221122842.379198f9@gandalf.local.home>

On Fri, Feb 21, 2025 at 12:28:42PM -0500, Steven Rostedt wrote:
> On Fri, 21 Feb 2025 08:46:31 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
> > On 2/20/25 20:35, realxxyq@163.com wrote:
> > > From: Yiqian Xun <xunyiqian@kylinos.cn>
> > > 
> > > In parse_abi function,the dyn_test fails because the
> > > enable_file isn’t closed after successfully registering an event.
> > > By adding wait_for_delete(), the dyn_test now passes as expected.
> > > 
> > > Signed-off-by: Yiqian Xun <xunyiqian@kylinos.cn>
> > > ---
> > >   tools/testing/selftests/user_events/dyn_test.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
> > > index bdf9ab127488..54c9412f8dee 100644
> > > --- a/tools/testing/selftests/user_events/dyn_test.c
> > > +++ b/tools/testing/selftests/user_events/dyn_test.c
> > > @@ -127,6 +127,8 @@ static int parse_abi(int *check, const char *value)
> > >   
> > >   	close(fd);
> > >   
> > > +	wait_for_delete();
> > > +
> > >   	return ret;
> > >   }
> > >     
> > 

Thank you for this fix!

> > Adding Steve for review.
> > 
> > Steve, please review the patch. If you are happy with it
> > give me Ack or Reviewed-by if you want to take this through
> > my tree.
> 
> Actually, Beau should review it.
> 
> Beau?
> 

I applied it locally and ensured it passed (seems timing related).

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

-Beau

> Here's the patch: https://lore.kernel.org/all/20250221033555.326716-1-realxxyq@163.com/
> 
> -- Steve
> 
> 

