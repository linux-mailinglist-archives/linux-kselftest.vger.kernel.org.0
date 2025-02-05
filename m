Return-Path: <linux-kselftest+bounces-25817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A89A286C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 10:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA2D162B17
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA422A7F3;
	Wed,  5 Feb 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0ouUcBU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FD22A7E4;
	Wed,  5 Feb 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748352; cv=none; b=WdALuk7SNfeIr1BISfIOEuHZADOH11s7MdyQt34Sj2npzRJ0OQ1M9ModD5/sBDs7a3jrZEAltP4zr34bgxmf0Mw5SPqJkwGzFRuCPLOECqAaur0lfpKEB3odg0eEgLkyNF8yb8LWofN5D4MIrs4Y7bctc/Y9bSepBPHeFzGBmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748352; c=relaxed/simple;
	bh=Rxon6PTD7daRJg0+aVySuS+0sANyOmpEYks80AvCv/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gu7OZ8/t4UARtQyycKijBQwwoPZfOOTjB1WJMO/3NHVnFfkR5xHJni8zNMkM4J3myfTxANF3HBB7VCgXj01CcBTlzmvjlQp3D+8BcdHz9WobaQhWptffhKaMK+Vqwhnlh75r/dFm98iXJVi0CNU0fxLQB0tOI+tzuikRbFLtnHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0ouUcBU; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so20992335ab.2;
        Wed, 05 Feb 2025 01:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738748350; x=1739353150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJCR/SfTU0C0sRJZd2HUPVpgMo5fZYOkbmZsnQM0lUA=;
        b=V0ouUcBU1aIelrb7ruT2TvTk4Ai07ufN+bvUMhjt8sA//himWgPv2csUSK3BFAR8mM
         UGUhUZeqRDKyrIbKKOvFlNRiTwaNSXLA4UDJt3VtoQixVsM56ZCv7vEJmd76hvs88dom
         4GuTo4XwAPL3DcW20vZe3H5YOBl6Ijt0Ty0CCnjzQw25zqgSeu0E5JoL8GHRjKUjQI04
         j7CcsDAm9ZQJIwMdceeFuNxYIP/PygTn5tbDL8l3lpTRr3RR/mE+vhCBJvzhjGUq/fpW
         HiQYiMUH6e561z/sit2PjVXAUIFMSRULblPKEc/MLRB7/KJGDBwx3SZnVntvt6QBeRbJ
         6q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738748350; x=1739353150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJCR/SfTU0C0sRJZd2HUPVpgMo5fZYOkbmZsnQM0lUA=;
        b=F5hyFMgbBBdfmrI16MqdeLF1u7oAJCEMU4vLdW0uNEZZ0D2AVXg1HApg9tlCQUqqjd
         9LMcSQ45MXKkqHhG3g1AxKRr7NtCBJFrHzwR0F8+NPjFHSVM8JaClmthXRMGleXiFt9X
         s7SaVr5RUd8Vmz7huVsnfckhsNh6JpmDmFI76MYjDzJpR8ejEpoEQaEiAgY8kCu6A5do
         IjzFNMFgFmO43FfV/sDg7HlQEuX2fF2DLkRAkaKr6VMURIgNUoA5cptQjvjTr0vYcx5M
         ZnF5N1aTFW+IFoqOPWCX2ZOA3IOTWGLiZ3kw5dJqQSUYuRo4IjpC+Yq47HlMVkpBNPp2
         i0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXieftqypiJe0em1um5vNd7tUHC+lzv0KWtrzxR9wE/0EdydmwNrJaSKzVy2z09xUpibfcopJmDvAPOIihepho=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqol2Jp/FOtY/9f5Wh1GI0opIRlPZCTG2APwBv3/2Lg8gp/z1V
	JK2ajp/LOxkLKQisGO790IS/Mbhr9uBncxZ49Zk2734zOykuO8YO+8XJow0Sq5Jt2aXkZGtTYrJ
	z99VOTqTDL7kKVu5p1LPmAeg5DR0=
