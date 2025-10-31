Return-Path: <linux-kselftest+bounces-44518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6558BC25244
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 14:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F2D1A22722
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816FB34216B;
	Fri, 31 Oct 2025 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3sj5XBa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F4183088
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915430; cv=none; b=N53B9ML/yGu6kBSAe6gzQzQR5yY1KXnmot8TQ+fzViJd4NFbYpd7nLDh/lRuROdT6jkTVlRYwJYAy/QhJmWK7lF3jb93PlatYLgUV4fKxiAlkq4xuddkARwhQIse7IsiV+tz71raPauuknUxedmKjIIfT7UIG4lmauD1AmW348k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915430; c=relaxed/simple;
	bh=l1q3ZoTg1Enh2GqilNhs4U1NnvY2DHGQklHOE6qU9DA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sHUjYHcYtCUfi0k8Lh1ZdnOEuB5aiF8jOoGCnFptzxIHneHvQGEf8sO6LmnS7p9tHAHkoPMscqRFKpDTmT29BhvQ16/WMYMR+xf7ISZ7KzHEh2fvLs8xW1bri8xv6sJYY46jtLoqOWIlQ/LE6ZyQB0cqJXKYYcWW0iArxBuEAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3sj5XBa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-475dc22db7eso18788895e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761915427; x=1762520227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1q3ZoTg1Enh2GqilNhs4U1NnvY2DHGQklHOE6qU9DA=;
        b=h3sj5XBa4731oQLt7oa0+cXd8Xa0wNXNnLN9gwa8bQ+BLN92wa7NGrbRAPt7DwTaY3
         IF5hoVjeIkTcz2QK5rYymTwVNeK9f+XxFjJmj80xSDhnvjr5kw2TcsVnt+BVwHA4rWbV
         y3Nd+mjtZ9aM1uRFgddVy7ZC1kFM9tvzgO3lqFCWM3PM/8nzl4jPCX8UTSO0mjTfvy7U
         ErkwDuiX7/CA0LWw8yTmRIZ9/0ESgzAOV9b1msJ+JkwI4CQXC812NQJm289qluN0TECP
         eXfFp6pUtuGYdVQTxS6zNL2ddcQ2tUdVdkZLqlhAFrBIkFI8awoJHBhFZnlx6VpENLJF
         8rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915427; x=1762520227;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l1q3ZoTg1Enh2GqilNhs4U1NnvY2DHGQklHOE6qU9DA=;
        b=xM1vAS4MIPxYuZhxpPPSvjyYl+T6JFkd8Q4khkUyUKzNPlcfmhGfkLj2ybCF1W/PuP
         yDhgVJvvxC0gQWxLlJ+yWDiJ8u0zss3D0kBF3a4B/Ruvd3Y/V3JRipYG0ZnWzvnYpoen
         QaD6n65GMrEzawKgbzpjhvRtEw5R1pzIrHGlRcIeLjZN5IPjRffrbKhXy2oADSkHbaP5
         K85NH7dn9f3sKPHPQ3FOkQr7AjGTPWbWjlL5OlkWEDKDy+eaqjforxlfWuxr0MWCSOEG
         DZCxRU5JpYx0NRZF+uw6JC2EPnEFOfIdfSNahzeELYrFZfYcwiFAveRKoGQUhmPuMq4d
         1qdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNvJzcnNJy+nGk+rZSGJz8q+Lri19bxx8X68fyAnaFvzCxJSbmNMpOs5znZ0DGFUq8crSaI6y9zBCHV5KKZR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4+J/Qfn/CaTsFSJyK58VBXkaiVFVKM+oBpu7ek4sVxKOsKjr
	aJKyOYRF6YV3UzHGe2/DZhTO4lksxaj8539CeQKvp7DLt8wN3faSfktBFZktMBdx//Yml741yTS
	Wt9stc6RswTALuQ==
X-Google-Smtp-Source: AGHT+IEgK0CDGQv4ZwQyy3z5e1eyJRGphw1PkE6nao1q39MEjhZWIjfrdy3ipQ14wEs0ezfStNH2iPM+yHd9Ww==
X-Received: from wmbjp10.prod.google.com ([2002:a05:600c:558a:b0:46e:2640:aa83])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5249:b0:477:c37:2ebf with SMTP id 5b1f17b1804b1-4773086dbc6mr29546005e9.22.1761915427124;
 Fri, 31 Oct 2025 05:57:07 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:57:06 +0000
In-Reply-To: <80dec5ff-a9b2-4622-9dc9-ac65ca06e187@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014-b4-ksft-error-on-fail-v3-1-31e96fdf9bd7@google.com> <80dec5ff-a9b2-4622-9dc9-ac65ca06e187@linutronix.de>
X-Mailer: aerc 0.21.0
Message-ID: <DDWIW4V2X9EX.1VQ2QCG6AU78R@google.com>
Subject: Re: [PATCH v3] selftests/run_kselftest.sh: exit with error if tests fail
From: Brendan Jackman <jackmanb@google.com>
To: "=?utf-8?q?Thomas_Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, 
	Brendan Jackman <jackmanb@google.com>
Cc: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri Oct 31, 2025 at 12:48 PM UTC, Thomas Wei=C3=9Fschuh wrote:
> Hi Brendan,
>
> Oct 14, 2025 16:45:32 Brendan Jackman <jackmanb@google.com>:
>
> (...)
>
>> In case any user depends on the current behaviour, such as running this
>> from a script with `set -e` and parsing the result for failures
>> afterwards, add a flag they can set to get the old behaviour, namely
>> --no-error-on-fail.
>
> IMO this new flag is also unnecessary.
> The user can just do "|| true" when needed.
>

`|| true` is not the same thing, if you do that then you completely hide
all failures of the script. With --no-error-on-fail you just skip the
specific case of tests failing.

I did say somewhere in a previous thread that this distinction (test
failure vs test harness failure) is always gonna be a bit sketchy for
this script since it's running on the kernel under test. But that
doesn't mean we should give up on it completely completely.

