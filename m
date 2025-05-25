Return-Path: <linux-kselftest+bounces-33747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF6AC3256
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 05:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D8A1898245
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 03:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48307145B25;
	Sun, 25 May 2025 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Zi1Tim"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D08488;
	Sun, 25 May 2025 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748145300; cv=none; b=cvv6+8hE8NZJ0yNDW2GIXdmoYEvgLI4W0rq7OZ+Pe32KC5cd4hGLfxbCWBLnRRUY/yD1yn6xhQeRg3XFUe5kC4h5gJijdDwSxEBEOWzmgcLyd9UECCP/HLdn5kiN3u8zRA3SRt44cqQW3QjG5B50puFjkE1UUtnUBtYTebR40+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748145300; c=relaxed/simple;
	bh=N5Ejj8XafqIvwsSIiOEV/o+VpgAASxAANlvjGUxKlgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGmsgZjOC1cSXLor3AaOvG4o9aRYzLyavmnK2gd1SrH7lkMqkvZiItcu7Y8Bls4g/Q0qeguEwAoMK72ZDJfAy04Mnv+wxhQP9xQhAwaVJAUVQA3xU3CF/ecwOejoAOvqs1GLB2FN5EJqEMwql/VzkBR6TZjYZyH9KYVMGLWuW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4Zi1Tim; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742b0840d98so758024b3a.1;
        Sat, 24 May 2025 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748145298; x=1748750098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBYqFjWNmnPBuMr9KqcXFoSjNcF6sXA9Z8iI0N2NkR4=;
        b=O4Zi1TimCCSNrOxRVL/uaxuu29sXn0Za3f0V6brdYvBcCeZwnKUsfXP3wgycqbGZC6
         ZZqpnRYyw0JOf7gbDJi2p8fGvBu0ileZoOQ2oLCi8qvAOCfjfS1TbUUkqRbNAegmuoqh
         pc9Ukxll7IkPMGlQyJS9B26QBWfGCOXaTGuH3mMWUuU1cmWNsO8BhV7vSiWJzVjOmNgM
         PBNym5a9jxX3qrXFg70zXKgnd3uhmUtCA9MazJa9MS5+jy873IhM2F1/DEVKD5zZsrVq
         B6Cno0UCR91rDvu6cr/Ef2WfMWF8GKFv7bFQKJzAn2WlQRxOnNXNEOi1lZqjKNYUuMHj
         dsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748145298; x=1748750098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBYqFjWNmnPBuMr9KqcXFoSjNcF6sXA9Z8iI0N2NkR4=;
        b=gc19Mc+/Elflwskn5IaRbtxl/qNyvC3eETTaewgzWy/2EOXGgYNCnlbQtz/++xu60l
         nJbkkmMRcHXAFw02+orsRk8Hf8ccv2p0BLU0y/efheOkT/b1g7jA7vDi1iFuFF6xyCPv
         i3JQsdXLmGJ0ZLeGU7LUSf83BdzktVdG38vxVccSXgML/yf5KcM1Vnyu2jGm72DBiT1s
         StvbG4QO9NkG4d/QjOFyQBW3IJX4G8FGssEMa+0j2qmGLiafip48EYfLv56VGoLvwZga
         Q6elIDisSYNL6fGe/TUXHNNnOaO46c+zO1fRlisHy6KYrbpf41canC5FFi3dIiyrXNLX
         pV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHZ/k1yLlH5yfK02H6jee3YEsaXUctANcnbgvC0e873LRCD5QjWEkqQBXEA8NDS/C9Ldr3JFean0wGYgVtY9BS@vger.kernel.org, AJvYcCXQQ4qwzQnAnInSMaxeWOHufVXru8YVP9YtkGLEvGRc3M8cipJXYjyrtNArcsByQePSB8UU4sjv9sS2zY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvHnjaDz6JwaV0dTV8Po6+ymX9yjEWVuj/DDZkfKr/X4SF/SYS
	2fNZO3UIc6DnjtbaADctvCKCAWRpp19Tj6fFqhTo13ef77pkrPrnFwpj8jtODOD8aI8=
X-Gm-Gg: ASbGncu5k2Lw++rZyccyNl/MRFIIzFfuwTwkopKia6ZxTRXEL0m59g8zlccSqGEBYHm
	Etd9XIWy2GGCwHEZCGQXN1/fT4V4On+lL9NX96ZTZM7jIsMBYsg41z3/Ab0Yo2ECIiyOpeTClr9
	yAwoZGZ+JDi/sr5UmVsVAO33CebML5kkyqwvXuh7KhDk/DnfRYbyfkx85BcAV0e1U2LE4Z60Cnn
	jo+tM9cpcZcvKhRNVCDyuDmrnpWh8Gk8pFsbH1ToiDKwjGxho4knuW6TC1H+l+e59Z8FXTEfJr+
	hfnP4msBRCJ/JZU0L4KghezUpQirwpAoNDvmKYm7uiXfUk9mdWP/ao3geGRGRuBHxo8jIXNS
