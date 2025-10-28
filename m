Return-Path: <linux-kselftest+bounces-44194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F5CC1600B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 924184E485E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53BE3469F4;
	Tue, 28 Oct 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP+v+6HS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B233F8DA
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670702; cv=none; b=k4yOFrOlsYmldVE1K9HcamDOCzLItV7swj15hDpIhiJM2PUms/yf2pPdmaqkH6tw4rmqSf4cq6wuVR0JgvdRrbNGEuZOZ8FNM1S8RAOl1Kt9IwYDLAII7Oo9D94sv4dOLdEW+BMNGu16aFCJOSe1RspJABwfXqfnwvCaZFz1OxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670702; c=relaxed/simple;
	bh=S2YK88oreoElX7onfuW9IzclvPMp4++2KYT8+xCMHWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMDA12jFkLiN7KSyGLB/5xbhmwDiKxtm7ESnMtoRsL9kH2HWX3bRQgju1HwNkMYCc/KKdTJ5q32z6/e4Pf10cRMCghWCAbkbBycD2dp0mka7zy3je7i1IR8heyKYK4Mq9JYHk7MUYzrMUWUclValRc7gZrIuucD56xauC6WCpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP+v+6HS; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so3802857a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670700; x=1762275500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKAJWIVdXY6w33OMTqrvcoCl8DNQe+wsI3uiwsncnTY=;
        b=KP+v+6HSTLrwT2OpXu/6ZePmQxEAkhPAipGgDURxgT9q7sDRgYqNlMbr+L35kyIJb/
         9uLXAacqZyxOU8K2o9ccVVnMTUeIFrw0tynFlLkdfJtqWj6hQmeqoje7AwTuNlBztK6L
         1X1mnzj5jo6AODvZUuQ4cyYbUa9VEYnE7KFDUezu0J0E+wwDkuo+ocIToDenWvldHC6N
         bWVVfHwF2ZrHsgjLUte2EQQXuewkUo/4TkV+wFl8Tlc27GmOPfDv35HxSBPfE7JS2Wpx
         GDEy5gNkgwSzZ8i974XhnKrz3weO2/NCv4ouzVmKBU1SeO2cBLSYSZXusU+4GR4PpZkw
         AWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670700; x=1762275500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKAJWIVdXY6w33OMTqrvcoCl8DNQe+wsI3uiwsncnTY=;
        b=uHYMWJn2cENio3rVB1MJfksZvnBaur2ORfNfm9tJOW4Ph8BsS2564LlD5m8fNxY078
         Slej+BxdDhSQpLIw7j93+Yp1PPDt4IIClnwEiFuRUh9SCMxIVW1mGQvMFDI7SqG1RfCh
         fWCf/SYqo/lYpJPImDM9Q70lZZ4FbTPoQ02d0HGI2wILVsEHDvSYLzfsydz/aP9RVuQb
         GIVzBhddDZYVNy5sp3Ssiq8XexfEpsppFugoAvZVGNpVV5XMZ2l0wMKmCPkpwHOPNBRk
         XhAVRolmCxfBzGmjgSGpDFmulen8qNN/1NgPuDlGVvUZqo4y5d7axrT0lVPzyRxdWC9O
         RwYQ==
X-Gm-Message-State: AOJu0Ywqid3qCyxrQrXhuX/Z60C2epiK7BYUmaPpC5ljtf8K2NZ6W8XL
	ygUizmknON07uNlL59mlubZMn6dkkcVzvgIBw9iHjPGqVjcesnXuH6pP
X-Gm-Gg: ASbGncsd7PkTNdk06jfd5sgPfXXVmzcDbS1cEwDPG5kf7gx4L9gIBoL/CpJy1UbNPYd
	mJVE2Ucz0SD5UxP4y4hfsUCKTgXeaBnsVYjMBMW3TQgpmxbdfel8Tw4MW7jwkEGRGwnUou9Mrj8
	ye0BMgDCIiuhnOjyskuiYMJkttayNHbRCFMPrdP/G+pG36yb+JJTHcfCx+JtcektnWT3cHisac9
	2Bf3y8k4hVw5yzOrXUipw4HcUUP7DFUaQuDj4io2Ng0SwUTz8NLy2fnl9MQt4JIQWyRwhTMw8bu
	XP3kM+NY5xm0u8MiIJiPwxHbM78X8PNt642UNyPZtYhblajjii0E6PQODrWIYZQvp8qAILX2Mm/
	0A2aJfmtWNnnWm44tj3p6R1d0uzSfrgBDOnomhvMaIRTSI1d8ltcCT+86DcCYhHY0ujNgaTUjNY
	IYSq0UBfEb8tU7Dn3gZ1E=
X-Google-Smtp-Source: AGHT+IGoWRXRZauvUG5j1zo0Qxhl0gwoNettufvBODgutBswNwVQoMUoNOz0OY25v/QcS1yZJBzGlA==
X-Received: by 2002:a17:903:2f0e:b0:290:c0d7:237d with SMTP id d9443c01a7336-294cb50e4bbmr54429445ad.36.1761670700123;
        Tue, 28 Oct 2025 09:58:20 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4b0csm121255865ad.10.2025.10.28.09.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:58:19 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:28:10 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] selftests/user_events: Avoid taking address of packed
 member in perf_test
Message-ID: <aQD2Igc3svAF3klc@fedora>
References: <20251027113439.36059-1-ankitkhushwaha.linux@gmail.com>
 <20251027162521.c56c7f89f6ad4e3d639c408c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027162521.c56c7f89f6ad4e3d639c408c@linux-foundation.org>

On Mon, Oct 27, 2025 at 04:25:21PM -0700, Andrew Morton wrote:
> On Mon, 27 Oct 2025 17:04:39 +0530 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com> wrote:
> 
> > Accessing 'reg.write_index' directly triggers a -Waddress-of-packed-member
> > warning due to potential unaligned pointer access:
> > 
> > perf_test.c:239:38: warning: taking address of packed member 'write_index'
> > of class or structure 'user_reg' may result in an unaligned pointer value 
> > [-Waddress-of-packed-member]
> >   239 |         ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
> >       |                                             ^~~~~~~~~~~~~~~ 
> > 
> > Use memcpy() instead to safely copy the value and avoid unaligned pointer
> > access across architectures.
> > 
> > ...
> >
> > --- a/tools/testing/selftests/user_events/perf_test.c
> > +++ b/tools/testing/selftests/user_events/perf_test.c
> > @@ -201,6 +201,7 @@ TEST_F(user, perf_empty_events) {
> >  	struct perf_event_mmap_page *perf_page;
> >  	int page_size = sysconf(_SC_PAGESIZE);
> >  	int id, fd;
> > +	__u32 write_index;
> >  	__u32 *val;
> >  
> >  	reg.size = sizeof(reg);
> > @@ -236,7 +237,8 @@ TEST_F(user, perf_empty_events) {
> >  	ASSERT_EQ(1 << reg.enable_bit, self->check);
> >  
> >  	/* Ensure write shows up at correct offset */
> > -	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
> > +	memcpy(&write_index, &reg.write_index, sizeof(reg.write_index));
> > +	ASSERT_NE(-1, write(self->data_fd, &write_index,
> >  	                    sizeof(reg.write_index)));
> 
> Simply casting &write_index to void* would fix this?

yes, this hides the type mismatch from the compiler. But i think
casting to void * will not fix the alignment mismatch for packed struct.
It works on x86, but might break on other platform.

> 
> >  	val = (void *)(((char *)perf_page) + perf_page->data_offset);
> >  	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);

Thanks
Ankit

