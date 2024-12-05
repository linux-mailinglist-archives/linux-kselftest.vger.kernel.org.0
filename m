Return-Path: <linux-kselftest+bounces-22890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4B69E5F30
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 20:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF845285D50
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF722D4FA;
	Thu,  5 Dec 2024 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoJLV9Jg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778722D4E2
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428478; cv=none; b=XXhCtnsFqsOWUgrNGM3fX7mZ1Ik9VNuBfWgw/Ukf0Rl8p0Qp5XqDJINh7EhY/fZsqSrvTgryatqGqHpLdwUtnRsQWwNhlKvtUy8hCFDMrhYM8561xA8nvvS1AawDv7JSPF4UsQeuQonCv1QyMvfK/gG+Fc3vg4ojAXbxut9W5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428478; c=relaxed/simple;
	bh=vhbbHz1yBMg1oLY8i08EsGZhgnjN0h92EmEVlCnFACY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2uo1NIXD0F1oTJZF6ilEBAg2zgS6zpxAIsBMH6YCFTJu6SO5CSae+8Bo7aRZCPIrHp1smo3lf+gj50fKSJRr84ygACVcHuFdXO9K4enqMPtONGg6Gz02NHTMRt2QK8zkSblEDB6B5ESGy3ixAcxT+GEKQdBpL5EpfqBtmj559Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoJLV9Jg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4349ea54db7so9855e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733428475; x=1734033275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YV1GOShnKkFf0HLahvzq1w+GJ+Yzlm4X88Ky6h9+fMA=;
        b=QoJLV9JgDl34C7Ugqfm9XdnfyPQLc4Lm5yKF+NeashYgx195kbauZjmrx5UP3zT77I
         MdaKFvpzkMBSPBnwJ0274q8b1280iAjuwwu9WdBxR8UX+HcgBwwmDGS2Udjl3+ScHzDl
         oPhxNHzqhCee4nX1r5ToPNn/D88EklYAVlMbvCf52wwCzj4a//HTHo/c49JMm39lKl17
         bFYFYGWsbyIx+MyywsV+Vi+HKWVz0WkL9lh8mRsyu7mqgu/b/6MedyPTsN8Tgy/7iEsf
         IRAmwR3/NuK8IW5t4qId2sXvmwZJKjBWFKlLGDLsm3gLKTNRbRD/6jOv+ZkJlgeNzWf1
         t0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733428475; x=1734033275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YV1GOShnKkFf0HLahvzq1w+GJ+Yzlm4X88Ky6h9+fMA=;
        b=JuRKPZeEbA92/rFozqSgbh3nNWandoGe7y+jFtH4zSSoTXbMB7fpmHDiW+jlEMucDM
         mr/P8M/m3WS6HpK7Q7At60RLNkwrHASBXaeAtdn9VKAIEMMOA5CHGzMJMtIBwSS47pvj
         CADIz1DEi7d7FR79gf3MW1AfZRDAZKk4FQdAa3Hr7yFqkpuVY20JBJY3+H1yXGJwBtnm
         lx234rgk1Fi/8dNMchbv9STj6ck73jCf620CIsPv8v+TcjCB06jwTJLx7aLjFjIZhB5L
         NdW2Bk+IGe2Qv+v2A7tc2kSIkxXeQBFv6nUH81NS9USkzQeMcc0hUyCewA3e4h4L4aPX
         uv7A==
X-Forwarded-Encrypted: i=1; AJvYcCV1qAICKd54jSsnZW0rTVqKH8kPH20KmE4vK/MsPV8TjXhVY1WMCrDwZTJhVDUxkjNUIFVMEEUZxUB1rQUru7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcPAQDLnq9v2VG8Ek1Jg64kKye5UgCdNsEWoK68QEzluYteEG
	uW2/P07u59yswI34rf+w5Htn0kn9q1Imz0g7T7PndTtLLQhEcKeid0da1l7SKLU77OFIdrNy2yX
	hTpv9D8L/DiNsmJ/0ECktcHZefpLakpdEw+hj
X-Gm-Gg: ASbGncvAGFkB9dCKuX8pbTTRckxI7JVUJ75UZrsZ+DF8kEzd8Is8zx0ZVByH60w2DQM
	H72oJcB5PycQnU2noXKIlaoLDuSeTKUD/8RQF4W9iI3ZLDukpnfzYdgtCvERc
X-Google-Smtp-Source: AGHT+IEg8jS6R8nzvvgqFY4eAzSsGGb0NyqX/at7eAZ/z8kw1IzlpGFkHWMNC7b2JnZaKud2fJhzbW1s/D33iVi8sr0=
X-Received: by 2002:a05:600c:5846:b0:434:9e1d:44ef with SMTP id
 5b1f17b1804b1-434de647452mr97705e9.7.1733428474682; Thu, 05 Dec 2024 11:54:34
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205192943.3228757-1-isaacmanjarres@google.com>
In-Reply-To: <20241205192943.3228757-1-isaacmanjarres@google.com>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 5 Dec 2024 11:53:57 -0800
Message-ID: <CALmYWFvGZj5Bc8LfveMCc=3ZAgd-Lqr=186K4swpnTc=2a-JkQ@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/memfd: Run sysctl tests when PID namespace
 support is enabled
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Daniel Verkamp <dverkamp@chromium.org>, Kees Cook <kees@kernel.org>, stable@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 11:29=E2=80=AFAM Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
>
> The sysctl tests for vm.memfd_noexec rely on the kernel to support PID
> namespaces (i.e. the kernel is built with CONFIG_PID_NS=3Dy). If the
> kernel the test runs on does not support PID namespaces, the first
> sysctl test will fail when attempting to spawn a new thread in a new
> PID namespace, abort the test, preventing the remaining tests from
> being run.
>
> This is not desirable, as not all kernels need PID namespaces, but can
> still use the other features provided by memfd. Therefore, only run the
> sysctl tests if the kernel supports PID namespaces. Otherwise, skip
> those tests and emit an informative message to let the user know why
> the sysctl tests are not being run.
>
Thanks for fixing this.

> Fixes: 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_=
EXEC")
> Cc: stable@vger.kernel.org # v6.6+
> Cc: Jeff Xu <jeffxu@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/s=
elftests/memfd/memfd_test.c
> index 95af2d78fd31..0a0b55516028 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -9,6 +9,7 @@
>  #include <fcntl.h>
>  #include <linux/memfd.h>
>  #include <sched.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <signal.h>
> @@ -1557,6 +1558,11 @@ static void test_share_fork(char *banner, char *b_=
suffix)
>         close(fd);
>  }
>
> +static bool pid_ns_supported(void)
> +{
> +       return access("/proc/self/ns/pid", F_OK) =3D=3D 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         pid_t pid;
> @@ -1591,8 +1597,12 @@ int main(int argc, char **argv)
>         test_seal_grow();
>         test_seal_resize();
>
> -       test_sysctl_simple();
> -       test_sysctl_nested();
> +       if (pid_ns_supported()) {
> +               test_sysctl_simple();
> +               test_sysctl_nested();
> +       } else {
> +               printf("PID namespaces are not supported; skipping sysctl=
 tests\n");
> +       }
>
>         test_share_dup("SHARE-DUP", "");
>         test_share_mmap("SHARE-MMAP", "");
> --
> 2.47.0.338.g60cca15819-goog
>
Reviewed-by: Jeff Xu <jeffxu@google.com>

