Return-Path: <linux-kselftest+bounces-26313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E011EA2FFC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DABC188234C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4487B3E1;
	Tue, 11 Feb 2025 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsUlUbvl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C2224F6;
	Tue, 11 Feb 2025 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739235374; cv=none; b=UvKFqY5OVwzucCicDLxTvJTwK3Y43ot/p8WKUbr+9DkLbYLiQlK9HTOEcldz87vI4545F9uxkEVRu/bmV9vV5UAvfVW9WrvfinntVnx8soseoTQZO1VLxu/8F3vGg1P6RYgQqB6YvUfsnRwUnO5WProU7MdMvrNqWxQ2ppriraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739235374; c=relaxed/simple;
	bh=e47iR8fyburMallAFhuLe1RTPvkqX9NNf1uJok+lahI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK0MBYFTuLrIx/Xw6zs6lC8faEXp7qIhyygXrI3GPgtHDZQ8Fk0+R6pkfNUtQxir7F9kaBnEBmh9gScwYUTMmcqiDJ0YLQ6PkgREwkaMkasW8c04wThp+RaOx/kVDmLmHgMllfOtLQUav0dtAgWQKco9an2/npFxYxk0AVzYc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsUlUbvl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de6c708315so3522629a12.0;
        Mon, 10 Feb 2025 16:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739235370; x=1739840170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6UL9cMSXRLrKUmcSWZ6ehr9HZGcrPjrQbiwbSxeTuc0=;
        b=LsUlUbvl3hpoPc5qYWbSr54rDWpm7Vk5LUlHSePtW/jwjMB4z+Az6IiWAtuwzf+59i
         2dVdEO/az7Ewd2xG0SO1ph+tl8PziUzra8q0JRZVu+mAprWGbhTLfsDYDaDsOkBUrvel
         LZ9VI+J2A7a6+ogmv9651sv55ynnIxNkQUgEiPqqw7Sf92ChS43U75DDw92gu41MUp5d
         Xm+GmPNogal/sk4HBD1wiw9sc88SHHz8Z5UDL15SSGxBIvCwx8tr6w1N9jceOmisLYxg
         uFA4F4cofE7LwGSo9J2bfe/FOGlIabvYV7ydZe6lEYbQZYyORfPqFBlfBNGPXlWbEObj
         qeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739235370; x=1739840170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UL9cMSXRLrKUmcSWZ6ehr9HZGcrPjrQbiwbSxeTuc0=;
        b=fnRstHXUi8mS1TdGv7u1SlloLwJTem+5fVeqGkIY390EN/NbwnKx8+MC1VW3HuFIEF
         nG5oPEJh8++QrzXO/wJgBeI7eERukM9nL7cgYF1iUc+pD+XCrpQY4sqHgFbqo1P/BRUd
         ASf+jOtHAitaCkLHJVoivuwrTG4Sn80IDIolkJYPnsSVPzmD52Mcs/77YvT82GS5r35K
         QlQH1KeMzIPUEkleKjF6Jbo7k3i++XmSIhYsWft07qrfKpj5QmnDGqBDdNwejTflqNqD
         NJB8mRiToQZeD2Kz4SyPWfjP/mGd8JMwRd3Slb4+F7SLQ38ErT+z5aSJAdi9OmSFmgBJ
         /fZg==
X-Forwarded-Encrypted: i=1; AJvYcCWLWR4ihjTSGaNEn/M+dmzWpgtxXVwHvUQF3k3pClTvFrQBHyaChkB6K7NICmRcPWJDLeZ/UvzDQLH8QY8=@vger.kernel.org, AJvYcCWeK6pgZ/1AuMU9PkB79dsd0PM2Ep30d/mPpmspTaR0luXa85By3CwZReFHny6512rwgf3HDidZS7N/3Wu8Nww0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfb9w7AtZ7SF3pGYiJfa6NVRm5nBiGWAm0r5jO5z9tOUh5TQWF
	+dETAGU2506w4+FcTOIfaPtWmXMhat4DEmV2po1RerIha2pLCl4E
X-Gm-Gg: ASbGncuqTQbvdssQ/TjEmut/0bKLNIjgHeqSmGka3TOAVT0Y+LJ4hqJ36eJtzJIkNSs
	KpW0hGzkpiLa29mmHqgPTinJvHZxD6DE+obhdl2BjDRfNvBADGbw1OOZ9mzT8NzNVlyRbY9kA22
	ildX/BdGiQ1kDAbmXIKJKLGSC1Aneyf0vVBjReT+vqfYe8+8uSKwnEbIYsWx1X/f6JzXb0aEBM+
	HRv8VJQEEcNCEUw50Z9aosnEBpD9ZV+2mY2DMFhrIrbpiBgio11CJCswyRrKWGGmnCndsX6cl/d
	1Jyg
X-Google-Smtp-Source: AGHT+IFmOULmOXGP28PqCUALPKYMf0/xNA7A869rzJwx0VnrPUsVgBbo5gi6VDEbrDyHmyNFNjEpgQ==
X-Received: by 2002:a05:6402:4305:b0:5de:39fd:b303 with SMTP id 4fb4d7f45d1cf-5de44feab07mr15546115a12.2.1739235370140;
        Mon, 10 Feb 2025 16:56:10 -0800 (PST)
Received: from localhost ([95.85.21.13])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de379cedc6sm8183032a12.44.2025.02.10.16.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:56:08 -0800 (PST)
Date: Tue, 11 Feb 2025 02:56:06 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, shuah@kernel.org, 
	skhan@linuxfoundation.org
Cc: linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] selftests: tpm2: test_smoke: use POSIX-conformant
 expression operator
Message-ID: <gmqimicpacyyg6mkxrk4etmi74gp6zqivlrgbu263lfgpw7qvg@wwzrscxvidvm>
References: <D7OY3ZVGJOV5.R3SL9SBFT2DF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7OY3ZVGJOV5.R3SL9SBFT2DF@kernel.org>

Use POSIX-conformant operator symbol '=='.

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
---

Changes in v2:
 - Remove snippets pinpointing the issue 
   from commit message

 tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 168f4b166234..3a60e6c6f5c9 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -6,6 +6,6 @@ ksft_skip=4
 
 [ -e /dev/tpm0 ] || exit $ksft_skip
 read tpm_version < /sys/class/tpm/tpm0/tpm_version_major
-[ "$tpm_version" == 2 ] || exit $ksft_skip
+[ "$tpm_version" = 2 ] || exit $ksft_skip
 
 python3 -m unittest -v tpm2_tests.SmokeTest 2>&1
-- 
2.47.2


