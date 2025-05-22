Return-Path: <linux-kselftest+bounces-33498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5119BAC0746
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 10:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9145D3A2EB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08D1268C70;
	Thu, 22 May 2025 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="ZHR68oSn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82698267F44
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903124; cv=none; b=uim+n+Jv+hR6VugDNrnj8UXFEL41FnOKrEMSHfLq9ZK5okmZd7jQf9EgnapyU1HVuG7oU7ZZjMyXyM3ygofCIgglD5+i5s2w9oGLvfXVc/Lb88z6o+7nEkR4FT+7tipxYcqSi5+igju2GO2RQuMR7JBvGvFzWxOM4HVhCHOzX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903124; c=relaxed/simple;
	bh=K56au4wC7SajXotCQW+tsFDXuT8nbYN1Q28RXPF59x0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ws0kgX73/JuA1KQG1k7qfD98gbL+ySmE8W9Yx9XQDy/pA8CDKx+zxP4owrSeWeZpzk328Cu3OMVb9CgPI8PyNTHxJMXh3LBgZowOKHW43LNjYU2gpBtsfvNOC22l4YoyXNlN06gmXrboo9tCjkPTmkCI/nZlC4Gl7aqR6UdjJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=fail (0-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=ZHR68oSn reason="key not found in DNS"; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d8020ba858so74899525ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1747903121; x=1748507921; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/uztfpQFeRtAQ98xNCxi3LaxzIk4TybH/zbX7MUI9o=;
        b=ZHR68oSnLODm+h7f2tQahzIVJE6MZmjAtjD8DRgXvRxLlACdRncldNfY0D7TTK8Fix
         Ko61Ohf6oE3nGCYbJxN9M23Ygy3pqDcCnoXjQYv3Rk6hlkD7Peb6IXMaWeM0k6AsGGug
         Vws+yVGaVgao0NTzFVosY0A2WKK0CSvXEL17SoDGhaxwwM0aWzK0D1A9nb0DpWs8ZAdE
         XA1JBraavlKz0ZPKKf4oHN1bT+ADd7KJCr2VQs7QzOJ8i166/JDdhO044wsxVeMPz0/H
         vV6GyzEelQeI82vB2DGLX67gPAkKVk6STznYmtyix74THwPY8MKzNz9e1tAZBTri7JH+
         hkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747903121; x=1748507921;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y/uztfpQFeRtAQ98xNCxi3LaxzIk4TybH/zbX7MUI9o=;
        b=HBFq2hhgQ+BpVOtlBHsb/89LVR4q3mKqnNa2fZ5K3Xp4kXNIcvJ9NaGXrPhLpZlVQq
         3tSG3fR8zEmENIKrsT23lD40WN+oZ+Vo08BCtj+9zXhWc+nsWRyzRfoFPLf1/0hA9LC0
         esPSED2XPWhFiwuraXRQHplnnurk6cW0sKKn9eYCHOoNErbPJbxMIb8mg6clodAMJ/it
         5R7EWHLkeRGrPXe87dstJM9wdgIWUKpfiVQgrhgztVIHXH8NDOtwBj7JPN9WoAnNlZjO
         ivagLw0Sh/9Vsn22KzMnTuMvsqD0+jCpgD8YxpPXsDxvx1pB381FQRlc61khZp0mCGVp
         NhEA==
X-Forwarded-Encrypted: i=1; AJvYcCWAduT78DmYFxGk2eoRWEndJI/32w3/k6491mZu4pXFJRUlrSVYGWq1VQKBSwfzX59/OxRDR+p+d38iqogO2HY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykjjb7WboNmPGyZEwXTtkgWwvAmvmaAwU8E4QoU455cLCmaymQ
	wgYsTS1WKAGDbCKb0Id6Zt4aldErL0TW8A/XJGbqKXrQjZ9Zpnb4Q+MtVC27hx51YeU=
X-Gm-Gg: ASbGncu6T6neLllkMyg9jNgjZU6nUKCX+Yoe+NGfEqd971ZKWg06/pAvmkGXHu2C1uP
	muM/dIcz8JHtHQCEKxiPVDt6qwoyZRzTz2ovGHtGZNWA8jMmpMnZi/uAbOPqD/CwJHBDDkeHM20
	Z55Zu5bf/zIQJDr88m00GD60hhFSxcuJzZIapqXjLPNN0+kJGYrNR4Gb6Vkkor3IM11dHprwsg1
	94J8HARb60EAJvge78EAFyObbLdt90J5OEDctGuKnCrQvJK9JfXEeXa2vHMV3yoBUJc4TCS2Qg5
	nk986b/Qbx95ZsljG+W5IxqxT6AMrpY2n78un1nAa818GfJF
X-Google-Smtp-Source: AGHT+IFJPp18bgyKIIAXxbSlRy13fkqwY4ZTlJBJL1sgW5kbEsOeh05bDQBncf9RJJVbBnvlEhStNw==
X-Received: by 2002:a05:6e02:2187:b0:3dc:79e5:e6a3 with SMTP id e9e14a558f8ab-3dc79e5e8d3mr118701145ab.4.1747903121521;
        Thu, 22 May 2025 01:38:41 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a88dsm3083850173.15.2025.05.22.01.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 01:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 May 2025 02:38:40 -0600
Message-Id: <DA2JY06Z0DWG.ZE80FEIJQV92@brighamcampbell.com>
Cc: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] [next] selftests/ptrace: Fix spelling mistake
 "multible" -> "multiple"
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Ankit Chauhan" <ankitchauhan2065@gmail.com>, <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250501060329.126117-1-ankitchauhan2065@gmail.com>
In-Reply-To: <20250501060329.126117-1-ankitchauhan2065@gmail.com>

On Thu May 1, 2025 at 12:03 AM MDT, Ankit Chauhan wrote:
> Fix the spelling error from "multible" to "multiple".
>
> Signed-off-by: Ankit Chauhan <ankitchauhan2065@gmail.com>
> ---
>  tools/testing/selftests/ptrace/peeksiginfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing=
/selftests/ptrace/peeksiginfo.c
> index a6884f66dc01..2f345d11e4b8 100644
> --- a/tools/testing/selftests/ptrace/peeksiginfo.c
> +++ b/tools/testing/selftests/ptrace/peeksiginfo.c
> @@ -199,7 +199,7 @@ int main(int argc, char *argv[])
> =20
>  	/*
>  	 * Dump signal from the process-wide queue.
> -	 * The number of signals is not multible to the buffer size
> +	 * The number of signals is not multiple to the buffer size

Excellent work! This could probably be clarified further by fixing the
grammar a little bit (i.e. "... is not a multiple of ...", assuming that
is actually what is meant).

>  	 */
>  	if (check_direct_path(child, 1, 3))
>  		goto out;

Reviewed-by: Brigham Campbell <me@brighamcampbell.com>

