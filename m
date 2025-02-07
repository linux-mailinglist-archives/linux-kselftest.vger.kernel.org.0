Return-Path: <linux-kselftest+bounces-26004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA25A2C5AA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 15:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E0D3AA63C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 14:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B023ED62;
	Fri,  7 Feb 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzh4tRAN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25D22069A;
	Fri,  7 Feb 2025 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939078; cv=none; b=aAUQX4r0FHWQyjV4jgzyrssFGynKIiQofLViOKZvl2a90ssMKvjZV3UggiUIRpfI6Au5kHuXTyi+P0Y3zCLqH/niGFleKxY+MwBo0L+U/uAZqQiFrVAZheOj6PYroY7jPst/m4uvkVprKjxabKMbm/2kp7jnqjHlN6+MY9wtNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939078; c=relaxed/simple;
	bh=jqowGkYZ4pmesdH31UEgUiregsf3ZvUnQhKbvZq1sgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCNzE1qxfnDKBEwBK13p7/egEtexWvhU1ZTofwzNolpnaS91O6l5TudLkoVInzqdvmfXYhpLYHMfPVmOEhI41lnPmqoLdORzwpF3VrBNIoCPqTZ4rPTkPQHwcw+//8AuUSzkMFAX/xzuc/pfIJtShryPeFexmEepfHFJtF5ohhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzh4tRAN; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3061f1e534bso20624771fa.1;
        Fri, 07 Feb 2025 06:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738939075; x=1739543875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqowGkYZ4pmesdH31UEgUiregsf3ZvUnQhKbvZq1sgE=;
        b=kzh4tRANjnXcT+EcLbxA1kR9/zdPBCMLuynIzxuOh6i/DH2P9ISJwp4gpKb4E7v/x1
         PhybTFhPkY1mUMDPzxmrosRI1wYrU/O5xFaXOGmYMQpPWw28Av1uFA3qO7S8CIh+VWTZ
         d3AWnmcSPTTlai95ep/ysHaNkLD9HHXq8DgpbA9pChFwkE3JFr3CihFkOCZWjaw/isn+
         ApIYpCdVOfd1tjSMPlK61GFzgCU+XQmcozpTdZuVIN/oUAa0PjV6TkWTCkrz5BUb2bd6
         ztvc+NI9IJR1TwKjk3JAVCLVMl1qE4XOUfCxADsLha6nqrn5m8U4SBpmymwX4R5JJ9Ws
         BPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738939075; x=1739543875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqowGkYZ4pmesdH31UEgUiregsf3ZvUnQhKbvZq1sgE=;
        b=L7QhI8kcZSDDQ2l5TNHjtwn+zaJ+Ps62IQVipJ30ZZSXHrZryKBOqqRyrMdT99D9cO
         j+pBsBhiua0P15kreeHXWavysS35z4nixfwjWGZ1BpmAK9Pd+7jI2cliSlaJKQTAGMGa
         WWhHnxS2FmM6DrKle83wq/Ms1JnMsHdJXvVGrBt/eL5yFtomS7jDT9Pk/nUZhFqbKO4O
         C4c4cQ3TZ2uzXCiS/62+gNK5YN3Mol7IKWztrMdsdqrbnx8Dd4OtLchGbDIs4qk4woWx
         RwMOQgasU+X3gTGhaEj+K7I3OXnx8CklqjmhY9033sSRslicWzbuE6eLrQQ10pRdGfB7
         Nnzg==
X-Forwarded-Encrypted: i=1; AJvYcCW1mmwVgTR0nVCFsBDRc+SHF1z+vxILfe71tGfQUbFyTDysCdPZSb6oLhShDFy1uM/HJmFsIMXPfHVLKWCBMuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5k2M4Rtq63DWj9rR3xa+wQWPQxYDz9E8Kp3JOczJbf6sV8+e
	k3iotCsR10OkVvSXEsqQe1+F1lWWJb4XpkCa6eKy34NunNxx1vQO95NEge3hQJuOQ4cVMg4KFp4
	eVjSXt792c60qDNGgwJGbsc2tX7A=
X-Gm-Gg: ASbGnctl2g78c4qHfSGxCx6YNtaOyyseM96PJe8mfUtHTbIbP9mlI2sZ463ybtptcja
	DxN6Ov3r5NlOSuocA2C8QakiVKHJcsJNouHsYA3kgoYYWct4AjJw8pHSk4dWKidcfBB0ULnqkIH
	e1EQE1slbhT3iSD/7aLmsJpaG0Cchk
X-Google-Smtp-Source: AGHT+IE/7s3ZRdv2RJ8mB73L0hZdZLCobg6+u7fVU3XDEg1fbPGQuUj9F3JzqSSxhsjeZb1AeDeBWwUNzMVlDjizq7c=
X-Received: by 2002:a2e:bd14:0:b0:307:dc28:750b with SMTP id
 38308e7fff4ca-307e5801f81mr11890231fa.13.1738939074559; Fri, 07 Feb 2025
 06:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com> <20250207-printf-kunit-convert-v2-1-057b23860823@gmail.com>
In-Reply-To: <20250207-printf-kunit-convert-v2-1-057b23860823@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Feb 2025 09:37:18 -0500
X-Gm-Features: AWEUYZkqfV5zxM9Td4ZiPEVb-zfO0045lbfUGjZpcPCuzZw5gd9-N83XvwJrkDM
Message-ID: <CAJ-ks9n+EyV8USyxqbKbTVv8RkNEe+F2DHHk0d1-Rv-osmgUng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] printf: convert self-test to KUnit
To: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 6:30=E2=80=AFAM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Convert the printf() self-test to a KUnit test.
>
> In the interest of keeping the patch reasonably-sized this doesn't
> refactor the tests into proper parameterized tests - it's all one big
> test case.

Apologies for the version churn, I'll have to send one more which
removes spurious trailing newlines (not necessary in kunit) and
converts logging macros like pr_info to kunit_info.

I'll wait a few days in case folks have other comments.

