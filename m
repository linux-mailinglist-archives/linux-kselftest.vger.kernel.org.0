Return-Path: <linux-kselftest+bounces-30949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CAEA8B8CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 14:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021C3444ECA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC91221272;
	Wed, 16 Apr 2025 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="m2FT9p5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF31FECAF
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806124; cv=none; b=VE/angUxHhMVwTgITR1gbUHrKrS6qdcJnoXFASLgTTi9PEiIsw3rNOjgD9g4NMs5K3EiiL92stk0NNarfMDqwjOsNUMMPVlFr3VAGm0JpNVvrtiK8CivjrDtvg8PXfKcAO0R6ak9kI6jgUySFBwv2gh3pmAAwt0MAFLOpehKCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806124; c=relaxed/simple;
	bh=EFnc0WRzEf4Z9yc61d/RyuErKOJdh7/lCVhtPeNIyP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF/G83UMf2Vr2Sl/JWsYtP3gTI1Ts7R7ud2QalBZxDP4nZJSM49F0ssu773BweymG51c5VLzYDAvfnLVpdO5iB81lZWKtQOwMF/ri1dYfcG6n+RLhjbGr7B+YOHsyzqiw5DiDIWNvXJwdPXm1Z9x4qEh1Hz9BEEyaYR81sALtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=m2FT9p5S; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso7437261b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 05:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744806122; x=1745410922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+WVF0vgix7mkFpfvJCcnuLkknP11Yltc17yhUbYhWE=;
        b=m2FT9p5SMyOk2QGktkchCS4jhGeqdKKKRBBOMT26kuUOefFGjGg6abxZLxUSK5umKj
         VgOHfnRgm/vZnMLQ30bFwv4UnL/kocF+CkaVNHkKehfr19VSrnd/15Pi8Y71CTsoj22c
         dsyApoOiqYWMB66XVkqFb7totcFsM1NBXrFyTeGtQ4/Pzj4fEIFxpWMt04zN0X+qD/x/
         LuEgln4kGtndtbvIRIqpHUN9XWx8pdcTQwNgDITt15D1/YE+Khx/qKkO3JZy23WVu7uv
         iYEyBG4I+m/yX2Ir2wcz5Tc6uaJMtx2IfP6AqQHnTPyG/vXzjhMPd88inIV9vt1qf63o
         /KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806122; x=1745410922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+WVF0vgix7mkFpfvJCcnuLkknP11Yltc17yhUbYhWE=;
        b=tr92iBXw8smm83Fv1bk9i8bhlloTVfoQI17DsgSXMTjtC4xWGaXk7AFIWFuQr+KtBP
         XwZKLc+E0TBS3QrYfG3picnPLSyu0SYAAuY/tuF2b899L/cy9WV/ljdvCDKC3AlAUawY
         fO65GZ8SI9+it09grO5xptBY/EfsKF40XL8sz9tje8CP8nIX82Bi/lCRZEnFGsXgdlAb
         OJ7u+ACzOXUu2/gGr+S1y5+ilXn6UVyf5cxC78fCXHga18eHHTlvOCMN7Z/zl+1jGEj1
         Dttf+wfqa1Le5d0EY3hRKF0dpTXhy6BP4TbCAGemlqtWcCMXt4TyhEGqlXwbjYn2K9qu
         exxg==
X-Forwarded-Encrypted: i=1; AJvYcCVx063YZgcGIId3eWTct/nLUfTpFGxuDgtwiq5hMpdXcW6BEGNAjj2pQcbaMyAgJkaSPsxx7qAk0ozl6eHBFew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1epPIfjk1abJBPaw6w17cb5b9X/Sy78WjTszq2ZuDOX5WGyK
	JRjQkZsW5HttvwqwJvsuPlY/ifhgsSetsjOD7Nt3TM/uTAPc0ANegccCMRCxpg==
X-Gm-Gg: ASbGncsowDdEGgL5kuMF4AJhS9ZC70lf5ZSMqWF+SdBUXFmUKIvgpBOvO6EX/j+SFSC
	nPUxH0v37B+O2sY4vcL78TG0jp+50ejPviKZvSRv0UN2SfYM9ErfySXFEv0u5saaRpNNRWhpnU4
	hqL1BnCCRvTUE5BBXMNZjMw0fetAaBOo6DAlaYWvSKqy/k+Y9WoJxKitvteMPD0AxCjUFz7Mluc
	JnAqCmHwK+PzSDac9jAjvTXJUlq6RGrOa7y1MgS1MF69iPfR0x0aq7BPHIpCgpgjqnxvHDlJf4+
	KRpOL9Bkocwbi9lFAXqkPtC6zFwBgYq0+N3/RE1uXxH6Uepb8Ml1ORjwVln4gaAgYPmhLcq2Flj
	62bKGY3cKs0s=
