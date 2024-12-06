Return-Path: <linux-kselftest+bounces-22930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F289E79DF
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 21:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9390816C7F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA91C54BC;
	Fri,  6 Dec 2024 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjTxrsnM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841C1C5490
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515987; cv=none; b=eV4A3P4cFAE2KUtegbn4cJpWD0yvLNlNjZ4TnK6LX/L3Mn5D0sGRgtPwVuhKvDG3G0gI42/U2ZHOw8kNGHFZd9n1EvDkD1TdD++5A+XPwEz1pJsbbf7nqzMvUFkQo5YWuFopcC7NcpWkHjBNLjhy3XG8iR0aH27F/Nzo7+AdsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515987; c=relaxed/simple;
	bh=ZwHCCB0W5SJvZTh2Ug+0qYuqXUTVXSaDgcxcsJ9vGFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFgCpJbAybAqufaMY4leiYyROp528aSIakufkHCSbIaDYjl8luJ//QTS6qqjsHckCUUWXL3dUEAsEP4vUwq0BdZSmw+5dh/oVCJSI18zfdRr9fGiC9VE2/jwsDRAI231ngtmBspzvol0WKflakqyNr3wR7KzgztII1YWFWCn7tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjTxrsnM; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e39fb8548e2so2079909276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 12:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733515985; x=1734120785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt9PLA+P5fzzVESWLOIz6dAQ1ofEMi70x4/Ada7rM10=;
        b=HjTxrsnMBQK4azsq7ofTGW/n2iLnINgRu/0DPAh5ah2uZI2683BQcNuuBACfHNkcbe
         UJaZWpJUdCN8awUnL0AlYfbjXpmI/KeeuNtByrcxe3+8DU/1qgp0DbooiWLjAY1GcKNF
         C4JNV4obCacxIc+j+Z8gv5kCY5iZZLNGqoQZ8WPBTtzAO4I+YUW+PC6ooYJg9a57CHt5
         9FDXVXMbnCvmPmdP02TYPejT3oSfbhGCdtG0TxFp17EA4bJtaPQ+6ZlI7jgyZOSef3bm
         InlaexM8Fd1Tj1+E14B0rrd9A9K4KouU2jOEOINDnouxYseKPOKrv7JzN7RJlj5LsTGi
         jn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515985; x=1734120785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt9PLA+P5fzzVESWLOIz6dAQ1ofEMi70x4/Ada7rM10=;
        b=gDdVsk18OUk0bstUn78mla0vcCQePDK3ayOKrnTeSuUu7ymhvcdCT60ryCp466GFqo
         kI0biFmXpeexEWZNJ54322zIm8kdTwI8VwmJKE1yn78uPv/beUEX5UTEXymeD6GzhGaB
         fNRweyF3kmPmtqU8BI3fK7I1RV/dSKb2nJi9ShgBZ3a/ERRH4Jlu7Nl73nc/AoQ9pEJE
         iR/N4EA4xn6QeAK2r6++WjLV4PolnOESfhwN6IPsD21GkRgwQMtlA/s2Hm1LCfWgsxuG
         txMI67/omEM6Q69qEi2NBIjcEjgEeIdLdnXJYi7PoPyp/YHCkZBIPQ3yTnHsHt1CoymS
         ghKA==
X-Forwarded-Encrypted: i=1; AJvYcCVr3Zf5V4bM6cBN6SmLLOIOIhH38u6hAbi/nP4d9T9QcdJ58f9voQt2+gEiju62ns3ClbTBtHhrkrMxJOZM7+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxLCAH7sLJ5IonrJw8EbzcES52xPHWX7/5x1/jfhiCbDdmaPD
	H9xBmKOFYILpGD/G0hFaEVXq5HYkcIwxb55CR97CMGHo2o03QcKGu6CeH4e5CL2MbraXiXfcKKO
	S2t8igCUMBfFSFvrsTNDcEF2WlHKR9eis
X-Gm-Gg: ASbGnctDctyncecUyAXUGcFyY2PMtsjsEVW3TyNjV7+FEPTUoi94leO5jLnvrAU1vwF
	HL8kQy4DCHifsBQ3HImRD4mUciK6cU0Fj
X-Google-Smtp-Source: AGHT+IEHwEdtKyepsA1tEBA9yst1lJBZeCXpqJl2DcfVnXJlMcX3uxRred9ak1SZxt4+z9o8pRajCjN18nWYbArgGYA=
X-Received: by 2002:a05:6902:2b8f:b0:e2b:e0ba:d50 with SMTP id
 3f1490d57ef6-e3a0b072fccmr5847605276.5.1733515984995; Fri, 06 Dec 2024
 12:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205114757.5916-1-simeddon@gmail.com> <20241205114757.5916-3-simeddon@gmail.com>
 <6564cc2e-745d-49df-900d-263177c1ea19@sirena.org.uk> <CAGd6pzPEUun=t4=DGauX-zGhzMnDJsEcHGwZfH5DZkwmffeC-g@mail.gmail.com>
 <d942cddf-1600-48df-8819-7b774ea603fc@sirena.org.uk>
In-Reply-To: <d942cddf-1600-48df-8819-7b774ea603fc@sirena.org.uk>
From: BiscuitBobby <simeddon@gmail.com>
Date: Sat, 7 Dec 2024 01:42:27 +0530
Message-ID: <CAGd6pzPTH=M79g05OV5YbbkRZkuVX=1BN04ufxJuQTDxY-26Kw@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests/lib.mk: Introduce check to validate
 required configs
To: Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, mbenes@suse.cz, Petr Mladek <pmladek@suse.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 01:20, Mark Brown <broonie@kernel.org> wrote:
>
> It doesn't remove existing barriers but it's also not obvious that this
> isn't just a generic dependency mechanism that should be used for any
> old dependency rather than things that would actually break the build,
> and it's one config list for both build and runtime checks.  If the
> intention is that this should be infrequently used it probably needs to
> be a bit clearer that that's the case.  As things stand I'd expect there
> to be some confusion about the interaction between this and the existing
> system with specifying config fragments.

I shall update the commit and documentation to make this more clear.
Thank you for the feedback.

