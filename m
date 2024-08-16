Return-Path: <linux-kselftest+bounces-15514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8478954D2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AE71C21897
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EB41BE23D;
	Fri, 16 Aug 2024 14:50:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FF1BE227;
	Fri, 16 Aug 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819837; cv=none; b=rdVNOzw9N7wqPUbH7vGge8egCjQiZmNTxTgIbq3X02JrR4tXgi7vLrO2t/jgY9yEOCdzgUJKfn9EZVfW3HUwS3h2f31H0RhFJ9nhWz0d6/btNFK88SYUHFRZZxxCnVrSYXbPKdU8YvFr22+GqmYKLX9qf4K0wPeuD57baf3RLDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819837; c=relaxed/simple;
	bh=eBoT9mHnDEYNWbfyadzLnfSTUlg88qznghVjHEnGjoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5XVmK/j/ilidChMiOj/lkombIh2tE5a0/BGbez4+Qj66vmN8FzUZc5vPcMOQgXpT8wLVGx4+ZYRuOqYiXoYqnf/3khzSZe6oBPvvad3oNPdcvjQouDRY5KltA6SztGt6FjWMqCzrTnXED5uDaA1x1/ruORM1CCjfizxwm6fOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so80681a12.1;
        Fri, 16 Aug 2024 07:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723819834; x=1724424634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUA2d/1y4mfr6AuFj1uEEZ1GzNQmbmFC00Tg3yKPBf8=;
        b=MRsrR2NDdwC1X+Vr5Y14/jWlQolaIEvsMcBrpkoFAZLajRJpEr5pPk5NlrZqjMx54V
         W8j7/eaClvNUe7aB/CRQys2gQBfZ2oa70wQE4G9JtMaU25TtQ0lO6XDsZ7oqd8yodcyg
         diLRWyEWbp2IHmdD+zH4RDcgzegFR8Dv33O7JNqzrYT6FTqak8asHWZt9ojEU9fiO4zW
         e7nr94PB+EoVgemiXL39Yr39oOPwia4PNOWsJYXWuTpBZ/dZm3YcZRJMP3nRoIKw+1Wk
         E1hVQzbPy5N9z6wyI2NW+MGzeV/051An95Fn6CUp5CVTorml2p2IvQ79wzqbn+6uD6ir
         27qA==
X-Forwarded-Encrypted: i=1; AJvYcCUav4TDpsncZnXfyMsJY9zRohbj8ooJie4jUFH7LYwzBE5FW+JRxmLZWSibvJKVZ2ybLzRnIvnfEREAj3eWgWIVFY1qpZxVzMEjWDohgpYJ4attoYrFTBilPNUQBBRSbiB5JEnXzVJAvmmpf5cEy4Gp8/VdKL5vexgjs+zej0WWFuXX1vjq
X-Gm-Message-State: AOJu0YzVANvsvoR1Ud/OrQOJr0yQdUGZ7J5dps6f26TPX5z1aHgP/hBh
	jXule+kv3b+dWbz/UiqjrT5YzPBF7xaBxbJSot7D7XXhUKpuP45A
X-Google-Smtp-Source: AGHT+IEUwBIAA9oSte3H/Y6Jvhdn0QDDlhtFHetUMF8KZGSE/oW7YXVYlZHU6dV5KdpoT2Yxr37+uw==
X-Received: by 2002:a05:6402:4006:b0:5be:d595:5413 with SMTP id 4fb4d7f45d1cf-5bed59556f1mr1609784a12.3.1723819833180;
        Fri, 16 Aug 2024 07:50:33 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081cf5sm2320189a12.90.2024.08.16.07.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:50:32 -0700 (PDT)
Date: Fri, 16 Aug 2024 07:50:30 -0700
From: Breno Leitao <leitao@debian.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, liuhangbin@gmail.com, petrm@nvidia.com,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>, David Wei <dw@davidwei.uk>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <Zr9nNnAsqpmPnQOx@gmail.com>
References: <20240816132450.346744-1-leitao@debian.org>
 <cd9473bb-36d5-4b62-8523-f9112dc176f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9473bb-36d5-4b62-8523-f9112dc176f2@kernel.org>

On Fri, Aug 16, 2024 at 04:02:51PM +0200, Matthieu Baerts wrote:
> Hi Breno,
> 
> On 16/08/2024 15:24, Breno Leitao wrote:
> > Adds a selftest that creates two virtual interfaces, assigns one to a
> > new namespace, and assigns IP addresses to both.
> > 
> > It listens on the destination interface using socat and configures a
> > dynamic target on netconsole, pointing to the destination IP address.
> > 
> > The test then checks if the message was received properly on the
> > destination interface.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changelog:
> > 
> > v4:
> >  * Avoid sleeping in waiting for sockets and files (Matthieu Baerts)
> >  * Some other improvements (Matthieu Baerts)
> >  * Add configfs as a dependency (Jakub)
> 
> Thank you for the new version!
> 
> It looks good to me, but again, my review mainly focused on the
> Bash-related stuff, not on the netconsole test itself.
> 
> I just have one question below, but not blocking.
> 
> (...)
> 
> > diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
> > new file mode 100755
> > index 000000000000..5c3686af1fe8
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
> > @@ -0,0 +1,249 @@
> 
> (...)
> 
> > +check_file_size() {
> > +	local file="$1"
> > +
> > +	if [[ ! -f "$file" ]]; then
> > +		# File might not exist yet
> > +		return 1
> > +	fi
> > +
> > +	# Get file size
> > +	local size=$(stat -c %s "$file" 2>/dev/null)
> > +	# Check if stat command succeeded
> > +	if [[ $? -ne 0 ]]; then
> > +		return 1
> > +	fi
> > +
> > +	# Check if size is greater than zero
> > +	if [[ "$size" -gt 0 ]]; then
> > +		return 0  # file size > 0
> > +	else
> > +		return 1  # file size == 0
> > +	fi
> > +}
> 
> (...)
> 
> > +# Wait until socat saves the file to disk
> > +busywait "${BUSYWAIT_TIMEOUT}" check_file_size "${OUTPUT_FILE}"
> 
> It looks like your 'check_file_size' helper is a reimplementation of
> 'test -s <FILE>', no? Can you not simply use:

Why would you like to do it in one line when you can write a 15-lines
function that does exactly the same!? :-P

I will send a v5 with `test -x`, I will just wait for more reviews.

Thanks!

