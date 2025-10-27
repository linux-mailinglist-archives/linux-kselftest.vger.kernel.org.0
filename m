Return-Path: <linux-kselftest+bounces-44133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE052C0FD03
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AF804F6DF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD9D319867;
	Mon, 27 Oct 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNv7Tnmo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55E3164B6
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587758; cv=none; b=Qf4aiRhVRsD8+gvaSiAz7fzZGoprsZMdrr81x1wdK2Ay5MV637s2hvjFu/sAr1eIs2ruLxWAA3uxabzcYoExwNABmmdOzNVZkwqsIGzi77B9gYeHmJYPOr4hY0R0izpOW0oov8XZB7B6wDv0Qa1QEe0mRUOUq8ftzsTh4CsTTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587758; c=relaxed/simple;
	bh=s0NTkuxgo9nTW1wwUPyDTmWbVEsjdGmA1omaFkoHwoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0IZvmxRiLupzFPmhnhM5sU3fs/mj41zIx6FI0p1kNc/N2BnfACSpJCJw5vaGANghw9vBb5cjQdmBVW3c5YR1X1qy+LM/Jf0zCfFSooFxvnsJw1jN9Vl6JPqgZqafsLrqGhlCQTpO1hTl3+hljas2G2oeRfLALHVS0D2FqPgKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNv7Tnmo; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7861978aca2so1072427b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761587754; x=1762192554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t90v++bIrJi1Md65JkXT8gm2ApX72FdJn0ubPYfRRrY=;
        b=NNv7Tnmo+Azwrh0iUS0X2c0KZzVe6HOnkbfCcP3tFCY4MGEDOpb3X4nL4ifDr45dA0
         EUcN5oQ6VdOxfOzZLS54nVnP7eXTd1Jl7oUrQiNbUlz+b/vF5XilYSc2ERfpX/LW4dNa
         d9XEAbxlFydDrVh9Lps/H05SNJhrQxRcPXwmPu3Pgy8CAJlv18lbjo6Tfsb8O13GSxEP
         6D4zYfFjd3xfcWtsB8QzTFIWhXKR74WsX6ZB9NNWoCHvGdf8QqJ6014YOcZ99tSrLIZu
         rfdOBSw9WQyV+L9HTcgBnzvs33YsBCtPg2Tt6crbteGRjvBwwpTbAoObyHN/kkBOPcbT
         /GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587754; x=1762192554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t90v++bIrJi1Md65JkXT8gm2ApX72FdJn0ubPYfRRrY=;
        b=dO2absf8m1bUQ5gFyOunB/JOVOvUhzv5+1hH0KpvZ3dmimHwsjBTH5Dt2QrTjBRWoi
         QR/K4qi0K4W9rFGJbugRiAMgpoEQj0FJdHfujEXXBAGD2Pdon3cYmnqpFo5aMZRsMo1H
         Pz1uPzdAJpYnlF0HiKqvgRB1vRwI+LvKO2Z5qO1KXOsWM9CM8JPJu4bi89hq/NjKmQ8C
         gBjMar8pxa+LB1H2PNJhe9megrSp2svf2fLHH9k1JaKhPSOMd6utpJY+bt+e9J9r2d0g
         3kuLoMQ8KtUDsvqBYEBGO7C2P4+39SCYmFANXl4Zf3+kibISUJ18uUvtlzOayuYBsdlh
         rgew==
X-Forwarded-Encrypted: i=1; AJvYcCVQ83PLx7XNPaVLlIhcuJckEUJy5UqT0WUgIxdgraQFoqbf6I+kVluQjqW4It+hEJpI9LcyDPbKsAcJGyCeiqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk95tiBE6HvdeIM3ChbC82u3LkgQXzYxFWQPGdurXIgTRFD1qF
	yq+NbDbcypba1jbILdOgF3VbbfvPu03msy738lQFL3qukoZR1AHHCMlI
X-Gm-Gg: ASbGncsyL+5P6ky2TktUP8INa3eHnpmx0YgMf61W2wWejzKr9VhMEiwJ4qiZZt4vsb7
	crvj9tufqlz6NUGbdXpcEpYAnN4q0EbI2z9/gLLxgs0ri97zexGqtgonPtIqfBkYojDz2NclAIk
	mYJWNlDvQTwB/Irabi2dzPCKMIvY60enFeJBpnHryQXafK80vY8EOqPwaWQqV+kwH0GS7rha0Ls
	IF5iXH//x9FmSVSrucu5s3BXG43NvbsIzycS1XhLcQWPj7FHYxqQd/PeCyxEo+LFBlS+iONPD4T
	ASdNBTtdZb44XEbp/1/vi7uVB50doWsvYuEclXh88Qlxpv1GauWecXOZqeD5rKVDvrB9TA3Lt4s
	qhyPg4XxOPJKF1xqsPpE39F9HHX5v6EeQ72tEwnI+4mzldsNTg96ZCoKSU1QX+oOeZh4TkrVOWQ
	OGTsypTCqO8iZReZliExJ5vzM3U3FV86oXoiosIH1qM2fJYgc=
X-Google-Smtp-Source: AGHT+IEnq7T6tW6sESfh2/pS/VtVB6j5wsUZrO0cK7EA3RoMmtv5EedE7kUOtkxVYgtnLyJeX69FZg==
X-Received: by 2002:a05:690c:3510:b0:781:64f:2b74 with SMTP id 00721157ae682-786191bda08mr3102477b3.29.1761587754496;
        Mon, 27 Oct 2025 10:55:54 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1f2457sm20784977b3.58.2025.10.27.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:55:54 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:55:52 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 02/12] selftests/vsock: make wait_for_listener()
 work even if pipefail is on
Message-ID: <aP+yKDYZR6+/kzI2@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-2-edeb179d6463@meta.com>
 <aP-iXJQVPBCjfPHi@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-iXJQVPBCjfPHi@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:48:28PM +0000, Simon Horman wrote:
> On Wed, Oct 22, 2025 at 06:00:06PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Save/restore pipefail to not mistakenly trip the if-condition
> > in wait_for_listener().
> > 
> > awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
> > exiting upon finding a match causes false-positives when the pipefail
> > option is used. This will enable pipefail usage, so that we can losing
> > failures when piping test output into log() functions.
> > 
> > Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> >  tools/testing/selftests/vsock/vmtest.sh | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 561600814bef..ec3ff443f49a 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -243,6 +243,7 @@ wait_for_listener()
> >  	local port=$1
> >  	local interval=$2
> >  	local max_intervals=$3
> > +	local old_pipefail
> >  	local protocol=tcp
> >  	local pattern
> >  	local i
> > @@ -251,6 +252,13 @@ wait_for_listener()
> >  
> >  	# for tcp protocol additionally check the socket state
> >  	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
> > +
> > +	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
> > +	# an error, causing the if-condition to fail when pipefail is set.
> > +	# Instead, temporarily disable pipefail and restore it later.
> > +	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
> > +	set +o pipefail
> > +
> >  	for i in $(seq "${max_intervals}"); do
> >  		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
> >  		   grep -q "${pattern}"; then
> 
> Hi Bobby,
> 
> I agree this is a problem. But I'm wondering if you considered
> moving the pattern matching into the awk script. I'm no awk expert.
> But suspect that would lead to a more elegant solution.
> 

I bet you are right.

Playing around with awk, I find that this seems to work:

$ pattern=":$(printf '%04X' ${port}) 0A"
$ awk -v pattern="${pattern}" 'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0}
	END {exit rc}' /proc/net/tcp && echo FOUND

I think it beats doing the save/restore on pipefail?

Best,
Bobby

