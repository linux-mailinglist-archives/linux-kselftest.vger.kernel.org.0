Return-Path: <linux-kselftest+bounces-15095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 929D894D837
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 22:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BBA1F233BE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 20:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC77D1684B0;
	Fri,  9 Aug 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sagwtAvd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67662171
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236464; cv=none; b=bb8gqaC3KJDdjj3CQzjWnHSmLZkl1to3G6lMTwZk5FeoKO60AbjjMFRqdo3YXuXF6NqsFZ1EDzyfx9Vl+qtyzgoKW8/B/qv093o/5Cv3yjPR2iIlPndAATWzyC08K2l++nYUHtFOgKmYl2g8SrBjjzU3dMNICQdqkv+cvriG3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236464; c=relaxed/simple;
	bh=qFoCxLTwbe/nnOp5X19kHxEjmmdecMn7D42aZ3uKB34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOYM9VTX1NR1ooK9wkVGij/doKt6Ytr6N7GYaniMLyCZtniLbmzKveM2KkPzotCgQYEK8ez8h6VqwlVZjXfTKbNAQ+Bs1K+y7OzXelZP3JTKNknZ8y00s8kVYYWPIQGQYoT3iyZIJZHjidqm6+nvNWi1WnNrSysQhvUl1jI6t4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sagwtAvd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so408951466b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2024 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723236461; x=1723841261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a1osoLyHUSxCVj7RiQ7fO96za00szdDkZn7V0tOvr3s=;
        b=sagwtAvd2rcEEMVSTOuySNz5cFI/5dPv5ipBWLhADIjIu5CD+a3vEzZrA+hCvlcOar
         8BpXXkfsIG4A5czez4uxsKqSQfqJTcYTbZa5lx1r784cDMfGSyq5eAgIa24KmjjdUeqT
         ttMpVzpun1FqgCWkIDsihrM82YEfc7PhwqNgH/uKV5FUD/WO9HYukbfAeOMefA1LES6X
         vHPLOW7j3xdiu8lNcFQVsvbECrMvzK3zJj5vmjdYz6hgb6ckh8jzifhus+T2DT3nCW7P
         YWxiHmshL65TXFXnVyAgRuTdWoY/OSbY/q7SWPdQ/CR0TkRcl9G47jZ7YDf1muxfncao
         HdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723236461; x=1723841261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1osoLyHUSxCVj7RiQ7fO96za00szdDkZn7V0tOvr3s=;
        b=qbCt9sGoA0NJ6yfcKlaGu+AobaMX7QAPnIEJOn3EimIEBfRMH7BDtlB9HnS5CDEl3F
         vLfLoGF9pVBahaBW7DpgHE8m74y4/PYqftFesUjQfuYsvuzzi24GskajgutaC1Hr9jqX
         huzccjuY04T7GXK84yJZb6nUHbk+YhZuzS9/DsFbmgwQArsEdzKCrfvDIdwFWDQPRLMH
         nBF50OrFalT+0Fmtu4DhD9smPXDJWBGOT1XaDsesCI+uhymq7eWlexEhZs4t9yNLBBtW
         nAkpNX8PZpPlQo4y+CcY+BhCZOuR0WK0t8LP74i/U5zscc8ODj37JIkbDtD9alby2Ac2
         mb/A==
X-Forwarded-Encrypted: i=1; AJvYcCXuXhhx2yeathv7qpYvVJrdjC8In73FeFoUn+o9e4Fn8IrFxHPFdZm4XDqpVe3Ylf0ZuDpZOleToM/uoTTZJuxHNaKZeyt6Hbw4nPm57f6K
X-Gm-Message-State: AOJu0YzdCLRamu4TA9Sr0TP2Ha8WbxnyzIMLI2OOgbOhcdgkDpCiPT13
	t+aB6oM1fhOAgcAtRn/xtoUGxNJqX1ttXwbXU0lcZSZS9KicVY9HpDOWl3gDfGY=
X-Google-Smtp-Source: AGHT+IGQygi/8y0MrLGuxgnSxm90KDTHe7eOm0uSPyfY2XOG8dmtrj8y5l+ux0lyPkSOpXWnqw5aog==
X-Received: by 2002:a17:907:9816:b0:a72:7b17:5d68 with SMTP id a640c23a62f3a-a80ab7579c4mr201491466b.3.1723236461201;
        Fri, 09 Aug 2024 13:47:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb2421besm8690266b.207.2024.08.09.13.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:47:40 -0700 (PDT)
Date: Fri, 9 Aug 2024 23:47:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [bug report] selftests/bpf: BPF register range bounds tester
Message-ID: <24939c57-301a-4cdc-bfb9-501b4f6cdccc@stanley.mountain>
References: <5988b755-125a-4288-9f39-f34b1bab6e63@stanley.mountain>
 <CAEf4BzbeEGzPVaz+1E-UatJUzRcek5Y6qAbg8+UgKU1-vj8zEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbeEGzPVaz+1E-UatJUzRcek5Y6qAbg8+UgKU1-vj8zEw@mail.gmail.com>

On Fri, Aug 09, 2024 at 10:19:54AM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 9, 2024 at 4:23 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Hello Andrii Nakryiko,
> >
> > This is a semi-automatic email about new static checker warnings.
> >
> > Commit 8863238993e2 ("selftests/bpf: BPF register range bounds
> > tester") from Nov 11, 2023, leads to the following Smatch complaint:
> >
> >     ./tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1121 parse_reg_state()
> >     warn: variable dereferenced before check 'p' (see line 1119)
> >
> > ./tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> >   1118                  p = strpbrk(p, ",)");
> >   1119                  if (*p == ')')
> >   1120                          break;
> >   1121                  if (p)
> >
> > Was this NULL check supposed to be checking for the NUL terminator?
> 
> yeah, looks like a bug, it probably should be `if (p && *p == ')')
> break;`. Are you planning to send the fix to bpf@vger.kernel.org?
>

No, sorry.  I send drive by one liners, but BPF is too much of a headache to
deal with if you're not a regular BPFer.  Plus these days I have so little time
that I send way more bug reports than patches...

regards,
dan carpenter


