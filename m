Return-Path: <linux-kselftest+bounces-44300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 103E5C1BDC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 396245A9494
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D222B324B3E;
	Wed, 29 Oct 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO8wlahf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4594530E82B
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751247; cv=none; b=XuGKb6gGFbmIxN99/etp3uz5rG02j79lfQBzfg5wrgwlU4uc3nd2JguaUu/Rw/YsbayD9zjvE/azXNtoFGtnr1YJ6a/bh0viT4wtCJf+AYpkepkgoX0kwfhA/deFAQjA07Nn5FLF03WfqAqJOWltLNZhDLJOpLTHUNKhc+gGwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751247; c=relaxed/simple;
	bh=HtJoUupx6d/yAjUM+7GHFEp8E2bMSioh2TQ2z1eUvkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo3QTpNuxR6MvVgjjp3HwydUcfjHR2kN3z5ZwjbIiKMEbqSwkkAreqcEW8X6LAzbpWvrxKMnG/aj9iWABhnAdlROm03GurcsDwBWCEPpiBmZqmJLgF/DqSgkS39yr55UYP3oNwY8uImTH5dcAk+VYg0q26TeEj/iwZ4J0kjj0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO8wlahf; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-290cd62acc3so82331245ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 08:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761751245; x=1762356045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=StYPN+Xnv/FlnNbB7eCIIAuswaamCaMZ2VJSzNeBonw=;
        b=YO8wlahfk7zhuSu1taBkNV56d397C4+ZSInUL/QkrdiaOsPQ5MA0soEKfiN1TYN4Qn
         CVmAV0FikZzMfUd5O4x7D7OxEgG6fnDOv3H7rfs0hJRemFrbiibfJzRJIQ4dHMS5jQKS
         Srl1pIJR42ieowOEibynXL6YaR8rd9bpVw7yDvaexC6ZxnDSViS+zAWs/ixP9306ZgnI
         mHA+umwm3ksAqMkg+n9sGZ5r+5SWmMuBl3j+uz0RdkM/xVdZRgHRWyOOg1CN3uw41hC1
         1OXydasfIbqaSRVSdu9PIhk2aWeweSg929CU5mfJSCKROZqApyga5796HyQf5hm9A/u7
         usqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751245; x=1762356045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StYPN+Xnv/FlnNbB7eCIIAuswaamCaMZ2VJSzNeBonw=;
        b=hflQykAkgcoX62KMgJBy1Qs3oqnaQ002UQinZjFTYynjOlBj564heoZVhMDAk0zXnG
         I6gmIfwtqGMFRVQjw+V3kVY+9ULCNkuVABrkBeuxBl1ASO8KxKQ3Kk77bQVEVqD2w4Qi
         +KcXaEHM+1CB2fqJWveeOl4Lh2m3AKebTYnP6dFxWDNoWoYaBbM5txa95azArYEiL5NJ
         fJ+2RhyOoiOWh29Pnr/7ANiupeX6LA7JgjAh7kN+7s75verAyLUJeHiBHhs66CK5Xp2+
         YiInd7boSQOJpmlsWRwkVS4RqCz4SY+OrRJOzsjARRgk0elQ7EcK8OTmIGtarIOKi3LX
         q9MQ==
X-Gm-Message-State: AOJu0YxWhybWSdN/C5e0VDwsnbpzjf7EDQuCpP1TNP//7isINCrEuIFF
	I9gSp4rnOFu3fCGGzbsrUWPyyyooFTW6ZwfbRGWLdZc7CHMVlVXKdlvG
X-Gm-Gg: ASbGnct/81jf3OczSRZQ2CdNzfkh80XzeG14SGsVtdpdRJtJpsxPXobbhZSnlvaoQyU
	S3wkOScAjMvutSfAXJAoFaE39zZKof3sT/cDTJ7a3cAHX3YtjegFjisY1T6WYI2wWEmAvaN/A5d
	qtoxEHdd23pdzlqlwbf2OKNylundaZ7WGs1eC2oTTzaVoRwVWSjLaoRV5Rvb8dcP0SukyReVeDP
	cG3DbTIEaeBQIHCeET1sJwz9PIfjE6rjwzPSMBFpViXBLJnZUhy1bWTsYOUsjUXzKWJtNe/bDfL
	WZ+56990/sgqR3cbt0LyuSgR1H5pahxjn95/BkZfokeFIeAlEEdLoRCwzKKEyveIefMd0MjkkOV
	pz2OMiw4pQG9RVK0URBr4znS0ycmzFgzzm5s1nI7oyj7863gB/SBm/qYVlfTmPaXcYLSa3ql2xJ
	zjpIl4ype+ZqRnwsk5ATM=
X-Google-Smtp-Source: AGHT+IEpwGryO+Dsdw+yBiLYzvfG216rbfuFmYTVEwK59maJasPtn26KCM1zCvZKBwTCZ0ScENApeA==
X-Received: by 2002:a17:902:f550:b0:277:3488:787e with SMTP id d9443c01a7336-294dee0cebemr41194955ad.12.1761751245449;
        Wed, 29 Oct 2025 08:20:45 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3bfesm157605975ad.4.2025.10.29.08.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:20:44 -0700 (PDT)
Date: Wed, 29 Oct 2025 20:50:38 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] selftests/user_events: Avoid taking address of packed
 member in perf_test
Message-ID: <aQIwxjBNonW5Py_I@fedora>
References: <20251027113439.36059-1-ankitkhushwaha.linux@gmail.com>
 <20251027162521.c56c7f89f6ad4e3d639c408c@linux-foundation.org>
 <aQD2Igc3svAF3klc@fedora>
 <20251028132605.2926d3ef5eb6ea60d22ceffe@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028132605.2926d3ef5eb6ea60d22ceffe@linux-foundation.org>

On Tue, Oct 28, 2025 at 01:26:05PM -0700, Andrew Morton wrote:
> On Tue, 28 Oct 2025 22:28:10 +0530 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com> wrote:
> 
> > > > @@ -236,7 +237,8 @@ TEST_F(user, perf_empty_events) {
> > > >  	ASSERT_EQ(1 << reg.enable_bit, self->check);
> > > >  
> > > >  	/* Ensure write shows up at correct offset */
> > > > -	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
> > > > +	memcpy(&write_index, &reg.write_index, sizeof(reg.write_index));
> > > > +	ASSERT_NE(-1, write(self->data_fd, &write_index,
> > > >  	                    sizeof(reg.write_index)));
> > > 
> > > Simply casting &write_index to void* would fix this?
> > 
> > yes, this hides the type mismatch from the compiler. But i think
> > casting to void * will not fix the alignment mismatch for packed struct.
> > It works on x86, but might break on other platform.
> 
> It's the second argument to write(2)!  write(2) expects a const char *,
> but void* will work.

Hi Andrew,
Indeed 
`ASSERT_NE(-1, write(self->data_fd, (void *)&reg.write_index, 
		     sizeof(reg.write_index)));`

would work. However since `reg` is packed struct, directly taking the 
address of its member  `&reg.write_index` may lead to unaligned access 
on some architectures. as indicated by the compiler warning

	perf_test.c:239:38: warning: taking address of packed member
	'write_index' of class or structure 'user_reg' may result in 
	an unaligned pointer value [-Waddress-of-packed-member]
	239 |         ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
      	    |						  ^~~~~~~~~~~~~~~

Using `memcpy` avoids this by performing a byte-wise copy, which is safe 
to use for packed structures.

Thanks
-- Ankit

