Return-Path: <linux-kselftest+bounces-4512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A316851864
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 16:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2B1B20EFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E89B3CF49;
	Mon, 12 Feb 2024 15:48:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DCD3C495;
	Mon, 12 Feb 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752884; cv=none; b=h5Mrz1Da7R5SFYxJJbm1pPweRIEXxhpc7tHNrIKGxlP1ZsVO4hf5xq4A4rsiC+LZGDnq5F6ODH8g2WvYfSGbv0c1lO5yI/W6xt+GHhZH7yHL+Kp4MxqrgXBRDG7USQGDfHfzaCyWnNCcuWMKa1iEZDnnsAap3BrXl5gwW35f3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752884; c=relaxed/simple;
	bh=Be7/SIwQMjRcU5oeA3ToxtFC/uZGDzasgtxIjw2fCjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9e9LDRXAaEGu8ZCEOT+01AxKNT5fmDSKR2R1a/eQRH4Ga7UecoMkfrSbgUfBDOesavKot5XEM9LQ2GC2n5K0rThmdZxYD91uTLevGvABPUDagyIaVEbsKNzy2DygDJOgKSObhg1dnLo4MUH9KJTog8Vq1jpy0R1RaazWNBn5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59d249f8e57so184271eaf.1;
        Mon, 12 Feb 2024 07:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707752882; x=1708357682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/L6O8C6yOX7T5tLvNgT8mfVyjq/NcCcZ+sJHriik+w=;
        b=FPqXOMSaQNp1leCXv0YSicYaCZ9GzNIN6r1aaAWqjjXuP1J4Zszftg0UU37T1sRERE
         yI1zp/NsTkidFfj+cIOh2nAhPdL8++E/EOU2rUeHXAaHGglXMNqyGi2OXl5p3ZvNPgX2
         0YnVmQ7fu1vZlX1m5/eXytDKLda/pwMMjq1lvtI/EguxXJ4PsT2fi8fn9/RoScA9H6TJ
         qkp8gZQ2B8JtBitTYc10RxHKXc4S1vcFMxeJbV/+K5m5wxgVWN9o4nkoI4qf1YOBIaCy
         K5HoT7pcsR8XPpuXAiAusBTV8gqV/FqgYBdwUzDnuBChZh5ED/mg/eM9HKT4sW11rs7G
         5ZIw==
X-Forwarded-Encrypted: i=1; AJvYcCVCy93O90Tu/13s62sj+HG2oXJo8QpE4GIuQzawZoMKEtB58UAwZcIR8DaOBxFnYvY+UfbXgPOpEGXkwTUJtKNe+he2q2XJ+OmKTqOnmgIQImWGpswn684maY5QnAQTGHKEmT7mfs6Qw3rWiwUA/2XqpaXpYLMsa9/3RXBiiN+F2LyJIDGn966B1aTZXtuft+NpjuxZ5ba7AYbkZK11QVOr/+zz
X-Gm-Message-State: AOJu0Yxso8FfzrdH8TdBfkiZG93HYvgSoIuty/g9IlMcR+iRGnfsZKsn
	fjFZ7kdvMWc221G8DMky0lulp0/nifbHxThkZskA9jnl0JXlooIucLsp6HINmaR0UlPxwXliT15
	vWcFUX8EOvxKUpIsDPPxrtU7C2kA=
X-Google-Smtp-Source: AGHT+IGTL+ANY9Z1WiTUMovOS6ysIZX3Uxv342QYPLEI2dcV3vncrS0nHYmuzHom4rfnjZABfejkVl1IaHI99TFW70c=
X-Received: by 2002:a4a:ca0d:0:b0:599:e8ff:66d9 with SMTP id
 w13-20020a4aca0d000000b00599e8ff66d9mr5256840ooq.1.1707752881841; Mon, 12 Feb
 2024 07:48:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205060305.3594942-1-li.meng@amd.com>
In-Reply-To: <20240205060305.3594942-1-li.meng@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 16:47:49 +0100
Message-ID: <CAJZ5v0iQqHET2-vqEkLH34_dryP7yLSfkxqfsU2F33yuWkO_jw@mail.gmail.com>
Subject: Re: [PATCH] Fix the warning of amd-pstate.rst.
To: Meng Li <li.meng@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov <bpetkov@amd.com>, 
	Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-acpi@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
	Nathan Fontenot <nathan.fontenot@amd.com>, Deepak Sharma <deepak.sharma@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Shimmer Huang <shimmer.huang@amd.com>, Perry Yuan <Perry.Yuan@amd.com>, 
	Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Borislav Petkov <bp@alien8.de>, Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 7:04=E2=80=AFAM Meng Li <li.meng@amd.com> wrote:
>
> Title under line too short
>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/=
admin-guide/pm/amd-pstate.rst
> index 0a3aa6b8ffd5..1e0d101b020a 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -381,7 +381,7 @@ driver receives a message with the highest performanc=
e change, it will
>  update the core ranking and set the cpu's priority.
>
>  ``amd-pstate`` Preferred Core Switch
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Kernel Parameters
>  -----------------
>
> --

Applied as 6.9 material under a revised subject, thanks!

