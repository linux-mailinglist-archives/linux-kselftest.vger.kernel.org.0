Return-Path: <linux-kselftest+bounces-28400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B5BA54AA3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 13:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DCE169AFE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA96320B1EF;
	Thu,  6 Mar 2025 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="angw7KhZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD6207DEA
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263962; cv=none; b=f19GmXkCzXwTlxrOoHzw2S867FmY90rNJSzGRjxI09qzQV1dRDKeD8zzmApWsaTTBRHHAjiayQWFrpjNaeTbt/rO/xfVt5IkFd4PcZdXbz7A9XFKc+NhU0Q2KjVwi5fbir47aEv5H/LsWS6EoVA9dkZIMioGOvKSOTSr4xGPZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263962; c=relaxed/simple;
	bh=cIHmFcN+je4g6ZEkmn2nR9Gls5uOmxfiZ+vKzg2YvJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTlyBDQ4Usy92EvMbvdbuMNbKnX2KaxZasQQzQiqmMtuXSwOV7hChqMZ69LWnJ8VB31FrrJwpCTCzhgBzzOBso+r1IYr85klvX3AXXYRQFYC6Wel8su0J5oII7/l1yPSUelexIpQbDNKePcmRUbwie+e2S2epPJ8FVkoUA7Nxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=angw7KhZ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-472098e6e75so160321cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 04:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741263960; x=1741868760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mwY1CncZfvA5yu3fSWfGo19jkVv3bXPIhA3Usfu+tGQ=;
        b=angw7KhZA+BQv/wOEvhBNNW1MpfuYJRQ8n1RBk+/lQlxWcpAPFnmIhpIKDYQxjEJCt
         m6LvnAv3ne/JT/a2a+zPtYzHD0xOMiaY53+EO4FhC/7daIjt0Knvqbbcm2ib5NqE9e4h
         rGE3PYnwRLuBYG7K2PBtnJKj9y0ZHn/prq8Go0j6oV1cYpFv8r70T61xgjiA0vK6P7HP
         owxe/lF7aglk66B0A2EJ6Wb8+X7BUN1/dggSCTzM+ZZG1soBEMSvQNDKi1vkS0rOH004
         Ru5jUz7ft2TomlJoU2C7l5lrOW6crLiS8eHI74C1OYfIuFV335AgSLRUGZXVuoa3L5RV
         uWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741263960; x=1741868760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwY1CncZfvA5yu3fSWfGo19jkVv3bXPIhA3Usfu+tGQ=;
        b=ppKHiG/paiaKObROUFV2vLaJZk7O/NXuK0mnqIGyjnvVqZ5eGBGX980iVP0teuxgYB
         /shWBYzVkn2ITDEA7zCushSImda0B0LDhyBwgNrk4n+3zbDv5UsCH7+2i1gMyb1r7ohe
         Rz/lYTJO7cjlkBNaj++2O/9aKkeS6k7cbTlSiBq6UgoL1kQ8lLmftV3ASmdSx7B+4902
         zBa3KB4mMXzyzfpml4x0lN0U9hbOjuK0U0JkjDw91hbIGNLSOzENhASowe0h7pB0DHrz
         iWbJdCvf8PD41h7MnDVeG8pCwIK3zsXR/D1x1bDvHfmC65GkVS6PNTmzcuGGGx8TYD73
         zhrg==
X-Forwarded-Encrypted: i=1; AJvYcCX6BNdazhMZXIm+kSzS3JsB5K1esKoEwYmpxEOfuNjm5pcTumT0Pa5f2Rep7mLtRgiR5K5x9NzxVzmsCxvbxq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTxfiW9wyeSW8GgNhD6MVbGKLK7Td8HzlOMeuLqsX58VoodVTG
	RkcTCRg9UKTV+IuH519EumNlyvgRJfmnJiw45+M+Yckc1Vrj2vBUi1huGXoZqoYHe5IQysdLikq
	pIGOKFwVHO86/TkU/bPJxLNUG2AjBR51JiwHV
X-Gm-Gg: ASbGncv3SPRvH4eUGHCwwqdU8bmcdzY9RUTJgFen5mylF+FiOAqtiV8RwwkNKo1VqPi
	DIEF5BHWhMuqGqV5vkbKtNCNRNSLlmZndNQENj9uqTZTaZIoXQnvRFkCOj6qBNDcGQhdCufWaz+
	tdMXrJWqh51QW7lwlKGEZY9Kvqu/ZZADdia2jru8nMKpiScmxQ5qiKk9wi
X-Google-Smtp-Source: AGHT+IHni+4W1+dtjRM473KGIVmKLfVCgoaUxTl0NChdbDrUzneKPZyDgW+RAtTuH1RuCGLRDb8fjWExtju89vjvr7Q=
X-Received: by 2002:ac8:5809:0:b0:472:478:b124 with SMTP id
 d75a77b69052e-4751b0183acmr3594691cf.4.1741263959960; Thu, 06 Mar 2025
 04:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306002933.1893355-1-rmoar@google.com> <CABVgOSkwrb36rrhH3H17fhYOnywhTgTh06aDaKXT4jZp474sRQ@mail.gmail.com>
In-Reply-To: <CABVgOSkwrb36rrhH3H17fhYOnywhTgTh06aDaKXT4jZp474sRQ@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 6 Mar 2025 13:25:47 +0100
X-Gm-Features: AQ5f1Jp-WLFktBvoOoKCDCjh4812bpPlSnhL9ZZNsu-zSBteIHyxLpZPZ9jfly8
Message-ID: <CA+i-1C12kG9t=jqnVaKnvN4xCn58cTeph4QHOTL0+eg98rn52w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix bug in parsing test plan
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 10:00, David Gow <davidgow@google.com> wrote:
>
> On Thu, 6 Mar 2025 at 08:29, Rae Moar <rmoar@google.com> wrote:
> >
> > A bug was identified where the KTAP below caused an infinite loop:
> >
> >  TAP version 13
> >  ok 4 test_case
> >  1..4
> >
> > The infinite loop was caused by the parser not parsing a test plan
> > if following a test result line.
> >
> > Fix bug to correctly parse test plan and add error if test plan is
> > missing.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>

Thanks for taking a look at this Rae! I tried to take a look myself
but I could not really get a grip on the parsing logic in the time I
had.

> Thanks for looking into this: I don't think we want to unconditionally
> error if there's no test plan, though. Pretty much no parameterised
> tests include one -- it's not always possible to know how many tests
> there'll be in advance -- so this triggers all of the time.
>
> Maybe we can only include an error if we find a test plan line after
> an existing result, or something?

Since I reported this bug, I discovered that the example above is in
fact valid TAP:

> The plan [...] must appear once, whether at the beginning or end of the output.

From https://testanything.org/tap-version-13-specification.html

