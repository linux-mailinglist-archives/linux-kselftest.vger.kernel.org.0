Return-Path: <linux-kselftest+bounces-3097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF582F573
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400D11F24C80
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 19:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381A51D537;
	Tue, 16 Jan 2024 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WcUKQ6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67351D521
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433735; cv=none; b=uSeRRvwEeEUrehLf24oe5/n+JB4i5AicpPYTXPLmCYoD/4PfPJWpLGaWbQSXVswHwYwKszpUTLselPLZ0kNe8fgH6cOGYjwpwN9dDa9p1c3uem7gZtKXzPWo+iawF8lF1Y5g9d8thmypr+g9pTJ/h5RPQZTiHpCYDRKwuZLp1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433735; c=relaxed/simple;
	bh=evrxQ+WlZe/uz/I2gq8N6P2wlxnDtK9mA/7hhyJoZAM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=O/O1uHzyBnWcjhByT3eH9GlSk1z6y+duMSOp/T7kwkbbCmIHF8tRx1NvipkVGJXnHy5d4LFqIGmf2sk+pEQ8RP+oIE6s3DAct16y97AlA0IBIlzlR0J/tpytdYRXJpyasIxbg37q0EDKNgUHhgXKgwio+M9+r4aow/KVeRXG1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WcUKQ6a; arc=none smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4298fa85baeso41721cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 11:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705433732; x=1706038532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxJ9VvvDNT0D5B8Ol+QCsSG9ibygcO2/FPAnh3xxvBs=;
        b=2WcUKQ6a3Hemm/Mmhvyi8n6LStvrHnCK9qrvonAtiCR2iiSpZcXy7O/ctAMi+XYyK/
         wIoIirACPRAroiwVz3FIcCZaPJibWeD52nYxO8UsxCxl9vj3a0OWkwF9Isz3oPhtiaFN
         bAaZCRTMWjEf9cUFlcLcpvQWNrogRwwmlgUJIJdR6NP25apGeeON2cM84jd3qFw7It14
         94Sihm0CQ48iDSqFcOhLRT8rbazygyrioG5txeUJ3HIxOQf3gSUKhK9R60G7T621/y6R
         va7g+Od0vuUCN8KE0Skw5mpUsocNRy87rLvUvaYatHhbhaFmGpXYQo5EedghM8EzUwKo
         umVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705433732; x=1706038532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxJ9VvvDNT0D5B8Ol+QCsSG9ibygcO2/FPAnh3xxvBs=;
        b=G1FLRwNjDiv+4rhUJLLUiHUxee3uPamhRYUWpzE3iREhlmvtApI9HydFXMz9IydTnY
         iEulsLJwKsPPCyO0ibvFP6RbMJVoZRUTO+NafcZeybR3km2FzDkkTQQfKstzEgDk4rw2
         rYHbvwHDDXVXCcowfUy0PIoS0J19Oz18TUTp1mzYCQxQvxkDETSgdkZVYDvxH3ZcOJfP
         oSK7BS9/Vy1Gf7u3ZikrDOPr41cDvTsZUv3X2/4PhHmVtdsdeS5rjIGh2RjKeJQ7nCqs
         nHWKbfXt34H9oVGYuKk3ENdgucgkUnENNCEVydRUya6PXofG75Ncol2JsSiL0x7t+/YL
         d8dg==
X-Gm-Message-State: AOJu0YznBTK2E/LWNuWKOVTJ4B//iecH+WagFnx4FtiYybtQd2GGdTCU
	UvdulD1xpU1R9ggjgVLUErSm5xBGB6EvnLyrpbbTON2fcL9l
X-Google-Smtp-Source: AGHT+IFuS1zhB9xcg19M4+HxcGo4M5RxCkGNH3OXYKC8ynWkrz+mknzKdyv/4JNGFL8c87QpTvtG6AK4R1NjfBJUBTc=
X-Received: by 2002:a05:622a:1cc4:b0:429:c6bc:330c with SMTP id
 bc4-20020a05622a1cc400b00429c6bc330cmr71651qtb.14.1705433731736; Tue, 16 Jan
 2024 11:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111234948.3103511-1-davidgow@google.com>
In-Reply-To: <20240111234948.3103511-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 16 Jan 2024 14:35:20 -0500
Message-ID: <CA+GJov5HdYAaQYfM1=m=DZPvBM76c0hNhWuUKnWB833-=raOqw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: kunit: Add Rae Moar as a reviewer
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 6:50=E2=80=AFPM David Gow <davidgow@google.com> wro=
te:
>
> Rae has been shouldering a lot of the KUnit review burden for the last
> year, and will continue to do so in the future. Thanks!

Thanks David! Happy to review this one!

Reviewed-by: Rae Moar <rmoar@google.com>

>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8efcb72ad4b..2316d89806dd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11599,6 +11599,7 @@ F:      fs/smb/server/
>  KERNEL UNIT TESTING FRAMEWORK (KUnit)
>  M:     Brendan Higgins <brendanhiggins@google.com>
>  M:     David Gow <davidgow@google.com>
> +R:     Rae Moar <rmoar@google.com>
>  L:     linux-kselftest@vger.kernel.org
>  L:     kunit-dev@googlegroups.com
>  S:     Maintained
> --
> 2.43.0.275.g3460e3d667-goog
>

