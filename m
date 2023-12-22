Return-Path: <linux-kselftest+bounces-2376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FF781CC9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C8F1C22076
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC91241FA;
	Fri, 22 Dec 2023 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U7qpNPHr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8C241EA
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7b8529ce303so26434839f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703261744; x=1703866544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4EEYQg1fCmOE/nNMuzEIv4gHmrbN9kJTQkKQ+vCwE4=;
        b=U7qpNPHrBCxQlycsEf0NRKO4dD86CJnPcTNHxPjSlAn27HEnZDpMgOBDVFlW1aWy7T
         zK9YRphze0lrzPVdl3xhVDwtPYI8YQG9nTN302AGXvftjv9OA7SKAQGQtQhmFea2klFb
         TFxkrwOU6f5lPZS5J6xwljNWihM0zA5Z3UjAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703261744; x=1703866544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4EEYQg1fCmOE/nNMuzEIv4gHmrbN9kJTQkKQ+vCwE4=;
        b=AM1vol3w9yuExBWR1EdOd3ICiRkok0jW/0AUpLGSRlNbPpLeLgrdeWv79T2aeAQ1KD
         FCaHyGCbXExsvqi1r1sCh9LFaUXAnyfWRSF0Sdcf0aXSAXaKZIF2+Fgc/DcU0tKgwjn/
         X6rydTHAqGmD7KBf1uedVJLXZ8nwKZld/c0TDeSxCIib021YcGbStdxiE+cew6YZOXbC
         3HqKiZoqm6EzZ24ynPpjJSj1KAujbOfrQC2W6ymjUIAUTsGotd6bszi7UjLOv3HlSLgK
         XarHuc+OPpc0Hwx9ZC+EhE4jLOnN8rxSWcq6vKjBqW6BTsxK7NFpCpwJ9iGcfZ2NGoAh
         Hhkg==
X-Gm-Message-State: AOJu0YzxUYX7KjITUcuFWg3j7CdWxYrCkr59VT0+oGOhCRps589HYdhp
	EzjNoLceZBgJuHvf983DBd/7q2/IXj7VkQ==
X-Google-Smtp-Source: AGHT+IEg8caEjhtyaZDj6Py/3AT3BADKX4XNkFGUFK+l79PCzzV+EBMzkXe2dMEWXs/o6QQFMcAWsg==
X-Received: by 2002:a6b:db08:0:b0:7b9:c347:197 with SMTP id t8-20020a6bdb08000000b007b9c3470197mr3137610ioc.2.1703261744239;
        Fri, 22 Dec 2023 08:15:44 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g12-20020a02b70c000000b0046658ae37adsm1089869jam.9.2023.12.22.08.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 08:15:43 -0800 (PST)
Message-ID: <935441c3-f14b-4a5d-8031-3b406548a612@linuxfoundation.org>
Date: Fri, 22 Dec 2023 09:15:42 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing/selftests: Add ownership modification tests
 for eventfs
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux selftests <linux-kselftest@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231221211229.13398ef3@gandalf.local.home>
 <20231221211604.5062f4e8@gandalf.local.home>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231221211604.5062f4e8@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 19:16, Steven Rostedt wrote:
> 
> Shuah,
> 
> This patch has no dependencies. You can take it through your tree for the
> next merge window if you want. If not, I can take it.
> 
Tried to apply this and seeing a couple of issues:

-- missing SPDX
-- this file has executable permission set unlike the existing
    .tc files in the same directory

ERROR: do not set execute permissions for source files
#72: FILE: tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#72:
new file mode 100755

WARNING: Missing or malformed SPDX-License-Identifier tag in line 2
#78: FILE: tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc:2:
+# description: Test file and directory owership changes for eventfs

total: 1 errors, 2 warnings, 113 lines checked

thanks,
-- Shuah


