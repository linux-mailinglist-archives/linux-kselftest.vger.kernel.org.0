Return-Path: <linux-kselftest+bounces-40350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 262BBB3C6D7
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 02:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C6C1B26990
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 00:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301E21D59C;
	Sat, 30 Aug 2025 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWcFVISk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF62033A;
	Sat, 30 Aug 2025 00:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515360; cv=none; b=Xa8P8sYd1iBoltvWthEVya67VG6x8awxuy0Du5tIfL+57mpd+Q9WajSMaAju+p+pgXVLEA77uLX03HrnIqAYsb/u2nryVcMvJ5OdZVAJOH42WPCUPColEodrP5ljgKCrMjr20U+nXRcnLuoUCDasuZZzQtKVWunNHaSuRJdnob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515360; c=relaxed/simple;
	bh=4IIst6fsOMFqOY7ljlrPtObocW7F6+CnLwyE8yKoYOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syw5O56+ltUtrLmyrQqW3bPbLW0pUTLe4CUC8tqMTLhykembynRzE/YhlsK/dv0KqaM/gUq3qRlQIEB9/P9OdvFh+ZLX/5gSsnhAk7YgyDg1jDXG3T02a2pLnFPC3Z503n0Fx4xYmxRqrWdV58RTdiCBXBVEBHEnjZn8o18mBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWcFVISk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61ce4c32a36so3807128a12.3;
        Fri, 29 Aug 2025 17:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756515356; x=1757120156; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fmjVDdFrMx9ZSS1uNIb9RY2hqkvjiZO5mAN50cFP8A=;
        b=fWcFVISkDEqliWypGeoprg8ikamE5nVAjvSneh+DLAykFoZhtvnTyMtoiCH6HbVEU2
         c+ZQozvtn5N58NEA3o35J0VCRAk/rNUgBQ47zBPSbTw3q8ZtcmSdmEdO+d9oDXehliCc
         M2nAL2NbDI41d2SNJDTTd13bVYLgPSvk9J3bML9tpIzSZT4EfGprZJS+v25Q/f4MWQ2J
         SnfN3r3yEiMUhQcRaZ1KIQ6SNInk+r33wtCmllHvHuA0De00xgvmuKBV3CIb9BLb1RgC
         iwX6Ls/JwjeQ4TNKbwIbH+GQO9wHPHfjc2tpnTYlLp1sNW2WsPotyZTGdeflWHZsWhOu
         HIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756515356; x=1757120156;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fmjVDdFrMx9ZSS1uNIb9RY2hqkvjiZO5mAN50cFP8A=;
        b=jQRkfbTDZwGsVkGBV49P20Fw/fZiknQp/VJh0tsulW20gqZ90UKUAggWK3EW8bdXZy
         H8Yb4wVXNOos+zdJCRJSXcscavCB5eItczXgdonX0umvGvpoP/DUi8g5H1ERxZHHOdBs
         3CtFCuk9SROia4BROHYXSFIvkkj5AlrLbovBKoSVkpzI8w3+T7IhubDu/ZRR7fkoBb01
         BOTAVvUeSUw77c9YuDEbeiRCdz/7olBajuQVf4KYMYvBDQQOrWGKL1hpkydGCTN912uK
         NYf1fMTtjd6Yfb330hJsYeoHU5DCjoRTPR46bxjccdvvgWu/cJLtFeANHXu7b0ZNDrOu
         +P7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCF9Q9f1mP05qAT1qMBG8ZWPQZoXAl0wgcmCS/EF8b2akggi8+W8J6PIP7O+U0SWkl6fbCe/OS3qEb0xE=@vger.kernel.org, AJvYcCWnSsbJ5Qpnq2KYWvBdyFKPtF7JEHen7PzV1ZbCqsfDeHq7q9K1fUHCxTgC2J3qNVtaFr4gVdAFQM8G3QtFvbZN@vger.kernel.org, AJvYcCXe5wtMwB2hGTZ1Ci/+0fKpze6pPO23dnvyP7+OCbH1bpKK9ju48HX2Wzcg6HSm6COLXn8oA6mG5LTDEeEjsJpsNDRspLyC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4NSJNspWtzUA9tFt2AmiS4lGZ+AQaq8pM30qbd4yRtnIjZAi
	d4VF96ywfyW8+2x+lJByqnGgw0hBlG2ypBMEjipi+vFHNR9h44yQ+7mu
