Return-Path: <linux-kselftest+bounces-42981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA00BD0400
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Oct 2025 16:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9420F3AC491
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Oct 2025 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E87288527;
	Sun, 12 Oct 2025 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1s89k26"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B12882BE
	for <linux-kselftest@vger.kernel.org>; Sun, 12 Oct 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279530; cv=none; b=iyZ6uMVTDgA/xGeKGoYW1U+ZfCEHKL01NUyaGDblMJzjAdBdgO+onDwhOD/YMPViYftqNSiiS8Gta8h0QPFbVImGmuav1x7+sFEBNq0PMEDHhVPswHFtenhdzHr/gu4RfX2mTqPQvogxfKlvFYepiXEgbv51h5Ewhi5VcfattPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279530; c=relaxed/simple;
	bh=exVDaTCv2o9KGqW9+Cgff31C7B8DfZakECaMCpf1bfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6inFPmkV81wUBNLg6KDSjeuHcPaPgXka20q2WaDhCG0+QcLko9FXWDWEgRcbBL65S4etGJfSU8SYAZL1iWiCDo/7UrZel+MjJmCJQ7S90Rk6dpatdqDmQCp0VDMlFzbMFKsw+6TgsNH11BLlphJxnDD9OgwwjfSRYrksNcpwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1s89k26; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7e3148a8928so41192416d6.2
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Oct 2025 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760279528; x=1760884328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lafAVcrEHvdofnatEPGKT/Xtct7Xl7DSjL6fT41f0Sw=;
        b=K1s89k26nbYzSwwGw7yMYiYrRjewHFeqMCWTkxii0Kk1TGe8AJjnPIhBf9DswDh9AP
         Pc8PZkqx8PU/oLLaaseQlS2cn+adpK50u3OR+RUldZVfZbHOgIHTkf2j22hZCKR1/bY8
         K+WzATCb/aJGKL21QkWActjsYo1QICYWvUqnwm7Y23ReLGJMDnVIHhQ2nCvoLuAZDF4k
         MFpNBR0+2pc6q0LW7u3kXC9ZmsMz65gusX7+PngKjBo7pwiyG8Q3ip7uRmtL6kKVKXvC
         P35XoF+hOLRCfEMQFis3zy8k4eGD4BO0dwAafZG96RutusvGhhC7+CY8MhB04M5dSkS+
         lJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760279528; x=1760884328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lafAVcrEHvdofnatEPGKT/Xtct7Xl7DSjL6fT41f0Sw=;
        b=EBwBdaBNkHzZLbWWP6Oq315H4USujT5poRW6vJrCiPzaaEj9H0trDdZ8ZCoaoanCoh
         IjDiMeQEynrgnhbLyX3K1j+STpAnqxG1ctkuXmG+YvajSR+gUACrD6Ekasx+30PD96uo
         7CsRC10UZ9fjxQFRv9H0TBuWSUropPVCwENhYKnICGhXRudb1lebMoLgVoW2Os/tn5kH
         tQ0foOh1cO2XkgHI7VbnVVOBcF/JhtRPKEUZeRvONNypL1Nzm2CiojtVKqr/t7bHys6x
         lMXkI8J5YdW97E+skTcPiVs7HZKskbAh78Wbmla9QwVKcXJFnEBOGMvftP8Rq3EzfRb3
         z+5w==
X-Forwarded-Encrypted: i=1; AJvYcCWGK47O0fTOfSrk8JsjLmHQpVrKO099mRTWnkFqktiqP0N+6SpeFG2g7sclDSdM+beCyxCSvI/8zTocfcIiGy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDamXbuxrUTMRhmBTgLINxvVDpKQYjBmO/5+AllicfEJz6NOST
	gKz3EMEosh2Pa5V03btj7bM/X8YI33Nwmvt2iIbvcHRFf68t8igvTNZs
X-Gm-Gg: ASbGncvsQ9T2h+y3o+DlGxHtfTbEeYCnVgOqc16pr37MnfSXFN4NIfeIn4vRz5l1YUX
	W+KTFJHhJFu35ZfHSxT/0cyr/lZagpycOR5Bsb9sJ+HnZufM/fBzRP2xsgLkVN8jqK5AynnxMsU
	F5YQsonhx6CLpg8LYRtbYu7MeaqvLZJgQx58UhXgoxiXXIeiH1hgZYRVvMIiWGYLKgTX+oY1gN7
	vLbxRULjHpArc3ayawiQeuGz389ZspFeWwLnw9X/bpdsMYTGbFaZC/a1v8fJbeiVz2lL17cl4Yx
	T5j8AAM68gRpfz/N6U+YEySp5mVYXkrwph3rbByoRVPiB4seVkajRky9O/QSFvhGvMH3I57nsmM
	QLLp3IEBpEuoyl2x8DJlnvXnYxOZ7bonyydAucbDCF1izndQveUKF
X-Google-Smtp-Source: AGHT+IGylxeC57G3HP7/1vZXTCP0woc3CF/bb9piQD8YyNw88k6+Ampz6Ayo2XWXeOakyOz8ZMmEgA==
X-Received: by 2002:a05:622a:30f:b0:4e7:222e:6725 with SMTP id d75a77b69052e-4e7222e7357mr20155591cf.8.1760279527640;
        Sun, 12 Oct 2025 07:32:07 -0700 (PDT)
Received: from gmail.com ([2600:4041:4491:2000:f887:3bb2:9bc6:cbb0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35930f3sm54042686d6.43.2025.10.12.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:32:07 -0700 (PDT)
Date: Sun, 12 Oct 2025 23:32:05 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
	hca@linux.ibm.com, corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tracing: fprobe: require explicit [GROUP/]EVENT
 for list/wildcard
Message-ID: <aOu75evMUGF8pBxE@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
 <20251004235001.133111-3-seokwoo.chung130@gmail.com>
 <20251008095316.cf24f13a84a454ddbf530120@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008095316.cf24f13a84a454ddbf530120@kernel.org>

On Wed, Oct 08, 2025 at 09:53:16AM +0900, Masami Hiramatsu wrote:
> This should be a part of [3/5], because when bisecting, the test will check the
> README file and check the feature.
> 
> Thank you,
> 

Ok. I will fold the readme_msg change in [3/5] (the patch that
introduces :entry|:exit and keeps %return for single-symbol input) so
the tracefs README matches the feature during bisection and for tests.

> On Sun,  5 Oct 2025 08:46:56 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> 
> > Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> > ---
> >  kernel/trace/trace.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index b3c94fbaf002..ac0d3acc337e 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -5524,7 +5524,8 @@ static const char readme_msg[] =
> >  	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
> >  #endif
> >  #ifdef CONFIG_FPROBE_EVENTS
> > -	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
> > +	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
> > +	"\t                (single symbols still accept %return)\n"
> >  	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
> >  #endif
> >  #ifdef CONFIG_HIST_TRIGGERS
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

