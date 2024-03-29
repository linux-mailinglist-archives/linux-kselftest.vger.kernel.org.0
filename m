Return-Path: <linux-kselftest+bounces-6893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A258892460
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6A4284DA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C81EA8F;
	Fri, 29 Mar 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQ1lLi+3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98722139566
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741180; cv=none; b=u07C7WT/te80h7OIZmvh4Su/eyYOFUKIYbSjnCVNfkgktEoR3VIUk53Prteo5ppvhSWmzNB7zLe9Oqm6bzPhkNkWqmGyE/j5QtHzCTJSmIINUNFY2gPdDibmAzGBHWTSGh9TqF0VWNn/eeWT1L2SwDONZn7aTKvxXGCTHmwfBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741180; c=relaxed/simple;
	bh=XRwGuMCMDAiT/kGV1gveWR6DiWQyYt8NU9kqKbtVHek=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=Op/gibBWU7ByYdvHROV08rNnoHf7zspAadc+LSrbkAXtcUalNuq+8W4BKVSMJUBL5VulwmXjQJa2V8eoId4L7PLy0iqyILTQGA3EslMjN4NybA5DBfBCVRyg/c3Z84EsTf83v+J6IdEHqVsoJKep5polxSXATGWTSgzY+nilB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQ1lLi+3; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso20040239f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711741178; x=1712345978; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wGRUcWXsBInBmMfpGS0QfGv2r7xwIpgvwzLKcdpnYq0=;
        b=AQ1lLi+3B5VDyLGpJQ55qvCo3mDxb9zPqFA48ElRMuzRv3otKVyJgcX8DuSkER6Onw
         tL/NuzQKb+EgEkiW+BjV11V1EUt1rhQamVgoYCGNOWKDej/wj/Q7K/G/Fr+72slrwkOP
         miKgv66J6YQGr2z3CSiP+B3WJdCF5hGgcrWdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741178; x=1712345978;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGRUcWXsBInBmMfpGS0QfGv2r7xwIpgvwzLKcdpnYq0=;
        b=hxrSj6nTjfZrcZqhP9twTSp0CsusY6iRfehrjseZ2DZBjCyEE15eRs69h2r9Qu8ar7
         j2UwnNciqwc+MIN5GzsBz5mcB4HMKJDLYXRsoMXMp/Tmc3uP/KmWU9LEP/efTa09AsPK
         tdjfcVkQ7zuBsEhy9qJU/GqXfPFGmn4J5V/Uce4ygqHn7y9Lt/LQtpRjJgl5hjONG6OU
         hX5+R9PlsOz+uSQRxNvfrxi1YaQPkf+P6ZpuW/JmpHILJ0MKCtwFbJhx9YOZzwmps5xv
         utWkzNK/mAYBdiSMoEcPSR2AkaIYa/zF6wh/pW4cIeaaQvsZvVCfIDVYsvFl8bOjMSOn
         zXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvejW4h27bt276ZQezVr+7tcOq/2Kd+2oCKjWRXWDhhkzpMYQa5JaYAJAo3qIvaGbQsQsSjYs2F93hqmbH8L69xpc4FwNb4FMUJCgYCljG
X-Gm-Message-State: AOJu0YyfLJgkBoq7ajq98HMzcdLFOf6tSCCQia93wcL+Wck6NmXbVXbr
	pFB4vZV76TskbUTBUEQShY8/fKXkRbSg76bSHRFp8SSXticdceX+EUaump+Took=
X-Google-Smtp-Source: AGHT+IEF0hNNkf3bwSM19CEdUd7pYB9hRExVR1pNOhJaI0ULQvnYGKc0SJVoNnYjG75PRMc770knmg==
X-Received: by 2002:a92:c002:0:b0:368:efa4:be11 with SMTP id q2-20020a92c002000000b00368efa4be11mr1564250ild.2.1711741177641;
        Fri, 29 Mar 2024 12:39:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id n18-20020a92dd12000000b003687fe513f2sm1252463ilm.2.2024.03.29.12.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:39:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Vr1acWcKHWqaHYvzGvXWoWNj"
Message-ID: <0dea1005-3cd4-410e-aa3e-272712cca7b5@linuxfoundation.org>
Date: Fri, 29 Mar 2024 13:39:36 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.9-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 David Gow <davidgow@google.com>, Brendan Higgins
 <brendanhiggins@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, "kuba@kernel.org" <kuba@kernel.org>,
 Mark Brown <broonie@kernel.org>, Johannes Berg <johannes@sipsolutions.net>

This is a multi-part message in MIME format.
--------------Vr1acWcKHWqaHYvzGvXWoWNj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kunit fixes update for Linux 6.9rc2.

This kunit update for Linux 6.9-rc2 consists of one urgent fix for
--alltests build failure related to renaming of CONFIG_DAMON_DBGFS
to DAMON_DBGFS_DEPRECATED to the missing config option.

This is one of the two fixes to --alltests breakage. The other
one is in the following PR from net:
  
https://lore.kernel.org/netdev/20240328143117.26574-1-pabeni@redhat.com

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.9-rc2

for you to fetch changes up to cfedfb24c9ddee2bf1641545f6e9b6a02b924aee:

   kunit: configs: Enable CONFIG_DAMON_DBGFS_DEPRECATED for --alltests (2024-03-28 11:47:30 -0600)

----------------------------------------------------------------
linux_kselftest-kunit-fixes-6.9-rc2

This kunit update for Linux 6.9-rc2 consists of one urgent fix for
--alltests build failure related to renaming of CONFIG_DAMON_DBGFS
to DAMON_DBGFS_DEPRECATED to the missing config option.

----------------------------------------------------------------
David Gow (1):
       kunit: configs: Enable CONFIG_DAMON_DBGFS_DEPRECATED for --alltests

  tools/testing/kunit/configs/all_tests.config | 1 +
  1 file changed, 1 insertion(+)
----------------------------------------------------------------
--------------Vr1acWcKHWqaHYvzGvXWoWNj
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-fixes-6.9-rc2.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-fixes-6.9-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcva3VuaXQvY29uZmlncy9hbGxfdGVzdHMuY29u
ZmlnIGIvdG9vbHMvdGVzdGluZy9rdW5pdC9jb25maWdzL2FsbF90ZXN0cy5jb25maWcKaW5k
ZXggYWE1ZWMxNDlmOTZjLi5mMzg4NzQyY2YyNjYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rp
bmcva3VuaXQvY29uZmlncy9hbGxfdGVzdHMuY29uZmlnCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
a3VuaXQvY29uZmlncy9hbGxfdGVzdHMuY29uZmlnCkBAIC0zOCw2ICszOCw3IEBAIENPTkZJ
R19EQU1PTl9WQUREUj15CiBDT05GSUdfREFNT05fUEFERFI9eQogQ09ORklHX0RFQlVHX0ZT
PXkKIENPTkZJR19EQU1PTl9EQkdGUz15CitDT05GSUdfREFNT05fREJHRlNfREVQUkVDQVRF
RD15CiAKIENPTkZJR19SRUdNQVBfQlVJTEQ9eQogCg==

--------------Vr1acWcKHWqaHYvzGvXWoWNj--

