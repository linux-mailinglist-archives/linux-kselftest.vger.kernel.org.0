Return-Path: <linux-kselftest+bounces-8362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7F98AA2DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 21:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9C21C20A26
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF317F36F;
	Thu, 18 Apr 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7bPKhWe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70DA17BB2C;
	Thu, 18 Apr 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468936; cv=none; b=r/GhNMDEiQoXjJA06GORZZ82qcIOeFVPHyCqGrxqs+YokgLqnCRzic18gR4GjtTQQ/xrNX79/eUOv89H2igrTxgd7l6NHxPJkhhl01GKwLUzjWbJc25pnjPkqxQqtgEjUs+GvxqZB1b3DoZUYEeGLB0s8mlzdlljd4jsbquIWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468936; c=relaxed/simple;
	bh=OzBOmiPfCAiq6pIsQFQkEaHriJFCH3cvPlNRRS9d+m8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fMVAE5jm4ih+TlRijlZrpyptjCE4q82qcUUFl/d3rWydD9sSGwvs55+whQjEPpSK37HkoAf/F3LrjH/XvQn2i3tYiCbpKq9R5/O20jzNKGE1kAdoePXIaPz45vrICQwIiPGNzxhesaiMYl3c6HrArvBRse2W9c0+h5LSEgqYW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7bPKhWe; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-699320fcbc1so8350746d6.3;
        Thu, 18 Apr 2024 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713468934; x=1714073734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PFMTMR+Bmu2rlw/d5DDVMiLx3235SXmGWbOxpv+fu8=;
        b=g7bPKhWeF1d5yGleqTJ7KTnJ8C+F2u+B8OhTTJWO3uWhfnhnG94V8bJIXzHgnTMYQn
         suXOufDghcb5efAhNzAY1bg8h05ukdeIepDdieB9NgdN93rGey31qGPr337YPa4WQPE5
         GC+Uwjc6EtJS5SP0JkUfk9UvASvKKEidfChAanb/tDdzvQpgfqmPl7iWgIhWu6Lv/TEN
         1H7cdgV/U2F6rVhu4P8WzLW88ivI1dmVElTGaON+WRFm0dFNU1B7Er83th0g8w7rzeeq
         sCpScS27IOhwAFG/J2QwYFIRWA+mklROgSc17mFqxHQGny+ZVPS8984XVSXJxSQjE0Cb
         2icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713468934; x=1714073734;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0PFMTMR+Bmu2rlw/d5DDVMiLx3235SXmGWbOxpv+fu8=;
        b=EF5A1NXjJMnqF0cSE7KDivAUVmWk9h2T8s4QNw5qY8UC1gpAvr47wu9hATbmFJW6eh
         TXMy90RsxfcK78EHMfpPexXms3ZLoclynF6SBEJ0cX4Po85f9l5dk86RUgkL1zFj8Myf
         2SL2m16g0a6yplLMlaST+go2vOMfGsEIRt+RUeUg4BqhJURRZDmWLJuadChIaveLSdwT
         KXZTqOJydF1k0ZQEZtMxw988ffvWEuTTXa/DJqbHbPkyT4OlqzVv3SYB+XaRvrFD5BAM
         JPyr0/e/x4yZ+eUJ/sxJqMdqjq2lH4BqFrLPlh/qIXKMxTwFx5Pjgqr/ptaMUbJ+wCnk
         b31Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQYmhk/Cq8gLyTZcGdMBpLv58aGozIXv1dP2Qx9ihQum6D1Uw/Ob5bgO/uJy17W2+LM1lr/MGuwvGRxwSXekA6RS+PCElzUSkBetOPaxlF751YWn+E8Dkhi6EtklLRhMNjuxfld/JM
X-Gm-Message-State: AOJu0YzasqS9DaGX2aYLQdqevqNYa0lbEqO0rtXCnhRwzYibQDpMIeV8
	DdoBqDDcMnM8QYUd8lz2w+tnf9n2RcBBUlHisHYGzFYNJ4kkyl+a
X-Google-Smtp-Source: AGHT+IFpPZ0WwZ0qwB8imyUxvVkbkiPbf+zBUOfCiBjGAIaguZY3UQE7N2k0bQJD1ly5QG1Svlz1iA==
X-Received: by 2002:a05:6214:1549:b0:69c:a51d:4041 with SMTP id t9-20020a056214154900b0069ca51d4041mr3883262qvw.45.1713468933794;
        Thu, 18 Apr 2024 12:35:33 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id s5-20020a0c8d45000000b0069b4ddcbd42sm926014qvb.0.2024.04.18.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:35:33 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:35:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <6621760535c64_f818029464@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240418120628.381fd081@kernel.org>
References: <20240417231146.2435572-1-kuba@kernel.org>
 <20240417231146.2435572-8-kuba@kernel.org>
 <66212d8b82945_ec9b9294aa@willemb.c.googlers.com.notmuch>
 <20240418120628.381fd081@kernel.org>
Subject: Re: [PATCH net-next v3 7/8] selftests: net: support matching cases by
 name prefix
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
> On Thu, 18 Apr 2024 10:26:19 -0400 Willem de Bruijn wrote:
> > > -def ksft_run(cases, args=()):
> > > +def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
> > > +    cases = cases or []
> > > +
> > > +    if globs and case_pfx:
> > > +        for key, value in globs.items():
> > > +            stats_with_pfx = bool([pfx for pfx in case_pfx if key.startswith(pfx)])  
> > 
> > stats -> starts
> > 
> > for the reader, just spell out prefix instead of pfx?
> > 
> > perhaps less pythonic, but just
> > 
> >     if key.startswith(prefix) and callable(value):
> >       cases.append(value)
> 
> like this?
> 
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index fe4025dc5a16..8018bf98a9d2 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -86,9 +86,12 @@ KSFT_RESULT_ALL = True
>  
>      if globs and case_pfx:
>          for key, value in globs.items():
> -            stats_with_pfx = bool([pfx for pfx in case_pfx if key.startswith(pfx)])
> -            if callable(value) and stats_with_pfx:
> -                cases.append(value)
> +            if not callable(value):
> +                continue
> +            for prefix in case_pfx:
> +                if key.startswith(prefix):
> +                    cases.append(value)
> +                    break

Yes. I would not have brought this up if it wasn't for the typo as
well. Python developers perhaps find this less pythonic, but I do find
it easier to follow.


