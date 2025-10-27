Return-Path: <linux-kselftest+bounces-44122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE32EC0FA1B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DABC4E652B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CC311C38;
	Mon, 27 Oct 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3RNxoTo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6E27A47F
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586124; cv=none; b=OEEi1LjP8VhDb/d4MmCLKX8xT9AeNa/czd1I1S2S3RkgeaPt+u1kRZijDU++sYeYH6+cAuN74+v4wKdIwIf4yUc7aHVVXVyrHh24rIM9nzj3jxT/r0U5Gx1HfHre1BXwAm4P+kY5tyHxa6xYzhPwT5pvX/NOuEgKoHpCw62pj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586124; c=relaxed/simple;
	bh=n15GkVGRlM82y8bsXWGWKv4Ru0ouDE1mhKQda2Lxd3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZND0E3wzzEfaL73kx45GIrbbM6f4yYBLPKFp7ZQUb+ktEZ1Kf0cUw7iXkUfJ+Fdls8ApTohcSXxXW0NjK4aBup2Pt/bjn8KloSqkzEyGYrl8ynlfM3Y4PRiOvT2EKxcmRvy84NiXMVl+YO1EUoOBCmz3Z7npoaDZXO51zCDw+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3RNxoTo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-784a5f53e60so58755637b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761586122; x=1762190922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKbTf0ElmduUelZrYEJiaRrNvJO3TsTMSPfSoF30NGQ=;
        b=W3RNxoToAcmeXPfx5Lef5kG3LqvhP2a+x4eCRJPsXpSfbugs5gw9pvySwndsflcKcg
         /SrF0fVltryWnZcR6D4Bs4EWseD+5ykSuK/w6UAdRfwPZXWIOGzB3i7AmttfXfPdQeGH
         ku9Gv0V3No0+pBOG6Tya++NPkhOG+m5zS+31mU4GPUR09KPCnJgiqfLnddZQdia1KPU2
         +GxBaZ+qiLqBpvxfhw9YsvfIxsp637zlJnMfCL/jOUW9HrjKU1BqOFjvifVX7YmipqRM
         E3aDLz5nLDvmsLKLY2Jx3XItKcViG+Q6SnACPK+9QWTvXChaG91Ae6Raq40cafssBS7s
         q+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761586122; x=1762190922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKbTf0ElmduUelZrYEJiaRrNvJO3TsTMSPfSoF30NGQ=;
        b=dOnFwAYcDr5OEPIAtgyO0DsbC1QqgEooOheCBwf1lOhe56hiQIOhScjQQJ8QRRpAuP
         IJqyck+j/8v/O3l1IuSEv+bWCFrTK2mV8Watt25RvhMSjH/CWN4u0xAvewPS/JFO35dp
         jrDD2zEGgpnx3vsyGnmLPF+UFnTcshHxHoh18LwAs9M8LSPzWxDIvHe5I4WchBasW1wo
         wlKaJR0eHL5Ac2n1HN+3CEW2l9HBkB3JjgXJwW9tHkriBIHNlKVYqPw3q76OAJ6flI25
         lFYVOOSP1ETGNOY/SsAg/9NqLihigDMewxra85iAPPMaCCK+Jwc9RGA/jYjITZba5i07
         NthA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Zr876jqj+4iQHhGhu3wrw8hLDi48puw71zrEzIO33sBeb1hCx8Y+i+kNvFUdcpDRUCLi9lMjRrP5FAovWA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1UdI7/OXS1tdR1Biq+/TMAgI1zqMrCUaG0OMUbq+agbFK3G0
	fiGKPczxuZ9SgQsVZ4FTRNc7EdD/i+DgSskbGDHsNK1D6CAZTtfw4brd
