Return-Path: <linux-kselftest+bounces-10996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332408D603E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6641F233EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A91D156F46;
	Fri, 31 May 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OeS8pXcO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3F153BC1
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153616; cv=none; b=kYdWY4JQFmxSieo0fjwkOXTQCealJLONm6ZTfHxfWnNbAkUPxEHq2OxL7V8RxiEv4S2Kc0ZxocJ5cZeMzeHgLAHEY8CLfDTKOmWO80OnyRes4b/dtQZUJuW25CIMloDxTgrk86BUD65VWPgHjy7ZkJ3/TeU7q8beiUvzlkwaOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153616; c=relaxed/simple;
	bh=b63JTI62Pg8zEWJQ7SVpv+5RvTmJQ7KBtaQNOw86Wbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yd6fYK+kxekLKggWeSRWgKbVqLHaUklICbk9pIP/V0QahPVsqEArs1xm4hqCyMsrFEFWKpsLeoiEhiTGKLZeaz4I7rjRxOWLiLYEfFe+Ve+kwxHebMsh8KXO0G5DB2DAYkB1mU3CSTQXNg4cBrwZzBx7ocKsU90pWdR7ANWsM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OeS8pXcO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b78c65cadso2542661e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717153613; x=1717758413; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3mdfv2rH3R+xYGKIe88q8x7+eTV4JK7os4By2FXBeo=;
        b=OeS8pXcOuDNdBVZohp0UfMEj4awJocL8s8S4Mprw4joDmXv0l1HTotG5ASpxUsKzKH
         a1TwAEdVbunDM+A5hKOpesWNA/SwQDCS4Mj9KIXFEj9av7eaKg+d8kjt1t3THeII37yw
         El+QcSbhRkymySl6S82mn746kcYwjZ3Dr7LIPucmjqWesQGFWZJRkg2LZ826022/0cg9
         LkjMDwsLCPIcCFLOZYnflu8FyuDtFBqLfT83c+LaPXqSm1/ies/oWjez1YlhZkjwOgDp
         8UU1A9q4zhUgfxM5MW1MbC6xEYVtM3AaDSQRTG2fhe8Q6hDhmL+3KNCxGsBY0Upc8R+G
         7kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717153613; x=1717758413;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3mdfv2rH3R+xYGKIe88q8x7+eTV4JK7os4By2FXBeo=;
        b=RD5NeoidxWUY/pDmqdUzWqlSglLj+Kxcf0r0m1CH8CLt2LWsj+JhSOzMXvy+ec+LxO
         yiCbNW+8iZ70C1/sx0CpfBR/l2XSFef2dvdhWXei61QYjgoqs15PAuEoX+gROnlJisge
         Q6VjBKUVnJsgVoxPzjlX69NRZXM4Xk4nXU4YdPwGZHImj9uoe8ScABov/aQIFlP3cjAU
         Zf0C6BZEkXuxQtquNu+AgWcBoDiSvOamYuhy2AX29X8oObgBYI5oYID/SFYWGe+5Pnio
         g5ummttj+7Bqbn4v8K5O2k72G1dsg2k/wL3evapuvwbCxFPerFGhzklbFaYuerUpoUAL
         GGQw==
X-Forwarded-Encrypted: i=1; AJvYcCVIrBWi9F/iSc24LmH1up2CECErl1IQRB3U+CB+NySb9n44B0HYh5+axCozYy+0ehy77Dq/vrti1X6DvrGaucxuKkWCNdaBQnLbDEFbm84L
X-Gm-Message-State: AOJu0YxxOetOmSCrUIbpfhLmkVmgQzqafrfx/WM047G/R1h4YygpnY4G
	+KSG4MqlRnSCxqwwZei8d07mu92TzDHRYRQyR2sT/wVAcxUTd/G1tVPt0AH5coI=
X-Google-Smtp-Source: AGHT+IFrZEZzV53dUiNjC5OJwpp6b4oDHNv0nM7PrOe0AonBpEcRsg1aMk2Ca7cx4hhhCwlWSelU3g==
X-Received: by 2002:a19:f804:0:b0:529:a6f6:1b03 with SMTP id 2adb3069b0e04-52b895609ccmr1075401e87.14.1717153612612;
        Fri, 31 May 2024 04:06:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eab85f32sm75165066b.180.2024.05.31.04.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 04:06:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@google.com>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Geliang Tang <tanggeliang@kylinos.cn>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/8] fixes for test_sockmap
In-Reply-To: <cover.1716446893.git.tanggeliang@kylinos.cn> (Geliang Tang's
	message of "Thu, 23 May 2024 14:49:56 +0800")
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 31 May 2024 13:06:50 +0200
Message-ID: <871q5ixmt1.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 23, 2024 at 02:49 PM +08, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patchset contains some fixes and improvements for test_sockmap.
>
> 3-5: switching attachments to bpf_link as Jakub suggested in [1].
> 1-2, 6-8: Small fixes.
>
> [1]
> https://lore.kernel.org/bpf/87zfsiw3a3.fsf@cloudflare.com/
>
> Geliang Tang (8):
>   selftests/bpf: Fix tx_prog_fd values in test_sockmap
>   selftests/bpf: Drop duplicate definition of i in test_sockmap
>   selftests/bpf: Use bpf_link attachments in test_sockmap
>   selftests/bpf: Replace tx_prog_fd with tx_prog in test_sockmap
>   selftests/bpf: Drop prog_fd array in test_sockmap
>   selftests/bpf: Fix size of map_fd in test_sockmap
>   selftests/bpf: Check length of recv in test_sockmap
>   selftests/bpf: Drop duplicate bpf_map_lookup_elem in test_sockmap
>
>  .../selftests/bpf/progs/test_sockmap_kern.h   |   3 -
>  tools/testing/selftests/bpf/test_sockmap.c    | 101 +++++++++---------
>  2 files changed, 51 insertions(+), 53 deletions(-)

Tested-by: Jakub Sitnicki <jakub@cloudflare.com>

