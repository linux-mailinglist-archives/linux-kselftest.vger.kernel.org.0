Return-Path: <linux-kselftest+bounces-15922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9186C95A66E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC21B22B48
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0092170A3F;
	Wed, 21 Aug 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHHJGkpx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596A16EBE7
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275293; cv=none; b=j2vpnAbOBgKn1QIVRWDqu6aO/vtcyGx5SCCzZc6XySHrivcV17s0quNVKexsF9EE2wdMNGdllvT8MhBokYsCGU4gao3hyHIbghzCLoOY7RY7ImGXwcY8cOvVnQKK9X861cUk7+zvfimnrpMafWADC3vcDDV5Cm4D3GdEx5pNOD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275293; c=relaxed/simple;
	bh=ofgO8rJn0R2XGzo9oE+JGIZiUkQd3ZiMijEBH3Hva2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+w/tmbZxzh+J2CovB0PMahOcrxX0RQRXvnxDeH6tnk91KJ3CFFmQd8WIm2ncwBXIS+LsKGb7gCqOhm4vnV2LJmjb2Na1lAd7wkmxsYzeooZyQ2l0Hoqb90fRxt7WqYBGVbAE9KnXMr7nLLl4RPdiJ9vFHEsqiKqUWP/zRSQwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHHJGkpx; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-842fd4e4de7so56245241.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724275290; x=1724880090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfpBnvtVOlaRlCTMazncTSnie5oJO9jbnKby0uu1ynQ=;
        b=EHHJGkpx6M1vjtXoXmS4pEsFEItQPeRCQ+0lPYA1nK7MTIShPFGSzFFXm7T68yKHw3
         7Lf1G5x/h6ORGzDqch4zY3y9fCtyi0blbXxmYGdhdPRnZ4O21ZiWHiA0q5oOjXfTFwAA
         AC7ZyRJaOusYCnd4+52Yv37IqbUh3Z79RlHhu1XeDZKoV4PUZSBD3T0dcpn1fbXb/Anb
         3PAIeazH+18ik2PXozeiZkuXqf627LYe9/ZG2rJkWi0H5ChjKyy6rMCb7Z+wBbPCYvoN
         ER3R8Jf0iiUDnm5sbizLCD5hEzo3tioAi/OvMKYKjnGoOG4XffMdybECtmyjmak5cAKS
         0zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275290; x=1724880090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfpBnvtVOlaRlCTMazncTSnie5oJO9jbnKby0uu1ynQ=;
        b=IyQlgBR8luDNz0YUVi4x7+GFKKMn40uep60rGLYg33tkfxzTl7ulXxxTA81Xk8ZTGw
         79pZ0lyBQFBFB9/oPtiu/GmyNgrmNNm6GRPL/U6kKIJcIVRlOEawmROEQoZk8CxWkzgy
         CnTpEQYc9GgEhELhVddeCnC72S3p9KlQMyZYqT2I4EaufqyPP59f6bnAcnpJffllh9fI
         f+a2mYhsn8oe6keYjs5gPod1G8ZWjROx0cxRjaWR7YO6P3hHY3z1cdKGaFeIUKHpBwtb
         mT/BcVGPOVu9QRXKl/MOckFEBCKim/E9E6O0Ey5Y++eb2H0Zor+Vw6F5zIyasKFZEFJy
         JJYw==
X-Gm-Message-State: AOJu0Yyqausp5hGO+5Jg6GC8um7nkzQswKpwkGfSc1VlAV7hrvtvxCHh
	tuCAYFIR+Kbyhwa6qTp9jT0wr+1b7qF9FTl+3I/Qapc+UkXSqXVR6DYYEcEGspUGRe06W4eiYWj
	cfRnaRLTWUC/3wGRobU71xyjkmHTsZwr5E61K
X-Google-Smtp-Source: AGHT+IEdKZnlbKepPcBTId4+p8yQPhKFdS58AehZUvmD8MtM31QiRtk+2loVimrS9a+plZtzJ9suqTejtDgGSdQ49Cw=
X-Received: by 2002:a05:6102:32d5:b0:498:9c0a:af1a with SMTP id
 ada2fe7eead31-498d2e999e5mr5218311137.4.1724275290316; Wed, 21 Aug 2024
 14:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821144305.1958-1-michal.wajdeczko@intel.com> <20240821144305.1958-2-michal.wajdeczko@intel.com>
In-Reply-To: <20240821144305.1958-2-michal.wajdeczko@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 21 Aug 2024 17:21:17 -0400
Message-ID: <CA+GJov7DXbpEpvkDfSJDEvkcjEq_KjreZdBksFAOrt20j_rzUg@mail.gmail.com>
Subject: Re: [PATCH 1/4] kunit: Introduce kunit_is_running()
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Daniel Latypov <dlatypov@google.com>, David Gow <davidgow@google.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:43=E2=80=AFAM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> Wrap uses of the static key 'kunit_running' into a helper macro
> to allow future checks to be placed in the code residing outside
> of the CONFIG_KUNIT. We will start using this in upcoming patch.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

Hello!

I am good with this. It is definitely a prettier way to access kunit_runnin=
g.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

> ---
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  include/kunit/test-bug.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> index 47aa8f21ccce..e8ea3bab7250 100644
> --- a/include/kunit/test-bug.h
> +++ b/include/kunit/test-bug.h
> @@ -25,6 +25,13 @@ extern struct kunit_hooks_table {
>         void *(*get_static_stub_address)(struct kunit *test, void *real_f=
n_addr);
>  } kunit_hooks;
>
> +/**
> + * kunit_is_running() - True, if KUnit test is currently running.
> + *
> + * If CONFIG_KUNIT is not enabled, it will compile down to a false.
> + */
> +#define kunit_is_running() static_branch_unlikely(&kunit_running)
> +
>  /**
>   * kunit_get_current_test() - Return a pointer to the currently running
>   *                           KUnit test.
> @@ -40,7 +47,7 @@ extern struct kunit_hooks_table {
>   */
>  static inline struct kunit *kunit_get_current_test(void)
>  {
> -       if (!static_branch_unlikely(&kunit_running))
> +       if (!kunit_is_running())
>                 return NULL;
>
>         return current->kunit_test;
> @@ -53,7 +60,7 @@ static inline struct kunit *kunit_get_current_test(void=
)
>   * If a KUnit test is running in the current task, mark that test as fai=
led.
>   */
>  #define kunit_fail_current_test(fmt, ...) do {                          =
       \
> -               if (static_branch_unlikely(&kunit_running)) {            =
       \
> +               if (kunit_is_running()) {                                =
       \
>                         /* Guaranteed to be non-NULL when kunit_running t=
rue*/  \
>                         kunit_hooks.fail_current_test(__FILE__, __LINE__,=
       \
>                                                   fmt, ##__VA_ARGS__);   =
       \
> @@ -64,6 +71,7 @@ static inline struct kunit *kunit_get_current_test(void=
)
>
>  static inline struct kunit *kunit_get_current_test(void) { return NULL; =
}
>
> +#define kunit_is_running() false
>  #define kunit_fail_current_test(fmt, ...) do {} while (0)
>
>  #endif
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20240821144305.1958-2-michal.wajdeczko%40intel.com.

