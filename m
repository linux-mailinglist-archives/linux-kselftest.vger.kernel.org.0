Return-Path: <linux-kselftest+bounces-16228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D558D95E4F6
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 21:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E53AB2141B
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 19:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE011448C5;
	Sun, 25 Aug 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niGc+LSG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B23987D;
	Sun, 25 Aug 2024 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724614795; cv=none; b=DCJgkklM3DEuw/8n4GI3xIuUPId6eNPl6GVtiAW81rUglm+hLZIYOiT47D4G9J2LhEJhzV2VCn6/dBOnZ1GZG/hJ9j5zqlOf9laJqDprSr9pUjKvSFZdJi0JhebzgiGZwJQDX1GRV/5ywSfR5AGd4wwtKoWgeej1qD+G9Frp0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724614795; c=relaxed/simple;
	bh=tJFMf7Ox3/eoUXodySBxnPvVaHnjOizgVNRxMtWdrpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iwr2Qn9cfMQ0uCGb5MlsthoY1lm2onVmtl24YAzn5E/sEwcD46o9C15p0MNHxr1LO9VI4gi0M5VAu4v15EPNazdFWPX47B28ycR6ySBGiIqEmvhBe0+/TJCNtSr/T2srWPmdykMe4LnPRceHyUlFSeO77HZQ5JKbAXkxtCyzW30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niGc+LSG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3718c176ed7so2016106f8f.2;
        Sun, 25 Aug 2024 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724614792; x=1725219592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJFMf7Ox3/eoUXodySBxnPvVaHnjOizgVNRxMtWdrpM=;
        b=niGc+LSGEIFXnZC4qkAPjJXrA9o3YNZXL2khorLJ5Y6i/mRmw7DczQv+3AGq41l8K6
         jRLaCAWLjZZiSGYAbddnd9mg1yRDZL2S2JUI+PuZY+z09uW1ekiJLaXvxl/yj0+0vZQI
         QcohzQ2nwgI3sgvAwF8hF3q3lH0lsAEY5U1yHEOuZR5POlWKyRCssEkwmmMEJudFUgQ7
         Qwv/8m/ppU7xhCv7YGIz3tYbIqPp5qi9PFv4N5NuFo5DBkGZ4fJIpk6fKxeDg0kVrxU1
         SbLuLcZWJRtTwtzU2S/Rf8hUsAUgeFYxXdO5+wL9KsziEGjI2PqIse/ci4Q5aelSQCFN
         2aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724614792; x=1725219592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJFMf7Ox3/eoUXodySBxnPvVaHnjOizgVNRxMtWdrpM=;
        b=MM6Nwe+B5bPkBVqUfp7T/CfkCqSLKdTAele1Vs6eFrXu7UT5IjXYAkSYn1PLdlFZ5U
         GoOL1E+kj8sZlQqqTh7mZe0+yoJN0EfM9p0o+rGW9j8Svg2dGmM65UN8gVZWJbHTq8aB
         UsS7mdeYLKKpcaoSK9VSsiu8i7oiJqlmw+Ef9I1gsOkmnchoyxqIBCPvWE6gxea+YRFG
         LSdwCMsJXAceRdX8x0yOnnXI4wQ3YPjnzmScz+ni90Hyjkad9weqrCq+KbZwEfB/x9dQ
         ufEoDhqjT9mYo3C+nihHmQcDRJokUzzCSUcOd/fgZN6FN9rvj4C0WztIuG9epQqInCCm
         lyQw==
X-Forwarded-Encrypted: i=1; AJvYcCUKYCIWJpH2HkQqYXgxq+DNz+iR4Sqn5l4bZ1fmQ4HaVYEv3OJKtaE/wEIv/MhFx64HzrtEzh0PvDPwOQLd@vger.kernel.org, AJvYcCV3RAnFCYkvMZ94SJrVCh92J/7i737ITfn6oSbdQ6OQt3qZVAbs/R9icFY0y6npbDMQxnM=@vger.kernel.org, AJvYcCVr+1jJCIqdsrorcM09WT2TZjT0gEmwa5d9Gt5GYL6VOE5P5KgzAHhL19k9mvLMUh1V1iHFjmZP5IACBLUYphnl@vger.kernel.org, AJvYcCXjqx2F80k4HgISXYBDfXcP0EWDOcQDACj5opDxZhqpMt6GHirQWApLaeRJV7k7dUSPki13HlPj@vger.kernel.org
X-Gm-Message-State: AOJu0YynUYCeXIQIVGQ/2WRF1F60WigRYaeNNecw2Y4mrJp6FYmybhuC
	Af9ddi28rujhaPi/jN50HQOlBmcBRKoFHfdaoo3RK0zlD4WbbdG54Dq1uf3Prl4UERCfp/9RoR9
	dCTpB8yDUpkVrwezylroVYVtAOzc=
X-Google-Smtp-Source: AGHT+IGFbKNA4xLPSpMgdIAMRw0iydK7vN0/OI26qARJK1To1kpg2vBiPumvMtuCJAricMBw6H2GFqQcYHoRXaV2YOI=
X-Received: by 2002:a05:6000:1006:b0:371:82ec:206e with SMTP id
 ffacd0b85a97d-37311840ec0mr4673128f8f.5.1724614791663; Sun, 25 Aug 2024
 12:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
 <20240816-ups-bpf-next-selftests-use-khdr-v1-1-1e19f3d5b17a@kernel.org>
 <CAADnVQ+JBq8-6Rhi_LHX470uj2_2xxJAhgdUfg_abUxEDqpdJQ@mail.gmail.com>
 <6a693ad6-f145-48c1-b3a7-d441d3764e73@kernel.org> <CAADnVQKnEuQ4XZROLWH47mEZNwnJ9TuyTrauOnuobcLgVMrimw@mail.gmail.com>
 <41ef2c53-600a-47d6-a35f-674e1e7860f8@kernel.org>
In-Reply-To: <41ef2c53-600a-47d6-a35f-674e1e7860f8@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 25 Aug 2024 12:39:40 -0700
Message-ID: <CAADnVQKoesL+Rmp9eB6mQbU1J0yDWgFioigy6jK6XMsd3S1u=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests: bpf: use KHDR_INCLUDES for the
 UAPI headers
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 3:37=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Now that the CI runners have been updated to use Ubuntu 24.04 [1], we
> can use mptcp.h from the system headers, or do some actions via
> IPRoute2. So not having KHDR_INCLUDES is no longer blocking us for the
> moment. I think it might still be useful to add it for future use, and
> also to use the latest version of the UAPI headers that are not in
> 'tools/include/uapi', but I don't want to insist if you prefer not to
> use the latest version.

Let's not fix what is not broken. We'll add KHDR_INCLUDES when
it's actually necessary.

