Return-Path: <linux-kselftest+bounces-17200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9301A96CD3E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 05:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C427B24CD8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E6146A68;
	Thu,  5 Sep 2024 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNX5/usb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D313DDDF;
	Thu,  5 Sep 2024 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506832; cv=none; b=tgYFN9tmTBR496t31udZWb5vDX8PHflAdPka9Ixex5bH8KI+Eat82ortlQ2fdn1X8IdnW6BOfGXWMJ8a0hO89KR4sZYDuSjbpt0j7wtIOEQx7qifIhHzKqhLYJUd8vpzk5JdCH94hvf99vsQiQ6XdQEUy+3tZn5LW0aNaoikr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506832; c=relaxed/simple;
	bh=493Eu9NKzhahlJEPDLTDCyuodJroRApduA2tzcVfPxc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Z9b6wHJGVKHMu1DYlbR398FS7DMqKYPDx2Z4DDRnVw7VXh7QrB3fcGrtVUn6RYR03wY2VEtBXTJHdCv4MOcqvsMauIQItQaWoxCDRpajg0nYlKn/zOlrQGXF8SF93ElrHTz0RH7wa8m50mY2TH6b7Q9Tz5vrlZe8GB04KJsotgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNX5/usb; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c34c2a7dc7so1530516d6.3;
        Wed, 04 Sep 2024 20:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725506830; x=1726111630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwuLql25wk1ZI2iRiYl3cYZG1VFWAXiw54D6jDWYUOM=;
        b=KNX5/usb2vWmqbekOkkxmIgni00NQRIsjM5qf4NCm6sRzB4+bHt1Uc/ccenr74nLy1
         TLPnmToRbOquztAFKrMzuy7UIsPucYi00OqJQ6nHEyYUpDN362hcrR2YNOdgH+avTCEb
         wFlrUaxe7EDG4WXJP9n4W5OuD5MC0KkivgnVMx8rsmIz9IeMl7htViP8sfp3IkhcBiPn
         kIWX/BbihrjEET3FeBagHXGAaAOwvCxLWXJ9onJK2QHFnUiN3dvY5gPDOKgH8yLo7DyH
         2R6vRT6UlOFT8rItXRq4h7TzgL4Nh6sMx4H1JUNDDmITaUnxvKY2MtbriHvMl6RggGid
         czPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725506830; x=1726111630;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hwuLql25wk1ZI2iRiYl3cYZG1VFWAXiw54D6jDWYUOM=;
        b=eVhXQIhG/3J1HKLw7q79rLWvNfY7jvMWqvqPYu4Rcu1hyV/Y/DACe+2TEm0X5lsaiy
         oWGyc1yfHINjzUXCVkfMcicAxtimzYvOQUK1HaSF8/66f92O9z4GLE4sSuctEybiDtcI
         L8nNBuXc2JiwqsbJ3XndEE8xsO6mXJm/1Zg6eXfmb27rx/0lthqKeFcX0Ta0GTWUV7YG
         6j6ERu513Bk8OAgx77Xv6duEJYtxzb+8blbI0TZQ3dZvhqUXDNdUqK8i3doI6FNtvLtJ
         TKJX7zCt+jVW+OzIZjozI14cJ3BhNoOw7LOQuXYKHiQL4g2AypxVqKcODrJ40hKHM9ZZ
         41YA==
X-Forwarded-Encrypted: i=1; AJvYcCWBA+HXtE7hFj2XAdkuWVpTjoLjUhW5uQSBfwc2Z+DjIO2hk67gyQwp3Ny4XpdlJ1PGGU4j7NbyCnIM6lDXf94=@vger.kernel.org, AJvYcCWX6hD5IZyGHpIMwsnjkpwv4YqwYsscd7EOdunoO44APFAu3sM7/z98oTaZb1InuA06ezemxS3+@vger.kernel.org
X-Gm-Message-State: AOJu0YwuoyZifoqDn+jBa3d20DotMainMUg8n8p97z6hQfqriD31JsKB
	M77t9GCos7WMYvzCzUKxS9GbG4WFBa/acUYXaJisXmKwYH/V/Vul
X-Google-Smtp-Source: AGHT+IHOXLo6uy+QutPCpztdJUarIdNeFBLSve+ANNQtmwXibVO3mRhb+6rQIJT+TTGB3UuT/DHihQ==
X-Received: by 2002:a05:6214:5a0b:b0:6c1:6b5d:8cd with SMTP id 6a1803df08f44-6c33e6a7d9dmr294770896d6.49.1725506829880;
        Wed, 04 Sep 2024 20:27:09 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201e4152sm4215446d6.32.2024.09.04.20.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:27:09 -0700 (PDT)
Date: Wed, 04 Sep 2024 23:27:09 -0400
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
Message-ID: <66d9250d17916_17661d29484@willemb.c.googlers.com.notmuch>
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
> 
> But then again maybe we should give up on the idea of using directories?
> Use some separator like --, I mean:
> 
> mv packetdrill/tcp/inq/client.pkt packetdrill/tcp--inq--client.pkt
> 
> Assuming we're moving forward with the interpreter idea we don't need
> directories for multi-threading, just for organization. Which perhaps
> isn't worth the time investment? Given that we'd mostly interact with
> these tests via UI which will flatten it all back?

Okay, went with the simplest approach for v1: indeed just flattening
the space like this.

Only after implementing TEST_PROGS_RECURSE and PRESERVE_TEST_DIRS.
Both make kselftest more complex and in subtle ways that could break
existing tests.

Also simplified the interpreter mechanism. Instead of requiring an
environment variable, look for a specific executable in the TARGET
dir. This will make the test just work when someone does a manual run.

All is tentative and up for revision, of course.

