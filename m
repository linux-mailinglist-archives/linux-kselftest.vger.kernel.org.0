Return-Path: <linux-kselftest+bounces-31158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD311A93BD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECE9188D091
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E1821481E;
	Fri, 18 Apr 2025 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="fTgd9o6T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989AD217734;
	Fri, 18 Apr 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996645; cv=pass; b=bAs9mCJTUOYrPFWqiCTGBoEKjADnV51Tt38yLvECwvJGZoP5RJ/KYmzYwIdlN+oJxslFCFuM98Az3pzgeE+29P6x4GVsRq/bb4TFNBITU/e/DWhVHwg4B/tMEcSGa+XRBEVhJstZhhLKgp2Ry4cTKIETplowOesbwwpnpwwLHKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996645; c=relaxed/simple;
	bh=HWgRPEwVKkFmhhWiBm636+TJP5nBR6E34XlvIZtv6P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QI29kC/t4FusBUveKnxYxJ6T0x6Jyx9upGJlvyNBBVzUqFtfJ5jSfWBq5Xtv5p92GqULvW3MT6foTlqV0XATRckq1tC6IZWJKJQ2LB0c/J2zkV7hKiyKymZ3NpeIlH+ly8oN4WKc+5b5y0KU6v6s179DjK4XjdlLj1dRcv3Dncw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=fTgd9o6T; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744996609; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jxWkA9U9NSgJbmAJUXRHn0QNZ4IAW9AQoexfk/8Dhec7cY2AbkjMrmhOTK6evP9mbB3cXu2p4yoFygKVuBmubKQKYMb8F/qhOomsIOkMbEkunmsF0+CQdTVhnU5qxvR5ThAr/WLZ1ERTgBDYixv2Ax+2KftBlNBM7cXDVao5iTA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744996609; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J44kw+gzo5uLXPwGBO4pqJKAwwerl0rrlLnx0kM7WsI=; 
	b=Gf/c0WxKvpJtNDtYxf8wQEcUUqr0iaKCvPIoGjGKAB1G4P1LlDyoTNt7zg1cnAXm4B75gsCDL8go7T7pOqWL1C/tJHRlt6iYd3YKkfnE3hIbV+ZkMK9Lmt73bYSrUpmB4GU7EoUkcZvPpyjWwCnZ/SbKuurp6CZZhrPxJnkYz6g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744996609;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=J44kw+gzo5uLXPwGBO4pqJKAwwerl0rrlLnx0kM7WsI=;
	b=fTgd9o6TJ+HrN8kHIcyp7p8HWq2OGZAut8+9bw/SLk+wXodfeJH9aUNfImvqukp9
	xWW0cOlJ7O+bjjHIrMIY659F+070RBTKsjjrwVG/uXkOFzWDkQDQW0raxSCtqeePze/
	QoKXh8nh8XbxWczBkx+pI28bPv+9yWUUIfRGnHxY=
Received: by mx.zohomail.com with SMTPS id 1744996608012662.4463860725073;
	Fri, 18 Apr 2025 10:16:48 -0700 (PDT)
Message-ID: <447d6f10-a04b-4492-8cc0-cac317f7c6c7@collabora.com>
Date: Fri, 18 Apr 2025 22:16:42 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/32] selftests: harness: Remove dependency on
 libatomic
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250411-nolibc-kselftest-harness-v3-6-4d9c0295893f@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-6-4d9c0295893f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/11/25 2:00 PM, Thomas Weißschuh wrote:
> __sync_bool_compare_and_swap() is deprecated and requires libatomic on
> GCC. Compiler toolchains don't necessarily have libatomic available, so
> avoid this requirement by using atomics that don't need libatomic.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kselftest_harness.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 222a4f51a8d704c41597e09a241ad887ef787139..7ec4f66d0e3d7f129f6c2a45ff58310dabe5d03f 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -439,12 +439,12 @@
>  		} \
>  		if (child == 0) { \
>  			if (_metadata->setup_completed && !fixture_name##_teardown_parent && \
> -					__sync_bool_compare_and_swap(teardown, false, true)) \
> +					!__atomic_test_and_set(teardown, __ATOMIC_RELAXED)) \
>  				fixture_name##_teardown(_metadata, self, variant->data); \
>  			_exit(0); \
>  		} \
>  		if (_metadata->setup_completed && fixture_name##_teardown_parent && \
> -				__sync_bool_compare_and_swap(teardown, false, true)) \
> +				!__atomic_test_and_set(teardown, __ATOMIC_RELAXED)) \
>  			fixture_name##_teardown(_metadata, self, variant->data); \
>  		munmap(teardown, sizeof(*teardown)); \
>  		if (self && fixture_name##_teardown_parent) \
> 


-- 
Regards,
Usama

