Return-Path: <linux-kselftest+bounces-45368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7B3C4FCA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 22:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA17018C0B35
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8935CB92;
	Tue, 11 Nov 2025 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMZ27BoX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16899352F9F
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894917; cv=none; b=TgwjRD0tAaxLW3uOQLlB1WoDz4oT/OtmH7oglqFVRhCYQGDtv/M6GYXiwyRs+CTB1mm28jqtFA4X0W/+YEaV3N/qEYsJYTpGCWwKlhB9zuOupOvuddWu/VDMmlzs/XReLzjS8JB44HN5P4TpU2qzub/c9waM/22IQpMgnLHn8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894917; c=relaxed/simple;
	bh=m2/ll1uTQe3vdYyhgsBOhN/isiT4ncOezX9iuBFvWf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtGLQmwTGy9lcbBtk4lgKhGYjDY5Y8p4ysW+x84nGV0x18o0uoyqob5jWZZb2/wIQv50ouqznwGuJlL0egIbrBMAIRRrl9z1AZL4YhBvQ39qmnJ2L7Dv94qNcPYogWhT69YVN/cl7xHXXCVBR7+v41YSjBdKsYOWaIc5KI63mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMZ27BoX; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63f9beb27b9so166555d50.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 13:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762894911; x=1763499711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDPq8KvClJvWwDQMfmOhMgSMTNNkWL2W9UB4UAss5Bg=;
        b=EMZ27BoXyrccnWk6j0fZzJXConxIlnb+YJyxYnU4pvHMuVIow6oNh0p44L4eeNPAlb
         EuU22N0Cu3NLv75bupq/7aQaIC76fv8insPYQvRVpLLgtxNnYfaxq1leWkBbQwLqpal1
         dN2H45GfOTIZMIalPt3j+RAvbeKU5LUk5X4jrrgVx77EbEaniLj25o8hJrBzM2OzXDLb
         6EjMCrvHtPJKTl0XLha4W+sb/tyBJSEidqBbro/8EAwK29bMgtOQYDZxKcG0Ho3RXKmv
         B9Z4B6oHilKtSi+F0GDPzi4IS6pGJKPuoMNThYrWpESSL160+clnPrk3ZeGhyMlHRBO2
         OiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894911; x=1763499711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDPq8KvClJvWwDQMfmOhMgSMTNNkWL2W9UB4UAss5Bg=;
        b=QPWiCrWsuNF7am8qhNFQR+vXRLKkvSgBEd8sFiHQEhpCY+7KXfdFi1m1e20hPh3vY2
         1y3HBlP8H3SDzLx9qip9aWfF00kVwdAH+Kv0UwEkg1m/lFzUcowFLmk+md7rJWwZbEPP
         6iNQGDEtH3yZB2vnRZSTlGEJZpWLBx8LW5TPoVEWT+G1fzWJ/nxsGNecTOy6WMVKxaoh
         aX9WmxjswLCaZtkK6aIN4BMvDajIFz3QXL5d8dSxNgHCDayIQHCpMzwTkRCDuxiR523F
         P/Au/ypuHSOVDX4c/SGLeLNcUrZRjJNGDtQhnfsS9ansrQTmPhq0mIelaI3IaNMH/gfR
         iVgg==
X-Forwarded-Encrypted: i=1; AJvYcCVcBe97OdpqfrULjC59zlez6oJnEcFryJgHoHSxZP00ltZeeATeNpV3AmyDhoC4Hc7tqo0p2VPln8DkLSQS/LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7zlsZtJQ5Hx2OknC1yQYOfzkiwMrhXE9hFOZHksIOhLDks6V
	2n6aRvofazYGMqkozHHCooNR0xuZJ+xXqyXQYuFspnirvEDq1Cwpunj0quphrw==
