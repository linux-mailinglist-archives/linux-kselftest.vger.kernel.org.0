Return-Path: <linux-kselftest+bounces-17724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B0974BDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84473282A93
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8536C13E04C;
	Wed, 11 Sep 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZgjrRME"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57872C190
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041140; cv=none; b=Ve9YgV3ehf8OBK5vQGcfab5wSBphFbA45W7vNzOVFmZYB8YIFoiCLJNawW/9rZuix1PltgQVJOK8U/DGP6ctXGt5m5VIGZHmKH8wVa9D4Tkei78etwJ15hima1cZT73ZzYSQuTUi/3fUomaX+wt1vaEfK8xVdXXUrB6Ade/KF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041140; c=relaxed/simple;
	bh=gySaOFRHBtcljdSeXk5NTlv58piwgRt6if/IxQF/UWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vax1YOPPypu/nTygEJCBf6SpK3VRNx269qVc75BDR0e4RKk26p8CDkCb0ZiGZnuW/hNxbTwKZ+JFs7GjEXkAIcU6Fv2UPkwP4iEg8mnLxr2SPKotCmQh1DfoykvauvHEMWkmA2iidCpPNL6S/hpgaRYIreEjA7W6sZ2DTv93llE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZgjrRME; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so3489275e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726041136; x=1726645936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxxfET3fM3V/9CRMIOk0EfCrmZYUH+MdAUwdBUw1Geo=;
        b=rZgjrRMEpHCC1DfbkeUXitYL4PqDVOnM0Es1ujz7JkLEp2xy5xRJuDecgqWEOqG1wE
         FMak6ehT8K5u+EqilCOjt21MOvj0peRFwubrtow3/g99xzCdn4emLmovXqtbatp7Bbp4
         fzZ1BMzO1a6MaOEdtW9MF4NKz2HkwOP6g3dy0J1xNPQkv50wj28oKQNnIai9G+GMllr9
         XTEeFUyZIZ+W2rRM3E+D5KfBHiygUHPOPyHM6rRJo/LE/7zDNkChjYNdTjooLQJybyLB
         DLIkFtjxSrUxhw73+rcDV2vPTnQpaeHd6fOS+VK6BYO7XeLa5rzzaPMkjwZLjttqSraO
         5h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041136; x=1726645936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxxfET3fM3V/9CRMIOk0EfCrmZYUH+MdAUwdBUw1Geo=;
        b=LndLEddAH0yi6gWITT297duPM+eMwREaceYCBlqsTk/AosQXopAf6VdT5bEAerhylx
         1xxA6X/57KyKLsQIzFdwvA1UA6isCPkmHTDdxtkA320xn9zx+rI6npxy/OkeX7Ex7GKh
         BkPELaQC97zjmHQzNPGpUYEBGf6Blv8+mUqasOIzfGXVE07zpv71JH+swohSjc2/rfbc
         rJREbPtLjCMbY8AwJBl+WfyvX/fipFOdOzr1xVDP3fLzEPvNL3ykQvfHsGDi1RpkNnCm
         3uctlgy4Euh3jny7+pck55/zYe1sn/MLiPRK0QmB6GSynSIL+EI4aEnR4O/MuU7aamji
         iSdg==
X-Forwarded-Encrypted: i=1; AJvYcCWG+HKZkAyEX5+iI4k4+q1H/RWBBOsqm5pE+uiWqk7SHDAHspyol8gXJL71geB+5VO1MeknxZa+dFmw2oiVCCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWusSbADXiP7PmJ7v+m0Wm8zyZn4k5NW/NnlHt94TOVrRruAIp
	+qZv8/ctUXCwpmCn0bdjuG+zvQq9LMBBTrg2qXiK1f/4dSbshvcswbXFg9Fs+A==
X-Google-Smtp-Source: AGHT+IH3vyKCf0knIMn61KvQCDAk4WW46zj0emh72vl4fMCsHLyzArOUiTDQfBxn8rt89/yvFSddxA==
X-Received: by 2002:a05:600c:1ca7:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-42cbddb8169mr33274305e9.4.1726041135777;
        Wed, 11 Sep 2024 00:52:15 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb179f8e3sm125126015e9.43.2024.09.11.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:52:15 -0700 (PDT)
Date: Wed, 11 Sep 2024 08:52:11 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@android.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire
 meta-page padding
Message-ID: <ZuFMK7yndArZo4pA@google.com>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-2-vdonnefort@google.com>
 <20240910124541.23426cee@gandalf.local.home>
 <14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>

On Tue, Sep 10, 2024 at 12:49:58PM -0600, Shuah Khan wrote:
> On 9/10/24 10:45, Steven Rostedt wrote:
> > 
> > Shuah,
> > 
> > Can you take this through your tree?
> > 
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> I can take this through my tree.
> 
> > 
> > -- Steve
> > 
> > 
> > On Tue, 10 Sep 2024 17:23:34 +0100
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > > Improve the ring-buffer meta-page test coverage by checking for the
> > > entire padding region to be 0 instead of just looking at the first 4
> > > bytes.
> > > 
> > > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > > Cc: linux-kselftest@vger.kernel.org
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> Vincent,
> 
> Can you please rebase these on linux-kselftest next branch and
> resend.  This patch doesn't apply.
> 
> Also please fix the subject to say:
> 
> selfttests/ring-buffer

Will do, but it depends linux-trace/ring-buffer/for-next which hasn't make it
yet to linux-next.

