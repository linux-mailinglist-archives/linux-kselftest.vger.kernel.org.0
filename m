Return-Path: <linux-kselftest+bounces-42321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBE6B9F4D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 14:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB274A535D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7451E1B0F23;
	Thu, 25 Sep 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzKo123o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CA1A314D
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804054; cv=none; b=aQC+smzz10+aqYoIcT4fUI93MNhxXQNGJn433GSATeQUgwOD3r8FOvttBDpNBULvccEdSD9Y7OEXDlc8RMuYzCYVbLXuEj1lMnCaPripcwQ1QEm2aMPO6fh1r/0/kFZN9AKF60v2NSsJg6f0L7oirV4gIgpXHBB6YBMW3yo3/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804054; c=relaxed/simple;
	bh=VXON1v7RvXA7Y4H/9zywjlqD/4OXJyQ9u4H3dPvrN4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmJpFVfMvdWMcBlKeJtbrVvgo8WbO59CxndvMEEKodgoApT3w6l4+oob7MaTN/IwPKNurfexIiMQW4sD4zPS1FEcrbEdPPxKRP2s8WcAtKiDXi04ixN/208v6EK0tJXkZBTo4oNpQaL2vQ9j4/C6y71UNYMYS+9eGV034JQozU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzKo123o; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3331adeadbso273583466b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758804051; x=1759408851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4iZfEG4kVECR3QGnQozF1ONlvbS7K+/HZuIx+Nym7I=;
        b=mzKo123o4mA17/bqhXtbHWqZBbRW5bi7sjPdCyD40EEOLSaQ31nZeX1S7JfJmEg9Hw
         cZJpnnrTFGZ8o/MEnFiMSnWrBYRwn5Sakn+WjXyKySbF+5DP87a9wkEb6njD5yvmLgiP
         vyZ+SEICL8SHPi9J0WxNUm6yG/9Hnhy9wTd9Z/LPXVxIkryKtemptmaApy1o3Al9M7hi
         50M4ej39G4lMY/Bqi1N8QeHkMzG5Irbi2shA+6Fz/SDiPTPcEyl8N4pPljjwQsu2+DkO
         zaWolASy9P+6Nm3eFW6mtGxIU8PRaT7000FHU7hPVC08pKkphDFvkFS+j+H7rq+ZPO2h
         YSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804051; x=1759408851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4iZfEG4kVECR3QGnQozF1ONlvbS7K+/HZuIx+Nym7I=;
        b=k1YGuqIwQTUreYvEqbRYQq3Ynw/yAgJkpBVYf6X4DtadqdRKZ5X3MwfOlynBXVlxr8
         YrswFP0SfOVqVoGOwQ1HP/6+Ha2kt/hoC0NZEVUpG4vRkn+tXY2TY7gG8b1TgIKlUojR
         pT8hiy6/FCa8elrV7gLbThwl9FUHC5r3s1iO4BnrKwp5X5gs4m23n7088EZlfjnt3TvK
         hfT+PtSAEwMlqOFuECS51xzzeQRbl0xuXqX75EZ6+0caJTJUiiYQjKRoH9usuFDU2OdK
         UkKm1BSYXIgok0VaqfxqC/M0bvfMhBMCpWWX0VwS4XrJu1KIlKx/KkNdWHKfsl5ah/zf
         usiA==
X-Forwarded-Encrypted: i=1; AJvYcCUYFHBwKzf/w3QkMDcsqGFveCZWsASamFdHMN4JJQEnrUP8kVLyAvxf3H682ZkjPRQ9y5chf6p4W9vB5HsUNvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzRTYjTb4YJcImjRGyDrbq8hfz9g9DBNofoOucW34penwN6lr
	+nvgHWwP/MM0ld/Wj/pckddAW6EhpENfI/ZD8zPMzt8h2kI+v1ApZt0+pDSrNOQB