X-Gm-Gg: ASbGncvARSHXPpmGlaWy8YvOkn4hi05uyXC1wiOsS654sZyIKGoCCnUMH1Yer2fG3Mv
	XIWGO6Vd5mQ7oobXeuD9QxalHxKaOzFkvMzsk0s2a80I1OiogBcDzZDCpBINL/eN7sXLgUqU5lM
	qPXeu4XqUfzrJ0cAwk6o49DFFL3HLMw/tpoZuNOvIPgM0Q43Y3Y8dQgBjtlKyLWMUtGvytBKLyl
	Bt4M/S5j/qL+x+aR9PblPOhyioO93CCSwZLQnNi5ZJU5SXZ7cfxRLbBlow3Ua0qEy2K1RV+DPch
	rch5rLDiNwS0b6QvmXqRLhZnO2+DASiHSV1RNAiPRCTObgRoeqDkffD8odX2QDwp7L4eIReE14D
	Dcz25zCw4ML9h+yIIt0HCfiacfSrgJUPkECAmHDzvdsbATP4mMgtPSXU0urFfkCGujLimOKqfmp
	tI9xqL1Dl78IFr8wle3jK4g2kRmJfKb6Vf0fVXh8gMYX0RmA==
X-Google-Smtp-Source: AGHT+IG5pLwkGsZ+eCK296l8q5rg85wfM1wAQ8NbbJwGyjxk6/mldP/Q7Z6BLYOivEyqJVyS1VY/EA==
X-Received: by 2002:a53:c048:0:20b0:63f:a165:b9ed with SMTP id 956f58d0204a3-64101a0ab45mr674439d50.6.1762894911625;
        Tue, 11 Nov 2025 13:01:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d684218dsm36167807b3.21.2025.11.11.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:01:49 -0800 (PST)
Date: Tue, 11 Nov 2025 13:01:48 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 07/11] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <aROkPIIeGq3Tb0I6@devvm11784.nha0.facebook.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
 <20251106-vsock-selftests-fixes-and-improvements-v3-7-519372e8a07b@meta.com>
 <aRMjeZVqsnc1BNr-@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMjeZVqsnc1BNr-@horms.kernel.org>

On Tue, Nov 11, 2025 at 11:52:25AM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 04:49:51PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add check_result() function to reuse logic for incrementing the
> > pass/fail counters. This function will get used by different callers as
> > we add different types of tests in future patches (namely, namespace and
> > non-namespace tests will be called at different places, and re-use this
> > function).
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v3:
> > - increment cnt_total directly (no intermediary var) (Stefano)
> > - pass arg to check_result() from caller, dont incidentally rely on
> >   global (Stefano)
> > - use new create_pidfile() introduce in v3 of earlier patch
> > - continue with more disciplined variable quoting style
> > ---
> >  tools/testing/selftests/vsock/vmtest.sh | 95 +++++++++++++++++++++++++--------
> >  1 file changed, 72 insertions(+), 23 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 557f9a99a306..05cf370a3db4 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -46,6 +46,8 @@ readonly TEST_DESCS=(
> >  	"Run vsock_test using the loopback transport in the VM."
> >  )
> >  
> > +readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
> > +
> >  VERBOSE=0
> >  
> >  usage() {
> > @@ -79,6 +81,28 @@ die() {
> >  	exit "${KSFT_FAIL}"
> >  }
> >  
> > +check_result() {
> > +	local rc arg
> > +
> > +	rc=$1
> > +	arg=$2
> > +
> > +	cnt_total=$(( cnt_total + 1 ))
> > +
> > +	if [[ ${rc} -eq $KSFT_PASS ]]; then
> > +		cnt_pass=$(( cnt_pass + 1 ))
> > +		echo "ok ${num} ${arg}"
> > +	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
> > +		cnt_skip=$(( cnt_skip + 1 ))
> > +		echo "ok ${num} ${arg} # SKIP"
> > +	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
> > +		cnt_fail=$(( cnt_fail + 1 ))
> > +		echo "not ok ${num} ${arg} # exit=$rc"
> 
> Hi Bobby,
> 
> Should num be cnt_total above?
> 
> > +	fi
> > +
> > +	cnt_total=$(( cnt_total + 1 ))
> 
> It seems that cnt_total is being incremented twice.
> Once seems like it ought to be enough.
> 

Indeed. FWIW, this was fixed in the newest (v4). I messed up a rebase,
and my eye didn't catch it before sending out.

> > +}
> > +
> >  vm_ssh() {
> >  	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> >  	return $?
> 
> I'll confess that I didn't notice these myself, but
> Claude Code with https://github.com/masoncl/review-prompts/ did.

Thanks for the note, I'll give it a try. I'm trying to build out my
pre-send workflow atm, and this looks pretty useful.

Best,
Bobby