X-Google-Smtp-Source: AGHT+IFra/raW/ezrMCkU3wfDw/IUiBIhbnDyJ0d4yeScgQFnaaBeXOBOyXy0PpT1LGdszvhe1WB4Q==
X-Received: by 2002:a05:6a20:d04f:b0:218:17c4:246c with SMTP id adf61e73a8af0-2188c251f5amr7180651637.14.1748145297765;
        Sat, 24 May 2025 20:54:57 -0700 (PDT)
Received: from seokw-960QHA.Davolink ([115.137.3.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb084cd2sm14850465a12.54.2025.05.24.20.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 20:54:57 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: skhan@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	seokwoo.chung130@gmail.com,
	shuah@kernel.org,
	wen.yang@linux.dev
Subject: Re: [PATCH] selftests/eventfd: correct test name and improve messages
Date: Sun, 25 May 2025 12:54:52 +0900
Message-ID: <20250525035452.12238-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e3a43bd2-261b-4bab-96ad-216ef4f0d1f9@linuxfoundation.org>
References: <e3a43bd2-261b-4bab-96ad-216ef4f0d1f9@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, May 22, 2025 at 03:47:27PM -0600, Shuah Khan wrote:
> On 5/13/25 01:44, Ryan Chung wrote:
> > - Rename test from  to
> > 
> 
> ?? missing description of the change. Looks like the patch
> renames the test to fix spelling error in the test name?

Sorry for the missing description. I am not entirely sure what happened
there. The correct description should have been: 

- Rename test from eventfd_chek_flag_cloexec_and_nonblock to
eventfd_check_flag_cloexec_and_nonblock.

> > - Make the RDWR‐flag comment declarative:
> >    “The kernel automatically adds the O_RDWR flag.”
> > - Update semaphore‐flag failure message to:
> >    “eventfd semaphore flag check failed: …”
> 
> There is no need to list all these changes.
> 
> Please check a few chanelogs as a reference to how to write them.
>

Thank you for your comment. I will make sure to do so next time.

> > 
> > Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> > ---
> >   tools/testing/selftests/filesystems/eventfd/eventfd_test.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> > index 85acb4e3ef00..72d51ad0ee0e 100644
> > --- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> > +++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> > @@ -50,7 +50,7 @@ TEST(eventfd_check_flag_rdwr)
> >   	ASSERT_GE(fd, 0);
> >   	flags = fcntl(fd, F_GETFL);
> > -	// since the kernel automatically added O_RDWR.
> > +	// The kernel automatically adds the O_RDWR flag.
> >   	EXPECT_EQ(flags, O_RDWR);
> >   	close(fd);
> > @@ -85,7 +85,7 @@ TEST(eventfd_check_flag_nonblock)
> >   	close(fd);
> >   }
> > -TEST(eventfd_chek_flag_cloexec_and_nonblock)
> > +TEST(eventfd_check_flag_cloexec_and_nonblock)
> >   {
> >   	int fd, flags;
> > @@ -178,8 +178,7 @@ TEST(eventfd_check_flag_semaphore)
> >   	// The semaphore could only be obtained from fdinfo.
> >   	ret = verify_fdinfo(fd, &err, "eventfd-semaphore: ", 19, "1\n");
> >   	if (ret != 0)
> > -		ksft_print_msg("eventfd-semaphore check failed, msg: %s\n",
> > -				err.msg);
> > +		ksft_print_msg("eventfd semaphore flag check failed: %s\n", err.msg);
> 
> What's the reason for this change?
>

The error-print was reworded to match the project's logging style and
improve clarity for the flag. 

> >   	EXPECT_EQ(ret, 0);
> >   	close(fd);
> 
> thanks,
> -- Shuah

Thank you for your feedback. It looks like there was an issue with
sending the patch as this patch was missing descriptions. The correct
version of this patch - selftests/eventfd: correct test name and improve
messages - has been reviewd by Andrew Morton and merged into the
mm-stable branch: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.
The filename was
selftests-eventfd-correct-test-name-and-improve-messages.patch.

Please let me know if you'd like me to prepare a v2 of this patch of it
there are any further issues to address. 

Thanks again for reviewing.

Sincerely,
Ryan Chung


