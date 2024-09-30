Return-Path: <linux-kselftest+bounces-18620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7AF98A133
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 13:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3491C203E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8445218C014;
	Mon, 30 Sep 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaRZXSQp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694026AEC;
	Mon, 30 Sep 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697289; cv=none; b=q7vsW6aAxJ8Wk7F9Sj5Oj6iMM8F+hTtaeoafO9M+qMbPjpP4ohKIWNIwIci87/4YsCfjocSXGu9KMtJNKzfsTiB1RQGA4Dj6eRyu7sHswkSFCHno/iJj7/iI0pjhxgpGTCx27AVt6TK9dbo6bbDGR58bqwR3XW/2dvz7kvHGWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697289; c=relaxed/simple;
	bh=6LreWhW0Fa8SDW7CDi5FN1XVRQPTC32Zs31DUoR9NWc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gn0OsSL7Tor/GsTpaIeO7hOgwHkC6oPq2CPjQ4+8gEcfKMID26kY1nzJAg86qGx5WTCOQgM8KfVeA3wFGFRLVIK8NnzudveaBJKqM/DPATSPDVBs8e2O23ETffwzqJj55CPVzpoTBS8wEZVl9bkCInTU2aNVJ0spa/0l7TWtrVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaRZXSQp; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-710da656c0bso1531053a34.0;
        Mon, 30 Sep 2024 04:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727697287; x=1728302087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LreWhW0Fa8SDW7CDi5FN1XVRQPTC32Zs31DUoR9NWc=;
        b=WaRZXSQp4RLEnk+KxiTHCXNhmAU551hTp62Q2MLxNYyvuxu4FrANNVx2oQCiPb5uNS
         R38UuimEPLLa0sIZz+yVMF5iOU0VVIyEIt4nPZzmrAPjiGP3SHCI9lX7e5J5k2Zfy9Kz
         tgD6uUr90qrFGax8k2EusFY+1aFdYfWc2xjKuLWq2IoK9OJnFPD2GlnEn6VLrzBuQtdn
         nxIcfkLIPTOLIFQ8hjaEUydaLe/L5H/2VtOOd7XAGH5A7uPVkixD671Tp98iX998r2S+
         WD7XKKEOE+nOSgwUqOtA1AHX7yPdKrIAVGiiHk2xLfVbPYTThR+uyeRJK1kkjhdBUSIM
         tZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697287; x=1728302087;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6LreWhW0Fa8SDW7CDi5FN1XVRQPTC32Zs31DUoR9NWc=;
        b=HowAmnHWA95FlKXv9Fhu++XZ8qEkNWchb/qm1BDYwsvQuVMd+f5cj0clYSDkn7BorB
         cqajp/Tn7QWX78xAJIzuv3HntEbBn12dPHbQNwUVWEg2dgxzDoeZ7/rrg1V3hbAVpNjr
         39QHhVc3AJ+UrNdi92zoEmwc/yfhDsSzG91DxBMPAWz3TvpBH1Py8z6bvqFCVJfbkmKp
         IJDSsBMZveRhveFuLWXxsdVofFds7UPwZLwVNEzuyosdABjzWuzpe8tSR5VSuA8U+oNh
         zchSd/J6vmBYuO+c0LyycTa29O5jLpOD4X2USzS6MnmyxW9bGZdIYsg73in0fAZJ+Xy8
         DSIw==
X-Forwarded-Encrypted: i=1; AJvYcCVAcMhdId2H0FYS22hvnVEpnecOqC+bGIEK1++f1iwcX1R77P8xPjiKdl5txQdmZfrkDbep7f2E@vger.kernel.org, AJvYcCWc7ylzyGBrg2Md6OwCXU0F3KIcthQqqS+p1ekPjh/9hsiEA0hpa2C1NBF+8/ejFpMAmf5+L6y1UzQKFnSEX34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+d8GUJrIeLuYayhKf/lNmFTqPg0uXbyzTJpUrNwO/qUq2nU0
	miVJeioBJygkwUeOxHwN2Uvgx2t0s5cF67tfqhZtkINxaole16Fu
X-Google-Smtp-Source: AGHT+IGkGsY8esK8eMYKVyA+Y4pN91wR2RE7qdpfq8GodAab1cmemEBoa6mdhamVVc3KU4jbXjHvDw==
X-Received: by 2002:a05:6871:582c:b0:277:ce3a:9202 with SMTP id 586e51a60fabf-28710bb5a34mr6725666fac.37.1727697287215;
        Mon, 30 Sep 2024 04:54:47 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377ec00dsm404286285a.60.2024.09.30.04.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:54:46 -0700 (PDT)
Date: Mon, 30 Sep 2024 07:54:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66fa91864f534_17d4532943a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoD+Xn0s01ZqfaTRcUOLU7HfLx06FcWKabTcenCXPnXoQQ@mail.gmail.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-3-kerneljasonxing@gmail.com>
 <66fa808374566_17948d2947c@willemb.c.googlers.com.notmuch>
 <CAL+tcoD+Xn0s01ZqfaTRcUOLU7HfLx06FcWKabTcenCXPnXoQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net-timestamp: add OPT_ID_TCP test in
 selftests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Mon, Sep 30, 2024 at 6:42=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Introduce a test for SOF_TIMESTAMPING_OPT_ID_TCP for TCP proto so
> > > that we can get aware of whether using write_seq as an initial key
> > > value works as expected.
> >
> > Does the test behave different with this flag set?
> >
> =

> Sorry, my mistake, the last email is not open to the mailing list. So
> I copy that here.
> =

> Not that much, only at the very beginning, this new test will use
> write_seq directly.

The kernel will act differently. But the test does not detect this.
 =

> I once thought and wondered if I need to setsockopt() when one or two
> sendmsg() are already done, then we check the behaviour of subsequent
> sendmsg() calls. Then I changed my mind because it's a bit complex. Do
> you think it's a good way to test?

Packetdrill is more suitable for deterministically testing such subtle
differences.

I have a packetdrill test for OPT_ID with and without OPT_ID_TCP. It
is not public yet. As part of upstreaming our packetdrill tests, this
will eventually also be available.



