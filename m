Return-Path: <linux-kselftest+bounces-23883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B0A00DAD
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5223F16461C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7931FC7C7;
	Fri,  3 Jan 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrDmrANg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0231B983E
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Jan 2025 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929323; cv=none; b=qlTWVFxk8cIzXzvjblm5zHUY+NUVuQJduGunivqHHJjceqdF3lhgfmC2XCJcMz1DiMe+3R6pyFJ/iEiEsmrzcA+znzw9hQaCQDIff7guwVFkqZeg/coVjibXNvZ0mlNg/Ua86Mxbu2KA/t18ND6lx+YvUICskgoYV4vgT3w3brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929323; c=relaxed/simple;
	bh=QaOJp7HJHHdPaRMU0X9pZcayUF+tNiAnvQkPGvNtOFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZc9AF3++mxrk2L3FAyS86Mk0jzRLPXq7+ND5PrCxMleDzG8OIAg3Wnim17SA+2ivwiYNklUXcl/hYTq3WytbtmxCBJbEf1FFmvjXgfSlSM1t340ArN5Ni7FvwsnQ+PHPUUd+1/tzALZb7Q9bCgakCGF8n+NOxFRV8FltjR+HRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrDmrANg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso24035336a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Jan 2025 10:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735929320; x=1736534120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaOJp7HJHHdPaRMU0X9pZcayUF+tNiAnvQkPGvNtOFw=;
        b=SrDmrANg7bq7XatCTkHKwPS69xZ5LSrV1dCtFu5IYgNafX308iHdM25dLyTip2Uwo7
         Mk/IAs9mO3qjdu+itm4a4+Crs+egeCV8O6ml77OnLTqDgZv9eqDmVh/Ezjwr7XcE5r9J
         gJJ6HQa2WEzahZb0no3Y+xJKh2bR2slc61RSstB74BccLgROHKw+a+xVGGWOFNmAb9C5
         ywwhbNMcZ7Z/a0hnu6ZZXjIkNzFWLlCpbiiSJYVPz/W5KJ42APre/Saatx4QJE4ogF1P
         WMTc1cQT8MXR1A8azwekDOWa/n9dYUqb52DgpAM62vR0sXl7l+E2SL9S5dd5l8Uzr0xl
         SIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735929320; x=1736534120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaOJp7HJHHdPaRMU0X9pZcayUF+tNiAnvQkPGvNtOFw=;
        b=X17cyicKIcFRS4gJafl+bYwpV/AG88lyzl0wNhihaRldTk4WvHNbMqMDqx4VUOuMK3
         G58y+ZLec/5eaTP3IJ1g8jEMRY0Ql38e5SOQNFnUF8hb5pTs3k++z9o4pHRce3JjgM+R
         T2XQBcGRIvnNuI1NP4DV1Qbzl9mXmd3xNqcf+SjMcvw4DYv/gUVYiOU9MNKg1eugcXQ1
         g0BJ8cMvXKFIG5uZaUhyTfr6Q3kUTRk+NY6VVC5O8PcTXLFojwQb07ZlDECJVs/BxDWO
         b1zjJtWq6Z1mLI76HODhy4mLjmX8UBQntxo9za7aBBeiWRG2lfQsmcxtKY37LQ1xScST
         03PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpzattaUk87GexaK64GmUBl0pHObwoy5WQg07e7jMyFmGJieUnUuRP2JVO7si3ZkDQBQTKk7dQbtrAGAs7W8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0X77kbOfs6NdXJe5coq9ks4e8UDBpstQGzZ32uL8bfz+JQqQV
	rWDJXUy/L9ylxfv+QsbgAHWBp2DXT8sfY2c4nHEomPLl4GP6p+/6jFcpwEbWKD86w9CvdaRAZRy
	p/ZkvZZ+DctNdPxKUV7unG59iY12z+MMpn5+4
X-Gm-Gg: ASbGncvJksWWQFnjxCqHu4BLKllD6J1qlGe0dMFjZTHq7xmUQ0MZsZiO1VdW8YcDhBu
	in0VIVI8O3EbwPnjeDq/RpWw6m8OsiYwNwaGRUw==
X-Google-Smtp-Source: AGHT+IFb9aRY0DVrCM919IVThtD+cuQpRatmwe2KgRjXI1yw5UOYd+sHnm4XRiC0Xok2nGQctE2vtiWzgpKQdzLC68I=
X-Received: by 2002:a05:6402:268c:b0:5d0:d2b1:6831 with SMTP id
 4fb4d7f45d1cf-5d81e8c1309mr47104018a12.14.1735929319710; Fri, 03 Jan 2025
 10:35:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103104546.3714168-1-edumazet@google.com> <20250103182458.1213486-1-kuba@kernel.org>
In-Reply-To: <20250103182458.1213486-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Jan 2025 19:35:08 +0100
Message-ID: <CANn89i+oLRQmAeXq9wCfg6E3-_dEZRJtd1tn4W1OxpcKnwFefA@mail.gmail.com>
Subject: Re: [PATCH net] selftests: tc-testing: reduce rshift value
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	shuah@kernel.org, karansanghvi98@gmail.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 7:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> After previous change rshift >=3D 32 is no longer allowed.
> Modify the test to use 31, the test doesn't seem to send
> any traffic so the exact value shouldn't matter.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

