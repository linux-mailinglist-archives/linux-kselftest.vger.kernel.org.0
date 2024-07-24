Return-Path: <linux-kselftest+bounces-14130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E69793AB62
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 04:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C23B21623
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 02:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B670117995;
	Wed, 24 Jul 2024 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMX6cJ8i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190384A00;
	Wed, 24 Jul 2024 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789281; cv=none; b=O2jAtok9sNez1qTXuwZ24jseOAinHHLQcbCq+hsY7Ys2tNmgop7klMP/wmcmcOmTWvek1xU9z3BGtWNE5Pr2ZCCyVKsJQ2POYuouELLc8ya4xvORFO4Uo28z3JmNQ5V55wmDXo7kFvJ38sVnLfBZJT+R2jGMjV0RTHGOZF5KgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789281; c=relaxed/simple;
	bh=W2Zo/H7Kb0gy2oq96iwckVxt+BOSf1ppdK2zRybu11Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djJbatZFXBFoRMQ4CTGEO2J+z8YqYkIM+1EZk4DlE+ck5bg0WLHaYp2aVESt0m6kEyLWLt6O4AMF1eCWlYChCgNW8l15gVaW4PHZwNCiRqng7vV5sSI9ksfrxamwDeerPK6L+uR5D2I3JIWlpxmE0+g5yhz//hDV7i3lBSThRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMX6cJ8i; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3686b285969so2921019f8f.0;
        Tue, 23 Jul 2024 19:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721789278; x=1722394078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGy4ngI/f55DAxch8oa9eUxUsKlxjCBWL5eS5G4SOng=;
        b=cMX6cJ8iC4G7k/euwyt9kJO5CpAFw05ybyS84uMTLsbzBAH0XyaAGyVGPY9YB15xVM
         LR5rw4+4UmIdS12MvCfh9zD3gN7UFjfLz2P3dD1E+tp8mfhwG5DVGMOOARK494x/27yy
         DMDGh/pxpZoIi5lkPEZv8y8uAfCTTNiKcJFKbCKrMLDNUNO9w0C4ek2maTsE3mBmEIjG
         x+l5O4DPZiq7deyUa29YvJM34vmlYwiylGnSdE6hjCUcO2VerzHGrIrujWR56a21cKlm
         2c8yjI0yjhqyJELKAV5lDJ1FJNfhyaggN6Kln7fvUTYwdy4XtkWtCXyO4f+cPuUn+U05
         9Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721789278; x=1722394078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGy4ngI/f55DAxch8oa9eUxUsKlxjCBWL5eS5G4SOng=;
        b=efoQIRrN0qYi+76nISTjXbZR3XsqsUKcnA7xzAUjWd7MArD7fhbmghtFRKOU8Oy88C
         QBsUjEpWBRZIxIdMxC/2nLZcD1hzPnxK8ZN8Dz6N2BQ9jPFQdBrMGUp03en/KvdYruKR
         ovui9YxKzt7LXebfjaWhjUfZ0ofjc9D3RktEcYiOqUB1HVOZ+ezMVtymALDttdNSOLLS
         GTNYpqff57XDyj2wWFDDguvJNg4Pb+NnAW/nscpGQLGDxRpAQqbRQ9AEB2hnsdSiLd3+
         RV8yksjzLNnlltk+d1ufjajeHoaRAqAvvqyGmG8/cFCT6+tKNRX6vXi3frGLe2v5Q9OY
         KF9A==
X-Forwarded-Encrypted: i=1; AJvYcCX5Nlr5POfTjfooAbJNbq3/qnigSxLeipYSeCJP65SZfu7jHRSXz6YH03A4++m37cBBzOSIIOAqx6RsJ/YIxyxTCfGWhasNFqKQQ7l9Q2XWe1pKKQW8DnkEZ3q+qlc7gE3mknZ2A7DWjBMQr5n0
X-Gm-Message-State: AOJu0YyQXUuo1l6cI4m4+CPRDzg3nZ9fC7Z5g4GW/7rJs2XTU1RxSi+Z
	9H7m6GvSm0ydPS6k9314S44krGCaN2c5oId2u3pRewJC0EPzhvxAy87S9aGJrhKFxbjgZZbdQMp
	7p01U4FuuqolcvqZ9dxvpp9QGaIU=
X-Google-Smtp-Source: AGHT+IH8/M5kjJyGfkqVPhFkkfwGvy8Q6ErWtmKhyCouCUXC42Sfiv2sGM+z+0uARImXU38OqOrXmUKMkkiKfaoMUCU=
X-Received: by 2002:adf:fa12:0:b0:368:3f56:b24a with SMTP id
 ffacd0b85a97d-369bae34d05mr7461723f8f.15.1721789278225; Tue, 23 Jul 2024
 19:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724021112.2840-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20240724021112.2840-1-zhujun2@cmss.chinamobile.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 24 Jul 2024 10:47:47 +0800
Message-ID: <CAOsKWHArGK0yVhQSNN1nmcYvxSpsjV21L38XkAvdVGNcJ1xkAA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] selftests:Fix printf format string in kselftest_harness.h
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: shuah@kernel.org, kees@kernel.org, luto@amacapital.net, wad@chromium.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Zhu Jun,

On Wed, 24 Jul 2024 at 10:15, Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:
>
> '%u' in format string requires 'unsigned int' in __wait_for_test()
> but the argument type is 'signed int' that this problem was discovered
> by reading code
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes in v2:
>  - modify commit info add how to find the problem in the log
>
>  tools/testing/selftests/kselftest_harness.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index b634969cbb6f..dbbbcc6c04ee 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -1084,7 +1084,7 @@ void __wait_for_test(struct __test_metadata *t)
>                 }
>         } else {
>                 fprintf(TH_LOG_STREAM,
> -                       "# %s: Test ended in some other way [%u]\n",
> +                       "# %s: Test ended in some other way [%d]\n",
>                         t->name,
>                         status);

Seems this can use macro WTERMSIG like those above usage, rather than
changing the print format.

Thanks,
Chunyan

