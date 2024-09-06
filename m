Return-Path: <linux-kselftest+bounces-17426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC6A96FCE2
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 22:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EB42887D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508BF1D5CDB;
	Fri,  6 Sep 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H13Dnp0B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5D1D86D2
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725655595; cv=none; b=lZmQ17ZcJ5dyr7EjHYeCqk134cg7K/7hHWs3iLDteGqa8RS1Hm9QuLyo8XwXb1mamawHbFVJtUKONaRx3qVPbJUp6ida9H/6+lh1y+CezYXZT8fElUPeO4PR+wb65P9W3nxFVVAv4PAkLQNPaJG42tGZDj2U2pqzW93oEpdxkoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725655595; c=relaxed/simple;
	bh=+59T3YjsKgQollmAhoat7wU8VUkb4cTxcOz6DX/CSjE=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=ZU1eopjas7lsN0IoB8PkWofzl1gMTKIQraQZthNHwi546bBtpS0nXz/gT4TlBLT1OQic1EMnr/GWv3tYdRDdUCpz17b4LOBUbEbGyn47UwQ8Rch7gQWbAME+j7/ucfCoQOgEnOG7+uy1SuyNTyruEQOKccBtHbm0SOoiriVUhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H13Dnp0B; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2053f6b8201so22745935ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725655593; x=1726260393; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bdh2IYAhAWWL1ftwGcIYABEvHITFdtqLXlXBLwSHgBQ=;
        b=H13Dnp0B5tLztfGp+jss2OFdSfmpsycKCdUcAjjersFc843FpU0DcxIrQFro5Lfz+H
         x4Na+NbqJSNSqvb9Q70HQJK+DDges1kI9kV4H3yPuCvrgs3Z60wrW52aD7lLz9q/rH0d
         SnjHvkFOsaYGmn5dAzxftSmRYhnh/tzsbNwrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725655593; x=1726260393;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdh2IYAhAWWL1ftwGcIYABEvHITFdtqLXlXBLwSHgBQ=;
        b=BSZUUKT3eF1lehxkK7VX1zpRIoq2DT/ZYDLwlH+KfOgICeiUHftDTcHYzAHw4lvvOZ
         CieElHuvgAGoC7MH0mPwfi1okiwHDrj3s5+QJbFs+MbAxkwL07j0Dh6lT3v+Rhu/b23F
         rm23U/xsIpqS7hfvMMgCtOAcBMnEGtyGORJ1kZporn6vyo5CKTngc8v82m4Z3/J4J+JD
         IO3+LSEiPWuJSgUzSy/NcmmQ8yoEEFxP3T+PDQygGPYdbrQTe75NsMMk7kgWxFak5Y9J
         LLNh3tA4B3C+HskVSzjGaF5zC7liOwcjxytwFPRopYuYuFJONnFHZyIdebEKkfAWZPYA
         LX9g==
X-Forwarded-Encrypted: i=1; AJvYcCXBdqC93dhB54HFj1I0XhmdxFiXqVLI0pxokNwHYlRgFl45E7Y3eTToAv8/Jh8wxifmdUPnux023Ze/KGvsor4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nEvkPAweL8ig4K7NbQXseUUE31kftgJ4vHqWpj6o4a5K3IZ3
	zisrVWkQrWw0hOOUNXq0A184KcZpTlgpwKA2/xk6x1n7kcGncJgXSO33H4xau6w=
X-Google-Smtp-Source: AGHT+IF5288ygKhQcmDX7CfE48EpDs24C+dRatUUiz0mYsnyE9XO4eIPbro6c17Q6DEhKF5uxMLO3A==
X-Received: by 2002:a17:902:e806:b0:207:6d2:45ef with SMTP id d9443c01a7336-20706d24737mr16548675ad.37.1725655592369;
        Fri, 06 Sep 2024 13:46:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae951617sm47142625ad.83.2024.09.06.13.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 13:46:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------sEskxmypW7sDg6opuovWfsh8"
Message-ID: <27a3fc9b-436d-43f2-a8ff-b2d68922009b@linuxfoundation.org>
Date: Fri, 6 Sep 2024 14:46:31 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes second update for Linux 6.11-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 David Gow <davidgow@google.com>, Brendan Higgins
 <brendanhiggins@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------sEskxmypW7sDg6opuovWfsh8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes second update for Linux 6.11-rc7.

This KUnit fixes update for Linux 6.11-rc7 consists of a fix to
missing function parameter warning found during documentation
build in linux-next.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit f2c6dbd220170c2396fb019ead67fbada1e23ebd:

   kunit: Device wrappers should also manage driver name (2024-08-26 07:03:46 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.11-rc7-2

for you to fetch changes up to 12cb32a52eb607dc4d0e45fe6f4cf946d08da0fd:

   kunit: Fix missing kerneldoc comment (2024-09-05 14:29:10 -0600)

----------------------------------------------------------------
linux_kselftest-kunit-fixes-6.11-rc7-2

This KUnit fixes update for Linux 6.11-rc7 consists of a fix to
missing function parameter warning found during documentation
build in linux-next.

----------------------------------------------------------------
David Gow (1):
       kunit: Fix missing kerneldoc comment

  include/kunit/test.h | 1 +
  1 file changed, 1 insertion(+)
----------------------------------------------------------------
--------------sEskxmypW7sDg6opuovWfsh8
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-fixes-6.11-rc7-2.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-fixes-6.11-rc7-2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUva3VuaXQvdGVzdC5oIGIvaW5jbHVkZS9rdW5pdC90ZXN0
LmgKaW5kZXggNWFjMjM3Yzk0OWEwLi4zNGI3MWU0MmZiMTAgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUva3VuaXQvdGVzdC5oCisrKyBiL2luY2x1ZGUva3VuaXQvdGVzdC5oCkBAIC00ODQsNiAr
NDg0LDcgQEAgc3RhdGljIGlubGluZSB2b2lkICprdW5pdF9rY2FsbG9jKHN0cnVjdCBrdW5p
dCAqdGVzdCwgc2l6ZV90IG4sIHNpemVfdCBzaXplLCBnZnAKIAogLyoqCiAgKiBrdW5pdF9r
ZnJlZV9jb25zdCgpIC0gY29uZGl0aW9uYWxseSBmcmVlIHRlc3QgbWFuYWdlZCBtZW1vcnkK
KyAqIEB0ZXN0OiBUaGUgdGVzdCBjb250ZXh0IG9iamVjdC4KICAqIEB4OiBwb2ludGVyIHRv
IHRoZSBtZW1vcnkKICAqCiAgKiBDYWxscyBrdW5pdF9rZnJlZSgpIG9ubHkgaWYgQHggaXMg
bm90IGluIC5yb2RhdGEgc2VjdGlvbi4K

--------------sEskxmypW7sDg6opuovWfsh8--