X-Gm-Gg: ASbGncvbDRMZWBDYuGkQMvFkeCvu8MSKNMM9dNozh64ojgKahhRhZap65bArsiqcVFi
	H9hkZIUtP3LHi1nzseohE5iMPVbGXt6w9ap8d8pTI8CqCa8jSv6MsXxGd2OLnfVklvLxGeUf6tJ
	fd6tVuli+fGS7QzAB68zOfffjbsgVdLhoiixcNUgrSXUaHSwrALa9OhP2XMh+atY38aUetVB4VP
	WdQhCsI7yfRVLnMdjmH0HmuGYpmPYiHlmVLZJtQL8XqML6q4K6zUS71Z51lMoTwcIs00bsRrVcv
	yhurdl+n15STXjQFbhqEcXloexAfWS6BC4tJo7zo0UH2q6FfFeyIqt4u0MbJcJZMPnqBPDWkIwL
	/H7GDXheS32gK3iD8MmoANkG50OeRD8o2G0XrbWO0NSyXWeeTLKn+CSLnWw+6T5mHRdvGtCJf
X-Google-Smtp-Source: AGHT+IH1zVng8lk0TycVJy+o3g1mDILGx3FJMUy3vX3S9k2pmy4r7gL8isXWlnXBqQz/KWO9gE7z2w==
X-Received: by 2002:a17:907:1c94:b0:afe:ef8a:a48b with SMTP id a640c23a62f3a-b354e41468amr279935366b.30.1758804050688;
        Thu, 25 Sep 2025 05:40:50 -0700 (PDT)
Received: from alessandro-pc (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a98416sm158093566b.102.2025.09.25.05.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:40:50 -0700 (PDT)
Date: Thu, 25 Sep 2025 14:40:47 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: net: Fix error message if empty variable
Message-ID: <ryyvwk64xplpvwozytdsfkyxls7sa3r4p4xpdqfhh6h2k4rdhl@chwwppzuvbop>
References: <20250924230413.75246-1-alessandro.zanni87@gmail.com>
 <20250925104930.GG836419@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925104930.GG836419@horms.kernel.org>

On Thu, Sep 25, 2025 at 11:49:30AM +0100, Simon Horman wrote:
> On Thu, Sep 25, 2025 at 01:04:07AM +0200, Alessandro Zanni wrote:
> > Fix to avoid cases where the `res` shell variable is
> > empty in script comparisons.
> > 
> > The issue can be reproduced with the command:
> > make kselftest TARGETS=net
> > 
> > It solves the error:
> > ./tfo_passive.sh: line 98: [: -eq: unary operator expected
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >  tools/testing/selftests/net/tfo_passive.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/tfo_passive.sh b/tools/testing/selftests/net/tfo_passive.sh
> > index 80bf11fdc046..2655931b2396 100755
> > --- a/tools/testing/selftests/net/tfo_passive.sh
> > +++ b/tools/testing/selftests/net/tfo_passive.sh
> > @@ -95,7 +95,7 @@ wait
> >  res=$(cat $out_file)
> >  rm $out_file
> >  
> > -if [ $res -eq 0 ]; then
> > +if [ -n "$res" ] && [ $res -eq 0 ]; then
> >  	echo "got invalid NAPI ID from passive TFO socket"
> >  	cleanup_ns
> >  	exit 1
> 
> Hi Alessandro,
> 
> I'm not sure what $res can be in practice.
> But as it is the contents of $out_file (or more specifically,
> the stdout of running cat $outfile), in theory it could be anything.
> 
> So while your patch addresses one error case.
> I think there are others.
> 
> f.e. if res is not empty but not numeric, then we may see
> 
> bash: [: b: integer expression expected
> 
> Or if res contains a newline, then we may see
> 
> bash: [: too many arguments
> 
> 
> So I wonder if it is better to treat $res as a string,
> and quote it to avoid unexpected side effects.
> 
> [ "$res" = "0" ]

I'm not sure about the possible values in $res neither.
I assumed it was numeric because of the "-eq" operator but,
if it can be any value, a string comparison would be better.

I'm going to edit it.

Thanks,
Alessandro

