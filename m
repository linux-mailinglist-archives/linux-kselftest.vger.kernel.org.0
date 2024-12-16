Return-Path: <linux-kselftest+bounces-23402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745D29F2E91
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 11:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FFB164DDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1486203D61;
	Mon, 16 Dec 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwotHOYg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CD1FF7CA
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346372; cv=none; b=AK0CW9dlDaBvXJjQqI9cFKe9QgnbdALkDbucfnTfer6Pa3NWqNKoXCaM8F/qV6HQiCwnjy60RtjykI+tyhwuelW6deFFTS0zJ9i6rOboklIcj8Q6QIeFhjqrvJKgMr7hC7mjImEiPFMtK4l+VFk3vnYHMu0uqU3z+FZ056gdpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346372; c=relaxed/simple;
	bh=BiostCZ32g8dogyQDPIcRjpPy0It+ifOODpShfbrCBY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=vClKEmKohzfA/pEwyt7BIDzpPFZKUyZDeaG3VESyoP6d9xQkGH3TvNliciFh3nw+T+8pIp8/0/PMvXgWoE0I9PyV+vUwfUEfBbsQqqmHk0dUJcRgqzB20tRqCRxb1IvjnDOy8QOl4W4SLD+yU02jbp9fbxjS+0D8pFWlQs7WnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwotHOYg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725dac69699so3236005b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 02:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734346371; x=1734951171; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/IOYRGCuJyL4W5aS5tIFFhGj7u336MTqvrcn+JIIAm8=;
        b=NwotHOYgZ+EVkMDXyCXIRUYtPw2MubPBeDeZcOzg8shKQj4X7i7e9w4Z1+VJMosTRf
         IYeXSBLds57B9ENQEQ0rbPRFy+8He+2xePpPpwCK4vLSaaidZelGO17gBCKASefkzvZX
         F3MeS/31BosbC5I1xQ1f6NlAGh2gaRSW+rs6nZaHNKoFj1EycKdD0gYA8UTmUoFC46Ic
         LlO34haBafBzMEiW1sRjEQe3kNblkG6i5OQn8vVavGHvi4OApEclWi4Mgu7CgMbqMpZA
         mtEoLEX6kGKEuRWTOnlKExEifu8E3eOJM6fLgH0YmMI9B6iNk2Kinp7xTvUhwkSFG1V9
         8nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734346371; x=1734951171;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IOYRGCuJyL4W5aS5tIFFhGj7u336MTqvrcn+JIIAm8=;
        b=Cm8M0vuEzwcgFDTwQ+0ytAOqg7tueMxipp9fU+LXcaYe54qu5XFo+OdnjYG4IkV4Sx
         FMUUr3q79cqn9AstuZfVrwePyUJQ9uWPfI8CPwi/V1ijmZMRRtY6/tOjg4AVfNNCy74n
         Y1g0I/Trytk5HVkaObZnrGqUyESwocubzwejguLgeYcwdoWMb9q74poJ8SnWvvi67sxO
         XdlU1fMTBzN8ARfZcCCt4KaeUXrxNdcWywP0n91oNEZcfdIOeoDu79yYY8wXYNOZ6W/6
         FitIDAE/4+tykFpGIpd5a2KyQYUAl34vKBRt2rPcc0a/qPaiNAK1yVRwxQSGgLfSbb8d
         lWXw==
X-Forwarded-Encrypted: i=1; AJvYcCXUuOgQ5h6C0LcQRpyI4+hA7KlU1glwcaO2C4dfaOfx4raZfYQe93+NA6pkNzC30ZFrN9sF9jmB1CO+rqKWxXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMNcMRRHDiV9NzCKn8tslP5jW5OEZY8EJ0vXdupdtzAYOjVma
	Q1x6/TVPtttPxe+kpViqUwtstPw87ZRJiHm5Ayt1mRhfbRFgkI9c
X-Gm-Gg: ASbGncsxvOO7va/SXQ236YTHAgm11lRDBBuDvTekMbcuhVNBlbl1slXyBU7ynwOa7h9
	LdhmpFW5ylZ+yQ8gcEs8zrailiS+MEAnc2135kf15thBveDFi2SwHCX4q3IYkp9KQ5VLuC7cnE+
	+/ZXlzdBu3XyfxS4cWAAFZ51dHEz53/H7vfSMOwlVye1jFTJA/gkfCjFlgLGwK94M9PXQ6RMN/x
	G3I5qZcwZV/WZb6PUXWUt8wHqR5aNUfRGXtnzJ8v6JwOX/Tfw==
X-Google-Smtp-Source: AGHT+IFJiAlnaF9JAZcPmO5jw8NyHNzP1w/c76TAR3axPfE/oqiSHzw63fHzw/0e/V7mrANpQjWIRQ==
X-Received: by 2002:a17:902:da8b:b0:216:4b6f:ddda with SMTP id d9443c01a7336-21892a20f71mr165923095ad.35.1734346370592;
        Mon, 16 Dec 2024 02:52:50 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcb43csm40230895ad.64.2024.12.16.02.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:52:49 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH 1/3] selftest/powerpc/ptrace/core-pkey: Remove duplicate macros
In-Reply-To: <20241209151418.348085-1-maddy@linux.ibm.com>
Date: Mon, 16 Dec 2024 16:17:56 +0530
Message-ID: <87pllr52g3.fsf@gmail.com>
References: <20241209151418.348085-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Madhavan Srinivasan <maddy@linux.ibm.com> writes:

> core-pkey.c test has couple of macros defined which
> are part of "pkeys.h" header file. Remove those
> duplicates and include "pkeys.h"
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>  .../selftests/powerpc/ptrace/core-pkey.c      | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)

.../powerpc/ptrace/Makefile includes flags.mk. In
.../powerpc/flags.mk we anyways add -I$(selfdir)/powerpc/include in
CFLAGS - so it will pick up the header files defined in powerpc/include.

It make sense to clean this up and consolidate the common header definitions
into pkeys.h header file. The changes looks good to me. Please feel free
to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