X-Gm-Gg: ASbGncuN86n/WyT2Q24wlhnGThRoSExdnbMwRXKjGpnXrtcfi17uoqZ4gcDb6/3q2ZL
	2a5Zi4/eEPEQ+SO9kny4Js5sfnslA8oIBZXxGTCzdTOQt2I1T8j5Ww4FD9bERWeF6MZK3GWfG3s
	brRpTpvv9U5D6rc8QnkZIsFy0D23hJBKf5aK8lZz4X7Vm9HuPLE+Rpl2x0qBava0nsts1/9oWMM
	xP1G0LJlLqnG4iS3HylQfdjOEf9+tMuIp9WCQMtF8kA+agu1BB4b6HwjuwUEJ7r7bNTDXBrJZiS
	wEPyIAV/99K9HFHcUQkmuAj0dZuIlD66wKtVMmeR5CdQhyECCxBbcQSY9pNXO7DZlV3MBxO4pmG
	GjqcSInM6i+GpKjVeimKVE5yXj8ji30AQHcaUscnugrYgJzxMErOkR8YuL8x7lgmH/ylO/rAPft
	RiiMdl/s1hWjeiBT4cmblygWJI/eBN5VTKE+B0K5M3uOe199c=
X-Google-Smtp-Source: AGHT+IHM1NI9jlgl7YyHEw6xfZ2NvWKARzYo9jjqycdlEoc48MLVHrBBixAozXkHMEqVBYRHZIgJww==
X-Received: by 2002:a05:690c:9312:b0:785:eb11:647b with SMTP id 00721157ae682-78618357840mr4674427b3.33.1761586122152;
        Mon, 27 Oct 2025 10:28:42 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1a4391sm20417647b3.33.2025.10.27.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:28:41 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:28:40 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 01/12] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <aP+ryNxS2A45WT7f@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-1-edeb179d6463@meta.com>
 <aP-hpxMgB5tN7KJ3@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hpxMgB5tN7KJ3@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:45:27PM +0000, Simon Horman wrote:
> >  log() {
> > -	local prefix="$1"
> > +	local redirect
> > +	local prefix
> >  
> > -	shift
> > -	local redirect=
> >  	if [[ ${VERBOSE} -eq 0 ]]; then
> >  		redirect=/dev/null
> >  	else
> >  		redirect=/dev/stdout
> >  	fi
> >  
> > +	prefix="${LOG_PREFIX:-}"
> > +
> >  	if [[ "$#" -eq 0 ]]; then
> > -		__log_stdin | tee -a "${LOG}" > ${redirect}
> > +		if [[ -n "${prefix}" ]]; then
> > +			cat | awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
> 
> FIWIIW, I would drop cat from this line.
> 

sgtm!

> > +		else
> > +			cat
> > +		fi
> >  	else
> > -		__log_args "$@" | tee -a "${LOG}" > ${redirect}
> > -	fi
> > -}
> > -
> > -log_setup() {
> > -	log "setup" "$@"
> > +		if [[ -n "${prefix}" ]]; then
> > +			echo "${prefix}: " "$@"
> > +		else
> > +			echo "$@"
> > +		fi
> > +	fi | tee -a "${LOG}" > ${redirect}
> >  }
> >  
> >  log_host() {
> > -	local testname=$1
> > -
> > -	shift
> > -	log "test:${testname}:host" "$@"
> > +	LOG_PREFIX=host log $@
> 
> shellcheck suggests keeping the quoting of $@.
> This seems reasonable to me. Although in practice I don't think
> it will change the behaviour of this script.
> 

Ah right, makes sense to me.

> >  }
> >  log_host
> >  log_guest() {
> > -	local testname=$1
> > -
> > -	shift
> > -	log "test:${testname}:guest" "$@"
> > +	LOG_PREFIX=guest log $@
> 
> shellcheck also points out that log_guest is never passed
> arguments, so $@ can be dropped. If you prefer to keep
> it then, as per log_host, it seems reasonable for it to be quoted.
> 

Quoting it sounds best to me, in keeping with log_host().


Thanks,
Bobby

