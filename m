Return-Path: <linux-kselftest+bounces-24533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3496A11445
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 23:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACE47A23EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 22:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0DC2135D0;
	Tue, 14 Jan 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+LsTw0J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3B1FBE86
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894541; cv=none; b=Lv7MppeIrjfQbumSItr3OkrsMkE16ubKugZJeEMUxXLhDQx7ea5j55jzDd+5hO61BfyZsz+16uLK3OPj0jbc9FbevjWrdlLDD5mCwAWSz4mLLsm6PS3pJqk3M/+ojzztTJY/9NiqKUy1653qrflgQFBoW+YfuMzgeEGqbMZAgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894541; c=relaxed/simple;
	bh=Xs1dxq2fGPPYtaqU2IDeyblBvS5L0xhG1gPyp9lfs+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfxfddBlIkb7seJxjHGScZORtxmq1irtRIzOn8cgsHvv/xsZL4SDTaA3OSAO+HPSM8aQbNkQIIBOOb/wrzrZc9r9eKb/9MZ8Eu/cihxRa2SBL/WWL62E6FUOVAOleHxGkXiy68YYuQgDyNUkOFlQaY1PUzElbZwf16WEzFG9c3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+LsTw0J; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163affd184so209765ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 14:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736894540; x=1737499340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swMA7a3HQZ6EnlfLP67EfqYFg1OFOpUwx/BZEKqDMMM=;
        b=Q+LsTw0JnP7LfO47eHwP/JYC6wxNJsi/bb0c1zF9xc3guZzqRj+M23ZdM+nT22T+i9
         h9nFLY3B8AD+paY6wZ+//ObxOZWfEmY+ObBSs7quoUmuD457gBCWsEt7LmUxPSIDnzB8
         DAo6+KM+CzDcy3DkuZLrxAtE58jRI6GXOk33U3TbjvJmyEBijcabXDVNimxrSMIJUds4
         Ocf+7Y8DdlVtiNvXEWePO5xDE7O835QK60gzjt7PtwfNvBxflK9kFmQkMsYYave72+0G
         OcJKEqw3u7gw+fmsoUexq+wnZsO9I/ttvk2BV8dblljgqLzTQkdMD2Rl7ZbOR0ddDeye
         s9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894540; x=1737499340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swMA7a3HQZ6EnlfLP67EfqYFg1OFOpUwx/BZEKqDMMM=;
        b=sOpr9ZehAPUCPDPDyWDrtlWTEnlqARG2WIZM3sLvilRz90JSQ/vmQx1TUwki6YtpmD
         px/IqL0iF5jd21XPjP8rLJJV0UQSqDRMJbG5Q9pr9+vDikaHeI92fCsUBHOd2grOeLDM
         /sImt7g5blRqvhfKxeX4mZ43MsqbPMdbKytAxIL9yYULpJ0L1JBOxcqeTzm535Hub7qf
         HBq6EU4HjjMXDhasVKYpVOTVDtBRvM9QulF4kKopHGppSZipXinyevbFr4TwHrAJOcHV
         VvF053coXG8jWB+oxNRJr2ZleLHepu60ktOIfSm3q+7tW7PbRTOB58G3B9TP7/qqWJN0
         nLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBjqzmwOfEJ2D3GsXZFYVbdmsIt++UIB6CbL241gKOuc/nZNe1vl23WLEFnwW0VXJlvtj56vE8qZ3tUu8agVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/95MFcrb3FsBni+KZR2QDx0s0oXOARHsn6eZ/Y1fr5RpwB1Na
	u66icoYeOCPQHSTW+ZtcVJoUXjZJY9MDxVccET1dzs31c0bljfLwoSEA9B98qw==
X-Gm-Gg: ASbGnctpXcz/b8pEC73RFaH4yM+82AIWI8ECrjQpTBQ8qzBbRuQNQ+fQ2ZBa/R3rmFM
	o5jU28lZ6sBNveT4IGbhQUCBNgxFxcicmPeh6KUzGgAS+Nvmi7ygfAdbZk0XK+UvVa4sPIV9vy6
	E3kfZWy5t4onpVbS1cRqBszA8KQjmgVmz5aA2AeErcz/bOfkj2r289BRYLjrhjr63CIKHvwd+y6
	t1lSwMA01XMsp/J3VIuSuEr/1J7HGmcp2w2nyCdivKHKEz0to6NMFQx7Q==
X-Google-Smtp-Source: AGHT+IGoegfwlqw2q5WVfOTyFF4JK79h9BcAugnc0Xv9CPqMRMnAP3WIacvl0pdW6tR1pdom6vRMig==
X-Received: by 2002:a17:903:48f:b0:215:44af:313b with SMTP id d9443c01a7336-21befee6a7cmr867865ad.0.1736894539639;
        Tue, 14 Jan 2025 14:42:19 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:5f58:5aa8:70b1:12b6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a318e055feesm8811734a12.30.2025.01.14.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:42:19 -0800 (PST)
Date: Tue, 14 Jan 2025 14:42:14 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <Z4boRqW9Gv57GDzu@google.com>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
 <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
 <202501061643.986D9453@keescook>
 <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>
 <CABi2SkV72c+28S3ThwQo+qbK8UXuhfVK4K=Ztv7+FhzeYyF-CA@mail.gmail.com>
 <Z4bC1I1GTlXiJhvS@google.com>
 <202501141326.E81023D@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501141326.E81023D@keescook>

On Tue, Jan 14, 2025 at 01:29:44PM -0800, Kees Cook wrote:
> On Tue, Jan 14, 2025 at 12:02:28PM -0800, Isaac Manjarres wrote:
> > I think the main issue in the threat model that I described is that
> > an attacking process can gain control of a more priveleged process.
> 
> I understood it to be about an attacker gaining execution control through
> a rewritten function pointer, not that they already have arbitrary
> execution control. (i.e. taking a "jump anywhere" primitive and
> upgrading it to "execute anything".) Is the expectation that existing
> ROP/JOP techniques make protecting memfd irrelevant?
>

Is arbitrary execution control necessary? Suppose the attacker
overwrites the function pointer that the victim process is supposed to
return to. The attacker makes it that the victim process ends up
executing code that maps the buffer with PROT_EXEC and then jumps to
the buffer to execute the code that was injected.

I don't think having the ability to seal memfds against execution on a
per-buffer basis entirely addresses that attack. Can't the attacker
craft a different type of attack where they instead copy the code they
wrote to an executable memfd? I think a way to avoid that would be if
the original memfd was write-only to avoid the copy scenario but that
is not reasonable. Alternatively, MFD_NOEXEC_SEAL could be extended
to prevent executable mappings, and MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
could be enabled, but that type of system would prevent memfd buffers
from being used for execution for legitimate usecases (e.g. JIT), which
may not be desirable.

--Isaac

