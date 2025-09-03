Return-Path: <linux-kselftest+bounces-40687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0798B425E1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 937A14E51BB
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124D2289E30;
	Wed,  3 Sep 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbegsJB4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE21287258;
	Wed,  3 Sep 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914563; cv=none; b=et+5FTMwyi4znW2Wi6Vijxw8YbwvF1366E/yJ+W1+NwYp+Ke9oZeCknFyfcmPmyY3WFtd47sTDK6spQYMc/l8MhvEe2WQFVk2Ffpg6ipD/a5B+NUCRsW+eMDLisy0E+A5e7guLQ/+N7nyt/A5x+TZRXvj5+B9CIZhx81Y/+kuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914563; c=relaxed/simple;
	bh=Vs+2TVX6P+MA0FIJTI8WR59Uh1EZN6KJg5/PMwt7YoQ=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=JiUdoB9oDlrh84HSZLulkFhweKMLkWIqSJCVMUnkUy+vJBn1tpNe6Z1zfQkarbV19EY9XbrL1ijTWUIbUfpDIv7DOb7hy9hIiZyhsM8xaeuTnhpfTNxpYKK2wvPpiYvkea+YxD7jjeEHe5pSzjLKDoLDS5RZ2bAEJSpnrVnE6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbegsJB4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77287fb79d3so61912b3a.1;
        Wed, 03 Sep 2025 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756914559; x=1757519359; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs+2TVX6P+MA0FIJTI8WR59Uh1EZN6KJg5/PMwt7YoQ=;
        b=FbegsJB4k4Tth3H0jU2Gdt078Oxe9rysRXwKQtuVGURyXoiUPf5dnS2fZ05cF0xKCS
         T5hUsh/FlhOJdhApKvPBHjCMh2JST2Xah7Glb66bYnb7KSv033iiibO2ES1I+Fri813a
         QLxEyGF6d8x77aFjknGWScW0aZWUHQC55yftUNKZncJls7cDq7ulBFJclO0MG/D5LjyX
         noiASMz0kbBnPvuGrawqZ6VA+lKsCGsiRXHDH5xNsKp1YnyRQapwUiWZYV/fjdu1n69X
         +xuO65GGJ0qVrKZbx7U+wx312oM2ot+eT+XUYVRdCwY27eHrALrTTLEDcXpYKfUbx23e
         TXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914559; x=1757519359;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs+2TVX6P+MA0FIJTI8WR59Uh1EZN6KJg5/PMwt7YoQ=;
        b=Pl8n7Whu8Ovm40rlmHM5COK5AQZTLk07nS1Q6uEYdr0E/B9VvIihvTqzlVUT2WpPww
         9vbW675xFe7rDpOP+Kf+bDpsrKMZyQF5NOXftTDE+fpBk/UclCLTw8OAuSaQdZlHLDWV
         z+Nse6t5f3M5K87Sw8ep9jE02N4kftNuCR8zcnwb/GGNKePVjG2lUz87DowT5RfvGfR+
         +QsMpfGv0t+oyT5UIpsZwG6pQVlgiRvpo8Z+gpN15Kpbc0qPL3T61OZa8wgLHFZLVWiI
         nmLZc8wuaty8ZX+Ibf0DIVfWrTHlTLo6JfWbGlnc0Jv5/mf4wS9C3+tRsPIMnHMUioob
         ud2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcTn5qF/dIJ6dnA8ItzTVEIA8OXxV2mlGEBPmpsf1txCrv+FQL2FU6ceM2raDrY2XCX7tzAyW5lNG/spct@vger.kernel.org, AJvYcCXhK2416R7KQ/WsPkGCBZTwVjnxfSx/vYRIskpT/XMd9WVHBw0JeJznAKBR/FJfwoC4EeIpm1Xkl4UG0SK/DfHX@vger.kernel.org, AJvYcCXxjgVJe2AmaqwcMLQxju0qHezIXDomuYE/NelSAjYK9vPIOi+I7RiYRjOV5R8KxqLIuaMdpUOeZ4wcDKPOp8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6c1qZ5tjoO52WipnfUPqXAlEou/arGi1eZVuN1v+rejBMo8GQ
	MYssFiRdMVBiTt0KbGZu5XU7lNa1jlF+1IZ7+amyTNj9fW3q8TyVV4WbMtTRIEkx
X-Gm-Gg: ASbGncsfxjnftJua/AKwThhHw6YblGaSrjFkKSgKb8fkaeve7UuNVqR9MFY+JpsVOK2
	UJna3O918ZZMVMrYrrM0hCqzfSaNLHaK6ZrNclIUD7I/M86hwQXUmRBqnq5HBNJWfhtXL50V23Y
	dmpjPeAYz3mV0WColFJ1Cxq1cx5JkV48aEqHTqqYnoBnly2ilYq3xI3j2fm6+/6vTyc/aTrLpaW
	0i+8W8pRtOAygOpXcXQoyFeu3tVYzuVBSR0KErucsYob9vgvo4MGLOTeSyiMfTAqIbUhGhHw8e1
	e2jYor+ge6bxvh+z8RW7+K3pPoVxHiWbf2wOxDgwhCp8PQLN9Wvwn4Desaz/cx6IRwXoiAPAfnI
	gGA2Op7XPqj5H
X-Google-Smtp-Source: AGHT+IHEPuzcLvALXYq4AVPl2zYVTMkj6o7Fq/hq4L7YwMdmGzEqIh26wAxzw4dE7sdM5dK2Az4LBw==
X-Received: by 2002:a17:902:f691:b0:248:b542:d803 with SMTP id d9443c01a7336-249448f317dmr198535415ad.24.1756914559123;
        Wed, 03 Sep 2025 08:49:19 -0700 (PDT)
Received: from 1337 ([136.159.213.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24a92f897d8sm125285175ad.24.2025.09.03.08.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:49:18 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Paul Moore
 <paul@paul-moore.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] selftests/tty: add TIOCSTI test suite
Date: Wed, 03 Sep 2025 09:08:06 -0600
References: <20250902-toicsti-bug-v4-1-e5c960e0b3d6@gmail.com>
 <2025090312-pebbly-groggy-3df7@gregkh>
User-agent: mu4e 1.10.8; emacs 30.2
In-reply-to: <2025090312-pebbly-groggy-3df7@gregkh>
Message-ID: <87jz2fk03m.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Greg KH <gregkh@linuxfoundation.org> writes:

> On Tue, Sep 02, 2025 at 06:17:56PM -0600, Abhinav Saxena wrote:
>> TIOCSTI is a TTY ioctl command that allows inserting characters into
>> the terminal input queue, making it appear as if the user typed those
>> characters. This functionality has behavior that varies based on system
>> configuration and process credentials.
>
> <snip>
>
> Any specific reason you didn=E2=80=99t cc: the tty/serial maintainers and=
 the
> linux-serial list for this?
>
> thanks,
>
> greg k-h

My apologies for the oversight. I used b4 to collect to/cc addresses,
and didn=E2=80=99t confirm them before sending the patch. I guess since thi=
s is
just a selftest, it did not include tty/serial maintainers.

I=E2=80=99ll resend the series.

-Abhinav=20

--=-=-=--