X-Gm-Gg: ASbGnctdj7NJPO4wtFfv7Nys2zDmiYy+fdIokfgRrzrSMsDJ/vtEfT/FuG6MHqiuA+H
	VjSopJXqmS17wkLXVWR5G6U9F2yBir0iyiQ5adoaa6s/+YP+Prc2Z/GEU7pzKV3Nnb5Tq1TRq
X-Google-Smtp-Source: AGHT+IEjYWCRfmKIJ3npYCWHVcL0hG2R2j79Cy2iuxGpfdAhG+/yDIjpTXPZJXWiyh1Q8y4VsdFPMVD5a03ggM/VZ2I=
X-Received: by 2002:a92:c565:0:b0:3d0:47cf:869c with SMTP id
 e9e14a558f8ab-3d04f93131amr19140435ab.19.1738748349747; Wed, 05 Feb 2025
 01:39:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
 <20250204023946.16031-3-kerneljasonxing@gmail.com> <99ccf971-cae5-9c45-5dff-2c8563a7879f@huaweicloud.com>
 <CAL+tcoAkyjDQd48wKuA8V_RE6j1OYTL2iGxT8HdVKpryD3SaUA@mail.gmail.com> <b13c3602-69b8-7452-f342-8204287cea4d@huaweicloud.com>
In-Reply-To: <b13c3602-69b8-7452-f342-8204287cea4d@huaweicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 17:38:33 +0800
X-Gm-Features: AWEUYZltfuwHeJsbk39oiKI_AKRp6YWEhV_JaOvLDAIa7t1PFt-2HYxOZvdcX9M
Message-ID: <CAL+tcoC3eQew6R2Q=nZSus6p5d2pvF3kFbe_=ibPrPvzmjiD3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: sockopt_sk: fix 'undeclared'
 definition error
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:30=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 2/5/2025 11:27 AM, Jason Xing wrote:
> > On Wed, Feb 5, 2025 at 10:57=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> On 2/4/2025 10:39 AM, Jason Xing wrote:
> >>> Error messages:
> >>> selftests/bpf/prog_tests/sockopt_sk.c: In function =E2=80=98getsetsoc=
kopt=E2=80=99:
> >>> selftests/bpf/prog_tests/sockopt_sk.c:22:31: error: field =E2=80=98zc=
=E2=80=99 has incomplete type
> >>>    struct tcp_zerocopy_receive zc;
> >>>                                ^~
> >>> selftests/bpf/prog_tests/sockopt_sk.c:169:32: error: =E2=80=98TCP_ZER=
OCOPY_RECEIVE=E2=80=99 undeclared (first use in this function)
> >>>   err =3D getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen=
);
> >>>                                 ^~~~~~~~~~~~~~~~~~~~
> >>>
> >>> Fix it by introducing the right header.
> >>>
> >>> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> >>> ---
> >>>  tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/to=
ols/testing/selftests/bpf/prog_tests/sockopt_sk.c
> >>> index ba6b3ec1156a..e0a9785ffcdc 100644
> >>> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> >>> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> >>> @@ -2,7 +2,7 @@
> >>>  #include <test_progs.h>
> >>>  #include "cgroup_helpers.h"
> >>>
> >>> -#include <netinet/tcp.h>
> >>> +#include <uapi/linux/tcp.h>
> >> Should it be <linux/tcp.h> instead ?
> > I thought that too, but I altered my thoughts after reading this
> > commit[1], totally without knowing why the tcp part should be changed.
> > Should I change it back?
>
> Thanks for pointing the commit to me. Under my local environment, it
> seems both netinet/tcp.h and linux/tcp define tcp_zerocopy_receive and
> tcphdr, and I think that is the reason why the commit changes tcp as
> well. For the following build error:
>
> selftests/bpf/prog_tests/sockopt_sk.c:22:31: error: field =E2=80=98zc=E2=
=80=99 has
> incomplete type
>    struct tcp_zerocopy_receive zc;
>
> I think maybe your local environment is a bit out-of-date. I prefer to
> keep it as-is.

Thanks for your review.

Right, but I believe many users can't manage to upgrade to the latest
version for the whole system. The selftests are supposed to be
compatible, I reckon. It's surely not bad to consider the
compatibility after adjusting the header file.

Thanks,
Jason

