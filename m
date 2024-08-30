Return-Path: <linux-kselftest+bounces-16860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7462966B8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 23:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454EF1F237E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B8172BAE;
	Fri, 30 Aug 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUiShg4Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326713D60E;
	Fri, 30 Aug 2024 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054758; cv=none; b=DZKB0GlSuBExlLjVKkTjPcS3OEJAg83PpJQECN+4sgpiExvLVy5PpRB8OwxfXUBNTzQ3WBBtW8Sro3CTJz8a6XXmzDkn9CsIwwPnSPxD7u3hApUNgSpSXi+QcirYBIFqFVOdtWf2ThqTk1A0Ka8iaHARGTIjhvtsnCgTNJHHv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054758; c=relaxed/simple;
	bh=IkTuCSbVLR1iXF7AXKgQbRDx1TmVCNHiQlgZe2dW0ew=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jbEUe9MdYjCRLbKKi+8gSuOKt1BeA/zngZj0nep41Zxc/9AQqILFfF/hMoyBl2BIgV54hAmVDC+1JYr8rU9hrR1mxWZ+GA3pI7SFhJnWDGVqFCI3ojwElhQCnrKDrlB2TwHdaD+i5EgYfyzufLa6tBzttrRA7i99ijdKvYr1UA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUiShg4Q; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-456774a0fe7so12531011cf.0;
        Fri, 30 Aug 2024 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725054756; x=1725659556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcXD9EKY0OCyfbPqdutna+/Pp1nF39E/CbXST6SgpRk=;
        b=UUiShg4QtgbwQgx4LUfwboNxtQU7VtKbIdnvSrfsPvRsbj1j5R4is3rxfs3zjzE5e5
         ZSUSqxpfjkgHjdXQ3xHISS4H4cSXCT1U695+cqzPmdPQhnF1IKA2eYgGgCuruybO+kLp
         aG45ZZdvoVV+GRu3m39HVHZ+719OGquTSwpn8bTUFEEbIYUGqdyUNYdO9h5Jj5mVPWUX
         8zjZUBRgXyXPpLumI3VewTwFPBzOtCa/gBlmlUIht4G7oLuBB3OEslEYFSNAgKCl3MlO
         e5uFZHDyAVNApkW73vvh7un93uum/zbihdmZcv6ueW7bIwIQeqla1pZ05zmKo1Lo1cPc
         jagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725054756; x=1725659556;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CcXD9EKY0OCyfbPqdutna+/Pp1nF39E/CbXST6SgpRk=;
        b=B8zad2weOJfjKelYGzKT7XijCzw7ZiPj/EZzDkDMNy+OUqaaDGDdMV8HNQ7nTgACkl
         F0p8NanN8lItbXisXRqMNkZ/Uv5xRRqnyZf5lRF1hNFPgnSXU2/2C4pLj3dalMAqGgfK
         MrxiTCD6flLNfnjsKMSw0ZkjNQgKDPnTRBwU/lwB9YapNjKb2AaUyGrnoGIdFD0fi40N
         TuRZJE6P6jL4GRrS6i5IkeugzwHYb0Pe7bx6H9xfOYf3ZJ2u+Li0XA3PsXdcSNad0jhB
         AcoYOnKNnM3JCe9M7hRW+6nKS8RHeBlkCwBc55+INIRiiCmMsu6Ptum1OsI2ZS5+RohP
         PPwA==
X-Forwarded-Encrypted: i=1; AJvYcCUeKJDQuF7nOW5+FIbdYTmx2/Wb8REhEcq5oNbMWK3qIMHQOB+WfUG/xoVnWcPk2IKUwLNntJH+fFO34cpB4ss=@vger.kernel.org, AJvYcCXWwryOExCKq1FEnGVABkEorVB94h36Jm/d+KxOT//nHKvGz2uyYwb9VfZ+bQGN5sBlf8mAL3oZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzN06V0aXDvsNvwLKcEuS62qGF9XFuTsrKNgV8T7m91I21KCvpI
	vvvolZAvlzVXn/ig6csnaFYvx3yXOhNrkDLSVeKv8/JjgEArEVmY
X-Google-Smtp-Source: AGHT+IFaxoKnTc1ahBV3NjNBc8V4fwKTSlo2bknC7B4mNPLPi5ZHMsJwqwhugLHj+aP0wjGYPWnU+Q==
X-Received: by 2002:a05:622a:6209:b0:457:79bf:9591 with SMTP id d75a77b69052e-45779bf9678mr4405331cf.62.1725054755803;
        Fri, 30 Aug 2024 14:52:35 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d66b6asm17576591cf.65.2024.08.30.14.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:52:35 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:52:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 martineau@kernel.org
Message-ID: <66d23f2349f7_3d8dba29489@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240830144420.5974dc5b@kernel.org>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
 <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
 <20240828090120.71be0b20@kernel.org>
 <66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
 <20240828140035.4554142f@kernel.org>
 <66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
 <20240830103343.0dd20018@kernel.org>
 <66d213cf6652e_3c8f2d294b8@willemb.c.googlers.com.notmuch>
 <20240830144420.5974dc5b@kernel.org>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 14:47:43 -0400 Willem de Bruijn wrote:
> > > We have directories in net/lib, and it's a target, and it works, no?  
> > 
> > net/lib is not a TARGET in tools/testing/selftests/Makefile. Its
> > Makefile only generates dependencies for other targets: TEST_FILES,
> > TEST_GEN_FILES and TEST_INCLUDES.
> 
> Oh right, TEST_FILES vs TEST_INCLUDES :(
> 
> Looks like only x86 does some weird stuff and prepends $(OUTPUT) to all
> test names. Otherwise the only TEST_NAME with a / in it is
> 
> x86_64/nx_huge_pages_test.sh

Oh interesting precedent. Let me take a look.

> But then again maybe we should give up on the idea of using directories?
> Use some separator like --, I mean:
> 
> mv packetdrill/tcp/inq/client.pkt packetdrill/tcp--inq--client.pkt
> 
> Assuming we're moving forward with the interpreter idea we don't need
> directories for multi-threading, just for organization. Which perhaps
> isn't worth the time investment? Given that we'd mostly interact with
> these tests via UI which will flatten it all back?

That's definitely simpler :)

I'd like to keep diffs between packetdrill scripts on github (and
Google internal, we have more) and selftests to a minimum. This is
invertible, as is rewriting source statements inside the pkt files.
But that might be more work and more maintenance in the end.