X-Google-Smtp-Source: AGHT+IFS1pvArZ0aCV/sDSsf7um8PNFWJi22sTowudeeDBY25iY+lGk3il3k6n4C6X3PsuIgZ8ss0g==
X-Received: by 2002:a05:6a20:e188:b0:1f5:6f95:2544 with SMTP id adf61e73a8af0-203b3fd47e2mr2328501637.33.1744806121845;
        Wed, 16 Apr 2025 05:22:01 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:dc7b:da12:1e53:d800:3508? ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b220fc366sm1112316a12.42.2025.04.16.05.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 05:22:01 -0700 (PDT)
Message-ID: <ef8c59a0-be86-4ddc-b25a-d198051f12b2@mojatatu.com>
Date: Wed, 16 Apr 2025 09:21:53 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 RESEND iproute2-next 1/1] tc: add dualpi2 scheduler
 module
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
 liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
 Oliver Tilmans <olivier.tilmans@nokia.com>,
 Bob Briscoe <research@bobbriscoe.net>, Henrik Steen <henrist@henrist.net>
References: <20250414131859.97517-1-chia-yu.chang@nokia-bell-labs.com>
 <20250414131859.97517-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250414131859.97517-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/25 10:18, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> DUALPI2 AQM is a combination of the DUALQ Coupled-AQM with a PI2
> base-AQM. The PI2 AQM is in turn both an extension and a simplification
> of the PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while
> being able to control scalable congestion controls like TCP-Prague.
> With PI2, both Reno/Cubic can be used in parallel with Prague,
> maintaining window fairness. DUALQ provides latency separation between
> low latency Prague flows and Reno/Cubic flows that need a bigger queue.
> 
> This patch adds support to tc to configure it through its netlink
> interface.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Olga Albisser <olga@albisser.org>
> Signed-off-by: Olga Albisser <olga@albisser.org>
> Co-developed-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> Co-developed-by: Oliver Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Oliver Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
> Co-developed-by: Henrik Steen <henrist@henrist.net>
> Signed-off-by: Henrik Steen <henrist@henrist.net>
> ---
>   bash-completion/tc             |  11 +-
>   include/uapi/linux/pkt_sched.h |  39 +++
>   include/utils.h                |   2 +
>   ip/iplink_can.c                |  14 -
>   lib/utils.c                    |  30 ++
>   man/man8/tc-dualpi2.8          | 249 ++++++++++++++++
>   tc/Makefile                    |   1 +
>   tc/q_dualpi2.c                 | 519 +++++++++++++++++++++++++++++++++
>   8 files changed, 850 insertions(+), 15 deletions(-)
>   create mode 100644 man/man8/tc-dualpi2.8
>   create mode 100644 tc/q_dualpi2.c

Hi!

I compiled your patch and am seeing the following warnings:

q_dualpi2.c: In function 'dualpi2_parse_opt':
q_dualpi2.c:218:37: warning: pointer targets in passing argument 1 of 
'get_u32' differ in signedness [-Wpointer-sign]
   218 |                         if (get_u32(&min_qlen_step, *argv, 10)) {
       |                                     ^~~~~~~~~~~~~~
       |                                     |
       |                                     int32_t * {aka int *}
In file included from q_dualpi2.c:39:
../include/utils.h:157:20: note: expected '__u32 *' {aka 'unsigned int 
*'} but argument is of type 'int32_t *' {aka 'int *'}
   157 | int get_u32(__u32 *val, const char *arg, int base);
       |             ~~~~~~~^~~
q_dualpi2.c: At top level:
q_dualpi2.c:516:27: warning: initialization of 'int (*)(const struct 
qdisc_util *, int,  char **, struct nlmsghdr *, const char *)' from 
incompatible pointer type 'int (*)(struct qdisc_util *, int,  char **, 
struct nlmsghdr *, const char *)' [-Wincompatible-pointer-types]
   516 |         .parse_qopt     = dualpi2_parse_opt,
       |                           ^~~~~~~~~~~~~~~~~
q_dualpi2.c:516:27: note: (near initialization for 
'dualpi2_qdisc_util.parse_qopt')
q_dualpi2.c:517:27: warning: initialization of 'int (*)(const struct 
qdisc_util *, FILE *, struct rtattr *)' from incompatible pointer type 
'int (*)(struct qdisc_util *, FILE *, struct rtattr *)' 
[-Wincompatible-pointer-types]
   517 |         .print_qopt     = dualpi2_print_opt,
       |                           ^~~~~~~~~~~~~~~~~
q_dualpi2.c:517:27: note: (near initialization for 
'dualpi2_qdisc_util.print_qopt')
q_dualpi2.c:518:27: warning: initialization of 'int (*)(const struct 
qdisc_util *, FILE *, struct rtattr *)' from incompatible pointer type 
'int (*)(struct qdisc_util *, FILE *, struct rtattr *)' 
[-Wincompatible-pointer-types]
   518 |         .print_xstats   = dualpi2_print_xstats,
       |                           ^~~~~~~~~~~~~~~~~~~~
q_dualpi2.c:518:27: note: (near initialization for 
'dualpi2_qdisc_util.print_xstats')

cheers,
Victor