X-Gm-Gg: ASbGncu78sXW+rGjcvZEfbct/KiGVpsD6z0eOH+HA/l5AZqdvgCQe1Rrk3lhwpcOGEF
	BEv1eiSkrODH+xxM7zhvPspnISU2yfInc4AUCOveF72ff614x+Fbilx/vt2cphTshzjbsEsNNaM
	11vOeDxjQxJPDvT1Sq17Kab9Oe2xAt7i3SP7W/QOPzMwaoh6dUXP3AqypibIpv1syY/g7V6/tF4
	IyD0oL51MH0XuXvEeAX2XdhDN/DGMNZJHChArHU1cmShPyU2UOXC+hbe4meYO6DmnLdFgTxUYZC
	NDunxjTq0MM4ZPfSo1c8PDgXc8L0e3EfzaPMOdPUCv3mmd76TepyIdqKtVNTGyR3YXGeI/xhmcW
	51ZFG8VSnNkwymy5KUnuWOlfsAiQGWmi2oNcP
X-Google-Smtp-Source: AGHT+IE/li/Ts2UpBwuWVuVSIjcO4SAipUbYlLSRWpymiN4ghQfYMrr6M82K/BEJSs15LPmF9GkV2g==
X-Received: by 2002:a05:6402:5cb:b0:618:bc4:5777 with SMTP id 4fb4d7f45d1cf-61d2688bff2mr442032a12.9.1756515356279;
        Fri, 29 Aug 2025 17:55:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc214e2csm2654649a12.15.2025.08.29.17.55.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Aug 2025 17:55:55 -0700 (PDT)
Date: Sat, 30 Aug 2025 00:55:55 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: richard.weiyang@gmail.com, Liam.Howlett@oracle.com,
	akpm@linux-foundation.org, davem@davemloft.net, david@redhat.com,
	edumazet@google.com, gnoack@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, mic@digikod.net, ming.lei@redhat.com,
	pabeni@redhat.com, rppt@kernel.org, shuah@kernel.org,
	skhan@linuxfoundation.org, surenb@google.com, vbabka@suse.cz
Subject: Re: [PATCH 2/2] selftests: Replace relative includes with
 non-relative for kselftest.h and kselftest_harness.h
Message-ID: <20250830005555.ebx6sq2j22mm3plp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250829014358.qk3zme4qlaojun53@master>
 <20250829105306.6638-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829105306.6638-1-reddybalavignesh9979@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 29, 2025 at 04:23:06PM +0530, Bala-Vignesh-Reddy wrote:
>
>>+ifeq ($(KSFT_INCLUDES),)
>>+KSFT_INCLUDES := -I../
>>+endif
>>+
>
>This makes sense, but if we do it for mm/ then we have to
>follow this for all subdirectories in selftests.. that might
>cause problems if subdirectories are nested ones likes filesystems/.
>Duplicating this across all subdir Makefile adds churn and can
>lead to errors.
>
>Another way, is adding `CFLAGS += -I../` as is done in net/Makefile,
>but this also doesn't solve the problem completely as this also
>remain to relative addressing.
>
>But, if preferred we can add this snippet in Makefile to
>resolve the error temporarily.

Well, maybe I find a way.

Since we already get the top_srcdir in lib.mk, sounds we can add the include
path directly in lib.mk.

Some quick build looks good, not fully tested.

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 530390033929..1d3d0ad037d7 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -199,11 +199,18 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 # Build with _GNU_SOURCE by default
 CFLAGS += -D_GNU_SOURCE=
 
+CFLAGS += -I${top_srcdir}/tools/testing/selftests
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
 LDFLAGS += $(USERLDFLAGS)

>
>Thanks,
>Bala Vignesh

-- 
Wei Yang
Help you, Help me

