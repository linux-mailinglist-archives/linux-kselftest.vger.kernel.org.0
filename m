Return-Path: <linux-kselftest+bounces-5659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9086D04C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 18:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE7F1C20BA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346E05E082;
	Thu, 29 Feb 2024 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5zadmHE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F538DEA
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226914; cv=none; b=allkypX5ZiQgCmZd4+4Pj4E5MOSkKWro1pFE9915b1l/3znnYxJHbRQjRB9ZyCRUBhHGcPqBg8e1JPXDcMsRRVPWNlvHsaO80NNPhk0F4K+q0oxxGO1WYXmeD93i7s+okcRcQGZAbVl46NfmuAHemaKim6zq8+l8r2vZvUsuMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226914; c=relaxed/simple;
	bh=IBjqzoxRRfGUpQb4DxSibeeViO897QRlqbrOYsWI6OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W88JUiGlsfItoB+NUawyZbUmM/B+eOtpHZIOGhNqobV7s9w0AEmAhh2kQ/hCDgBQlU1ON0AdnyPxSNtO4YO8iiXf35ncaGA12yAWVoJGV2FYXkeq754QyihgXCNSNzceA5Ujyr+iSkl2WlcfsSifBKNU314IOxXsALMp/ixUtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5zadmHE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-565a2c4cc1aso1819903a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 09:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226910; x=1709831710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1Zw5VQp0F6Dx4Oge15y8ses9uRS5Ow56YjY/TYeF0w=;
        b=O5zadmHETgNQ4BRWjSPWrZ9XB70QdLv6NUSxiqUiqPRcBikeCPHkRTn1/m4mCz2VeW
         +0I5vTDU7lb1QN4eQ8QE83et4apCWZ3sSyxTdzwA6h7CK1L+noYcVDgUIgbirmpsssrA
         oy64P65S8H6HcQ/0seuWHVtwDWnMfJFmUMqdwQ9L3/FYhh/dj/sLg1bxa8eZIip3N+6d
         FQ1MClZ/VrA7kt6ixvd3vj8sz+96Z9MGTtuxRk5fu3R3XleJZDoiB4kPWisf/MV/RMja
         EauSdFJNl9sjGsoLF93wQB1fN0j6XZ+oBfKjvnaucdfVSU+AUm2DhMg3l+1CU6hfOvsj
         Rhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226910; x=1709831710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1Zw5VQp0F6Dx4Oge15y8ses9uRS5Ow56YjY/TYeF0w=;
        b=RveXeWC4YY1RE8+r7BDRyARKwWxQBO9xCf/XLhWPp7LAXUagvso7blbo2w3RhszrkX
         9K/ZrlRt7b8rPOpdZuqYPiDyOkBHBSeG3Y3vo+CmV+LBd+u2i9avY1JNmuTpJmpFw32L
         ZLAQyVPJNmhTp452sxexu1EaA1bkvLXXex2Vxfarfaji/YUcBnnfQ4kRzZaVCuqlrevZ
         UtPqAgGV5oAi5Mlp73sxNS1ORSyfZ5baFxonLQtfMhyTokPxCc1U0TAN3oCfPXckYkL1
         /cOhhDXq/BLbG7qR2Vr51SUJEjbhoK6Ez59Wx2Ji5XEQPaLY5kqaVJ8CbCv9evWDC7oY
         mB2w==
X-Forwarded-Encrypted: i=1; AJvYcCVMMy0HPKUROYFUUz040VOpB7aZV2WuY4Qhwf/lzMYp2WTEgKWe9pI3F2Hb33uLgz62UIFAVgDcqXtWMbaGHTGDRlpnTBw+GIMnLrdfo+N4
X-Gm-Message-State: AOJu0YyiNRDiPSp8RnTN3PO77Y4HcBswlNjSB8q54fCI/SHHv0bvrEOw
	5HLeStg4wa/dlS/B+HJRU5jruS/ZAFk5hPak/q29wNG6UjTDUAc8FFdDGBGv4qepyR9nLEVY971
	f9t2dnyyxxVYNDfEki1G3YQue8uiNYFarous=
X-Google-Smtp-Source: AGHT+IHQS8BwSw9lEJ6rm/Chxn2/ElOL/HSgC3eW4gh3iutYz8oEZt4qX35nDw5NEmCOvaIIPFe2P9qHDAKzdSk4GlQ=
X-Received: by 2002:a17:906:2653:b0:a44:1180:9c18 with SMTP id
 i19-20020a170906265300b00a4411809c18mr1939553ejc.55.1709226909753; Thu, 29
 Feb 2024 09:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
In-Reply-To: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 29 Feb 2024 19:14:33 +0200
Message-ID: <CAHp75VekfCq8c9h1k57LRjs2GZQ+ep9SdFbEWbDd98z_ySQ+Lw@mail.gmail.com>
Subject: Re: [kselftests/powerpc] Primitives test build failure with linux-next
To: Sachin Sant <sachinp@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kselftest@vger.kernel.org, 
	tanzhasanwork@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:53=E2=80=AFPM Sachin Sant <sachinp@linux.ibm.com>=
 wrote:
>
> Powerpc specific selftests (specifically powerpc/primitives) included in =
linux-next
> tree fails to build with following error
>
> gcc -std=3Dgnu99 -O2 -Wall -Werror -DGIT_VERSION=3D'"next-20240229-0-gf30=
3a3e2bcfb-dirty"' -I/home/sachin/linux-next/tools/testing/selftests/powerpc=
/include  -I/home/sachin/linux-next/tools/testing/selftests/powerpc/primiti=
ves    load_unaligned_zeropad.c ../harness.c  -o /home/sachin/linux-next/to=
ols/testing/selftests/powerpc/primitives/load_unaligned_zeropad
> In file included from load_unaligned_zeropad.c:26:
> word-at-a-time.h:7:10: fatal error: linux/bitops.h: No such file or direc=
tory
>     7 | #include <linux/bitops.h>
>       |          ^~~~~~~~~~~~~~~~
> compilation terminated.
>
> The header file in question was last changed by following commit
>
> commit 66a5c40f60f5d88ad8d47ba6a4ba05892853fa1f
>     kernel.h: removed REPEAT_BYTE from kernel.h

Thanks for the report.
What is missing here are the steps to reproduce it here. E.g., I have
an x86_64 machine, I can use QEMU if required.

--=20
With Best Regards,
Andy Shevchenko

