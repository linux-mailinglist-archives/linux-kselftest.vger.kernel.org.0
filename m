Return-Path: <linux-kselftest+bounces-46138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F8C75FDF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 20:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54F674E1657
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573B3612F9;
	Thu, 20 Nov 2025 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWB+30XZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4575B283FFB
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665351; cv=none; b=MifcURQGC3KUWSA5xfDt/lIzdvqy4iwcmFSgQQo0CnYYgstHClNxxQ1t+mYgpTE48nlZ/+aETrYY2SxyiY837z0CsUodNmiG8ldlyx0puKWWmd1tsuiCeATDNbDojCsa5lXsm0Bc2RynpOaLl13QYJMCe7UQwasUPqQVCDX+dO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665351; c=relaxed/simple;
	bh=gZXuJmBaVg7aPMWMII9QEeNHi9TbulCijsQPLIvEFvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im/HlWDHwkZxIktLqaDfiBhZfZPuJjD/XjneBH0d2nQyDyKC47xGhJibtlJ+eHrjdoL7TwMH4jE82B/26OJTojqodY7V6DiW2uOv+y1kHacr+VQ92jiJeTvFcNq8G/IGkBg8MMwbEBS4jShcQiWNrB6XUT8iTG2OemRNKGn4bCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWB+30XZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so756895e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 11:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763665347; x=1764270147; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUk7F3OiQezqpI/i6F82zzEyxwA4n2FgbJ6n9Doemj0=;
        b=IWB+30XZJWfymEtbhXoEzbLudbAhp2zzAn8X6PJnpJxs615v2kUqWDSsb11XUcOM8E
         mBJ8p7w888mgni1J8f+Tcna4isc1U4pjMQqv5U88MY0ql/9Lkeu6nMk4DVN2ARHsOAmB
         EePBARKQqUdFqNUqs0rMQSLeCiZRr8Wvo7ZlO8XNmHegQPCBoOA86kDU30Mn90LfBbt8
         jNiVmylzqWNxqkayuhxDcWw07pVhyo6iZ1qHqK7l93oJgzJJZ2qi45fwrMX+itJCj/EY
         7GrV4y2X5PhwZ/xMPiMMvyM0ysBT/ETAFx4rvFx8yYEp1heBOieZCqaTMpT6O8mnfFoS
         Dhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763665347; x=1764270147;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUk7F3OiQezqpI/i6F82zzEyxwA4n2FgbJ6n9Doemj0=;
        b=DMUyA15kh9pfBHNJ3gCHW7O6PjNSB8GKAVkJHHviNexfbcF/+Cn9KKNTd+T9Xl0GsG
         ZVGUCduX9MuW37UNYJ5TAZ97/z5i+vh3Y4qjkwl//ajktolGp1TKqRbZw7NGskx3YTAJ
         ytd4DV7pJ26IifheAdcKckTBjFvAJHp6DZIZ8ORj5OGQSFfQKwFqlrd695A1IRlS8mvB
         ngJTq+S+X9qYvx405U0G9u8VKbVEw0F15VsLrO8bBcZZ//AZi+XZ6pvf4WLjRc88vYnr
         T6LEwML0pgLibM0KyX057P9ZqTMWEgoMFSWoV45c38SJGyrObuAsW1v8q3Y+9MxzHQm2
         Q1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFTCh2Qv4+PvvdoQUKBkhq6gIlhVSdl1TjFAfzTQAX3mBB/WsFv0yFVlU7ZUot5+OJJyf6925WXKCqi7NM+Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3mwEtR2H7hrRmDOTMACWepviUW5SbGB70sBPvAb6lf5SMX9U
	aF1dJDKZQjFZ3fNzz5uJssRE5i1/K/MPhiPihE/HiNraepT/lvPbF9l2
X-Gm-Gg: ASbGncsc/ZDhpWQRLuHtH0sLdz3WARmDtHigrql1UALvjtvrnyuq0kAf20rvblB53ho
	1Jew4FS5O+6HId2EvzjvRoKOgvPGfd74plNwoPsgWd1lAm0gLb/o5EbxgEkVDlCM/IJZn9m8vY3
	tIn2DpDTaLedWGayViGIqdeFkqAMSIj5NM7mw5nm2S1uPOHJLWHTEHgjlotO/ojbNZEUuiBLBpF
	bzY/3VS7AeEdJuHEBM+25QxpjvqUhMZq9QQDsFHwh7iZwgIXB+K8sGKgyDD3bQLScSCCmEbIKqY
	0aLqBf7ZQS5MZ3z/u+Di0ipd42Fq+NrhyObA01h4FXFkUNgC38u2ulNjUVBARJNt3A984M4xK6L
	JOr/sIYha0hfShjaxAGiPNIbI1EuU4L97+zxRXikq7FfMau3SO4ArvK1tG1As1zC+3L7oc8OrHu
	DmdktW
X-Google-Smtp-Source: AGHT+IEm7cyBl9sCriUUQUppCnGpTm7hcBwhjRia2+n5Yk+UR+NhXXnMSkR2YAPQMqM5M9apaOTEZw==
X-Received: by 2002:a05:600c:1c86:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-477b857907amr46992595e9.3.1763665347278;
        Thu, 20 Nov 2025 11:02:27 -0800 (PST)
Received: from curiosity ([80.211.22.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3af0e1sm3254925e9.10.2025.11.20.11.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:02:26 -0800 (PST)
Date: Thu, 20 Nov 2025 22:02:21 +0300
From: Sergey Matyukevich <geomatsi@gmail.com>
To: Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v4 1/9] selftests: riscv: test ptrace vector interface
Message-ID: <aR9lvboEcSzSjGNY@curiosity>
References: <20251108194207.1257866-1-geomatsi@gmail.com>
 <20251108194207.1257866-2-geomatsi@gmail.com>
 <CAFTtA3PK8kU6dsHdOT8Gj=ov9UbguSWv8+aQjtnvkx6hFWZGkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFTtA3PK8kU6dsHdOT8Gj=ov9UbguSWv8+aQjtnvkx6hFWZGkg@mail.gmail.com>

On Wed, Nov 19, 2025 at 11:13:36AM -0600, Andy Chiu wrote:
> On Sat, Nov 8, 2025 at 1:42 PM Sergey Matyukevich <geomatsi@gmail.com> wrote:
> >
> > Add a test case to check ptrace behavior in the case when vector
> > extension is supported by the system, but vector context is not
> > yet enabled for the traced process.
> >
> > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> 
> Reviewed-by: Andy Chiu <andybnac@gmail.com>

Thanks for taking a look ! I will need at least one more respin
to cover xtheadvector support to both ptrace check and the selftests.

Regards,
Sergey

